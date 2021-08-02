<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";

    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 0) {
            echo "New";
        } else {
            echo "Used";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>