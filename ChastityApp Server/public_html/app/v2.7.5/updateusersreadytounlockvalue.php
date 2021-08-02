<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query1 = $pdo->prepare("select u.user_id as u_user_id from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l where s.share_id = :sharedID and s.user_id = :userID and s.share_id = l.shared_id and l.id = :lockID and l.user_id = u.user_id and u.id = :sharedUserID and l.deleted = 0");
        $query1->execute(array('sharedID' => $_POST['sharedID'], 'userID' => $userID1, 'lockID' => $_POST['lockID'], 'sharedUserID' => $_POST['sharedUserID']));
        if ($query1->rowCount() == 1) {
            foreach ($query1 as $row1) {
                $lockedUserID = $row1["u_user_id"];
            }
        }
        $query2 = $pdo->prepare("update Locks_V2 set ready_to_unlock = :readyToUnlock where user_id = :lockedUserID and shared_id = :sharedID and id = :lockID");
        $query2->execute(array('lockedUserID' => $lockedUserID, 'sharedID' => $_POST['sharedID'], 'lockID' => $_POST['lockID'], 'readyToUnlock' => $_POST['readyToUnlock']));
    }
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>