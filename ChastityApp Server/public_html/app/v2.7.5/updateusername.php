<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        if (strlen($_POST['username']) == 0) {
            // DO NOTHING FOR NOW
        } elseif (strlen($_POST['username']) < 4) {
            // DO NOTHING FOR NOW
        } elseif (strlen($_POST['username']) > 15) {
            // DO NOTHING FOR NOW
        } elseif (preg_match("/[^A-Za-z0-9]/", $_POST['username'])) {
            // DO NOTHING FOR NOW
        } else {
            $query = $pdo->prepare("select id from ReservedUsernames_V2 where username = :username");
            $query->execute(array('username' => $_POST['username']));
            if ($query->rowCount() >= 1) {
                // DO NOTHING FOR NOW
            } else {
                $query = $pdo->prepare("select id from UserIDs_V2 where username = :username");
                $query->execute(array('username' => $_POST['username']));
                if ($query->rowCount() >= 1) {
                    // DO NOTHING FOR NOW
                } else {
                    $query = $pdo->prepare("update UserIDs_V2 set username = :username where user_id = :userID");
                    $query->execute(array('username' => $_POST['username'], 'userID' => $userID1));
                }
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