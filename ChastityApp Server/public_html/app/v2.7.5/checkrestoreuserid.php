<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($restoreUserID1 == $restoreUserID2) {
        $query = $pdo->prepare("select id from UserIDs_V2 where user_id = :restoreUserID");
        $query->execute(array('restoreUserID' => $restoreUserID1));
        if ($query->rowCount() == 1) {
            echo "Exists";
        } else {
            echo "Invalid";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>