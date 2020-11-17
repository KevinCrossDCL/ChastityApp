<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        if ($_POST['version'] != "") { $versionNumber = $_POST['version']; }
        $query = $pdo->prepare("update UserIDs_V2 set 
            build_number_installed = :buildNumberInstalled, 
            display_in_stats = :displayInStats,
            device_id = :deviceID,
            last_active = NOW(), 
            main_role = :mainRole,
            no_of_keys = :noOfKeys,
            no_of_keys_purchased = :noOfKeysPurchased,
            no_of_times_review_box_shown = :noOfTimesReviewBoxShown,
            platform = :platform, 
            push_notifications_disabled = :pushNotificationsDisabled,
            private_profile = :privateProfile,
            removed_ads = :removedAds,
            requests = requests + 1, 
            show_combinations_to_keyholders = :showCombinationsToKeyholders,
            status = :status,
            timestamp_last_active = :timestampLastActive,
            token = :pushNotificationToken,
            version_installed = :versionNumber where user_id = :userID");
        $result = $query->execute(array(
            'userID' => $userID1,
            'buildNumberInstalled' => $_POST['build'], 
            'deviceID' => $_POST['deviceID'],
            'displayInStats' => $_POST['visibleInPublicStats'],
            'mainRole' => $_POST['mainRole'],
            'noOfKeys' => $_POST['noOfKeys'],
            'noOfKeysPurchased' => $_POST['noOfKeysPurchased'],
            'noOfTimesReviewBoxShown' => $_POST['noOfTimesReviewBoxShown'],
            'platform' => $_POST['platform'], 
            'pushNotificationsDisabled' => $_POST['notificationsDisabled'],
            'pushNotificationToken' => str_replace("[colon]", ":", $_POST['pushNotificationToken']),
            'privateProfile' => $_POST['privateProfile'],
            'removedAds' => $_POST['adsRemoved'],
            'showCombinationsToKeyholders' => $_POST['showCombinationsToKeyholders'],
            'status' => $_POST['status'],
            'timestampLastActive' => time(), 
            'versionNumber' => $versionNumber));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>