<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON1 = array();
    $JSON2 = array();
    $JSON3 = array();
    
    if ($userID1 == $userID2) {
        // LOCKED USERS TAB
        if ($_POST['usersTab'] == 1) {
            $keyholderUserID = $userID1;
            $query1 = $pdo->prepare("select
                l.id as l_id, 
                l.user_id as l_user_id, 
                l.lock_id as l_lock_id,
                l.auto_resets_paused as l_auto_resets_paused,
                l.build as l_build, 
                l.card_info_hidden as l_card_info_hidden, 
                l.chances_accumulated_before_freeze as l_chances_accumulated_before_freeze,
                l.check_in_frequency_in_seconds as l_check_in_frequency_in_seconds,
                l.combination as l_combination,
                l.cumulative as l_cumulative,
                l.date_locked as l_date_locked,
                l.discard_pile as l_discard_pile,
                l.double_up_cards as l_double_up_cards, 
                l.fake as l_fake,
                l.freeze_cards as l_freeze_cards, 
                l.green_cards as l_green_cards, 
                l.greens_picked_since_reset as l_greens_picked_since_reset, 
                l.hide_greens_until_picked_count as l_hide_greens_until_picked_count,
                l.initial_double_up_cards as l_initial_double_up_cards, 
                l.initial_freeze_cards as l_initial_freeze_cards, 
                l.initial_green_cards as l_initial_green_cards, 
                l.initial_minutes as l_initial_minutes,
                l.initial_red_cards as l_initial_red_cards, 
                l.initial_reset_cards as l_initial_reset_cards, 
                l.initial_sticky_cards as l_initial_sticky_cards, 
                l.initial_yellow_minus_2_cards as l_initial_yellow_minus_2_cards, 
                l.initial_yellow_minus_1_cards as l_initial_yellow_minus_1_cards, 
                l.initial_yellow_add_1_cards as l_initial_yellow_add_1_cards, 
                l.initial_yellow_add_2_cards as l_initial_yellow_add_2_cards, 
                l.initial_yellow_add_3_cards as l_initial_yellow_add_3_cards,
                l.keyholder_allows_free_unlock as l_keyholder_allows_free_unlock,
                l.keyholder_emoji as l_keyholder_emoji, 
                l.keyholder_emoji_colour as l_keyholder_emoji_colour,
                l.key_disabled as l_key_disabled,
                l.last_update_id_seen as l_last_update_id_seen,
                l.late_check_in_window_in_seconds as l_late_check_in_window_in_seconds,
                l.lock_frozen_by_card as l_lock_frozen_by_card, 
                l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
                l.maximum_auto_resets as l_maximum_auto_resets,
                l.minutes as l_minutes,
                l.no_of_add_1_cards as l_no_of_add_1_cards,
                l.no_of_add_2_cards as l_no_of_add_2_cards,
                l.no_of_add_3_cards as l_no_of_add_3_cards,
                l.no_of_minus_1_cards as l_no_of_minus_1_cards, 
                l.no_of_minus_2_cards as l_no_of_minus_2_cards, 
                l.no_of_times_auto_reset as l_no_of_times_auto_reset,
                l.no_of_times_card_reset as l_no_of_times_card_reset,
                l.no_of_times_full_reset as l_no_of_times_full_reset,
                l.no_of_times_green_card_revealed as l_no_of_times_green_card_revealed,
                l.no_of_times_reset as l_no_of_times_reset,
                l.picked_count as l_picked_count,
                l.picked_count_since_reset as l_picked_count_since_reset,
                l.ready_to_unlock as l_ready_to_unlock, 
                l.red_cards as l_red_cards, 
                l.reset_cards as l_reset_cards, 
                l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
                l.sticky_cards as l_sticky_cards,
                l.test as l_test,
                l.timer_hidden as l_timer_hidden, 
                l.timestamp_clean_time_request_blocked_until as l_timestamp_clean_time_request_blocked_until,
                l.timestamp_denied_clean_time as l_timestamp_denied_clean_time,
                l.timestamp_ended_clean_time as l_timestamp_ended_clean_time,
                l.timestamp_frozen_by_card as l_timestamp_frozen_by_card, 
                l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder, 
                l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
                l.timestamp_last_card_reset as l_timestamp_last_card_reset,
                l.timestamp_last_checked_in as l_timestamp_last_checked_in,
                l.timestamp_last_full_reset as l_timestamp_last_full_reset,
                l.timestamp_last_picked as l_timestamp_last_picked, 
                l.timestamp_last_reset as l_timestamp_last_reset,
                l.timestamp_last_synced as l_timestamp_last_synced,
                l.timestamp_last_updated as l_timestamp_last_updated,
                l.timestamp_locked as l_timestamp_locked, 
                l.timestamp_real_last_picked as l_timestamp_real_last_picked,
                l.timestamp_requested_clean_time as l_timestamp_requested_clean_time,
                l.timestamp_requested_keyholders_decision as l_timestamp_requested_keyholders_decision, 
                l.timestamp_started_clean_time as l_timestamp_started_clean_time,
                l.timestamp_unfreezes as l_timestamp_unfreezes, 
                l.timestamp_unfrozen as l_timestamp_unfrozen, 
                l.total_time_cleaning as l_total_time_cleaning,
                l.total_time_frozen as l_total_time_frozen, 
                l.trust_keyholder as l_trust_keyholder, 
                l.unlocked as l_unlocked, 
                l.user_emoji as l_user_emoji, 
                l.user_emoji_colour as l_user_emoji_colour,
                l.version as l_version,
                u.id as u_id,
                u.build_number_installed as u_build_number_installed,
                u.keyholder_level as u_keyholder_level,
                u.lockee_level as u_lockee_level, 
                u.main_role as u_main_role,
                u.show_combinations_to_keyholders as u_show_combinations_to_keyholders,
                u.status as u_status,
                u.timestamp_last_active as u_timestamp_last_active,
                u.username as u_username
            from Locks_V2 as l, UserIDs_V2 as u where l.shared_id = :shareID and l.user_id <> :keyholderUserID and l.user_id = u.user_id and l.unlocked = 0 and l.deleted = 0 and l.removed_by_keyholder = 0 order by rand(:seed) limit 199");
            $query1->execute(array('shareID' => $_POST['sharedID'], 'keyholderUserID' => $keyholderUserID, 'seed' => $_POST['seed']));
            foreach ($query1 as $row1) {
                $lockeeUserID = $row1["l_user_id"];
                $combination = $row1["l_combination"];
                $keyholderEmojiColour = $row1["l_keyholder_emoji_colour"];
                if ($keyholderEmojiColour == 0) { $keyholderEmojiColour = 1; }
                $mainRole = $row1["u_main_role"];
                if ($mainRole == 1) { $mainRoleLevel = $row1["u_keyholder_level"]; }
                if ($mainRole == 2) { $mainRoleLevel = $row1["u_lockee_level"]; }
                $showCombinationsToKeyholders = $row1["u_show_combinations_to_keyholders"];
                if ($showCombinationsToKeyholders != 1) { $combination = ""; }
                $timestampLastPicked = $row1["l_timestamp_last_picked"];
                $timestampRealLastPicked = $row1["l_timestamp_real_last_picked"];
                $userEmojiColour = $row1["l_user_emoji_colour"];
                if ($userEmojiColour == 0) { $userEmojiColour = 1; }
                $username = $row1["u_username"];
                if ($username == "") { $username = "CKU".$row1["u_id"]; }
                $version = $row1["l_version"];
                $version = str_replace("Amazon ", "", $version);
                $version = str_replace("App Store ", "", $version);
                $version = str_replace("Google Play ", "", $version);
                $version = str_replace("Mac Store ", "", $version);
                $version = str_replace("MiKandi ", "", $version);
                
                // CHECK IF LOCKEE HAS MULTIPLE KEYHOLDERS
                $noOfKeyholders = 1;
                $otherKeyholders = "";
                $query2 = $pdo->prepare("select
                    if (u.username = '', concat('CKU', u.id), u.username) as u_username,
                    l.test as l_test
                from Locks_V2 as l, UserIDs_V2 as u 
                where l.deleted = 0 and 
                    l.fake = 0 and 
                    l.shared_id <> :sharedID and 
                    l.shared_id <> '' and 
                    l.user_id = :lockeeUserID and 
                    l.timestamp_unlocked = 0 and 
                    l.unlocked = 0 and 
                    u.id = l.keyholder_id and 
                    u.user_id <> :keyholderUserID");
                $query2->execute(array('sharedID' => $_POST['sharedID'], 'lockeeUserID' => $lockeeUserID, 'keyholderUserID' => $keyholderUserID));
                foreach ($query2 as $row2) {
                    $keyholderUsername = $row2["u_username"];
                    if (strstr($otherKeyholders, $keyholderUsername." ")) {
                        
                    } else {
                        $noOfKeyholders++;
                        if ($row2["l_test"] == 1) {
                            $testLock = " (Test Lock)";
                        } else {
                            $testLock = "";
                        }
                        $otherKeyholders = $otherKeyholders.$keyholderUsername.$testLock." \n";
                    }
                }
            
                // USERS AVERAGE RATING
                $query2 = $pdo->prepare("select 
                    avg(rating_from_keyholder) as avg_rating_from_keyholders, 
                    count(rating_from_keyholder) as count_rating_from_keyholders 
                from Locks_V2 where user_id = :lockeeUserID and 
                    fake = 0 and 
                    rating_from_keyholder > 0");
                $query2->execute(array('lockeeUserID' => $lockeeUserID));
                foreach ($query2 as $row2) {
                    $averageRatingFromKeyholders = $row2["avg_rating_from_keyholders"];
                    $noOfRatingsFromKeyholders = $row2["count_rating_from_keyholders"];
                }
                $averageRatingFromKeyholders = 0;
                $noOfRatingsFromKeyholders = 0;
                
                // TIMESTAMP REAL LAST PICKED
                if ($timestampRealLastPicked < $timestampLastPicked) {
                    $timestampRealLastPicked = $timestampLastPicked;
                    $query2 = $pdo->prepare("select 
                        timestamp  
                    from Locks_Log where user_id = :lockeeUserID and 
                        lock_id = :lockID and
                        action = 'PickedACard'
                    order by id desc limit 1");
                    $query2->execute(array('lockeeUserID' => $lockeeUserID, 'lockID' => $row1["l_lock_id"]));
                    foreach ($query2 as $row2) {
                        $timestampRealLastPicked = $row2["timestamp"];
                    }
                }
                
                // SAVE TO JSON ARRAY
                array_push($JSON1, array(
                    'jsonNo' => 1,
                    'usersAutoResetsPaused' => $row1["l_auto_resets_paused"],
                    'usersAverageRatingFromKeyholders#' => $averageRatingFromKeyholders,
                    'usersBuildNumberInstalled' => $row1["u_build_number_installed"],
                    'usersCardInfoHidden' => $row1["l_card_info_hidden"],
                    'usersChancesAccumulatedBeforeFreeze' => $row1["l_chances_accumulated_before_freeze"],
                    'usersCombination$' => $combination,
                    'usersCheckInFrequencyInSeconds' => $row1["l_check_in_frequency_in_seconds"],
                    'usersCumulative' => $row1["l_cumulative"],
                    'usersDateLocked$' => $row1["l_date_locked"],
                    'usersDiscardPile$' => $row1["l_discard_pile"],
                    'usersDoubleUpCards' => $row1["l_double_up_cards"],
                    'usersEmojiChosen' => $row1["l_user_emoji"],
                    'usersEmojiColourSelected' => $userEmojiColour,
                    'usersFakeLock' => $row1["l_fake"],
                    'usersFreezeCards' => $row1["l_freeze_cards"],
                    'usersGreenCards' => $row1["l_green_cards"],
                    'usersGreenCardsPicked' => $row1["l_greens_picked_since_reset"],
                    'usersHideGreensUntilPickedCount' => $row1["l_hide_greens_until_picked_count"],
                    'usersID' => $row1["u_id"],
                    'usersInitialDoubleUpCards' => $row1["l_initial_double_up_cards"],
                    'usersInitialFreezeCards' => $row1["l_initial_freeze_cards"],
                    'usersInitialGreenCards' => $row1["l_initial_green_cards"],
                    'usersInitialMinutes' => $row1["l_initial_minutes"],
                    'usersInitialRedCards' => $row1["l_initial_red_cards"],
                    'usersInitialResetCards' => $row1["l_initial_reset_cards"],
                    'usersInitialStickyCards' => $row1["l_initial_sticky_cards"],
                    'usersInitialYellowCards' => [
                        0,
                        $row1["l_initial_yellow_minus_2_cards"], 
                        $row1["l_initial_yellow_minus_1_cards"], 
                        $row1["l_initial_yellow_add_1_cards"], 
                        $row1["l_initial_yellow_add_2_cards"],
                        $row1["l_initial_yellow_add_3_cards"]
                    ],
                    'usersKeyholderAllowsFreeUnlock' => $row1["l_keyholder_allows_free_unlock"],
                    'usersKeyholderEmojiChosen' => $row1["l_keyholder_emoji"],
                    'usersKeyholderEmojiColourSelected' => $keyholderEmojiColour,
                    'usersKeysDisabled' => $row1["l_key_disabled"],
                    'usersLastActive' => $row1["u_timestamp_last_active"],
                    'usersLastUpdateIDSeen' => $row1["l_last_update_id_seen"],
                    'usersLateCheckInWindowInSeconds' => $row1["l_late_check_in_window_in_seconds"],
                    'usersLockBuildNumber' => $row1["l_build"],
                    'usersLockFrozenByCard' => $row1["l_lock_frozen_by_card"],
                    'usersLockFrozenByKeyholder' => $row1["l_lock_frozen_by_keyholder"],
                    'usersLockID' => $row1["l_lock_id"],
                    'usersMainRole' => $mainRole,
                    'usersMainRoleLevel' => $mainRoleLevel,
                    'usersMaxAutoResets' => $row1["l_maximum_auto_resets"],
                    'usersMinutes' => $row1["l_minutes"],
                    'usersNoOfKeyholders' => $noOfKeyholders,
                    'usersNoOfRatingsFromKeyholders' => $noOfRatingsFromKeyholders,
                    'usersNoOfTimesAutoReset' => $row1["l_no_of_times_auto_reset"],
                    'usersNoOfTimesCardReset' => $row1["l_no_of_times_card_reset"],
                    'usersNoOfTimesFullReset' => $row1["l_no_of_times_full_reset"],
                    'usersNoOfTimesGreenCardRevealed' => $row1["l_no_of_times_green_card_revealed"],
                    'usersNoOfTimesReset' => $row1["l_no_of_times_reset"],
                    'usersPickedCount' => $row1["l_picked_count"],
                    'usersPickedCountSinceReset' => $row1["l_picked_count_since_reset"],
                    'usersOtherKeyholders$' => $otherKeyholders,
                    'usersReadyToUnlock' => $row1["l_ready_to_unlock"],
                    'usersRedCards' => $row1["l_red_cards"],
                    'usersResetCards' => $row1["l_reset_cards"],
                    'usersResetFrequencyInSeconds' => $row1["l_reset_frequency_in_seconds"],
                    'usersStatus' => $row1["u_status"],
                    'usersStickyCards' => $row1["l_sticky_cards"],
                    'usersTestLock' => $row1["l_test"],
                    'usersTimerHidden' => $row1["l_timer_hidden"],
                    'usersTimestampDeniedCleanTime' => $row1["l_timestamp_denied_clean_time"],
                    'usersTimestampEndedCleanTime' => $row1["l_timestamp_denied_ended_time"],
                    'usersTimestampFrozenByCard' => $row1["l_timestamp_frozen_by_card"],
                    'usersTimestampFrozenByKeyholder' => $row1["l_timestamp_frozen_by_keyholder"],
                    'usersTimestampLastAutoReset' => $row1["l_timestamp_last_auto_reset"],
                    'usersTimestampLastCardReset' => $row1["l_timestamp_last_card_reset"],
                    'usersTimestampLastCheckedIn' => $row1["l_timestamp_last_checked_in"],
                    'usersTimestampLastFullReset' => $row1["l_timestamp_last_full_reset"],
                    'usersTimestampLastPicked' => $timestampLastPicked,
                    'usersTimestampLastReset' => $row1["tl_imestamp_last_reset"],
                    'usersTimestampLastSynced' => $row1["l_timestamp_last_synced"],
                    'usersTimestampLastUpdated' => $row1["l_timestamp_last_updated"],
                    'usersTimestampLocked' => $row1["l_timestamp_locked"],
                    'usersTimestampRealLastPicked' => $timestampRealLastPicked,
                    'usersTimestampRequestedCleanTime' => $row1["l_timestamp_requested_clean_time"],
                    'usersTimestampRequestedKeyholdersDecision' => $row1["l_timestamp_requested_keyholders_decision"],
                    'usersTimestampStartedCleanTime' => $row1["l_timestamp_started_clean_time"],
                    'usersTimestampUnfreezes' => $row1["l_timestamp_unfreezes"],
                    'usersTimestampUnfrozen' => $row1["l_timestamp_unfrozen"],
                    'usersTotalTimeCleaning' => $row1["l_total_time_cleaning"],
                    'usersTotalTimeFrozen' => $row1["l_total_time_frozen"],
                    'usersTrustKeyholder' => $row1["l_trust_keyholder"],
                    'usersUnlocked' => $row1["l_unlocked"],
                    'usersUsername$' => $username,
                    'usersVersion$' => $version,
                    'usersYellowCards' => [
                        0,
                        $row1["l_no_of_minus_2_cards"], 
                        $row1["l_no_of_minus_1_cards"], 
                        $row1["l_no_of_add_1_cards"], 
                        $row1["l_no_of_add_2_cards"],
                        $row1["l_no_of_add_3_cards"]
                    ]
                ));
            }
        }

        // UNLOCKED USERS TAB
        if ($_POST['usersTab'] == 2) {
            $keyholderUserID = $userID1;
            $query1 = $pdo->prepare("select
                l.id as l_id, 
                l.user_id as l_user_id,
                l.lock_id as l_lock_id,
                l.build as l_build,
                l.check_in_frequency_in_seconds as l_check_in_frequency_in_seconds,
                l.combination as l_combination,
                l.date_locked as l_date_locked,
                l.date_unlocked as l_date_unlocked,
                l.key_used as l_key_used,
                l.late_check_in_window_in_seconds as l_late_check_in_window_in_seconds,
                l.rating_from_keyholder as l_rating_from_keyholder,
                l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
                l.test as l_test,
                l.timestamp_keyholder_rated as l_timestamp_keyholder_rated,
                l.timestamp_last_updated as l_timestamp_last_updated,
                l.timestamp_locked as l_timestamp_locked, 
                l.timestamp_unlocked as l_timestamp_unlocked,
                u.id as u_id,
                u.build_number_installed as u_build_number_installed,
                u.keyholder_level as u_keyholder_level,
                u.lockee_level as u_lockee_level, 
                u.main_role as u_main_role,
                u.show_combinations_to_keyholders as u_show_combinations_to_keyholders,
                u.status as u_status,
                u.timestamp_last_active as u_timestamp_last_active,
                u.username as u_username
            from Locks_V2 as l, UserIDs_V2 as u where l.shared_id = :sharedID and l.user_id <> :keyholderUserID and l.user_id = u.user_id and l.unlocked = 1 and l.fake = 0 and l.removed_by_keyholder = 0 order by l.timestamp_unlocked desc limit 199"); // limit 199");
            $query1->execute(array('sharedID' => $_POST['sharedID'], 'keyholderUserID' => $keyholderUserID));
            foreach ($query1 as $row1) {
                $lockeeUserID = $row1["l_user_id"];
                $combination = $row1["l_combination"];
                $mainRole = $row1["u_main_role"];
                if ($mainRole == 1) { $mainRoleLevel = $row1["u_keyholder_level"]; }
                if ($mainRole == 2) { $mainRoleLevel = $row1["u_lockee_level"]; }
                $showCombinationsToKeyholders = $row1["u_show_combinations_to_keyholders"];
                if ($showCombinationsToKeyholders != 1) { $combination = ""; }
                $username = $row1["u_username"];
                if ($username == "") { $username = "CKU".$row1["u_id"]; }
                
                // USERS AVERAGE RATING
                $query2 = $pdo->prepare("select 
                    avg(rating_from_keyholder) as avg_rating_from_keyholders, 
                    count(rating_from_keyholder) as count_rating_from_keyholders 
                from Locks_V2 where user_id = :lockeeUserID and 
                    fake = 0 and 
                    rating_from_keyholder > 0");
                $query2->execute(array('lockeeUserID' => $lockeeUserID));
                foreach ($query2 as $row2) {
                    $averageRatingFromKeyholders = $row2["avg_rating_from_keyholders"];
                    $noOfRatingsFromKeyholders = $row2["count_rating_from_keyholders"];
                }
                $averageRatingFromKeyholders = 0;
                $noOfRatingsFromKeyholders = 0;

                // SAVE TO JSON ARRAY
                array_push($JSON2, array(
                    'jsonNo' => 2,
                    'usersAverageRatingFromKeyholders#' => $averageRatingFromKeyholders,
                    'usersBuildNumberInstalled' => $row1["u_build_number_installed"],
                    'usersCheckInFrequencyInSeconds' => $row1["l_check_in_frequency_in_seconds"],
                    'usersCombination$' => $combination,
                    'usersDateLocked$' => $row1["l_date_locked"],
                    'usersDateUnlocked$' => $row1["l_date_unlocked"],
                    'usersID' => $row1["u_id"],
                    'usersKeyUsed' => $row1["l_key_used"],
                    'usersLastActive' => $row1["u_timestamp_last_active"],
                    'usersLateCheckInWindowInSeconds' => $row1["l_late_check_in_window_in_seconds"],
                    'usersLockBuildNumber' => $row1["build"],
                    'usersLockID' => $row1["l_lock_id"],
                    'usersMainRole' => $mainRole,
                    'usersMainRoleLevel' => $mainRoleLevel,
                    'usersNoOfRatingsFromKeyholders' => $noOfRatingsFromKeyholders,
                    'usersRatingFromKeyholder' => $row1["l_rating_from_keyholder"],
                    'usersResetFrequencyInSeconds' => $row1["l_reset_frequency_in_seconds"],
                    'usersStatus' => $row1["u_status"],
                    'usersTestLock' => $row1["l_test"],
                    'usersTimestampKeyholderRated' => $row1["l_timestamp_keyholder_rated"],
                    'usersTimestampLastUpdated' => $row1["l_timestamp_last_updated"],
                    'usersTimestampLocked' => $row1["l_timestamp_locked"],
                    'usersTimestampUnlocked' => $row1["l_timestamp_unlocked"],
                    'usersUsername$' => $username
                ));
            }
        }

        // DESERTED USERS TAB
        if ($_POST['usersTab'] == 3) {
            $keyholderUserID = $userID1;
            $query1 = $pdo->prepare("select
                l.id as l_id, 
                l.user_id as l_user_id,
                l.lock_id as l_lock_id,
                l.build as l_build,
                l.check_in_frequency_in_seconds as l_check_in_frequency_in_seconds,
                l.combination as l_combination,
                l.date_locked as l_date_locked,
                l.date_deleted as l_date_deleted,
                l.key_used as l_key_used,
                l.late_check_in_window_in_seconds as l_late_check_in_window_in_seconds,
                l.rating_from_keyholder as l_rating_from_keyholder,
                l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
                l.test as l_test,
                l.timestamp_deleted as l_timestamp_deleted,
                l.timestamp_keyholder_rated as l_timestamp_keyholder_rated,
                l.timestamp_last_updated as l_timestamp_last_updated,
                l.timestamp_locked as l_timestamp_locked,
                u.id as u_id,
                u.build_number_installed as u_build_number_installed,
                u.keyholder_level as u_keyholder_level,
                u.lockee_level as u_lockee_level, 
                u.main_role as u_main_role,
                u.show_combinations_to_keyholders as u_show_combinations_to_keyholders,
                u.status as u_status,
                u.timestamp_last_active as u_timestamp_last_active,
                u.username as u_username
            from Locks_V2 as l, UserIDs_V2 as u where l.shared_id = :sharedID and l.user_id <> :keyholderUserID and l.user_id = u.user_id and l.unlocked = 0 and l.deleted = 1 and l.fake = 0 and l.removed_by_keyholder = 0 order by l.timestamp_deleted desc limit 199");
            $query1->execute(array('sharedID' => $_POST['sharedID'], 'keyholderUserID' => $keyholderUserID));
            foreach ($query1 as $row1) {
                $lockeeUserID = $row1["user_id"];
                $combination = "";
                $mainRole = $row1["u_main_role"];
                if ($mainRole == 1) { $mainRoleLevel = $row1["u_keyholder_level"]; }
                if ($mainRole == 2) { $mainRoleLevel = $row1["u_lockee_level"]; }
                $showCombinationsToKeyholders = $row1["u_show_combinations_to_keyholders"];
                if ($showCombinationsToKeyholders != 1) { $combination = ""; }
                $username = $row1["u_username"];
                if ($username == "") { $username = "CKU".$row1["u_id"]; }
                
                // USERS AVERAGE RATING
                $query2 = $pdo->prepare("select 
                    avg(rating_from_keyholder) as avg_rating_from_keyholders, 
                    count(rating_from_keyholder) as count_rating_from_keyholders 
                from Locks_V2 where user_id = :lockeeUserID and 
                    fake = 0 and 
                    rating_from_keyholder > 0");
                $query2->execute(array('lockeeUserID' => $lockeeUserID));
                foreach ($query2 as $row2) {
                    $averageRatingFromKeyholders = $row2["avg_rating_from_keyholders"];
                    $noOfRatingsFromKeyholders = $row2["count_rating_from_keyholders"];
                }
                $averageRatingFromKeyholders = 0;
                $noOfRatingsFromKeyholders = 0;

                // SAVE TO JSON ARRAY
                array_push($JSON3, array(
                    'jsonNo' => 3,
                    'usersAverageRatingFromKeyholders#' => $averageRatingFromKeyholders,
                    'usersBuildNumberInstalled' => $row1["u_build_number_installed"],
                    'usersCheckInFrequencyInSeconds' => $row1["l_check_in_frequency_in_seconds"],
                    'usersCombination$' => $combination,
                    'usersDateDeleted$' => $row1["l_date_deleted"],
                    'usersDateLocked$' => $row1["l_date_locked"],
                    'usersID' => $row1["u_id"],
                    'usersKeyUsed' => $row1["l_key_used"],
                    'usersLastActive' => $row1["u_timestamp_last_active"],
                    'usersLateCheckInWindowInSeconds' => $row1["l_late_check_in_window_in_seconds"],
                    'usersLockBuildNumber' => $row1["l_build"],
                    'usersLockID' => $row1["l_lock_id"],
                    'usersMainRole' => $mainRole,
                    'usersMainRoleLevel' => $mainRoleLevel,
                    'usersNoOfRatingsFromKeyholders' => $noOfRatingsFromKeyholders,
                    'usersRatingFromKeyholder' => $row1["l_rating_from_keyholder"],
                    'usersResetFrequencyInSeconds' => $row1["l_reset_frequency_in_seconds"],
                    'usersStatus' => $row1["u_status"],
                    'usersTestLock' => $row1["l_test"],
                    'usersTimestampDeleted' => $row1["l_timestamp_deleted"],
                    'usersTimestampKeyholderRated' => $row1["l_timestamp_keyholder_rated"],
                    'usersTimestampLastUpdated' => $row1["l_timestamp_last_updated"],
                    'usersTimestampLocked' => $row1["l_timestamp_locked"],
                    'usersUsername$' => $username
                ));
            }
        }
        echo json_encode(array_merge($JSON1,$JSON2,$JSON3));
    }
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>