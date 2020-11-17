<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select 
            t1.id as u_id,
            t1.user_id as u_user_id,
            t1.username as u_username,
            t1.avatar_id as u_avatar_id, 
            COALESCE(t2.approved, 0) as a_avatar_approved, 
            t1.banned as u_banned, 
            t1.discord_discriminator as u_discord_discriminator, 
            t1.discord_id as u_discord_id, 
            t1.discord_username as u_discord_username, 
            t1.display_in_stats as u_display_in_stats, 
            t1.keyholder_level as u_original_keyholder_level,
            t1.lockee_level as u_original_lockee_level,
            t1.main_role as u_main_role, 
            t2.original_file_name as a_original_file_name, 
            t1.private_profile as u_private_profile,
            t1.status as u_status,
            t1.timestamp_last_active as u_timestamp_last_active,
            t1.twitter_handle as u_twitter_handle
        from (select 
                id,
                user_id,
                username,
                avatar_id, 
                banned, 
                discord_discriminator, 
                discord_id, 
                discord_username, 
                display_in_stats, 
                keyholder_level,
                lockee_level,
                main_role, 
                private_profile,
                status,
                timestamp_last_active,
                twitter_handle
            from UserIDs_V2 where id = :profileID) t1 
        left join (select id, approved, original_file_name from Avatars) t2 on (t1.avatar_id = t2.id)");
        $query->execute(array('profileID' => $_POST["profileID"]));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $id = $row["u_id"];
                $userID = $row["u_user_id"];
                $username = $row["u_username"];
                $avatarApproved = $row["a_avatar_approved"];
                $avatarName = $row["a_original_file_name"];
                $banned = $row["u_banned"];
                $discordDiscriminator = $row["u_discord_discriminator"];
                $discordID = $row["u_discord_id"];
                $discordUsername = $row["u_discord_username"];
                $mainRoleSelected = $row["u_main_role"];
                $originalKeyholderLevel = $row["u_original_keyholder_level"];
                $originalLockeeLevel = $row["u_original_lockee_level"];
                $privateProfile = $row["u_private_profile"];
                $statusSelected = $row["u_status"];
                $timestampLastActive = $row["u_timestamp_last_active"];
                $twitterHandle = $row["u_twitter_handle"];
                $visibleInPublicStats = $row["u_display_in_stats"];
                if ($username == "") {
                    $username = "CKU".$id;
                }
                $averageRating = 0;
                $noOfRatings = 0;
                if ($mainRoleSelected == 1) {
                    if ($username == "Hailey" || $username == "Blaine" || $username == "Zoe" || $username == "Chase") {
                        // DON'T GET RATINGS OR STATS IF BOT
                    } else {
                        $query2 = $pdo->prepare("select count(*) as no_of_locks_managed, timestamp_locked as timestamp_first_keyheld from `Locks_V2` AS l, `ShareableLocks_V2` AS s, `UserIDs_V2` AS u where l.shared_id = s.share_id and s.user_id = u.user_id and u.user_id = :userID and l.fake = 0 and l.test = 0 and u.display_in_stats = 1 order by timestamp_locked asc limit 1");
                        $query2->execute(array('userID' => $userID));
                        foreach ($query2 as $row2) {
                            $noOfLocksManaged = $row2["no_of_locks_managed"];
                            $timestampFirstKeyheld = $row2["timestamp_first_keyheld"];
                        }
                        if ($noOfLocksManaged >= 1500 && time() - $timestampFirstKeyheld >= 15552000) { $keyholderLevel = 5; }
                        elseif ($noOfLocksManaged >= 500 && time() - $timestampFirstKeyheld >= 10368000) { $keyholderLevel = 4; }
                        elseif ($noOfLocksManaged >= 100 && time() - $timestampFirstKeyheld >= 5184000) { $keyholderLevel = 3; }
                        elseif ($noOfLocksManaged >= 10 && time() - $timestampFirstKeyheld) { $keyholderLevel = 2; }
                        else { $keyholderLevel = 1; }
                        
                        // UPDATE RECORD IF LEVEL HAS CHANGED
                        if ($keyholderLevel != $originalKeyholderLevel) {
                            $query2 = $pdo->prepare("update `UserIDs_V2` set keyholder_level = :keyholderLevel where user_id = :userID");
                            $query2->execute(array('keyholderLevel' => $keyholderLevel, 'userID' => $userID));
                        }
                        
                        $query2 = $pdo->prepare("select avg(l.rating) as average_rating, count(l.rating) as number_of_ratings from Locks_V2 as l, ShareableLocks_V2 as s where l.shared_id = s.share_id and s.user_id = :userID and l.rating > 0 and l.fake = 0");
                        $query2->execute(array('userID' => $userID));
                        foreach ($query2 as $row2) {
                            $averageRating = $row2["average_rating"];
                            $noOfRatings = $row2["number_of_ratings"];
                        }
                    }
                } elseif ($mainRoleSelected == 2) {
                    $cumulativeMonthsLocked = 0;
                    $cumulativeSecondsLocked = 0;
                    $noOfLocks = 0;
                    $noOfLocksCompleted = 0;
                    $averageSecondsLocked = 0;
                    $longestSecondsLocked = 0;
                    $lastTimestampLocked = 0;
                    $lastTimestampUnlocked = 0;
                    $query2 = $pdo->prepare("select deleted, timestamp_locked, timestamp_unlocked, unlocked from Locks_V2 where user_id = :userID and timestamp_locked >= 1400000000 and fake = 0 and test = 0 and (unlocked = 1 or (unlocked = 0 and deleted = 0)) order by timestamp_locked");
                    $query2->execute(array('userID' => $userID));
                    foreach ($query2 as $row2) {
                        $deleted = $row2["deleted"];
                        $timestampLocked = $row2["timestamp_locked"];
                        $timestampUnlocked = $row2["timestamp_unlocked"];
                        $unlocked = $row2["unlocked"];
                        if ($deleted == 0 && $unlocked == 0) { $timestampUnlocked = time(); }
                        $secondsLocked = $timestampUnlocked - $timestampLocked;
                        if ($secondsLocked <= 0) { continue; }
                        $noOfLocks++;
                        if ($unlocked == 1) { $noOfLocksCompleted++; }
                        if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked <= $lastTimestampUnlocked) { continue; }
                        if ($timestampLocked <= $lastTimestampUnlocked) {
                            $timestampLocked = $lastTimestampUnlocked;
                            $secondsLocked = $timestampUnlocked - $timestampLocked;
                        }
                        if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked > $lastTimestampUnlocked) { $cumulativeSecondsLocked = $cumulativeSecondsLocked + $secondsLocked; }
                        if ($secondsLocked > $longestSecondsLocked) { $longestSecondsLocked = $secondsLocked; }
                        $lastTimestampLocked = $timestampLocked;
                        $lastTimestampUnlocked = $timestampUnlocked;
                    }
                    $cumulativeMonthsLocked = $cumulativeSecondsLocked / 2592000;
                    if ($cumulativeMonthsLocked >= 24) { $lockeeLevel = 5; }
                    elseif ($cumulativeMonthsLocked >= 12) { $lockeeLevel = 4; }
                    elseif ($cumulativeMonthsLocked >= 6 && $cumulativeMonthsLocked < 12) { $lockeeLevel = 3; }
                    elseif ($cumulativeMonthsLocked >= 2 && $cumulativeMonthsLocked < 6) { $lockeeLevel = 2; }
                    else { $lockeeLevel = 1; }
                    
                    // UPDATE RECORD IF LEVEL HAS CHANGED
                    if ($lockeeLevel != $originalLockeeLevel) {
                        $query2 = $pdo->prepare("update `UserIDs_V2` set lockee_level = :lockeeLevel where user_id = :userID");
                        $query2->execute(array('lockeeLevel' => $lockeeLevel, 'userID' => $userID));
                    }

                    $query2 = $pdo->prepare("select avg(rating_from_keyholder) as average_rating, count(rating_from_keyholder) as number_of_ratings from Locks_V2 where user_id = :userID and rating_from_keyholder > 0 and fake = 0");
                    $query2->execute(array('userID' => $userID));
                    foreach ($query2 as $row2) {
                        $averageRating = $row2["average_rating"];
                        $noOfRatings = $row2["number_of_ratings"];
                    }
                }
                $query2 = $pdo->prepare("select 
                    sum(case when user_two_id = :id and status = 1 then 1 else 0 end) as followers,
                    sum(case when user_one_id = :id and status = 1 then 1 else 0 end) as following
                from Relations where (user_one_id = :id or user_two_id) and status = 1");
                $query2->execute(array('id' => $id));
                foreach ($query2 as $row2) {
                    $followers = $row2["followers"];
                    $following = $row2["following"];
                }
            }
            array_push($JSON, array(
                'id' => $id,
                'username$' => $username,
                'avatarApproved' => $avatarApproved,
                'avatarName$' => $avatarName,
                'averageRating#' => $averageRating,
                'banned' => $banned,
                'discordDiscriminator' => $discordDiscriminator,
                'discordID$' => $discordID,
                'discordUsername$' => RemoveEmoji($discordUsername),
                'followers' => $followers,
                'following' => $following,
                'keyholderLevel' => $keyholderLevel,
                'lockeeLevel' => $lockeeLevel,
                'mainRoleSelected' => $mainRoleSelected,
                'noOfRatings' => $noOfRatings,
                'privateProfile' => $privateProfile,
                'statusSelected' => $statusSelected,
                'timestampLastActive' => $timestampLastActive,
                'twitterHandle$' => $twitterHandle,
                'visibleInPublicStats' => $visibleInPublicStats
            ));
            echo json_encode($JSON);
        } else {
            echo "No Profile Found";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>