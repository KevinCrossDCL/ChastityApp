<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query1 = $pdo->prepare("select
            id,
            share_id,
            name,
            block_users_already_locked,
            block_users_with_stats_hidden,
            build, 
            card_info_hidden, 
            check_in_frequency_in_seconds,
            cumulative, 
            fixed, 
            force_trust, 
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
        from ShareableLocks_V2 where user_id = :userID and hide_from_owner = 0 order by id desc");
        $query1->execute(array('userID' => $userID1));
        foreach ($query1 as $row1) {
            $shareID = $row1["share_id"];
            $name = $row1["name"];
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
            $awaitingDecision = 0;
            $lockedCount = 0;
            $lockedCountExcludingTest = 0;
            $lockedCountIncludingTest = 0;
            $fakeLockedCount = 0;
            $unlockedCount = 0;
            $unlockedCountAwaitingRating = 0;
            $desertedCount = 0;
            $desertedCountAwaitingRating = 0;
            $query2 = $pdo->prepare("select u.id as u_id, u.username as u_username, l.deleted as l_deleted, l.fake as l_fake, l.fixed as l_fixed, l.rating_from_keyholder as l_rating_from_keyholder, l.ready_to_unlock as l_ready_to_unlock, l.test as l_test, .l.timestamp_deleted as l_timestamp_deleted, l.timestamp_requested_keyholders_decision as l_timestamp_requested_keyholders_decision, l.timestamp_unlocked as l_timestamp_unlocked, l.unlocked as l_unlocked from Locks_V2 as l, UserIDs_V2 as u where l.shared_id = :shareID and l.user_id <> :userID and l.user_id = u.user_id and l.removed_by_keyholder = 0");
            $query2->execute(array('shareID' => $shareID, 'userID' => $userID1));
            $lockedUsersDelimited = "";
            $unlockedUsersDelimited = "";
            $desertedUsersDelimited = "";
            foreach ($query2 as $row2) {
                $username = $row2["u_username"];
                if ($username == "") { $username = "CKU".$row2["u_id"]; }
                if ($row2["l_unlocked"] == 0 && $row2["l_deleted"] == 0) {
                    $lockedCount++;
                    $lockedCountIncludingTest++;
                    if ($row2["l_test"] == 0) { $lockedCountExcludingTest++; }
                    if ($row2["l_ready_to_unlock"] == 1 && $row2["l_timestamp_requested_keyholders_decision"] > 0) {
                        $awaitingDecision++;
                    }
                    if (strpos($lockedUsersDelimited, $username) === false) { $lockedUsersDelimited = $lockedUsersDelimited."|".$username."|"; }
                }
                if ($row2["l_unlocked"] == 0 && $row2["l_fake"] == 1 && $row2["l_deleted"] == 0) { $fakeLockedCount++; }
                if ($row2["l_unlocked"] == 1 && $row2["l_fake"] == 0) {
                    $unlockedCount++;
                    if ($row2["l_rating_from_keyholder"] == 0 && $row2["l_test"] == 0 && time() - $row2["l_timestamp_unlocked"] <= 604800) { $unlockedCountAwaitingRating++; }
                    if (strpos($unlockedUsersDelimited, $username) === false) { $unlockedUsersDelimited = $unlockedUsersDelimited."|".$username."|"; }
                }
                if ($row2["l_unlocked"] == 0 && $row2["l_deleted"] == 1 && $row2["l_fake"] == 0) { 
                    $desertedCount++;
                    if ($row2["l_rating_from_keyholder"] == 0 && $row2["l_test"] == 0 && time() - $row2["l_timestamp_deleted"] <= 604800) { $desertedCountAwaitingRating++; }
                    if (strpos($desertedUsersDelimited, $username) === false) { $desertedUsersDelimited = $desertedUsersDelimited."|".$username."|"; }
                }
            }
            $query2 = $pdo->prepare("select count(rating) as no_of_ratings, avg(rating) as average_rating from Locks_V2 where shared_id = :shareID and rating > 0 and fake = 0 limit 1");
            $query2->execute(array('shareID' => $shareID));
            foreach ($query2 as $row2) {
                $noOfRatings = $row2["no_of_ratings"];
                $rating = $row2["average_rating"];
            }
            array_push($JSON, array(
                'id' => $row1["id"],
                'shareID$' => $shareID, 
                'awaitingDecision' => $awaitingDecision,
                'blockUsersAlreadyLocked' => $row1["block_users_already_locked"],
                'blockUsersWithStatsHidden' => $row1["block_users_with_stats_hidden"],
                'build' => $row1["build"],
                'cardInfoHidden' => $row1["card_info_hidden"],
                'checkInFrequencyInSeconds' => $row1["check_in_frequency_in_seconds"],
                'cumulative' => $row1["cumulative"],
                'desertedUsers' => $desertedCount,
                'desertedUsersAwaitingRating' => $desertedCountAwaitingRating,
                'desertedUsersDelimited$' => $desertedUsersDelimited,
                'fakeLockedUsers' => $fakeLockedCount,
                'fixed' => $row1["fixed"],
                'forceTrust' => $row1["force_trust"],
                'keyDisabled' => $row1["key_disabled"],
                'keyholderDecisionDisabled' => $row1["keyholder_decision_disabled"],
                'lateCheckInWindowInSeconds' => $row1["late_check_in_window_in_seconds"],
                'lockedUsers' => $lockedCount,
                'lockedUsersDelimited$' => $lockedUsersDelimited,
                'lockedUsersExcludingTest' => $lockedCountExcludingTest,
                'lockedUsersIncludingTest' => $lockedCountIncludingTest,
                'lockRating#' => $rating,
                'lockName$' => $name,
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
                'noOfLockRatings' => $noOfRatings,
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
                'unlockedUsers' => $unlockedCount,
                'unlockedUsersAwaitingRating' => $unlockedCountAwaitingRating,
                'unlockedUsersDelimited$' => $unlockedUsersDelimited,
                'version$' => $row1["version"]
            ));
        }
        echo json_encode($JSON);
    }
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>