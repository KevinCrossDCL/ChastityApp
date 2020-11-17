<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../includes/app.php";
    
    $array = array();
    header("HTTP/1.1 200 OK", true, 200);
        $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
    
    $array["locks"] = array();   
    $query = $pdo->prepare("/* Solo Locks */
    select
        u.id as u_id,
        if (u.username = '', concat('CKU', u.id), u.username) as u_username,
        u.discord_id as u_discord_id,
        l.lock_group_id as l_lock_group_id,
        '' as l_locked_by,
        l.name as l_name,
        '' as s_shared_lock_id,
        '' as s_shared_lock_qr_code,
        '' as s_shared_lock_url,
        l.auto_resets_paused as l_auto_resets_paused,
        l.bot_chosen as l_bot_chosen,
        l.build as l_build,
        l.card_info_hidden as l_card_info_hidden,
        l.cumulative as l_cumulative,
        l.discard_pile as l_discard_pile,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.double_up_cards, -9) as l_double_up_cards,
        l.fixed as l_fixed,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.freeze_cards, -9) as l_freeze_cards,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.green_cards, -9) as l_green_cards,
        l.greens_picked_since_reset as l_greens_picked_since_reset,
        l.lock_frozen_by_card as l_lock_frozen_by_card,
        l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
        l.lock_id as l_lock_id,
        l.maximum_auto_resets as l_maximum_auto_resets,
        l.multiple_greens_required as l_multiple_greens_required,
        l.no_of_times_auto_reset as l_no_of_times_auto_reset,
        l.no_of_times_card_reset as l_no_of_times_card_reset,
        l.no_of_times_full_reset as l_no_of_times_full_reset,
        l.picked_count as l_picked_count,
        l.ready_to_unlock as l_ready_to_unlock,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.red_cards, -9) as l_red_cards,
        if (l.regularity < 0.25, 0, l.regularity) as l_regularity,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.reset_cards, -9) as l_reset_cards,
        l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.sticky_cards, -9) as l_sticky_cards,
        l.timer_hidden as l_timer_hidden,
        l.timestamp_frozen_by_card as l_timestamp_frozen_by_card,
        l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder,
        l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
        l.timestamp_last_card_reset as l_timestamp_last_card_reset,
        l.timestamp_last_full_reset as l_timestamp_last_full_reset,
        l.timestamp_last_picked as l_timestamp_last_picked,
        l.timestamp_locked as l_timestamp_locked,
        l.timestamp_real_last_picked as l_timestamp_real_last_picked,
        l.total_time_frozen as l_total_time_frozen,
        l.trust_keyholder as l_trust_keyholder,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.yellow_cards, -9) as l_yellow_cards
    from UserIDs_V2 as u, Locks_V2 as l
    where ".time()." - u.timestamp_last_active < 1209600 and 
        u.display_in_stats = 1 and 
        l.user_id = u.user_id and 
        l.bot_chosen = 0 and 
        l.deleted = 0 and 
        l.display_in_stats = 1 and 
        l.regularity > 0 and 
        l.shared_id = '' and 
        l.test = 0 and 
        l.timestamp_locked > 1451606400 and 
        l.unlocked = 0");
    $query->execute();
    foreach ($query as $row) {
        $lockBuild = $row["l_build"];
        if ($lockBuild <= 194) {
            $lockID = $row["l_lock_group_id"];
            $lockGroupID = $row["l_lock_group_id"];
        } else {
            if ($row["l_lock_group_id"] != $row["l_lock_id"]) {
                $lockID = $row["l_lock_group_id"].sprintf("%02d", ($row["l_lock_id"] - $row["l_lock_group_id"]));
                $lockGroupID = $row["l_lock_group_id"];
            } else {
                $lockID = $row["l_lock_group_id"]."01";
                $lockGroupID = $row["l_lock_group_id"];
            }
        }
        
        if ($row["l_ready_to_unlock"] == 1) {
            $lockStatus = "ReadyToUnlock";
        } else {
            $lockStatus = "Locked";
        }
            
        $lockFrozen = 0;
        if ($row["l_lock_frozen_by_card"] == "1" || $row["l_lock_frozen_by_keyholder"] == "1") { $lockFrozen = 1; }
            
        $timestampExpectedUnlock = 0;
        if ($row["l_fixed"] == 1 && $row["l_timer_hidden"] == 0 && $lockStatus == "Locked") {
            if ($row["l_regularity"] == 0.016667) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_minutes"] * 60);
            }
            if ($row["l_regularity"] >= 0.25) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_red_cards"] * ($row["l_regularity"] * 3600));
            }
        }
        
        $timestampLastPicked = $row["l_timestamp_locked"];
        if ($row["l_timestamp_last_picked"] > $row["l_timestamp_locked"]) { $timestampLastPicked = $row["l_timestamp_last_picked"]; }
                
        $timestampNextPick = 0;
        $timestampNextPick = $row["l_timestamp_last_picked"] + ($row["l_regularity"] * 3600);
        if ($row["l_fixed"] == 0 && $lockFrozen == 1) { $timestampNextPick = -9; }
        if ($row["l_unlocked"] == 1 || $row["l_ready_to_unlock"] == 1) { $timestampNextPick = 0; }

        if ($row["l_regularity"] == 0.016667) { $row["l_regularity"] = 0; }
        
        $timestampFrozenByCard = (int)$row["l_timestamp_frozen_by_card"];
        $timestampFrozenByKeyholder = (int)$row["l_timestamp_frozen_by_keyholder"];
        $totalTimeFrozen = (int)$row["l_total_time_frozen"];
        if ($timestampFrozenByCard > 0 && $row["l_lock_frozen_by_card"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByCard); }
        if ($timestampFrozenByKeyholder > 0 && $row["l_lock_frozen_by_keyholder"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByKeyholder); }
                
        $lock = array(
            'userID' => (int)$row["u_id"],
            'username' => (string)$row["u_username"],
            'discordID' => (string)$row["u_discord_id"],
            'lockGroupID' => (int)$lockGroupID,
            'lockID' => (int)$lockID,
            'lockedBy' => (string)$row["l_locked_by"],
            'lockName' => (string)$row["l_name"],
            'sharedLockID' => (string)$row["s_shared_lock_id"],
            'sharedLockQRCode' => (string)$row["s_shared_lock_qr_code"],
            'sharedLockURL' => (string)$row["s_shared_lock_url"],
            'autoResetFrequencyInSeconds' => (int)$row["l_reset_frequency_in_seconds"],
            'autoResetsPaused' => (int)$row["l_auto_resets_paused"],
            'botChosen' => (int)$row["l_bot_chosen"],
            'build' => (int)$row["l_build"],
            'cardInfoHidden' => (int)$row["l_card_info_hidden"],
            'cumulative' => (int)$row["l_cumulative"],
            'discardPile' => rtrim($row["l_discard_pile"], ","),
            'doubleUpCards' => (int)$row["l_double_up_cards"],
            'fixed' => (int)$row["l_fixed"],
            'freezeCards' => (int)$row["l_freeze_cards"],
            'greenCards' => (int)$row["l_green_cards"],
            'greenCardsPicked' => (int)$row["l_greens_picked_since_reset"],
            'lockFrozen' => (int)$lockFrozen,
            'lockFrozenByCard' => (int)$row["l_lock_frozen_by_card"],
            'lockFrozenByKeyholder' => (int)$row["l_lock_frozen_by_keyholder"],
            'logID' => (int)$row["l_lock_id"],
            'maximumAutoResets' => (int)$row["l_maximum_auto_resets"],
            'multipleGreensRequired' => (int)$row["l_multiple_greens_required"],
            'noOfTimesAutoReset' => (int)$row["l_no_of_times_auto_reset"],
            'noOfTimesCardReset' => (int)$row["l_no_of_times_card_reset"],
            'noOfTimesFullReset' => (int)$row["l_no_of_times_full_reset"],
            'noOfTurns' => (int)$row["l_picked_count"],
            'redCards' => (int)$row["l_red_cards"],
            'regularity' => (double)$row["l_regularity"],
            'resetCards' => (int)$row["l_reset_cards"],
            'status' => $lockStatus,
            'stickyCards' => (int)$row["l_sticky_cards"],
            'timerHidden' => (int)$row["l_timer_hidden"],
            'timestampExpectedUnlock' => $timestampExpectedUnlock,
            'timestampFrozenByCard' => $timestampFrozenByCard,
            'timestampFrozenByKeyholder' => $timestampFrozenByKeyholder,
            'timestampLastAutoReset' => (int)$row["l_timestamp_last_auto_reset"],
            'timestampLastCardReset' => (int)$row["l_timestamp_last_card_reset"],
            'timestampLastFullReset' => (int)$row["l_timestamp_last_full_reset"],
            'timestampLastPicked' => (int)$timestampLastPicked,
            'timestampLocked' => (int)$row["l_timestamp_locked"],
            'timestampNextPick' => (int)$timestampNextPick,
            'timestampRealLastPicked' => (int)$row["l_timestamp_real_last_picked"],
            'totalTimeFrozen' => $totalTimeFrozen,
            'trustKeyholder' => (int)$row["l_trust_keyholder"],
            'yellowCards' => (int)$row["l_yellow_cards"]
        );
        array_push($array["locks"], $lock);
    }
    
    $query = $pdo->prepare("/* Bot Locks */
    select
        u.id as u_id,
        if (u.username = '', concat('CKU', u.id), u.username) as u_username,
        u.discord_id as u_discord_id,
        l.lock_group_id as l_lock_group_id,
        (case
            when l.bot_chosen = 1 then 'Hailey'
            when l.bot_chosen = 2 then 'Blaine'
            when l.bot_chosen = 3 then 'Zoe'
            when l.bot_chosen = 4 then 'Chase'
            else ''
        end) as l_locked_by,
        l.name as l_name,
        '' as s_shared_lock_id,
        '' as s_shared_lock_qr_code,
        '' as s_shared_lock_url,
        l.auto_resets_paused as l_auto_resets_paused,
        l.bot_chosen as l_bot_chosen,
        l.build as l_build,
        l.card_info_hidden as l_card_info_hidden,
        l.cumulative as l_cumulative,
        l.discard_pile as l_discard_pile,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.double_up_cards, -9) as l_double_up_cards,
        l.fixed as l_fixed,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.freeze_cards, -9) as l_freeze_cards,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.green_cards, -9) as l_green_cards,
        l.greens_picked_since_reset as l_greens_picked_since_reset,
        l.lock_frozen_by_card as l_lock_frozen_by_card,
        l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
        l.lock_id as l_lock_id,
        l.maximum_auto_resets as l_maximum_auto_resets,
        l.multiple_greens_required as l_multiple_greens_required,
        l.no_of_times_auto_reset as l_no_of_times_auto_reset,
        l.no_of_times_card_reset as l_no_of_times_card_reset,
        l.no_of_times_full_reset as l_no_of_times_full_reset,
        l.picked_count as l_picked_count,
        l.ready_to_unlock as l_ready_to_unlock,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.red_cards, -9) as l_red_cards,
        if (l.regularity < 0.25, 0, l.regularity) as l_regularity,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.reset_cards, -9) as l_reset_cards,
        l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.sticky_cards, -9) as l_sticky_cards,
        l.timer_hidden as l_timer_hidden,
        l.timestamp_frozen_by_card as l_timestamp_frozen_by_card,
        l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder,
        l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
        l.timestamp_last_card_reset as l_timestamp_last_card_reset,
        l.timestamp_last_full_reset as l_timestamp_last_full_reset,
        l.timestamp_last_picked as l_timestamp_last_picked,
        l.timestamp_locked as l_timestamp_locked,
        l.timestamp_real_last_picked as l_timestamp_real_last_picked,
        l.total_time_frozen as l_total_time_frozen,
        l.trust_keyholder as l_trust_keyholder,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.yellow_cards, -9) as l_yellow_cards
    from UserIDs_V2 as u, Locks_V2 as l
    where ".time()." - u.timestamp_last_active < 1209600 and 
        u.display_in_stats = 1 and 
        l.user_id = u.user_id and 
        l.bot_chosen > 0 and 
        l.deleted = 0 and 
        l.display_in_stats = 1 and 
        l.regularity > 0 and 
        l.shared_id like 'BOT0%' and 
        l.test = 0 and 
        l.timestamp_locked > 1451606400 and 
        l.unlocked = 0");
    $query->execute();
    foreach ($query as $row) {
        $lockBuild = $row["l_build"];
        if ($lockBuild <= 194) {
            $lockID = $row["l_lock_group_id"];
            $lockGroupID = $row["l_lock_group_id"];
        } else {
            if ($row["l_lock_group_id"] != $row["l_lock_id"]) {
                $lockID = $row["l_lock_group_id"].sprintf("%02d", ($row["l_lock_id"] - $row["l_lock_group_id"]));
                $lockGroupID = $row["l_lock_group_id"];
            } else {
                $lockID = $row["l_lock_group_id"]."01";
                $lockGroupID = $row["l_lock_group_id"];
            }
        }
        
        if ($row["l_ready_to_unlock"] == 1) {
            $lockStatus = "ReadyToUnlock";
        } else {
            $lockStatus = "Locked";
        }
            
        $lockFrozen = 0;
        if ($row["l_lock_frozen_by_card"] == "1" || $row["l_lock_frozen_by_keyholder"] == "1") { $lockFrozen = 1; }
            
        $timestampExpectedUnlock = 0;
        if ($row["l_fixed"] == 1 && $row["l_timer_hidden"] == 0 && $lockStatus == "Locked") {
            if ($row["l_regularity"] == 0.016667) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_minutes"] * 60);
            }
            if ($row["l_regularity"] >= 0.25) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_red_cards"] * ($row["l_regularity"] * 3600));
            }
        }
            
        $timestampNextPick = 0;
        $timestampNextPick = $row["l_timestamp_last_picked"] + ($row["l_regularity"] * 3600);
        if ($row["l_fixed"] == 0 && $lockFrozen == 1) { $timestampNextPick = -9; }
        if ($row["l_unlocked"] == 1 || $row["l_ready_to_unlock"] == 1) { $timestampNextPick = 0; }
  
        if ($row["l_regularity"] == 0.016667) { $row["l_regularity"] = 0; }
        
        $timestampFrozenByCard = (int)$row["l_timestamp_frozen_by_card"];
        $timestampFrozenByKeyholder = (int)$row["l_timestamp_frozen_by_keyholder"];
        $totalTimeFrozen = (int)$row["l_total_time_frozen"];
        if ($timestampFrozenByCard > 0 && $row["l_lock_frozen_by_card"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByCard); }
        if ($timestampFrozenByKeyholder > 0 && $row["l_lock_frozen_by_keyholder"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByKeyholder); }
            
        $lock = array(
            'userID' => (int)$row["u_id"],
            'username' => (string)$row["u_username"],
            'discordID' => (string)$row["u_discord_id"],
            'lockGroupID' => (int)$lockGroupID,
            'lockID' => (int)$lockID,
            'lockedBy' => (string)$row["l_locked_by"],
            'lockName' => (string)$row["l_name"],
            'sharedLockID' => (string)$row["s_shared_lock_id"],
            'sharedLockQRCode' => (string)$row["s_shared_lock_qr_code"],
            'sharedLockURL' => (string)$row["s_shared_lock_url"],
            'autoResetFrequencyInSeconds' => (int)$row["l_reset_frequency_in_seconds"],
            'autoResetsPaused' => (int)$row["l_auto_resets_paused"],
            'botChosen' => (int)$row["l_bot_chosen"],
            'build' => (int)$row["l_build"],
            'cardInfoHidden' => (int)$row["l_card_info_hidden"],
            'cumulative' => (int)$row["l_cumulative"],
            'discardPile' => rtrim($row["l_discard_pile"], ","),
            'doubleUpCards' => (int)$row["l_double_up_cards"],
            'fixed' => (int)$row["l_fixed"],
            'freezeCards' => (int)$row["l_freeze_cards"],
            'greenCards' => (int)$row["l_green_cards"],
            'greenCardsPicked' => (int)$row["l_greens_picked_since_reset"],
            'lockFrozen' => (int)$lockFrozen,
            'lockFrozenByCard' => (int)$row["l_lock_frozen_by_card"],
            'lockFrozenByKeyholder' => (int)$row["l_lock_frozen_by_keyholder"],
            'logID' => (int)$row["l_lock_id"],
            'maximumAutoResets' => (int)$row["l_maximum_auto_resets"],
            'multipleGreensRequired' => (int)$row["l_multiple_greens_required"],
            'noOfTimesAutoReset' => (int)$row["l_no_of_times_auto_reset"],
            'noOfTimesCardReset' => (int)$row["l_no_of_times_card_reset"],
            'noOfTimesFullReset' => (int)$row["l_no_of_times_full_reset"],
            'noOfTurns' => (int)$row["l_picked_count"],
            'redCards' => (int)$row["l_red_cards"],
            'regularity' => (double)$row["l_regularity"],
            'resetCards' => (int)$row["l_reset_cards"],
            'status' => $lockStatus,
            'stickyCards' => (int)$row["l_sticky_cards"],
            'timerHidden' => (int)$row["l_timer_hidden"],
            'timestampExpectedUnlock' => $timestampExpectedUnlock,
            'timestampFrozenByCard' => $timestampFrozenByCard,
            'timestampFrozenByKeyholder' => $timestampFrozenByKeyholder,
            'timestampLastAutoReset' => (int)$row["l_timestamp_last_auto_reset"],
            'timestampLastCardReset' => (int)$row["l_timestamp_last_card_reset"],
            'timestampLastFullReset' => (int)$row["l_timestamp_last_full_reset"],
            'timestampLastPicked' => (int)$row["l_timestamp_last_picked"],
            'timestampLocked' => (int)$row["l_timestamp_locked"],
            'timestampNextPick' => (int)$timestampNextPick,
            'timestampRealLastPicked' => (int)$row["l_timestamp_real_last_picked"],
            'totalTimeFrozen' => $totalTimeFrozen,
            'trustKeyholder' => (int)$row["l_trust_keyholder"],
            'yellowCards' => (int)$row["l_yellow_cards"]
        );
        array_push($array["locks"], $lock);
    }
    
    $query = $pdo->prepare("/* Shared Locks */
    select
        u.id as u_id,
        if (u.username = '', concat('CKU', u.id), u.username) as u_username,
        u.discord_id as u_discord_id,
        l.lock_group_id as l_lock_group_id,
        (case
            when l.bot_chosen = 0 and k.username = '' and s.hide_from_owner = 0 and k.display_in_stats = 1 then concat('CKU', k.id)
            when l.bot_chosen = 0 and k.username <> '' and s.hide_from_owner = 0 and k.display_in_stats = 1 then k.username
            when l.bot_chosen = 0 and s.hide_from_owner = 1 then ''
            else '<hidden>'
        end) as l_locked_by,
        s.name as s_name,
        (case
            when s.share_in_api = 1 and l.shared_id <> '' and s.hide_from_owner = 0 then l.shared_id
            when s.share_in_api = 0 and l.shared_id <> '' and s.hide_from_owner = 0 then '<hidden>'
            else ''
        end) as s_shared_lock_id,
        (case
            when s.share_in_api = 1 and l.shared_id <> '' and s.hide_from_owner = 0 then concat('".$appName."-Shareable-Lock-', l.shared_id)
            when s.share_in_api = 0 and l.shared_id <> '' and s.hide_from_owner = 0 then '<hidden>'
            else ''
        end) as s_shared_lock_qr_code,
        (case
            when s.share_in_api = 1 and l.shared_id <> '' and s.hide_from_owner = 0 then concat('".$appServerDomain."/sharedlock/', l.shared_id)
            when s.share_in_api = 0 and l.shared_id <> '' and s.hide_from_owner = 0 then '<hidden>'
            else ''
        end) as s_shared_lock_url,
        l.auto_resets_paused as l_auto_resets_paused,
        l.bot_chosen as l_bot_chosen,
        l.build as l_build,
        l.card_info_hidden as l_card_info_hidden,
        l.cumulative as l_cumulative,
        l.discard_pile as l_discard_pile,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.double_up_cards, -9) as l_double_up_cards,
        l.fixed as l_fixed,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.freeze_cards, -9) as l_freeze_cards,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.green_cards, -9) as l_green_cards,
        l.greens_picked_since_reset as l_greens_picked_since_reset,
        l.lock_frozen_by_card as l_lock_frozen_by_card,
        l.lock_frozen_by_keyholder as l_lock_frozen_by_keyholder,
        l.lock_id as l_lock_id,
        l.maximum_auto_resets as l_maximum_auto_resets,
        l.multiple_greens_required as l_multiple_greens_required,
        l.no_of_times_auto_reset as l_no_of_times_auto_reset,
        l.no_of_times_card_reset as l_no_of_times_card_reset,
        l.no_of_times_full_reset as l_no_of_times_full_reset,
        l.picked_count as l_picked_count,
        l.ready_to_unlock as l_ready_to_unlock,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.red_cards, -9) as l_red_cards,
        if (l.regularity < 0.25, 0, l.regularity) as l_regularity,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.reset_cards, -9) as l_reset_cards,
        l.reset_frequency_in_seconds as l_reset_frequency_in_seconds,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.sticky_cards, -9) as l_sticky_cards,
        l.timer_hidden as l_timer_hidden,
        l.timestamp_frozen_by_card as l_timestamp_frozen_by_card,
        l.timestamp_frozen_by_keyholder as l_timestamp_frozen_by_keyholder,
        l.timestamp_last_auto_reset as l_timestamp_last_auto_reset,
        l.timestamp_last_card_reset as l_timestamp_last_card_reset,
        l.timestamp_last_full_reset as l_timestamp_last_full_reset,
        l.timestamp_last_picked as l_timestamp_last_picked,
        l.timestamp_locked as l_timestamp_locked,
        l.timestamp_real_last_picked as l_timestamp_real_last_picked,
        l.total_time_frozen as l_total_time_frozen,
        l.trust_keyholder as l_trust_keyholder,
        if (l.card_info_hidden = 0 and l.timer_hidden = 0, l.yellow_cards, -9) as l_yellow_cards
    from UserIDs_V2 as u, Locks_V2 as l, ShareableLocks_V2 as s
        left join UserIDs_V2 as k
            on s.user_id = k.user_id
    where ".time()." - u.timestamp_last_active < 1209600 and 
        u.display_in_stats = 1 and 
        l.user_id = u.user_id and 
        l.bot_chosen = 0 and 
        l.deleted = 0 and 
        l.display_in_stats = 1 and 
        l.regularity > 0 and 
        l.shared_id = s.share_id and 
        l.test = 0 and 
        l.timestamp_locked > 1451606400 and 
        l.unlocked = 0");
    $query->execute();
    foreach ($query as $row) {
        $lockBuild = $row["l_build"];
        if ($lockBuild <= 194) {
            $lockID = $row["l_lock_group_id"];
            $lockGroupID = $row["l_lock_group_id"];
        } else {
            if ($row["l_lock_group_id"] != $row["l_lock_id"]) {
                $lockID = $row["l_lock_group_id"].sprintf("%02d", ($row["l_lock_id"] - $row["l_lock_group_id"]));
                $lockGroupID = $row["l_lock_group_id"];
            } else {
                $lockID = $row["l_lock_group_id"]."01";
                $lockGroupID = $row["l_lock_group_id"];
            }
        }
        
        if ($row["l_ready_to_unlock"] == 1) {
            $lockStatus = "ReadyToUnlock";
        } else {
            $lockStatus = "Locked";
        }
            
        $lockFrozen = 0;
        if ($row["l_lock_frozen_by_card"] == "1" || $row["l_lock_frozen_by_keyholder"] == "1") { $lockFrozen = 1; }
            
        $timestampExpectedUnlock = 0;
        if ($row["l_fixed"] == 1 && $row["l_timer_hidden"] == 0 && $lockStatus == "Locked") {
            if ($row["l_regularity"] == 0.016667) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_minutes"] * 60);
            }
            if ($row["l_regularity"] >= 0.25) {
                $timestampExpectedUnlock = $row["l_timestamp_locked"] + ($row["l_red_cards"] * ($row["l_regularity"] * 3600));
            }
        }
            
        $timestampNextPick = 0;
        $timestampNextPick = $row["l_timestamp_last_picked"] + ($row["l_regularity"] * 3600);
        if ($row["l_fixed"] == 0 && $lockFrozen == 1) { $timestampNextPick = -9; }
        if ($row["l_unlocked"] == 1 || $row["l_ready_to_unlock"] == 1) { $timestampNextPick = 0; }
                
        if ($row["l_regularity"] == 0.016667) { $row["l_regularity"] = 0; }
        
        $timestampFrozenByCard = (int)$row["l_timestamp_frozen_by_card"];
        $timestampFrozenByKeyholder = (int)$row["l_timestamp_frozen_by_keyholder"];
        $totalTimeFrozen = (int)$row["l_total_time_frozen"];
        if ($timestampFrozenByCard > 0 && $row["l_lock_frozen_by_card"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByCard); }
        if ($timestampFrozenByKeyholder > 0 && $row["l_lock_frozen_by_keyholder"] == 1) { $totalTimeFrozen = $totalTimeFrozen + (time() - $timestampFrozenByKeyholder); }
            
        $lock = array(
            'userID' => (int)$row["u_id"],
            'username' => (string)$row["u_username"],
            'discordID' => (string)$row["u_discord_id"],
            'lockGroupID' => (int)$lockGroupID,
            'lockID' => (int)$lockID,
            'lockedBy' => (string)$row["l_locked_by"],
            'lockName' => (string)$row["s_name"],
            'sharedLockID' => (string)$row["s_shared_lock_id"],
            'sharedLockQRCode' => (string)$row["s_shared_lock_qr_code"],
            'sharedLockURL' => (string)$row["s_shared_lock_url"],
            'autoResetFrequencyInSeconds' => (int)$row["l_reset_frequency_in_seconds"],
            'autoResetsPaused' => (int)$row["l_auto_resets_paused"],
            'botChosen' => (int)$row["l_bot_chosen"],
            'build' => (int)$row["l_build"],
            'cardInfoHidden' => (int)$row["l_card_info_hidden"],
            'cumulative' => (int)$row["l_cumulative"],
            'discardPile' => rtrim($row["l_discard_pile"], ","),
            'doubleUpCards' => (int)$row["l_double_up_cards"],
            'fixed' => (int)$row["l_fixed"],
            'freezeCards' => (int)$row["l_freeze_cards"],
            'greenCards' => (int)$row["l_green_cards"],
            'greenCardsPicked' => (int)$row["l_greens_picked_since_reset"],
            'lockFrozen' => (int)$lockFrozen,
            'lockFrozenByCard' => (int)$row["l_lock_frozen_by_card"],
            'lockFrozenByKeyholder' => (int)$row["l_lock_frozen_by_keyholder"],
            'logID' => (int)$row["l_lock_id"],
            'maximumAutoResets' => (int)$row["l_maximum_auto_resets"],
            'multipleGreensRequired' => (int)$row["l_multiple_greens_required"],
            'noOfTimesAutoReset' => (int)$row["l_no_of_times_auto_reset"],
            'noOfTimesCardReset' => (int)$row["l_no_of_times_card_reset"],
            'noOfTimesFullReset' => (int)$row["l_no_of_times_full_reset"],
            'noOfTurns' => (int)$row["l_picked_count"],
            'redCards' => (int)$row["l_red_cards"],
            'regularity' => (double)$row["l_regularity"],
            'resetCards' => (int)$row["l_reset_cards"],
            'status' => $lockStatus,
            'stickyCards' => (int)$row["l_sticky_cards"],
            'timerHidden' => (int)$row["l_timer_hidden"],
            'timestampExpectedUnlock' => $timestampExpectedUnlock,
            'timestampFrozenByCard' => $timestampFrozenByCard,
            'timestampFrozenByKeyholder' => $timestampFrozenByKeyholder,
            'timestampLastAutoReset' => (int)$row["l_timestamp_last_auto_reset"],
            'timestampLastCardReset' => (int)$row["l_timestamp_last_card_reset"],
            'timestampLastFullReset' => (int)$row["l_timestamp_last_full_reset"],
            'timestampLastPicked' => (int)$row["l_timestamp_last_picked"],
            'timestampLocked' => (int)$row["l_timestamp_locked"],
            'timestampNextPick' => (int)$timestampNextPick,
            'timestampRealLastPicked' => (int)$row["l_timestamp_real_last_picked"],
            'totalTimeFrozen' => $totalTimeFrozen,
            'trustKeyholder' => (int)$row["l_trust_keyholder"],
            'yellowCards' => (int)$row["l_yellow_cards"]
        );
        array_push($array["locks"], $lock);
    }

    $query = null;
    $query1 = null;
    $query2 = null;
    $query3 = null;
    $pdo = null;
    
    $fp = fopen('../api/v0.5/runninglocks.json', 'w');
    fwrite($fp, json_encode($array, JSON_PRETTY_PRINT));
    fclose($fp);

} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
