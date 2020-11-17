<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
        
    $followBackCount = 0;
    $query = $pdo->prepare("select 
        t1.user_one_id as t1_user_one_id,
        t1.user_two_id as t2_user_two_id
    from Relations t1 
        left join Relations t2 on (t1.user_two_id = t2.user_one_id and t1.user_one_id = t2.user_two_id)
    where ((t1.user_two_id >= 3948 and t1.user_two_id <= 3951) or (t2.user_one_id >= 3948 and t2.user_one_id <= 3951)) and t1.status = 1 and t2.status is null");
    $query->execute();
    if ($query->rowCount() > 0) {
        foreach ($query as $row) {
            $userOneID = $row["t1_user_one_id"];
            $userTwoID = $row["t2_user_two_id"];
            if ($userTwoID == 3948) { $botName = "Hailey"; }
            if ($userTwoID == 3949) { $botName = "Blaine"; }
            if ($userTwoID == 3950) { $botName = "Zoe"; }
            if ($userTwoID == 3951) { $botName = "Chase"; }
            $chanceRoll = mt_rand(1, 1000000);
            if ($chanceRoll <= 300000) {
                $followBackCount = $followBackCount + 1;
                $query2 = $pdo->prepare("insert into Relations (
                    id, 
                    user_one_id, 
                    user_two_id, 
                    status
                ) values (
                    '', 
                    :userOneID,
                    :userTwoID,
                    :status)");
                $query2->execute(array(
                    'userOneID' => $userTwoID, 
                    'userTwoID' => $userOneID, 
                    'status' => 1));
                $query2 = $pdo->prepare("select 
                    platform,
                    push_notifications_disabled,
                    status,
                    token
                from UserIDs_V2 where
                    id = :userOneID");
                $query2->execute(array('userOneID' => $userOneID));
                if ($query2->rowCount() == 1) {
                    foreach ($query2 as $row2) {
                        $platform = $row2["platform"];
                        $pushNotificationsDisabled = $row2["push_notifications_disabled"];
                        $status = $row2["status"];
                        $token = $row2["token"];
                        if ($pushNotificationsDisabled != 1 && $token != "" && $status != 3) {
                            if ($platform == "android") {
                                SendPushNotificationAndroidFCM($token, $botName." is now following you.");
                            }
                            if ($platform == "ios") {
                                SendPushNotificationiOS($token, $botName." is now following you.");
                            }
                        }
                    }
                }
            }
        }
    }
    echo "Followed back ".$followBackCount." out of ".$query->rowCount();
    
    $query = null;
    $query1 = null;
    $query2 = null;
    $query3 = null;
    $pdo = null;
    
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>