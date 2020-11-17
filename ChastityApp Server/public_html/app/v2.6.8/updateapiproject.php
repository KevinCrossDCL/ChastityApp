<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("update APIProjects set 
            bot = :bot, 
            desktop_app = :desktopApp, 
            dont_know = :dontKnow, 
            lockbox = :lockBox, 
            name = :name, 
            mobile_app = :mobileApp, 
            something_else = :somethingElse,
            website = :website
        where user_id = :userID and client_id = :clientID and client_secret = :clientSecret");
        $result = $query->execute(array(
            'userID' => $userID1, 
            'clientID' => $_POST['clientID'], 
            'clientSecret' => $_POST['clientSecret'],
            'bot' => $_POST['bot'],
            'desktopApp' => $_POST['desktopApp'],
            'dontKnow' => $_POST['dontKnow'],
            'lockBox' => $_POST['lockBox'],
            'mobileApp' => $_POST['mobileApp'],
            'name' => $_POST['name'],
            'somethingElse' => $_POST['somethingElse'],
            'website' => $_POST['website']));
        if ($result) {
            echo "Successfully Updated";
        } else {
            echo "Not Updated";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>