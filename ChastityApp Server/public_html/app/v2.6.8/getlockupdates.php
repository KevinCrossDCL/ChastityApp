<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    $updateCount = 0;
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select
            m.id as m_id, 
            m.shared_id as m_shared_id,
            m.auto_resets_paused_modified_by as m_auto_resets_paused_modified_by,
            m.card_info_hidden_modified_by as m_card_info_hidden_modified_by, 
            m.cumulative_modified_by as m_cumulative_modified_by, 
            m.double_up_cards_modified_by as m_double_up_cards_modified_by, 
            m.freeze_cards_modified_by as m_freeze_cards_modified_by, 
            m.green_cards_modified_by as m_green_cards_modified_by, 
            m.hidden as m_hidden,
            m.lock_frozen_modified_by as m_lock_frozen_modified_by, 
            m.minutes_modified_by as m_minutes_modified_by, 
            m.no_of_add_1_cards as m_no_of_add_1_cards_modified_by, 
            m.no_of_add_2_cards as m_no_of_add_2_cards_modified_by, 
            m.no_of_add_3_cards as m_no_of_add_3_cards_modified_by, 
            m.no_of_minus_1_cards as m_no_of_minus_1_cards_modified_by, 
            m.no_of_minus_2_cards as m_no_of_minus_2_cards_modified_by, 
            m.ready_to_unlock as m_ready_to_unlock,
            m.red_cards_modified_by as m_red_cards_modified_by, 
            m.reset as m_reset,
            m.reset_cards_modified_by as m_reset_cards_modified_by, 
            m.sticky_cards_modified_by as m_sticky_cards_modified_by, 
            m.timer_hidden_modified_by as m_timer_hidden_modified_by, 
            m.timestamp_modified as m_timestamp_modified,
            m.unlocked as m_unlocked, 
            m.user_notified, 
            m.yellow_cards_modified_by as m_yellow_cards_modified_by, 
            l.lock_id as l_lock_id, 
            u.id as u_id, 
            u.username as u_username 
        from ModifiedLocks_V2 as m, ShareableLocks_V2 as s, Locks_V2 as l, UserIDs_V2 as u where 
            m.id > l.last_update_id_seen and 
            m.user_id = :userID and 
            m.user_id = l.user_id and 
            m.user_notified = 0 and 
            s.share_id = m.shared_id and 
            s.user_id = u.user_id and 
            l.id = m.lock_id and 
            l.shared_id = m.shared_id and 
            l.deleted = 0 order by m.id asc");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                $updateCount++;
                $modifiedID = $row["m_id"];
                $sharedID = $row["m_shared_id"];
                $lockID = $row["l_lock_id"];
                $autoResetsPausedModifiedBy = $row["m_auto_resets_paused_modified_by"];
                $cardInfoHiddenModifiedBy = $row["m_card_info_hidden_modified_by"];
                $cumulativeModifiedBy = $row["m_cumulative_modified_by"];
                $doubleUpCardsModifiedBy = $row["m_double_up_cards_modified_by"];
                $freezeCardsModifiedBy = $row["m_freeze_cards_modified_by"];
                $greenCardsModifiedBy = $row["m_green_cards_modified_by"];
                $hidden = $row["m_hidden"];
                $lockedBy = $row["u_username"];
                $lockedByID = $row["u_id"];
                if ($lockedBy == "") {
                    $lockedBy = "CKU".$lockedByID;
                }
                $lockFrozenByKeyholderModifiedBy = $row["m_lock_frozen_modified_by"];
                $minutesModifiedBy = $row["m_minutes_modified_by"];
                $noOfAdd1CardsModifiedBy = $row["m_no_of_add_1_cards_modified_by"];
                $noOfAdd2CardsModifiedBy = $row["m_no_of_add_2_cards_modified_by"];
                $noOfAdd3CardsModifiedBy = $row["m_no_of_add_3_cards_modified_by"];
                $noOfMinus1CardsModifiedBy = $row["m_no_of_minus_1_cards_modified_by"];
                $noOfMinus2CardsModifiedBy = $row["m_no_of_minus_2_cards_modified_by"];
                $readyToUnlock = $row["m_ready_to_unlock"];
                $redCardsModifiedBy = $row["m_red_cards_modified_by"];
                $reset = $row["m_reset"];
                $resetCardsModifiedBy = $row["m_reset_cards_modified_by"];
                $stickyCardsModifiedBy = $row["m_sticky_cards_modified_by"];
                $timerHiddenModifiedBy = $row["m_timer_hidden_modified_by"];
                $timestampModified = $row["m_timestamp_modified"];
                $unlocked = $row["m_unlocked"];
                $yellowCardsModifiedBy = $row["m_yellow_cards_modified_by"];
                array_push($JSON, array(
                    'id' => $modifiedID,
                    'lockID' => $lockID,
                    'autoResetsPausedModifiedBy' => $autoResetsPausedModifiedBy,
                    'cardInfoHiddenModifiedBy' => $cardInfoHiddenModifiedBy,
                    'cumulativeModifiedBy' => $cumulativeModifiedBy,
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy,
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy,
                    'greenCardsModifiedBy' => $greenCardsModifiedBy,
                    'hidden' => $hidden,
                    'lockedBy$' => $lockedBy,
                    'lockFrozenByKeyholderModifiedBy' => $lockFrozenByKeyholderModifiedBy,
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1CardsModifiedBy' => $noOfAdd1CardsModifiedBy,
                    'noOfAdd2CardsModifiedBy' => $noOfAdd2CardsModifiedBy,
                    'noOfAdd3CardsModifiedBy' => $noOfAdd3CardsModifiedBy,
                    'noOfMinus1CardsModifiedBy' => $noOfMinus1CardsModifiedBy,
                    'noOfMinus2CardsModifiedBy' => $noOfMinus2CardsModifiedBy,
                    'readyToUnlock' => $readyToUnlock,
                    'redCardsModifiedBy' => $redCardsModifiedBy,
                    'reset' => $reset,
                    'resetCardsModifiedBy' => $resetCardsModifiedBy,
                    'stickyCardsModifiedBy' => $stickyCardsModifiedBy,
                    'timerHiddenModifiedBy' => $timerHiddenModifiedBy,
                    'timestampModified' => $timestampModified,
                    'unlocked' => $unlocked,
                    'yellowCardsModifiedBy' => $yellowCardsModifiedBy
                ));
            }
        }
        $query = $pdo->prepare("select
            m.id as m_id, 
            m.shared_id as m_shared_id,
            m.auto_resets_paused_modified_by as m_auto_resets_paused_modified_by,
            m.card_info_hidden_modified_by as m_card_info_hidden_modified_by, 
            m.cumulative_modified_by as m_cumulative_modified_by, 
            m.double_up_cards_modified_by as m_double_up_cards_modified_by, 
            m.freeze_cards_modified_by as m_freeze_cards_modified_by, 
            m.green_cards_modified_by as m_green_cards_modified_by, 
            m.hidden as m_hidden,
            m.lock_frozen_modified_by as m_lock_frozen_modified_by, 
            m.minutes_modified_by as m_minutes_modified_by, 
            m.no_of_add_1_cards as m_no_of_add_1_cards_modified_by, 
            m.no_of_add_2_cards as m_no_of_add_2_cards_modified_by, 
            m.no_of_add_3_cards as m_no_of_add_3_cards_modified_by, 
            m.no_of_minus_1_cards as m_no_of_minus_1_cards_modified_by, 
            m.no_of_minus_2_cards as m_no_of_minus_2_cards_modified_by, 
            m.ready_to_unlock as m_ready_to_unlock,
            m.red_cards_modified_by as m_red_cards_modified_by, 
            m.reset as m_reset,
            m.reset_cards_modified_by as m_reset_cards_modified_by, 
            m.sticky_cards_modified_by as m_sticky_cards_modified_by, 
            m.timer_hidden_modified_by as m_timer_hidden_modified_by, 
            m.timestamp_modified as m_timestamp_modified,
            m.unlocked as m_unlocked, 
            m.user_notified, 
            m.yellow_cards_modified_by as m_yellow_cards_modified_by, 
            l.lock_id as l_lock_id
        from ModifiedLocks_V2 as m, Locks_V2 as l where 
            m.id > l.last_update_id_seen and 
            m.user_id = :userID and 
            m.user_id = l.user_id and 
            m.user_notified = 0 and 
            m.shared_id like 'BOT0_' and 
            l.id = m.lock_id and 
            l.deleted = 0 order by m.id asc");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                $updateCount++;
                $modifiedID = $row["m_id"];
                $sharedID = $row["m_shared_id"];
                $lockID = $row["l_lock_id"];
                $autoResetsPausedModifiedBy = $row["m_auto_resets_paused_modified_by"];
                $cardInfoHiddenModifiedBy = $row["m_card_info_hidden_modified_by"];
                $cumulativeModifiedBy = $row["m_cumulative_modified_by"];
                $doubleUpCardsModifiedBy = $row["m_double_up_cards_modified_by"];
                $freezeCardsModifiedBy = $row["m_freeze_cards_modified_by"];
                $greenCardsModifiedBy = $row["m_green_cards_modified_by"];
                $hidden = $row["m_hidden"];
                $lockedBy = $row["u_username"];
                if ($row["m_shared_id"] == "BOT01") { $lockedBy = "Hailey"; }
                if ($row["m_shared_id"] == "BOT02") { $lockedBy = "Blaine"; }
                if ($row["m_shared_id"] == "BOT03") { $lockedBy = "Zoe"; }
                if ($row["m_shared_id"] == "BOT04") { $lockedBy = "Chase"; }
                $lockFrozenByKeyholderModifiedBy = $row["m_lock_frozen_modified_by"];
                $minutesModifiedBy = $row["m_minutes_modified_by"];
                $noOfAdd1CardsModifiedBy = $row["m_no_of_add_1_cards_modified_by"];
                $noOfAdd2CardsModifiedBy = $row["m_no_of_add_2_cards_modified_by"];
                $noOfAdd3CardsModifiedBy = $row["m_no_of_add_3_cards_modified_by"];
                $noOfMinus1CardsModifiedBy = $row["m_no_of_minus_1_cards_modified_by"];
                $noOfMinus2CardsModifiedBy = $row["m_no_of_minus_2_cards_modified_by"];
                $readyToUnlock = $row["m_ready_to_unlock"];
                $redCardsModifiedBy = $row["m_red_cards_modified_by"];
                $reset = $row["m_reset"];
                $resetCardsModifiedBy = $row["m_reset_cards_modified_by"];
                $stickyCardsModifiedBy = $row["m_sticky_cards_modified_by"];
                $timerHiddenModifiedBy = $row["m_timer_hidden_modified_by"];
                $timestampModified = $row["m_timestamp_modified"];
                $unlocked = $row["m_unlocked"];
                $yellowCardsModifiedBy = $row["m_yellow_cards_modified_by"];
                array_push($JSON, array(
                    'id' => $modifiedID,
                    'lockID' => $lockID,
                    'autoResetsPausedModifiedBy' => $autoResetsPausedModifiedBy,
                    'cardInfoHiddenModifiedBy' => $cardInfoHiddenModifiedBy,
                    'cumulativeModifiedBy' => $cumulativeModifiedBy,
                    'doubleUpCardsModifiedBy' => $doubleUpCardsModifiedBy,
                    'freezeCardsModifiedBy' => $freezeCardsModifiedBy,
                    'greenCardsModifiedBy' => $greenCardsModifiedBy,
                    'hidden' => $hidden,
                    'lockedBy$' => $lockedBy,
                    'lockFrozenByKeyholderModifiedBy' => $lockFrozenByKeyholderModifiedBy,
                    'minutesModifiedBy' => $minutesModifiedBy,
                    'noOfAdd1CardsModifiedBy' => $noOfAdd1CardsModifiedBy,
                    'noOfAdd2CardsModifiedBy' => $noOfAdd2CardsModifiedBy,
                    'noOfAdd3CardsModifiedBy' => $noOfAdd3CardsModifiedBy,
                    'noOfMinus1CardsModifiedBy' => $noOfMinus1CardsModifiedBy,
                    'noOfMinus2CardsModifiedBy' => $noOfMinus2CardsModifiedBy,
                    'readyToUnlock' => $readyToUnlock,
                    'redCardsModifiedBy' => $redCardsModifiedBy,
                    'reset' => $reset,
                    'resetCardsModifiedBy' => $resetCardsModifiedBy,
                    'stickyCardsModifiedBy' => $stickyCardsModifiedBy,
                    'timerHiddenModifiedBy' => $timerHiddenModifiedBy,
                    'timestampModified' => $timestampModified,
                    'unlocked' => $unlocked,
                    'yellowCardsModifiedBy' => $yellowCardsModifiedBy
                ));
            }
        }
        if ($updateCount > 0) {
            echo json_encode($JSON);
        } else {
            echo "No Updates";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>