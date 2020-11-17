<?php
session_start();

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, clientID, clientSecret");
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header('Content-Type: application/json');

$array = array();

if (json_decode(file_get_contents('php://input'), true)) {
    $postData = array_change_key_case(json_decode(file_get_contents('php://input'), true), CASE_LOWER);
}
if ($_POST) {
    $postData = array_change_key_case($_POST, CASE_LOWER);
}
 
// VALIDATE TOKENS
$clientID = $_SERVER["HTTP_CLIENTID"];
if (!ctype_alnum($clientID) || strlen($clientID) != 32) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid client id', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
$clientSecret = $_SERVER["HTTP_CLIENTSECRET"];
if (!ctype_alnum($clientSecret) || strlen($clientSecret) != 32) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid client secret', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}

// VALIDATE REQUIRED POSTFIELDS
if ($postData["username"] == "" && $postData["discordid"] == "") {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'required postdata missing: username or discordid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
if ($postData["username"] != "" && !ctype_alnum($postData["username"])) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid postdata: username', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
if ($postData["discordid"] != "" && (!ctype_alnum($postData["discordid"]) || strlen($postData["discordid"]) < 17)) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid postdata: discordid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}

include_once("../../../includes/app.php");

// VERIFY CLIENT ID AND CLIENT SECRET
$query = $pdo->prepare("select id, user_id, timestamp_last_called, tokens, tokens_per_minute, total_requests_made from APIProjects where client_id = :clientID and client_secret = :clientSecret and deleted = 0");
$query->execute(array('clientID' => $clientID, 'clientSecret' => $clientSecret));
if ($query->rowCount() == 0 || $query->rowCount() > 1) {
    header("HTTP/1.1 401 Unauthorized", true, 401);
    $array["response"] = array('status' => 401, 'message' => 'unauthorized access', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    $query = null;
    $pdo = null;
    die();
} else {
    foreach ($query as $row) {
        $apiUserID = $row["user_id"];
        $lastCalled = $row["timestamp_last_called"];
        $tokens = $row["tokens"];
        $tokensPerMinute = $row["tokens_per_minute"];
        $totalRequestsMade = $row["total_requests_made"];
    }
    if (floor(time() / 60) > floor($lastCalled / 60)) { $tokens = $tokensPerMinute; }
    if ($tokens == 0) {
        header("HTTP/1.1 429 Too Many Requests", true, 429);
        $retryAfter = 60 - (time() % 60);
        header("Retry-After: ".$retryAfter);
        $array["response"] = array('status' => 429, 'message' => 'too many requests', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        die();
    }    
    $tokens = $tokens - 1;
    $totalRequestsMade = $totalRequestsMade + 1;
}

// UPDATE RATE LIMIT TOKEN COUNTS
$query = $pdo->prepare("update APIProjects set timestamp_last_called = :timestampLastCalled, tokens = :tokens, total_requests_made = :totalRequestsMade where client_id = :clientID and client_secret = :clientSecret");
$query->execute(array('clientID' => $clientID, 'clientSecret' => $clientSecret, 'timestampLastCalled' => time(), 'tokens' => $tokens, 'totalRequestsMade' => $totalRequestsMade));

// RUN QUERY
$query = $pdo->prepare("select * from UserIDs_V2 where ((username = :username and :username <> '') or (discord_id = :discordID and :discordID <> '')) and deleted = 0");
$query->execute(array('username' => $postData['username'], 'discordID' => $postData['discordid']));
if ($query->rowCount() == 0 || $query->rowCount() > 1) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    if ($postData['username'] != "") {
        $array["response"] = array('status' => 400, 'message' => 'invalid postdata: username', 'timestampGenerated' => time());
    }
    if ($postData['discordid'] != "") {
        $array["response"] = array('status' => 400, 'message' => 'invalid postdata: discordid', 'timestampGenerated' => time());
    }
    echo json_encode($array, JSON_PRETTY_PRINT);
    $query = null;
    $pdo = null;
    die();
} else {
    foreach ($query as $row) {
        header("HTTP/1.1 200 OK", true, 200);
        $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
        $userNo = $row["id"];
        $userID = $row["user_id"];
        $mainRole = "Unknown";
        if ($row["main_role"] == 1) { $mainRole = "Keyholder"; }
        if ($row["main_role"] == 2) { $mainRole = "Lockee"; }
        
        if ($row["status"] == 0 || $row["status"] == 1) {
            if (time() - $row["timestamp_last_active"] <= 900) {
                $status = "Available";
            } else {
                $status = "Offline";
            }
        }
        if ($row["status"] == 2) { $status = "Busy"; }
        if ($row["status"] == 3) { $status = "Sleeping"; }

        $noOfSharedLocks = 0;
        $noOfSharedLocksFixed = 0;
        $noOfSharedLocksVariable = 0;
        $query2 = $pdo->prepare("select
            coalesce(count(*), 0) as noOfSharedLocks,
            sum(case when s.fixed = 1 then 1 else 0 end) as noOfSharedLocksFixed,
            sum(case when s.fixed = 0 then 1 else 0 end) as noOfSharedLocksVariable
        from ShareableLocks_V2 as s
        where s.user_id = :userID and 
            s.hide_from_owner = 0");
        $query2->execute(array('userID' => $userID));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $noOfSharedLocks = $row2["noOfSharedLocks"];
                $noOfSharedLocksFixed = $row2["noOfSharedLocksFixed"];
                $noOfSharedLocksVariable = $row2["noOfSharedLocksVariable"];
            }
        }
        
        $noOfLocksFlaggedAsTrusted = 0;
        $noOfLocksManagingNow = 0;
        $noOfLocksManagingNowFixed = 0;
        $noOfLocksManagingNowVariable = 0;
        $query2 = $pdo->prepare("select
            coalesce(sum(l.trust_keyholder), 0) as noOfLocksFlaggedAsTrusted,
            coalesce(count(*), 0) as noOfLocksManagingNow,
            sum(case when l.fixed = 1 then 1 else 0 end) as noOfLocksManagingNowFixed,
            sum(case when l.fixed = 0 then 1 else 0 end) as noOfLocksManagingNowVariable
        from ShareableLocks_V2 as s, Locks_V2 as l
        where s.user_id = :userID and 
            l.shared_id = s.share_id and 
            s.hide_from_owner = 0 and 
            l.deleted = 0 and 
            l.fake = 0 and 
            l.test = 0 and 
            l.timestamp_locked > 1451606400 and 
            l.unlocked = 0");
        $query2->execute(array('userID' => $userID));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $noOfLocksFlaggedAsTrusted = $row2["noOfLocksFlaggedAsTrusted"];
                $noOfLocksManagingNow = $row2["noOfLocksManagingNow"];
                $noOfLocksManagingNowFixed = $row2["noOfLocksManagingNowFixed"];
                $noOfLocksManagingNowVariable = $row2["noOfLocksManagingNowVariable"];
            }
        }
    
        $dateFirstKeyheld = 0;
        $timestampFirstKeyheld = 0;
        $totalLocksManaged = 0;
        $query2 = $pdo->prepare("select
            min(l.timestamp_locked) as timestampFirstKeyheld,
            coalesce(count(*), 0) as totalLocksManaged
        from ShareableLocks_V2 as s, Locks_V2 as l
        where s.user_id = :userID and 
            l.shared_id = s.share_id and 
            l.fake = 0 and 
            l.test = 0 and 
            l.timestamp_locked > 1451606400
        order by l.timestamp_locked asc");
        $query2->execute(array('userID' => $userID));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $dateFirstKeyheld = date("d/m/Y", $row2["timestampFirstKeyheld"]);
                $timestampFirstKeyheld = $row2["timestampFirstKeyheld"];
                $totalLocksManaged = $row2["totalLocksManaged"];
            }
        }
        
        $averageRating = 0;
        $noOfRatings = 0;
        $query2 = $pdo->prepare("select
            coalesce(cast(avg(l.rating) as decimal(3,2)), 0) as averageRating,
            coalesce(count(*), 0) as noOfRatings
        from ShareableLocks_V2 as s, Locks_V2 as l
        where s.user_id = :userID and 
            l.shared_id = s.share_id and 
            l.rating > 0 and 
            l.test = 0 and 
            l.timestamp_locked > 1451606400
        order by l.timestamp_locked asc");
        $query2->execute(array('userID' => $userID));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $averageRating = $row2["averageRating"];
                $noOfRatings = $row2["noOfRatings"];
                if ($noOfRatings < 5) { $averageRating = 0; }
            }
        }
    
        if ($totalLocksManaged >= 1500 && time() - $timestampFirstKeyheld >= 15552000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 5; }
        elseif ($totalLocksManaged >= 500 && time() - $timestampFirstKeyheld >= 10368000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 4; }
        elseif ($totalLocksManaged >= 100 && time() - $timestampFirstKeyheld >= 5184000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 3; }
        elseif ($totalLocksManaged >= 10 && time() - $timestampFirstKeyheld) { $keyholderLevel = 2; }
        else { $keyholderLevel = 1; }
        
        $query2 = $pdo->prepare("select id from Relations where 
            user_two_id = :userTwoID and 
            status = 1");
        $query2->execute(array('userTwoID' => $userNo));
        $followersCount = $query2->rowCount();
        
        $query2 = $pdo->prepare("select id from Relations where 
            user_one_id = :userOneID and 
            status = 1");
        $query2->execute(array('userOneID' => $userNo));
        $followingCount = $query2->rowCount();
        
        if ($row["display_in_stats"] == 1 || $apiUserID == $userID) {
            $data = array(
                'userID' => (int)$row["id"],
                'username' => $row["username"],
                'discordID' => $row["discord_id"],
                'displayInStats' => (int)$row["display_in_stats"],
                'averageRating' => (double)$averageRating,
                'buildNumberInstalled' => (int)$row["build_number_installed"],
                'dateFirstKeyheld' => $dateFirstKeyheld,
                'followersCount' => (int)$followersCount,
                'followingCount' => (int)$followingCount,
                'joined' => $row["created"],
                'keyholderLevel' => (int)$keyholderLevel,
                'mainRole' => $mainRole,
                'noOfLocksFlaggedAsTrusted' => (int)$noOfLocksFlaggedAsTrusted,
                'noOfLocksManagingNow' => (int)$noOfLocksManagingNow,
                'noOfLocksManagingNowFixed' => (int)$noOfLocksManagingNowFixed,
                'noOfLocksManagingNowVariable' => (int)$noOfLocksManagingNowVariable,
                'noOfRatings' => (int)$noOfRatings,
                'noOfSharedLocks' => (int)$noOfSharedLocks,
                'noOfSharedLocksFixed' => (int)$noOfSharedLocksFixed,
                'noOfSharedLocksVariable' => (int)$noOfSharedLocksVariable,
                'status' => $status,
                'timestampFirstKeyheld' => (int)$timestampFirstKeyheld,
                'timestampJoined' => strtotime($row["created"]),
                'timestampLastActive' => (int)$row["timestamp_last_active"],
                'totalLocksManaged' => (int)$totalLocksManaged,
                'twitterUsername' => (string)$row["twitter_handle"],
                'versionInstalled' => $row["version_installed"]
            );
        } else {
            $data = array(
                'userID' => -9,
                'username' => $row["username"],
                'discordID' => "<hidden>",
                'displayInStats' => (int)$row["display_in_stats"],
                'averageRating' => -9,
                'buildNumberInstalled' => -9,
                'dateFirstKeyheld' => "<hidden>",
                'followersCount' => -9,
                'followingCount' => -9,
                'joined' => "<hidden>",
                'keyholderLevel' => -9,
                'mainRole' => "<hidden>",
                'noOfLocksFlaggedAsTrusted' => -9,
                'noOfLocksManagingNow' => -9,
                'noOfLocksManagingNowFixed' => -9,
                'noOfLocksManagingNowVariable' => -9,
                'noOfRatings' => -9,
                'noOfSharedLocks' => -9,
                'noOfSharedLocksFixed' => -9,
                'noOfSharedLocksVariable' => -9,
                'status' => "<hidden>",
                'timestampFirstKeyheld' => -9,
                'timestampJoined' => -9,
                'timestampLastActive' => -9,
                'totalLocksManaged' => -9,
                'twitterUsername' => "<hidden>",
                'versionInstalled' => "<hidden>"
            );
        }
    }
    $array["data"] = $data;
    $array["locks"] = array();
    if ($row["display_in_stats"] == 1 || $apiUserID == $userID) {
        $query = $pdo->prepare("select
            block_users_already_locked,
            build, 
            card_info_hidden, 
            cumulative, 
            daily, 
            fixed, 
            force_trust, 
            hide_from_owner, 
            id,
            key_disabled, 
            max_auto_resets,
            max_random_copies,
            max_random_double_ups, 
            max_random_freezes, 
            max_random_greens, 
            max_random_minutes,
            max_random_reds, 
            max_random_resets, 
            max_random_stickies,
            max_random_yellows, 
            max_random_yellows_add, 
            max_random_yellows_minus, 
            maximum_copies,
            maximum_users,
            min_random_copies,
            min_random_double_ups,
            min_random_freezes,
            min_random_greens,
            min_random_minutes,
            min_random_reds,
            min_random_resets,
            min_random_stickies,
            min_random_yellows, 
            min_random_yellows_add,
            min_random_yellows_minus,
            minimum_version_required, 
            multiple_greens_required,
            name,
            regularity, 
            require_dm,
            reset_frequency_in_seconds,
            share_id, 
            share_in_api,
            simulation_average_minutes_locked,
            simulation_best_case_minutes_locked,
            simulation_worst_case_minutes_locked,
            timer_hidden,
            user_id,
            version 
        from ShareableLocks_V2
        where user_id = :userID and 
            hide_from_owner = 0");
        $query->execute(array('userID' => $userID));
        if ($query->rowCount() > 0) {
            $lockees = array();
            foreach ($query as $row) {
                if ($row["share_in_api"] == 0) {
                    $sharedLockID = "<hidden>";
                    $sharedLockQRCode = "<hidden>";
                    $sharedLockURL = "<hidden>";
                } else {
                    $sharedLockID = $row["share_id"];
                    $sharedLockQRCode = $appName."-Shareable-Lock-".$row["share_id"];
                    $sharedLockURL = $appServerDomain."/sharedlock/".$row["share_id"];
                }
                
                $minVersionRequired = $row["minimum_version_required"];
                if ($minVersionRequired == "") { $minVersionRequired = "2.2.0"; }
                $minCopies = 0;
                $maxCopies = 0;
                if ($row["maximum_copies"] > 0) {
                    $minCopies = 0;
                    $maxCopies = $row["maximum_copies"];
                } elseif ($row["max_random_copies"] > 0) {
                    $minCopies = $row["min_random_copies"];
                    $maxCopies = $row["max_random_copies"];
                }
                
                if ($row["fixed"] == 0) {
                    if ($row["card_info_hidden"] == 0) {
                        $autoResetFrequencyInSeconds = $row["reset_frequency_in_seconds"];
                        $maxAutoResets = $row["max_auto_resets"];
                        $maxDoubleUps = $row["max_random_double_ups"];
                        $maxFreezes = $row["max_random_freezes"];
                        $maxGreens = $row["max_random_greens"];
                        $maxMinutes = 0;
                        $maxReds = $row["max_random_reds"];
                        $maxResets = $row["max_random_resets"];
                        $maxStickies = $row["max_random_stickies"];
                        $maxYellows = $row["max_random_yellows"];
                        $maxYellowsAdd = $row["max_random_yellows_add"];
                        $maxYellowsMinus = $row["max_random_yellows_minus"];
                        $minDoubleUps = $row["min_random_double_ups"];
                        $minFreezes = $row["min_random_freezes"];
                        $minGreens = $row["min_random_greens"];
                        $minMinutes = 0;
                        $minReds = $row["min_random_reds"];
                        $minResets = $row["min_random_resets"];
                        $minStickies = $row["min_random_stickies"];
                        $minYellows = $row["min_random_yellows"];
                        $minYellowsAdd = $row["min_random_yellows_add"];
                        $minYellowsMinus = $row["min_random_yellows_minus"];
                    }
                    if ($row["card_info_hidden"] == 1) {
                        $autoResetFrequencyInSeconds = -9;
                        $maxAutoResets = -9;
                        $maxDoubleUps = -9;
                        $maxFreezes = -9;
                        $maxGreens = -9;
                        $maxMinutes = 0;
                        $maxReds = -9;
                        $maxResets = -9;
                        $maxStickies = -9;
                        $maxYellows = -9;
                        $maxYellowsAdd = -9;
                        $maxYellowsMinus = -9;
                        $minDoubleUps = -9;
                        $minFreezes = -9;
                        $minGreens = -9;
                        $minMinutes = 0;
                        $minReds = -9;
                        $minResets = -9;
                        $minStickies = -9;
                        $minYellows = -9;
                        $minYellowsAdd = -9;
                        $minYellowsMinus = -9;
                    }
                }
                if ($row["fixed"] == 1) {
                    if ($row["timer_hidden"] == 0) {
                        $autoResetFrequencyInSeconds = 0;
                        $maxAutoResets = 0;
                        $maxDoubleUps = 0;
                        $maxFreezes = 0;
                        $maxGreens = 0;
                        if ($row["regularity"] == 0.016667) {
                            $maxMinutes = $row["max_random_minutes"];
                            $maxReds = 0;
                        } else {
                            $maxMinutes = $row["max_random_reds"] * (3600 * $row["regularity"]);
                            $maxReds = 0;
                        }
                        $maxResets = 0;
                        $maxStickies = 0;
                        $maxYellows = 0;
                        $maxYellowsAdd = 0;
                        $maxYellowsMinus = 0;
                        $minDoubleUps = 0;
                        $minFreezes = 0;
                        $minGreens = 0;
                        if ($row["regularity"] == 0.016667) {
                            $minMinutes = $row["min_random_minutes"];
                            $minReds = 0;
                        } else {
                            $minMinutes = $row["min_random_reds"] * (3600 * $row["regularity"]);
                            $minReds = 0;
                        }
                        $minResets = 0;
                        $minStickies = 0;
                        $minYellows = 0;
                        $minYellowsAdd = 0;
                        $minYellowsMinus = 0;
                    }
                    if ($row["timer_hidden"] == 1) {
                        $autoResetFrequencyInSeconds = 0;
                        $maxAutoResets = 0;
                        $maxDoubleUps = 0;
                        $maxFreezes = 0;
                        $maxGreens = 0;
                        $maxMinutes = -9;
                        $maxReds = 0;
                        $maxResets = 0;
                        $maxStickies = 0;
                        $maxYellows = 0;
                        $maxYellowsAdd = 0;
                        $maxYellowsMinus = 0;
                        $minDoubleUps = 0;
                        $minFreezes = 0;
                        $minGreens = 0;
                        $minMinutes = -9;
                        $minReds = 0;
                        $minResets = 0;
                        $minStickies = 0;
                        $minYellows = 0;
                        $minYellowsAdd = 0;
                        $minYellowsMinus = 0;
                    }
                }
                $maxUsers = $row["maximum_users"];
                
                if ($row["regularity"] == 0.016667) { $row["regularity"] = 0; }
                
                if ($row["fixed"] == 0) {
                    if ($row["card_info_hidden"] == 0) {
                        $simulationAverageMinutesLocked = $row["simulation_average_minutes_locked"];
                        $simulationBestCaseMinutesLocked = $row["simulation_best_case_minutes_locked"];
                        $simulationWorstCaseMinutesLocked = $row["simulation_worst_case_minutes_locked"];
                        if ($simulationAverageMinutesLocked > $simulationWorstCaseMinutesLocked) { $simulationAverageMinutesLocked = $simulationAverageMinutesLocked / 100; }
                    }
                    if ($row["card_info_hidden"] == 1) {
                        $simulationAverageMinutesLocked = -9;
                        $simulationBestCaseMinutesLocked = -9;
                        $simulationWorstCaseMinutesLocked = -9;
                    }
                }
                if ($row["fixed"] == 1) {
                    $simulationAverageMinutesLocked = 0;
                    $simulationBestCaseMinutesLocked = 0;
                    $simulationWorstCaseMinutesLocked = 0;
                }
                
                $lockees = array();
                $query2 = $pdo->prepare("select
                    u.id as u_id,
                    if (u.username = '', CONCAT('CKU', u.id), u.username) as u_username,
                    l.lock_group_id as l_lock_group_id,
                    l.lock_id as l_lock_id,
                    l.build as l_build
                from Locks_V2 as l, UserIDs_V2 as u
                where 
                    l.user_id = u.user_id and 
                    l.shared_id = :sharedID and 
                    l.deleted = 0 and 
                    l.test = 0 and 
                    l.timestamp_locked > 1451606400 and 
                    l.unlocked = 0 order by u_username");
                $query2->execute(array('sharedID' => $row["share_id"]));
                if ($query2->rowCount() > 0) {
                    foreach ($query2 as $row2) {
                        $lockBuild = $row2["l_build"];
                        if ($lockBuild <= 194) {
                            $lockID = $row2["l_lock_group_id"];
                            $lockGroupID = $row2["l_lock_group_id"];
                        } else {
                            if ($row2["l_lock_group_id"] != $row2["l_lock_id"]) {
                                $lockID = $row2["l_lock_group_id"].sprintf("%02d", ($row2["l_lock_id"] - $row2["l_lock_group_id"]));
                                $lockGroupID = $row2["l_lock_group_id"];
                            } else {
                                $lockID = $row2["l_lock_group_id"]."01";
                                $lockGroupID = $row2["l_lock_group_id"];
                            }
                        }
                        array_push($lockees, array(
                            'userID' => (integer)$row2["u_id"],
                            'username' => $row2["u_username"],
                            'lockGroupID' => (integer)$lockGroupID,
                            'lockID' => (integer)$lockID,
                            'build' => (integer)$lockBuild
                        ));
                    }
                }
                
                $lock = array(
                    'lockID' => (integer)$row["id"],
                    'lockName' => $row["name"],
                    'sharedLockID' => $sharedLockID,
                    'sharedLockQRCode' => $sharedLockQRCode,
                    'sharedLockURL' => $sharedLockURL,
                    'autoResetFrequencyInSeconds' => (integer)$autoResetFrequencyInSeconds,
                    'blockUsersAlreadyLocked' => (integer)$row["block_users_already_locked"],
                    'cardInfoHidden' => (integer)$row["card_info_hidden"],
                    'cumulative' => (integer)$row["cumulative"],
                    'fixed' => (integer)$row["fixed"],
                    'forceTrust' => (integer)$row["force_trust"],
                    'keyDisabled' => (integer)$row["key_disabled"],
                    'lockees' => $lockees,
                    'maxAutoResets' => (integer)$maxAutoResets,
                    'maxDoubleUps' => (integer)$maxDoubleUps,
                    'maxFreezes' => (integer)$maxFreezes,
                    'maxGreens' => (integer)$maxGreens,
                    'maxMinutes' => (integer)$maxMinutes,
                    'maxReds' => (integer)$maxReds,
                    'maxResets' => (integer)$maxResets,
                    'maxStickies' => (integer)$maxStickies,
                    'maxUsers' => (integer)$row["maximum_users"],
                    'maxYellows' => (integer)$maxYellows,
                    'maxYellowsAdd' => (integer)$maxYellowsAdd,
                    'maxYellowsMinus' => (integer)$maxYellowsMinus,
                    'minDoubleUps' => (integer)$minDoubleUps,
                    'minFreezes' => (integer)$minFreezes,
                    'minGreens' => (integer)$minGreens,
                    'minMinutes' => (integer)$minMinutes,
                    'minReds' => (integer)$minReds,
                    'minResets' => (integer)$minResets,
                    'minStickies' => (integer)$minStickies,
                    'minVersionRequired' => (string)$minVersionRequired,
                    'minYellows' => (integer)$minYellows,
                    'minYellowsAdd' => (integer)$minYellowsAdd,
                    'minYellowsMinus' => (integer)$minYellowsMinus,
                    'multipleGreensRequired' => (integer)$row["multiple_greens_required"],
                    'regularity' => (double)$row["regularity"],
                    'requireDM' => (integer)$row["require_dm"],
                    'simulationAverageMinutesLocked' => (integer)$simulationAverageMinutesLocked,
                    'simulationBestCaseMinutesLocked' => (integer)$simulationBestCaseMinutesLocked,
                    'simulationWorstCaseMinutesLocked' => (integer)$simulationWorstCaseMinutesLocked,
                    'timerHidden' => (integer)$row["timer_hidden"]
                );
                array_push($array["locks"], $lock);
            }
        }
    }
    echo json_encode($array, JSON_PRETTY_PRINT);
    $query = null;
    $pdo = null;
    die();
}
?>
