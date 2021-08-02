<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    $username = "";
    // Status 0 = Pending, 1 = Accepted, 2 = Declined, 3 = Blocked
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $userOneID = $row["id"];
                $userOneUsername = $row["username"];
            }
        }
        $userTwoID = $_POST['profileID'];
        $query = $pdo->prepare("select platform, private_profile, push_notifications_disabled, status, token, user_id from UserIDs_V2 where id = :id");
        $query->execute(array('id' => $userTwoID));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $userTwoPlatform = $row["platform"];
                $userTwoPrivateProfile = $row["private_profile"];
                $userTwoPushNotificationsDisabled = $row["push_notifications_disabled"];
                $userTwoStatus = $row["status"];
                $userTwoToken = $row["token"];
                $userTwoUserID = $row["user_id"];
            }
        }
        $query = $pdo->prepare("select id, status from Relations where user_one_id = :userTwoID and user_two_id = :userOneID and status = 3");
        $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID));
        if ($query->rowCount() == 1 || $userTwoPrivateProfile == 1) {
            $status = 0;
        } else {
            $status = 1;
        }
        $userOneIDBlocked = 0;
        $query = $pdo->prepare("select t2.id as u_id from (select id, device_id from UserIDs_V2 where user_id = :userID) t1 left join (select id, device_id from UserIDs_V2) t2 on (t1.device_id = t2.device_id)");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() >= 1) {
            foreach ($query as $row) {
                $otherUserOneID = (int)$row["u_id"];
                $query2 = $pdo->prepare("select id from Relations where user_one_id = :userTwoID and user_two_id = :userOneID and status = 3");
                $query2->execute(array('userOneID' => $otherUserOneID, 'userTwoID' => $userTwoID));
                if ($query2->rowCount() == 1) {
                    $userOneIDBlocked = 1;
                    break;
                }
            }
        }
        if ($userOneIDBlocked == 1) { $status = 2; }
        $query = $pdo->prepare("select id, status from Relations where user_one_id = :userOneID and user_two_id = :userTwoID");
        $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID));
        if ($query->rowCount() == 0) {
            $query = $pdo->prepare("insert into Relations (id, user_one_id, user_two_id, status) values ('', :userOneID, :userTwoID, :status)");
            $result = $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID, 'status' => $status));
            if ($result == 1 && ($status == 0 || $status == 2)) { echo "Request Sent Successfully"; }
            if ($result == 1 && $status == 1) { echo "Successfully Following"; }
            
            if ($userTwoPushNotificationsDisabled != 1 && $userTwoToken != "" && $userTwoStatus != 3 && ($status == 0 || $status == 1)) {
                if ($status == 0) { $notificationMessage = $userOneUsername." has requested to follow you"; }
                if ($status == 1) { $notificationMessage = $userOneUsername." is now following you"; }
                if ($userTwoPlatform == "android") {
                    SendPushNotificationAndroidFCM($userTwoToken, $notificationMessage, false);
                }
                if ($userTwoPlatform == "ios") {
                    SendPushNotificationiOS($userTwoToken, $notificationMessage, false);
                }
            }
            
            if ($status == 0) {
                $query = $pdo->prepare("insert into RecentActivity (
                    id, 
                    user_id, 
                    activity_type,
                    mentioned_user_id,
                    timestamp_added) values (
                        '', 
                        :userID, 
                        :activityType, 
                        :mentionedUserID, 
                        :timestampAdded)");
                $query->execute(array(
                    'userID' => $userTwoUserID, 
                    'activityType' => "NewFollowRequest",
                    'mentionedUserID' => $userOneID, 
                    'timestampAdded' => time()));
            }
            if ($status == 1) {
                $query = $pdo->prepare("insert into RecentActivity (
                    id, 
                    user_id, 
                    activity_type,
                    mentioned_user_id,
                    timestamp_added) values (
                        '', 
                        :userID, 
                        :activityType, 
                        :mentionedUserID, 
                        :timestampAdded)");
                $query->execute(array(
                    'userID' => $userTwoUserID, 
                    'activityType' => "NewFollow",
                    'mentionedUserID' => $userOneID, 
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