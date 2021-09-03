<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $locksData = "";
    $JSON = array();
    
    if ($userID1 == $userID2) {
        
        if (substr($_POST['sharedID'], 0, 2) == '!A') {
            $queryFindDiscordAuth = $pdo->prepare("select * from DiscordQRRegister where auth_code = ? and created > (now() - interval 5 minute)");
            $queryFindDiscordAuth->execute([substr($_POST['sharedID'], 2)]);
            if ($queryFindDiscordAuth->rowCount() > 0) {
                $discordObj = $queryFindDiscordAuth->fetchObject();
                $queryClearOldConnection = $pdo->prepare("update UserIDs_V2 set discord_id = null, discord_username = null, discord_discriminator = null where discord_id = ?");
                $queryClearOldConnection->execute([$discordObj->discord_id]);
                $queryUpdateUser = $pdo->prepare("update UserIDs_V2 set discord_id = ?, discord_username = ?, discord_discriminator = ? where user_id = ?");
                $queryUpdateUser->execute([$discordObj->discord_id, $discordObj->discord_username, $discordObj->discord_discriminator, $userID1]);
                $queryDeleteDiscordAuth = $pdo->prepare("delete from DiscordQRRegister where auth_code = ?");
                $queryDeleteDiscordAuth->execute([substr($_POST['sharedID'], 2)]);
                echo "Error:Congratulations, your Discord has been linked to your account.";
            } else {
                echo "Error:Sorry, your Discord Authentication was not found or expired. Please try again.";
            }
        } else {
            $query1 = $pdo->prepare("select 
                id, 
                user_id,
                share_id,
                name,
                allow_copies, 
                block_test_locks,
                block_users_already_locked,
                block_users_with_stats_hidden,
                build, 
                card_info_hidden, 
                check_in_frequency_in_seconds,
                cumulative, 
                fixed, 
                force_trust, 
                hide_from_owner, 
                key_disabled, 
                keyholder_decision_disabled,
                late_check_in_window_in_seconds,
                max_auto_resets,
                max_random_copies,
                max_random_double_ups, 
                max_random_freezes, 
                max_random_greens, 
                max_random_minutes,
                max_random_reds, 
                max_random_resets, 
                max_random_stickies,
                max_random_yellows, 
                max_random_yellows_add, 
                max_random_yellows_minus, 
                maximum_copies, 
                maximum_users,
                min_random_copies,
                min_random_double_ups,
                min_random_freezes,
                min_random_greens,
                min_random_minutes,
                min_random_reds,
                min_random_resets,
                min_random_stickies,
                min_random_yellows, 
                min_random_yellows_add,
                min_random_yellows_minus,
                min_rating_required,
                minimum_version_required, 
                multiple_greens_required,
                regularity, 
                require_dm,
                reset_frequency_in_seconds,
                share_in_api,
                simulation_average_minutes_locked,
                simulation_best_case_minutes_locked,
                simulation_worst_case_minutes_locked,
                start_lock_frozen,
                temporarily_disabled,
                timer_hidden,
                version 
            from ShareableLocks_V2 where share_id = :shareID");
            $query1->execute(array('shareID' => $_POST['sharedID']));
            if ($query1->rowCount() == 1) {
                foreach ($query1 as $row1) {
                    $shareID = $row1["share_id"];
                    $userID = $row1["user_id"];
                    $minVersionRequired = $row1["minimum_version_required"];
                    if ($minVersionRequired == "") { $minVersionRequired = "2.2.0"; }
                    $minRandomCopies = 0;
                    $maxRandomCopies = 0;
                    if ($row1["maximum_copies"] > 0) {
                        $minRandomCopies = 0;
                        $maxRandomCopies = $row1["maximum_copies"];
                    }
                    if ($row1["max_random_copies"] > 0) {
                        $minRandomCopies = $row1["min_random_copies"];
                        $maxRandomCopies = $row1["max_random_copies"];
                    }
                    $query2 = $pdo->prepare("select u.id as u_id, u.username as u_username, u.status as u_status, u.timestamp_last_active as u_timestamp_last_active from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :shareID and s.user_id = u.user_id");
                    $query2->execute(array('shareID' => $shareID));
                    if ($query2->rowCount() == 1) {
                        foreach ($query2 as $row2) {
                            $keyholderID = $row2["u_id"];
                            $keyholderUsername = $row2["u_username"];
                            $keyholderStatus = $row2["u_status"];
                            $keyholderLastActive = $row2["u_timestamp_last_active"];
                            if ($keyholderUsername == "") {
                                $keyholderUsername = "CKU".$keyholderID;
                            }
                        }
                    }
                    if ($keyholderUsername == "Hailey") {
                        $query2 = $pdo->prepare("select avg(l.rating) as avg_l_rating, count(l.rating) as count_l_rating from Locks_V2 as l where l.shared_id = 'BOT01' and fake = 0 and l.rating > 0");    
                    } elseif ($keyholderUsername == "Blaine") {
                        $query2 = $pdo->prepare("select avg(l.rating) as avg_l_rating, count(l.rating) as count_l_rating from Locks_V2 as l where l.shared_id = 'BOT02' and fake = 0 and l.rating > 0");    
                    } elseif ($keyholderUsername == "Zoe") {
                        $query2 = $pdo->prepare("select avg(l.rating) as avg_l_rating, count(l.rating) as count_l_rating from Locks_V2 as l where l.shared_id = 'BOT03' and fake = 0 and l.rating > 0");    
                    } elseif ($keyholderUsername == "Chase") {
                        $query2 = $pdo->prepare("select avg(l.rating) as avg_l_rating, count(l.rating) as count_l_rating from Locks_V2 as l where l.shared_id = 'BOT04' and fake = 0 and l.rating > 0");    
                    } else {
                        $query2 = $pdo->prepare("select avg(l.rating) as avg_l_rating, count(l.rating) as count_l_rating from ShareableLocks_V2 as s, Locks_V2 as l where s.user_id = :user_id and s.share_id = l.shared_id and fake = 0 and l.rating > 0");
                    }
                    $query2->execute(array('user_id' => $userID));
                    foreach ($query2 as $row2) {
                        $keyholderRating = $row2["avg_l_rating"];
                        $noOfKeyholderRatings = $row2["count_l_rating"];
                    }
                    $query2 = $pdo->prepare("select avg(rating) as avg_rating, count(rating) as count_ratings from Locks_V2 where shared_id = :shareID and fake = 0 and rating > 0");
                    $query2->execute(array('shareID' => $shareID));
                    $noOfLockRatings = 0;
                    $lockRating = 0;
                    foreach ($query2 as $row2) {
                        $noOfLockRatings = $row2["count_ratings"];
                        $lockRating = $row2["avg_rating"];
                    }
                    $query2 = $pdo->prepare("select id from Locks_V2 where shared_id = :shareID and fake = 0 and unlocked = 0 and deleted = 0");
                    $query2->execute(array('shareID' => $shareID));
                    $lockedUsers = $query2->rowCount();
                    array_push($JSON, array(
                        'shareID$' => $shareID,
                        'allowCopies' => $row1["allow_copies"],
                        'blockTestLocks' => $row1["block_test_locks"],
                        'blockUsersAlreadyLocked' => $row1["block_users_already_locked"],
                        'blockUsersWithStatsHidden' => $row1["block_users_with_stats_hidden"],
                        'build' => $row1["build"],
                        'cardInfoHidden' => $row1["card_info_hidden"],
                        'checkInFrequencyInSeconds' => $row1["check_in_frequency_in_seconds"],
                        'cumulative' => $row1["cumulative"],
                        'fixed' => $row1["fixed"],
                        'forceTrust' => $row1["force_trust"],
                        'hiddenFromOwner' => $row1["hide_from_owner"],
                        'keyDisabled' => $row1["key_disabled"],
                        'keyholderDecisionDisabled' => $row1["keyholder_decision_disabled"],
                        'keyholderID' => $keyholderID,
                        'keyholderLastActive' => $keyholderLastActive,
                        'keyholderRating#' => $keyholderRating,
                        'keyholderStatus' => $keyholderStatus,
                        'keyholderUsername$' => $keyholderUsername,
                        'lateCheckInWindowInSeconds' => $row1["late_check_in_window_in_seconds"],
                        'lockedUsers' => $lockedUsers,
                        'lockName$' => $row1["name"],
                        'lockRating#' => $lockRating,
                        'maxAutoResets' => $row1["max_auto_resets"],
                        'maxRandomCopies' => $maxRandomCopies,
                        'maxRandomDoubleUps' => $row1["max_random_double_ups"],
                        'maxRandomFreezes' => $row1["max_random_freezes"],
                        'maxRandomGreens' => $row1["max_random_greens"],
                        'maxRandomMinutes' => $row1["max_random_minutes"],
                        'maxRandomReds' => $row1["max_random_reds"],
                        'maxRandomResets' => $row1["max_random_resets"],
                        'maxRandomStickies' => $row1["max_random_stickies"],
                        'maxRandomYellows' => $row1["max_random_yellows"],
                        'maxRandomYellowsAdd' => $row1["max_random_yellows_add"],
                        'maxRandomYellowsMinus' => $row1["max_random_yellows_minus"],
                        'maxUsers' => $row1["maximum_users"],
                        'minRandomCopies' => $minRandomCopies,
                        'minRandomDoubleUps' => $row1["min_random_double_ups"],
                        'minRandomFreezes' => $row1["min_random_freezes"],
                        'minRandomGreens' => $row1["min_random_greens"],
                        'minRandomMinutes' => $row1["min_random_minutes"],
                        'minRandomReds' => $row1["min_random_reds"],
                        'minRandomResets' => $row1["min_random_resets"],
                        'minRandomStickies' => $row1["min_random_stickies"],
                        'minRandomYellows' => $row1["min_random_yellows"],
                        'minRandomYellowsAdd' => $row1["min_random_yellows_add"],
                        'minRandomYellowsMinus' => $row1["min_random_yellows_minus"],
                        'minRatingRequired' => $row1["min_rating_required"],
                        'minVersionRequired$' => $minVersionRequired,
                        'multipleGreensRequired' => $row1["multiple_greens_required"],
                        'noOfKeyholderRatings' => $noOfKeyholderRatings,
                        'noOfLockRatings' => $noOfLockRatings,
                        'regularity#' => $row1["regularity"],
                        'requireDM' => $row1["require_dm"],
                        'resetFrequencyInSeconds' => $row1["reset_frequency_in_seconds"],
                        'shareInAPI' => $row1["share_in_api"],
                        'simulationAverageMinutesLocked' => $row1["simulation_average_minutes_locked"],
                        'simulationBestCaseMinutesLocked' => $row1["simulation_best_case_minutes_locked"],
                        'simulationWorstCaseMinutesLocked' => $row1["simulation_worst_case_minutes_locked"],
                        'startLockFrozen' => $row1["start_lock_frozen"],
                        'temporarilyDisabled' => $row1["temporarily_disabled"],
                        'timerHidden' => $row1["timer_hidden"],
                        'version$' => $row1["version"]
                    ));
                }
                $lockeeBlocked = 0;
                if ($row1["hide_from_owner"] == 0 && $_POST["platform"] != "ios") {
                    $query2 = $pdo->prepare("select t2.id as u_id from (select id, device_id from UserIDs_V2 where user_id = :userID) t1 left join (select id, device_id from UserIDs_V2) t2 on (t1.device_id = t2.device_id)");
                    $query2->execute(array('userID' => $userID1));
                    if ($query2->rowCount() >= 1) {
                        foreach ($query2 as $row2) {
                            $lockeeID = (int)$row2["u_id"];
                            $query3 = $pdo->prepare("select id from Relations where user_one_id = :userOneID and user_two_id = :userTwoID and status = 3");
                            $query3->execute(array('userOneID' => $keyholderID, 'userTwoID' => $lockeeID));
                            if ($query3->rowCount() == 1) {
                                $lockeeBlocked = 1;
                                break;
                            }
                        }
                    }
                }
                if ($row1["hide_from_owner"] == 0 && $_POST["platform"] == "ios") {
                    $query2 = $pdo->prepare("select id from UserIDs_V2 where user_id = :userID");
                    $query2->execute(array('userID' => $userID1));
                    if ($query2->rowCount() >= 1) {
                        foreach ($query2 as $row2) {
                            $lockeeID = (int)$row2["id"];
                            $query3 = $pdo->prepare("select id from Relations where user_one_id = :userOneID and user_two_id = :userTwoID and status = 3");
                            $query3->execute(array('userOneID' => $keyholderID, 'userTwoID' => $lockeeID));
                            if ($query3->rowCount() == 1) {
                                $lockeeBlocked = 1;
                                break;
                            }
                        }
                    }
                }
                if ($lockeeBlocked >= 1) {
                    echo "Error:You do not have permission to load this lock.\n\nPlease try another.";
                } elseif ($row1["maximum_users"] > 0 && $lockedUsers >= $row1["maximum_users"]) {
                    echo "Error:Lock has the maximum number of users allowed.\n\nPlease try again at a later date.";
                } else {
                    echo json_encode($JSON);
                }
            } else {
                echo "Error:Shared lock ID was not found.\n\nPlease try again.";
            }
        }
    }
    $query1 = null;
    $query2 = null;
    $query3 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>