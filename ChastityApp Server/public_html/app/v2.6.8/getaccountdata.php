<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select 
            t1.id as u_id, 
            t1.username as u_username,
            t1.avatar_id as u_avatar_id, 
            COALESCE(t2.approved, 0) as a_avatar_approved, 
            t1.banned as u_banned, 
            t1.created as u_date_joined,
            t1.discord_discriminator as u_discord_discriminator, 
            t1.discord_id as u_discord_id, 
            t1.discord_username as u_discord_username, 
            t1.display_in_stats as u_display_in_stats, 
            t1.free_ads_removal_available as u_free_ads_removal_available, 
            t1.free_keys_available as u_free_keys_available, 
            t1.keyholder_level as u_keyholder_level,
            t1.lockee_level as u_lockee_level,
            t1.main_role as u_main_role, 
            t1.no_of_times_review_box_shown as u_no_of_times_review_box_shown, 
            t2.original_file_name as a_original_file_name, 
            t1.private_profile as u_private_profile,
            t1.reason_banned as u_reason_banned, 
            t1.show_combinations_to_keyholders as u_show_combinations_to_keyholders,
            t1.status as u_status,
            t1.twitter_handle as u_twitter_handle
        from (select 
                id, 
                username,
                avatar_id, 
                banned, 
                created,
                discord_discriminator, 
                discord_id, 
                discord_username, 
                display_in_stats, 
                free_ads_removal_available, 
                free_keys_available, 
                keyholder_level,
                lockee_level,
                main_role, 
                no_of_times_review_box_shown, 
                private_profile,
                reason_banned, 
                show_combinations_to_keyholders,
                status,
                twitter_handle
            from UserIDs_V2 where user_id = :userID) t1 
        left join (select id, approved, original_file_name from Avatars) t2 on (t1.avatar_id = t2.id)");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                $id = $row["u_id"];
                $username = $row["u_username"];
                //$adsRemoved = $row["removed_ads"];
                $avatarApproved = $row["a_avatar_approved"];
                $avatarName = $row["a_original_file_name"];
                $banned = $row["u_banned"];
                $dateJoined = $row["u_date_joined"];
                $discordDiscriminator = $row["u_discord_discriminator"];
                $discordID = $row["u_discord_id"];
                $discordUsername = $row["u_discord_username"];
                $freeAdsRemovalAvailable = $row["u_free_ads_removal_available"];
                $freeKeysAvailable = $row["u_free_keys_available"];
                $keyholderLevel = $row["u_keyholder_level"];
                $lockeeLevel = $row["u_lockee_level"];
                $mainRoleSelected = $row["u_main_role"];
                $noOfTimesReviewBoxShown = $row["u_no_of_times_review_box_shown"];
                $privateProfile = $row["u_private_profile"];
                $reasonBanned = $row["u_reason_banned"];
                $showCombinationsToKeyholders = $row["u_show_combinations_to_keyholders"];
                $statusSelected = $row["u_status"];
                $twitterHandle = $row["u_twitter_handle"];
                $visibleInPublicStats = $row["u_display_in_stats"];
                if ($mainRoleSelected == 1) {
                    $query2 = $pdo->prepare("select avg(l.rating) as average_rating, count(l.rating) as number_of_ratings from Locks_V2 as l, ShareableLocks_V2 as s where l.shared_id = s.share_id and s.user_id = :userID and l.rating > 0 and l.fake = 0");
                    $query2->execute(array('userID' => $userID1));
                    foreach ($query2 as $row2) {
                        $averageRating = $row2["average_rating"];
                        $noOfRatings = $row2["number_of_ratings"];
                    }
                } else {
                    $query2 = $pdo->prepare("select avg(rating_from_keyholder) as average_rating, count(rating_from_keyholder) as number_of_ratings from Locks_V2 where user_id = :userID and rating_from_keyholder > 0 and fake = 0");
                    $query2->execute(array('userID' => $userID1));
                    foreach ($query2 as $row2) {
                        $averageRating = $row2["average_rating"];
                        $noOfRatings = $row2["number_of_ratings"];
                    }
                }
                
            }
            array_push($JSON, array('variable' => 'id', 'value' => $id));
            array_push($JSON, array('variable' => 'username', 'value' => $username));
            array_push($JSON, array('variable' => 'avatarApproved', 'value' => $avatarApproved));
            array_push($JSON, array('variable' => 'avatarName', 'value' => $avatarName));
            array_push($JSON, array('variable' => 'averageRating', 'value' => $averageRating));
            array_push($JSON, array('variable' => 'banned', 'value' => $banned));
            array_push($JSON, array('variable' => 'discordDiscriminator', 'value' => $discordDiscriminator));
            array_push($JSON, array('variable' => 'discordID', 'value' => $discordID));
            array_push($JSON, array('variable' => 'discordUsername', 'value' => RemoveEmoji($discordUsername)));
            array_push($JSON, array('variable' => 'freeAdsRemovalAvailable', 'value' => $freeAdsRemovalAvailable));
            array_push($JSON, array('variable' => 'freeKeysAvailable', 'value' => $freeKeysAvailable));
            array_push($JSON, array('variable' => 'mainRoleSelected', 'value' => $mainRoleSelected));
            array_push($JSON, array('variable' => 'noOfRatings', 'value' => $noOfRatings));
            array_push($JSON, array('variable' => 'privateProfile', 'value' => $privateProfile));
            array_push($JSON, array('variable' => 'reasonBanned', 'value' => $reasonBanned));
            array_push($JSON, array('variable' => 'showCombinationsToKeyholders', 'value' => $showCombinationsToKeyholders));
            array_push($JSON, array('variable' => 'statusSelected', 'value' => $statusSelected));
            array_push($JSON, array('variable' => 'timesReviewBoxShown', 'value' => $noOfTimesReviewBoxShown));
            array_push($JSON, array('variable' => 'twitterHandle', 'value' => RemoveEmoji($twitterHandle)));
            array_push($JSON, array('variable' => 'visibleInPublicStats', 'value' => $visibleInPublicStats));
            if ($freeKeysAvailable > 0 || $freeAdsRemovalAvailable > 0) {
                $query = $pdo->prepare("update UserIDs_V2 set free_keys_available = 0, free_ads_removal_available = 0 where user_id = :userID");
                $query->execute(array('userID' => $userID1));
            }
        } else {
            array_push($JSON, array('variable' => 'id', 'value' => '0'));
        }
        echo json_encode($JSON);
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>