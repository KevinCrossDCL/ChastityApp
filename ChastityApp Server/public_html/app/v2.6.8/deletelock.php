<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        if ($_POST['deleteLock'] == "1") {
            $query = $pdo->prepare("update Locks_V2 set 
                date_deleted = :dateDeleted,
                deleted = 1, 
                timestamp_deleted = :timestampDeleted 
            where user_id = :userID and lock_id = :lockID");
            $query->execute(array(
                'userID' => $userID1, 
                'lockID' => $_POST['lockID'], 
                'timestampDeleted' => $_POST['timestampDeleted'], 
                'dateDeleted' => $_POST['dateDeleted']));
            $query = $pdo->prepare("select id from Locks_V2 where 
                lock_id = :lockID and 
                user_id = :userID and 
                date_deleted = :dateDeleted and 
                deleted = 1 and 
                timestamp_deleted = :timestampDeleted");
            $query->execute(array(
                'userID' => $userID1, 
                'lockID' => $_POST['lockID'], 
                'timestampDeleted' => $_POST['timestampDeleted'], 
                'dateDeleted' => $_POST['dateDeleted']));
            if ($query->rowCount() == 1) {
                echo "Successfully Deleted";
                $query = $pdo->prepare("insert into Locks_Log (
                    id, 
                    lock_id, 
                    user_id, 
                    action, 
                    actioned_by, 
                    result, 
                    timestamp, 
                    total_action_time,
                    private
                ) values (
                    '', 
                    :lockID, 
                    :userID, 
                    :action, 
                    :actionedBy, 
                    :result, 
                    :timestamp, 
                    :totalActionTime,
                    :private)");
                $query->execute(array(
                    'lockID' => $_POST['lockID'], 
                    'userID' => $userID1, 
                    'action' => 'DeletedLock', 
                    'actionedBy' => 'Lockee', 
                    'result' => '', 
                    'timestamp' => $_POST['timestampDeleted'], 
                    'totalActionTime' => 0,
                    'private' => 0));
                    
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