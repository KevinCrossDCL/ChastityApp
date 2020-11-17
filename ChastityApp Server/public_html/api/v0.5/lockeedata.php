<?php
session_start();

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, clientID, clientSecret");
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Content-Type: application/json");

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
        //$data = "";
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

        $test = 0;
        if (($postData['includetestlocks'] == "1" || strtolower($postData['includetestlocks']) == "true") && $apiUserID == $userID) {
            $test = 1;
        }
        
        $secondsLockedInCurrentLock = 0;
        $query2 = $pdo->prepare("select 
            coalesce(max(:timestampNow - l.timestamp_locked), 0) as secondsLockedInCurrentLock
        from Locks_V2 as l
        where l.user_id = :userID and 
            l.deleted = 0 and 
            l.display_in_stats = 1 and 
            l.test <= :test and 
            l.timestamp_locked > 1451606400 and 
            l.unlocked = 0");
        $query2->execute(array('userID' => $row["user_id"], 'timestampNow' => time(), 'test' => $test));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $secondsLockedInCurrentLock = $row2["secondsLockedInCurrentLock"];
            }
        }
        
        $cumulativeSecondsLocked = 0;
        $noOfLocks = 0;
        $noOfLocksCompleted = 0;
        $longestSecondsLocked = 0;
        $query2 = $pdo->prepare("select 
            l.deleted as l_deleted,
            l.timestamp_locked as l_timestamp_locked,
            l.timestamp_unlocked as l_timestamp_unlocked,
            l.unlocked as l_unlocked
        from Locks_V2 as l where l.user_id = :userID and 
            l.display_in_stats = 1 and 
            l.fake = 0 and 
            l.test <= :test and 
            l.timestamp_locked > 1451606400 and 
            (l.unlocked = 1 or (l.unlocked = 0 and l.deleted = 0))
        order by l.timestamp_locked");
        $query2->execute(array('userID' => $row["user_id"], 'test' => $test));
        foreach ($query2 as $row2) {
            $deleted = $row2["l_deleted"];
            $timestampLocked = $row2["l_timestamp_locked"];
            $timestampUnlocked = $row2["l_timestamp_unlocked"];
            $unlocked = $row2["l_unlocked"];
            if ($deleted == 0 && $unlocked == 0) { $timestampUnlocked = time(); }
            $secondsLocked = $timestampUnlocked - $timestampLocked;
            if ($secondsLocked <= 0) { continue; }
            $noOfLocks++;
            if ($unlocked == 1) { $noOfLocksCompleted++; }
            if ($secondsLocked > $longestSecondsLocked && $unlocked == 1) { $longestSecondsLocked = $secondsLocked; }
            if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked <= $lastTimestampUnlocked) { continue; }
            if ($timestampLocked <= $lastTimestampUnlocked) {
                $timestampLocked = $lastTimestampUnlocked;
                $secondsLocked = $timestampUnlocked - $timestampLocked;
            }
            if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked > $lastTimestampUnlocked) { $cumulativeSecondsLocked = $cumulativeSecondsLocked + $secondsLocked; }
            $lastTimestampLocked = $timestampLocked;
            $lastTimestampUnlocked = $timestampUnlocked;
        }
        if ($noOfLocks > 0) {
            $averageTimeLockedInSeconds = $cumulativeSecondsLocked / $noOfLocks;
        } else {
            $averageTimeLockedInSeconds = $cumulativeSecondsLocked;
        }
        $longestCompletedLockInSeconds = $longestSecondsLocked;
        $totalNoOfLocks = $noOfLocks;
        $totalNoOfCompletedLocks = $noOfLocksCompleted;
 
        $averageRating = 0;
        $noOfRatings = 0;
        $query2 = $pdo->prepare("select
            coalesce(cast(avg(l.rating_from_keyholder) as decimal(3,2)), 0) as averageRating,
            coalesce(count(*), 0) as noOfRatings
        from Locks_V2 as l
        where l.user_id = :userID and 
            l.display_in_stats = 1 and 
            l.fake = 0 and 
            l.rating_from_keyholder > 0 and 
            l.test <= :test");
        $query2->execute(array('userID' => $row["user_id"], 'test' => $test));
        if ($query2->rowCount() == 1) {
            foreach ($query2 as $row2) {
                $averageRating = $row2["averageRating"];
                $noOfRatings = $row2["noOfRatings"];
                if ($noOfRatings < 5) { $averageRating = 0; }
            }
        }
        
        if ($cumulativeMonthsLocked >= 24) { $lockeeLevel = 5; }
        elseif ($cumulativeMonthsLocked >= 12) { $lockeeLevel = 4; }
        elseif ($cumulativeMonthsLocked >= 6 && $cumulativeMonthsLocked < 12) { $lockeeLevel = 3; }
        elseif ($cumulativeMonthsLocked >= 2 && $cumulativeMonthsLocked < 6) { $lockeeLevel = 2; }
        else { $lockeeLevel = 1; }
    
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
                'averageTimeLockedInSeconds' => (int)$averageTimeLockedInSeconds,
                'buildNumberInstalled' => (int)$row["build_number_installed"],
                'cumulativeSecondsLocked' => (int)$cumulativeSecondsLocked,
                'followersCount' => (int)$followersCount,
                'followingCount' => (int)$followingCount,
                'joined' => $row["created"],
                'lockeeLevel' => (int)$lockeeLevel,
                'longestCompletedLockInSeconds' => (int)$longestCompletedLockInSeconds,
                'mainRole' => $mainRole,
                'noOfRatings' => (int)$noOfRatings,
                'secondsLockedInCurrentLock' => (int)$secondsLockedInCurrentLock,
                'status' => $status,
                'timestampJoined' => strtotime($row["created"]),
                'timestampLastActive' => (int)$row["timestamp_last_active"],
                'totalNoOfCompletedLocks' => (int)$totalNoOfCompletedLocks,
                'totalNoOfLocks' => (int)$totalNoOfLocks,
                'twitterUsername' => (string)$row["twitter_handle"],
                'versionInstalled' => $row["version_installed"]
            );
        } else {
            $data = array(
                'userID' => -9,
                'username' => $row["username"],
                'discordID' => $row["discord_id"],
                'displayInStats' => (int)$row["display_in_stats"],
                'averageRating' => -9,
                'averageTimeLockedInSeconds' => -9,
                'buildNumberInstalled' => -9,
                'cumulativeSecondsLocked' => -9,
                'followersCount' => -9,
                'followingCount' => -9,
                'joined' => "<hidden>",
                'lockeeLevel' => -9,
                'longestCompletedLockInSeconds' => -9,
                'mainRole' => "<hidden>",
                'noOfRatings' => -9,
                'secondsLockedInCurrentLock' => -9,
                'status' => "<hidden>",
                'timestampJoined' => -9,
                'timestampLastActive' => -9,
                'totalNoOfCompletedLocks' => -9,
                'totalNoOfLocks' => -9,
                'twitterUsername' => "<hidden>",
                'versionInstalled' => "<hidden>"
            );
        }
    }
    $array["data"] = $data;
    $array["locks"] = array();
    if ($row["display_in_stats"] == 1 || $apiUserID == $userID) {
        $lockGroupID = 0;
        $lockID = 0;
        if ($postData['lockid'] > 0) {
            if (strlen($postData['lockid']) == 12) {
                $lockGroupID = 0;
                $lockID = (integer)substr($postData['lockid'], 0, 10) + (integer)substr($postData['lockid'], 11, 2);
            } else {
                $lockGroupID = (integer)$postData['lockid'];
                $lockID = 0;
            }
        } elseif ($postData['lockgroupid'] > 0) {
            $lockGroupID = (integer)$postData['lockgroupid'];
            $lockID = 0;
        }
        $deleted = 0;
        if ($postData['showdeleted'] == "1" || strtolower($postData['showdeleted']) == "true") {
            $deleted = 1;
        }
        if ($postData['includedeletedlocks'] == "1" || strtolower($postData['includedeletedlocks']) == "true") {
            $deleted = 1;
        }
        $query = $pdo->prepare("select 
            l.auto_resets_paused as l_auto_resets_paused,
            l.bot_chosen as l_bot_chosen,
            l.build as l_build,
            l.card_info_hidden as l_card_info_hidden,
            l.combination as l_combination,
            l.cumulative as l_cumulative,
            l.deleted as l_deleted,
            l.discard_pile as l_discard_pile,
            l.double_up_cards as l_double_up_cards,
            l.fake as l_fake,
            l.fixed as l_fixed,
            l.freeze_cards as l_freeze_cards,
            l.green_cards as l_green_cards,
            l.greens_picked_since_reset as l_green_cards_picked, 
            l.id as l_id,
            l.lock_frozen_by_card as l_lock_frozen_by_card,
            l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
            l.lock_group_id as l_lock_group_id, 
            l.lock_id as l_lock_id,
            l.maximum_auto_resets as l_maximum_auto_resets,
            l.minutes as l_minutes,
            l.multiple_greens_required as l_multiple_greens_required, 
            l.name as l_name,
            l.no_of_times_auto_reset as l_no_of_times_auto_reset,
            l.no_of_times_card_reset as l_no_of_times_card_reset,
            l.no_of_times_full_reset as l_no_of_times_full_reset,
            l.picked_count as l_picked_count, 
            l.red_cards as l_red_cards,
            l.regularity as l_regularity,
            l.ready_to_unlock as l_ready_to_unlock,
            l.reset_cards as l_reset_cards,
            l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
            l.shared_id as l_shared_id,
            l.sticky_cards as l_sticky_cards,
            l.test as l_test,
            l.timer_hidden as l_timer_hidden,
            l.timestamp_deleted as l_timestamp_deleted,
            l.timestamp_frozen_by_card as l_timestamp_frozen_by_card,
            l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder,
            l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
            l.timestamp_last_card_reset as l_timestamp_last_card_reset,
            l.timestamp_last_full_reset as l_timestamp_last_full_reset,
            l.timestamp_last_picked as l_timestamp_last_picked,
            l.timestamp_locked as l_timestamp_locked, 
            l.timestamp_real_last_picked as l_timestamp_real_last_picked,
            l.timestamp_unlocked as l_timestamp_unlocked, 
            l.total_time_frozen as l_total_time_frozen,
            l.trust_keyholder as l_trust_keyholder, 
            l.unlocked as l_unlocked,
            l.yellow_cards as l_yellow_cards
        from UserIDs_V2 as u, Locks_V2 as l where ((u.username = :username and :username <> '') or (u.discord_id = :discordID and :discordID <> '')) and u.user_id = l.user_id and ((l.lock_group_id > 0 and :lockGroupID = 0 and :lockID = 0 and l.deleted <= :deleted) or (l.lock_group_id = :lockGroupID and :lockGroupID > 0) or (l.lock_id = :lockID and :lockID > 0)) and l.test <= :test");
        $query->execute(array('username' => $postData['username'], 'discordID' => $postData['discordid'], 'lockGroupID' => $lockGroupID, 'lockID' => $lockID, 'deleted' => $deleted, 'test' => $test));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                $lockBuild = $row["l_build"];
                if ($lockBuild <= 194) {
                    $lockID = $row["l_lock_group_id"];
                    $lockGroupID = $row["l_lock_group_id"];
                } else {
                    if ($row["l_lock_group_id"] != $row["l_lock_id"]) {
                        $lockID = $row["l_lock_group_id"].sprintf("%02d", ($row["l_lock_id"] - $row["l_lock_group_id"]));
                        $lockGroupID = $row["l_lock_group_id"];
                    } else {
                        $lockID = $row["l_lock_group_id"]."01";
                        $lockGroupID = $row["l_lock_group_id"];
                    }
                }
                        
                $lockedBy = "";
                $lockName = $row["l_name"];
                $sharedLockID = "";
                $sharedLockQRCode = "";
                $sharedLockURL = "";
                if ($row["l_shared_id"] == "BOT01") {
                    $lockedBy = "Hailey";
                } elseif ($row["l_shared_id"] == "BOT02") { 
                    $lockedBy = "Blaine";
                } elseif ($row["l_shared_id"] == "BOT03") {
                    $lockedBy = "Zoe";
                } elseif ($row["l_shared_id"] == "BOT04") {
                    $lockedBy = "Chase";
                } else {
                    $query2 = $pdo->prepare("select u.id as u_id, u.user_id as u_user_id, u.username as u_username, u.display_in_stats as u_display_in_stats, s.share_id as s_shared_id, s.name as s_name, s.share_in_api as s_share_in_api, s.user_id as s_user_id, s.hide_from_owner as s_hide_from_owner, s.timestamp_hidden as s_timestamp_hidden, l.id as l_id, l.user_id as l_user_id, l.shared_id as l_shared_id from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l where l.id = :id and l.shared_id = s.share_id and s.user_id = u.user_id");
                    $query2->execute(array('id' => $row["l_id"]));
                    if ($query2->rowCount() == 1) {
                        foreach ($query2 as $row2) {
                            $lockedBy = $row2["u_username"];
                            $lockedByUserID = $row2["u_user_id"];
                            if ($lockedBy == "") {
                                $lockedBy = "CKU".$row2["u_id"];
                            }
                            if ($row2["u_display_in_stats"] != "1" && $apiUserID != $lockedByUserID) {
                                $lockedBy = "<hidden>";
                            }
                            if ($row2["s_name"] != "") { $lockName = $row2["s_name"]; }
                            if ($row2["s_share_in_api"] == 0 && $row["l_shared_id"] != "" && $apiUserID != $lockedByUserID) {
                                $sharedLockID = "<hidden>";
                                $sharedLockQRCode = "<hidden>";
                                $sharedLockURL = "<hidden>";
                            } else {
                                $sharedLockID = $row["l_shared_id"];
                                $sharedLockQRCode = $appName."-Shareable-Lock-".$row["l_shared_id"];
                                $sharedLockURL = $appServerDomain."/sharedlock/".$row["l_shared_id"];
                            }
                            if ($row2["s_hide_from_owner"] == 1) {
                                $lockedBy = "";
                                $sharedLockID = "";
                                $sharedLockQRCode = "";
                                $sharedLockURL = "";
                            }
                        }
                    }
                }
                
                if (($row["l_card_info_hidden"] == 1 || $row["l_timer_hidden"] == 1) && $apiUserID != $lockedByUserID) {
                    $doubleUpCards = -9;
                    $freezeCards = -9;
                    $greenCards = -9;
                    $minutes = -9;
                    $redCards = -9;
                    $resetCards = -9;
                    $stickyCards = -9;
                    $yellowCards = -9;
                } else {
                    $doubleUpCards = $row["l_double_up_cards"];
                    $freezeCards = $row["l_freeze_cards"];
                    $greenCards = $row["l_green_cards"];
                    $minutes = $row["l_minutes_cards"];
                    $redCards = $row["l_red_cards"];
                    $resetCards = $row["l_reset_cards"];
                    $stickyCards = $row["l_sticky_cards"];
                    $yellowCards = $row["l_yellow_cards"];
                }
                
                if ($row["l_unlocked"] == 0) {
                    if ($row["l_ready_to_unlock"] == 1) {
                        $lockStatus = "ReadyToUnlock";
                        $combination = "";
                    } else {
                        if ($apiUserID != $lockedByUserID) {
                            if ($row["l_fake"] == 0) {
                                $lockStatus = "Locked";
                                $combination = "";
                            } else {
                                $query = $pdo->prepare("select id from Locks_V2 where user_id = :userID and lock_group_id = :lockGroupID and unlocked = 1 and fake = 0");
                                $query->execute(array('userID' => $userID, 'lockGroupID' => $lockGroupID));
                                if ($query->rowCount() > 0) { 
                                    $lockStatus = "LockedFake"; 
                                    $combination = "";
                                } else {
                                    $lockStatus = "Locked";
                                    $combination = "";
                                }
                            }
                        } else {
                            if ($row["l_fake"] == 0) {
                                $lockStatus = "LockedReal";
                                $combination = "";
                            } else {
                                $lockStatus = "LockedFake";
                                $combination = "";
                            }
                        }
                    }
                } else {
                    if ($row["l_fake"] == 0) {
                        $lockStatus = "UnlockedReal";
                        $combination = $row["l_combination"];
                    } else {
                        $lockStatus = "UnlockedFake";
                        $combination = $row["l_combination"];
                    }
                }
                
                $lockFrozen = 0;
                if ($row["l_lock_frozen_by_card"] == "1" || $row["l_lock_frozen_by_keyholder"] == "1") { $lockFrozen = 1; }
                
                $timestampExpectedUnlock = 0;
                if ($row["l_fixed"] == 1 && $lockStatus == "Locked") {
                    if ($row["l_timer_hidden"] == 0 || $apiUserID == $lockedByUserID) {
                        if ($row["l_regularity"] == 0.016667) {
                            $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_minutes"] * 60);
                        }
                        if ($row["l_regularity"] >= 0.25) {
                            $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_red_cards"] * ($row["l_regularity"] * 3600));
                        }
                    } else {
                        $timestampExpectedUnlock = -9;
                    }
                }
                
                $timestampLastPicked = $row["l_timestamp_locked"];
                if ($row["l_timestamp_last_picked"] > $row["l_timestamp_locked"]) { $timestampLastPicked = $row["l_timestamp_last_picked"]; }

                $timestampNextPick = 0;
                $timestampNextPick = $row["l_timestamp_last_picked"] + ($row["l_regularity"] * 3600);
                if ($row["l_fixed"] == 0 && $lockFrozen == 1) { $timestampNextPick = -9; }
                if ($row["l_unlocked"] == 1 || $row["l_ready_to_unlock"] == 1) { $timestampNextPick = 0; }
                
                if ($row["l_regularity"] == 0.016667) { $row["l_regularity"] = 0; }
                
                $timestampFrozenByCard = (int)$row["l_timestamp_frozen_by_card"];
                $timestampFrozenByKeyholder = (int)$row["l_timestamp_frozen_by_keyholder"];
                $totalTimeFrozen = (int)$row["l_total_time_frozen"];
                if ($timestampFrozenByCard > 0 && $row["l_lock_frozen_by_card"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByCard); }
                if ($timestampFrozenByKeyholder > 0 && $row["l_lock_frozen_by_keyholder"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByKeyholder); }
        
                $lock = array(
                    'lockGroupID' => (int)$lockGroupID,
                    'lockID' => (int)$lockID,
                    'lockedBy' => $lockedBy,
                    'lockName' => $lockName,
                    'sharedLockID' => $sharedLockID,
                    'sharedLockQRCode' => $sharedLockQRCode,
                    'sharedLockURL' => $sharedLockURL,
                    'autoResetFrequencyInSeconds' => (int)$row["l_reset_frequency_in_seconds"],
                    'autoResetsPaused' => (int)$row["l_auto_resets_paused"],
                    'botChosen' => (int)$row["l_bot_chosen"],
                    'build' => (int)$lockBuild,
                    'cardInfoHidden' => (int)$row["l_card_info_hidden"],
                    'cumulative' => (int)$row["l_cumulative"],
                    'combination' => $combination,
                    'deleted' => (int)$row["l_deleted"],
                    'discardPile' => rtrim($row["l_discard_pile"], ","),
                    'doubleUpCards' => (int)$doubleUpCards,
                    'fixed' => (int)$row["l_fixed"],
                    'freezeCards' => (int)$freezeCards,
                    'greenCards' => (int)$greenCards,
                    'greenCardsPicked' => (int)$row["l_green_cards_picked"],
                    'lockFrozen' => $lockFrozen,
                    'lockFrozenByCard' => (int)$row["l_lock_frozen_by_card"],
                    'lockFrozenByKeyholder' => (int)$row["l_lock_frozen_by_keyholder"],
                    'logID' => (int)$row["l_lock_id"],
                    'maximumAutoResets' => (int)$row["l_maximum_auto_resets"],
                    'multipleGreensRequired' => (int)$row["l_multiple_greens_required"],
                    'noOfTimesAutoReset' => (int)$row["l_no_of_times_auto_reset"],
                    'noOfTimesCardReset' => (int)$row["l_no_of_times_card_reset"],
                    'noOfTimesFullReset' => (int)$row["l_no_of_times_full_reset"],
                    'noOfTurns' => (int)$row["l_picked_count"],
                    'redCards' => (int)$redCards,
                    'regularity' => (double)$row["l_regularity"],
                    'resetCards' => (int)$resetCards,
                    'status' => $lockStatus,
                    'stickyCards' => (int)$stickyCards,
                    'test' => (int)$row["l_test"],
                    'timerHidden' => (int)$row["l_timer_hidden"],
                    'timestampDeleted' => (int)$row["l_timestamp_deleted"],
                    'timestampExpectedUnlock' => $timestampExpectedUnlock,
                    'timestampFrozenByCard' => $timestampFrozenByCard,
                    'timestampFrozenByKeyholder' => $timestampFrozenByKeyholder,
                    'timestampLastAutoReset' => (int)$row["l_timestamp_last_auto_reset"],
                    'timestampLastCardReset' => (int)$row["l_timestamp_last_card_reset"],
                    'timestampLastFullReset' => (int)$row["l_timestamp_last_full_reset"],
                    'timestampLastPicked' => (int)$timestampLastPicked,
                    'timestampLocked' => (int)$row["l_timestamp_locked"],
                    'timestampNextPick' => (int)$timestampNextPick,
                    'timestampRealLastPicked' => (int)$row["l_timestamp_real_last_picked"],
                    'timestampUnlocked' => (int)$row["l_timestamp_unlocked"],
                    'totalTimeFrozen' => $totalTimeFrozen,
                    'trustKeyholder' => (int)$row["l_trust_keyholder"],
                    'yellowCards' => (int)$yellowCards
                );
                array_push($array["locks"], $lock);
            }
            echo json_encode($array, JSON_PRETTY_PRINT);
            $query = null;
            $pdo = null;
            die();
        }
    }
    echo json_encode($array, JSON_PRETTY_PRINT);
    $query = null;
    $pdo = null;
    die();
}
?>
