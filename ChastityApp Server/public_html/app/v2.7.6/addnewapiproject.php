<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        do {
            $clientID = GetToken(32);
            $clientSecret = GetToken(32);
            $query = $pdo->prepare("select id from APIProjects where client_id = :clientID");
            $query->execute(array('clientID' => $clientID));
        } while($query->rowCount() > 0);
        $query = $pdo->prepare("insert into APIProjects (
            id,
            user_id,
            name,
            client_id,
            client_secret,
            bot,
            desktop_app,
            dont_know,
            lockbox,
            mobile_app,
            something_else,
            website
        ) values (
            '',
            :userID,
            :name,
            :clientID,
            :clientSecret,
            :bot,
            :desktopApp,
            :dontKnow,
            :lockBox,
            :mobileApp,
            :somethingElse,
            :website)");
        $result = $query->execute(array(
            'userID' => $userID1,
            'name' => $_POST['name'],
            'clientID' => $clientID,
            'clientSecret' => $clientSecret,
            'bot' => $_POST['bot'],
            'desktopApp' => $_POST['desktopApp'],
            'dontKnow' => $_POST['dontKnow'],
            'lockBox' => $_POST['lockBox'],
            'mobileApp' => $_POST['mobileApp'],
            'somethingElse' => $_POST['somethingElse'],
            'website' => $_POST['website']));
        if ($result) {
            array_push($JSON, array(
                'name$' => $_POST['name'],
                'clientID$' => $clientID,
                'clientSecret$' => $clientSecret,
                'bot' => $_POST['bot'],
                'desktopApp' => $_POST['desktopApp'],
                'dontKnow' => $_POST['dontKnow'],
                'lockBox' => $_POST['lockBox'],
                'mobileApp' => $_POST['mobileApp'],
                'somethingElse' => $_POST['somethingElse'],
                'website' => $_POST['website']));
        }
        echo json_encode($JSON);
        
        // CREATE API.JSON FILE
        $apiUsers["client_".$clientID] = array();
        $apiUsers["client_".$clientID][0]["lastCalled"] = 0;
        $apiUsers["client_".$clientID][0]["tokens"] = 60;
        $apiUsers["client_".$clientID][0]["tokensPerMinute"] = 60;
        $apiUsers["client_".$clientID][0]["totalRequestsMade"] = 0;
        file_put_contents("../../../includes/apiprojects/client_".$clientID.".json", json_encode($apiUsers, JSON_PRETTY_PRINT));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>