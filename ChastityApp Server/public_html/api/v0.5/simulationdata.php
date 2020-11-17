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

// VALIDATE POSTFIELDS
$minMinutes = 1;
if ($postData["minminutes"] != "") {
    if (!is_numeric($postData["minminutes"])) {
        header("HTTP/1.1 400 Bad Request", true, 400);
        $array["response"] = array('status' => 400, 'message' => 'invalid postadata: minminutes', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        die();
    }
    $minMinutes = $postData["minminutes"];
}
$maxMinutes = 5256000;
if ($postData["maxminutes"] != "") {
    if (!is_numeric($postData["maxminutes"])) {
        header("HTTP/1.1 400 Bad Request", true, 400);
        $array["response"] = array('status' => 400, 'message' => 'invalid postadata: maxminutes', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        die();
    }
    $maxMinutes = $postData["maxminutes"];
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
$query = $pdo->prepare("select
    u.id as u_id,
    if (u.username = '', concat('CKU', u.id), u.username) as u_username,
    u.discord_id as u_discord_id,
    s.card_info_hidden as s_card_info_hidden, 
    s.hide_from_owner as s_hide_from_owner, 
    s.max_auto_resets as s_max_auto_resets,
    s.max_random_double_ups as s_max_random_double_ups, 
    s.max_random_freezes as s_max_random_freezes, 
    s.max_random_greens as s_max_random_greens, 
    s.max_random_reds as s_max_random_reds, 
    s.max_random_resets as s_max_random_resets, 
    s.max_random_stickies as s_max_random_stickies,
    s.max_random_yellows as s_max_random_yellows, 
    s.max_random_yellows_add as s_max_random_yellows_add, 
    s.max_random_yellows_minus as s_max_random_yellows_minus, 
    s.min_random_double_ups as s_min_random_double_ups,
    s.min_random_freezes as s_min_random_freezes,
    s.min_random_greens as s_min_random_greens,
    s.min_random_reds as s_min_random_reds,
    s.min_random_resets as s_min_random_resets,
    s.min_random_stickies as s_min_random_stickies,
    s.min_random_yellows as s_min_random_yellows, 
    s.min_random_yellows_add as s_min_random_yellows_add,
    s.min_random_yellows_minus as s_min_random_yellows_minus,
    s.multiple_greens_required as s_multiple_greens_required,
    s.name as s_name,
    s.regularity as s_regularity, 
    s.reset_frequency_in_seconds as s_auto_reset_frequency_in_seconds,
    s.share_id as s_share_id, 
    s.share_in_api as s_share_in_api,
    s.simulation_average_minutes_locked as s_simulation_average_minutes_locked,
    s.simulation_best_case_minutes_locked as s_simulation_best_case_minutes_locked,
    s.simulation_worst_case_minutes_locked as s_simulation_worst_case_minutes_locked
from ShareableLocks_V2 as s, UserIDs_V2 as u 
where s.user_id = u.user_id and 
    u.display_in_stats = 1 and 
    s.fixed = 0 and
    s.simulation_average_minutes_locked > 0 and
    s.simulation_average_minutes_locked >= :minMinutes and 
    s.simulation_average_minutes_locked <= :maxMinutes order by u_username");
$query->execute(array('minMinutes' => $minMinutes, 'maxMinutes' => $maxMinutes));
if ($query->rowCount() >= 1) {
    header("HTTP/1.1 200 OK", true, 200);
    $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
    $array["locks"] = array();
    foreach ($query as $row) {
        if ($row["s_share_in_api"] == 0 || $row["s_hide_from_owner"] == 1 || $row["s_card_info_hidden"] == 1) {
            $userID = -9;
            $username = "<hidden>";
            $discordID = "";
            $lockName = "";
            $sharedLockID = "<hidden>";
            $sharedLockQRCode = "<hidden>";
            $sharedLockURL = "<hidden>";
        } else {
            $userID = $row["u_id"];
            $username = $row["u_username"];
            $discordID = $row["u_discord_id"];
            $lockName = $row["s_name"];
            $sharedLockID = $row["s_share_id"];
            $sharedLockQRCode = $appName."-Shareable-Lock-".$row["s_share_id"];
            $sharedLockURL = $appServerDomain."/sharedlock/".$row["s_share_id"];
        }

        $maxDoubleUps = $row["s_max_random_double_ups"];
        $maxFreezes = $row["s_max_random_freezes"];
        $maxGreens = $row["s_max_random_greens"];
        $maxReds = $row["s_max_random_reds"];
        $maxResets = $row["s_max_random_resets"];
        $maxStickies = $row["s_max_random_stickies"];
        $maxYellows = $row["s_max_random_yellows"];
        $maxYellowsAdd = $row["s_max_random_yellows_add"];
        $maxYellowsMinus = $row["s_max_random_yellows_minus"];
        $minDoubleUps = $row["s_min_random_double_ups"];
        $minFreezes = $row["s_min_random_freezes"];
        $minGreens = $row["s_min_random_greens"];
        $minReds = $row["s_min_random_reds"];
        $minResets = $row["s_min_random_resets"];
        $minStickies = $row["s_min_random_stickies"];
        $minYellows = $row["s_min_random_yellows"];
        $minYellowsAdd = $row["s_min_random_yellows_add"];
        $minYellowsMinus = $row["s_min_random_yellows_minus"];
        
        if ($row["s_regularity"] == 0.016667) { $row["s_regularity"] = 0; }
            
        $simulationAverageMinutesLocked = $row["s_simulation_average_minutes_locked"];
        $simulationBestCaseMinutesLocked = $row["s_simulation_best_case_minutes_locked"];
        $simulationWorstCaseMinutesLocked = $row["s_simulation_worst_case_minutes_locked"];
        if ($simulationAverageMinutesLocked > $simulationWorstCaseMinutesLocked) { $simulationAverageMinutesLocked = $simulationAverageMinutesLocked / 100; }
                    
        $lock = array(
            'userID' => (int)$userID,
            'username' => $username,
            'discordID' => $discordID,
            'lockName' => $lockName,
            'sharedLockID' => $sharedLockID,
            'sharedLockQRCode' => $sharedLockQRCode,
            'sharedLockURL' => $sharedLockURL,
            'autoResetFrequencyInSeconds' => (integer)$row["s_auto_reset_frequency_in_seconds"],
            'maxAutoResets' => (integer)$row["s_max_auto_resets"],
            'maxDoubleUps' => (integer)$maxDoubleUps,
            'maxFreezes' => (integer)$maxFreezes,
            'maxGreens' => (integer)$maxGreens,
            'maxReds' => (integer)$maxReds,
            'maxResets' => (integer)$maxResets,
            'maxStickies' => (integer)$maxStickies,
            'maxYellows' => (integer)$maxYellows,
            'maxYellowsAdd' => (integer)$maxYellowsAdd,
            'maxYellowsMinus' => (integer)$maxYellowsMinus,
            'minDoubleUps' => (integer)$minDoubleUps,
            'minFreezes' => (integer)$minFreezes,
            'minGreens' => (integer)$minGreens,
            'minReds' => (integer)$minReds,
            'minResets' => (integer)$minResets,
            'minStickies' => (integer)$minStickies,
            'minYellows' => (integer)$minYellows,
            'minYellowsAdd' => (integer)$minYellowsAdd,
            'minYellowsMinus' => (integer)$minYellowsMinus,
            'multipleGreensRequired' => (integer)$row["s_multiple_greens_required"],
            'regularity' => (double)$row["s_regularity"],
            'simulationAverageMinutesLocked' => (integer)$simulationAverageMinutesLocked,
            'simulationBestCaseMinutesLocked' => (integer)$simulationBestCaseMinutesLocked,
            'simulationWorstCaseMinutesLocked' => (integer)$simulationWorstCaseMinutesLocked
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
?>
