<?php
$skipIfLines = 0;

// RESET LOCK
if ($trustKeyholder == 1 && time() >= $earliestTimestampToReset && time() < $timestampToUnlock && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= floor(41700 / (($noOfTimesReset + 1) * ($noOfTimesReset + 1)))) {
			$resetLock = 1;
			$skipIfLines = 1;
			if ($fixed == 0) { ResetVariableLock(); }
			if ($fixed == 1) { ResetFixedLock(); }
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= floor(83400 / (($noOfTimesReset + 1) * ($noOfTimesReset + 1)))) {
			$resetLock = 1;
			$skipIfLines = 1;
			if ($fixed == 0) { ResetVariableLock(); }
			if ($fixed == 1) { ResetFixedLock(); }
		}
	}
}

// UNLOCK LOCK
if (time() >= $timestampToUnlock && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		$chanceRollModifier = floor((time() - $timestampToUnlock) * 50);
		if ($chanceRoll - $chanceRollModifier <= 95300) {
			$unlockLock = 1;
			$skipIfLines = 1;
			UnlockLock();
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		$chanceRollModifier = floor((time() - $timestampToUnlock) * 25);
		if ($chanceRoll - $chanceRollModifier <= 95300) {
			$unlockLock = 1;
			$skipIfLines = 1;
			UnlockLock();
		}
	}
}

// FREEZE/UNFREEZE
if ($fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($trustKeyholder == 1 && $lockFrozenByCard == 0 && $lockFrozenByKeyholder == 0 && time() >= $earliestTimeToFreeze && $chanceRoll <= 60800) {
		$lockFrozenByKeyholderModifiedBy = 1;
		$skipIfLines = 1;
	}
	if ($lockFrozenByKeyholder == 1 && ((time() >= $earliestTimestampToUnfreeze && $chanceRoll <= 95800) || (time() >= $maximumTimestampToUnfreeze))) {
		$lockFrozenByKeyholderModifiedBy = -1;
		$skipIfLines = 1;
	}
}
if ($fixed == 1 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($trustKeyholder == 1 && $lockFrozenByKeyholder == 0 && time() >= $earliestTimeToFreeze && $chanceRoll <= 95100) {
		$lockFrozenByKeyholderModifiedBy = 1;
		$skipIfLines = 1;
	}
	if ($lockFrozenByKeyholder == 1 && ((time() >= $earliestTimestampToUnfreeze && $chanceRoll <= 75800) || (time() >= $maximumTimestampToUnfreeze))) {
		$lockFrozenByKeyholderModifiedBy = -1;
		$skipIfLines = 1;
	}
}

// DOUBLE UP CARDS
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 45850) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 662037) { $modifiedBy = 1; }
			if ($modifiedRoll > 662037 && $modifiedRoll <= 908186) { $modifiedBy = 2; }
			if ($modifiedRoll > 908186 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$doubleUpCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 970900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 277370) { $modifiedBy = -2; }
			if ($modifiedRoll > 277370 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$doubleUpCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 91700) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 597685) { $modifiedBy = 1; }
			if ($modifiedRoll > 597685 && $modifiedRoll <= 819907) { $modifiedBy = 2; }
			if ($modifiedRoll > 819907 && $modifiedRoll <= 902796) { $modifiedBy = 3; }
			if ($modifiedRoll > 902796 && $modifiedRoll <= 955319) { $modifiedBy = 4; }
			if ($modifiedRoll > 955319 && $modifiedRoll <= 1000000) { $modifiedBy = 5; }
			$doubleUpCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 985450) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 277370) { $modifiedBy = -2; }
			if ($modifiedRoll > 277370 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$doubleUpCardsModifiedBy = $modifiedBy;
		}
	}
	if ($doubleUpCards + $doubleUpCardsModifiedBy < 0) { $doubleUpCardsModifiedBy = $doubleUpCardsModifiedBy - ($doubleUpCards + $doubleUpCardsModifiedBy); }
	if ($build < 166 && $doubleUpCards + $doubleUpCardsModifiedBy > 20) { $doubleUpCardsModifiedBy = $doubleUpCardsModifiedBy - (($doubleUpCards + $doubleUpCardsModifiedBy) - 20); }
	if ($build >= 166 && $doubleUpCards + $doubleUpCardsModifiedBy > 30) { $doubleUpCardsModifiedBy = $doubleUpCardsModifiedBy - (($doubleUpCards + $doubleUpCardsModifiedBy) - 30); }
}

// FREEZE CARDS
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 48150) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 606936) { $modifiedBy = 1; }
			if ($modifiedRoll > 606936 && $modifiedRoll <= 895280) { $modifiedBy = 2; }
			if ($modifiedRoll > 895280 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$freezeCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 973900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 289865) { $modifiedBy = -2; }
			if ($modifiedRoll > 289865 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$freezeCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 96300) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 541888) { $modifiedBy = 1; }
			if ($modifiedRoll > 541888 && $modifiedRoll <= 799329) { $modifiedBy = 2; }
			if ($modifiedRoll > 799329 && $modifiedRoll <= 892825) { $modifiedBy = 3; }
			if ($modifiedRoll > 892825 && $modifiedRoll <= 950655) { $modifiedBy = 4; }
			if ($modifiedRoll > 950655 && $modifiedRoll <= 1000000) { $modifiedBy = 5; }
			$freezeCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 986950) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 289865) { $modifiedBy = -2; }
			if ($modifiedRoll > 289865 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$freezeCardsModifiedBy = $modifiedBy;
		}
	}
	if ($freezeCards + $freezeCardsModifiedBy < 0) { $freezeCardsModifiedBy = $freezeCardsModifiedBy - ($freezeCards + $freezeCardsModifiedBy); }
	if ($build < 166 && $freezeCards + $freezeCardsModifiedBy > 20) { $freezeCardsModifiedBy = $freezeCardsModifiedBy - (($freezeCards + $freezeCardsModifiedBy) - 20); }
	if ($build >= 166 && $freezeCards + $freezeCardsModifiedBy > 30) { $freezeCardsModifiedBy = $freezeCardsModifiedBy - (($freezeCards + $freezeCardsModifiedBy) - 30); }
}

// GREEN CARDS
if ($trustKeyholder == 1 && $fixed == 0 && $multipleGreensRequired == 1 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 42150) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 684637) { $modifiedBy = 1; }
			if ($modifiedRoll > 684637 && $modifiedRoll <= 1000000) { $modifiedBy = 2; }
			$greenCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 993400) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 344340) { $modifiedBy = -2; }
			if ($modifiedRoll > 344340 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$greenCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 84300) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 524017) { $modifiedBy = 1; }
			if ($modifiedRoll > 524017 && $modifiedRoll <= 765394) { $modifiedBy = 2; }
			if ($modifiedRoll > 765394 && $modifiedRoll <= 902080) { $modifiedBy = 3; }
			if ($modifiedRoll > 902080 && $modifiedRoll <= 1000000) { $modifiedBy = 4; }
			$greenCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 996700) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 344340) { $modifiedBy = -2; }
			if ($modifiedRoll > 344340 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$greenCardsModifiedBy = $modifiedBy;
		}
	}
	if ($greenCards + $greenCardsModifiedBy < 1) { $greenCardsModifiedBy = $greenCardsModifiedBy - ($greenCards + $greenCardsModifiedBy) + 1; }
	if ($build < 166 && $greenCards + $greenCardsModifiedBy > 20) { $greenCardsModifiedBy = $greenCardsModifiedBy - (($greenCards + $greenCardsModifiedBy) - 20); }
	if ($build >= 166 && $greenCards + $greenCardsModifiedBy > 30) { $greenCardsModifiedBy = $greenCardsModifiedBy - (($greenCards + $greenCardsModifiedBy) - 30); }
}

// RED CARDS
if ($trustKeyholder == 0 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 70250) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 372334) { $modifiedBy = 1; }
			if ($modifiedRoll > 372334 && $modifiedRoll <= 560655) { $modifiedBy = 2; }
			if ($modifiedRoll > 560655 && $modifiedRoll <= 685926) { $modifiedBy = 3; }
			if ($modifiedRoll > 685926 && $modifiedRoll <= 772205) { $modifiedBy = 4; }
			if ($modifiedRoll > 772205 && $modifiedRoll <= 851098) { $modifiedBy = 5; }
			if ($modifiedRoll > 851098 && $modifiedRoll <= 903470) { $modifiedBy = 6; }
			if ($modifiedRoll > 903470 && $modifiedRoll <= 1000000) { $modifiedBy = 7; }
			$redCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 869900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 44522) { $modifiedBy = -7; }
			if ($modifiedRoll > 44522 && $modifiedRoll <= 96726) { $modifiedBy = -6; }
			if ($modifiedRoll > 96726 && $modifiedRoll <= 175716) { $modifiedBy = -5; }
			if ($modifiedRoll > 175716 && $modifiedRoll <= 266088) { $modifiedBy = -4; }
			if ($modifiedRoll > 266088 && $modifiedRoll <= 387227) { $modifiedBy = -3; }
			if ($modifiedRoll > 387227 && $modifiedRoll <= 560650) { $modifiedBy = -2; }
			if ($modifiedRoll > 560650 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$redCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 140500) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 372334) { $modifiedBy = 1; }
			if ($modifiedRoll > 372334 && $modifiedRoll <= 560655) { $modifiedBy = 2; }
			if ($modifiedRoll > 560655 && $modifiedRoll <= 685926) { $modifiedBy = 3; }
			if ($modifiedRoll > 685926 && $modifiedRoll <= 772205) { $modifiedBy = 4; }
			if ($modifiedRoll > 772205 && $modifiedRoll <= 851098) { $modifiedBy = 5; }
			if ($modifiedRoll > 851098 && $modifiedRoll <= 903470) { $modifiedBy = 6; }
			if ($modifiedRoll > 903470 && $modifiedRoll <= 1000000) { $modifiedBy = 7; }
			$redCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 934950) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 87448) { $modifiedBy = -5; }
			if ($modifiedRoll > 87448 && $modifiedRoll <= 187497) { $modifiedBy = -4; }
			if ($modifiedRoll > 187497 && $modifiedRoll <= 321608) { $modifiedBy = -3; }
			if ($modifiedRoll > 321608 && $modifiedRoll <= 513602) { $modifiedBy = -2; }
			if ($modifiedRoll > 513602 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$redCardsModifiedBy = $modifiedBy;
		}
	}
	if ($redCards + $redCardsModifiedBy < 1) { $redCardsModifiedBy = $redCardsModifiedBy - ($redCards + $redCardsModifiedBy) + 1; }
	if ($build < 166 && $redCards < 399 && $redCards + $redCardsModifiedBy > 399) { $redCardsModifiedBy = $redCardsModifiedBy - (($redCards + $redCardsModifiedBy) - 399); }
	if ($build < 166 && $redCards >= 399) { $redCardsModifiedBy = 0; }
	if ($build >= 166 && $redCards < 599 && $redCards + $redCardsModifiedBy > 599) { $redCardsModifiedBy = $redCardsModifiedBy - (($redCards + $redCardsModifiedBy) - 599); }
	if ($build >= 166 && $redCards >= 599) { $redCardsModifiedBy = 0; }
}
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 70250) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 306326) { $modifiedBy = 1; }
			if ($modifiedRoll > 306326 && $modifiedRoll <= 461261) { $modifiedBy = 2; }
			if ($modifiedRoll > 461261 && $modifiedRoll <= 564324) { $modifiedBy = 3; }
			if ($modifiedRoll > 564324 && $modifiedRoll <= 635308) { $modifiedBy = 4; }
			if ($modifiedRoll > 635308 && $modifiedRoll <= 700215) { $modifiedBy = 5; }
			if ($modifiedRoll > 700215 && $modifiedRoll <= 743303) { $modifiedBy = 6; }
			if ($modifiedRoll > 743303 && $modifiedRoll <= 822719) { $modifiedBy = 7; }
			if ($modifiedRoll > 822719 && $modifiedRoll <= 845463) { $modifiedBy = 8; }
			if ($modifiedRoll > 845463 && $modifiedRoll <= 864882) { $modifiedBy = 9; }
			if ($modifiedRoll > 864882 && $modifiedRoll <= 895596) { $modifiedBy = 10; }
			if ($modifiedRoll > 895596 && $modifiedRoll <= 908564) { $modifiedBy = 11; }
			if ($modifiedRoll > 908564 && $modifiedRoll <= 922545) { $modifiedBy = 12; }
			if ($modifiedRoll > 922545 && $modifiedRoll <= 932827) { $modifiedBy = 13; }
			if ($modifiedRoll > 932827 && $modifiedRoll <= 943241) { $modifiedBy = 14; }
			if ($modifiedRoll > 943241 && $modifiedRoll <= 953897) { $modifiedBy = 15; }
			if ($modifiedRoll > 953897 && $modifiedRoll <= 962748) { $modifiedBy = 16; }
			if ($modifiedRoll > 962748 && $modifiedRoll <= 969860) { $modifiedBy = 17; }
			if ($modifiedRoll > 969860 && $modifiedRoll <= 979437) { $modifiedBy = 18; }
			if ($modifiedRoll > 979437 && $modifiedRoll <= 986483) { $modifiedBy = 19; }
			if ($modifiedRoll > 986483 && $modifiedRoll <= 1000000) { $modifiedBy = 20; }
			$redCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 869900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 44522) { $modifiedBy = -7; }
			if ($modifiedRoll > 44522 && $modifiedRoll <= 96726) { $modifiedBy = -6; }
			if ($modifiedRoll > 96726 && $modifiedRoll <= 175716) { $modifiedBy = -5; }
			if ($modifiedRoll > 175716 && $modifiedRoll <= 266088) { $modifiedBy = -4; }
			if ($modifiedRoll > 266088 && $modifiedRoll <= 387227) { $modifiedBy = -3; }
			if ($modifiedRoll > 387227 && $modifiedRoll <= 560650) { $modifiedBy = -2; }
			if ($modifiedRoll > 560650 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$redCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 140500) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 275222) { $modifiedBy = 1; }
			if ($modifiedRoll > 275222 && $modifiedRoll <= 414425) { $modifiedBy = 2; }
			if ($modifiedRoll > 414425 && $modifiedRoll <= 507023) { $modifiedBy = 3; }
			if ($modifiedRoll > 507023 && $modifiedRoll <= 570799) { $modifiedBy = 4; }
			if ($modifiedRoll > 570799 && $modifiedRoll <= 629115) { $modifiedBy = 5; }
			if ($modifiedRoll > 629115 && $modifiedRoll <= 667828) { $modifiedBy = 6; }
			if ($modifiedRoll > 667828 && $modifiedRoll <= 739180) { $modifiedBy = 7; }
			if ($modifiedRoll > 739180 && $modifiedRoll <= 759614) { $modifiedBy = 8; }
			if ($modifiedRoll > 759614 && $modifiedRoll <= 777061) { $modifiedBy = 9; }
			if ($modifiedRoll > 777061 && $modifiedRoll <= 804656) { $modifiedBy = 10; }
			if ($modifiedRoll > 804656 && $modifiedRoll <= 816307) { $modifiedBy = 11; }
			if ($modifiedRoll > 816307 && $modifiedRoll <= 828868) { $modifiedBy = 12; }
			if ($modifiedRoll > 828868 && $modifiedRoll <= 838106) { $modifiedBy = 13; }
			if ($modifiedRoll > 838106 && $modifiedRoll <= 847463) { $modifiedBy = 14; }
			if ($modifiedRoll > 847463 && $modifiedRoll <= 857037) { $modifiedBy = 15; }
			if ($modifiedRoll > 857037 && $modifiedRoll <= 864989) { $modifiedBy = 16; }
			if ($modifiedRoll > 864989 && $modifiedRoll <= 871378) { $modifiedBy = 17; }
			if ($modifiedRoll > 871378 && $modifiedRoll <= 879983) { $modifiedBy = 18; }
			if ($modifiedRoll > 879983 && $modifiedRoll <= 886313) { $modifiedBy = 19; }
			if ($modifiedRoll > 886313 && $modifiedRoll <= 898459) { $modifiedBy = 20; }
			if ($modifiedRoll > 898459 && $modifiedRoll <= 904235) { $modifiedBy = 21; }
			if ($modifiedRoll > 904235 && $modifiedRoll <= 910526) { $modifiedBy = 22; }
			if ($modifiedRoll > 910526 && $modifiedRoll <= 915590) { $modifiedBy = 23; }
			if ($modifiedRoll > 915590 && $modifiedRoll <= 935431) { $modifiedBy = 24; }
			if ($modifiedRoll > 935431 && $modifiedRoll <= 956162) { $modifiedBy = 25; }
			if ($modifiedRoll > 956162 && $modifiedRoll <= 959505) { $modifiedBy = 26; }
			if ($modifiedRoll > 959505 && $modifiedRoll <= 963006) { $modifiedBy = 27; }
			if ($modifiedRoll > 963006 && $modifiedRoll <= 966151) { $modifiedBy = 28; }
			if ($modifiedRoll > 966151 && $modifiedRoll <= 969356) { $modifiedBy = 29; }
			if ($modifiedRoll > 969356 && $modifiedRoll <= 975627) { $modifiedBy = 30; }
			if ($modifiedRoll > 975627 && $modifiedRoll <= 978574) { $modifiedBy = 31; }
			if ($modifiedRoll > 978574 && $modifiedRoll <= 981007) { $modifiedBy = 32; }
			if ($modifiedRoll > 981007 && $modifiedRoll <= 983559) { $modifiedBy = 33; }
			if ($modifiedRoll > 983559 && $modifiedRoll <= 986032) { $modifiedBy = 34; }
			if ($modifiedRoll > 986032 && $modifiedRoll <= 989138) { $modifiedBy = 35; }
			if ($modifiedRoll > 989138 && $modifiedRoll <= 992066) { $modifiedBy = 36; }
			if ($modifiedRoll > 992066 && $modifiedRoll <= 993767) { $modifiedBy = 37; }
			if ($modifiedRoll > 993767 && $modifiedRoll <= 995270) { $modifiedBy = 38; }
			if ($modifiedRoll > 995270 && $modifiedRoll <= 997545) { $modifiedBy = 39; }
			if ($modifiedRoll > 997545 && $modifiedRoll <= 1000000) { $modifiedBy = 40; }
			$redCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 934950) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 87448) { $modifiedBy = -5; }
			if ($modifiedRoll > 87448 && $modifiedRoll <= 187497) { $modifiedBy = -4; }
			if ($modifiedRoll > 187497 && $modifiedRoll <= 321608) { $modifiedBy = -3; }
			if ($modifiedRoll > 321608 && $modifiedRoll <= 513602) { $modifiedBy = -2; }
			if ($modifiedRoll > 513602 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$redCardsModifiedBy = $modifiedBy;
		}
	}
	if ($redCards + $redCardsModifiedBy < 1) { $redCardsModifiedBy = $redCardsModifiedBy - ($redCards + $redCardsModifiedBy) + 1; }
	if ($build < 166 && $redCards < 399 && $redCards + $redCardsModifiedBy > 399) { $redCardsModifiedBy = $redCardsModifiedBy - (($redCards + $redCardsModifiedBy) - 399); }
	if ($build < 166 && $redCards >= 399) { $redCardsModifiedBy = 0; }
	if ($build >= 166 && $redCards < 599 && $redCards + $redCardsModifiedBy > 599) { $redCardsModifiedBy = $redCardsModifiedBy - (($redCards + $redCardsModifiedBy) - 599); }
	if ($build >= 166 && $redCards >= 599) { $redCardsModifiedBy = 0; }
}

// RESET CARDS
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 32500) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 758800) { $modifiedBy = 1; }
			if ($modifiedRoll > 758800 && $modifiedRoll <= 1000000) { $modifiedBy = 2; }
			$resetCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 976200) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 162557) { $modifiedBy = -2; }
			if ($modifiedRoll > 162557 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$resetCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 65000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 705330) { $modifiedBy = 1; }
			if ($modifiedRoll > 705330 && $modifiedRoll <= 929534) { $modifiedBy = 2; }
			if ($modifiedRoll > 929534 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$resetCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 988100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 162557) { $modifiedBy = -2; }
			if ($modifiedRoll > 162557 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$resetCardsModifiedBy = $modifiedBy;
		}
	}
	if ($resetCards + $resetCardsModifiedBy < 0) { $resetCardsModifiedBy = $resetCardsModifiedBy - ($resetCards + $resetCardsModifiedBy); }
	if ($build < 166 && $resetCards + $resetCardsModifiedBy > 20) { $resetCardsModifiedBy = $resetCardsModifiedBy - (($resetCards + $resetCardsModifiedBy) - 20); }
	if ($build >= 166 && $resetCards + $resetCardsModifiedBy > 30) { $resetCardsModifiedBy = $resetCardsModifiedBy - (($resetCards + $resetCardsModifiedBy) - 30); }
}

// STICKY CARDS
if ($trustKeyholder == 1 && $fixed == 0 && $stickyCards > 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 777778) { $modifiedBy = 1; }
			if ($modifiedRoll > 777778 && $modifiedRoll <= 1000000) { $modifiedBy = 2; }
			$stickyCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 1000000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$stickyCardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 200) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 660377) { $modifiedBy = 1; }
			if ($modifiedRoll > 660377 && $modifiedRoll <= 849056) { $modifiedBy = 2; }
			if ($modifiedRoll > 849056 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$stickyCardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 1000000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$stickyCardsModifiedBy = $modifiedBy;
		}
	}
	if ($stickyCards + $stickyCardsModifiedBy < 0) { $stickyCardsModifiedBy = $stickyCardsModifiedBy - ($stickyCards + $stickyCardsModifiedBy); }
	if ($stickyCards + $stickyCardsModifiedBy > 30) { $stickyCardsModifiedBy = $stickyCardsModifiedBy - (($stickyCards + $stickyCardsModifiedBy) - 30); }
}

// YELLOW ADD 1 CARDS
if ($trustKeyholder == 0 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 45000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 591599) { $modifiedBy = 1; }
			if ($modifiedRoll > 591599 && $modifiedRoll <= 811696) { $modifiedBy = 2; }
			if ($modifiedRoll > 811696 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 943300) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 322141) { $modifiedBy = -2; }
			if ($modifiedRoll > 322141 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 90000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 554429) { $modifiedBy = 1; }
			if ($modifiedRoll > 554429 && $modifiedRoll <= 760698) { $modifiedBy = 2; }
			if ($modifiedRoll > 760698 && $modifiedRoll <= 937171) { $modifiedBy = 3; }
			if ($modifiedRoll > 937171 && $modifiedRoll <= 1000000) { $modifiedBy = 4; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 971650) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 322141) { $modifiedBy = -2; }
			if ($modifiedRoll > 322141 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd1Cards + $noOfAdd1CardsModifiedBy < 0) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - ($noOfAdd1Cards + $noOfAdd1CardsModifiedBy); }
	if ($build < 166 && $noOfAdd1Cards + $noOfAdd1CardsModifiedBy > 199) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - (($noOfAdd1Cards + $noOfAdd1CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd1Cards + $noOfAdd1CardsModifiedBy > 299) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - (($noOfAdd1Cards + $noOfAdd1CardsModifiedBy) - 299); }
}
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 45000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 488264) { $modifiedBy = 1; }
			if ($modifiedRoll > 488264 && $modifiedRoll <= 669917) { $modifiedBy = 2; }
			if ($modifiedRoll > 669917 && $modifiedRoll <= 825330) { $modifiedBy = 3; }
			if ($modifiedRoll > 825330 && $modifiedRoll <= 880661) { $modifiedBy = 4; }
			if ($modifiedRoll > 880661 && $modifiedRoll <= 924463) { $modifiedBy = 5; }
			if ($modifiedRoll > 924463 && $modifiedRoll <= 945248) { $modifiedBy = 6; }
			if ($modifiedRoll > 945248 && $modifiedRoll <= 960661) { $modifiedBy = 7; }
			if ($modifiedRoll > 960661 && $modifiedRoll <= 974256) { $modifiedBy = 8; }
			if ($modifiedRoll > 974256 && $modifiedRoll <= 985992) { $modifiedBy = 9; }
			if ($modifiedRoll > 985992 && $modifiedRoll <= 1000000) { $modifiedBy = 10; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 943300) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 66252) { $modifiedBy = -5; }
			if ($modifiedRoll > 66252 && $modifiedRoll <= 164143) { $modifiedBy = -4; }
			if ($modifiedRoll > 164143 && $modifiedRoll <= 299351) { $modifiedBy = -3; }
			if ($modifiedRoll > 299351 && $modifiedRoll <= 525059) { $modifiedBy = -2; }
			if ($modifiedRoll > 525059 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 90000) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 470139) { $modifiedBy = 1; }
			if ($modifiedRoll > 470139 && $modifiedRoll <= 645048) { $modifiedBy = 2; }
			if ($modifiedRoll > 645048 && $modifiedRoll <= 794692) { $modifiedBy = 3; }
			if ($modifiedRoll > 794692 && $modifiedRoll <= 847969) { $modifiedBy = 4; }
			if ($modifiedRoll > 847969 && $modifiedRoll <= 890145) { $modifiedBy = 5; }
			if ($modifiedRoll > 890145 && $modifiedRoll <= 910159) { $modifiedBy = 6; }
			if ($modifiedRoll > 910159 && $modifiedRoll <= 925000) { $modifiedBy = 7; }
			if ($modifiedRoll > 925000 && $modifiedRoll <= 938090) { $modifiedBy = 8; }
			if ($modifiedRoll > 938090 && $modifiedRoll <= 949390) { $modifiedBy = 9; }
			if ($modifiedRoll > 949390 && $modifiedRoll <= 962878) { $modifiedBy = 10; }
			if ($modifiedRoll > 962878 && $modifiedRoll <= 968448) { $modifiedBy = 11; }
			if ($modifiedRoll > 968448 && $modifiedRoll <= 973103) { $modifiedBy = 12; }
			if ($modifiedRoll > 973103 && $modifiedRoll <= 976565) { $modifiedBy = 13; }
			if ($modifiedRoll > 976565 && $modifiedRoll <= 980146) { $modifiedBy = 14; }
			if ($modifiedRoll > 980146 && $modifiedRoll <= 984682) { $modifiedBy = 15; }
			if ($modifiedRoll > 984682 && $modifiedRoll <= 987348) { $modifiedBy = 16; }
			if ($modifiedRoll > 987348 && $modifiedRoll <= 989855) { $modifiedBy = 17; }
			if ($modifiedRoll > 989855 && $modifiedRoll <= 992441) { $modifiedBy = 18; }
			if ($modifiedRoll > 992441 && $modifiedRoll <= 995465) { $modifiedBy = 19; }
			if ($modifiedRoll > 995465 && $modifiedRoll <= 1000000) { $modifiedBy = 20; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 971650) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 66252) { $modifiedBy = -5; }
			if ($modifiedRoll > 66252 && $modifiedRoll <= 164143) { $modifiedBy = -4; }
			if ($modifiedRoll > 164143 && $modifiedRoll <= 299351) { $modifiedBy = -3; }
			if ($modifiedRoll > 299351 && $modifiedRoll <= 525059) { $modifiedBy = -2; }
			if ($modifiedRoll > 525059 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd1CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd1Cards + $noOfAdd1CardsModifiedBy < 0) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - ($noOfAdd1Cards + $noOfAdd1CardsModifiedBy); }
	if ($build < 166 && $noOfAdd1Cards + $noOfAdd1CardsModifiedBy > 199) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - (($noOfAdd1Cards + $noOfAdd1CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd1Cards + $noOfAdd1CardsModifiedBy > 299) { $noOfAdd1CardsModifiedBy = $noOfAdd1CardsModifiedBy - (($noOfAdd1Cards + $noOfAdd1CardsModifiedBy) - 299); }
}

// YELLOW ADD 2 CARDS
if ($trustKeyholder == 0 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 50950) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 571734) { $modifiedBy = 1; }
			if ($modifiedRoll > 571734 && $modifiedRoll <= 809853) { $modifiedBy = 2; }
			if ($modifiedRoll > 809853 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 936100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 331163) { $modifiedBy = -2; }
			if ($modifiedRoll > 331163 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 101900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 531256) { $modifiedBy = 1; }
			if ($modifiedRoll > 531256 && $modifiedRoll <= 752516) { $modifiedBy = 2; }
			if ($modifiedRoll > 752516 && $modifiedRoll <= 929201) { $modifiedBy = 3; }
			if ($modifiedRoll > 929201 && $modifiedRoll <= 1000000) { $modifiedBy = 4; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 968050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 331163) { $modifiedBy = -2; }
			if ($modifiedRoll > 331163 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd2Cards + $noOfAdd2CardsModifiedBy < 0) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - ($noOfAdd2Cards + $noOfAdd2CardsModifiedBy); }
	if ($build < 166 && $noOfAdd2Cards + $noOfAdd2CardsModifiedBy > 199) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - (($noOfAdd2Cards + $noOfAdd2CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd2Cards + $noOfAdd2CardsModifiedBy > 299) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - (($noOfAdd2Cards + $noOfAdd2CardsModifiedBy) - 299); }
}
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 50950) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 486772) { $modifiedBy = 1; }
			if ($modifiedRoll > 486772 && $modifiedRoll <= 689505) { $modifiedBy = 2; }
			if ($modifiedRoll > 689505 && $modifiedRoll <= 851395) { $modifiedBy = 3; }
			if ($modifiedRoll > 851395 && $modifiedRoll <= 916265) { $modifiedBy = 4; }
			if ($modifiedRoll > 916265 && $modifiedRoll <= 960979) { $modifiedBy = 5; }
			if ($modifiedRoll > 960979 && $modifiedRoll <= 983981) { $modifiedBy = 6; }
			if ($modifiedRoll > 983981 && $modifiedRoll <= 1000000) { $modifiedBy = 7; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 936100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 99680) { $modifiedBy = -4; }
			if ($modifiedRoll > 99680 && $modifiedRoll <= 235791) { $modifiedBy = -3; }
			if ($modifiedRoll > 235791 && $modifiedRoll <= 488869) { $modifiedBy = -2; }
			if ($modifiedRoll > 488869 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 101900) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 460384) { $modifiedBy = 1; }
			if ($modifiedRoll > 460384 && $modifiedRoll <= 652127) { $modifiedBy = 2; }
			if ($modifiedRoll > 652127 && $modifiedRoll <= 805241) { $modifiedBy = 3; }
			if ($modifiedRoll > 805241 && $modifiedRoll <= 866594) { $modifiedBy = 4; }
			if ($modifiedRoll > 866594 && $modifiedRoll <= 908884) { $modifiedBy = 5; }
			if ($modifiedRoll > 908884 && $modifiedRoll <= 930640) { $modifiedBy = 6; }
			if ($modifiedRoll > 930640 && $modifiedRoll <= 945790) { $modifiedBy = 7; }
			if ($modifiedRoll > 945790 && $modifiedRoll <= 958535) { $modifiedBy = 8; }
			if ($modifiedRoll > 958535 && $modifiedRoll <= 968587) { $modifiedBy = 9; }
			if ($modifiedRoll > 968587 && $modifiedRoll <= 982337) { $modifiedBy = 10; }
			if ($modifiedRoll > 982337 && $modifiedRoll <= 986932) { $modifiedBy = 11; }
			if ($modifiedRoll > 986932 && $modifiedRoll <= 991599) { $modifiedBy = 12; }
			if ($modifiedRoll > 991599 && $modifiedRoll <= 995943) { $modifiedBy = 13; }
			if ($modifiedRoll > 995943 && $modifiedRoll <= 1000000) { $modifiedBy = 14; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 968050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 99680) { $modifiedBy = -4; }
			if ($modifiedRoll > 99680 && $modifiedRoll <= 235791) { $modifiedBy = -3; }
			if ($modifiedRoll > 235791 && $modifiedRoll <= 488869) { $modifiedBy = -2; }
			if ($modifiedRoll > 488869 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd2CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd2Cards + $noOfAdd2CardsModifiedBy < 0) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - ($noOfAdd2Cards + $noOfAdd2CardsModifiedBy); }
	if ($build < 166 && $noOfAdd2Cards + $noOfAdd2CardsModifiedBy > 199) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - (($noOfAdd2Cards + $noOfAdd2CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd2Cards + $noOfAdd2CardsModifiedBy > 299) { $noOfAdd2CardsModifiedBy = $noOfAdd2CardsModifiedBy - (($noOfAdd2Cards + $noOfAdd2CardsModifiedBy) - 299); }
}

// YELLOW ADD 3 CARDS
if ($trustKeyholder == 0 && $fixed == 0 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 57050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 554577) { $modifiedBy = 1; }
			if ($modifiedRoll > 554577 && $modifiedRoll <= 789294) { $modifiedBy = 2; }
			if ($modifiedRoll > 789294 && $modifiedRoll <= 1000000) { $modifiedBy = 3; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 936100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 333412) { $modifiedBy = -2; }
			if ($modifiedRoll > 333412 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 114100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 513018) { $modifiedBy = 1; }
			if ($modifiedRoll > 513018 && $modifiedRoll <= 730146) { $modifiedBy = 2; }
			if ($modifiedRoll > 730146 && $modifiedRoll <= 925063) { $modifiedBy = 3; }
			if ($modifiedRoll > 925063 && $modifiedRoll <= 1000000) { $modifiedBy = 4; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 968050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 333412) { $modifiedBy = -2; }
			if ($modifiedRoll > 333412 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd3Cards + $noOfAdd3CardsModifiedBy < 0) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - ($noOfAdd3Cards + $noOfAdd3CardsModifiedBy); }
	if ($build < 166 && $noOfAdd3Cards + $noOfAdd3CardsModifiedBy > 199) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - (($noOfAdd3Cards + $noOfAdd3CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd3Cards + $noOfAdd3CardsModifiedBy > 299) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - (($noOfAdd3Cards + $noOfAdd3CardsModifiedBy) - 299); }
}
if ($trustKeyholder == 1 && $fixed == 0 && $skipIfLines == 0) {
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 57050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 513018) { $modifiedBy = 1; }
			if ($modifiedRoll > 513018 && $modifiedRoll <= 730146) { $modifiedBy = 2; }
			if ($modifiedRoll > 730146 && $modifiedRoll <= 925063) { $modifiedBy = 3; }
			if ($modifiedRoll > 925063 && $modifiedRoll <= 1000001) { $modifiedBy = 4; }
			if ($modifiedRoll > 1000001 && $modifiedRoll <= 1000000) { $modifiedBy = 5; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 936100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 166419) { $modifiedBy = -3; }
			if ($modifiedRoll > 166419 && $modifiedRoll <= 444345) { $modifiedBy = -2; }
			if ($modifiedRoll > 444345 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 114100) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 438882) { $modifiedBy = 1; }
			if ($modifiedRoll > 438882 && $modifiedRoll <= 624633) { $modifiedBy = 2; }
			if ($modifiedRoll > 624633 && $modifiedRoll <= 791382) { $modifiedBy = 3; }
			if ($modifiedRoll > 791382 && $modifiedRoll <= 855491) { $modifiedBy = 4; }
			if ($modifiedRoll > 855491 && $modifiedRoll <= 907869) { $modifiedBy = 5; }
			if ($modifiedRoll > 907869 && $modifiedRoll <= 934074) { $modifiedBy = 6; }
			if ($modifiedRoll > 934074 && $modifiedRoll <= 952315) { $modifiedBy = 7; }
			if ($modifiedRoll > 952315 && $modifiedRoll <= 969664) { $modifiedBy = 8; }
			if ($modifiedRoll > 969664 && $modifiedRoll <= 981461) { $modifiedBy = 9; }
			if ($modifiedRoll > 981461 && $modifiedRoll <= 1000000) { $modifiedBy = 10; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		} elseif ($chanceRoll >= 968050) {
			$modifiedRoll = mt_rand(1, 1000000) + $botLoyaltyPoints;
			if ($modifiedRoll > 1000000) { $modifiedRoll = 1000000; }
			if ($modifiedRoll > 0 && $modifiedRoll <= 166419) { $modifiedBy = -3; }
			if ($modifiedRoll > 166419 && $modifiedRoll <= 444345) { $modifiedBy = -2; }
			if ($modifiedRoll > 444345 && $modifiedRoll <= 1000000) { $modifiedBy = -1; }
			$noOfAdd3CardsModifiedBy = $modifiedBy;
		}
	}
	if ($noOfAdd3Cards + $noOfAdd3CardsModifiedBy < 0) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - ($noOfAdd3Cards + $noOfAdd3CardsModifiedBy); }
	if ($build < 166 && $noOfAdd3Cards + $noOfAdd3CardsModifiedBy > 199) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - (($noOfAdd3Cards + $noOfAdd3CardsModifiedBy) - 199); }
	if ($build >= 166 && $noOfAdd3Cards + $noOfAdd3CardsModifiedBy > 299) { $noOfAdd3CardsModifiedBy = $noOfAdd3CardsModifiedBy - (($noOfAdd3Cards + $noOfAdd3CardsModifiedBy) - 299); }
}

// MINUTES
if ($trustKeyholder == 0 && $fixed == 1 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 160400) {
			$minutesModifiedBy = mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * (10 + ($timesLockedWithBot * 0.2))));
		} elseif ($chanceRoll >= 832100) {
			$minutesModifiedBy = -mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * 5));
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 320800) {
			$minutesModifiedBy = mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * (20 + ($timesLockedWithBot * 0.2))));
		} elseif ($chanceRoll >= 916050) {
			$minutesModifiedBy = -mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * 2.5));
		}
	}
	if ($minutes + $minutesModifiedBy < 0) { $minutesModifiedBy = $minutesModifiedBy - ($minutes + $minutesModifiedBy); }
	if ($minutes + $minutesModifiedBy > 576000) { $minutesModifiedBy = $minutesModifiedBy - (($minutes + $minutesModifiedBy) - 576000); }
}
if ($trustKeyholder == 1 && $fixed == 1 && $skipIfLines == 0) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 160400) {
			$minutesModifiedBy = mt_rand(ceil(($initialMinutes / 100) * 5), ceil(($initialMinutes / 100) * (30 + ($timesLockedWithBot * 0.2))));
		} elseif ($chanceRoll >= 832100) {
			$minutesModifiedBy = -mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * 5));
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 320800) {
			$minutesModifiedBy = mt_rand(ceil(($initialMinutes / 100) * 10), ceil(($initialMinutes / 100) * (60 + ($timesLockedWithBot * 0.2))));
		} elseif ($chanceRoll >= 916050) {
			$minutesModifiedBy = -mt_rand(ceil($initialMinutes / 100), ceil(($initialMinutes / 100) * 2.5));
		}
	}
	if ($minutes + $minutesModifiedBy < 0) { $minutesModifiedBy = $minutesModifiedBy - ($minutes + $minutesModifiedBy); }
	if ($minutes + $minutesModifiedBy > 576000) { $minutesModifiedBy = $minutesModifiedBy - (($minutes + $minutesModifiedBy) - 576000); }
}

?>