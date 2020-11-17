<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $yellowCards = [];
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $id = $row["id"];
                $username = $row["username"];
                if ($username == "") { $username = "CKU".$id; }
            }
        }
        $query = $pdo->prepare("select 
            u.id, 
            u.user_id as u_user_id, 
            u.build_number_installed as u_build_number_installed,
            u.platform as u_platform, 
            u.push_notifications_disabled as u_push_notifications_disabled, 
            u.status as u_status, 
            u.token as u_token, 
            s.user_id, 
            s.share_id, 
            l.id as l_id, 
            l.user_id, 
            l.lock_id,
            l.shared_id
        from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l 
        where s.share_id = :sharedID and 
            s.user_id = :userID and 
            s.share_id = l.shared_id and 
            l.lock_id = :lockID and 
            l.user_id = u.user_id and 
            u.id = :sharedUserID and 
            l.deleted = 0");
        $query->execute(array('sharedID' => $_POST['sharedID'], 'userID' => $userID1, 'lockID' => $_POST['lockID'], 'sharedUserID' => $_POST['sharedUserID']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $lockID = $row["l_id"];
                $lockedUserID = $row["u_user_id"];
                $lockedUserBuildNumberInstalled = $row["u_build_number_installed"];
                $lockedUserPlatform = $row["u_platform"];
                $lockedUserPushNotificationsDisabled = $row["u_push_notifications_disabled"];
                $lockedUserStatus = $row["u_status"];
                $lockedUserToken = $row["u_token"];
            }

            $query2 = $pdo->prepare("update Locks_V2 set 
                removed_by_keyholder = :removedByKeyholder,
                timestamp_removed_by_keyholder = :timestampRemovedByKeyholder
            where user_id = :lockedUserID and shared_id = :sharedID and lock_id = :lockID");
            $query2->execute(array(
                'lockedUserID' => $lockedUserID, 
                'lockID' => $_POST['lockID'],
                'sharedID' => $_POST['sharedID'], 
                'removedByKeyholder' => 1,
                'timestampRemovedByKeyholder' => $_POST['timestampModified']));
        } else {
            echo "Shared Lock And User Match Failed";
        }
    }
    $query = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>