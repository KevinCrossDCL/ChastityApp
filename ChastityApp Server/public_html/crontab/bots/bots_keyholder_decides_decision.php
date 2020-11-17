<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    function ResetFixedLock() {
        global $initialMinutes;
        global $initialRedCards;
        global $lockFrozenByKeyholder;
        global $lockFrozenByKeyholderModifiedBy;
        global $lockFrozenModifiedBy;
        global $lockModified;
        global $minutes;
        global $minutesModifiedBy;
        global $noOfTimesReset;
        global $readyToUnlock;
        global $redCards;
        global $redCardsModifiedBy;
        global $regularity;
        global $reset;
        global $timestampLastReset;
        global $timestampLocked;
        global $timestampRequestedKeyholdersDecision;
        if ($lockFrozenByKeyholder == 1) {
            $lockFrozenByKeyholderModifiedBy = -1;
            $lockFrozenModifiedBy = -1;
        }
        if ($regularity > 0) {
            // RED CARDS
            if ($initialRedCards > $redCards) {
                $redCardsModifiedBy = $initialRedCards - $redCards;
            } elseif ($initialRedCards < $redCards) {
                $redCardsModifiedBy = -($redCards - $initialRedCards);
            }
        } else {
            // MINUTES
            $minutesLocked = (time() - $timestampLocked) / 60;
            $minutesLeft = $minutes - $minutesLocked;
            if ($initialMinutes > $minutesLeft) {
                $minutesModifiedBy = $initialMinutes - $minutesLeft;
            } elseif ($initialMinutes < $minutesLeft) {
                $minutesModifiedBy = -($minutesLeft - $initialMinutes);
            }
        }
        $timestampLastReset = time();
        $readyToUnlock = 0;
        $timestampRequestedKeyholdersDecision = 0;
        $noOfTimesReset = $noOfTimesReset + 1;
        $reset = 1;
    }
    function ResetVariableLock() {
        global $build;
        global $doubleUpCards;
        global $doubleUpCardsModifiedBy;
        global $freezeCards;
        global $freezeCardsModifiedBy;
        global $greenCards;
        global $greenCardsModifiedBy;
        global $initialDoubleUpCards;
        global $initialFreezeCards;
        global $initialGreenCards;
        global $initialRedCards;
        global $initialResetCards;
        global $initialYellowAdd1Cards;
        global $initialYellowAdd2Cards;
        global $initialYellowAdd3Cards;
        global $initialYellowMinus1Cards;
        global $initialYellowMinus2Cards;
        global $lockFrozenByCard;
        global $lockFrozenByCardModifiedBy;
        global $lockFrozenByKeyholder;
        global $lockFrozenByKeyholderModifiedBy;
        global $lockFrozenModifiedBy;
        global $lockModified;
        global $noOfTimesReset;
        global $readyToUnlock;
        global $redCards;
        global $redCardsModifiedBy;
        global $regularity;
        global $reset;
        global $resetCards;
        global $resetCardsModifiedBy;
        global $timestampLastReset;
        global $timestampRequestedKeyholdersDecision;
        global $yellowAdd1Cards;
        global $yellowAdd1CardsModifiedBy;
        global $yellowAdd2Cards;
        global $yellowAdd2CardsModifiedBy;
        global $yellowAdd3Cards;
        global $yellowAdd3CardsModifiedBy;
        global $yellowCardsModifiedBy;
        global $yellowMinus1Cards;
        global $yellowMinus1CardsModifiedBy;
        global $yellowMinus2Cards;
        global $yellowMinus2CardsModifiedBy;
        if ($lockFrozenByCard == 1) {
            $lockFrozenByCardModifiedBy = -1;
            $lockFrozenModifiedBy = -1;
        }
        if ($lockFrozenByKeyholder == 1) {
            $lockFrozenByKeyholderModifiedBy = -1;
            $lockFrozenModifiedBy = -1;
        }
        // DOUBLE UP CARDS
        if ($initialDoubleUpCards > $doubleUpCards) {
            $doubleUpCardsModifiedBy = $initialDoubleUpCards - $doubleUpCards;
        } elseif ($initialDoubleUpCards < $doubleUpCards) {
            $doubleUpCardsModifiedBy = -($doubleUpCards - $initialDoubleUpCards);
        }
        if ($build < 166 && $doubleUpCardsModifiedBy > 20) { $doubleUpCardsModifiedBy = 20; }
        if ($build >= 166 && $doubleUpCardsModifiedBy > 30) { $doubleUpCardsModifiedBy = 30; }
        // FREEZE CARDS
        if ($initialFreezeCards > $freezeCards) {
            $freezeCardsModifiedBy = $initialFreezeCards - $freezeCards;
        } elseif ($initialFreezeCards < $freezeCards) {
            $freezeCardsModifiedBy = -($freezeCards - $initialFreezeCards);
        }
        if ($build < 166 && $freezeCardsModifiedBy > 20) { $freezeCardsModifiedBy = 20; }
        if ($build >= 166 && $freezeCardsModifiedBy > 30) { $freezeCardsModifiedBy = 30; }
        // GREEN CARDS
        if ($initialGreenCards > $greenCards) {
            $greenCardsModifiedBy = $initialGreenCards - $greenCards;
        } elseif ($initialGreenCards < $greenCards) {
            $greenCardsModifiedBy = -($greenCards - $initialGreenCards);
        }
        if ($build < 166 && $greenCardsModifiedBy > 20) { $greenCardsModifiedBy = 20; }
        if ($build >= 166 && $greenCardsModifiedBy > 30) { $greenCardsModifiedBy = 30; }
        // RED CARDS
        if ($initialRedCards > $redCards) {
            $redCardsModifiedBy = $initialRedCards - $redCards;
        } elseif ($initialRedCards < $redCards) {
            $redCardsModifiedBy = -($redCards - $initialRedCards);
        }
        if ($build < 166 && $redCardsModifiedBy > 399) { $redCardsModifiedBy = 399; }
        if ($build >= 166 && $redCardsModifiedBy > 599) { $redCardsModifiedBy = 599; }
        // RESET CARDS
        if ($initialResetCards > $resetCards) {
            $resetCardsModifiedBy = $initialResetCards - $resetCards;
        } elseif ($initialResetCards < $resetCards) {
            $resetCardsModifiedBy = -($resetCards - $initialResetCards);
        }
        if ($build < 166 && $resetCardsModifiedBy > 20) { $resetCardsModifiedBy = 20; }
        if ($build >= 166 && $resetCardsModifiedBy > 30) { $resetCardsModifiedBy = 30; }
        // YELLOW ADD 1 CARDS
        if ($initialYellowAdd1Cards > $yellowAdd1Cards) {
            $yellowAdd1CardsModifiedBy = $initialYellowAdd1Cards - $yellowAdd1Cards;
        } elseif ($initialYellowAdd1Cards < $yellowAdd1Cards) {
            $yellowAdd1CardsModifiedBy = -($yellowAdd1Cards - $initialYellowAdd1Cards);
        }
        if ($build < 166 && $yellowAdd1CardsModifiedBy > 199) { $yellowAdd1CardsModifiedBy = 199; }
        if ($build >= 166 && $yellowAdd1CardsModifiedBy > 299) { $yellowAdd1CardsModifiedBy = 299; }
        // YELLOW ADD 2 CARDS
        if ($initialYellowAdd2Cards > $yellowAdd2Cards) {
            $yellowAdd2CardsModifiedBy = $initialYellowAdd2Cards - $yellowAdd2Cards;
        } elseif ($initialYellowAdd2Cards < $yellowAdd2Cards) {
            $yellowAdd2CardsModifiedBy = -($yellowAdd2Cards - $initialYellowAdd2Cards);
        }
        if ($build < 166 && $yellowAdd2CardsModifiedBy > 199) { $yellowAdd2CardsModifiedBy = 199; }
        if ($build >= 166 && $yellowAdd2CardsModifiedBy > 299) { $yellowAdd2CardsModifiedBy = 299; }
        // YELLOW ADD 3 CARDS
        if ($initialYellowAdd3Cards > $yellowAdd3Cards) {
            $yellowAdd3CardsModifiedBy = $initialYellowAdd3Cards - $yellowAdd3Cards;
        } elseif ($initialYellowAdd3Cards < $yellowAdd3Cards) {
            $yellowAdd3CardsModifiedBy = -($yellowAdd3Cards - $initialYellowAdd3Cards);
        }
        if ($build < 166 && $yellowAdd3CardsModifiedBy > 199) { $yellowAdd3CardsModifiedBy = 199; }
        if ($build >= 166 && $yellowAdd3CardsModifiedBy > 299) { $yellowAdd3CardsModifiedBy = 299; }
        // YELLOW MINUS 1 CARDS
        if ($initialYellowMinus1Cards > $yellowMinus1Cards) {
            $yellowMinus1CardsModifiedBy = $initialYellowMinus1Cards - $yellowMinus1Cards;
        } elseif ($initialYellowMinus1Cards < $yellowMinus1Cards) {
            $yellowMinus1CardsModifiedBy = -($yellowMinus1Cards - $initialYellowMinus1Cards);
        }
        if ($build < 166 && $yellowMinus1CardsModifiedBy > 199) { $yellowMinus1CardsModifiedBy = 199; }
        if ($build >= 166 && $yellowMinus1CardsModifiedBy > 299) { $yellowMinus1CardsModifiedBy = 299; }
        // YELLOW MINUS 2 CARDS
        if ($initialYellowMinus2Cards > $yellowMinus2Cards) {
            $yellowMinus2CardsModifiedBy = $initialYellowMinus2Cards - $yellowMinus2Cards;
        } elseif ($initialYellowMinus2Cards < $yellowMinus2Cards) {
            $yellowMinus2CardsModifiedBy = -($yellowMinus2Cards - $initialYellowMinus2Cards);
        }
        if ($build < 166 && $yellowMinus2CardsModifiedBy > 199) { $yellowMinus2CardsModifiedBy = 199; }
        if ($build >= 166 && $yellowMinus2CardsModifiedBy > 299) { $yellowMinus2CardsModifiedBy = 299; }
        $yellowCardsModifiedBy = $yellowAdd1CardsModifiedBy + $yellowAdd2CardsModifiedBy + $yellowAdd3CardsModifiedBy + $yellowMinus1CardsModifiedBy + $yellowMinus2CardsModifiedBy;
        $timestampLastReset = time();
        $readyToUnlock = 0;
        $timestampRequestedKeyholdersDecision = 0;
        $noOfTimesReset = $noOfTimesReset + 1;
        $reset = 1;
    }
    function UnlockLock() {
        global $build;
        global $dateUnlocked;
        global $endOfLockDecisionMade;
        global $lockFrozenByCard;
        global $lockFrozenByCardModifiedBy;
        global $lockFrozenByKeyholder;
        global $lockFrozenByKeyholderModifiedBy;
        global $lockFrozenModifiedBy;
        global $lockModified;
        global $readyToUnlock;
        global $timestampRequestedKeyholdersDecision;
        global $timestampUnlocked;
        global $unlocked;
        global $unlockLock;
        if ($lockFrozenByCard == 1) {
            $lockFrozenByCardModifiedBy = -1;
            $lockFrozenModifiedBy = -1;
        }
        if ($lockFrozenByKeyholder == 1) {
            $lockFrozenByKeyholderModifiedBy = -1;
            $lockFrozenModifiedBy = -1;
        }
        $dateUnlocked = date("d/m/Y");
        $readyToUnlock = 0;
        $timestampRequestedKeyholdersDecision = 0;
        $timestampUnlocked = time();
        $unlocked = 1;
        $unlockLock = 1;
    }
    
    $noOfLocksModified = 0;
    $sqlLimit = rand(299, 499);
    $query = $pdo->prepare("select
        l.id as l_id,
        l.user_id as l_user_id,
        l.bot_chosen as l_bot_chosen,
        l.build as l_build,
        l.card_info_hidden as l_card_info_hidden,
        l.cumulative as l_cumulative, 
        l.date_unlocked as l_date_unlocked,
        l.double_up_cards as l_double_up_cards,
        l.fixed as l_fixed,
        l.freeze_cards as l_freeze_cards,
        l.green_cards as l_green_cards,
        l.initial_double_up_cards as l_initial_double_up_cards,
        l.initial_freeze_cards as l_initial_freeze_cards,
        l.initial_green_cards as l_initial_green_cards,
        l.initial_minutes as l_initial_minutes,
        l.initial_red_cards as l_initial_red_cards,
        l.initial_reset_cards as l_initial_reset_cards,
        l.initial_yellow_add_1_cards as l_initial_yellow_add_1_cards,
        l.initial_yellow_add_2_cards as l_initial_yellow_add_2_cards,
        l.initial_yellow_add_3_cards as l_initial_yellow_add_3_cards,
        l.initial_yellow_cards as l_initial_yellow_cards,
        l.initial_yellow_minus_1_cards as l_initial_yellow_minus_1_cards,
        l.initial_yellow_minus_2_cards as l_initial_yellow_minus_2_cards,
        l.keyholder_emoji as l_keyholder_emoji,
        l.keyholder_emoji_colour as l_keyholder_emoji_colour,
        l.lock_frozen_by_card as l_lock_frozen_by_card,
        l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
        l.lock_group_id as l_lock_group_id,
        l.lock_id as l_lock_id,
        l.maximum_minutes as l_maximum_minutes,
        l.maximum_red_cards as l_maximum_red_cards,
        l.minimum_minutes as l_minimum_minutes,
        l.minimum_red_cards as l_minimum_red_cards,
        l.minutes as l_minutes,
        l.multiple_greens_required as l_multiple_greens_required,
        l.no_of_add_1_cards as l_no_of_add_1_cards,
        l.no_of_add_2_cards as l_no_of_add_2_cards,
        l.no_of_add_3_cards as l_no_of_add_3_cards,
        l.no_of_minus_1_cards as l_no_of_minus_1_cards,
        l.no_of_minus_2_cards as l_no_of_minus_2_cards,
        l.no_of_times_reset as l_no_of_times_reset,
        l.ready_to_unlock as l_ready_to_unlock,
        l.red_cards as l_red_cards,
        l.red_cards_added as l_red_cards_added,
        l.regularity as l_regularity,
        l.reset_cards as l_reset_cards,
        l.shared_id as l_shared_id,
        l.simulation_average_minutes_locked as l_simulation_average_minutes_locked,
        l.simulation_best_case_minutes_locked as l_simulation_best_case_minutes_locked,
        l.simulation_worst_case_minutes_locked as l_simulation_worst_case_minutes_locked,
        l.timer_hidden as l_timer_hidden,
        l.timestamp_frozen_by_card as l_timestamp_frozen_by_card,
        l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder,
        l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
        l.timestamp_last_card_reset as l_timestamp_last_card_reset,
        l.timestamp_last_full_reset as l_timestamp_last_full_reset,
        l.timestamp_last_reset as l_timestamp_last_reset,
        l.timestamp_last_updated as l_timestamp_last_updated,
        l.timestamp_locked as l_timestamp_locked,
        l.timestamp_requested_keyholders_decision as l_timestamp_requested_keyholders_decision,
        l.timestamp_unfreezes as l_timestamp_unfreezes,
        l.timestamp_unlocked as l_timestamp_unlocked,
        l.total_time_frozen as l_total_time_frozen,
        l.trust_keyholder as l_trust_keyholder,
        l.unlocked as l_unlocked,
        l.user_emoji as l_user_emoji,
        l.user_emoji_colour as l_user_emoji_colour,
        l.yellow_cards as l_yellow_cards,
        u.platform as u_platform, 
        u.push_notifications_disabled as u_push_notifications_disabled, 
        u.status as u_status, 
        u.token as u_token
    from Locks_V2 as l, UserIDs_V2 as u where 
        l.user_id = u.user_id and 
        (l.bot_chosen > 0 or l.shared_id = 'S2Y5CZ848P75X26' or l.shared_id = '258V78632ZHKQ2F' or l.shared_id = 'V83KZYUL9359329') and 
        l.build >= 134 and 
        l.deleted = 0 and 
        l.unlocked = 0 and 
        l.ready_to_unlock = 1 and
        l.timestamp_requested_keyholders_decision > 0
    order by rand() limit ".$sqlLimit);
    $query->execute(array("timeNow" => time()));
    if ($query->rowCount() > 0) {
        foreach ($query as $row) {
            $modifiedLockID = $row["l_id"];
            $lockID = $row["l_lock_id"];
            $lockGroupID = $row["l_lock_group_id"];
            $userID = $row["l_user_id"];
            $botChosen = $row["l_bot_chosen"];
            if ($row["l_shared_id"] == "S2Y5CZ848P75X26") { $botChosen = 3; }
            if ($row["l_shared_id"] == "258V78632ZHKQ2F") { $botChosen = 4; }
            if ($row["l_shared_id"] == "V83KZYUL9359329") { $botChosen = 4; }
            $botLoyaltyPoints = 0;
            $build = $row["l_build"];
            $cardInfoHidden = $row["l_card_info_hidden"];
            $cardInfoHiddenModifiedBy = 0;
            $cumulative = $row["l_cumulative"]; 
            $dateUnlocked = $row["l_date_unlocked"];
            $doubleUpCards = $row["l_double_up_cards"];
            $doubleUpCardsModifiedBy = 0;
            $emoji = array();
            $endOfLockDecisionMade = 0;
            $fixed = $row["l_fixed"];
            $freezeCards = $row["l_freeze_cards"];
            $freezeCardsModifiedBy = 0;
            $greenCards = $row["l_green_cards"];
            $greenCardsModifiedBy = 0;
            $initialDoubleUpCards = $row["l_initial_double_up_cards"];
            $initialFreezeCards = $row["l_initial_freeze_cards"];
            $initialGreenCards = $row["l_initial_green_cards"];
            $initialMinutes = $row["l_initial_minutes"];
            $initialRedCards = $row["l_initial_red_cards"];
            $initialResetCards = $row["l_initial_reset_cards"];
            $initialYellowAdd1Cards = $row["l_initial_yellow_add_1_cards"];
            $initialYellowAdd2Cards = $row["l_initial_yellow_add_2_cards"];
            $initialYellowAdd3Cards = $row["l_initial_yellow_add_3_cards"];
            $initialYellowCards = $row["l_initial_yellow_cards"];
            $initialYellowMinus1Cards = $row["l_initial_yellow_minus_1_cards"];
            $initialYellowMinus2Cards = $row["l_initial_yellow_minus_2_cards"];
            $keyholderEmoji = $row["l_keyholder_emoji"];
            $keyholderEmojiColour = $row["l_keyholder_emoji_colour"];
            $lockFrozenByCard = $row["l_lock_frozen_by_card"];
            $lockFrozenByKeyholder = $row["l_lock_frozen_by_keyholder"];
            $lockFrozenByKeyholderModifiedBy = 0;
            $logLockID = $row["l_lock_id"];
            $maximumMinutes = $row["l_maximum_minutes"];
            $maximumRedCards = $row["l_maximum_red_cards"];
            $minimumMinutes = $row["l_minimum_minutes"];
            $minimumRedCards = $row["l_minimum_red_cards"];
            $minutes = $row["l_minutes"];
            $minutesModifiedBy = 0;
            $multipleGreensRequired = $row["l_multiple_greens_required"];
            $newKeyholderEmoji = 0;
            $newKeyholderEmojiColour = 0;
            $noOfAdd1Cards = $row["l_no_of_add_1_cards"];
            $noOfAdd1CardsModifiedBy = 0;
            $noOfAdd2Cards = $row["l_no_of_add_2_cards"];
            $noOfAdd2CardsModifiedBy = 0;
            $noOfAdd3Cards = $row["l_no_of_add_3_cards"];
            $noOfAdd3CardsModifiedBy = 0;
            $noOfMinus1Cards = $row["l_no_of_minus_1_cards"];
            $noOfMinus1CardsModifiedBy = 0;
            $noOfMinus2Cards = $row["l_no_of_minus_2_cards"];
            $noOfMinus2CardsModifiedBy = 0;
            $noOfTimesReset = $row["l_no_of_times_reset"];
            $originalKeyholderEmoji = $row["l_keyholder_emoji"];
            $originalKeyholderEmojiColour = $row["l_keyholder_emoji_colour"];
            $readyToUnlock = 0;
            $redCards = $row["l_red_cards"];
            $redCardsAdded = $row["l_red_cards_added"];
            $redCardsModifiedBy = 0;
            $regularity = $row["l_regularity"];
            if ($regularity < 0.25) { $regularity = 0; }
            $resetCards = $row["l_reset_cards"];
            $resetCardsModifiedBy = 0;
            $resetLock = 0;
            $sharedID = $row["l_shared_id"];
            $simulationAverageMinutesLocked = $row["l_simulation_average_minutes_locked"];
            $simulationBestCaseMinutesLocked = $row["l_simulation_best_case_minutes_locked"];
            $simulationWorstCaseMinutesLocked = $row["l_simulation_worst_case_minutes_locked"];
            $timerHidden = $row["l_timer_hidden"];
            $timerHiddenModifiedBy = 0;
            $timesLockedWithBot = 0;
            $timestampFrozenByCard = $row["l_timestamp_frozen_by_card"];
            $timestampFrozenByKeyholder = $row["l_timestamp_frozen_by_keyholder"];
            $timestampLastAutoReset = $row["l_timestamp_last_auto_reset"];
            $timestampLastCardReset = $row["l_timestamp_last_card_reset"];
            $timestampLastFullReset = $row["l_timestamp_last_full_reset"];
            $timestampLastReset = $row["l_timestamp_last_reset"];
            $timestampLocked = $row["l_timestamp_locked"];
            $timestampRequestedKeyholdersDecision = $row["l_timestamp_requested_keyholders_decision"];
            $timestampUnfreezes = $row["l_timestamp_unfreezes"];
            $timestampUnlocked = $row["l_timestamp_unlocked"];
            $totalTimeFrozen = $row["l_total_time_frozen"];
            $trustKeyholder = $row["l_trust_keyholder"];
            $unit = 3600 * $regularity;
            $unlocked = $row["l_unlocked"];
            $unlockLock = 0;
            $userEmoji = $row["l_user_emoji"];
            $userEmojiColour = $row["l_user_emoji_colour"];
            $userPlatform = $row["u_platform"];
            $userPushNotificationsDisabled = $row["u_push_notifications_disabled"];
            $userPushToken = $row["u_token"];
            $userStatus = $row["u_status"];
            $yellowCards = $row["l_yellow_cards"];
            $yellowCardsModifiedBy = 0;
            
            $query2 = $pdo->prepare("select count(*) as times_locked_with_bot from Locks_V2 where user_id = :userID and shared_id = :sharedID and build >= 134 and fake = 0 and unlocked = 1");
            $query2->execute(array("userID" => $userID, "sharedID" => $sharedID));
            if ($query2->rowCount() > 0) {
                foreach ($query2 as $row2) {
                    $timesLockedWithBot = $row2["times_locked_with_bot"];
                    if ($timesLockedWithBot > 25) { $timesLockedWithBot = 25; }
                    $botLoyaltyPoints = (1000000 / 100) * ($timesLockedWithBot * 0.2);
                }
            }

            include("bot_code_keyholders_decision.php");
            
            if ($resetLock == 1 || $unlockLock == 1) {
                $noOfLocksModified++;
                $query2 = $pdo->prepare("insert into ModifiedLocks_V2 (
                    id, 
                    user_id, 
                    lock_id, 
                    shared_id, 
                    card_info_hidden_modified_by, 
                    double_up_cards_modified_by,
                    freeze_cards_modified_by,
                    green_cards_modified_by,
                    lock_frozen_modified_by,
                    minutes_modified_by,
                    no_of_add_1_cards, 
                    no_of_add_2_cards, 
                    no_of_add_3_cards, 
                    no_of_minus_1_cards, 
                    no_of_minus_2_cards, 
                    ready_to_unlock,
                    red_cards_modified_by, 
                    reset,
                    reset_cards_modified_by,
                    timer_hidden_modified_by,
                    timestamp_modified, 
                    unlocked,
                    yellow_cards_modified_by
                ) values (
                    '', 
                    :userID,
                    :lockID,
                    :sharedID, 
                    :cardInfoHiddenModifiedBy, 
                    :doubleUpCardsModifiedBy, 
                    :freezeCardsModifiedBy,
                    :greenCardsModifiedBy,
                    :lockFrozenModifiedBy,
                    :minutesModifiedBy,
                    :noOfAdd1Cards, 
                    :noOfAdd2Cards, 
                    :noOfAdd3Cards, 
                    :noOfMinus1Cards, 
                    :noOfMinus2Cards, 
                    :readyToUnlock,
                    :redCardsModifiedBy, 
                    :reset,
                    :resetCardsModifiedBy, 
                    :timerHiddenModifiedBy, 
                    :timestampModified,
                    :unlocked,
                    :yellowCardsModifiedBy)");
                $query2->execute(array(
                    'userID' => $userID, 
                    'lockID' => $modifiedLockID, 
                    'sharedID' => $sharedID, 
                    'cardInfoHiddenModifiedBy' => $cardInfoHiddenModifiedBy,
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy, 
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy, 
                    'greenCardsModifiedBy' => $greenCardsModifiedBy,
                    'lockFrozenModifiedBy' => $lockFrozenByKeyholderModifiedBy,
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1Cards' => $noOfAdd1CardsModifiedBy, 
                    'noOfAdd2Cards' => $noOfAdd2CardsModifiedBy, 
                    'noOfAdd3Cards' => $noOfAdd3CardsModifiedBy, 
                    'noOfMinus1Cards' => $noOfMinus1CardsModifiedBy, 
                    'noOfMinus2Cards' => $noOfMinus2CardsModifiedBy, 
                    'readyToUnlock' => $readyToUnlock,
                    'redCardsModifiedBy' => $redCardsModifiedBy, 
                    'reset' => $resetLock,
                    'resetCardsModifiedBy' => $resetCardsModifiedBy, 
                    'timerHiddenModifiedBy' => $timerHiddenModifiedBy, 
                    'timestampModified' => time(),
                    'unlocked' => $unlockLock,
                    'yellowCardsModifiedBy' => $noOfAdd1CardsModifiedBy + $noOfAdd2CardsModifiedBy + $noOfAdd3CardsModifiedBy + $noOfMinus1CardsModifiedBy + $noOfMinus2CardsModifiedBy));
                    
                $timeFrozen = 0;
                if ($lockFrozenByKeyholderModifiedBy == -1) { 
                    if ($lockFrozenByCard == 1) { $timeFrozen = time() - $timestampFrozenByCard; }
                    if ($lockFrozenByKeyholder == 1) { $timeFrozen = time() - $timestampFrozenByKeyholder; }
                    $totalTimeFrozen = $totalTimeFrozen + $timeFrozen;
                    $lockFrozenByCard = 0;
                    $lockFrozenByKeyholder = 0;
                    $timestampFrozenByCard = 0;
                    $timestampFrozenByKeyholder = 0;
                    $timestampUnfreezes = 0;
                    $timestampUnfrozen = time();
                }
                if ($lockFrozenByKeyholderModifiedBy == 1) { 
                    $lockFrozenByCard = 0;
                    $lockFrozenByKeyholder = 1;
                    $timestampFrozenByCard = 0;
                    $timestampFrozenByKeyholder = time();
                    $timestampUnfreezes = 0;
                }
                    
                $query2 = $pdo->prepare("update Locks_V2 set 
                    card_info_hidden = :cardInfoHidden, 
                    date_unlocked = :dateUnlocked,
                    double_up_cards = double_up_cards + :doubleUpCardsModifiedBy, 
                    freeze_cards = freeze_cards + :freezeCardsModifiedBy, 
                    green_cards = green_cards + :greenCardsModifiedBy, 
                    keyholder_emoji = :keyholderEmoji,
                    keyholder_emoji_colour = :keyholderEmojiColour,
                    lock_frozen_by_card = :lockFrozenByCard, 
                    lock_frozen_by_keyholder = :lockFrozenByKeyholder, 
                    minutes = minutes + :minutesModifiedBy,
                    no_of_add_1_cards = no_of_add_1_cards + :noOfAdd1CardsModifiedBy, 
                    no_of_add_2_cards = no_of_add_2_cards + :noOfAdd2CardsModifiedBy, 
                    no_of_add_3_cards = no_of_add_3_cards + :noOfAdd3CardsModifiedBy, 
                    no_of_minus_1_cards = no_of_minus_1_cards + :noOfMinus1CardsModifiedBy, 
                    no_of_minus_2_cards = no_of_minus_2_cards + :noOfMinus2CardsModifiedBy, 
                    no_of_times_reset = :noOfTimesReset,
                    ready_to_unlock = :readyToUnlock,
                    red_cards = red_cards + :redCardsModifiedBy, 
                    reset_cards = reset_cards + :resetCardsModifiedBy, 
                    timer_hidden = :timerHidden, 
                    timestamp_frozen_by_card = :timestampFrozenByCard, 
                    timestamp_frozen_by_keyholder = :timestampFrozenByKeyholder, 
                    timestamp_last_reset = :timestampLastReset,
                    timestamp_requested_keyholders_decision = :timestampRequestedKeyholdersDecision,
                    timestamp_unfreezes = :timestampUnfreezes,
                    timestamp_unfrozen = :timestampUnfrozen,
                    timestamp_unlocked = :timestampUnlocked,
                    total_time_frozen = :totalTimeFrozen,
                    unlocked = :unlocked,
                    yellow_cards = yellow_cards + :yellowCardsModifiedBy
                where lock_id = :lockID and 
                    shared_id = :sharedID and 
                    user_id = :userID");
                $query2->execute(array(
                    'userID' => $userID, 
                    'sharedID' => $sharedID, 
                    'lockID' => $lockID,
                    'cardInfoHidden' => $cardInfoHidden, 
                    'dateUnlocked' => $dateUnlocked,
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy, 
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy, 
                    'greenCardsModifiedBy' => $greenCardsModifiedBy, 
                    'keyholderEmoji' => $keyholderEmoji,
                    'keyholderEmojiColour' => $keyholderEmojiColour,
                    'lockFrozenByCard' => $lockFrozenByCard,
                    'lockFrozenByKeyholder' => $lockFrozenByKeyholder,
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1CardsModifiedBy' => $noOfAdd1CardsModifiedBy, 
                    'noOfAdd2CardsModifiedBy' => $noOfAdd2CardsModifiedBy, 
                    'noOfAdd3CardsModifiedBy' => $noOfAdd3CardsModifiedBy, 
                    'noOfMinus1CardsModifiedBy' => $noOfMinus1CardsModifiedBy, 
                    'noOfMinus2CardsModifiedBy' => $noOfMinus1CardsModifiedBy, 
                    'noOfTimesReset' => $noOfTimesReset,
                    'readyToUnlock' => $readyToUnlock,
                    'redCardsModifiedBy' => $redCardsModifiedBy, 
                    'resetCardsModifiedBy' => $resetCardsModifiedBy,
                    'timerHidden' => $timerHidden, 
                    'timestampFrozenByCard' => $timestampFrozenByCard,
                    'timestampFrozenByKeyholder' => $timestampFrozenByKeyholder,
                    'timestampLastReset' => $timestampLastReset,
                    'timestampRequestedKeyholdersDecision' => $timestampRequestedKeyholdersDecision,
                    'timestampUnfreezes' => $timestampUnfreezes,
                    'timestampUnfrozen' => $timestampUnfrozen,
                    'timestampUnlocked' => $timestampUnlocked,
                    'totalTimeFrozen' => $totalTimeFrozen,
                    'unlocked' => $unlocked,
                    'yellowCardsModifiedBy' => $noOfAdd1CardsModifiedBy + $noOfAdd2CardsModifiedBy + $noOfAdd3CardsModifiedBy + $noOfMinus1CardsModifiedBy + $noOfMinus2CardsModifiedBy));
                
                if ($botChosen == 1) { $botName = "Hailey"; $botUserID = "BOT01"; }
                if ($botChosen == 2) { $botName = "Blaine"; $botUserID = "BOT02"; }
                if ($botChosen == 3) { $botName = "Zoe"; $botUserID = "BOT03"; }
                if ($botChosen == 4) { $botName = "Chase"; $botUserID = "BOT04"; }
                $query2 = $pdo->prepare("update UserIDs_V2 set 
                    timestamp_last_active = :timestampLastActive 
                where user_id = :botUserID");
                $query2->execute(array('timestampLastActive' => time(), 'botUserID' => $botUserID));
                
                if ($unlockLock == 1) {
                    $query2 = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                    $query2->execute(array('timestampNow' => time(), 'lockID' => $logLockID, 'userID' => $userID, 'action' => 'KeyholderUpdate', 'actionedBy' => 'Keyholder', 'result' => 'UnlockedLock', 'totalActionTime' => 0, 'hidden' => 0, 'private' => 0));
                } elseif ($resetLock == 1) {
                    $query2 = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, hidden, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :hidden, :private)");
                    $query2->execute(array('timestampNow' => time(), 'lockID' => $logLockID, 'userID' => $userID, 'action' => 'KeyholderUpdate', 'actionedBy' => 'Keyholder', 'result' => 'ResetLock', 'totalActionTime' => 0, 'hidden' => 0, 'private' => 0));
                }
                    
                if ($userPushNotificationsDisabled != 1 && $userPushToken != "" && $userStatus != 3) {
                    if ($userPlatform == "android") {
                        SendPushNotificationAndroidFCM($userPushToken, $botName." has just updated your lock.");
                    }
                    if ($userPlatform == "ios") {
                        SendPushNotificationiOS($userPushToken, $botName." has just updated your lock.");
                    }
                }
            }
        }
    }
    echo "Modified ".$noOfLocksModified." out of ".$query->rowCount();
    
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