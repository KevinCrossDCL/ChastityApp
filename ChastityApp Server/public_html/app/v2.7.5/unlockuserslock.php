<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
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
            u.status as u_status, 
            u.platform as u_platform, 
            u.push_notifications_disabled as u_push_notifications_disabled, 
            u.token as u_token, 
            u.build_number_installed as u_build_number_installed,
            s.share_id, 
            s.user_id, 
            l.id as l_id, 
            l.user_id, 
            l.build as l_build,
            l.lock_group_id as l_lock_group_id,
            l.lock_id,
            l.shared_id from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l where s.share_id = :sharedID and s.user_id = :userID and s.share_id = l.shared_id and l.lock_id = :lockID and l.user_id = u.user_id and u.id = :sharedUserID and l.deleted = 0");
        $query->execute(array('sharedID' => $_POST['sharedID'], 'userID' => $userID1, 'lockID' => $_POST['lockID'], 'sharedUserID' => $_POST['sharedUserID']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $groupID = $row["l_lock_group_id"];
                $lockID = $row["l_id"];
                $lockBuild = $row["l_build"];
                $lockedUserID = $row["u_user_id"];
                $lockedUserStatus = $row["u_status"];
                $lockedUserPlatform = $row["u_platform"];
                $lockedUserPushNotificationsDisabled = $row["u_push_notifications_disabled"];
                $lockedUserToken = $row["u_token"];
                $lockedUserBuildNumberInstalled = $row["u_build_number_installed"];
            }
            $timestampUnlocked = $_POST['timestampModified'];
            $dateUnlocked = date("d/m/Y");
            $lockedUserReadyToUnlock = 0;
            $query2 = $pdo->prepare("insert into ModifiedLocks_V2 (
                id, 
                user_id, 
                shared_id, 
                lock_id, 
                lock_frozen_modified_by,
                timestamp_modified,
                unlocked) values (
                    '', 
                    :lockedUserID, 
                    :sharedID, 
                    :lockID, 
                    :lockFrozenByKeyholderModifiedBy,
                    :timestampModified,
                    :unlocked)");
            $query2->execute(array(
                'lockedUserID' => $lockedUserID, 
                'sharedID' => $_POST['sharedID'], 
                'lockID' => $lockID, 
                'lockFrozenByKeyholderModifiedBy' => $_POST['lockFrozenByKeyholderModifiedBy'],
                'timestampModified' => $_POST['timestampModified'],
                'unlocked' => $_POST['unlocked']));
            $query2 = $pdo->prepare("update Locks_V2 set 
                ready_to_unlock = :readyToUnlock,
                unlocked = :unlocked, 
                timestamp_unlocked = :timestampUnlocked, 
                date_unlocked = :dateUnlocked where user_id = :lockedUserID and shared_id = :sharedID and lock_id = :lockID");
            $query2->execute(array(
                'readyToUnlock' => $lockedUserReadyToUnlock,
                'unlocked' => $_POST['unlocked'], 
                'timestampUnlocked' => $timestampUnlocked,
                'dateUnlocked' => $dateUnlocked,
                'lockedUserID' => $lockedUserID, 
                'sharedID' => $_POST['sharedID'], 
                'lockID' => $_POST['lockID']));
            
            if ($_POST['logAction'] != "") {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
            }
            
            if ($lockedUserPushNotificationsDisabled != 1 && $lockedUserToken != "" && $lockedUserStatus != 3) {
                if ($username != "") {
                    if ($lockedUserPlatform == "android") {
                        if ($lockedUserBuildNumberInstalled < 115) {
                            SendPushNotificationAndroid($lockedUserToken, $username." has just updated your lock.", $appName);
                        } else {
                            SendPushNotificationAndroidFCM($lockedUserToken, $username." has just updated your lock.");
                        }
                    }
                    if ($lockedUserPlatform == "ios") {
                        SendPushNotificationiOS($lockedUserToken, $username." has just updated your lock.");
                    }
                } else {
                    if ($lockedUserPlatform == "android") {
                        if ($lockedUserBuildNumberInstalled < 115) {
                            SendPushNotificationAndroid($lockedUserToken, "Your keyholder has just updated your lock.", $appName);
                        } else {
                            SendPushNotificationAndroidFCM($lockedUserToken, "Your keyholder has just updated your lock.");
                        }
                    }
                    if ($lockedUserPlatform == "ios") {
                        SendPushNotificationiOS($lockedUserToken, "Your keyholder has just updated your lock.");
                    }
                }
            }
            
            if ($lockBuild <= 194) {
                $apiLockID = $lockGroupID;
            } else {
                if ($lockGroupID != $_POST['lockID']) {
                    $apiLockID = $lockGroupID.sprintf("%02d", ($_POST['lockID'] - $lockGroupID));
                } else {
                    $apiLockID = $lockGroupID."01";
                }
            }
            $query = $pdo->prepare("insert into RecentActivity (
                id, 
                user_id, 
                activity_type,
                lock_id,
                mentioned_user_id,
                share_id,
                timestamp_added) values (
                    '', 
                    :userID, 
                    :activityType, 
                    :lockID,
                    :mentionedUserID, 
                    :shareID,
                    :timestampAdded)");
            $query->execute(array(
                'userID' => $lockedUserID, 
                'activityType' => "KeyholderUnlockedLock",
                'lockID' => $apiLockID,
                'mentionedUserID' => $id, 
                'shareID' => $_POST['sharedID'],
                'timestampAdded' => time()));
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