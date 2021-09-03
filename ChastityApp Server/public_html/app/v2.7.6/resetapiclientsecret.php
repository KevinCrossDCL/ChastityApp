<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $clientSecret = GetToken(32);
        $query = $pdo->prepare("update APIProjects set client_secret = :newClientSecret where client_id = :clientID and client_secret = :clientSecret");
        $result = $query->execute(array('newClientSecret' => $clientSecret, 'clientID' => $_POST['clientID'], 'clientSecret' => $_POST['clientSecret']));
        if ($result) {
            array_push($JSON, array(
                'clientID$' => $_POST['clientID'],
                'clientSecret$' => $clientSecret));
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