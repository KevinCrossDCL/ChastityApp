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
if ($postData["lockid"] == "") {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'required postdata missing: lockid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
if ($postData["lockid"] != "" && !is_numeric($postData["lockid"])) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid postdata: lockid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
if ($postData["logid"] == "") {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'required postdata missing: logid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}
if ($postData["logid"] != "" && !is_numeric($postData["logid"])) {
    header("HTTP/1.1 400 Bad Request", true, 400);
    $array["response"] = array('status' => 400, 'message' => 'invalid postdata: logid', 'timestampGenerated' => time());
    echo json_encode($array, JSON_PRETTY_PRINT);
    die();
}

// VALIDATE OPTIONAL POSTFIELDS
$sinceTimestamp = 0;
if ($postData["since"] != "") {
    if (!is_numeric($postData["since"])) {
        header("HTTP/1.1 400 Bad Request", true, 400);
        $array["response"] = array('status' => 400, 'message' => 'invalid postadata: since', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        die();
    }
    $sinceTimestamp = $postData["since"];
}
$limit = 1000;
if ($postData["limit"] != "") {
    if (!is_numeric($postData["limit"])) {
        header("HTTP/1.1 400 Bad Request", true, 400);
        $array["response"] = array('status' => 400, 'message' => 'invalid postadata: limit', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        die();
    }
    $limit = $postData["limit"];
    if ($limit < 0 || $limit > 1000) { $limit = 1000; }
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
        if ($row["display_in_stats"] != 1) {
            header("HTTP/1.1 204 Bad Request", true, 204);
            $array["response"] = array('status' => 204, 'message' => 'no content: user has selected to keep their data from the API', 'timestampGenerated' => time());
            echo json_encode($array, JSON_PRETTY_PRINT);
            $query = null;
            $pdo = null;
            die();
        }
        $userID = $row["user_id"];
    }
    $lockGroupID = 0;
    $lockID = 0;
    $lockName = "";
    if ($postData['lockid'] > 0) {
        if (strlen($postData['lockid']) == 12) {
            $lockID = (integer)substr($postData['lockid'], 0, 10) + (integer)substr($postData['lockid'], 11, 2);
        } else {
            $lockGroupID = (integer)$postData['lockid'];
        }
    } elseif ($postData['lockname'] <> '') {
        $lockName = (string)$postData['lockname'];
    } elseif ($postData['lockgroupid'] > 0) {
        $lockGroupID = (integer)$postData['lockgroupid'];
    }
    $query = $pdo->prepare("select l.id from Locks_V2 as l where l.user_id = :userID and ((l.lock_group_id > 0 and :lockGroupID = 0 and :lockID = 0) or (l.lock_group_id = :lockGroupID and :lockGroupID > 0) or (l.lock_id = :lockID and :lockID > 0))");
    $query->execute(array('userID' => $userID, 'lockGroupID' => $lockGroupID, 'lockID' => $lockID));
    if ($query->rowCount() == 1) {
        if ($limit > 0) { $limitString = " limit ".$limit; }
        else { $limitString = ""; }
        $query = $pdo->prepare("select
            l.id as l_id,
            l.action as l_action,
            l.actioned_by as l_actioned_by,
            l.hidden as l_hidden,
            l.private as l_private,
            l.result as l_result,
            l.timestamp as l_timestamp
	    from Locks_Log as l where l.user_id = :userID and l.lock_id = :logID and l.timestamp >= :sinceTimestamp".$limitString);
        $query->execute(array('userID' => $userID, 'logID' => $postData['logid'], 'sinceTimestamp' => $sinceTimestamp));
        if ($query->rowCount() >= 1) {
            header("HTTP/1.1 200 OK", true, 200);
            $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
            $array["query"] = array('discordID' => (string)$postData['discordid'], 'limit' => (int)$limit, 'lockID' => (int)$postData['lockid'], 'logID' => (int)$postData['logid'], 'since' => (int)$sinceTimestamp, 'username' => (string)$postData['username']);
            $array["log"] = array();
            foreach ($query as $row) {
                // action = "AddedCards", or "RemovedCards"
                    // --- actioned_by = "Keyholder", or "Lockee"
                    // --- result = "<hidden>", "x*DoubleUpCard", "x*FreezeCard", "x*GreenCard", "x*RedCard", "x*ResetCard", "x*YellowAdd1Card", "x*YellowAdd2Card", "x*YellowAdd3Card", "x*YellowMinus1Card", or "x*YellowMinus2Card"
                
                // action = "AddedTime", or "RemovedTime"
                    // --- actioned_by = "Keyholder", or "Lockee"
                    // --- result = "<hidden>", "x" (number of minutes)
                    
                // action = "CardFreezeEnded"
                    // --- actioned_by = "Keyholder", or "Lockee"
 
                // action = "CardFreezeStarted"
                    // --- actioned_by = "Keyholder", or "Lockee"
                
                // action = "Decision"
                    // --- actioned_by = "Lockee"
                    // --- result = "DecideLater", "LetKeyholderDecide", "ResetLock", "ResetLockWithSurpriseMe"

                // action = "DeletedLock"
                    // --- actioned_by = "Lockee"
                
                // action = "KeyholderFreezeEnded"
                    // --- actioned_by = "Keyholder"

                // action = "KeyholderFreezeStarted"
                    // --- actioned_by = "Keyholder"
                
                // action = "KeyholderUpdate"
                    // --- actioned_by = "Keyholder"
                    // --- result = "HidCardInfo", "HidTimer", "ResetLock", "RevealedCardInfo", "RevealedTimer", or "UnlockedLock"
                
                // action = "PickedACard"
                    // --- actioned_by = "Lockee"
                    // --- result = "DoubleUpCard", "FreezeCard", "GreenCard", "RedCard", "ResetCard", "YellowAdd1Card", "YellowAdd2Card", "YellowAdd3Card", "YellowMinus1Card", or "YellowMinus2Card"
                
                // action = "RatedLock"
                    // --- actioned_by = "Keyholder", or "Lockee"
                    // --- result = "<hidden>"
                
                // action = "ReadyToUnlock"
                    // --- actioned_by = "Lockee"
                    
                // action = SetMoodEmoji
                    // --- actioned_by = "Keyholder", or "Lockee"
                    // --- result = "Emoji=x,Colour=x"
                    
                // action = "StartedLock"
                    // --- actioned_by = "Lockee"
                    
                // action = "UnlockedLock"
                    // --- actioned_by = "Keyholder", or "Lockee"
                    // --- result = "Bugged", "FreeUnlock", "GreenCard", "Key", "Naturally", or "NaturallyWithSurpriseMe"
                    
                // result for any of the above can be "<hidden>"
                    
                $action = $row["l_action"];
                
                $actionedBy = $row["l_actioned_by"];
                if ($actionedBy == "App") { $actionedBy = "Lockee"; }
                if ($actionedBy == "Locked") { $actionedBy = "Lockee"; }
                
                $hidden = 0;
                if ($row["l_hidden"] == 1 || $row["private"] == 1) { $hidden = 1; }
                
                $result = $row["l_result"];
                if ($action == "RatedLock" || $hidden == 1) { 
                    if ($row["l_hidden"] == 1) { $action = "<hidden>"; }
                    $result = "<hidden>"; 
                }
                
                if ($actionedBy == "Keyholder" && strpos($result, 'Yellow') !== false) {
                    $result = str_replace("YellowAdd1Card", "YellowCard", $result);
                    $result = str_replace("YellowAdd2Card", "YellowCard", $result);
                    $result = str_replace("YellowAdd3Card", "YellowCard", $result);
                    $result = str_replace("YellowMinus1Card", "YellowCard", $result);
                    $result = str_replace("YellowMinus2Card", "YellowCard", $result);
                }
                
                if ($lastHidden == 1 && $hidden == 1 && $lastTimestamp == $row["l_timestamp"]) {
                    continue;
                }
                $logItem = array(
                    'id' => (int)$row["l_id"],
                    'action' => (string)$action,
                    'actionedBy' => (string)$actionedBy,
                    'hidden' => (int)$hidden,
                    'result' => (string)$result,
                    'timestamp' => (int)$row["l_timestamp"]
                );
                array_push($array["log"], $logItem);
                $lastHidden = $hidden;
                $lastTimestamp = $row["timestamp"];
            }
        } else {
            header("HTTP/1.1 204 No Content", true, 204);
            $array["response"] = array('status' => 204, 'message' => 'no records found', 'timestampGenerated' => time());
            $array["query"] = array('discordID' => (string)$postData['discordid'], 'limit' => (int)$limit, 'lockID' => (int)$postData['lockid'], 'logID' => (int)$postData['logid'], 'since' => (int)$sinceTimestamp, 'username' => (string)$postData['username']);
        }
        echo json_encode($array, JSON_PRETTY_PRINT);
        $query = null;
        $pdo = null;
        die();
    } else {
        header("HTTP/1.1 204 No Content", true, 204);
        $array["response"] = array('status' => 204, 'message' => 'no records found', 'timestampGenerated' => time());
        $array["query"] = array('discordID' => (string)$postData['discordid'], 'limit' => (int)$limit, 'lockID' => (int)$postData['lockid'], 'logID' => (int)$postData['logid'], 'since' => (int)$sinceTimestamp, 'username' => (string)$postData['username']);
        echo json_encode($array, JSON_PRETTY_PRINT);
        $query = null;
        $pdo = null;
        die();
    }
}
?>
