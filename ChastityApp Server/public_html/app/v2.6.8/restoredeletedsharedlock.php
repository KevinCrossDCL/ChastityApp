<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("update ShareableLocks_V2 set 
            hide_from_owner = 0,
            timestamp_hidden = 0
        where user_id = :userID and share_id = :shareID");
        $query->execute(array(
            'userID' => $userID1,
            'shareID' => $_POST['shareID']));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>