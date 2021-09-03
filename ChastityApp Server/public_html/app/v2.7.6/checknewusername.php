<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id from ReservedUsernames_V2 where username = :username");
        $query->execute(array('username' => $_POST['username']));
        if ($query->rowCount() >= 1) {
            echo "Taken";
        } else {
            $query = $pdo->prepare("select id from UserIDs_V2 where username = :username");
            $query->execute(array('username' => $_POST['username']));
            if ($query->rowCount() == 0) {
                echo "Free";
            } else {
                echo "Taken";
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