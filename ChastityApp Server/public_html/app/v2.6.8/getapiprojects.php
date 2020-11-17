<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $locksData = "";
    $lockCount = 0;
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query1 = $pdo->prepare("select
            id,
            name,
            client_id,
            client_secret,
            banned,
            bot,
            deleted,
            desktop_app,
            dont_know,
            lockbox,
            mobile_app,
            something_else,
            tokens,
            tokens_per_minute,
            total_requests_made,
            website
        from APIProjects where user_id = :userID and deleted = 0");
        $query1->execute(array('userID' => $userID1));
        foreach ($query1 as $row1) {
            $clientID = $row1["client_id"];
            $resetsIn = 60 - (time() % 60);
            array_push($JSON, array(
                'clientID$' => $row1["client_id"],
                'clientSecret$' => $row1["client_secret"],
                'banned' => (int)$row1["banned"],
                'bot' => (int)$row1["bot"],
                'desktopApp' => (int)$row1["desktop_app"],
                'dontKnow' => (int)$row1["dont_know"],
                'lastCalled' => (int)$lastCalled,
                'lockBox' => (int)$row1["lockbox"],
                'mobileApp' => (int)$row1["mobile_app"],
                'name$' => $row1["name"],
                'resetsIn' => (int)$resetsIn,
                'somethingElse' => (int)$row1["something_else"],
                'tokens' => (int)$row1["tokens"],
                'tokensPerMinute' => (int)$row1["tokens_per_minute"],
                'totalRequestsMade' => (int)$row1["total_requests_made"],
                'website' => (int)$row1["website"]));
        }
        echo json_encode($JSON);
    } else {
        echo "Invalid Request";
    }
    $query = null;
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>