<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $yellowCards = [];
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id, username from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $id = $row["id"];
                $username = $row["username"];
                if ($username == "") { $username = "CKU".$id; }
            }
        }
        $query = $pdo->prepare("select 
            u.id, 
            u.user_id as u_user_id, 
            u.build_number_installed as u_build_number_installed,
            u.platform as u_platform, 
            u.push_notifications_disabled as u_push_notifications_disabled, 
            u.status as u_status, 
            u.token as u_token, 
            s.user_id, 
            s.share_id, 
            l.id as l_id, 
            l.user_id, 
            l.lock_id,
            l.shared_id, 
            l.auto_resets_paused as l_auto_resets_paused,
            l.build as l_build,
            l.card_info_hidden as l_card_info_hidden, 
            l.cumulative as l_cumulative,
            l.double_up_cards as l_double_up_cards,
            l.freeze_cards as l_freeze_cards,
            l.green_cards as l_green_cards,
            l.greens_picked_since_reset as l_greens_picked_since_reset,
            l.keyholder_allows_free_unlock as l_keyholder_allows_free_unlock,
            l.lock_frozen_by_card as l_lock_frozen_by_card,
            l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
            l.lock_group_id as l_lock_group_id,
            l.maximum_auto_resets as l_maximum_auto_resets,
            l.minutes as l_minutes,
            l.no_of_add_1_cards as l_no_of_add_1_cards, 
            l.no_of_add_2_cards as l_no_of_add_2_cards, 
            l.no_of_add_3_cards as l_no_of_add_3_cards, 
            l.no_of_minus_1_cards as l_no_of_minus_1_cards, 
            l.no_of_minus_2_cards as l_no_of_minus_2_cards, 
            l.no_of_times_auto_reset as l_no_of_times_auto_reset,
            l.ready_to_unlock as l_ready_to_unlock,
            l.red_cards as l_red_cards,
            l.regularity as l_regularity,
            l.reset_cards as l_reset_cards,
            l.sticky_cards as l_sticky_cards,
            l.test as l_test,
            l.timer_hidden as l_timer_hidden,
            l.timestamp_frozen_by_card as l_timestamp_frozen_by_card, 
            l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder, 
            l.timestamp_last_picked as l_timestamp_last_picked,
            l.timestamp_last_reset as l_timestamp_last_reset, 
            l.timestamp_last_full_reset as l_timestamp_last_full_reset,
            l.timestamp_unfreezes as l_timestamp_unfreezes,
            l.timestamp_unfrozen as l_timestamp_unfrozen, 
            l.total_time_frozen as l_total_time_frozen
        from UserIDs_V2 as u, ShareableLocks_V2 as s, Locks_V2 as l 
        where s.share_id = :sharedID and 
            s.user_id = :userID and 
            s.share_id = l.shared_id and 
            l.lock_id = :lockID and 
            l.user_id = u.user_id and 
            u.id = :sharedUserID and 
            l.deleted = 0");
        $query->execute(array('sharedID' => $_POST['sharedID'], 'userID' => $userID1, 'lockID' => $_POST['lockID'], 'sharedUserID' => $_POST['sharedUserID']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $lockBuild = $row["l_build"];
                $lockGroupID = $row["l_lock_group_id"];
                $lockID = $row["l_id"];
                $lockedUserID = $row["u_user_id"];
                $lockedUserAutoResetsPaused = $row["l_auto_resets_paused"];
                $lockedUserBuildNumberInstalled = $row["u_build_number_installed"];
                $lockedUserCardInfoHidden = $row["l_card_info_hidden"];
                $lockedUserCumulative = $row["l_cumulative"];
                $lockedUserDoubleUpCards = $row["l_double_up_cards"];
                $lockedUserFreezeCards = $row["l_freeze_cards"];
                $lockedUserFrozenByCard = $row["l_lock_frozen_by_card"];
                $lockedUserFrozenByKeyholder = $row["l_lock_frozen_by_keyholder"];
                $lockedUserGreenCards = $row["l_green_cards"];
                $lockedUserGreensPickedSinceReset = $row["l_greens_picked_since_reset"];
                $lockedUserKeyholderAllowsFreeUnlock = $row["l_keyholder_allows_free_unlock"];
                $lockedUserMaximumAutoResets = $row["l_maximum_auto_resets"];
                $lockedUserMinutes = $row["l_minutes"];
                $lockedUserNoOfAdd1Cards = $row["l_no_of_add_1_cards"];
                $lockedUserNoOfAdd2Cards = $row["l_no_of_add_2_cards"];
                $lockedUserNoOfAdd3Cards = $row["l_no_of_add_3_cards"];
                $lockedUserNoOfMinus1Cards = $row["l_no_of_minus_1_cards"];
                $lockedUserNoOfMinus2Cards = $row["l_no_of_minus_2_cards"];
                $lockedUserNoOfTimesAutoReset = $row["l_no_of_times_auto_reset"];
                $lockedUserPlatform = $row["u_platform"];
                $lockedUserPushNotificationsDisabled = $row["u_push_notifications_disabled"];
                $lockedUserReadyToUnlock = $row["l_ready_to_unlock"];
                $lockedUserRedCards = $row["l_red_cards"];
                $lockedUserRegularity = $row["l_regularity"];
                $lockedUserResetCards = $row["l_reset_cards"];
                $lockedUserStatus = $row["u_status"];
                $lockedUserStickyCards = $row["l_sticky_cards"];
                $lockedUserTestLock = $row["l_test"];
                $lockedUserTimerHidden = $row["l_timer_hidden"];
                $lockedUserTimestampFrozenByCard = $row["l_timestamp_frozen_by_card"];
                $lockedUserTimestampFrozenByKeyholder = $row["l_timestamp_frozen_by_keyholder"];
                $lockedUserTimestampLastPicked = $row["l_timestamp_last_picked"];
                $lockedUserTimestampLastReset = $row["l_timestamp_last_reset"];
                $lockedUserTimestampLastFullReset = $row["l_timestamp_last_full_reset"];
                $lockedUserTimestampUnfreezes = $row["l_timestamp_unfreezes"];
                $lockedUserTimestampUnfrozen = $row["l_timestamp_unfrozen"];
                $lockedUserToken = $row["u_token"];
                $lockedUserTotalTimeFrozen = $row["l_total_time_frozen"];
            }
            
            //$sendNotification = 0;
            
            if ($_POST['allowFreeUnlockModifiedBy'] == -1) { $lockedUserKeyholderAllowsFreeUnlock = 0; }
            if ($_POST['allowFreeUnlockModifiedBy'] == 1) { $lockedUserKeyholderAllowsFreeUnlock = 1; }
            
            if ($_POST['autoResetsPausedModifiedBy'] == -1) { $lockedUserAutoResetsPaused = 0; }
            if ($_POST['autoResetsPausedModifiedBy'] == 1) { $lockedUserAutoResetsPaused = 1; }
            //if ($_POST['autoResetsPausedModifiedBy'] != 0) { $sendNotification = 1; }
            
            if ($_POST['cardInfoHiddenModifiedBy'] == -1) { $lockedUserCardInfoHidden = 0; }
            if ($_POST['cardInfoHiddenModifiedBy'] == 1) { $lockedUserCardInfoHidden = 1; }
            //if ($_POST['cardInfoHiddenModifiedBy'] != 0) { $sendNotification = 1; }
                
            if ($_POST['cumulativeModifiedBy'] == -1) { 
                $lockedUserCumulative = 0;
                if ($lockedUserTimestampLastPicked < $_POST['timestampModified'] - ($lockedUserRegularity * 3600)) {
                    $lockedUserTimestampLastPicked = $_POST['timestampModified'] - ($lockedUserRegularity * 3600);
                }
            }
            if ($_POST['cumulativeModifiedBy'] == 1) { $lockedUserCumulative = 1; }
            //if ($_POST['cumulativeModifiedBy'] != 0) { $sendNotification = 1; }
            
            $doubleUpCardsModifiedBy = $_POST['doubleUpCardsModifiedBy'];
            if ($lockedUserDoubleUpCards + $doubleUpCardsModifiedBy < 0) { $doubleUpCardsModifiedBy = $doubleUpCardsModifiedBy - ($lockedUserDoubleUpCards + $doubleUpCardsModifiedBy); }
            //if ($doubleUpCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $freezeCardsModifiedBy = $_POST['freezeCardsModifiedBy'];
            if ($lockedUserFreezeCards + $freezeCardsModifiedBy < 0) { $freezeCardsModifiedBy = $freezeCardsModifiedBy - ($lockedUserFreezeCards + $freezeCardsModifiedBy); }
            //if ($freezeCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $greenCardsModifiedBy = $_POST['greenCardsModifiedBy'];
            if ($lockedUserGreenCards + $greenCardsModifiedBy < 0) { $greenCardsModifiedBy = $greenCardsModifiedBy - ($lockedUserGreenCards + $greenCardsModifiedBy); }
            //if ($greenCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $minutesModifiedBy = $_POST['minutesModifiedBy'];
            if ($lockedUserMinutes + $minutesModifiedBy < 0) { $minutesModifiedBy = $minutesModifiedBy - ($lockedUserMinutes + $minutesModifiedBy); }
            //if ($minutesModifiedBy != 0) { $sendNotification = 1; }
            
            $stickyCardsModifiedBy = $_POST['stickyCardsModifiedBy'];
            if ($lockedUserStickyCards + $stickyCardsModifiedBy < 0) { $stickyCardsModifiedBy = $stickyCardsModifiedBy - ($lockedUserStickyCards + $stickyCardsModifiedBy); }
            //if ($stickyCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $noOfAdd1CardsModifiedBy = $_POST['yellowCardsModifiedBy3'];
            if ($lockedUserNoOfAdd1Cards + $noOfAdd1CardsModifiedBy < 0) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - ($lockedUserNoOfAdd1Cards + $noOfAdd1CardsModifiedBy); }
            //if ($noOfAdd1CardsModifiedBy != 0) { $sendNotification = 1; }
            
            $noOfAdd2CardsModifiedBy = $_POST['yellowCardsModifiedBy4'];
            if ($lockedUserNoOfAdd2Cards + $noOfAdd2CardsModifiedBy < 0) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - ($lockedUserNoOfAdd2Cards + $noOfAdd2CardsModifiedBy); }
            //if ($noOfAdd2CardsModifiedBy != 0) { $sendNotification = 1; }
            
            $noOfAdd3CardsModifiedBy = $_POST['yellowCardsModifiedBy5'];
            if ($lockedUserNoOfAdd3Cards + $noOfAdd3CardsModifiedBy < 0) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - ($lockedUserNoOfAdd3Cards + $noOfAdd3CardsModifiedBy); }
            //if ($noOfAdd3CardsModifiedBy != 0) { $sendNotification = 1; }
            
            $noOfMinus1CardsModifiedBy = $_POST['yellowCardsModifiedBy2'];
            if ($lockedUserNoOfMinus1Cards + $noOfMinus1CardsModifiedBy < 0) { $noOfMinus1CardsModifiedBy = $noOfMinus1CardsModifiedBy - ($lockedUserNoOfMinus1Cards + $noOfMinus1CardsModifiedBy); }
            //if ($noOfMinus1CardsModifiedBy != 0) { $sendNotification = 1; }
            
            $noOfMinus2CardsModifiedBy = $_POST['yellowCardsModifiedBy1'];
            if ($lockedUserNoOfMinus2Cards + $noOfMinus2CardsModifiedBy < 0) { $noOfMinus2CardsModifiedBy = $noOfMinus2CardsModifiedBy - ($lockedUserNoOfMinus2Cards + $noOfMinus2CardsModifiedBy); }
            //if ($noOfMinus2CardsModifiedBy != 0) { $sendNotification = 1; }
            
            $redCardsModifiedBy = $_POST['redCardsModifiedBy'];
            if ($lockedUserRedCards + $redCardsModifiedBy < 0) { $redCardsModifiedBy = $redCardsModifiedBy - ($lockedUserRedCards + $redCardsModifiedBy); }
            //if ($redCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $resetCardsModifiedBy = $_POST['resetCardsModifiedBy'];
            if ($lockedUserResetCards + $resetCardsModifiedBy < 0) { $resetCardsModifiedBy = $resetCardsModifiedBy - ($lockedUserResetCards + $resetCardsModifiedBy); }
            //if ($resetCardsModifiedBy != 0) { $sendNotification = 1; }
            
            $yellowCardsModifiedBy = $noOfAdd1CardsModifiedBy + $noOfAdd2CardsModifiedBy + $noOfAdd3CardsModifiedBy + $noOfMinus1CardsModifiedBy + $noOfMinus2CardsModifiedBy;
            //if ($noOfAdd2CardsModifiedBy != 0) { $sendNotification = 1; }
            
            
            $lockedUserTimeFrozen = 0;
            if ($_POST['lockFrozenByKeyholderModifiedBy'] == -1) {
                if ($lockedUserFrozenByCard == 1) { 
                    $lockedUserTimeFrozen = $_POST['timestampModified'] - $lockedUserTimestampFrozenByCard;
                    $lockedUserTotalTimeFrozen = $lockedUserTotalTimeFrozen + ($_POST['timestampModified'] - $lockedUserTimestampFrozenByCard);
                }
                if ($lockedUserFrozenByKeyholder == 1) {
                    $lockedUserTimeFrozen = $_POST['timestampModified'] - $lockedUserTimestampFrozenByKeyholder;
                    $lockedUserTotalTimeFrozen = $lockedUserTotalTimeFrozen + ($_POST['timestampModified'] - $lockedUserTimestampFrozenByKeyholder);
                }
                $lockedUserFrozenByCard = 0;
                $lockedUserFrozenByKeyholder = 0;
                $lockedUserTimestampFrozenByKeyholder = 0;
                $lockedUserTimestampFrozenByCard = 0;
                $lockedUserTimestampUnfreezes = 0;
                $lockedUserTimestampUnfrozen = $_POST['timestampModified'];
            }
            if ($_POST['lockFrozenByKeyholderModifiedBy'] == 1) {
                $lockedUserFrozenByCard = 0;
                $lockedUserFrozenByKeyholder = 1;
                $lockedUserTimestampFrozenByCard = 0;
                $lockedUserTimestampFrozenByKeyholder = $_POST['timestampModified'];
                $lockedUserTimestampUnfreezes = 0;
            }
            //if ($_POST['lockFrozenByKeyholderModifiedBy'] != 0) { $sendNotification = 1; }
            
            if ($_POST['reset'] == 1) {
                $lockedUserGreensPickedSinceReset = 0;
                $lockedUserNoOfTimesAutoReset = 0;
                $lockedUserTimestampLastFullReset = $_POST['timestampModified'];
                $lockedUserTimestampLastReset = $_POST['timestampModified'];
                $lockedUserReadyToUnlock = 0;
                //$sendNotification = 1;
            }
            
            if ($_POST['timerHiddenModifiedBy'] == -1) { $lockedUserTimerHidden = 0; }
            if ($_POST['timerHiddenModifiedBy'] == 1) { $lockedUserTimerHidden = 1; }
            //if ($_POST['timerHiddenModifiedBy'] != 0) { $sendNotification = 1; }
            
            if ($_POST['allowFreeUnlockModifiedBy'] != 0 || $_POST['autoResetsPausedModifiedBy'] != 0 || $_POST['cardInfoHiddenModifiedBy'] != 0 || $_POST['cumulativeModifiedBy'] != 0 || $doubleUpCardsModifiedBy != 0 || $_POST['fakeUpdate'] != 0 || $freezeCardsModifiedBy != 0 || $greenCardsModifiedBy != 0 || $_POST['lockFrozenByKeyholderModifiedBy'] != 0 || $minutesModifiedBy != 0 || $redCardsModifiedBy != 0 || $_POST['reset'] != 0 || $resetCardsModifiedBy != 0 || $stickyCardsModifiedBy != 0 || $_POST['timerHiddenModifiedBy'] != 0 || $noOfAdd1CardsModifiedBy != 0 || $noOfAdd2CardsModifiedBy != 0 || $noOfAdd3CardsModifiedBy != 0 || $noOfMinus1CardsModifiedBy != 0 || $noOfMinus2CardsModifiedBy != 0) {
                $query2 = $pdo->prepare("insert into ModifiedLocks_V2 (
                    id, 
                    user_id, 
                    lock_id, 
                    shared_id, 
                    allow_free_unlock_modified_by,
                    auto_resets_paused_modified_by,
                    card_info_hidden_modified_by,
                    cumulative_modified_by,
                    double_up_cards_modified_by,
                    fake_update,
                    freeze_cards_modified_by,
                    green_cards_modified_by,
                    hidden,
                    lock_frozen_modified_by,
                    minutes_modified_by,
                    no_of_add_1_cards, 
                    no_of_add_2_cards, 
                    no_of_add_3_cards,
                    no_of_minus_1_cards,
                    no_of_minus_2_cards, 
                    red_cards_modified_by, 
                    reset,
                    reset_cards_modified_by, 
                    sticky_cards_modified_by, 
                    timer_hidden_modified_by, 
                    timestamp_modified,
                    yellow_cards_modified_by) values (
                        '', 
                        :lockedUserID, 
                        :lockID, 
                        :sharedID, 
                        :allowFreeUnlockModifiedBy,
                        :autoResetsPausedModifiedBy,
                        :cardInfoHiddenModifiedBy,
                        :cumulativeModifiedBy,
                        :doubleUpCardsModifiedBy,
                        :fakeUpdate,
                        :freezeCardsModifiedBy,
                        :greenCardsModifiedBy,
                        :hidden,
                        :lockFrozenByKeyholderModifiedBy,
                        :minutesModifiedBy,
                        :noOfAdd1Cards, 
                        :noOfAdd2Cards, 
                        :noOfAdd3Cards, 
                        :noOfMinus1Cards, 
                        :noOfMinus2Cards, 
                        :redCardsModifiedBy,
                        :reset,
                        :resetCardsModifiedBy, 
                        :stickyCardsModifiedBy, 
                        :timerHiddenModifiedBy, 
                        :timestampModified,
                        :yellowCardsModifiedBy)");
                $query2->execute(array(
                    'lockedUserID' => $lockedUserID, 
                    'lockID' => $lockID, 
                    'sharedID' => $_POST['sharedID'], 
                    'allowFreeUnlockModifiedBy' => $_POST['allowFreeUnlockModifiedBy'],
                    'autoResetsPausedModifiedBy' => $_POST['autoResetsPausedModifiedBy'],
                    'cardInfoHiddenModifiedBy' => $_POST['cardInfoHiddenModifiedBy'],
                    'cumulativeModifiedBy' => $_POST['cumulativeModifiedBy'],
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy, 
                    'fakeUpdate' => $_POST['fakeUpdate'],
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy, 
                    'greenCardsModifiedBy' => $greenCardsModifiedBy,
                    'hidden' =>$_POST['hideUpdate'],
                    'lockFrozenByKeyholderModifiedBy' => $_POST['lockFrozenByKeyholderModifiedBy'],
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1Cards' => $noOfAdd1CardsModifiedBy, 
                    'noOfAdd2Cards' => $noOfAdd2CardsModifiedBy, 
                    'noOfAdd3Cards' => $noOfAdd3CardsModifiedBy, 
                    'noOfMinus1Cards' => $noOfMinus1CardsModifiedBy, 
                    'noOfMinus2Cards' => $noOfMinus2CardsModifiedBy, 
                    'redCardsModifiedBy' => $redCardsModifiedBy, 
                    'reset' => $_POST['reset'],
                    'resetCardsModifiedBy' => $resetCardsModifiedBy, 
                    'stickyCardsModifiedBy' => $stickyCardsModifiedBy, 
                    'timerHiddenModifiedBy' => $_POST['timerHiddenModifiedBy'], 
                    'timestampModified' => $_POST['timestampModified'],
                    'yellowCardsModifiedBy' => $yellowCardsModifiedBy));
                $query2 = $pdo->prepare("update Locks_V2 set 
                    auto_resets_paused = :autoResetsPaused,
                    card_info_hidden = :cardInfoHidden, 
                    cumulative = :cumulative, 
                    double_up_cards = double_up_cards + :doubleUpCardsModifiedBy, 
                    freeze_cards = freeze_cards + :freezeCardsModifiedBy, 
                    green_cards = green_cards + :greenCardsModifiedBy, 
                    greens_picked_since_reset = :greensPickedSinceReset,
                    keyholder_allows_free_unlock = :keyholderAllowsFreeUnlock,
                    lock_frozen_by_card = :lockFrozenByCard, 
                    lock_frozen_by_keyholder = :lockFrozenByKeyholder, 
                    minutes = minutes + :minutesModifiedBy,
                    no_of_add_1_cards = no_of_add_1_cards + :noOfAdd1Cards, 
                    no_of_add_2_cards = no_of_add_2_cards + :noOfAdd2Cards, 
                    no_of_add_3_cards = no_of_add_3_cards + :noOfAdd3Cards, 
                    no_of_minus_1_cards = no_of_minus_1_cards + :noOfMinus1Cards, 
                    no_of_minus_2_cards = no_of_minus_2_cards + :noOfMinus2Cards, 
                    no_of_times_auto_reset = :noOfTimesAutoReset,
                    ready_to_unlock = :readyToUnlock,
                    red_cards = red_cards + :redCardsModifiedBy, 
                    reset_cards = reset_cards + :resetCardsModifiedBy, 
                    sticky_cards = sticky_cards + :stickyCardsModifiedBy, 
                    timer_hidden = :timerHidden, 
                    timestamp_frozen_by_card = :timestampFrozenByCard, 
                    timestamp_frozen_by_keyholder = :timestampFrozenByKeyholder, 
                    timestamp_last_full_reset = :timestampLastFullReset,
                    timestamp_last_picked = :timestampLastPicked,
                    timestamp_last_reset = :timestampLastReset,
                    timestamp_last_updated = :timestampLastUpdated,
                    timestamp_unfreezes = :timestampUnfreezes,
                    timestamp_unfrozen = :timestampUnfrozen,
                    total_time_frozen = :totalTimeFrozen,
                    yellow_cards = yellow_cards + ".$yellowCardsModifiedBy."
                where user_id = :lockedUserID and shared_id = :sharedID and lock_id = :lockID");
                $query2->execute(array(
                    'lockedUserID' => $lockedUserID, 
                    'lockID' => $_POST['lockID'],
                    'sharedID' => $_POST['sharedID'], 
                    'autoResetsPaused' => $lockedUserAutoResetsPaused, 
                    'cardInfoHidden' => $lockedUserCardInfoHidden, 
                    'cumulative' => $lockedUserCumulative, 
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy, 
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy, 
                    'greenCardsModifiedBy' => $greenCardsModifiedBy, 
                    'greensPickedSinceReset' => $lockedUserGreensPickedSinceReset,
                    'keyholderAllowsFreeUnlock' => $lockedUserKeyholderAllowsFreeUnlock,
                    'lockFrozenByCard' => $lockedUserFrozenByCard,
                    'lockFrozenByKeyholder' => $lockedUserFrozenByKeyholder,
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1Cards' => $noOfAdd1CardsModifiedBy, 
                    'noOfAdd2Cards' => $noOfAdd2CardsModifiedBy, 
                    'noOfAdd3Cards' => $noOfAdd3CardsModifiedBy, 
                    'noOfMinus1Cards' => $noOfMinus1CardsModifiedBy, 
                    'noOfMinus2Cards' => $noOfMinus2CardsModifiedBy, 
                    'noOfTimesAutoReset' => $lockedUserNoOfTimesAutoReset,
                    'readyToUnlock' => $lockedUserReadyToUnlock,
                    'redCardsModifiedBy' => $redCardsModifiedBy, 
                    'resetCardsModifiedBy' => $resetCardsModifiedBy,
                    'stickyCardsModifiedBy' => $stickyCardsModifiedBy,
                    'timerHidden' => $lockedUserTimerHidden, 
                    'timestampFrozenByCard' => $lockedUserTimestampFrozenByCard,
                    'timestampFrozenByKeyholder' => $lockedUserTimestampFrozenByKeyholder,
                    'timestampLastFullReset' => $lockedUserTimestampLastFullReset,
                    'timestampLastPicked' => $lockedUserTimestampLastPicked,
                    'timestampLastReset' => $lockedUserTimestampLastReset,
                    'timestampLastUpdated' => $_POST['timestampModified'],
                    'timestampUnfreezes' => $lockedUserTimestampUnfreezes,
                    'timestampUnfrozen' => $lockedUserTimestampUnfrozen,
                    'totalTimeFrozen' => $lockedUserTotalTimeFrozen));
    
                if ($_POST['logAction'] != "") {
                    if ($_POST['logResult'] == "FrozeLock") {
                        $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                        $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'KeyholderFreezeStarted', 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
                    } elseif ($_POST['logResult'] == "UnfrozeLock") {
                        $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
                        $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'KeyholderFreezeEnded', 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $lockedUserTimeFrozen, 'private' => $_POST['logPrivate']));
                    } elseif ($_POST['logResult'] == "UpdatedCards") {
                        if ($_POST['fakeUpdate'] == 1) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'FakeUpdate', 'actionedBy' => $_POST['logActionedBy'], 'result' => '', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($doubleUpCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($doubleUpCardsModifiedBy).'*DoubleUpCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($doubleUpCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $doubleUpCardsModifiedBy.'*DoubleUpCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($freezeCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($freezeCardsModifiedBy).'*FreezeCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($freezeCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $freezeCardsModifiedBy.'*FreezeCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($greenCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($greenCardsModifiedBy).'*GreenCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($greenCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $greenCardsModifiedBy.'*GreenCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($redCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($redCardsModifiedBy).'*RedCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($redCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $redCardsModifiedBy.'*RedCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($resetCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($resetCardsModifiedBy).'*ResetCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($resetCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $resetCardsModifiedBy.'*ResetCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($stickyCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($stickyCardsModifiedBy).'*StickyCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($stickyCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $stickyCardsModifiedBy.'*StickyCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($noOfAdd1CardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($noOfAdd1CardsModifiedBy).'*YellowAdd1Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($noOfAdd1CardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $noOfAdd1CardsModifiedBy.'*YellowAdd1Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($noOfAdd2CardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($noOfAdd2CardsModifiedBy).'*YellowAdd2Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($noOfAdd2CardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $noOfAdd2CardsModifiedBy.'*YellowAdd2Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($noOfAdd3CardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($noOfAdd3CardsModifiedBy).'*YellowAdd3Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($noOfAdd3CardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $noOfAdd3CardsModifiedBy.'*YellowAdd3Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($noOfMinus1CardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($noOfMinus1CardsModifiedBy).'*YellowMinus1Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($noOfMinus1CardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $noOfMinus1CardsModifiedBy.'*YellowMinus1Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($noOfMinus2CardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($noOfMinus2CardsModifiedBy).'*YellowMinus2Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($noOfMinus2CardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $noOfMinus2CardsModifiedBy.'*YellowMinus2Card', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                    } elseif ($_POST['logResult'] == "UpdatedTime") {
                        if ($_POST['fakeUpdate'] == 1) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'FakeUpdate', 'actionedBy' => $_POST['logActionedBy'], 'result' => '', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                        if ($minutesModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedTime', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($minutesModifiedBy), 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($minutesModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedTime', 'actionedBy' => $_POST['logActionedBy'], 'result' => $minutesModifiedBy, 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                    } elseif ($_POST['logResult'] == "UpdatedTimeOldVersion") {
                        if ($redCardsModifiedBy < 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'RemovedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => abs($redCardsModifiedBy).'*RedCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        } elseif ($redCardsModifiedBy > 0) {
                            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => 'AddedCards', 'actionedBy' => $_POST['logActionedBy'], 'result' => $redCardsModifiedBy.'*RedCard', 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                        }
                    } else {
                        $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                        $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'hidden' => $_POST['hideUpdate'], 'private' => $_POST['logPrivate']));
                    }
                }
            
                if ($lockedUserPushNotificationsDisabled != 1 && $lockedUserToken != "" && $lockedUserStatus != 3) {
                    if ($username != "") {
                        if ($lockedUserPlatform == "android") {
                            if ($lockedUserBuildNumberInstalled < 115) {
                                SendPushNotificationAndroid($lockedUserToken, $username." has just updated your lock.", $appName);
                            } else {
                                SendPushNotificationAndroidFCM($lockedUserToken, $username." has just updated your lock.");
                            }
                        }
                        if ($lockedUserPlatform == "ios") {
                            SendPushNotificationiOS($lockedUserToken, $username." has just updated your lock.");
                        }
                    } else {
                        if ($lockedUserPlatform == "android") {
                            if ($lockedUserBuildNumberInstalled < 115) {
                                SendPushNotificationAndroid($lockedUserToken, "Your keyholder has just updated your lock.", $appName);
                            } else {
                                SendPushNotificationAndroidFCM($lockedUserToken, "Your keyholder has just updated your lock.");
                            }
                        }
                        if ($lockedUserPlatform == "ios") {
                            SendPushNotificationiOS($lockedUserToken, "Your keyholder has just updated your lock.");
                        }
                    }
                }
                
                if ($lockBuild <= 194) {
                    $apiLockID = $lockGroupID;
                } else {
                    if ($lockGroupID != $_POST['lockID']) {
                        $apiLockID = $lockGroupID.sprintf("%02d", ($_POST['lockID'] - $lockGroupID));
                    } else {
                        $apiLockID = $lockGroupID."01";
                    }
                }
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
                    'userID' => $lockedUserID, 
                    'activityType' => "KeyholderUpdatedLock",
                    'lockID' => $apiLockID,
                    'mentionedUserID' => $id, 
                    'shareID' => $_POST['sharedID'],
                    'testLock' => $lockedUserTestLock,
                    'timestampAdded' => time()));
            }
        } else {
            echo "Shared Lock And User Match Failed";
        }
    }
    $query = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>