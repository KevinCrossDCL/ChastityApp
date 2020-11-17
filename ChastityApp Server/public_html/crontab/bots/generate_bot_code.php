<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

ini_set("memory_limit","256M");

try {
    include "../../../includes/app.php";

    echo "Generating Percentages<br />";
    $query = $pdo->prepare("select 
        count(*) as updates_count,
        sum(case when s.fixed = 0 then 1 else 0 end) as variable_updates_count,
        sum(case when s.fixed = 1 and s.build < 134 then 1 else 0 end) as old_fixed_updates_count,
        sum(case when s.fixed = 1 and s.build >= 134 then 1 else 0 end) as new_fixed_updates_count,
        sum(case when m.card_info_hidden_modified_by = 1 and s.fixed = 0 then 1 else 0 end) as variable_card_info_hidden_count,
        sum(case when m.card_info_hidden_modified_by = -1 and s.fixed = 0 then 1 else 0 end) as variable_card_info_unhidden_count,
        sum(case when m.double_up_cards_modified_by > 0 and m.double_up_cards_modified_by < 6 and s.fixed = 0 then 1 else 0 end) as variable_double_up_cards_modified_by_adding_count,
        sum(case when m.double_up_cards_modified_by > -3 and m.double_up_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_double_up_cards_modified_by_removing_count,
        sum(case when m.freeze_cards_modified_by > 0 and m.freeze_cards_modified_by < 6 and s.fixed = 0 then 1 else 0 end) as variable_freeze_cards_modified_by_adding_count,
        sum(case when m.freeze_cards_modified_by > -3 and m.freeze_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_freeze_cards_modified_by_removing_count,
        sum(case when m.green_cards_modified_by > 0 and m.green_cards_modified_by < 5 and s.fixed = 0 then 1 else 0 end) as variable_green_cards_modified_by_adding_count,
        sum(case when m.green_cards_modified_by > -2 and m.green_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_green_cards_modified_by_removing_count,
        sum(case when m.lock_frozen_modified_by = 1 and s.fixed = 0 then 1 else 0 end) as variable_freeze_lock_count,
        sum(case when m.lock_frozen_modified_by = -1 and s.fixed = 0 then 1 else 0 end) as variable_unfreeze_lock_count,
        sum(case when m.lock_frozen_modified_by = 1 and s.fixed = 1 then 1 else 0 end) as fixed_freeze_lock_count,
        sum(case when m.lock_frozen_modified_by = -1 and s.fixed = 1 then 1 else 0 end) as fixed_unfreeze_lock_count,
        sum(case when m.minutes_modified_by > 0 and s.fixed = 1 and s.build >= 134 then 1 else 0 end) as new_fixed_minutes_modified_by_adding_count,
        sum(case when m.minutes_modified_by < 0 and s.fixed = 1 and s.build >= 134 then 1 else 0 end) as new_fixed_minutes_modified_by_removing_count,
        sum(case when m.no_of_add_1_cards > 0 and m.no_of_add_1_cards < 200 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_1_cards_modified_by_adding_count,
        sum(case when m.no_of_add_1_cards > -100 and m.no_of_add_1_cards < 0 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_1_cards_modified_by_removing_count,
        sum(case when m.no_of_add_2_cards > 0 and m.no_of_add_2_cards < 200 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_2_cards_modified_by_adding_count,
        sum(case when m.no_of_add_2_cards > -100 and m.no_of_add_2_cards < 0 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_2_cards_modified_by_removing_count,
        sum(case when m.no_of_add_3_cards > 0 and m.no_of_add_3_cards < 200 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_3_cards_modified_by_adding_count,
        sum(case when m.no_of_add_3_cards > -100 and m.no_of_add_3_cards < 0 and s.fixed = 0 then 1 else 0 end) as variable_no_of_add_3_cards_modified_by_removing_count,
        sum(case when m.no_of_minus_1_cards > 0 and m.no_of_minus_1_cards < 200 and s.fixed = 0 then 1 else 0 end) as variable_no_of_minus_1_cards_modified_by_adding_count,
        sum(case when m.no_of_minus_1_cards > -100 and m.no_of_minus_1_cards < 0 and s.fixed = 0 then 1 else 0 end) as variable_no_of_minus_1_cards_modified_by_removing_count,
        sum(case when m.no_of_minus_2_cards > 0 and m.no_of_minus_2_cards < 200 and s.fixed = 0 then 1 else 0 end) as variable_no_of_minus_2_cards_modified_by_adding_count,
        sum(case when m.no_of_minus_2_cards > -100 and m.no_of_minus_2_cards < 0 and s.fixed = 0 then 1 else 0 end) as variable_no_of_minus_2_cards_modified_by_removing_count,
        sum(case when m.red_cards_modified_by > 0 and m.red_cards_modified_by < 400 and s.fixed = 0 then 1 else 0 end) as variable_red_cards_modified_by_adding_count,
        sum(case when m.red_cards_modified_by > -200 and m.red_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_red_cards_modified_by_removing_count,
        sum(case when m.red_cards_modified_by > 0 and m.red_cards_modified_by < 400 and s.fixed = 1 and s.build < 134 then 1 else 0 end) as old_fixed_red_cards_modified_by_adding_count,
        sum(case when m.red_cards_modified_by > -200 and m.red_cards_modified_by < 0 and s.fixed = 1 and s.build < 134 then 1 else 0 end) as old_fixed_red_cards_modified_by_removing_count,
        sum(case when m.reset = 1 then 1 else 0 end) as reset_count,
        sum(case when m.reset_cards_modified_by > 0 and reset_cards_modified_by < 4 and s.fixed = 0 then 1 else 0 end) as variable_reset_cards_modified_by_adding_count,
        sum(case when m.reset_cards_modified_by > -2 and reset_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_reset_cards_modified_by_removing_count,
        sum(case when m.sticky_cards_modified_by > 0 and m.sticky_cards_modified_by < 4 and s.fixed = 0 then 1 else 0 end) as variable_sticky_cards_modified_by_adding_count,
        sum(case when m.sticky_cards_modified_by > -2 and m.sticky_cards_modified_by < 0 and s.fixed = 0 then 1 else 0 end) as variable_sticky_cards_modified_by_removing_count,
        sum(case when m.timer_hidden_modified_by = 1 then 1 else 0 end) as fixed_timer_hidden_count,
        sum(case when m.timer_hidden_modified_by = -1 then 1 else 0 end) as fixed_timer_unhidden_count,
        sum(case when m.unlocked = 1 then 1 else 0 end) as unlocked_count
    from ModifiedLocks_V2 as m, ShareableLocks_V2 as s
    where shared_id not like 'BOT0%' and
        m.shared_id = s.share_id");
    $query->execute();
    if ($query->rowCount() == 1) {
        foreach ($query as $row) {
            $variableCardInfoHiddenPercentage = number_format($row["variable_card_info_hidden_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableCardInfoUnhiddenPercentage = number_format($row["variable_card_info_unhidden_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableDoubleUpCardsModifiedByAddingPercentage = number_format($row["variable_double_up_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableDoubleUpCardsModifiedByRemovingPercentage = number_format($row["variable_double_up_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableFreezeCardsModifiedByAddingPercentage = number_format($row["variable_freeze_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableFreezeCardsModifiedByRemovingPercentage = number_format($row["variable_freeze_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableFreezeLockPercentage = number_format($row["variable_freeze_lock_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableUnfreezeLockPercentage = number_format($row["variable_unfreeze_lock_count"] / $row["variable_updates_count"], 4) * 1000000;
            $fixedFreezeLockPercentage = number_format($row["fixed_freeze_lock_count"] / ($row["old_fixed_updates_count"] + $row["new_fixed_updates_count"]), 4) * 1000000;
            $fixedUnfreezeLockPercentage = number_format($row["fixed_unfreeze_lock_count"] / ($row["old_fixed_updates_count"] + $row["new_fixed_updates_count"]), 4) * 1000000;
            $variableGreenCardsModifiedByAddingPercentage = number_format($row["variable_green_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableGreenCardsModifiedByRemovingPercentage = number_format($row["variable_green_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $newFixedMinutesModifiedByAddingPercentage = number_format($row["new_fixed_minutes_modified_by_adding_count"] / $row["new_fixed_updates_count"], 4) * 1000000;
            $newFixedMinutesModifiedByRemovingPercentage = number_format($row["new_fixed_minutes_modified_by_removing_count"] / $row["new_fixed_updates_count"], 4) * 1000000;
            $variableNoOfAdd1CardsModifiedByAddingPercentage = number_format($row["variable_no_of_add_1_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfAdd1CardsModifiedByRemovingPercentage = number_format($row["variable_no_of_add_1_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfAdd2CardsModifiedByAddingPercentage = number_format($row["variable_no_of_add_2_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfAdd2CardsModifiedByRemovingPercentage = number_format($row["variable_no_of_add_2_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfAdd3CardsModifiedByAddingPercentage = number_format($row["variable_no_of_add_3_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfAdd3CardsModifiedByRemovingPercentage = number_format($row["variable_no_of_add_3_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfMinus1CardsModifiedByAddingPercentage = number_format($row["variable_no_of_minus_1_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfMinus1CardsModifiedByRemovingPercentage = number_format($row["variable_no_of_minus_1_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfMinus2CardsModifiedByAddingPercentage = number_format($row["variable_no_of_minus_2_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableNoOfMinus2CardsModifiedByRemovingPercentage = number_format($row["variable_no_of_minus_2_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableRedCardsModifiedByAddingPercentage = number_format($row["variable_red_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableRedCardsModifiedByRemovingPercentage = number_format($row["variable_red_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $oldFixedRedCardsModifiedByAddingPercentage = number_format($row["old_fixed_red_cards_modified_by_adding_count"] / $row["old_fixed_updates_count"], 4) * 1000000;
            $oldFixedRedCardsModifiedByRemovingPercentage = number_format($row["old_fixed_red_cards_modified_by_removing_count"] / $row["old_fixed_updates_count"], 4) * 1000000;
            $variableResetCardsModifiedByAddingPercentage = number_format($row["variable_reset_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableResetCardsModifiedByRemovingPercentage = number_format($row["variable_reset_cards_modified_by_removing_count"] / $row["updates_count"], 4) * 1000000;
            $resetPercentage = number_format($row["reset_count"] / ($row["variable_updates_count"] + $row["new_fixed_updates_count"]), 4) * 1000000;
            $variableStickyCardsModifiedByAddingPercentage = number_format($row["variable_sticky_cards_modified_by_adding_count"] / $row["variable_updates_count"], 4) * 1000000;
            $variableStickyCardsModifiedByRemovingPercentage = number_format($row["variable_sticky_cards_modified_by_removing_count"] / $row["variable_updates_count"], 4) * 1000000;
            $fixedTimerHiddenPercentage = number_format($row["fixed_timer_hidden_count"] / ($row["old_fixed_updates_count"] + $row["new_fixed_updates_count"]), 4) * 1000000;
            $fixedTimerUnhiddenPercentage = number_format($row["fixed_timer_unhidden_count"] / ($row["old_fixed_updates_count"] + $row["new_fixed_updates_count"]), 4) * 1000000;
            $unlockedPercentage = number_format($row["unlocked_count"] / $row["updates_count"], 4) * 1000000;
        }
    }

    $file = fopen("bot_code_keyholders_decision2.php", "w");
    
    fwrite($file, "<?php\n");
    
    echo "Generating End of Lock Decision Code<br />";
    // END OF LOCK DECISION
    fwrite($file, "// END OF LOCK DECISION\n");
    fwrite($file, "\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "if (\$chanceRoll <= ".(($resetPercentage + $unlockedPercentage) * 6).") {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($resetPercentage * 4).") {\n");
    fwrite($file, "\t\t\t\$resetLock = 1;\n");
    fwrite($file, "\t\t\tif (\$fixed == 0) { ResetVariableLock(); }\n");
    fwrite($file, "\t\t\tif (\$fixed == 1) { ResetFixedLock(); }\n");
    fwrite($file, "\t\t} else {\n");
    fwrite($file, "\t\t\t\$unlockLock = 1;\n");
    fwrite($file, "\t\t\tUnlockLock();\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($resetPercentage * 8).") {\n");
    fwrite($file, "\t\t\t\$resetLock = 1;\n");
    fwrite($file, "\t\t\tif (\$fixed == 0) { ResetVariableLock(); }\n");
    fwrite($file, "\t\t\tif (\$fixed == 1) { ResetFixedLock(); }\n");
    fwrite($file, "\t\t} else {\n");
    fwrite($file, "\t\t\t\$unlockLock = 1;\n");
    fwrite($file, "\t\t\tUnlockLock();\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n");
    
    fwrite($file, "?>\n");
    
    fclose($file);
    rename("bot_code_keyholders_decision2.php", "bot_code_keyholders_decision.php");
    
    $file = fopen("bot_code2.php", "w");
    
    fwrite($file, "<?php\n");
    fwrite($file, "\$skipIfLines = 0;\n\n");

    echo "Generating Reset Lock Code<br />";
    // RESET LOCK
    fwrite($file, "// RESET LOCK\n");
    fwrite($file, "if (\$trustKeyholder == 1 && time() >= \$earliestTimestampToReset && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= floor(".($resetPercentage / 2)." / ((\$noOfTimesReset + 1) * (\$noOfTimesReset + 1)))) {\n");
    fwrite($file, "\t\t\t\$resetLock = 1;\n");
    fwrite($file, "\t\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t\t\tif (\$fixed == 0) { ResetVariableLock(); }\n");
    fwrite($file, "\t\t\tif (\$fixed == 1) { ResetFixedLock(); }\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= floor(".$resetPercentage." / ((\$noOfTimesReset + 1) * (\$noOfTimesReset + 1)))) {\n");
    fwrite($file, "\t\t\t\$resetLock = 1;\n");
    fwrite($file, "\t\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t\t\tif (\$fixed == 0) { ResetVariableLock(); }\n");
    fwrite($file, "\t\t\tif (\$fixed == 1) { ResetFixedLock(); }\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Unlock Lock Code<br />";
    // UNLOCK LOCK
    fwrite($file, "// UNLOCK LOCK\n");
    fwrite($file, "if (time() >= \$timestampToUnlock && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\t\$chanceRollModifier = floor((time() - \$timestampToUnlock) * 50);\n");
    fwrite($file, "\t\tif (\$chanceRoll - \$chanceRollModifier <= ".$unlockedPercentage.") {\n");
    fwrite($file, "\t\t\t\$unlockLock = 1;\n");
    fwrite($file, "\t\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t\t\tUnlockLock();\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\t\$chanceRollModifier = floor((time() - \$timestampToUnlock) * 25);\n");
    fwrite($file, "\t\tif (\$chanceRoll - \$chanceRollModifier <= ".$unlockedPercentage.") {\n");
    fwrite($file, "\t\t\t\$unlockLock = 1;\n");
    fwrite($file, "\t\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t\t\tUnlockLock();\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n\n");

    echo "Generating Freeze/Unfreeze Code<br />";
    // FREEZE/UNFREEZE
    fwrite($file, "// FREEZE/UNFREEZE\n");
    fwrite($file, "if (\$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$trustKeyholder == 1 && \$lockFrozenByCard == 0 && \$lockFrozenByKeyholder == 0 && time() >= \$earliestTimeToFreeze && \$chanceRoll <= ".$variableFreezeLockPercentage.") {\n");
    fwrite($file, "\t\t\$lockFrozenByKeyholderModifiedBy = 1;\n");
    fwrite($file, "\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$lockFrozenByKeyholder == 1 && ((time() >= \$earliestTimestampToUnfreeze && \$chanceRoll <= ".$variableUnfreezeLockPercentage.") || (time() >= \$maximumTimestampToUnfreeze))) {\n");
    fwrite($file, "\t\t\$lockFrozenByKeyholderModifiedBy = -1;\n");
    fwrite($file, "\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$fixed == 1 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$trustKeyholder == 1 && \$lockFrozenByKeyholder == 0 && time() >= \$earliestTimeToFreeze && \$chanceRoll <= ".$fixedFreezeLockPercentage.") {\n");
    fwrite($file, "\t\t\$lockFrozenByKeyholderModifiedBy = 1;\n");
    fwrite($file, "\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$lockFrozenByKeyholder == 1 && ((time() >= \$earliestTimestampToUnfreeze && \$chanceRoll <= ".$fixedUnfreezeLockPercentage.") || (time() >= \$maximumTimestampToUnfreeze))) {\n");
    fwrite($file, "\t\t\$lockFrozenByKeyholderModifiedBy = -1;\n");
    fwrite($file, "\t\t\$skipIfLines = 1;\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Double Up Cards Code<br />";
    // DOUBLE UP CARDS
    fwrite($file, "// DOUBLE UP CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableDoubleUpCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        double_up_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where double_up_cards_modified_by > 0 and double_up_cards_modified_by < 4 and shared_id not like 'BOT0%') as double_up_cards_modified_by_percentage 
    from ModifiedLocks_V2 where double_up_cards_modified_by > 0 and 
        double_up_cards_modified_by < 4 and 
        shared_id not like 'BOT0%'
    group by double_up_cards_modified_by
    order by double_up_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["double_up_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["double_up_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$doubleUpCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableDoubleUpCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        double_up_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where double_up_cards_modified_by > -3 and double_up_cards_modified_by < 0 and shared_id not like 'BOT0%') as double_up_cards_modified_by_percentage 
    from ModifiedLocks_V2 where double_up_cards_modified_by > -3 and 
        double_up_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by double_up_cards_modified_by
    order by double_up_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["double_up_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["double_up_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$doubleUpCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableDoubleUpCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        double_up_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where double_up_cards_modified_by > 0 and double_up_cards_modified_by < 6 and shared_id not like 'BOT0%') as double_up_cards_modified_by_percentage 
    from ModifiedLocks_V2 where double_up_cards_modified_by > 0 and 
        double_up_cards_modified_by < 6 and 
        shared_id not like 'BOT0%'
    group by double_up_cards_modified_by
    order by double_up_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["double_up_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["double_up_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$doubleUpCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableDoubleUpCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        double_up_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where double_up_cards_modified_by > -3 and double_up_cards_modified_by < 0 and shared_id not like 'BOT0%') as double_up_cards_modified_by_percentage 
    from ModifiedLocks_V2 where double_up_cards_modified_by > -3 and 
        double_up_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by double_up_cards_modified_by
    order by double_up_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["double_up_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["double_up_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$doubleUpCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$doubleUpCards + \$doubleUpCardsModifiedBy < 0) { \$doubleUpCardsModifiedBy = \$doubleUpCardsModifiedBy - (\$doubleUpCards + \$doubleUpCardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$doubleUpCards + \$doubleUpCardsModifiedBy > 20) { \$doubleUpCardsModifiedBy = \$doubleUpCardsModifiedBy - ((\$doubleUpCards + \$doubleUpCardsModifiedBy) - 20); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$doubleUpCards + \$doubleUpCardsModifiedBy > 30) { \$doubleUpCardsModifiedBy = \$doubleUpCardsModifiedBy - ((\$doubleUpCards + \$doubleUpCardsModifiedBy) - 30); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Freeze Cards Code<br />";
    // FREEZE CARDS
    fwrite($file, "// FREEZE CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableFreezeCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        freeze_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where freeze_cards_modified_by > 0 and freeze_cards_modified_by < 4 and shared_id not like 'BOT0%') as freeze_cards_modified_by_percentage 
    from ModifiedLocks_V2 where freeze_cards_modified_by > 0 and 
        freeze_cards_modified_by < 4 and 
        shared_id not like 'BOT0%'
    group by freeze_cards_modified_by
    order by freeze_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["freeze_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["freeze_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$freezeCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableFreezeCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        freeze_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where freeze_cards_modified_by > -3 and freeze_cards_modified_by < 0 and shared_id not like 'BOT0%') as freeze_cards_modified_by_percentage 
    from ModifiedLocks_V2 where freeze_cards_modified_by > -3 and 
        freeze_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by freeze_cards_modified_by
    order by freeze_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["freeze_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["freeze_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$freezeCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableFreezeCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        freeze_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where freeze_cards_modified_by > 0 and freeze_cards_modified_by < 6 and shared_id not like 'BOT0%') as freeze_cards_modified_by_percentage 
    from ModifiedLocks_V2 where freeze_cards_modified_by > 0 and 
        freeze_cards_modified_by < 6 and 
        shared_id not like 'BOT0%'
    group by freeze_cards_modified_by
    order by freeze_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["freeze_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["freeze_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$freezeCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableFreezeCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        freeze_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where freeze_cards_modified_by > -3 and freeze_cards_modified_by < 0 and shared_id not like 'BOT0%') as freeze_cards_modified_by_percentage 
    from ModifiedLocks_V2 where freeze_cards_modified_by > -3 and 
        freeze_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by freeze_cards_modified_by
    order by freeze_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["freeze_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["freeze_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$freezeCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$freezeCards + \$freezeCardsModifiedBy < 0) { \$freezeCardsModifiedBy = \$freezeCardsModifiedBy - (\$freezeCards + \$freezeCardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$freezeCards + \$freezeCardsModifiedBy > 20) { \$freezeCardsModifiedBy = \$freezeCardsModifiedBy - ((\$freezeCards + \$freezeCardsModifiedBy) - 20); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$freezeCards + \$freezeCardsModifiedBy > 30) { \$freezeCardsModifiedBy = \$freezeCardsModifiedBy - ((\$freezeCards + \$freezeCardsModifiedBy) - 30); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Green Cards Code<br />";
    // GREEN CARDS
    fwrite($file, "// GREEN CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$multipleGreensRequired == 1 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableGreenCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        green_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where green_cards_modified_by > 0 and green_cards_modified_by < 3 and shared_id not like 'BOT0%') as green_cards_modified_by_percentage 
    from ModifiedLocks_V2 where green_cards_modified_by > 0 and 
        green_cards_modified_by < 3 and 
        shared_id not like 'BOT0%'
    group by green_cards_modified_by
    order by green_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["green_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["green_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$greenCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableGreenCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        green_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where green_cards_modified_by > -3 and green_cards_modified_by < 0 and shared_id not like 'BOT0%') as green_cards_modified_by_percentage 
    from ModifiedLocks_V2 where green_cards_modified_by > -3 and 
        green_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by green_cards_modified_by
    order by green_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["green_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["green_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$greenCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableGreenCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        green_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where green_cards_modified_by > 0 and green_cards_modified_by < 5 and shared_id not like 'BOT0%') as green_cards_modified_by_percentage 
    from ModifiedLocks_V2 where green_cards_modified_by > 0 and 
        green_cards_modified_by < 5 and 
        shared_id not like 'BOT0%'
    group by green_cards_modified_by
    order by green_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["green_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["green_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$greenCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableGreenCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        green_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where green_cards_modified_by > -3 and green_cards_modified_by < 0 and shared_id not like 'BOT0%') as green_cards_modified_by_percentage 
    from ModifiedLocks_V2 where green_cards_modified_by > -3 and 
        green_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by green_cards_modified_by
    order by green_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["green_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["green_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$greenCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$greenCards + \$greenCardsModifiedBy < 1) { \$greenCardsModifiedBy = \$greenCardsModifiedBy - (\$greenCards + \$greenCardsModifiedBy) + 1; }\n");
    fwrite($file, "\tif (\$build < 166 && \$greenCards + \$greenCardsModifiedBy > 20) { \$greenCardsModifiedBy = \$greenCardsModifiedBy - ((\$greenCards + \$greenCardsModifiedBy) - 20); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$greenCards + \$greenCardsModifiedBy > 30) { \$greenCardsModifiedBy = \$greenCardsModifiedBy - ((\$greenCards + \$greenCardsModifiedBy) - 30); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Red Cards Code<br />";
    // RED CARDS
    fwrite($file, "// RED CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 0 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableRedCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > 0 and red_cards_modified_by < 8 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 
    where red_cards_modified_by > 0 and 
        red_cards_modified_by < 8 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableRedCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > -8 and red_cards_modified_by < 0 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 
    where red_cards_modified_by > -8 and 
        red_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableRedCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > 0 and red_cards_modified_by < 8 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > 0 and 
        red_cards_modified_by < 8 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableRedCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > -6 and red_cards_modified_by < 0 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > -6 and 
        red_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$redCards + \$redCardsModifiedBy < 1) { \$redCardsModifiedBy = \$redCardsModifiedBy - (\$redCards + \$redCardsModifiedBy) + 1; }\n");
    fwrite($file, "\tif (\$build < 166 && \$redCards < 399 && \$redCards + \$redCardsModifiedBy > 399) { \$redCardsModifiedBy = \$redCardsModifiedBy - ((\$redCards + \$redCardsModifiedBy) - 399); }\n");
    fwrite($file, "\tif (\$build < 166 && \$redCards >= 399) { \$redCardsModifiedBy = 0; }\n");
    fwrite($file, "\tif (\$build >= 166 && \$redCards < 599 && \$redCards + \$redCardsModifiedBy > 599) { \$redCardsModifiedBy = \$redCardsModifiedBy - ((\$redCards + \$redCardsModifiedBy) - 599); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$redCards >= 599) { \$redCardsModifiedBy = 0; }\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableRedCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > 0 and red_cards_modified_by < 21 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > 0 and 
        red_cards_modified_by < 21 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableRedCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > -8 and red_cards_modified_by < 0 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > -8 and 
        red_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableRedCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > 0 and red_cards_modified_by < 41 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > 0 and 
        red_cards_modified_by < 41 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableRedCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        red_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where red_cards_modified_by > -6 and red_cards_modified_by < 0 and shared_id not like 'BOT0%') as red_cards_modified_by_percentage 
    from ModifiedLocks_V2 where red_cards_modified_by > -6 and 
        red_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by red_cards_modified_by
    order by red_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["red_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["red_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$redCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$redCards + \$redCardsModifiedBy < 1) { \$redCardsModifiedBy = \$redCardsModifiedBy - (\$redCards + \$redCardsModifiedBy) + 1; }\n");
    fwrite($file, "\tif (\$build < 166 && \$redCards < 399 && \$redCards + \$redCardsModifiedBy > 399) { \$redCardsModifiedBy = \$redCardsModifiedBy - ((\$redCards + \$redCardsModifiedBy) - 399); }\n");
    fwrite($file, "\tif (\$build < 166 && \$redCards >= 399) { \$redCardsModifiedBy = 0; }\n");
    fwrite($file, "\tif (\$build >= 166 && \$redCards < 599 && \$redCards + \$redCardsModifiedBy > 599) { \$redCardsModifiedBy = \$redCardsModifiedBy - ((\$redCards + \$redCardsModifiedBy) - 599); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$redCards >= 599) { \$redCardsModifiedBy = 0; }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Reset Cards Code<br />";
    // RESET CARDS
    fwrite($file, "// RESET CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableResetCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        reset_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where reset_cards_modified_by > 0 and reset_cards_modified_by < 3 and shared_id not like 'BOT0%') as reset_cards_modified_by_percentage 
    from ModifiedLocks_V2 where reset_cards_modified_by > 0 and 
        reset_cards_modified_by < 3 and 
        shared_id not like 'BOT0%'
    group by reset_cards_modified_by
    order by reset_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["reset_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["reset_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$resetCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableResetCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        reset_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where reset_cards_modified_by > -3 and reset_cards_modified_by < 0 and shared_id not like 'BOT0%') as reset_cards_modified_by_percentage 
    from ModifiedLocks_V2 where reset_cards_modified_by > -3 and 
        reset_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by reset_cards_modified_by
    order by reset_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["reset_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["reset_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$resetCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableResetCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        reset_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where reset_cards_modified_by > 0 and reset_cards_modified_by < 4 and shared_id not like 'BOT0%') as reset_cards_modified_by_percentage 
    from ModifiedLocks_V2 where reset_cards_modified_by > 0 and 
        reset_cards_modified_by < 4 and 
        shared_id not like 'BOT0%'
    group by reset_cards_modified_by
    order by reset_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["reset_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["reset_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$resetCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableResetCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        reset_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where reset_cards_modified_by > -3 and reset_cards_modified_by < 0 and shared_id not like 'BOT0%') as reset_cards_modified_by_percentage 
    from ModifiedLocks_V2 where reset_cards_modified_by > -3 and 
        reset_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by reset_cards_modified_by
    order by reset_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["reset_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["reset_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$resetCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$resetCards + \$resetCardsModifiedBy < 0) { \$resetCardsModifiedBy = \$resetCardsModifiedBy - (\$resetCards + \$resetCardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$resetCards + \$resetCardsModifiedBy > 20) { \$resetCardsModifiedBy = \$resetCardsModifiedBy - ((\$resetCards + \$resetCardsModifiedBy) - 20); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$resetCards + \$resetCardsModifiedBy > 30) { \$resetCardsModifiedBy = \$resetCardsModifiedBy - ((\$resetCards + \$resetCardsModifiedBy) - 30); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Sticky Cards Code<br />";
    // STICKY CARDS
    fwrite($file, "// STICKY CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$stickyCards > 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableStickyCardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        sticky_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where sticky_cards_modified_by > 0 and sticky_cards_modified_by < 3 and shared_id not like 'BOT0%') as sticky_cards_modified_by_percentage 
    from ModifiedLocks_V2 where sticky_cards_modified_by > 0 and 
        sticky_cards_modified_by < 3 and 
        shared_id not like 'BOT0%'
    group by sticky_cards_modified_by
    order by sticky_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["sticky_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["sticky_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$stickyCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableStickyCardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        sticky_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where sticky_cards_modified_by > -2 and sticky_cards_modified_by < 0 and shared_id not like 'BOT0%') as sticky_cards_modified_by_percentage 
    from ModifiedLocks_V2 where sticky_cards_modified_by > -2 and 
        sticky_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by sticky_cards_modified_by
    order by sticky_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["sticky_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["sticky_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$stickyCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableStickyCardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        sticky_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where sticky_cards_modified_by > 0 and sticky_cards_modified_by < 4 and shared_id not like 'BOT0%') as sticky_cards_modified_by_percentage 
    from ModifiedLocks_V2 where sticky_cards_modified_by > 0 and 
        sticky_cards_modified_by < 4 and 
        shared_id not like 'BOT0%'
    group by sticky_cards_modified_by
    order by sticky_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["sticky_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["sticky_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$stickyCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableStickyCardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        sticky_cards_modified_by, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where sticky_cards_modified_by > -2 and sticky_cards_modified_by < 0 and shared_id not like 'BOT0%') as sticky_cards_modified_by_percentage 
    from ModifiedLocks_V2 where sticky_cards_modified_by > -2 and 
        sticky_cards_modified_by < 0 and 
        shared_id not like 'BOT0%'
    group by sticky_cards_modified_by
    order by sticky_cards_modified_by asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["sticky_cards_modified_by_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["sticky_cards_modified_by"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$stickyCardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$stickyCards + \$stickyCardsModifiedBy < 0) { \$stickyCardsModifiedBy = \$stickyCardsModifiedBy - (\$stickyCards + \$stickyCardsModifiedBy); }\n");
    fwrite($file, "\tif (\$stickyCards + \$stickyCardsModifiedBy > 30) { \$stickyCardsModifiedBy = \$stickyCardsModifiedBy - ((\$stickyCards + \$stickyCardsModifiedBy) - 30); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Yellow Add 1 Cards Code<br />";
    // YELLOW ADD 1 CARDS
    fwrite($file, "// YELLOW ADD 1 CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 0 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd1CardsModifiedByAddingPercentage / 2.0).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > 0 and no_of_add_1_cards < 4 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > 0 and 
        no_of_add_1_cards < 4 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd1CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > -3 and no_of_add_1_cards < 0 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > -3 and 
        no_of_add_1_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd1CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > 0 and no_of_add_1_cards < 5 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > 0 and 
        no_of_add_1_cards < 5 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd1CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > -3 and no_of_add_1_cards < 0 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > -3 and 
        no_of_add_1_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy < 0) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - (\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy > 199) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - ((\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy > 299) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - ((\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd1CardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > 0 and no_of_add_1_cards < 11 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > 0 and 
        no_of_add_1_cards < 11 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd1CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > -6 and no_of_add_1_cards < 0 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > -6 and 
        no_of_add_1_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd1CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > 0 and no_of_add_1_cards < 21 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > 0 and 
        no_of_add_1_cards < 21 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd1CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_1_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_1_cards > -6 and no_of_add_1_cards < 0 and shared_id not like 'BOT0%') as no_of_add_1_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_1_cards > -6 and 
        no_of_add_1_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_1_cards
    order by no_of_add_1_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_1_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_1_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd1CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy < 0) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - (\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy > 199) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - ((\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy > 299) { \$noOfAdd1CardsModifiedBy = \$noOfAdd1CardsModifiedBy - ((\$noOfAdd1Cards + \$noOfAdd1CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Yellow Add 2 Cards Code<br />";
    // YELLOW ADD 2 CARDS
    fwrite($file, "// YELLOW ADD 2 CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 0 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd2CardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > 0 and no_of_add_2_cards < 4 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > 0 and 
        no_of_add_2_cards < 4 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd2CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > -3 and no_of_add_2_cards < 0 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > -3 and 
        no_of_add_2_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd2CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > 0 and no_of_add_2_cards < 5 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > 0 and 
        no_of_add_2_cards < 5 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd2CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > -3 and no_of_add_2_cards < 0 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > -3 and 
        no_of_add_2_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy < 0) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - (\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy > 199) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - ((\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy > 299) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - ((\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd2CardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > 0 and no_of_add_2_cards < 8 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > 0 and 
        no_of_add_2_cards < 8 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd2CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > -5 and no_of_add_2_cards < 0 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > -5 and 
        no_of_add_2_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd2CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > 0 and no_of_add_2_cards < 15 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > 0 and 
        no_of_add_2_cards < 15 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd2CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_2_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_2_cards > -5 and no_of_add_2_cards < 0 and shared_id not like 'BOT0%') as no_of_add_2_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_2_cards > -5 and 
        no_of_add_2_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_2_cards
    order by no_of_add_2_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_2_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_2_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd2CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy < 0) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - (\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy > 199) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - ((\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy > 299) { \$noOfAdd2CardsModifiedBy = \$noOfAdd2CardsModifiedBy - ((\$noOfAdd2Cards + \$noOfAdd2CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n\n");
    
    echo "Generating Yellow Add 3 Cards Code<br />";
    // YELLOW ADD 3 CARDS
    fwrite($file, "// YELLOW ADD 3 CARDS\n");
    fwrite($file, "if (\$trustKeyholder == 0 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd3CardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > 0 and no_of_add_3_cards < 4 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > 0 and 
        no_of_add_3_cards < 4 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd3CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > -3 and no_of_add_3_cards < 0 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > -3 and 
        no_of_add_3_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd3CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > 0 and no_of_add_3_cards < 5 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > 0 and 
        no_of_add_3_cards < 5 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd3CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > -3 and no_of_add_3_cards < 0 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > -3 and 
        no_of_add_3_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy < 0) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - (\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy > 199) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - ((\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy > 299) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - ((\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 0 && \$skipIfLines == 0) {\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($variableNoOfAdd3CardsModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > 0 and no_of_add_3_cards < 5 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > 0 and 
        no_of_add_3_cards < 6 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $variableNoOfAdd3CardsModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > -4 and no_of_add_3_cards < 0 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > -4 and 
        no_of_add_3_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$variableNoOfAdd3CardsModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > 0 and no_of_add_3_cards < 11 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > 0 and 
        no_of_add_3_cards < 11 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($variableNoOfAdd3CardsModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$modifiedRoll = mt_rand(1, 1000000) + \$botLoyaltyPoints;\n");
    fwrite($file, "\t\t\tif (\$modifiedRoll > 1000000) { \$modifiedRoll = 1000000; }\n");
    $query = $pdo->prepare("select
        no_of_add_3_cards, 
        count(*) * 100 / (select count(*) from ModifiedLocks_V2 where no_of_add_3_cards > -4 and no_of_add_3_cards < 0 and shared_id not like 'BOT0%') as no_of_add_3_cards_percentage 
    from ModifiedLocks_V2 where no_of_add_3_cards > -4 and 
        no_of_add_3_cards < 0 and 
        shared_id not like 'BOT0%'
    group by no_of_add_3_cards
    order by no_of_add_3_cards asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        $startNumber = 0;
        $counter = 0;
        foreach ($query as $row) {
            $endNumber = $startNumber + $row["no_of_add_3_cards_percentage"] * 10000;
            $counter++;
            if ($counter == $query->rowCount()) { $endNumber = 1000000; }
            $modifiedBy = $row["no_of_add_3_cards"];
            fwrite($file, "\t\t\tif (\$modifiedRoll > ".$startNumber." && \$modifiedRoll <= ".$endNumber.") { \$modifiedBy = ".$modifiedBy."; }\n");
            $startNumber = $endNumber;
        }
        fwrite($file, "\t\t\t\$noOfAdd3CardsModifiedBy = \$modifiedBy;\n");
    }
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy < 0) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - (\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy); }\n");
    fwrite($file, "\tif (\$build < 166 && \$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy > 199) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - ((\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy) - 199); }\n");
    fwrite($file, "\tif (\$build >= 166 && \$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy > 299) { \$noOfAdd3CardsModifiedBy = \$noOfAdd3CardsModifiedBy - ((\$noOfAdd3Cards + \$noOfAdd3CardsModifiedBy) - 299); }\n");
    fwrite($file, "}\n\n");

    echo "Generating Minutes Code<br />";
    // MINUTES
    fwrite($file, "// MINUTES\n");
    fwrite($file, "if (\$trustKeyholder == 0 && \$fixed == 1 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($newFixedMinutesModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * (10 + (\$timesLockedWithBot * 0.2))));\n");
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $newFixedMinutesModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = -mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * 5));\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$newFixedMinutesModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * (20 + (\$timesLockedWithBot * 0.2))));\n");
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($newFixedMinutesModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = -mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * 2.5));\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$minutes + \$minutesModifiedBy < 0) { \$minutesModifiedBy = \$minutesModifiedBy - (\$minutes + \$minutesModifiedBy); }\n");
    fwrite($file, "\tif (\$minutes + \$minutesModifiedBy > 576000) { \$minutesModifiedBy = \$minutesModifiedBy - ((\$minutes + \$minutesModifiedBy) - 576000); }\n");
    fwrite($file, "}\n");
    fwrite($file, "if (\$trustKeyholder == 1 && \$fixed == 1 && \$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$botChosen == 1 || \$botChosen == 2) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".($newFixedMinutesModifiedByAddingPercentage / 2).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = mt_rand(ceil((\$initialMinutes / 100) * 5), ceil((\$initialMinutes / 100) * (30 + (\$timesLockedWithBot * 0.2))));\n");
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - $newFixedMinutesModifiedByRemovingPercentage).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = -mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * 5));\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$botChosen == 3 || \$botChosen == 4) {\n");
    fwrite($file, "\t\tif (\$chanceRoll <= ".$newFixedMinutesModifiedByAddingPercentage.") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = mt_rand(ceil((\$initialMinutes / 100) * 10), ceil((\$initialMinutes / 100) * (60 + (\$timesLockedWithBot * 0.2))));\n");
    fwrite($file, "\t\t} elseif (\$chanceRoll >= ".(1000000 - ($newFixedMinutesModifiedByRemovingPercentage / 2)).") {\n");
    fwrite($file, "\t\t\t\$minutesModifiedBy = -mt_rand(ceil(\$initialMinutes / 100), ceil((\$initialMinutes / 100) * 2.5));\n");
    fwrite($file, "\t\t}\n");
    fwrite($file, "\t}\n");
    fwrite($file, "\tif (\$minutes + \$minutesModifiedBy < 0) { \$minutesModifiedBy = \$minutesModifiedBy - (\$minutes + \$minutesModifiedBy); }\n");
    fwrite($file, "\tif (\$minutes + \$minutesModifiedBy > 576000) { \$minutesModifiedBy = \$minutesModifiedBy - ((\$minutes + \$minutesModifiedBy) - 576000); }\n");
    fwrite($file, "}\n\n");
    
    fwrite($file, "?>");
    
    fclose($file);
    rename("bot_code2.php", "bot_code.php");
    $query = null;
    $pdo = null;

} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>