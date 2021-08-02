<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id, user_id, username from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $id = $row["id"];
                $username = $row["username"];
                if ($username == "") { $username = "CKU".$id; }
            }
        }
        $query = $pdo->prepare("select u.user_id as u_user_id, u.platform as u_platform, u.status as u_status, u.push_notifications_disabled as u_push_notifications_disabled, u.token as u_token, u.build_number_installed as u_build_number_installed, s.share_id, s.user_id, s.name as s_name, s.hide_from_owner from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :shareID and s.user_id = u.user_id and s.hide_from_owner = 0");
        $query->execute(array('shareID' => $_POST['sharedID']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $lockName = $row["s_name"];
                $userID = $row["u_user_id"];
                $platform = $row["u_platform"];
                $status = $row["u_status"];
                $pushNotificationsDisabled = $row["u_push_notifications_disabled"];
                $token = $row["u_token"];
                $buildNumberInstalled = $row["u_build_number_installed"];
            }
            if ($pushNotificationsDisabled != 1 && $token != "" && $status != 3) {
                if ($username != "") {
                    if ($platform == "android") {
                        if ($buildNumberInstalled < 115) {
                            if ($_POST['messageType'] == "LoadedSharedLock") {
                                if ($lockName == "") { SendPushNotificationAndroid($token, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                if ($lockName != "") { SendPushNotificationAndroid($token, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName, $appName); }
                            }
                            if ($_POST['messageType'] == "RequestKeyholdersDecision") {
                                if ($lockName == "") { SendPushNotificationAndroid($token, $username." wants you to decide if they should unlock or restart. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                if ($lockName != "") { SendPushNotificationAndroid($token, $username." wants you to decide if they should unlock or restart. Shared Lock Name: ".$lockName, $appName); }
                            }
                        } else {
                            if ($_POST['messageType'] == "LoadedSharedLock") { 
                                if ($lockName == "") { SendPushNotificationAndroidFCM($token, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                                if ($lockName != "") { SendPushNotificationAndroidFCM($token, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                            }
                            if ($_POST['messageType'] == "RequestKeyholdersDecision") {
                                if ($lockName == "") { SendPushNotificationAndroidFCM($token, $username." wants you to decide if they should unlock or restart. Shared Lock ID: ".$_POST['sharedID']); }
                                if ($lockName != "") { SendPushNotificationAndroidFCM($token, $username." wants you to decide if they should unlock or restart. Shared Lock Name: ".$lockName); }
                            }
                        }
                    }
                    if ($platform == "ios") {
                        if ($_POST['messageType'] == "LoadedSharedLock") {
                            if ($lockName == "") { SendPushNotificationiOS($token, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                            if ($lockName != "") { SendPushNotificationiOS($token, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                        }
                        if ($_POST['messageType'] == "RequestKeyholdersDecision") {
                            if ($lockName == "") { SendPushNotificationiOS($token, $username." wants you to decide if they should unlock or restart. Shared Lock ID: ".$_POST['sharedID']); }
                            if ($lockName != "") { SendPushNotificationiOS($token, $username." wants you to decide if they should unlock or restart. Shared Lock Name: ".$lockName); }
                        }
                    }
                }
            }
            
            if ($_POST['messageType'] == "LoadedSharedLock") {
                $query = $pdo->prepare("insert into RecentActivity (
                    id, 
                    user_id, 
                    activity_type,
                    mentioned_user_id,
                    share_id,
                    timestamp_added) values (
                        '', 
                        :userID, 
                        :activityType, 
                        :mentionedUserID, 
                        :shareID,
                        :timestampAdded)");
                $query->execute(array(
                    'userID' => $userID, 
                    'activityType' => "LoadedSharedLock",
                    'mentionedUserID' => $id, 
                    'shareID' => $_POST['sharedID'],
                    'timestampAdded' => time()));
            }
            if ($_POST['messageType'] == "RequestKeyholdersDecision") {
                $query = $pdo->prepare("insert into RecentActivity (
                    id, 
                    user_id, 
                    activity_type,
                    mentioned_user_id,
                    share_id,
                    timestamp_added) values (
                        '', 
                        :userID, 
                        :activityType, 
                        :mentionedUserID, 
                        :shareID,
                        :timestampAdded)");
                $query->execute(array(
                    'userID' => $userID, 
                    'activityType' => "RequestKeyholdersDecision",
                    'mentionedUserID' => $id, 
                    'shareID' => $_POST['sharedID'],
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