<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        if ($_POST['deleteAPIProject'] == "1") {
            $query = $pdo->prepare("update APIProjects set deleted = 1, timestamp_deleted = :timestampDeleted where user_id = :userID and client_id = :clientID and client_secret = :clientSecret");
            $result = $query->execute(array(
                'userID' => $userID1, 
                'clientID' => $_POST['clientID'], 
                'clientSecret' => $_POST['clientSecret'],
                'timestampDeleted' => time()));
            if ($result) {
                echo "Successfully Deleted";
            } else {
                echo "Not Deleted";
            }
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>