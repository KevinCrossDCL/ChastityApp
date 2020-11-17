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
        $userID = $row["user_id"];
        if ($row["display_in_stats"] != 1 && $apiUserID != $userID) {
            header("HTTP/1.1 403 Forbidden", true, 403);
            $array["response"] = array('status' => 403, 'message' => 'forbidden: user has selected to keep their data from the API', 'timestampGenerated' => time());
            echo json_encode($array, JSON_PRETTY_PRINT);
            $query = null;
            $pdo = null;
            die();
        }
    }
    
    $test = 0;
    if (($postData['includetestlocks'] == "1" || strtolower($postData['includetestlocks']) == "true") && $apiUserID == $userID) {
        $test = 1;
    }
        
    $query = $pdo->prepare("select 
        l.build as l_build,
        l.combination as l_combination,
        l.id as l_id,
        l.lock_group_id as l_lock_group_id, 
        l.lock_id as l_lock_id,
        l.name as l_name,
        l.shared_id as l_shared_id,
        l.test as l_test,
        l.timestamp_unlocked as l_timestamp_unlocked
    from UserIDs_V2 as u, Locks_V2 as l where ((u.username = :username and :username <> '') or (u.discord_id = :discordID and :discordID <> '')) and u.user_id = l.user_id and l.fake = 0 and l.unlocked = 1 and l.test <= :test order by l.timestamp_unlocked desc");
    $query->execute(array('username' => $postData['username'], 'discordID' => $postData['discordid'], 'test' => $test));
    if ($query->rowCount() > 0) {
        header("HTTP/1.1 200 OK", true, 200);
        $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
        $array["locks"] = array();
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
                        if ($lockedBy == "") {
                            $lockedBy = "CKU".$row2["u_id"];
                        }
                        if ($row2["u_display_in_stats"] != "1") {
                            $lockedBy = "<hidden>";
                        }
                        if ($row2["s_name"] != "") { $lockName = $row2["s_name"]; }
                    }
                }
            }
            
            $lock = array(
                'lockGroupID' => (int)$lockGroupID,
                'lockID' => (int)$lockID,
                'lockedBy' => $lockedBy,
                'lockName' => $lockName,
                'build' => (int)$lockBuild,
                'combination' => $row["l_combination"],
                'test' => (int)$row["l_test"],
                'timestampUnlocked' => (int)$row["l_timestamp_unlocked"]
            );
            array_push($array["locks"], $lock);
        }
        echo json_encode($array, JSON_PRETTY_PRINT);
        $query = null;
        $pdo = null;
        die();
    } else {
        header("HTTP/1.1 204 No Content", true, 204);
        $array["response"] = array('status' => 204, 'message' => 'no records found', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        $query = null;
        $pdo = null;
        die();
    }
}
?>
