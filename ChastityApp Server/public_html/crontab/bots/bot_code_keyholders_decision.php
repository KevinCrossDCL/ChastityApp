<?php
// END OF LOCK DECISION
$chanceRoll = mt_rand(1, 1000000);
if ($chanceRoll <= 1072200) {
	$chanceRoll = mt_rand(1, 1000000);
	if ($botChosen == 1 || $botChosen == 2) {
		if ($chanceRoll <= 333600) {
			$resetLock = 1;
			if ($fixed == 0) { ResetVariableLock(); }
			if ($fixed == 1) { ResetFixedLock(); }
		} else {
			$unlockLock = 1;
			UnlockLock();
		}
	}
	if ($botChosen == 3 || $botChosen == 4) {
		if ($chanceRoll <= 667200) {
			$resetLock = 1;
			if ($fixed == 0) { ResetVariableLock(); }
			if ($fixed == 1) { ResetFixedLock(); }
		} else {
			$unlockLock = 1;
			UnlockLock();
		}
	}
}
?>
