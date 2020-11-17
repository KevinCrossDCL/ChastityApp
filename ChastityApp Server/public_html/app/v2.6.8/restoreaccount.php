<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $locksData = "";
    $lockCount = 0;
    $JSON = array();
    
    if ($restoreUserID1 == $restoreUserID2) {
        $query1 = $pdo->prepare("select
            id,
            lock_id,
            lock_group_id,
            shared_id,
            name,
            auto_resets_paused,
            block_users_already_locked,
            bot_chosen,
            build,
            card_info_hidden,
            chances_accumulated_before_freeze,
            check_in_frequency_in_seconds,
            combination,
            cumulative,
            date_last_picked,
            date_locked,
            date_unlocked,
            discard_pile,
            display_in_stats,
            double_up_cards,
            double_up_cards_added,
            double_up_cards_picked,
            fake,
            fixed,
            flag_chosen,
            freeze_cards,
            freeze_cards_added,
            go_again_cards,
            go_again_cards_percentage,
            green_cards,
            greens_picked_since_reset,
            hide_greens_until_picked_count,
            initial_double_up_cards,
            initial_freeze_cards,
            initial_green_cards,
            initial_minutes,
            initial_red_cards,
            initial_reset_cards,
            initial_sticky_cards,
            initial_yellow_add_1_cards,
            initial_yellow_add_2_cards,
            initial_yellow_add_3_cards,
            initial_yellow_cards,
            initial_yellow_minus_1_cards,
            initial_yellow_minus_2_cards,
            key_disabled,
            key_used,
            keyholder_decision_disabled,
            keyholder_disabled_key,
            keyholder_emoji,
            keyholder_emoji_colour,
            last_update_id_seen,
            late_check_in_window_in_seconds,
            lock_frozen_by_card,
            lock_frozen_by_keyholder,
            maximum_auto_resets,
            maximum_minutes,
            maximum_red_cards,
            minimum_minutes,
            minimum_red_cards,
            minutes,
            minutes_added,
            multiple_greens_required,
            no_of_add_1_cards,
            no_of_add_2_cards,
            no_of_add_3_cards,
            no_of_keys_required,
            no_of_minus_1_cards,
            no_of_minus_2_cards,
            no_of_times_auto_reset,
            no_of_times_card_reset,
            no_of_times_full_reset,
            no_of_times_green_card_revealed,
            no_of_times_reset,
            permanent,
            picked_count,
            picked_count_including_yellows,
            picked_count_since_reset,
            random_cards_added,
            rating,
            ready_to_unlock,
            red_cards,
            red_cards_added,
            regularity,
            removed_by_keyholder,
            reset_cards,
            reset_cards_added,
            reset_cards_picked,
            reset_frequency_in_seconds,
            show_fake_card_count,
            simulation_average_minutes_locked,
            simulation_best_case_minutes_locked,
            simulation_worst_case_minutes_locked,
            sticky_cards,
            test,
            time_left_until_next_chance_before_freeze,
            timer_hidden,
            timestamp_clean_time_request_blocked_until,
            timestamp_denied_clean_time,
            timestamp_ended_clean_time,
            timestamp_frozen_by_card,
            timestamp_frozen_by_keyholder,
            timestamp_last_auto_reset,
            timestamp_last_card_reset,
            timestamp_last_checked_in,
            timestamp_last_full_reset,
            timestamp_last_picked,
            timestamp_last_reset,
            timestamp_last_synced,
            timestamp_last_updated,
            timestamp_locked,
            timestamp_rated,
            timestamp_real_last_picked,
            timestamp_removed_by_keyholder,
            timestamp_requested_clean_time,
            timestamp_requested_keyholders_decision,
            timestamp_started_clean_time,
            timestamp_unfreezes,
            timestamp_unfrozen,
            timestamp_unlocked,
            total_time_cleaning,
            total_time_frozen,
            trust_keyholder,
            unlocked,
            user_emoji,
            user_emoji_colour,
            version,
            yellow_cards 
        from Locks_V2 where user_id = :restoreUserID and deleted = 0 order by lock_id asc");
        $query1->execute(array('restoreUserID' => $restoreUserID1));
        if ($query1->rowCount() > 0) {
            foreach ($query1 as $row1) {
                $hiddenFromOwner = 0;
                $timestampHiddenFromOwner = 0;
                $removedByKeyholder = $row1["removed_by_keyholder"];
                $timestampRemovedByKeyholder = $row1["timestamp_removed_by_keyholder"];
                $id = $row1["id"];
                $lockCount++;
                $lockedBy = "";
                $keyholderEmoji = $row1["keyholder_emoji"];
                $keyholderEmojiColour = $row1["keyholder_emoji_colour"];
                if ($keyholderEmojiColour == 0) { $keyholderEmojiColour = 1; }
                $keyholderID = 0;
                $keyholderUsername = "";
                $userEmoji = $row1["user_emoji"];
                $userEmojiColour = $row1["user_emoji_colour"];
                if ($userEmojiColour == 0) { $userEmojiColour = 1; }
                $sharedID = $row1["shared_id"];
                $lockName = $row1["name"];
                $updates = array();
                if ($sharedID != "" && $removedByKeyholder == 0) {
                    $query2 = $pdo->prepare("select
                        l.id as l_id, 
                        l.shared_id as l_shared_id,
                        l.user_id as l_user_id,
                        s.hide_from_owner as s_hide_from_owner, 
                        s.name as s_name,
                        s.share_id as s_shared_id, 
                        s.timestamp_hidden as s_timestamp_hidden, 
                        s.user_id as s_user_id, 
                        u.build_number_installed as u_build_number_installed, 
                        u.id as u_id, 
                        u.keyholder_level as u_keyholder_level, 
                        u.lockee_level as u_lockee_level, 
                        u.main_role as u_main_role, 
                        u.timestamp_last_active as u_timestamp_last_active, 
                        u.user_id as u_user_id, 
                        u.username as u_username
                    from 
                        Locks_V2 as l, 
                        ShareableLocks_V2 as s, 
                        UserIDs_V2 as u
                    where 
                        l.id = :id and 
                        l.shared_id = s.share_id and 
                        s.user_id = u.user_id");
                    $query2->execute(array('id' => $id));
                    if ($query2->rowCount() == 1) {
                        foreach ($query2 as $row2) {
                            $keyholderBuildNumberInstalled = $row2["u_build_number_installed"];
                            $keyholderID = $row2["u_id"];
                            $keyholderLastActive = $row2["u_timestamp_last_active"];
                            $keyholderMainRole = $row2["u_main_role"];
                            $keyholderMainRoleLevel = 0;
                            if ($keyholderMainRole == 1) {
                                $keyholderMainRoleLevel = $row2["u_keyholder_level"];
                            }
                            if ($keyholderMainRole == 2) {
                                $keyholderMainRoleLevel = $row2["u_lockee_level"];
                            }
                            $keyholderStatus = $row2["u_status"];
                            $keyholderUsername = $row2["u_username"];
                            if ($keyholderUsername == "") {
                                $keyholderUsername = "CKU".$keyholderID;
                            }
                            $hiddenFromOwner = $row2["s_hide_from_owner"];
                            if ($row2["s_name"] != "") { $lockName = $row2["s_name"]; }
                            $timestampHiddenFromOwner = $row2["s_timestamp_hidden"];
                        }
                    }
                    
                    $lastUpdateIDSeen = $row1["last_update_id_seen"];
                    $query2 = $pdo->prepare("select id from ModifiedLocks_V2 where user_id = :restoreUserID and lock_id = :id order by id desc limit 1");
                    $query2->execute(array('restoreUserID' => $restoreUserID1, 'id' => $id));
                    foreach ($query2 as $row2) {
                        if ($row2["id"] > $lastUpdateIDSeen) { $lastUpdateIDSeen = $row2["id"]; }
                    }
                }
                
                array_push($JSON, array(
                'id' => $row1["lock_id"],
                'groupID' => $row1["lock_group_id"],
                'sharedID$' => $sharedID,
                'lockName$' => $lockName,
                'autoResetsPaused' => $row1["auto_resets_paused"],
                'blockUsersAlreadyLocked' => $row1["block_users_already_locked"],
                'botChosen' => $row1["bot_chosen"],
                'build' => $row1["build"],
                'cardInfoHidden' => $row1["card_info_hidden"],
                'chancesAccumulatedBeforeFreeze' => $row1["chances_accumulated_before_freeze"],
                'checkInFrequencyInSeconds' => $row1["check_in_frequency_in_seconds"],
                'combination$' => $row1["combination"],
                'cumulative' => $row1["cumulative"],
                'dateLastPicked$' => $row1["date_last_picked"],
                'dateLocked$' => $row1["date_locked"],
                'dateUnlocked$' => $row1["date_unlocked"],
                'discardPile$' => $row1["discard_pile"],
                'displayInStats' => $row1["display_in_stats"],
                'doubleUpCards' => $row1["double_up_cards"],
                'doubleUpCardsAdded' => $row1["double_up_cards_added"],
                'doubleUpCardsPicked' => $row1["double_up_cards_picked"],
                'emojiChosen' => $userEmoji,
                'emojiColourSelected' => $userEmojiColour,
                'fake' => $row1["fake"],
                'fixed' => $row1["fixed"],
                'flagChosen' => $row1["flag_chosen"],
                'freezeCards' => $row1["freeze_cards"],
                'freezeCardsAdded' => $row1["freeze_cards_added"],
                'goAgainCards' => $row1["go_again_cards"],
                'goAgainCardsPercentage#' => $row1["go_again_cards_percentage"],
                'greenCards' => $row1["green_cards"],
                'greensPickedSinceReset' => $row1["greens_picked_since_reset"],
                'hiddenFromOwner' => $hiddenFromOwner,
                'hideGreensUntilPickedCount' => $row1["hide_greens_until_picked_count"],
                'initialDoubleUpCards' => $row1["initial_double_up_cards"],
                'initialFreezeCards' => $row1["initial_freeze_cards"],
                'initialGreenCards' => $row1["initial_green_cards"],
                'initialMinutes' => $row1["initial_minutes"],
                'initialRedCards' => $row1["initial_red_cards"],
                'initialResetCards' => $row1["initial_reset_cards"],
                'initialStickyCards' => $row1["initial_sticky_cards"],
                'initialYellowAdd1Cards' => $row1["initial_yellow_add_1_cards"],
                'initialYellowAdd2Cards' => $row1["initial_yellow_add_2_cards"],
                'initialYellowAdd3Cards' => $row1["initial_yellow_add_3_cards"],
                'initialYellowCards' => $row1["initial_yellow_cards"],
                'initialYellowMinus1Cards' => $row1["initial_yellow_minus_1_cards"],
                'initialYellowMinus2Cards' => $row1["initial_yellow_minus_2_cards"],
                'keyDisabled' => $row1["key_disabled"],
                'keyholderBuildNumberInstalled' => $keyholderBuildNumberInstalled,
                'keyholderDecisionDisabled' => $row1["keyholder_decision_disabled"],
                'keyholderDisabledKey' => $row1["keyholder_disabled_key"],
                'keyholderEmojiChosen' => $keyholderEmoji,
                'keyholderEmojiColourSelected' => $keyholderEmojiColour,
                'keyholderID' => $keyholderID,
                'keyholderLastActive' => $keyholderLastActive,
                'keyholderMainRole' => $keyholderMainRole,
                'keyholderMainRoleLevel' => $keyholderMainRoleLevel,
                'keyholderStatus' => $keyholderStatus,
                'keyholderUsername$' => $keyholderUsername,
                'keyUsed' => $row1["key_used"],
                'lastUpdateIDSeen' => $lastUpdateIDSeen,
                'lateCheckInWindowInSeconds' => $row1["late_check_in_window_in_seconds"],
                'lockFrozenByCard' => $row1["lock_frozen_by_card"],
                'lockFrozenByKeyholder' => $row1["lock_frozen_by_keyholder"],
                'maximumAutoResets' => $row1["maximum_auto_resets"],
                'maximumMinutes' => $row1["maximum_minutes"],
                'maximumRedCards' => $row1["maximum_red_cards"],
                'minimumMinutes' => $row1["minimum_minutes"],
                'minimumRedCards' => $row1["minimum_red_cards"],
                'minutes' => $row1["minutes"],
                'minutesAdded' => $row1["minutes_added"],
                'multipleGreensRequired' => $row1["multiple_greens_required"],
                'noOfAdd1Cards' => $row1["no_of_add_1_cards"],
                'noOfAdd2Cards' => $row1["no_of_add_2_cards"],
                'noOfAdd3Cards' => $row1["no_of_add_3_cards"],
                'noOfKeysRequired' => $row1["no_of_keys_required"],
                'noOfMinus1Cards' => $row1["no_of_minus_1_cards"],
                'noOfMinus2Cards' => $row1["no_of_minus_2_cards"],
                'noOfTimesAutoReset' => $row1["no_of_times_auto_reset"],
                'noOfTimesCardReset' => $row1["no_of_times_card_reset"],
                'noOfTimesFullReset' => $row1["no_of_times_full_reset"],
                'noOfTimesGreenCardRevealed' => $row1["no_of_times_green_card_revealed"],
                'noOfTimesReset' => $row1["no_of_times_reset"],
                'permanent' => $row1["permanent"],
                'pickedCount' => $row1["picked_count"],
                'pickedCountIncludingYellows' => $row1["picked_count_including_yellows"],
                'pickedCountSinceReset' => $row1["picked_count_since_reset"],
                'randomCardsAdded' => $row1["random_cards_added"],
                'rating' => $row1["rating"],
                'readyToUnlock' => $row1["ready_to_unlock"],
                'redCards' => $row1["red_cards"],
                'redCardsAdded' => $row1["red_cards_added"],
                'regularity#' => $row1["regularity"],
                'removedByKeyholder' => $row1["removed_by_keyholder"],
                'resetCards' => $row1["reset_cards"],
                'resetCardsAdded' => $row1["reset_cards_added"],
                'resetCardsPicked' => $row1["reset_cards_picked"],
                'resetFrequencyInSeconds' => $row1["reset_frequency_in_seconds"],
                'rowInDB' => $row1["id"],
                'simulationAverageMinutesLocked' => $row1["simulation_average_minutes_locked"],
                'simulationBestCaseMinutesLocked' => $row1["simulation_best_case_minutes_locked"],
                'simulationWorstCaseMinutesLocked' => $row1["simulation_worst_case_minutes_locked"],
                'stickyCards' => $row1["sticky_cards"],
                'test' => $row1["test"],
                'timeLeftUntilNextChanceBeforeFreeze' => $row1["time_left_until_next_chance_before_freeze"],
                'timerHidden' => $row1["timer_hidden"],
                'timestampCleanTimeRequestBlockedUntil' => $row1["timestamp_clean_time_blocked_until"],
                'timestampDeniedCleanTime' => $row1["timestamp_denied_clean_time"],
                'timestampEndedCleanTime' => $row1["timestamp_ended_clean_time"],
                'timestampFrozenByCard' => $row1["timestamp_frozen_by_card"],
                'timestampFrozenByKeyholder' => $row1["timestamp_frozen_by_keyholder"],
                'timestampHiddenFromOwner' => $timestampHiddenFromOwner,
                'timestampLastAutoReset' => $row1["timestamp_last_auto_reset"],
                'timestampLastCardReset' => $row1["timestamp_last_card_reset"],
                'timestampLastCheckedIn' => $row1["timestamp_last_checked_in"],
                'timestampLastFullReset' => $row1["timestamp_last_full_reset"],
                'timestampLastPicked' => $row1["timestamp_last_picked"],
                'timestampLastReset' => $row1["timestamp_last_reset"],
                'timestampLastSynced' => $row1["timestamp_last_synced"],
                'timestampLastUpdated' => $row1["timestamp_last_updated"],
                'timestampLocked' => $row1["timestamp_locked"],
                'timestampRated' => $row1["timestamp_rated"],
                'timestampRealLastPicked' => $row1["timestamp_real_last_picked"],
                'timestampRemovedByKeyholder' => $row1["timestamp_removed_by_keyholder"],
                'timestampRequestedCleanTime' => $row1["timestamp_requested_clean_time"],
                'timestampRequestedKeyholdersDecision' => $row1["timestamp_requested_keyholders_decision"],
                'timestampStartedCleanTime' => $row1["timestamp_started_clean_time"],
                'timestampUnfreezes' => $row1["timestamp_unfreezes"],
                'timestampUnfrozen' => $row1["timestamp_unfrozen"],
                'timestampUnlocked' => $row1["timestamp_unlocked"],
                'totalTimeCleaning' => $row1["total_time_cleaning"],
                'totalTimeFrozen' => $row1["total_time_frozen"],
                'trustKeyholder' => $row1["trust_keyholder"],
                'unlocked' => $row1["unlocked"],
                'updates' => $updates,
                'version$' => $row1["version"],
                'yellowCards' => $row1["yellow_cards"]));
            }
        }
        if ($lockCount > 0) {
            echo json_encode($JSON);
        } else {
            $query = $pdo->prepare("select id from ShareableLocks_V2 where user_id = :restoreUserID and hide_from_owner = 0");
            $query->execute(array('restoreUserID' => $restoreUserID1));
            if ($query->rowCount() > 0) {
                echo "Keyholder";
            } else {
                $query = $pdo->prepare("select id from UserIDs_V2 where user_id = :restoreUserID and deleted = 0");
                $query->execute(array('restoreUserID' => $restoreUserID1));
                if ($query->rowCount() > 0) {
                    echo "No Locks";
                } else {
                    echo "No User ID";
                }
            }
        }
    } else {
        echo "Invalid Request";
    }
    $query = null;
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>