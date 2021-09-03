<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query1 = $pdo->prepare("select u.user_id as u_user_id from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l where s.share_id = :sharedID and s.user_id = :userID and s.share_id = l.shared_id and l.lock_id = :lockID and l.user_id = u.user_id and u.id = :sharedUserID");
        $query1->execute(array('sharedID' => $_POST['sharedID'], 'userID' => $userID1, 'lockID' => $_POST['lockID'], 'sharedUserID' => $_POST['sharedUserID']));
        if ($query1->rowCount() == 1) {
            foreach ($query1 as $row1) {
                $lockedUserID = $row1["u_user_id"];
            }
            $query2 = $pdo->prepare("update Locks_V2 set rating_from_keyholder = :ratingFromKeyholder, timestamp_keyholder_rated = :timestampKeyholderRated where user_id = :lockedUserID and shared_id = :sharedID and lock_id = :lockID");
            $result = $query2->execute(array('lockedUserID' => $lockedUserID, 'sharedID' => $_POST['sharedID'], 'lockID' => $_POST['lockID'], 'ratingFromKeyholder' => $_POST['ratingFromKeyholder'], 'timestampKeyholderRated' => $_POST['timestampKeyholderRated']));
            
            if ($result == 1) { echo "Successfully Updated"; }
            
            if ($_POST['logAction'] != "") {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
            }
        }
    }
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>