<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $lockeeID = $row["id"];
                $username = $row["username"];
                if ($username == "") { $username = "CKU".$lockeeID; }
            }
        } elseif ($query->rowCount() == 0) {
            $query = $pdo->prepare("insert into UserIDs_V2 (user_id, admin_notes, created, last_active, version_installed, build_number_installed) values (:userID, :adminNotes, NOW(), NOW(), :versionInstalled, :buildNumberInstalled)");
            $query->execute(array('userID' => $userID1, 'adminNotes' => 'Account inserted after lock(s) created', 'versionInstalled' => $_POST['version'], 'buildNumberInstalled' => $_POST['build']));
            $query2 = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
            $query2->execute(array('userID' => $userID1));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $lockeeID = $row2["id"];
                    $username = $row2["username"];
                    if ($username == "") { $username = "CKU".$lockeeID; }
                }
            }
        }
        $query = $pdo->prepare("select id from Locks_V2 where user_id = :userID and lock_id = :lockID");
        $query->execute(array('userID' => $userID1, 'lockID' => $_POST['lockID']));
        if ($query->rowCount() == 0) {
            $query = $pdo->prepare("insert into Locks_V2 (
            id,
            lock_id,
            user_id,
            shared_id,
            name,
            auto_resets_paused,
            block_bot_from_unlocking,
            block_users_already_locked,
            bot_chosen, 
            build,
            card_info_hidden,
            chances_accumulated_before_freeze,
            check_in_frequency_in_seconds,
            combination, 
            combination_backup,
            cumulative,
            date_last_picked,
            date_locked, 
            date_unlocked,
            discard_pile,
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
            keyholder_id,
            last_update_id_seen,
            late_check_in_window_in_seconds,
            lock_frozen_by_card,
            lock_frozen_by_keyholder,
            lock_group_id,
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
            platform,
            random_cards_added, 
            rating,
            ready_to_unlock,
            red_cards, 
            red_cards_added, 
            regularity, 
            reset_cards, 
            reset_cards_added, 
            reset_cards_picked, 
            reset_frequency_in_seconds,
            simulation_average_minutes_locked,
            simulation_best_case_minutes_locked,
            simulation_worst_case_minutes_locked,
            sticky_cards,
            test,
            time_left_until_next_chance_before_freeze,
            timer_hidden,
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
            timestamp_locked, 
            timestamp_rated,
            timestamp_real_last_picked,
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
            yellow_cards) values (
                '',
                :lockID, 
                :userID,
                :sharedID,
                :name,
                :autoResetsPaused,
                :blockBotFromUnlocking,
                :blockUsersAlreadyLocked,
                :botChosen,
                :build,
                :cardInfoHidden,
                :chancesAccumulatedBeforeFreeze,
                :checkInFrequencyInSeconds,
                :combination, 
                :combinationBackup,
                :cumulative,
                :dateLastPicked,
                :dateLocked, 
                :dateUnlocked, 
                :discardPile,
                :doubleUpCards, 
                :doubleUpCardsAdded, 
                :doubleUpCardsPicked, 
                :fake, 
                :fixed,
                :flagChosen,
                :freezeCards,
                :freezeCardsAdded,
                :goAgainCards,
                :goAgainCardsPercentage,
                :greenCards, 
                :greensPickedSinceReset,
                :hideGreensUntilPickCount,
                :initialDoubleUpCards, 
                :initialFreezeCards,
                :initialGreenCards, 
                :initialMinutes,
                :initialRedCards,
                :initialResetCards,
                :initialStickyCards,
                :initialYellowAdd1Cards, 
                :initialYellowAdd2Cards, 
                :initialYellowAdd3Cards, 
                :initialYellowCards, 
                :initialYellowMinus1Cards, 
                :initialYellowMinus2Cards,
                :keyDisabled,
                :keyUsed, 
                :keyholderDecisionDisabled,
                :keyholderDisabledKey,
                :keyholderID,
                :lastUpdateIDSeen,
                :lateCheckInWindowInSeconds,
                :lockFrozenByCard,
                :lockFrozenByKeyholder,
                :lockGroupID,
                :maximumAutoResets,
                :maximumMinutes,
                :maximumRedCards,
                :minimumMinutes,
                :minimumRedCards,
                :minutes,
                :minutesAdded,
                :multipleGreensRequired,
                :noOfAdd1Cards, 
                :noOfAdd2Cards, 
                :noOfAdd3Cards, 
                :noOfKeysRequired, 
                :noOfMinus1Cards, 
                :noOfMinus2Cards, 
                :noOfTimesAutoReset,
                :noOfTimesCardReset,
                :noOfTimesFullReset,
                :noOfTimesGreenCardRevealed,
                :noOfTimesReset,
                :permanent,
                :pickedCount, 
                :pickedCountIncludingYellows,
                :pickedCountSinceReset,
                :platform,
                :randomCardsAdded, 
                :rating,
                :readyToUnlock,
                :redCards, 
                :redCardsAdded, 
                :regularity, 
                :resetCards, 
                :resetCardsAdded, 
                :resetCardsPicked,
                :resetFrequencyInSeconds,
                :simulationAverageMinutesLocked,
                :simulationBestCaseMinutesLocked,
                :simulationWorstCaseMinutesLocked,
                :stickyCards,
                :test,
                :timeLeftUntilNextChanceBeforeFreeze,
                :timerHidden,
                :timestampEndedCleanTime,
                :timestampFrozenByCard, 
                :timestampFrozenByKeyholder, 
                :timestampLastAutoReset,
                :timestampLastCardReset,
                :timestampLastCheckedIn,
                :timestampLastFullReset,
                :timestampLastPicked, 
                :timestampLastReset,
                :timestampLastSynced,
                :timestampLocked, 
                :timestampRated,
                :timestampRealLastPicked,
                :timestampRequestedCleanTime,
                :timestampRequestedKeyholdersDecision,
                :timestampStartedCleanTime,
                :timestampUnfreezes,
                :timestampUnfrozen,
                :timestampUnlocked,
                :totalTimeCleaning,
                :totalTimeFrozen,
                :trustKeyholder, 
                :unlocked, 
                :userEmoji,
                :userEmojiColour,
                :version,
                :yellowCards)");
            $query->execute(array(
                'lockID' => $_POST['lockID'], 
                'userID' => $userID1,
                'sharedID' => $_POST['sharedID'],
                'name' => $_POST['lockName'],
                'autoResetsPaused' => $_POST['autoResetsPaused'],
                'blockBotFromUnlocking' => $_POST['blockBotFromUnlocking'],
                'blockUsersAlreadyLocked' => $_POST['blockUsersAlreadyLocked'],
                'botChosen' => $_POST['botChosen'], 
                'build' => $_POST['build'], 
                'cardInfoHidden' => $_POST['cardInfoHidden'],
                'chancesAccumulatedBeforeFreeze' => $_POST['chancesAccumulatedBeforeFreeze'],
                'checkInFrequencyInSeconds' => $_POST['checkInFrequencyInSeconds'],
                'combination' => $_POST['combination'], 
                'combinationBackup' => $_POST['combination'],
                'cumulative' => $_POST['cumulative'],
                'dateLastPicked' => $_POST['dateLastPicked'], 
                'dateLocked' => $_POST['dateLocked'], 
                'dateUnlocked' => $_POST['dateUnlocked'], 
                'discardPile' => $_POST['discardPile'],
                'doubleUpCards' => $_POST['doubleUpCards'], 
                'doubleUpCardsAdded' => $_POST['doubleUpCardsAdded'], 
                'doubleUpCardsPicked' => $_POST['doubleUpCardsPicked'], 
                'fake' => $_POST['fake'], 
                'fixed' => $_POST['fixed'],
                'flagChosen' => $_POST['flagChosen'],
                'freezeCards' => $_POST['freezeCards'],
                'freezeCardsAdded' => $_POST['freezeCardsAdded'],
                'goAgainCards' => $_POST['goAgainCards'],
                'goAgainCardsPercentage' => $_POST['goAgainCardsPercentage'],
                'greenCards' => $_POST['greenCards'], 
                'greensPickedSinceReset' => $_POST['greensPickedSinceReset'], 
                'hideGreensUntilPickCount' => $_POST['hideGreensUntilPickCount'], 
                'initialDoubleUpCards' => $_POST['initialDoubleUpCards'], 
                'initialFreezeCards' => $_POST['initialFreezeCards'], 
                'initialGreenCards' => $_POST['initialGreenCards'], 
                'initialMinutes' => $_POST['initialMinutes'], 
                'initialRedCards' => $_POST['initialRedCards'], 
                'initialResetCards' => $_POST['initialResetCards'], 
                'initialStickyCards' => $_POST['initialStickyCards'], 
                'initialYellowAdd1Cards' => $_POST['initialYellowAdd1Cards'], 
                'initialYellowAdd2Cards' => $_POST['initialYellowAdd2Cards'], 
                'initialYellowAdd3Cards' => $_POST['initialYellowAdd3Cards'], 
                'initialYellowCards' => $_POST['initialYellowCards'], 
                'initialYellowMinus1Cards' => $_POST['initialYellowMinus1Cards'], 
                'initialYellowMinus2Cards' => $_POST['initialYellowMinus2Cards'],
                'keyDisabled' => $_POST['keyDisabled'], 
                'keyUsed' => $_POST['keyUsed'], 
                'keyholderDecisionDisabled' => $_POST['keyholderDecisionDisabled'],
                'keyholderDisabledKey' => $_POST['keyholderDisabledKey'], 
                'keyholderID' => $_POST['keyholderID'], 
                'lastUpdateIDSeen' => $_POST['lastUpdateIDSeen'],
                'lateCheckInWindowInSeconds' => $_POST['lateCheckInWindowInSeconds'],
                'lockFrozenByCard' => $_POST['lockFrozenByCard'], 
                'lockFrozenByKeyholder' => $_POST['lockFrozenByKeyholder'], 
                'lockGroupID' => $_POST['groupID'],
                'maximumAutoResets' => $_POST['maximumAutoResets'],
                'maximumMinutes' => $_POST['maximumMinutes'], 
                'maximumRedCards' => $_POST['maximumRedCards'], 
                'minimumMinutes' => $_POST['minimumMinutes'], 
                'minimumRedCards' => $_POST['minimumRedCards'], 
                'minutes' => $_POST['minutes'],
                'minutesAdded' => $_POST['minutesAdded'],
                'multipleGreensRequired' => $_POST['multipleGreensRequired'], 
                'noOfAdd1Cards' => $_POST['noOfAdd1Cards'], 
                'noOfAdd2Cards' => $_POST['noOfAdd2Cards'], 
                'noOfAdd3Cards' => $_POST['noOfAdd3Cards'], 
                'noOfKeysRequired' => $_POST['noOfKeysRequired'], 
                'noOfMinus1Cards' => $_POST['noOfMinus1Cards'], 
                'noOfMinus2Cards' => $_POST['noOfMinus2Cards'], 
                'noOfTimesAutoReset' => $_POST['noOfTimesAutoReset'],
                'noOfTimesCardReset' => $_POST['noOfTimesCardReset'],
                'noOfTimesFullReset' => $_POST['noOfTimesFullReset'],
                'noOfTimesGreenCardRevealed' => $_POST['noOfTimesGreenCardRevealed'], 
                'noOfTimesReset' => $_POST['noOfTimesReset'],
                'permanent' => $_POST['permanent'],
                'pickedCount' => $_POST['pickedCount'], 
                'pickedCountIncludingYellows' => $_POST['pickedCountIncludingYellows'], 
                'pickedCountSinceReset' => $_POST['pickedCountSinceReset'], 
                'platform' => $_POST['platform'], 
                'randomCardsAdded' => $_POST['randomCardsAdded'], 
                'rating' => $_POST['rating'], 
                'readyToUnlock' => $_POST['readyToUnlock'], 
                'redCards' => $_POST['redCards'], 
                'redCardsAdded' => $_POST['redCardsAdded'], 
                'regularity' => $_POST['regularity'], 
                'resetCards' => $_POST['resetCards'], 
                'resetCardsAdded' => $_POST['resetCardsAdded'], 
                'resetCardsPicked' => $_POST['resetCardsPicked'], 
                'resetFrequencyInSeconds' => $_POST['resetFrequencyInSeconds'],
                'simulationAverageMinutesLocked' => $_POST['simulationAverageMinutesLocked'],
                'simulationBestCaseMinutesLocked' => $_POST['simulationBestCaseMinutesLocked'],
                'simulationWorstCaseMinutesLocked' => $_POST['simulationWorstCaseMinutesLocked'],
                'stickyCards' => $_POST['stickyCards'], 
                'test' => $_POST['test'],
                'timeLeftUntilNextChanceBeforeFreeze' => $_POST['timeLeftUntilNextChanceBeforeFreeze'],
                'timerHidden' => $_POST['timerHidden'], 
                'timestampEndedCleanTime' => $_POST['timestampEndedCleanTime'],
                'timestampFrozenByCard' => $_POST['timestampFrozenByCard'], 
                'timestampFrozenByKeyholder' => $_POST['timestampFrozenByKeyholder'], 
                'timestampLastAutoReset' => $_POST['timestampLastAutoReset'],
                'timestampLastCardReset' => $_POST['timestampLastCardReset'],
                'timestampLastCheckedIn' => $_POST['timestampLastCheckedIn'],
                'timestampLastFullReset' => $_POST['timestampLastFullReset'],
                'timestampLastPicked' => $_POST['timestampLastPicked'], 
                'timestampLastReset' => $_POST['timestampLastReset'], 
                'timestampLastSynced' => time(), 
                'timestampLocked' => $_POST['timestampLocked'], 
                'timestampRated' => $_POST['timestampRated'],
                'timestampRealLastPicked' => $_POST['timestampRealLastPicked'],
                'timestampRequestedCleanTime' => $_POST['timestampRequestedCleanTime'],
                'timestampRequestedKeyholdersDecision' => $_POST['timestampRequestedKeyholdersDecision'],
                'timestampStartedCleanTime' => $_POST['timestampStartedCleanTime'],
                'timestampUnfreezes' => $_POST['timestampUnfreezes'], 
                'timestampUnfrozen' => $_POST['timestampUnfrozen'], 
                'timestampUnlocked' => $_POST['timestampUnlocked'], 
                'totalTimeCleaning' => $_POST['totalTimeCleaning'], 
                'totalTimeFrozen' => $_POST['totalTimeFrozen'], 
                'trustKeyholder' => $_POST['trustKeyholder'], 
                'unlocked' => $_POST['unlocked'],
                'userEmoji' => $_POST['emojiChosen'],
                'userEmojiColour' => $_POST['emojiColourSelected'],
                'version' => $_POST['version'], 
                'yellowCards' => $_POST['yellowCards']));
            if ($pdo->lastInsertId() > 0) {
                array_push($JSON, array('variable' => 'lastInsertID', 'value' => $pdo->lastInsertId()));
                array_push($JSON, array('variable' => 'timestampLastSynced', 'value' => time()));
            }
            if ($_POST['sharedID'] != "" && $_POST['fake'] == "0") {
                $query = $pdo->prepare("select u.id as u_id, u.user_id as u_user_id, u.platform as u_platform, u.push_notifications_disabled as u_push_notifications_disabled, u.status as u_status, u.token as u_token, u.build_number_installed as u_build_number_installed, s.name as s_name, s.share_id as s_share_id, s.user_id from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :sharedID and s.user_id = u.user_id and s.hide_from_owner = 0");
                $query->execute(array('sharedID' => $_POST['sharedID']));
                if ($query->rowCount() == 1) {
                    foreach ($query as $row) {
                        $lockName = $row["s_name"];
                        $keyholderID = $row["u_id"];
                        $keyholderUserID = $row["u_user_id"];
                        $keyholderPlatform = $row["u_platform"];
                        $keyholderPushNotificationsDisabled = $row["u_push_notifications_disabled"];
                        $keyholderStatus = $row["u_status"];
                        $keyholderToken = $row["u_token"];
                        $keyholderBuildNumberInstalled = $row["u_build_number_installed"];
                        if ($userID1 != $keyholderUserID && $keyholderPushNotificationsDisabled != "1" && $keyholderToken != "" && $keyholderStatus != 3) {
                            if ($username != "") {
                                if ($keyholderPlatform == "android") {
                                    if ($keyholderBuildNumberInstalled < 115) {
                                        if ($lockName == "") { SendPushNotificationAndroid($keyholderToken, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                        if ($lockName != "") { SendPushNotificationAndroid($keyholderToken, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName, $appName); }
                                    } else {
                                        if ($lockName == "") { SendPushNotificationAndroidFCM($keyholderToken, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                                        if ($lockName != "") { SendPushNotificationAndroidFCM($keyholderToken, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                                    }
                                }
                                if ($keyholderPlatform == "ios") {
                                    if ($lockName == "") { SendPushNotificationiOS($keyholderToken, $username." has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                                    if ($lockName != "") { SendPushNotificationiOS($keyholderToken, $username." has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                                }
                            } else {
                                if ($keyholderPlatform == "android") {
                                    if ($keyholderBuildNumberInstalled < 115) {
                                        if ($lockName == "") { SendPushNotificationAndroid($keyholderToken, "A user has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID'], $appName); }
                                        if ($lockName != "") { SendPushNotificationAndroid($keyholderToken, "A user has just loaded your shared lock. Shared Lock Name: ".$lockName, $appName); }
                                    } else {
                                        if ($lockName == "") { SendPushNotificationAndroidFCM($keyholderToken, "A user has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                                        if ($lockName != "") { SendPushNotificationAndroidFCM($keyholderToken, "A user has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                                    }
                                }
                                if ($keyholderPlatform == "ios") {
                                    if ($lockName == "") { SendPushNotificationiOS($keyholderToken, "A user has just loaded your shared lock. Shared Lock ID: ".$_POST['sharedID']); }
                                    if ($lockName != "") { SendPushNotificationiOS($keyholderToken, "A user has just loaded your shared lock. Shared Lock Name: ".$lockName); }
                                }
                            }
                            
                        }
                        
                        if ($userID1 != $keyholderUserID) {
                            $query = $pdo->prepare("insert into RecentActivity (
                                id, 
                                user_id, 
                                activity_type,
                                lock_id,
                                mentioned_user_id,
                                share_id,
                                test_lock,
                                timestamp_added) values (
                                    '', 
                                    :userID, 
                                    :activityType,
                                    :lockID,
                                    :mentionedUserID, 
                                    :shareID,
                                    :testLock,
                                    :timestampAdded)");
                            $query->execute(array(
                                'userID' => $keyholderUserID, 
                                'activityType' => "LoadedSharedLock",
                                'lockID' => 0,
                                'mentionedUserID' => $lockeeID, 
                                'shareID' => $_POST['sharedID'],
                                'testLock' => $_POST['test'],
                                'timestampAdded' => time()));
                        }
                    }
                }
            }
        } else {
            $query = $pdo->prepare("update Locks_V2 set 
            name = :lockName,
            block_bot_from_unlocking = :blockBotFromUnlocking,
            chances_accumulated_before_freeze = :chancesAccumulatedBeforeFreeze,
            date_deleted = :dateDeleted,
            date_last_picked = :dateLastPicked, 
            date_unlocked = :dateUnlocked, 
            deleted = :deleted,
            discard_pile = :discardPile,
            double_up_cards = :doubleUpCards, 
            double_up_cards_added = :doubleUpCardsAdded, 
            double_up_cards_picked = :doubleUpCardsPicked, 
            flag_chosen = :flagChosen,
            freeze_cards = :freezeCards,
            freeze_cards_added = :freezeCardsAdded,
            go_again_cards = :goAgainCards,
            go_again_cards_percentage = :goAgainCardsPercentage,
            green_cards = :greenCards, 
            greens_picked_since_reset = :greensPickedSinceReset,
            key_disabled = :keyDisabled,
            key_used = :keyUsed, 
            keyholder_id = :keyholderID,
            last_update_id_seen = :lastUpdateIDSeen,
            lock_frozen_by_card = :lockFrozenByCard,
            lock_frozen_by_keyholder = :lockFrozenByKeyholder,
            minutes = :minutes,
            minutes_added = :minutesAdded,
            no_of_add_1_cards = :noOfAdd1Cards, 
            no_of_add_2_cards = :noOfAdd2Cards, 
            no_of_add_3_cards = :noOfAdd3Cards, 
            no_of_minus_1_cards = :noOfMinus1Cards, 
            no_of_minus_2_cards = :noOfMinus2Cards, 
            no_of_keys_required = :noOfKeysRequired,
            no_of_times_auto_reset = :noOfTimesAutoReset,
            no_of_times_card_reset = :noOfTimesCardReset,
            no_of_times_full_reset = :noOfTimesFullReset,
            no_of_times_green_card_revealed = :noOfTimesGreenCardRevealed,
            no_of_times_reset = :noOfTimesReset,
            picked_count = :pickedCount, 
            picked_count_including_yellows = :pickedCountIncludingYellows,
            picked_count_since_reset = :pickedCountSinceReset,
            random_cards_added = :randomCardsAdded, 
            rating = :rating,
            ready_to_unlock = :readyToUnlock,
            red_cards = :redCards, 
            red_cards_added = :redCardsAdded, 
            reset_cards = :resetCards, 
            reset_cards_added = :resetCardsAdded, 
            reset_cards_picked = :resetCardsPicked, 
            sticky_cards = :stickyCards,
            test = :test,
            time_left_until_next_chance_before_freeze = :timeLeftUntilNextChanceBeforeFreeze,
            timestamp_deleted = :timestampDeleted,
            timestamp_ended_clean_time = :timestampEndedCleanTime,
            timestamp_frozen_by_card = :timestampFrozenByCard, 
            timestamp_frozen_by_keyholder = :timestampFrozenByKeyholder, 
            timestamp_last_auto_reset = :timestampLastAutoReset,
            timestamp_last_card_reset = :timestampLastCardReset,
            timestamp_last_checked_in = :timestampLastCheckedIn,
            timestamp_last_full_reset = :timestampLastFullReset,
            timestamp_last_picked = :timestampLastPicked, 
            timestamp_last_reset = :timestampLastReset,
            timestamp_last_synced = :timestampLastSynced,
            timestamp_rated = :timestampRated,
            timestamp_real_last_picked = :timestampRealLastPicked,
            timestamp_requested_clean_time = :timestampRequestedCleanTime,
            timestamp_requested_keyholders_decision = :timestampRequestedKeyholdersDecision,
            timestamp_started_clean_time = :timestampStartedCleanTime,
            timestamp_unfreezes = :timestampUnfreezes, 
            timestamp_unfrozen = :timestampUnfrozen, 
            timestamp_unlocked = :timestampUnlocked, 
            total_time_cleaning = :totalTimeCleaning, 
            total_time_frozen = :totalTimeFrozen, 
            trust_keyholder = :trustKeyholder,
            unlocked = :unlocked, 
            user_emoji = :userEmoji,
            user_emoji_colour = :userEmojiColour,
            yellow_cards = :yellowCards where user_id = :userID1 and lock_id = :lockID");
            $result = $query->execute(array(
                'userID1' => $userID1, 
                'lockID' => $_POST['lockID'],
                'lockName' => $_POST['lockName'],
                'blockBotFromUnlocking' => $_POST['blockBotFromUnlocking'],
                'chancesAccumulatedBeforeFreeze' => $_POST['chancesAccumulatedBeforeFreeze'],
                'dateDeleted' => $_POST['dateDeleted'],
                'dateLastPicked' => $_POST['dateLastPicked'], 
                'dateUnlocked' => $_POST['dateUnlocked'], 
                'deleted' => $_POST['deleted'],
                'discardPile' => $_POST['discardPile'],
                'doubleUpCards' => $_POST['doubleUpCards'], 
                'doubleUpCardsAdded' => $_POST['doubleUpCardsAdded'], 
                'doubleUpCardsPicked' => $_POST['doubleUpCardsPicked'], 
                'flagChosen' => $_POST['flagChosen'], 
                'freezeCards' => $_POST['freezeCards'], 
                'freezeCardsAdded' => $_POST['freezeCardsAdded'], 
                'goAgainCards' => $_POST['goAgainCards'],
                'goAgainCardsPercentage' => $_POST['goAgainCardsPercentage'],
                'greenCards' => $_POST['greenCards'], 
                'greensPickedSinceReset' => $_POST['greensPickedSinceReset'], 
                'keyDisabled' => $_POST['keyDisabled'],
                'keyholderID' => $_POST['keyholderID'],
                'keyUsed' => $_POST['keyUsed'], 
                'lastUpdateIDSeen' => $_POST['lastUpdateIDSeen'],
                'lockFrozenByCard' => $_POST['lockFrozenByCard'], 
                'lockFrozenByKeyholder' => $_POST['lockFrozenByKeyholder'], 
                'minutes' => $_POST['minutes'], 
                'minutesAdded' => $_POST['minutesAdded'], 
                'noOfAdd1Cards' => $_POST['noOfAdd1Cards'], 
                'noOfAdd2Cards' => $_POST['noOfAdd2Cards'], 
                'noOfAdd3Cards' => $_POST['noOfAdd3Cards'], 
                'noOfKeysRequired' => $_POST['noOfKeysRequired'],
                'noOfMinus1Cards' => $_POST['noOfMinus1Cards'], 
                'noOfMinus2Cards' => $_POST['noOfMinus2Cards'],
                'noOfTimesAutoReset' => $_POST['noOfTimesAutoReset'],
                'noOfTimesCardReset' => $_POST['noOfTimesCardReset'],
                'noOfTimesFullReset' => $_POST['noOfTimesFullReset'],
                'noOfTimesGreenCardRevealed' => $_POST['noOfTimesGreenCardRevealed'],
                'noOfTimesReset' => $_POST['noOfTimesReset'],
                'pickedCount' => $_POST['pickedCount'], 
                'pickedCountIncludingYellows' => $_POST['pickedCountIncludingYellows'], 
                'pickedCountSinceReset' => $_POST['pickedCountSinceReset'], 
                'randomCardsAdded' => $_POST['randomCardsAdded'], 
                'rating' => $_POST['rating'],
                'readyToUnlock' => $_POST['readyToUnlock'], 
                'redCards' => $_POST['redCards'], 
                'redCardsAdded' => $_POST['redCardsAdded'], 
                'resetCards' => $_POST['resetCards'], 
                'resetCardsAdded' => $_POST['resetCardsAdded'], 
                'resetCardsPicked' => $_POST['resetCardsPicked'], 
                'stickyCards' => $_POST['stickyCards'], 
                'test' => $_POST['test'],
                'timeLeftUntilNextChanceBeforeFreeze' => $_POST['timeLeftUntilNextChanceBeforeFreeze'],
                'timestampDeleted' => $_POST['timestampDeleted'],
                'timestampEndedCleanTime' => $_POST['timestampEndedCleanTime'], 
                'timestampFrozenByCard' => $_POST['timestampFrozenByCard'], 
                'timestampFrozenByKeyholder' => $_POST['timestampFrozenByKeyholder'], 
                'timestampLastAutoReset' => $_POST['timestampLastAutoReset'],
                'timestampLastCardReset' => $_POST['timestampLastCardReset'],
                'timestampLastCheckedIn' => $_POST['timestampLastCheckedIn'],
                'timestampLastFullReset' => $_POST['timestampLastFullReset'],
                'timestampLastPicked' => $_POST['timestampLastPicked'], 
                'timestampLastReset' => $_POST['timestampLastReset'],
                'timestampLastSynced' => time(),
                'timestampRated' => $_POST['timestampRated'],
                'timestampRealLastPicked' => $_POST['timestampRealLastPicked'],
                'timestampRequestedCleanTime' => $_POST['timestampRequestedCleanTime'], 
                'timestampRequestedKeyholdersDecision' => $_POST['timestampRequestedKeyholdersDecision'],
                'timestampStartedCleanTime' => $_POST['timestampStartedCleanTime'], 
                'timestampUnfreezes' => $_POST['timestampUnfreezes'], 
                'timestampUnfrozen' => $_POST['timestampUnfrozen'], 
                'timestampUnlocked' => $_POST['timestampUnlocked'], 
                'totalTimeCleaning' => $_POST['totalTimeCleaning'], 
                'totalTimeFrozen' => $_POST['totalTimeFrozen'], 
                'trustKeyholder' => $_POST['trustKeyholder'], 
                'unlocked' => $_POST['unlocked'],
                'userEmoji' => $_POST['emojiChosen'],
                'userEmojiColour' => $_POST['emojiColourSelected'],
                'yellowCards' => $_POST['yellowCards']));
            array_push($JSON, array('variable' => 'timestampLastSynced', 'value' => time()));
            
            if ($_POST['justUnlocked'] == 1 && $_POST['sharedID'] != "" && $_POST['fake'] == 0) {
                $query = $pdo->prepare("select u.user_id as u_user_id from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :sharedID and s.user_id = u.user_id and s.hide_from_owner = 0");
                $query->execute(array('sharedID' => $_POST['sharedID']));
                if ($query->rowCount() == 1) {
                    foreach ($query as $row) {
                        $keyholderUserID = $row["u_user_id"];
                    }
                    
                    if ($userID1 != $keyholderUserID) {
                        $query = $pdo->prepare("insert into RecentActivity (
                            id, 
                            user_id, 
                            activity_type,
                            lock_id,
                            mentioned_user_id,
                            share_id,
                            test_lock,
                            timestamp_added) values (
                                '', 
                                :userID, 
                                :activityType,
                                :lockID,
                                :mentionedUserID, 
                                :shareID,
                                :testLock,
                                :timestampAdded)");
                        $query->execute(array(
                            'userID' => $keyholderUserID, 
                            'activityType' => "LockeeFinishedLock",
                            'lockID' => 0,
                            'mentionedUserID' => $lockeeID, 
                            'shareID' => $_POST['sharedID'],
                            'testLock' => $_POST['test'],
                            'timestampAdded' => time()));
                    }
                }
            }
        }
        if ($_POST['logAction'] != "") {
            //if ($_POST['logAction'] == "GreenCardDecision" || ($_POST['logAction'] == "UnlockedLock" && $_POST['logResult'] == "GreenCard")) {
                //$query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                //$query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => 'PickedACard', 'actionedBy' => $_POST['logActionedBy'], 'result' => 'GreenCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
            //    if ($_POST['logAction'] == "GreenCardDecision") {
            //        if ($_POST['logResult'] == "DecideLater") {
            //            $_POST['logAction'] = "ReadyToUnlock";
            //        } else {
            //            $_POST['logAction'] = "Decision";
            //        }
            //    }
            //}
            if (($_POST['logAction'] == "AddedTime" || $_POST['logAction'] == "AddedCards") && $_POST['fixed'] == 1 && $_POST['timerHidden'] == 1) {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => 1, 'private' => $_POST['logPrivate']));
            } elseif ($_POST['logAction'] == "AutoResetLock") {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
            } else {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
                if ($_POST['logAction'] == "PickedACard" && $_POST['logResult'] == "FreezeCard") {
                    $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :private)");
                    $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => 'CardFreezeStarted', 'actionedBy' => 'App', 'private' => $_POST['logPrivate']));
                }
            }
            /*
            if ($_POST['logAction'] == "PickedACard" && $_POST['logResult'] == "GreenCard" && $_POST['readyToUnlock'] == 1) {
                $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy)");
                $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => 'ReadyToUnlock', 'actionedBy' => $_POST['logActionedBy']));
            }
            */
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