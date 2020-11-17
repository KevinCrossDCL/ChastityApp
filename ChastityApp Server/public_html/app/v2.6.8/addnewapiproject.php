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
            tokens_per_minute,
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
            :tokensPerMinute,
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
            'tokensPerMinutes' => 60,
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
                'tokensPerMinute' => $_POST['tokensPerMinute'],
                'website' => $_POST['website']));
        }
        echo json_encode($JSON);
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>