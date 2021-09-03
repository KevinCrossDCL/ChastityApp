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
        if ($_POST['abandonedLock'] == "1") {
            $query = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
            $query->execute(array('userID' => $userID1));
            if ($query->rowCount() == 1) {
                foreach ($query as $row) {
                    $id = $row["id"];
                    $username = $row["username"];
                }
            }
            $query = $pdo->prepare("select u.id, u.user_id as u_user_id, u.platform as u_platform, u.push_notifications_disabled as u_push_notifications_disabled, u.status as u_status, u.token as u_token, u.build_number_installed as u_build_number_installed, s.name as s_name, s.share_id as s_share_id, s.user_id from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :sharedID and s.user_id = u.user_id and s.hide_from_owner = 0");
            $query->execute(array('sharedID' => $_POST['sharedID']));
            if ($query->rowCount() == 1) {
                foreach ($query as $row) {
                    $lockName = $row["s_name"];
                    $keyholderUserID = $row["u_user_id"];
                    $keyholderPlatform = $row["u_platform"];
                    $keyholderPushNotificationsDisabled = $row["u_push_notifications_disabled"];
                    $keyholderStatus = $row["u_status"];
                    $keyholderToken = $row["u_token"];
                    $keyholderBuildNumberInstalled = $row["u_build_number_installed"];
                    if ($userID1 != $keyholderUserID && $keyholderPushNotificationsDisabled != "1" && $keyholderToken != "" && $keyholderStatus != 3) {
                        if ($username != "") {
                            if ($keyholderPlatform == "android") {
                                if ($keyholderBuildNumberInstalled < 115) {
                                    if ($lockName == "") { SendPushNotificationAndroid($keyholderToken, $username." has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                    if ($lockName != "") { SendPushNotificationAndroid($keyholderToken, $username." has just abandoned your lock. Shared Lock Name: ".$lockName, $appName); }
                                } else {
                                    if ($lockName == "") { SendPushNotificationAndroidFCM($keyholderToken, $username." has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID']); }
                                    if ($lockName != "") { SendPushNotificationAndroidFCM($keyholderToken, $username." has just abandoned your lock. Shared Lock Name: ".$lockName); }
                                }
                            }
                            if ($keyholderPlatform == "ios") {
                                if ($lockName == "") { SendPushNotificationiOS($keyholderToken, $username." has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID']); }
                                if ($lockName != "") { SendPushNotificationiOS($keyholderToken, $username." has just abandoned your lock. Shared Lock Name: ".$lockName); }
                            }
                        } else {
                            if ($keyholderPlatform == "android") {
                                if ($keyholderBuildNumberInstalled < 115) {
                                    if ($lockName == "") { SendPushNotificationAndroid($keyholderToken, "A user has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                    if ($lockName != "") { SendPushNotificationAndroid($keyholderToken, "A user has just abandoned your lock. Shared Lock Name: ".$lockName, $appName); }
                                } else {
                                    if ($lockName == "") { SendPushNotificationAndroidFCM($keyholderToken, "A user has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID']); }
                                    if ($lockName != "") { SendPushNotificationAndroidFCM($keyholderToken, "A user has just abandoned your lock. Shared Lock Name: ".$lockName); }
                                }
                            }
                            if ($keyholderPlatform == "ios") {
                                if ($lockName == "") { SendPushNotificationiOS($keyholderToken, "A user has just abandoned your lock. Shared Lock ID: ".$_POST['sharedID']); }
                                if ($lockName != "") { SendPushNotificationiOS($keyholderToken, "A user has just abandoned your lock. Shared Lock Name: ".$lockName); }
                            }
                        }
                    }
                }
            }
            if ($userID1 != $keyholderUserID) {
                $query = $pdo->prepare("insert into RecentActivity (
                    id, 
                    user_id, 
                    activity_type,
                    lock_id,
                    mentioned_user_id,
                    share_id,
                    test_lock,
                    timestamp_added) values (
                        '', 
                        :userID, 
                        :activityType,
                        :lockID,
                        :mentionedUserID, 
                        :shareID,
                        :testLock,
                        :timestampAdded)");
                $query->execute(array(
                    'userID' => $keyholderUserID, 
                    'activityType' => "LockeeAbandonedLock",
                    'lockID' => 0,
                    'mentionedUserID' => $id, 
                    'shareID' => $_POST['sharedID'],
                    'testLock' => $_POST['test'],
                    'timestampAdded' => time()));
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