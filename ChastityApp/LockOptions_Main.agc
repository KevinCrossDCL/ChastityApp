
if (screenToView = constLockOptionsScreen)
	// LOAD SCREEN IMAGES ONCE
	if (screenNo <> constLockOptionsScreen)
		if (imgBot01 = 0) then imgBot01 = LoadImage("Bot01.png")
		if (imgBot02 = 0) then imgBot02 = LoadImage("Bot02.png")
		if (imgBot03 = 0) then imgBot03 = LoadImage("Bot03.png")
		if (imgBot04 = 0) then imgBot04 = LoadImage("Bot04.png")
		maxDD as integer
		maxHH as integer
		maxMM as integer
		minDD as integer
		minHH as integer
		minMM as integer
		simulationRan as integer : simulationRan = 0
	endif
	screenNo = screenToView

	userText$ as string : userText$ = ""
	
	if (sharedLockToClone > 0)
		OryUISetButtonGroupItemSelectedByIndex(grpIsThisATestLock, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWouldYouLikeABotToKeyhold, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWhichBot, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouTrustTheKeyholder, 2)
		if (sharedLocks[sharedLockToClone, 0].fixed = 0) then OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 1)
		if (sharedLocks[sharedLockToClone, 0].fixed = 1) then OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 2)
		if (sharedLocks[sharedLockToClone, 0].fixed = 0)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 24) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 12) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 2)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 6) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 3)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 3) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 4)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 1) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 5)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.5) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 6)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.25) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 7)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.016667) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 8)
		endif
		if (sharedLocks[sharedLockToClone, 0].fixed = 1)
			if (sharedLocks[sharedLockToClone, 0].regularity# <> 0.016667)
				OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 8)
			endif
		endif
		if (sharedLocks[sharedLockToClone, 0].cumulative = 0) then OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 2)
		if (sharedLocks[sharedLockToClone, 0].cumulative = 1) then OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)
		if (sharedLocks[sharedLockToClone, 0].maxRandomReds > 0)
			if (sharedLocks[sharedLockToClone, 0].fixed = 0)
				OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomReds))
				OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomReds))
			endif
			if (sharedLocks[sharedLockToClone, 0].fixed = 1)
				minDD = floor((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)) / 60 / 24)
				minHH = floor(mod((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)) / 60, 24))
				minMM = floor(mod((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)), 60))
				maxDD = floor((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)) / 60 / 24)
				maxHH = floor(mod((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)) / 60, 24))
				maxMM = floor(mod((sharedLocks[sharedLockToClone, 0].minRandomReds * (sharedLocks[sharedLockToClone, 0].regularity# * 60)), 60))						
				OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:" + str(minDD))
				OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:" + str(minHH))
				OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:" + str(minMM))
				OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:" + str(maxDD))
				OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:" + str(maxHH))
				OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:" + str(maxMM))
			endif
		else
			if (sharedLocks[sharedLockToClone, 0].fixed = 0)
				OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:0")
				OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:0")
			endif
			if (sharedLocks[sharedLockToClone, 0].fixed = 1)
				OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0")
				OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:0")
				OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0")
				OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0")
				OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:0")
				OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0")
			endif
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomMinutes > 0)
			minDD = floor(sharedLocks[sharedLockToClone, 0].minRandomMinutes / 60 / 24)
			minHH = floor(mod(sharedLocks[sharedLockToClone, 0].minRandomMinutes / 60, 24))
			minMM = floor(mod(sharedLocks[sharedLockToClone, 0].minRandomMinutes, 60))
			maxDD = floor(sharedLocks[sharedLockToClone, 0].maxRandomMinutes / 60 / 24)
			maxHH = floor(mod(sharedLocks[sharedLockToClone, 0].maxRandomMinutes / 60, 24))
			maxMM = floor(mod(sharedLocks[sharedLockToClone, 0].maxRandomMinutes, 60))						
			OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:" + str(minDD))
			OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:" + str(minHH))
			OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:" + str(minMM))
			OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:" + str(maxDD))
			OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:" + str(maxHH))
			OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:" + str(maxMM))
		else
			OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0")
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomYellows > 0 or sharedLocks[sharedLockToClone, 0].maxRandomYellowsAdd > 0 or sharedLocks[sharedLockToClone, 0].maxRandomYellowsMinus > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomYellows))
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomYellows))
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomYellowsMinus))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomYellowsMinus))
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomYellowsAdd))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomYellowsAdd))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:0")
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomStickies > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomStickies))
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomStickies))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:0")
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomFreezes > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomFreezes))
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomFreezes))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:0")
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomDoubleUps > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomDoubleUps))
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomDoubleUps))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:0")
		endif
		if (sharedLocks[sharedLockToClone, 0].maxRandomResets > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomResets))
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomResets))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:0")
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomGreens))
		OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomGreens))
		if (sharedLocks[sharedLockToClone, 0].multipleGreensRequired = 0) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)
		if (sharedLocks[sharedLockToClone, 0].multipleGreensRequired = 1) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 1)
		if (sharedLocks[sharedLockToClone, 0].cardInfoHidden = 0) then OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 2)
		if (sharedLocks[sharedLockToClone, 0].cardInfoHidden = 1) then OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 1)
		if (sharedLocks[sharedLockToClone, 0].timerHidden = 0) then OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)
		if (sharedLocks[sharedLockToClone, 0].timerHidden = 1) then OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 1)
		if (sharedLocks[sharedLockToClone, 0].maxRandomCopies > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRandomCopies))
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxRandomCopies))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:1")
		endif
		if (sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 1)
			if (sharedLocks[sharedLockToClone, 0].regularity# = 24) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 86400))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 12) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 43200))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 6) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 21600))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 3) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 10800))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 1) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 3600))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.5) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 1800))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.25) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 900))
			if (sharedLocks[sharedLockToClone, 0].regularity# = 0.016667) then OryUIUpdateInputSpinner(spinResetFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].resetFrequencyInSeconds / 60))
			OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxAutoResets))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 2)
			OryUIUpdateInputSpinner(spinResetFrequency, "inputText:1")
			OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "inputText:1")
		endif
		if (sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 1)
			if (sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds <= 2700)
				OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:" + str(sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds / 900))
			elseif (sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds <= 89100)
				OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:" + str(((sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds - 2700) / 3600) + 4))
			else
				OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:" + str(((sharedLocks[sharedLockToClone, 0].checkInFrequencyInSeconds - 89100) / 86400) + 29))
			endif
			if (sharedLocks[sharedLockToClone, 0].lateCheckInWindowInSeconds <= 2700)
				OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:" + str(sharedLocks[sharedLockToClone, 0].lateCheckInWindowInSeconds / 900))
			elseif (sharedLocks[sharedLockToClone, 0].lateCheckInWindowInSeconds <= 89100)
				OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:" + str(((sharedLocks[sharedLockToClone, 0].lateCheckInWindowInSeconds - 2700) / 3600) + 4))
			else
				OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:" + str(((sharedLocks[sharedLockToClone, 0].lateCheckInWindowInSeconds - 89100) / 86400) + 29))
			endif
		else
			OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 2)
			OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:4")
			OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:1")
		endif
		if (sharedLocks[sharedLockToClone, 0].keyDisabled = 0) then OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 1)
		if (sharedLocks[sharedLockToClone, 0].keyDisabled = 1) then OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 2)
		OryUIUpdateInputSpinner(spinNumberOfKeysRequired, "inputText:1")
		if (sharedLocks[sharedLockToClone, 0].startLockFrozen = 0) then OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 2)
		if (sharedLocks[sharedLockToClone, 0].startLockFrozen = 1) then OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 1)
		if (sharedLocks[sharedLockToClone, 0].keyholderDecisionDisabled = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 2)
		if (sharedLocks[sharedLockToClone, 0].keyholderDecisionDisabled = 1) then OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 1)
		if (sharedLocks[sharedLockToClone, 0].maxUsers > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 1)
			OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "inputText:" + str(sharedLocks[sharedLockToClone, 0].maxUsers))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 2)
			OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "inputText:40")
		endif
		if (sharedLocks[sharedLockToClone, 0].blockTestLocks = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockTestLocks, 2)
		if (sharedLocks[sharedLockToClone, 0].blockTestLocks = 1) then OryUISetButtonGroupItemSelectedByIndex(grpBlockTestLocks, 1)
		if (sharedLocks[sharedLockToClone, 0].minRatingRequired > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 1)
			OryUIUpdateInputSpinner(spinMinimumRatingRequired, "inputText:" + str(sharedLocks[sharedLockToClone, 0].minRatingRequired))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 2)
			OryUIUpdateInputSpinner(spinMinimumRatingRequired, "inputText:1")
		endif
		if (sharedLocks[sharedLockToClone, 0].blockUsersAlreadyLocked = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 2)
		if (sharedLocks[sharedLockToClone, 0].blockUsersAlreadyLocked = 1) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 1)
		if (sharedLocks[sharedLockToClone, 0].blockUsersWithStatsHidden = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 2)
		if (sharedLocks[sharedLockToClone, 0].blockUsersWithStatsHidden = 1) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 1)
		if (sharedLocks[sharedLockToClone, 0].forceTrust = 0) then OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 2)
		if (sharedLocks[sharedLockToClone, 0].forceTrust = 1) then OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 1)
		if (sharedLocks[sharedLockToClone, 0].requireDM = 0) then OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 2)
		if (sharedLocks[sharedLockToClone, 0].requireDM = 1) then OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)
		showFakeCombinationOptions = 0
		sharedLockToClone = 0
	elseif (generatedLockSelected > 0)
		OryUISetButtonGroupItemSelectedByIndex(grpIsThisATestLock, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWouldYouLikeABotToKeyhold, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWhichBot, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouTrustTheKeyholder, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 1)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 24) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 12) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 2)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 6) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 3)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 3) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 4)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 1) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 5)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 0.5) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 6)
		if (generatedLocks[generatedLockSelected - 1].regularity# = 0.25) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 7)
		OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)
		OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomReds))
		OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomReds))
		OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0")
		OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:1")
		OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0")
		if (generatedLocks[generatedLockSelected - 1].maxRandomYellows > 0 or generatedLocks[generatedLockSelected - 1].maxRandomYellowsAdd > 0 or generatedLocks[generatedLockSelected - 1].maxRandomYellowsMinus > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomYellows))
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomYellows))
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomYellowsMinus))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomYellowsMinus))
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomYellowsAdd))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomYellowsAdd))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:0")
		endif
		if (generatedLocks[generatedLockSelected - 1].maxRandomStickies > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomStickies))
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomStickies))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:0")
		endif
		if (generatedLocks[generatedLockSelected - 1].maxRandomFreezes > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomFreezes))
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomFreezes))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:0")
		endif
		if (generatedLocks[generatedLockSelected - 1].maxRandomDoubleUps > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomDoubleUps))
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomDoubleUps))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:0")
		endif
		if (generatedLocks[generatedLockSelected - 1].maxRandomResets > 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 1)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomResets))
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomResets))
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:0")
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].minRandomGreens))
		OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "inputText:" + str(generatedLocks[generatedLockSelected - 1].maxRandomGreens))
		if (generatedLocks[generatedLockSelected - 1].multipleGreensRequired = 0) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)
		if (generatedLocks[generatedLockSelected - 1].multipleGreensRequired = 1) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 2)
		OryUIUpdateInputSpinner(spinResetFrequency, "inputText:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 2)
		OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:4")
		OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 1)
		OryUIUpdateInputSpinner(spinNumberOfKeysRequired, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 2)
		OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "inputText:40")
		OryUISetButtonGroupItemSelectedByIndex(grpBlockTestLocks, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 2)
		OryUIUpdateInputSpinner(spinMinimumRatingRequired, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)
		showFakeCombinationOptions = 0
		generatedLockSelected = 0
	elseif (resetOptions = 1)
		OryUISetButtonGroupItemSelectedByIndex(grpIsThisATestLock, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWouldYouLikeABotToKeyhold, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpWhichBot, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouTrustTheKeyholder, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)
		OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)
		OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:1")
		OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0")
		OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:1")
		OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0")
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:0")
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:0")
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:0")
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:0")
		OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:0")
		OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "inputText:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)
		OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:0")
		OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 2)
		OryUIUpdateInputSpinner(spinResetFrequency, "inputText:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 2)
		OryUIUpdateInputSpinner(spinCheckInFrequency, "inputText:4")
		OryUIUpdateInputSpinner(spinLateCheckIns, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 1)
		OryUIUpdateInputSpinner(spinNumberOfKeysRequired, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 2)
		OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "inputText:40")
		OryUISetButtonGroupItemSelectedByIndex(grpBlockTestLocks, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 2)
		OryUIUpdateInputSpinner(spinMinimumRatingRequired, "inputText:1")
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)
		showFakeCombinationOptions = 0
		resetOptions = 0
	endif
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// JUMP TO LAST VIEW OFFSET Y WHEN RETURNING TO THIS SCREEN
	if (screen[screenNo].lastViewY# > screenBoundsTop#)
		SetViewOffset(GetViewOffsetX(), screen[screenNo].lastViewY#)
		screen[screenNo].lastViewY# = screenBoundsTop#
	endif
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)	
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		loadingSharedLock = 0
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, selectedLockOptionsTab)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = ""
		sharedLockInfo$ = ""
		selectedLockOptionsTab = 1
		SetScreenToView(constLockOptionsScreen)
	endif
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = ""
		sharedLockInfo$ = ""
		selectedLockOptionsTab = 2
		SetScreenToView(constLockOptionsScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs) + 2

	startScrollBarY# = elementY# - 1
	
	if (selectedLockOptionsTab = 1) then loadingSharedLock = 0
	if (selectedLockOptionsTab = 2) 
		loadingSharedLock = 1
		creatingSharedLock = 0
	endif
	
	// LOCK TEMPLATES
	if (loadingSharedLock = 0)
		elementY# = elementY# - 2
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLockTemplates, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";headerText:;supportingText:Need help or inspiration with creating a lock?" + chr(10) + chr(10) + "If so, check out the " + constAppName$ + " Lock Templates.;supportingTextAlignment:center;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLockTemplates)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnLockTemplates, "text:View Lock Templates;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";textColor:41,128,185,255;textSize:2.5")
		endif
		if (OryUIGetButtonReleased(btnLockTemplates))
			SetScreenToView(constLockGeneratorScreen)
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(btnLockTemplates)
	else
		OryUIUpdateTextCard(crdLockTemplates, "position:-1000,-1000")
		OryUIUpdateButton(btnLockTemplates, "position:-1000,-1000")
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// LOAD LOCK?
	if (loadingSharedLock = 1 and sharedID$ = "")
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLoadLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLoadLock)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpLoadLock, "position:" + str((screenNo * 100) + 27.5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].pageColor) + ";selectedIconColorID:" + str(colorMode[colorModeSelected].textColor) + ";selectedTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].pageColor) + ";unselectedIconColorID:" + str(colorMode[colorModeSelected].textColor) + ";unselectedTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIInsertButtonGroupListener(grpLoadLock)
		if (OryUIGetButtonGroupItemReleasedByName(grpLoadLock, "Load"))
			sharedID$ = ""
			sharedLockName$ = ""
			sharedLockError$ = ""
			sharedLockInfo$ = ""
			if (left(username$, 3) = "CKU")
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can load shared locks you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				if (CheckPermission("WriteExternal") <= 0 and GetDeviceBaseName() = "android")
					RequestPermission("WriteExternal")
					while(CheckPermission("WriteExternal") = 1)
						Sync()
					endwhile
				endif
				if (CheckPermission("WriteExternal") >= 1 or GetDeviceBaseName() = "ios")
					ShowChooseImageScreen()
					repeat
						if (GetRawKeyPressed(27))
							exit
						endif
						Sync()
					until (IsChoosingImage() = 0)
					encodedQRFile as integer : encodedQRFile = GetChosenImage()
					sharedID$ = DecodeQRCode(encodedQRFile)
					if (left(sharedID$, len(constAppName$) + 16) <> constAppName$ + "-Shareable-Lock-" or len(sharedID$) <> 31 + len(constAppName$))
						sharedID$ = ""
						sharedLockName$ = ""
						sharedLockError$ = "Not a valid " + constAppName$ + " QR code. Please try again."
					else
						sharedID$ = mid(sharedID$, len(constAppName$) + 17, 15)
						GetSharedLockInformation(sharedID$, 1)
						SetScreenToView(screenNo)
					endif
					DeleteImage(encodedQRFile)
				else
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Storage Permissions;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + constAppName$ + " does not have access to your gallery. You can grant permission in your device app settings.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 1)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
			endif
		elseif (OryUIGetButtonGroupItemReleasedByName(grpLoadLock, "Scan"))
			sharedID$ = ""
			sharedLockName$ = ""
			sharedLockError$ = ""
			sharedLockInfo$ = ""
			if (left(username$, 3) = "CKU")
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can load shared locks you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				if (GetNumDeviceCameras() > 0)
					if (CheckPermission("Camera") <= 0 and GetDeviceBaseName() = "android")
						RequestPermission("Camera")
						while(CheckPermission("Camera") = 1)
							Sync()
						endwhile
					endif
					if (CheckPermission("Camera") >= 1 or GetDeviceBaseName() = "ios")
						SetScreenToView(constScanQRCodeScreen)
					else
						OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Camera Permissions;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + constAppName$ + " does not have access to your camera. You can grant permission in your device app settings.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
						OryUISetDialogButtonCount(dialog, 1)
						OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
						OryUIShowDialog(dialog)
					endif
				else
					sharedLockError$ = "Couldn't find the camera."
				endif
			endif
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpLoadLock) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLoadLock, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpLoadLock, "position:-1000,-1000")
		endif
	endif

	// DISPLAY SHARED LOCK ERROR
	if (sharedLockError$ <> "")
		OryUIUpdateText(txtSharedLockError, "text:" + OryUIWrapText(sharedLockError$, 2.6, 84) + ";color:235,77,75,255;position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
		elementY# = elementY# + GetTextTotalHeight(txtSharedLockError) + 1
	else
		OryUIUpdateText(txtSharedLockError, "position:-1000,-1000")
	endif

	// DISPLAY SHARED LOCK INFORMATION
	if (sharedLockInfo$ <> "")
		OryUIUpdateText(txtSharedLockInformation, "text:" + sharedLockInfo$ + ";color:106,176,76,255;position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
		
		if (startLockSettingsManagedByBlackFont <> endLockSettingsManagedByBlackFont)
			for i = startLockSettingsManagedByBlackFont to endLockSettingsManagedByBlackFont - 1
				SetTextCharColor(txtSharedLockInformation, i, GetColorRed(colorMode[colorModeSelected].textColor), GetColorGreen(colorMode[colorModeSelected].textColor), GetColorBlue(colorMode[colorModeSelected].textColor), 255)
			next
		endif
		if (startLockSettingsManagedByRedFont <> endLockSettingsManagedByRedFont)
			for i = startLockSettingsManagedByRedFont to endLockSettingsManagedByRedFont - 1
				SetTextCharColor(txtSharedLockInformation, i, 255, 0, 0, 255)
			next
		endif
		
		if (startLockSettingsTestLockRedFont <> endLockSettingsTestLockRedFont)
			for i = startLockSettingsTestLockRedFont to endLockSettingsTestLockRedFont - 1
				SetTextCharColor(txtSharedLockInformation, i, 255, 0, 0, 255)
			next
		endif
		
		if (startLockSettingsRedFont <> endLockSettingsRedFont)
			for i = startLockSettingsRedFont to endLockSettingsRedFont - 1
				SetTextCharColor(txtSharedLockInformation, i, 255, 0, 0, 255)
			next
		endif
		textLockTextPosition as integer : textLockTextPosition = FindString(GetTextString(txtSharedLockInformation), "(TEST LOCK)")
		if (textLockTextPosition > 0)
			for i = textLockTextPosition - 1 to textLockTextPosition + 10
				SetTextCharColor(txtSharedLockInformation, i, 255, 0, 0, 255)
			next
		endif
		elementY# = elementY# + GetTextTotalHeight(txtSharedLockInformation) + 1
	else
		OryUIUpdateText(txtSharedLockInformation, "position:-1000,-1000")
	endif

	// WHO IS THE LOCK FOR?
	if (loadingSharedLock = 0)
		if (noOfLocks < 20)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdWhoIsTheLockFor, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUISetButtonGroupItemCount(grpWhoIsTheLockFor, 2)
				OryUIUpdateButtonGroupItem(grpWhoIsTheLockFor, 1, "name:Myself;text:Myself")
				OryUIUpdateButtonGroupItem(grpWhoIsTheLockFor, 2, "name:Others;text:Others")
				if (OryUIGetButtonGroupItemSelectedName(grpWhoIsTheLockFor) = "Myself")
					creatingSharedLock = 0
					userText$ = "You"
					OryUIUpdateTextCard(crdWhoIsTheLockFor, "supportingText:A lock that runs on your device for you to use will be created. It can run with or without a keyholder.")
				endif
				if (OryUIGetButtonGroupItemSelectedName(grpWhoIsTheLockFor) = "Others")
					creatingSharedLock = 1
					userText$ = "They"
					OryUIUpdateTextCard(crdWhoIsTheLockFor, "supportingText:A lock that runs on other peoples devices that you control.")
				endif
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdWhoIsTheLockFor)
			if (redrawScreen = 1)
				OryUIUpdateButtonGroup(grpWhoIsTheLockFor, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			endif
			OryUIInsertButtonGroupListener(grpWhoIsTheLockFor)
			if (OryUIGetButtonGroupItemReleasedIndex(grpWhoIsTheLockFor) > 0)
				screen[screenNo].lastViewY# = GetViewOffsetY()
				SetScreenToView(constLockOptionsScreen)
			endif
			elementY# = elementY# + OryUIGetButtonGroupHeight(grpWhoIsTheLockFor) + 2
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdWhoIsTheLockFor, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUISetButtonGroupItemCount(grpWhoIsTheLockFor, 1)
				OryUIUpdateButtonGroupItem(grpWhoIsTheLockFor, 1, "name:Others;text:Others")
				OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)
				OryUIUpdateTextCard(crdWhoIsTheLockFor, "supportingText:Because you have the maximum number of locks allowed for yourself you can now only create locks that run on other people's devices that you control.")
				creatingSharedLock = 1
				userText$ = "They"
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdWhoIsTheLockFor)
			if (redrawScreen = 1)
				OryUIUpdateButtonGroup(grpWhoIsTheLockFor, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			endif
			OryUIInsertButtonGroupListener(grpWhoIsTheLockFor)
			if (OryUIGetButtonGroupItemReleasedIndex(grpWhoIsTheLockFor) > 0) 
				screen[screenNo].lastViewY# = GetViewOffsetY()
				SetScreenToView(constLockOptionsScreen)
			endif
			elementY# = elementY# + OryUIGetButtonGroupHeight(grpWhoIsTheLockFor) + 2
		endif
		if (creatingSharedLock = 1 and left(username$, 3) = "CKU")
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can create shared locks that you control as a keyholder, you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	else
		if (redrawScreen = 1)
			userText$ = "You"
			OryUIUpdateTextCard(crdWhoIsTheLockFor, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpWhoIsTheLockFor, "position:-1000,-1000")
		endif
	endif

	// IS THIS A TEST LOCK?
	if ((loadingSharedLock = 0 and creatingSharedLock = 0) or (loadingSharedLock = 1 and sharedID$ <> "" and blockTestLocks = 0 and ((fixed = 0 and regularity# >= 0.25) or fixed = 1)))
		if (redrawScreen = 1)
			if (loadingSharedLock = 0)
				OryUIUpdateTextCard(crdIsThisATestLock, "supportingText:Test locks will run like real locks but won't be included in your lock history and stats.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			if (loadingSharedLock = 1)
				OryUIUpdateTextCard(crdIsThisATestLock, "supportingText:Test locks will run like real locks but won't be included in your lock history and stats. Keyholders will also see that you've loaded it as a test lock.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpIsThisATestLock) = "Yes")
				testLock = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpIsThisATestLock) = "No")
				testLock = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdIsThisATestLock)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpIsThisATestLock, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpIsThisATestLock)
		if (OryUIGetButtonGroupItemReleasedIndex(grpIsThisATestLock) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpIsThisATestLock) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 1 and sharedID$ <> "" and fixed = 0 and regularity# = 0.016667)
				testLock = 1
			else
				testLock = 0
			endif
			OryUIUpdateTextCard(crdIsThisATestLock, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpIsThisATestLock, "position:-1000,-1000")
		endif
	endif

	// WOULD YOU LIKE A BOT TO KEYHOLD?
	if (loadingSharedLock = 0 and creatingSharedLock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpWouldYouLikeABotToKeyhold) = "Yes")
				botControlled = 1
				OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "supportingText:A bot will choose some of the settings and control the lock.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWouldYouLikeABotToKeyhold) = "No")
				botControlled = 0
				OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "supportingText:This lock will run privately without a bot keyholder.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdWouldYouLikeABotToKeyhold)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpWouldYouLikeABotToKeyhold, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpWouldYouLikeABotToKeyhold)
		if (OryUIGetButtonGroupItemReleasedIndex(grpWouldYouLikeABotToKeyhold) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpWouldYouLikeABotToKeyhold) + 2
	else
		if (redrawScreen = 1)
			botControlled = 0
			OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpWouldYouLikeABotToKeyhold, "position:-1000,-1000")
		endif
	endif
	
	// WHICH BOT?
	if (botControlled = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdWhichBot, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			botKindness$ as string : botKindness$ = ""
			botName$ as string : botName$ = ""
			botRatings$ as string : botRatings$ = ""
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Hailey")
				botChosen = 1
				botKindness$ = "Kind Bot"
				botName$ = "Hailey"
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Blaine")
				botChosen = 2
				botKindness$ = "Kind Bot"
				botName$ = "Blaine"
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Zoe")
				botChosen = 3
				botKindness$ = "Mean Bot"
				botName$ = "Zoe"
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Chase")
				botChosen = 4
				botKindness$ = "Mean Bot"
				botName$ = "Chase"
			endif
			botPhrase$ as string : botPhrase$ = botsData[botChosen].phrase$
			if (botsData[botChosen].noOfRatings	>= 5)
				botRatings$ = ReplaceString(str(botsData[botChosen].rating#, 1), ".0", "", -1) + " out of 5 stars (" + str(botsData[botChosen].noOfRatings) + " Ratings)"
			else
				if (botsData[botChosen].noOfRatings = 0)
					botRatings$ = "No ratings yet"
				elseif (botsData[botChosen].noOfRatings = 1)
					botRatings$ = "Not enough ratings (1 Rating)"
				else
					botRatings$ = "Not enough ratings (" + str(botsData[botChosen].noOfRatings) + " Ratings)"
				endif
			endif
			OryUIUpdateTextCard(crdWhichBot, "supportingText:" + botName$ + "[colon] '" + botPhrase$ + "'" + chr(10) + botKindness$ + " | Users Locked[colon] " + str(botsData[botChosen].lockedCount) + chr(10) + botRatings$ + ";supportingTextAlignment:center;")
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdWhichBot)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpWhichBot, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateButtonGroupItem(grpWhichBot, 1, "iconID:" + str(imgBot01))
			OryUIUpdateButtonGroupItem(grpWhichBot, 2, "iconID:" + str(imgBot02))
			OryUIUpdateButtonGroupItem(grpWhichBot, 3, "iconID:" + str(imgBot03))
			OryUIUpdateButtonGroupItem(grpWhichBot, 4, "iconID:" + str(imgBot04))
		endif
		OryUIInsertButtonGroupListener(grpWhichBot)
		if (OryUIGetButtonGroupItemReleasedIndex(grpWhichBot) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpWhichBot) + 2
	else
		if (redrawScreen = 1)
			botChosen = 0
			botName$ = ""
			OryUIUpdateTextCard(crdWhichBot, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpWhichBot, "position:-1000,-1000")
		endif
	endif

	// DO YOU TRUST THE KEYHOLDER?
	if (botControlled = 1 or (loadingSharedLock = 1 and sharedID$ <> "" and forceTrust = 0 and hiddenFromOwner = 0 and keyholderUsername$ <> username$))
		if (redrawScreen = 1)
			if (botChosen = 1) then keyholderUsername$ = "Hailey"
			if (botChosen = 2) then keyholderUsername$ = "Blaine"
			if (botChosen = 3) then keyholderUsername$ = "Zoe"
			if (botChosen = 4) then keyholderUsername$ = "Chase"
			OryUIUpdateTextCard(crdDoYouTrustTheKeyholder, "headerText:Do you trust " + keyholderUsername$ + "?;supportingText:Trusting them will remove all limitations from them as your keyholder which means that they can add/remove as much time as they want, and as often as they want. It also means that the lock can run for a lot longer than you expected. If this is your first session with this keyholder then it's recommended that you choose 'No'.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouTrustTheKeyholder) = "Yes")
				trustKeyholder = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouTrustTheKeyholder) = "No")
				trustKeyholder = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouTrustTheKeyholder)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouTrustTheKeyholder, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpDoYouTrustTheKeyholder)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouTrustTheKeyholder) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouTrustTheKeyholder) + 2
	else
		if (redrawScreen = 1)
			trustKeyholder = 0
			if (loadingSharedLock = 1 and forceTrust = 1) then trustKeyholder = 1
			OryUIUpdateTextCard(crdDoYouTrustTheKeyholder, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouTrustTheKeyholder, "position:-1000,-1000")
		endif
	endif

	// TYPE OF LOCK?
	if (loadingSharedLock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdTypeOfLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpTypeOfLock) = "VariableLock")
				fixed = 0
				OryUIUpdateTextCard(crdTypeOfLock, "supportingText:" + userText$ + " will have a chance at regular intervals to unlock. Variable locks use a card system.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpTypeOfLock) = "FixedLock")
				fixed = 1
				OryUIUpdateTextCard(crdTypeOfLock, "supportingText:Fixed locks run for a fixed duration.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdTypeOfLock)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpTypeOfLock, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpTypeOfLock)
		if (OryUIGetButtonGroupItemReleasedIndex(grpTypeOfLock) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpTypeOfLock) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdTypeOfLock, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpTypeOfLock, "position:-1000,-1000")
		endif
	endif
	
	// REGULARITY?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdRegularity, "headerText:Chance regularity?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if ((testLock = 1 or creatingSharedLock = 1) and botChosen = 0)
				OryUISetButtonGroupItemCount(grpRegularity, 8)
			else
				OryUISetButtonGroupItemCount(grpRegularity, 7)
			endif
			OryUIUpdateButtonGroupItem(grpRegularity, 1, "name:24H;text:24H")
			OryUIUpdateButtonGroupItem(grpRegularity, 2, "name:12H;text:12H")
			OryUIUpdateButtonGroupItem(grpRegularity, 3, "name:6H;text:6H")
			OryUIUpdateButtonGroupItem(grpRegularity, 4, "name:3H;text:3H")
			OryUIUpdateButtonGroupItem(grpRegularity, 5, "name:1H;text:1H")
			OryUIUpdateButtonGroupItem(grpRegularity, 6, "name:30M;text:30M")
			OryUIUpdateButtonGroupItem(grpRegularity, 7, "name:15M;text:15M")
			if ((testLock = 1 or creatingSharedLock = 1) and botChosen = 0)
				OryUIUpdateButtonGroupItem(grpRegularity, 8, "name:1M;text:1M")
			else
				if (OryUIGetButtonGroupItemSelectedIndex(grpRegularity) = 8) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpRegularity) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "24H")
				regularity# = 24
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 24 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "12H")
				regularity# = 12
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 12 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "6H")
				regularity# = 6
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 6 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "3H")
				regularity# = 3
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 3 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "1H")
				regularity# = 1
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every hour to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "30M")
				regularity# = 0.5
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 30 minutes to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "15M")
				regularity# = 0.25
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every 15 minutes to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRegularity) = "1M")
				regularity# = 0.016667
				testLock = 1
				OryUIUpdateTextCard(crdRegularity, "supportingText:" + userText$ + " will be given a chance every minute to unlock early.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdRegularity)
		if (creatingSharedLock = 1 and fixed = 0 and OryUIGetButtonGroupItemSelectedName(grpRegularity) = "1M")
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdTestRegularity, "headerText:;supportingText:One minute draw intervals are for testing purposes only. Locks completed with it will not be included in yours or other users lock history and stats.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColor:192,57,43,255")
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdTestRegularity)
		else
			OryUIUpdateTextCard(crdTestRegularity, "position:-1000,-1000")
		endif
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpRegularity, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpRegularity)
		if (OryUIGetButtonGroupItemReleasedIndex(grpRegularity) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpRegularity) + 2
	else
		if (loadingSharedLock = 0 and fixed = 1) then regularity# = 0.016667
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdRegularity, "position:-1000,-1000")
			OryUIUpdateTextCard(crdTestRegularity, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpRegularity, "position:-1000,-1000")
		endif
	endif

	// CUMULATIVE CHANCES
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCumulativeChances, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpCumulativeChances) = "Yes")
				cumulative = 1
				if (regularity# = 24) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X days. For example if " + lower(userText$) + " were away for 3 days " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 12) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 12 hours. For example if " + lower(userText$) + " were away for 36 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 6) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 6 hours. For example if " + lower(userText$) + " were away for 18 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 3) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 3 hours. For example if " + lower(userText$) + " were away for 9 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 1) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X hours. For example if " + lower(userText$) + " were away for 3 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 0.5) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 30 minutes. For example if " + lower(userText$) + " were away for 90 minutes " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 0.25) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 15 minutes. For example if " + lower(userText$) + " were away for 45 minutes " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 0.016667) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X minutes. For example if " + lower(userText$) + " were away for 3 minutes " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCumulativeChances) = "No")
				cumulative = 0
				if (regularity# = 24) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X days. For example if " + lower(userText$) + " were away for 3 days " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 12) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 12 hours. For example if " + lower(userText$) + " were away for 36 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 6) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 6 hours. For example if " + lower(userText$) + " were away for 18 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 3) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 3 hours. For example if " + lower(userText$) + " were away for 9 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 1) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X hours. For example if " + lower(userText$) + " were away for 3 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 0.5) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 30 minutes. For example if " + lower(userText$) + " were away for 90 minutes " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 0.25) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 15 minutes. For example if " + lower(userText$) + " were away for 45 minutes " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 0.016667) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for 1 minute. For example if " + lower(userText$) + " were away for 3 minutes " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCumulativeChances) = "BotDecides")
				cumulative = 3
				OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + botName$ + " will decide if it's cumulative or not.")
			endif	
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCumulativeChances)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpCumulativeChances, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpCumulativeChances, 2)
				OryUIUpdateButtonGroupItem(grpCumulativeChances, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCumulativeChances, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpCumulativeChances, 3)
				OryUIUpdateButtonGroupItem(grpCumulativeChances, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCumulativeChances, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpCumulativeChances, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpCumulativeChances) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpCumulativeChances) > OryUIGetButtonGroupItemCount(grpCumulativeChances)) then OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)
		endif
		OryUIInsertButtonGroupListener(grpCumulativeChances)
		if (OryUIGetButtonGroupItemReleasedIndex(grpCumulativeChances) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpCumulativeChances) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then cumulative = 0
			OryUIUpdateTextCard(crdCumulativeChances, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpCumulativeChances, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF DIGITS/CHARACTERS IN COMBINATION
	local maxDigits = 12
	if (allowDuplicatesInCombination = 2 and combinationType = 1) then maxDigits = 10
	if ((loadingSharedLock = 0 and creatingSharedLock = 0) or (loadingSharedLock = 1 and sharedID$ <> ""))
		if (combinationType = 1)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdNumberOfDigitsInCombination, "headerText:Number of digits in combination?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDigitsInCombination)
			if (redrawScreen = 1)
				OryUIUpdateInputSpinner(spinNumberOfDigitsInCombination, "defaultValue:" + str(noOfDigits) + ";max:" + str(maxDigits) + ";position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetInputSpinnerHeight(spinNumberOfDigitsInCombination) + 2
		elseif (combinationType = 2 or combinationType = 3)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdNumberOfDigitsInCombination, "headerText:Number of characters in combination?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDigitsInCombination)
			if (redrawScreen = 1)
				OryUIUpdateInputSpinner(spinNumberOfDigitsInCombination, "defaultValue:" + str(noOfDigits) + ";max:" + str(maxDigits) + ";position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetInputSpinnerHeight(spinNumberOfDigitsInCombination) + 2
		endif
		OryUIInsertInputSpinnerListener(spinNumberOfDigitsInCombination)
		if (OryUIGetInputSpinnerHasFocus(spinNumberOfDigitsInCombination))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfDigitsInCombination) - GetSpriteY(screen[screenNo].sprPage))
		endif
		noOfDigits = val(OryUIGetInputSpinnerString(spinNumberOfDigitsInCombination))
		if (OryUIGetInputSpinnerChangedValue(spinNumberOfDigitsInCombination))
			SaveLocalVariable("noOfDigits", str(noOfDigits))
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdNumberOfDigitsInCombination, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinNumberOfDigitsInCombination, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF RED CARDS / DAYS / HOURS / MINUTES?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 24 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 12) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 12 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 6) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 6 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 3) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 3 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 1 hour before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.5) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 30 minutes before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.25) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 15 minutes before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.016667) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 1 minute before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfRedCards)
		if (redrawScreen = 1)
			OryUIUpdateText(txtNumberOfRedCards, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtNumberOfRedCards) + 1
		inputSpinner1Min = 0
		inputSpinner1Max = 599
		inputSpinner2Min = 0
		inputSpinner2Max = 599
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfRedCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfRedCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfRedCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfRedCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRedCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRedCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfRedCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfRedCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfRedCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfRedCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfRedCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfRedCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfRedCards) = 1) then simulationCount = 0
		minReds = val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards))
		maxReds = val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards))
		if (minReds = maxReds)
			if (maxReds = 0)
				OryUIUpdateText(txtNumberOfRedCards, "text: ;")
			elseif (maxReds = 1)
				if (regularity# = 24) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 1 day")
				if (regularity# = 12) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 12 hours")
				if (regularity# = 6) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 6 hours")
				if (regularity# = 3) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 3 hours")
				if (regularity# = 1) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 1 hour")
				if (regularity# = 0.5) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 30 minutes")
				if (regularity# = 0.25) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 15 minutes")
				if (regularity# = 0.016667) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately 1 minute")
			elseif (maxReds > 1)
				if (regularity# = 24) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 1440, maxReds * 1440))
				if (regularity# = 12) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 720, maxReds * 720))
				if (regularity# = 6) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 360, maxReds * 360))
				if (regularity# = 3) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 180, maxReds * 180))
				if (regularity# = 1) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 60, maxReds * 60))
				if (regularity# = 0.5) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 30, maxReds * 30))
				if (regularity# = 0.25) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1 * 15, maxReds * 15))
				if (regularity# = 0.016667) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(1, maxReds))
			endif
		else
			if (regularity# = 24) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 1440, maxReds * 1440))
			if (regularity# = 12) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 720, maxReds * 720))
			if (regularity# = 6) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 360, maxReds * 360))
			if (regularity# = 3) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 180, maxReds * 180))
			if (regularity# = 1) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 60, maxReds * 60))
			if (regularity# = 0.5) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 30, maxReds * 30))
			if (regularity# = 0.25) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds * 15, maxReds * 15))
			if (regularity# = 0.016667) then OryUIUpdateText(txtNumberOfRedCards, "text:Approximately " + ConvertMinutesRangeToText(minReds, maxReds))
		endif
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1)
				minReds = 0
				maxReds = 0
			endif
			OryUIUpdateTextCard(crdNumberOfRedCards, "position:-1000,-1000")
			OryUIUpdateText(txtNumberOfRedCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfRedCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "inputText:0;position:-1000,-1000")
		endif
	endif
	
	// MINIMUM LOCK DURATION?
	if (loadingSharedLock = 0 and fixed = 1)
		if (redrawScreen = 1)
			inputSpinnerTotalMinutesMin = 0
			if (botChosen = 0)
				OryUIUpdateTextCard(crdMinLockDuration, "headerText:Minimum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdMinLockDuration, "headerText:Approximate minimum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMinLockDuration)
		inputSpinnerDaysMin = 0
		inputSpinnerDaysMax = 365
		inputSpinnerHoursMin = 0
		inputSpinnerHoursMax = 23
		inputSpinnerMinutesMin = 0
		inputSpinnerMinutesMax = 59
		if (inputSpinnerTotalMinutesMin + 1440 > inputSpinnerTotalMinutesMax)
			inputSpinnerDaysMax = OryUIGetInputSpinnerInteger(spinMinNumberOfDays)
		endif
		if (inputSpinnerTotalMinutesMin + 60 > inputSpinnerTotalMinutesMax)
			inputSpinnerHoursMax = OryUIGetInputSpinnerInteger(spinMinNumberOfHours)
		endif
		if (inputSpinnerTotalMinutesMin + 1 > inputSpinnerTotalMinutesMax)
			inputSpinnerMinutesMax = OryUIGetInputSpinnerInteger(spinMinNumberOfMinutes)
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfDays, "position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMinNumberOfHours, "position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "position:" + str((screenNo * 100) + 66.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinDays, "position:" + str(OryUIGetInputSpinnerX(spinMinNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMinNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinHours, "position:" + str(OryUIGetInputSpinnerX(spinMinNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMinNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMinNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMinNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfDays) + 2
		OryUIUpdateInputSpinner(spinMinNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax) + ";step:1")
		OryUIUpdateInputSpinner(spinMinNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax) + ";step:1")
		OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax) + ";step:1")
		OryUIInsertInputSpinnerListener(spinMinNumberOfDays)
		OryUIInsertInputSpinnerListener(spinMinNumberOfHours)
		OryUIInsertInputSpinnerListener(spinMinNumberOfMinutes)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMinNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMinNumberOfMinutes))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinLockDuration) - GetSpriteY(screen[screenNo].sprPage))
		endif
		inputSpinnerTotalMinutesMin = (val(OryUIGetInputSpinnerString(spinMinNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMinNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMinNumberOfMinutes))
		minMinutes = inputSpinnerTotalMinutesMin
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 0) then minMinutes = 0
			OryUIUpdateTextCard(crdMinLockDuration, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0;position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:0;position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtMinDays, "position:-1000,-1000")
			OryUIUpdateText(txtMinHours, "position:-1000,-1000")
			OryUIUpdateText(txtMinMinutes, "position:-1000,-1000")
		endif
	endif
	
	// MAXIMUM LOCK DURATION?
	if (loadingSharedLock = 0 and fixed = 1)
		if (redrawScreen = 1)
			inputSpinnerTotalMinutesMax = 0
			if (botChosen = 0)
				OryUIUpdateTextCard(crdMaxLockDuration, "headerText:Maximum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdMaxLockDuration, "headerText:Approximate maximum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMaxLockDuration)
		inputSpinnerDaysMin = 0
		inputSpinnerDaysMax = 365
		inputSpinnerHoursMin = 0
		inputSpinnerHoursMax = 23
		inputSpinnerMinutesMin = 0
		inputSpinnerMinutesMax = 59
		if (inputSpinnerTotalMinutesMax - 1440 < inputSpinnerTotalMinutesMin)
			inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfDays)
		endif
		if (inputSpinnerTotalMinutesMax - 60 < inputSpinnerTotalMinutesMin)
			inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfHours)
		endif
		if (inputSpinnerTotalMinutesMax - 1 < inputSpinnerTotalMinutesMin)
			inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfMinutes)
		endif		
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMaxNumberOfDays, "position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfHours, "position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "position:" + str((screenNo * 100) + 66.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxDays, "position:" + str(OryUIGetInputSpinnerX(spinMaxNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMaxNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxHours, "position:" + str(OryUIGetInputSpinnerX(spinMaxNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMaxNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMaxNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMaxNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMaxNumberOfDays) + 2
		OryUIUpdateInputSpinner(spinMaxNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax) + ";step:1")
		OryUIInsertInputSpinnerListener(spinMaxNumberOfDays)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfHours)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfMinutes)
		if (OryUIGetInputSpinnerHasFocus(spinMaxNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfMinutes))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinLockDuration) - GetSpriteY(screen[screenNo].sprPage))
		endif
		inputSpinnerTotalMinutesMax = (val(OryUIGetInputSpinnerString(spinMaxNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMaxNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMaxNumberOfMinutes))
		maxMinutes = inputSpinnerTotalMinutesMax
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 0) then maxMinutes = 0
			OryUIUpdateTextCard(crdMaxLockDuration, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0;position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:0;position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtMaxDays, "position:-1000,-1000")
			OryUIUpdateText(txtMaxHours, "position:-1000,-1000")
			OryUIUpdateText(txtMaxMinutes, "position:-1000,-1000")
		endif
	endif
	
	// CORRECT MIN VALUES IF GREATER THAN MAX
	if (loadingSharedLock = 0 and fixed = 1)
		if (inputSpinnerTotalMinutesMin > inputSpinnerTotalMinutesMax)
			inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfDays)
			inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfHours)
			inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxNumberOfMinutes)
			OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMin))
			OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMin))
			OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMin))
		endif
	endif

	// DO YOU WANT TO ADD YELLOW CARDS?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddYellowCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "Yes")
				yellowCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "No")
				yellowCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "BotDecides")
				yellowCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddYellowCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddYellowCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddYellowCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddYellowCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddYellowCards) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddYellowCards) > OryUIGetButtonGroupItemCount(grpDoYouWantToAddYellowCards)) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddYellowCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddYellowCards) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddYellowCards) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then yellowCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddYellowCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddYellowCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF RANDOM YELLOW CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfRandomYellowCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedYellowCardsEachType
		inputSpinner2Min = 0
		inputSpinner2Max = cappedYellowCardsEachType
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfRandomYellowCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfRandomYellowCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfRandomYellowCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfRandomYellowCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRandomYellowCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRandomYellowCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfRandomYellowCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfRandomYellowCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfRandomYellowCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfRandomYellowCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfRandomYellowCards) = 1) then simulationCount = 0
		minYellowsRandom = val(OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards))
		maxYellowsRandom = val(OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or yellowCards <> 1))
				minYellowsRandom = 0
				maxYellowsRandom = 0
			endif
			OryUIUpdateTextCard(crdNumberOfRandomYellowCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfRandomYellowCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "inputText:0;position:-1000,-1000")
		endif
	endif
			
	// NUMBER OF YELLOW CARDS THAT REMOVE RED CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfYellowMinusCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedYellowCardsEachType
		inputSpinner2Min = 0
		inputSpinner2Max = cappedYellowCardsEachType
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfYellowMinusCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfYellowMinusCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfYellowMinusCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfYellowMinusCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowMinusCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfYellowMinusCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfYellowMinusCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfYellowMinusCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfYellowMinusCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfYellowMinusCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfYellowMinusCards) = 1) then simulationCount = 0
		minYellowsMinus = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards))
		maxYellowsMinus = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or yellowCards <> 1))
				minYellowsMinus = 0
				maxYellowsMinus = 0
			endif
			OryUIUpdateTextCard(crdNumberOfYellowMinusCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfYellowMinusCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "inputText:0;position:-1000,-1000")
		endif
	endif

	// NUMBER OF YELLOW CARDS THAT ADD RED CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfYellowAddCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedYellowCardsEachType
		inputSpinner2Min = 0
		inputSpinner2Max = cappedYellowCardsEachType
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfYellowAddCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfYellowAddCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfYellowAddCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfYellowAddCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowAddCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfYellowAddCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfYellowAddCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfYellowAddCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfYellowAddCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfYellowAddCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfYellowAddCards) = 1) then simulationCount = 0
		minYellowsAdd = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards))
		maxYellowsAdd = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or yellowCards <> 1))
				minYellowsAdd = 0
				maxYellowsAdd = 0
			endif
			OryUIUpdateTextCard(crdNumberOfYellowAddCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfYellowAddCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "inputText:0;position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD STICKY CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and fixed = 0)
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 24 hours before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 12) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 12 hours before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 6) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 6 hours before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 3) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 3 hours before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 1 hour before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.5) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 30 minutes before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.25) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 15 minutes before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.016667) then OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "supportingText:Like a red card, when a sticky card is revealed " + lower(userText$) + " will have to wait 1 minute before " + lower(userText$) + " can pick again. However, a sticky card goes back into play for a chance to be picked again and does not get discarded;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddStickyCards) = "Yes")
				stickyCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddStickyCards) = "No")
				stickyCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddStickyCards) = "BotDecides")
				stickyCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddStickyCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddStickyCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddStickyCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddStickyCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddStickyCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddStickyCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddStickyCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddStickyCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddStickyCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddStickyCards) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddStickyCards) > OryUIGetButtonGroupItemCount(grpDoYouWantToAddStickyCards)) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddStickyCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddStickyCards) > 0) 
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddStickyCards) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then stickyCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddStickyCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddStickyCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF STICKY CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and stickyCards = 1)
		OryUIUpdateTextCard(crdNumberOfStickyCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfStickyCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedStickyCards
		inputSpinner2Min = 0
		inputSpinner2Max = cappedStickyCards
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfStickyCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfStickyCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfStickyCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfStickyCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfStickyCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfStickyCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfStickyCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfStickyCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfStickyCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfStickyCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfStickyCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfStickyCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfStickyCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfStickyCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfStickyCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfStickyCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfStickyCards) = 1) then simulationCount = 0
		minStickies = val(OryUIGetInputSpinnerString(spinMinNumberOfStickyCards))
		maxStickies = val(OryUIGetInputSpinnerString(spinMaxNumberOfStickyCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or freezeCards <> 1))
				minStickies = 0
				maxStickies = 0
			endif
			OryUIUpdateTextCard(crdNumberOfStickyCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfStickyCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfStickyCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfStickyCards, "inputText:0;position:-1000,-1000")
		endif
	endif
	
	// DO YOU WANT TO ADD FREEZE CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and fixed = 0)
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 2-4 days;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 12) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 24-48 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 6) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 12-24 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 3) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 6-12 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 2-4 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.5) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 1-2 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.25) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 30-60 minutes;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.016667) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 2-4 minutes;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "Yes")
				freezeCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "No")
				freezeCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "BotDecides")
				freezeCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddFreezeCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddFreezeCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddFreezeCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddFreezeCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddFreezeCards) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddFreezeCards) > OryUIGetButtonGroupItemCount(grpDoYouWantToAddFreezeCards)) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddFreezeCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddFreezeCards) > 0) 
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddFreezeCards) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then freezeCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddFreezeCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF FREEZE CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and freezeCards = 1)
		OryUIUpdateTextCard(crdNumberOfFreezeCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfFreezeCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedFreezeCards
		inputSpinner2Min = 0
		inputSpinner2Max = cappedFreezeCards
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfFreezeCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfFreezeCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfFreezeCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfFreezeCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFreezeCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFreezeCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfFreezeCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfFreezeCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfFreezeCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfFreezeCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfFreezeCards) = 1) then simulationCount = 0
		minFreezes = val(OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards))
		maxFreezes = val(OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or freezeCards <> 1))
				minFreezes = 0
				maxFreezes = 0
			endif
			OryUIUpdateTextCard(crdNumberOfFreezeCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfFreezeCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "inputText:0;position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD DOUBLE UP CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddDoubleUpCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "Yes")
				doubleUpCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "No")
				doubleUpCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "BotDecides")
				doubleUpCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddDoubleUpCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddDoubleUpCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddDoubleUpCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddDoubleUpCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddDoubleUpCards) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddDoubleUpCards) > OryUIGetButtonGroupItemCount(grpDoYouWantToAddDoubleUpCards)) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddDoubleUpCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddDoubleUpCards) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddDoubleUpCards) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then doubleUpCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddDoubleUpCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddDoubleUpCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF DOUBLE UP CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and doubleUpCards = 1)
		OryUIUpdateTextCard(crdNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDoubleUpCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedDoubleUpCards
		inputSpinner2Min = 0
		inputSpinner2Max = cappedDoubleUpCards
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfDoubleUpCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfDoubleUpCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfDoubleUpCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfDoubleUpCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfDoubleUpCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfDoubleUpCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfDoubleUpCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfDoubleUpCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfDoubleUpCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfDoubleUpCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfDoubleUpCards) = 1) then simulationCount = 0
		minDoubleUps = val(OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards))
		maxDoubleUps = val(OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or doubleUpCards <> 1))
				minDoubleUps = 0
				maxDoubleUps = 0
			endif
			OryUIUpdateTextCard(crdNumberOfDoubleUpCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfDoubleUpCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "inputText:0;position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD RESET CARDS?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddResetCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "Yes")
				resetCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "No")
				resetCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "BotDecides")
				resetCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddResetCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddResetCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddResetCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddResetCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddResetCards) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddResetCards) > OryUIGetButtonGroupItemCount(grpDoYouWantToAddResetCards)) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddResetCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddResetCards) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddResetCards) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then resetCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddResetCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddResetCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF RESET CARDS?
	if (loadingSharedLock = 0 and fixed = 0 and resetCards = 1)
		OryUIUpdateTextCard(crdNumberOfResetCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfResetCards)
		inputSpinner1Min = 0
		inputSpinner1Max = cappedResetCards
		inputSpinner2Min = 0
		inputSpinner2Max = cappedResetCards
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfResetCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfResetCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfResetCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfResetCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfResetCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfResetCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfResetCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfResetCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfResetCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfResetCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfResetCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfResetCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfResetCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfResetCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfResetCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfResetCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfResetCards) = 1) then simulationCount = 0
		minResets = val(OryUIGetInputSpinnerString(spinMinNumberOfResetCards))
		maxResets = val(OryUIGetInputSpinnerString(spinMaxNumberOfResetCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and (fixed = 1 or resetCards <> 1))
				minResets = 0
				maxResets = 0
			endif
			OryUIUpdateTextCard(crdNumberOfResetCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfResetCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "inputText:0;position:-1000,-1000")
		endif
	endif

	// NUMBER OF GREEN CARDS?
	if (loadingSharedLock = 0 and fixed = 0)
		OryUIUpdateTextCard(crdNumberOfGreenCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfGreenCards)
		inputSpinner1Min = 1
		inputSpinner1Max = cappedGreenCards
		inputSpinner2Min = 1
		inputSpinner2Max = cappedGreenCards
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfGreenCardsTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfGreenCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfGreenCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfGreenCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfGreenCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfGreenCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfGreenCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfGreenCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfGreenCards)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards)))
				OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfGreenCards))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfGreenCards) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards)) < val(OryUIGetInputSpinnerString(spinMinNumberOfGreenCards)))
				OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards))
			endif
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfGreenCards) = 1) then simulationCount = 0
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfGreenCards) = 1) then simulationCount = 0
		minGreens = val(OryUIGetInputSpinnerString(spinMinNumberOfGreenCards))
		maxGreens = val(OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1)
				minGreens = 1
				maxGreens = 1
			endif
			OryUIUpdateTextCard(crdNumberOfGreenCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "inputText:1;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfGreenCardsTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "inputText:1;position:-1000,-1000")
		endif
	endif
	
	// MULTIPLE GREENS REQUIRED?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMultipleGreensRequired, "supportingText:If multiple green cards are required " + lower(userText$) + " will need to find all green cards that are in play to unlock. Otherwise " + lower(userText$) + " just need to find one green card, and any extra greens in play increase the chance of unlocking early.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "Yes")
				multipleGreensRequired = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "No")
				multipleGreensRequired = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "BotDecides")
				multipleGreensRequired = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMultipleGreensRequired)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpMultipleGreensRequired, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpMultipleGreensRequired, 2)
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpMultipleGreensRequired, 3)
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpMultipleGreensRequired) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpMultipleGreensRequired) > OryUIGetButtonGroupItemCount(grpMultipleGreensRequired)) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)
		endif
		OryUIInsertButtonGroupListener(grpMultipleGreensRequired)
		if (OryUIGetButtonGroupItemReleasedIndex(grpMultipleGreensRequired) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpMultipleGreensRequired) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then multipleGreensRequired = 0
			OryUIUpdateTextCard(crdMultipleGreensRequired, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpMultipleGreensRequired, "position:-1000,-1000")
		endif
	endif

	// HIDE CARD INFORMATION?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdHideCardInformation, "supportingText:If hidden " + lower(userText$) + " will not see card counts or percentages. To make it harder to count the exact number of cards some fake 'Go Again' cards may also be included in the deck. These cards do not affect the length of the lock in anyway, because when revealed " + lower(userText$) + " get to pick another card.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpHideCardInformation) = "Yes")
				cardInfoHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideCardInformation) = "No")
				cardInfoHidden = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideCardInformation) = "BotDecides")
				cardInfoHidden = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdHideCardInformation)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpHideCardInformation, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpHideCardInformation, 2)
				OryUIUpdateButtonGroupItem(grpHideCardInformation, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideCardInformation, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpHideCardInformation, 3)
				OryUIUpdateButtonGroupItem(grpHideCardInformation, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideCardInformation, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpHideCardInformation, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpHideCardInformation) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpHideCardInformation) > OryUIGetButtonGroupItemCount(grpHideCardInformation)) then OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 2)
		endif
		OryUIInsertButtonGroupListener(grpHideCardInformation)
		if (OryUIGetButtonGroupItemReleasedIndex(grpHideCardInformation) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpHideCardInformation) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 1) then cardInfoHidden = 0
			OryUIUpdateTextCard(crdHideCardInformation, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpHideCardInformation, "position:-1000,-1000")
		endif
	endif
	
	// HIDE TIMER?
	if (loadingSharedLock = 0 and fixed = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdHideTimer, "supportingText:If hidden " + lower(userText$) + " will not see how long is left of the lock.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "Yes")
				timerHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "No")
				timerHidden = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "BotDecides")
				timerHidden = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdHideTimer)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpHideTimer, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpHideTimer, 2)
				OryUIUpdateButtonGroupItem(grpHideTimer, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideTimer, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpHideTimer, 3)
				OryUIUpdateButtonGroupItem(grpHideTimer, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideTimer, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpHideTimer, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpHideTimer) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpHideTimer) > OryUIGetButtonGroupItemCount(grpHideTimer)) then OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)
		endif
		OryUIInsertButtonGroupListener(grpHideTimer)
		if (OryUIGetButtonGroupItemReleasedIndex(grpHideTimer) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpHideTimer) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0 and fixed = 0) then timerHidden = 0
			OryUIUpdateTextCard(crdHideTimer, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpHideTimer, "position:-1000,-1000")
		endif
	endif

	// CREATE FAKE COMBINATION?
	if (creatingSharedLock = 0)
		if (loadingSharedLock = 0)
			absoluteMinCopies = 0
			absoluteMaxCopies = 19 - noOfLocks
			if (showFakeCombinationOptions = 0)
				if (botControlled = 1 and absoluteMaxCopies >= 1) then showFakeCombinationOptions = 1
				if (fixed = 0 and absoluteMaxCopies >= 1) then showFakeCombinationOptions = 1
				if (fixed = 1 and minReds <> maxReds and absoluteMaxCopies >= 1) then showFakeCombinationOptions = 1
				if (fixed = 1 and minMinutes <> maxMinutes and absoluteMaxCopies >= 1) then showFakeCombinationOptions = 1
				if (showFakeCombinationOptions = 1)
					screen[screenNo].lastViewY# = GetViewOffsetY()
					SetScreenToView(constLockOptionsScreen)
				endif
			else
				if (absoluteMaxCopies <= 0) then showFakeCombinationOptions = 0
				if (botControlled = 0 and fixed = 1 and minMinutes = maxMinutes) then showFakeCombinationOptions = 0
				if (showFakeCombinationOptions = 0)
					screen[screenNo].lastViewY# = GetViewOffsetY()
					SetScreenToView(constLockOptionsScreen)
				endif
			endif
		endif
		if (loadingSharedLock = 1)
			if (absoluteMinCopies > 19 - noOfLocks)
				absoluteMinCopies = 19 - noOfLocks
				if (absoluteMinCopies < 0) then absoluteMinCopies = 0
			endif
			if (absoluteMaxCopies > 19 - noOfLocks)
				absoluteMaxCopies = 19 - noOfLocks
				if (absoluteMaxCopies < 0) then absoluteMaxCopies = 0
			endif
			if (showFakeCombinationOptions = 0)
				if (sharedID$ <> "" and absoluteMinCopies = 0 and absoluteMaxCopies >= 1) then showFakeCombinationOptions = 1
				if (showFakeCombinationOptions = 1)
					screen[screenNo].lastViewY# = GetViewOffsetY()
					SetScreenToView(constLockOptionsScreen)
				endif
			else
				if (absoluteMaxCopies = 0 or absoluteMinCopies = absoluteMaxCopies) then showFakeCombinationOptions = 0
				if (sharedID$ = "") then showFakeCombinationOptions = 0
				if (showFakeCombinationOptions = 0)
					screen[screenNo].lastViewY# = GetViewOffsetY()
					SetScreenToView(constLockOptionsScreen)
				endif
			endif
		endif
	endif
	if (creatingSharedLock = 1)
		absoluteMinCopies = 0
		absoluteMaxCopies = 19
		if (showFakeCombinationOptions = 0)
			if (fixed = 0) then showFakeCombinationOptions = 1
			if (fixed = 1 and minReds <> maxReds) then showFakeCombinationOptions = 1
			if (fixed = 1 and minMinutes <> maxMinutes) then showFakeCombinationOptions = 1
			if (showFakeCombinationOptions = 1)
				screen[screenNo].lastViewY# = GetViewOffsetY()
				SetScreenToView(constLockOptionsScreen)
			endif
		else
			if (fixed = 1 and minMinutes = maxMinutes) then showFakeCombinationOptions = 0
			if (showFakeCombinationOptions = 0)
				screen[screenNo].lastViewY# = GetViewOffsetY()
				SetScreenToView(constLockOptionsScreen)
			endif
		endif
	endif
	if (showFakeCombinationOptions = 1 and absoluteMinCopies = 0)
		if (redrawScreen = 1)
			if (creatingSharedLock = 0)
				OryUIUpdateTextCard(crdCreateFakeCombination, "headerText:Create copies with fake combinations?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. " + userText$ + " won't know which one is real or fake until " + lower(userText$) + " try the combination.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdCreateFakeCombination, "headerText:Allow copies with fake combinations?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. " + userText$ + " won't know which one is real or fake until " + lower(userText$) + " try the combination.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif	
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "Yes")
				createCopies = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "No")
				createCopies = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "BotDecides")
				createCopies = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCreateFakeCombination)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpCreateFakeCombination, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpCreateFakeCombination, 2)
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpCreateFakeCombination, 3)
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpCreateFakeCombination) = 0 or OryUIGetButtonGroupItemSelectedIndex(grpCreateFakeCombination) > OryUIGetButtonGroupItemCount(grpCreateFakeCombination)) then OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)
		endif
		OryUIInsertButtonGroupListener(grpCreateFakeCombination)
		if (OryUIGetButtonGroupItemReleasedIndex(grpCreateFakeCombination) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpCreateFakeCombination) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then createCopies = 0
			if (loadingSharedLock = 1 and absoluteMinCopies > 0) then createCopies = 1
			OryUIUpdateTextCard(crdCreateFakeCombination, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpCreateFakeCombination, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF FAKE COMBINATION COPIES?
	if (createCopies = 1 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "")))
		if (absoluteMinCopies = 0)
			OryUIUpdateTextCard(crdNumberOfFakeCombinationCopies, "headerText:Number of fake combination copies?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdNumberOfFakeCombinationCopies, "headerText:Number of fake combination copies?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. " + userText$ + " won't know which one is real or fake until " + lower(userText$) + " try the combination. The keyholder has requested that a minimum number of copies are created when loading this lock.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif	
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfFakeCombinationCopies)
		inputSpinner1Min = absoluteMinCopies
		inputSpinner1Max = absoluteMaxCopies
		inputSpinner2Min = absoluteMinCopies
		inputSpinner2Max = absoluteMaxCopies
		if (inputSpinner2Min = 0) then inputSpinner2Min = 1
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtNumberOfFakeCombinationCopiesTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "defaultValue:" + str(absoluteMinCopies) + ";min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "defaultValue:" + str(absoluteMaxCopies) + ";min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		if (val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies)) < absoluteMinCopies or val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies)) > absoluteMaxCopies)
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:" + str(absoluteMinCopies))
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:" + str(absoluteMaxCopies))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfFakeCombinationCopies) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfFakeCombinationCopies)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfFakeCombinationCopies)
		if (OryUIGetInputSpinnerChangedValue(spinMinNumberOfFakeCombinationCopies) = 1)
			if (val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies)) > val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies)))
				OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:" + OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies))
			endif
		elseif (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfFakeCombinationCopies) = 1)
			if (val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies)) < val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies)))
				OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:" + OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies))
			endif
		endif
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFakeCombinationCopies) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFakeCombinationCopies))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfFakeCombinationCopies) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minCopies = val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies))
		maxCopies = val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0)
				minCopies = 0
				maxCopies = 0
			endif
			OryUIUpdateTextCard(crdNumberOfFakeCombinationCopies, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "inputText:0;position:-1000,-1000")
			OryUIUpdateText(txtNumberOfFakeCombinationCopiesTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "inputText:1;position:-1000,-1000")
		endif
	endif

	// SCHEDULE AUTO RESETS?
	if (loadingSharedLock = 0 and fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdScheduleAutoResets, "supportingText:If yes, you will be able to set how often the lock resets. The reset will act like a keyholder reset which resets all card counts including double up and reset cards.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpScheduleAutoResets) = "Yes")
				autoResetLock = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpScheduleAutoResets) = "No")
				autoResetLock = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdScheduleAutoResets)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpScheduleAutoResets, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpScheduleAutoResets, 2)
			OryUIUpdateButtonGroupItem(grpScheduleAutoResets, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpScheduleAutoResets, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpScheduleAutoResets) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 2)
		endif
		OryUIInsertButtonGroupListener(grpScheduleAutoResets)
		if (OryUIGetButtonGroupItemReleasedIndex(grpScheduleAutoResets) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpScheduleAutoResets) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdScheduleAutoResets, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpScheduleAutoResets, "position:-1000,-1000")
		endif
	endif

	// RESET FREQUENCY
	if (loadingSharedLock = 0 and fixed = 0 and autoResetLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdResetFrequency, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdResetFrequency)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinResetFrequency, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtResetFrequency, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinResetFrequency) + (OryUIGetInputSpinnerHeight(spinResetFrequency) / 2) - (GetTextTotalHeight(txtResetFrequency) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# >= 1) then OryUIUpdateText(txtResetFrequency, "size:3")
			if (regularity# <= 0.5) then OryUIUpdateText(txtResetFrequency, "size:2.5")
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinResetFrequency) + 2
		OryUIInsertInputSpinnerListener(spinResetFrequency)
		if (OryUIGetInputSpinnerHasFocus(spinResetFrequency))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdResetFrequency) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinResetFrequency) = 1) then simulationCount = 0
		if (regularity# = 24) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 86400
		if (regularity# = 12) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 43200
		if (regularity# = 6) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 21600
		if (regularity# = 3) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 10800
		if (regularity# = 1) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 3600
		if (regularity# = 0.5) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 1800
		if (regularity# = 0.25) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 900
		if (regularity# = 0.016667) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinResetFrequency)) * 60
		OryUIUpdateText(txtResetFrequency, "text:Every " + ConvertSecondsToText(resetFrequencyInSeconds, 1))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then resetFrequencyInSeconds = 0
			OryUIUpdateTextCard(crdResetFrequency, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinResetFrequency, "position:-1000,-1000")
			OryUIUpdateText(txtResetFrequency, "position:-1000,-1000")
		endif
	endif
	
	// MAXIMUM NUMBER OF AUTO RESETS?
	if (loadingSharedLock = 0 and fixed = 0 and autoResetLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMaxNumberOfAutoResets, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMaxNumberOfAutoResets)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMaxNumberOfAutoResets) + 2
		OryUIInsertInputSpinnerListener(spinMaxNumberOfAutoResets)
		if (OryUIGetInputSpinnerHasFocus(spinMaxNumberOfAutoResets))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMaxNumberOfAutoResets) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinMaxNumberOfAutoResets) = 1) then simulationCount = 0
		maxAutoResets = val(OryUIGetInputSpinnerString(spinMaxNumberOfAutoResets))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then maxAutoResets = 0
			OryUIUpdateTextCard(crdMaxNumberOfAutoResets, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfAutoResets, "position:-1000,-1000")
		endif
	endif

	// CHECK-INS REQUIRED?
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCheckInsRequired, "supportingText:If yes, you will be able to set how often " + lower(userText$) + " need to check-in. Check-ins will be logged so that you can see if " + lower(userText$) + " checked in on time or late. How you act on these check-ins is up to you. The app doesn't do anything but track/record them. These may be more useful on fixed locks but can be used on either.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpCheckInsRequired) = "Yes")
				checkInsRequired = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCheckInsRequired) = "No")
				checkInsRequired = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCheckInsRequired)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpCheckInsRequired, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpCheckInsRequired, 2)
			OryUIUpdateButtonGroupItem(grpCheckInsRequired, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpCheckInsRequired, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpCheckInsRequired) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 2)
		endif
		OryUIInsertButtonGroupListener(grpCheckInsRequired)
		if (OryUIGetButtonGroupItemReleasedIndex(grpCheckInsRequired) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpCheckInsRequired) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCheckInsRequired, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpCheckInsRequired, "position:-1000,-1000")
		endif
	endif

	// CHECK-IN FREQUENCY
	if (creatingSharedLock = 1 and checkInsRequired = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCheckInFrequency, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCheckInFrequency)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinCheckInFrequency, "min:2;max:426;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtCheckInFrequency, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinCheckInFrequency) + (OryUIGetInputSpinnerHeight(spinCheckInFrequency) / 2) - (GetTextTotalHeight(txtCheckInFrequency) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# >= 1 or fixed = 1) then OryUIUpdateText(txtCheckInFrequency, "size:3")
			if (regularity# <= 0.5 and fixed = 0) then OryUIUpdateText(txtCheckInFrequency, "size:2.5")
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinCheckInFrequency) + 2
		OryUIInsertInputSpinnerListener(spinCheckInFrequency)
		if (OryUIGetInputSpinnerHasFocus(spinCheckInFrequency))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdCheckInFrequency) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinCheckInFrequency) = 1) then simulationCount = 0
		if (val(OryUIGetInputSpinnerString(spinCheckInFrequency)) < 4)
			checkInFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinCheckInFrequency)) * 900
		elseif (val(OryUIGetInputSpinnerString(spinCheckInFrequency)) < 52) // 28
			checkInFrequencyInSeconds = (val(OryUIGetInputSpinnerString(spinCheckInFrequency)) - 3) * 3600
		else
			checkInFrequencyInSeconds = (val(OryUIGetInputSpinnerString(spinCheckInFrequency)) - 49) * 86400 // 27
		endif
		OryUIUpdateText(txtCheckInFrequency, "text:Every " + ConvertSecondsToText(checkInFrequencyInSeconds, 1))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then checkInFrequencyInSeconds = 0
			OryUIUpdateTextCard(crdCheckInFrequency, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinCheckInFrequency, "position:-1000,-1000")
			OryUIUpdateText(txtCheckInFrequency, "position:-1000,-1000")
		endif
	endif
	
	// LATE CHECK-INS
	if (creatingSharedLock = 1 and checkInsRequired = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLateCheckIns, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLateCheckIns)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinLateCheckIns, "min:1;max:426;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtLateCheckIns, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinLateCheckIns) + (OryUIGetInputSpinnerHeight(spinLateCheckIns) / 2) - (GetTextTotalHeight(txtLateCheckIns) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# >= 1 or fixed = 1) then OryUIUpdateText(txtLateCheckIns, "size:3")
			if (regularity# <= 0.5 and fixed = 0) then OryUIUpdateText(txtLateCheckIns, "size:2.5")
		endif
		OryUIUpdateInputSpinner(spinLateCheckIns, "max:" + str(val(OryUIGetInputSpinnerString(spinCheckInFrequency)) - 1, 0))
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinLateCheckIns) + 2
		OryUIInsertInputSpinnerListener(spinLateCheckIns)
		if (OryUIGetInputSpinnerHasFocus(spinLateCheckIns))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdLateCheckIns) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (OryUIGetInputSpinnerChangedValue(spinLateCheckIns) = 1) then simulationCount = 0
		if (val(OryUIGetInputSpinnerString(spinLateCheckIns)) < 4)
			lateCheckInWindowInSeconds = val(OryUIGetInputSpinnerString(spinLateCheckIns)) * 900
		elseif (val(OryUIGetInputSpinnerString(spinLateCheckIns)) < 52) // 28
			lateCheckInWindowInSeconds = (val(OryUIGetInputSpinnerString(spinLateCheckIns)) - 3) * 3600
		else
			lateCheckInWindowInSeconds = (val(OryUIGetInputSpinnerString(spinLateCheckIns)) - 49) * 86400 // 27
		endif
		OryUIUpdateText(txtLateCheckIns, "text:Every " + ConvertSecondsToText(lateCheckInWindowInSeconds, 1))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then lateCheckInWindowInSeconds = 0
			OryUIUpdateTextCard(crdLateCheckIns, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinLateCheckIns, "position:-1000,-1000")
			OryUIUpdateText(txtLateCheckIns, "position:-1000,-1000")
		endif
	endif
	
	// ENABLE EARLY RELEASE WITH A PURCHASED KEY
	if (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and keyholderDisabledKey = 0))
		if (redrawScreen = 1)
			if (creatingSharedLock = 0)
				OryUIUpdateTextCard(crdEnableEarlyReleaseWithAPurchasedKey, "supportingText:If enabled, and in case of an emergency " + lower(userText$) + " have the option to purchase a digital key which will finish and unlock the lock early. It is recommended that " + lower(userText$) + " keep these enabled, especially if " + lower(userText$) + "'re not fully used to the equipment " + lower(userText$) + " will be using during the lock session. If " + lower(userText$) + " do disable them please have a back up plan in place that will allow " + lower(userText$) + " to unlock early in an emergency.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdEnableEarlyReleaseWithAPurchasedKey, "supportingText:If enabled, and in case of an emergency " + lower(userText$) + " have the option to purchase a digital key which will finish and unlock the lock early. If disabled, " + lower(userText$) + " will need to contact and ask you if they can be unlocked early because of an emergency.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpEnableEarlyReleaseWithAPurchasedKey) = "Yes")
				keyDisabled = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpEnableEarlyReleaseWithAPurchasedKey) = "No")
				keyDisabled = 1
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdEnableEarlyReleaseWithAPurchasedKey)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpEnableEarlyReleaseWithAPurchasedKey, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpEnableEarlyReleaseWithAPurchasedKey, 2)
			OryUIUpdateButtonGroupItem(grpEnableEarlyReleaseWithAPurchasedKey, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpEnableEarlyReleaseWithAPurchasedKey, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpEnableEarlyReleaseWithAPurchasedKey) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 2)
		endif
		OryUIInsertButtonGroupListener(grpEnableEarlyReleaseWithAPurchasedKey)
		if (OryUIGetButtonGroupItemReleasedIndex(grpEnableEarlyReleaseWithAPurchasedKey) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpEnableEarlyReleaseWithAPurchasedKey) + 2
		keyholderDisabledKey = 0
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then keyDisabled = 0
			if (loadingSharedLock = 1 and keyholderDisabledKey = 1) then keyDisabled = 1
			OryUIUpdateTextCard(crdEnableEarlyReleaseWithAPurchasedKey, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpEnableEarlyReleaseWithAPurchasedKey, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF KEYS REQUIRED FOR EMERGENCY RELEASE?
	if (((loadingSharedLock = 0 and creatingSharedLock = 0) or (loadingSharedLock = 1 and sharedID$ <> "" and keyholderDisabledKey = 0)) and keyDisabled = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdNumberOfKeysRequired, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfKeysRequired)
		if (redrawScreen = 1)
			OryUIUpdateText(txtNumberOfKeysRequired, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtNumberOfKeysRequired) + 1
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinNumberOfKeysRequired, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinNumberOfKeysRequired) + 2
		OryUIInsertInputSpinnerListener(spinNumberOfKeysRequired)
		if (OryUIGetInputSpinnerHasFocus(spinNumberOfKeysRequired))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfKeysRequired) - GetSpriteY(screen[screenNo].sprPage))
		endif
		noOfKeysRequired = val(OryUIGetInputSpinnerString(spinNumberOfKeysRequired))
		if (noOfKeysRequired = 1)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:1 key required (1 key costs[colon] " + GetInAppPurchaseLocalPrice(1) + ")")
		elseif (noOfKeysRequired < 5)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (2 keys costs[colon] " + GetInAppPurchaseLocalPrice(2) + ")")
		elseif (noOfKeysRequired < 10)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (5 keys costs[colon] " + GetInAppPurchaseLocalPrice(3) + ")")
		elseif (noOfKeysRequired < 25)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (10 keys costs[colon] " + GetInAppPurchaseLocalPrice(4) + ")")
		elseif (noOfKeysRequired < 50)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (25 keys costs[colon] " + GetInAppPurchaseLocalPrice(5) + ")")
		elseif (noOfKeysRequired = 50)
			OryUIUpdateText(txtNumberOfKeysRequired, "text:50 keys required (50 keys costs[colon] " + GetInAppPurchaseLocalPrice(6) + ")")
		endif
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then noOfKeysRequired = 1
			OryUIUpdateTextCard(crdNumberOfKeysRequired, "position:-1000,-1000")
			OryUIUpdateText(txtNumberOfKeysRequired, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinNumberOfKeysRequired, "inputText:1;position:-1000,-1000")
		endif
	endif

	// START LOCK FROZEN
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdStartLockFrozen, "supportingText:If yes, the lock will automatically be frozen when " + lower(userText$) + " load the lock and it will remain frozen until you unfreeze it.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpStartLockFrozen) = "Yes")
				startLockFrozen = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpStartLockFrozen) = "No")
				startLockFrozen = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdStartLockFrozen)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpStartLockFrozen, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpStartLockFrozen, 2)
			OryUIUpdateButtonGroupItem(grpStartLockFrozen, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpStartLockFrozen, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpStartLockFrozen) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 2)
		endif
		OryUIInsertButtonGroupListener(grpStartLockFrozen)
		if (OryUIGetButtonGroupItemReleasedIndex(grpStartLockFrozen) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpStartLockFrozen) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then startLockFrozen = 0
			OryUIUpdateTextCard(crdStartLockFrozen, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpStartLockFrozen, "position:-1000,-1000")
		endif
	endif
	
	// DISABLE KEYHOLDER DECISION AT END OF LOCK
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDisableKeyholderDecision, "supportingText:If disabled, " + lower(userText$) + " will not have the option at the end of the lock to ask for your decision as to whether the combination is revealed, or the lock is reset. If you're running this as a short lock for scenarios that might be considered dangerous, and worried that you might not always be available to make the decision when they request it, then it's a good idea to disable it.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDisableKeyholderDecision) = "Yes")
				keyholderDecisionDisabled = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDisableKeyholderDecision) = "No")
				keyholderDecisionDisabled = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDisableKeyholderDecision)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDisableKeyholderDecision, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpDisableKeyholderDecision, 2)
			OryUIUpdateButtonGroupItem(grpDisableKeyholderDecision, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpDisableKeyholderDecision, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpDisableKeyholderDecision) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 2)
		endif
		OryUIInsertButtonGroupListener(grpDisableKeyholderDecision)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDisableKeyholderDecision) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDisableKeyholderDecision) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then keyholderDecisionDisabled = 0
			OryUIUpdateTextCard(crdDisableKeyholderDecision, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDisableKeyholderDecision, "position:-1000,-1000")
		endif
	endif
	
	// LIMIT THE NUMBER OF USERS
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLimitNumberOfUsers, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpLimitNumberOfUsers) = "Yes")
				limitUsers = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpLimitNumberOfUsers) = "No")
				limitUsers = 0
				maxUsers = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLimitNumberOfUsers)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpLimitNumberOfUsers, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpLimitNumberOfUsers, 2)
			OryUIUpdateButtonGroupItem(grpLimitNumberOfUsers, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpLimitNumberOfUsers, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpLimitNumberOfUsers) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 2)
		endif
		OryUIInsertButtonGroupListener(grpLimitNumberOfUsers)
		if (OryUIGetButtonGroupItemReleasedIndex(grpLimitNumberOfUsers) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpLimitNumberOfUsers) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0)
				limitUsers = 0
				maxUsers = 0
			endif
			OryUIUpdateTextCard(crdLimitNumberOfUsers, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpLimitNumberOfUsers, "position:-1000,-1000")
		endif
	endif

	// MAXIMUM NUMBER OF USERS?
	if (creatingSharedLock = 1 and limitUsers = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMaximumNumberOfUsers, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMaximumNumberOfUsers)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMaximumNumberOfUsers) + 2
		OryUIInsertInputSpinnerListener(spinMaximumNumberOfUsers)
		if (OryUIGetInputSpinnerHasFocus(spinMaximumNumberOfUsers))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMaximumNumberOfUsers) - GetSpriteY(screen[screenNo].sprPage))
		endif
		maxUsers = val(OryUIGetInputSpinnerString(spinMaximumNumberOfUsers))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then maxUsers = 0
			OryUIUpdateTextCard(crdMaximumNumberOfUsers, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaximumNumberOfUsers, "inputText:40;position:-1000,-1000")
		endif
	endif

	// BLOCK TEST LOCKS?
	if (creatingSharedLock = 1 and testLock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdBlockTestLocks, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpBlockTestLocks) = "Yes")
				blockTestLocks = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpBlockTestLocks) = "No")
				blockTestLocks = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdBlockTestLocks)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpBlockTestLocks, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpBlockTestLocks, 2)
			OryUIUpdateButtonGroupItem(grpBlockTestLocks, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpBlockTestLocks, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpBlockTestLocks) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockTestLocks, 2)
		endif
		OryUIInsertButtonGroupListener(grpBlockTestLocks)
		if (OryUIGetButtonGroupItemReleasedIndex(grpBlockTestLocks) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpBlockTestLocks) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then blockTestLocks = 0
			OryUIUpdateTextCard(crdBlockTestLocks, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpBlockTestLocks, "position:-1000,-1000")
		endif
	endif

	// BLOCK USERS WITH A SPECIFIC RATING?
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdBlockUsersWithSpecificRating, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersWithSpecificRating) = "Yes")
				blockUsersWithSpecificRating = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersWithSpecificRating) = "No")
				blockUsersWithSpecificRating = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdBlockUsersWithSpecificRating)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpBlockUsersWithSpecificRating, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpBlockUsersWithSpecificRating, 2)
			OryUIUpdateButtonGroupItem(grpBlockUsersWithSpecificRating, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpBlockUsersWithSpecificRating, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpBlockUsersWithSpecificRating) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 2)
		endif
		OryUIInsertButtonGroupListener(grpBlockUsersWithSpecificRating)
		if (OryUIGetButtonGroupItemReleasedIndex(grpBlockUsersWithSpecificRating) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpBlockUsersWithSpecificRating) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then blockUsersWithSpecificRating = 0
			OryUIUpdateTextCard(crdBlockUsersWithSpecificRating, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpBlockUsersWithSpecificRating, "position:-1000,-1000")
		endif
	endif

	// MINIMUM RATING REQUIRED?
	if (creatingSharedLock = 1 and blockUsersWithSpecificRating = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMinimumRatingRequired, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMinimumRatingRequired)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinimumRatingRequired, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinimumRatingRequired) + 2
		OryUIInsertInputSpinnerListener(spinMinimumRatingRequired)
		if (OryUIGetInputSpinnerHasFocus(spinMinimumRatingRequired))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinimumRatingRequired) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minRatingRequired = val(OryUIGetInputSpinnerString(spinMinimumRatingRequired))
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then minRatingRequired = 0
			OryUIUpdateTextCard(crdMinimumRatingRequired, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinimumRatingRequired, "inputText:1;position:-1000,-1000")
		endif
	endif
	
	// BLOCK USERS ALREADY LOCKED?
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdBlockUsersAlreadyLocked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersAlreadyLocked) = "Yes")
				blockUsersAlreadyLocked = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersAlreadyLocked) = "No")
				blockUsersAlreadyLocked = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdBlockUsersAlreadyLocked)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpBlockUsersAlreadyLocked, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpBlockUsersAlreadyLocked, 2)
			OryUIUpdateButtonGroupItem(grpBlockUsersAlreadyLocked, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpBlockUsersAlreadyLocked, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpBlockUsersAlreadyLocked) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 2)
		endif
		OryUIInsertButtonGroupListener(grpBlockUsersAlreadyLocked)
		if (OryUIGetButtonGroupItemReleasedIndex(grpBlockUsersAlreadyLocked) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpBlockUsersAlreadyLocked) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then blockUsersAlreadyLocked = 0
			OryUIUpdateTextCard(crdBlockUsersAlreadyLocked, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpBlockUsersAlreadyLocked, "position:-1000,-1000")
		endif
	endif
	
	// BLOCK USERS WITH STATS HIDDEN?
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdBlockUsersWithStatsHidden, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersWithStatsHidden) = "Yes")
				blockUsersWithStatsHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpBlockUsersWithStatsHidden) = "No")
				blockUsersWithStatsHidden = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdBlockUsersWithStatsHidden)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpBlockUsersWithStatsHidden, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpBlockUsersWithStatsHidden, 2)
			OryUIUpdateButtonGroupItem(grpBlockUsersWithStatsHidden, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpBlockUsersWithStatsHidden, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpBlockUsersWithStatsHidden) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 2)
		endif
		OryUIInsertButtonGroupListener(grpBlockUsersWithStatsHidden)
		if (OryUIGetButtonGroupItemReleasedIndex(grpBlockUsersWithStatsHidden) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpBlockUsersWithStatsHidden) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then blockUsersWithStatsHidden = 0
			OryUIUpdateTextCard(crdBlockUsersWithStatsHidden, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpBlockUsersWithStatsHidden, "position:-1000,-1000")
		endif
	endif

	// FORCE TRUST?
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdForceTrust, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpForceTrust) = "Yes")
				forceTrust = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpForceTrust) = "No")
				forceTrust = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdForceTrust)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpForceTrust, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpForceTrust, 2)
			OryUIUpdateButtonGroupItem(grpForceTrust, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpForceTrust, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpForceTrust) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 2)
		endif
		OryUIInsertButtonGroupListener(grpForceTrust)
		if (OryUIGetButtonGroupItemReleasedIndex(grpForceTrust) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpForceTrust) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then forceTrust = 0
			OryUIUpdateTextCard(crdForceTrust, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpForceTrust, "position:-1000,-1000")
		endif
	endif
	
	// REQUIRE DM BEFORE LOADING
	if (creatingSharedLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdRequireDM, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpRequireDM) = "Yes")
				requireDM = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpRequireDM) = "No")
				requireDM = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdRequireDM)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpRequireDM, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpRequireDM, 2)
			OryUIUpdateButtonGroupItem(grpRequireDM, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpRequireDM, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpRequireDM) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 2)
		endif
		OryUIInsertButtonGroupListener(grpRequireDM)
		if (OryUIGetButtonGroupItemReleasedIndex(grpRequireDM) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpRequireDM) + 2
	else
		if (redrawScreen = 1)
			if (loadingSharedLock = 0) then requireDM = 0
			OryUIUpdateTextCard(crdRequireDM, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpRequireDM, "position:-1000,-1000")
		endif
	endif
	
	// CONTACTED KEYHOLDER
	if (loadingSharedLock = 1 and requireDM = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdContactedKeyholder, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpContactedKeyholder) = "Yes")
				contactedKeyholder = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpContactedKeyholder) = "No")
				contactedKeyholder = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdContactedKeyholder)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpContactedKeyholder, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUISetButtonGroupItemCount(grpContactedKeyholder, 2)
			OryUIUpdateButtonGroupItem(grpContactedKeyholder, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpContactedKeyholder, 2, "name:No;text:No")
			if (OryUIGetButtonGroupItemSelectedIndex(grpContactedKeyholder) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)
		endif
		OryUIInsertButtonGroupListener(grpContactedKeyholder)
		if (OryUIGetButtonGroupItemReleasedIndex(grpContactedKeyholder) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockOptionsScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpContactedKeyholder) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdContactedKeyholder, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpContactedKeyholder, "position:-1000,-1000")
		endif
	endif
	
	// LOCK ESTIMATIONS
	if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
		if (redrawScreen = 1)
			if ((loadingSharedLock = 1 and sharedID$ <> "") or botChosen > 0)
				if (cumulative = 0) then OryUIUpdateTextCard(crdLockEstimations, "supportingText:These estimates are based on 100 test runs of a lock with the above settings. They do not take into account time away from the app, i.e. sleeping. Nor do they take into account keyholder updates.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				if (cumulative = 1 or cumulative = 3) then OryUIUpdateTextCard(crdLockEstimations, "supportingText:These estimates are based on 100 test runs of a lock with the above settings. They do not take into account keyholder updates.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				if (cumulative = 0) then OryUIUpdateTextCard(crdLockEstimations, "supportingText:These estimates are based on 100 test runs of a lock with the above settings. They do not take into account time away from the app, i.e. sleeping.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				if (cumulative = 1 or cumulative = 3) then OryUIUpdateTextCard(crdLockEstimations, "supportingText:These estimates are based on 100 test runs of a lock with the above settings.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLockEstimations)

		if (redrawScreen = 1)
			simulationCount = 0
		endif
		if (simulationCount = 0)
			simulationAverageMinutesLocked = 0
			simulationAverageNoOfTurns = 0
			simulationAverageNoOfCardsDrawn = 0
			simulationAverageNoOfLockResets = 0
			simulationBestCaseMinutesLocked = 9999999999
			simulationBestCaseNoOfTurns = 9999999999
			simulationBestCaseNoOfCardsDrawn = 9999999999
			simulationBestCaseNoOfLockResets = 9999999999
			simulationWorstCaseMinutesLocked = 0
			simulationWorstCaseNoOfTurns = 0
			simulationWorstCaseNoOfCardsDrawn = 0
			simulationWorstCaseNoOfLockResets = 0
			if (maxReds = 0)
				simulationMinimumRedCards = 1
			elseif (minReds = maxReds)
				simulationMinimumRedCards = 1
			else
				simulationMinimumRedCards = minReds
			endif
		endif

		if (simulationCount > 0)
			RunSimulation(1)
		endif
		if (simulationCount <= simulationsToTry)
			if (simulationMinutesLocked < simulationBestCaseMinutesLocked) then simulationBestCaseMinutesLocked = simulationMinutesLocked
			if (simulationNoOfTurns < simulationBestCaseNoOfTurns) then simulationBestCaseNoOfTurns = simulationNoOfTurns
			if (simulationNoOfCardsDrawn < simulationBestCaseNoOfCardsDrawn) then simulationBestCaseNoOfCardsDrawn = simulationNoOfCardsDrawn
			if (simulationNoOfLockResets < simulationBestCaseNoOfLockResets) then simulationBestCaseNoOfLockResets = simulationNoOfLockResets
			if (simulationMinutesLocked > simulationWorstCaseMinutesLocked) then simulationWorstCaseMinutesLocked = simulationMinutesLocked
			if (simulationNoOfTurns > simulationWorstCaseNoOfTurns) then simulationWorstCaseNoOfTurns = simulationNoOfTurns
			if (simulationNoOfCardsDrawn > simulationWorstCaseNoOfCardsDrawn) then simulationWorstCaseNoOfCardsDrawn = simulationNoOfCardsDrawn
			if (simulationNoOfLockResets > simulationWorstCaseNoOfLockResets) then simulationWorstCaseNoOfLockResets = simulationNoOfLockResets
		endif
		if (simulationCount = simulationsToTry)
			simulationRan = 1
		endif
		
		for i = 1 to 4
			if (i = 4 and resetCards = 0 and autoResetLock = 0)
				OryUIUpdateText(lockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
				continue
			endif
			chartTitle$ as string : chartTitle$ = ""
			bestCase as integer : bestCase = 0
			averageCase as integer : averageCase = 0
			worstCase as integer : worstCase = 0
			if (i = 1)
				if (regularity# = 24 or ((simulationAverageMinutesLocked / simulationsToTry) / 60) >= 168)
					chartTitle$ = "Number of days"
					bestCase = simulationBestCaseMinutesLocked / 60 / 24
					averageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60 / 24
					worstCase = simulationWorstCaseMinutesLocked / 60 / 24
				else
					chartTitle$ = "Number of hours"
					bestCase = simulationBestCaseMinutesLocked / 60
					averageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60
					worstCase = simulationWorstCaseMinutesLocked / 60
				endif
			endif
			if (i = 2)
				chartTitle$ = "Number of chances"
				bestCase = simulationBestCaseNoOfTurns
				averageCase = simulationAverageNoOfTurns / simulationsToTry
				worstCase = simulationWorstCaseNoOfTurns
			endif
			if (i = 3)
				chartTitle$ = "Number of cards drawn"
				bestCase = simulationBestCaseNoOfCardsDrawn
				averageCase = simulationAverageNoOfCardsDrawn / simulationsToTry
				worstCase = simulationWorstCaseNoOfCardsDrawn
			endif
			if (i = 4)
				chartTitle$ = "Number of resets (card and scheduled)"
				bestCase = simulationBestCaseNoOfLockResets
				averageCase = simulationAverageNoOfLockResets / simulationsToTry
				worstCase = simulationWorstCaseNoOfLockResets
			endif
			min as integer : min = RoundDownWithReducedPrecision(bestCase)
			max as integer : max = RoundUpWithReducedPrecision(worstCase)
			bestCaseWidth# as float : bestCaseWidth# = (70.0 / (max - min)) * (bestCase - min)
			averageCaseWidth# as float : averageCaseWidth# = (70.0 / (max - min)) * (averageCase - min)
			worstCaseWidth# as float : worstCaseWidth# = (70.0 / (max - min)) * (worstCase - min)
			OryUIUpdateText(lockEstimations[i].txtChartTitle, "text:" + chartTitle$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			elementY# = elementY# + GetTextTotalHeight(lockEstimations[i].txtChartTitle) + 1
			OryUIUpdateSprite(lockEstimations[i].sprBackground, "position:" + str((screenNo * 100) + 15) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateSprite(lockEstimations[i].sprBestCaseBar, "width:" + str(bestCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 0.5) + ";colorID:" + str(theme[themeSelected].color[2]))
			OryUIUpdateSprite(lockEstimations[i].sprAverageCaseBar, "width:" + str(averageCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 3) + ";colorID:" + str(theme[themeSelected].color[3]))
			OryUIUpdateSprite(lockEstimations[i].sprWorstCaseBar, "width:" + str(worstCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 5.5) + ";colorID:" + str(theme[themeSelected].color[4]))
			OryUIUpdateText(lockEstimations[i].txtBestCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(lockEstimations[i].txtAverageCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(lockEstimations[i].txtWorstCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(lockEstimations[i].txtBestCaseLabel, "text:" + str(bestCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(lockEstimations[i].txtAverageCaseLabel, "text:" + str(averageCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(lockEstimations[i].txtWorstCaseLabel, "text:" + str(worstCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtBestCaseTitle, lockEstimations[i].sprBestCaseBar, -(GetTextTotalWidth(lockEstimations[i].txtBestCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtAverageCaseTitle, lockEstimations[i].sprAverageCaseBar, -(GetTextTotalWidth(lockEstimations[i].txtAverageCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtWorstCaseTitle, lockEstimations[i].sprWorstCaseBar, -(GetTextTotalWidth(lockEstimations[i].txtWorstCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtBestCaseLabel, lockEstimations[i].sprBestCaseBar, GetSpriteWidth(lockEstimations[i].sprBestCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtAverageCaseLabel, lockEstimations[i].sprAverageCaseBar, GetSpriteWidth(lockEstimations[i].sprAverageCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(lockEstimations[i].txtWorstCaseLabel, lockEstimations[i].sprWorstCaseBar, GetSpriteWidth(lockEstimations[i].sprWorstCaseBar) + 2, 0)
			if (simulationCount = 0)
				OryUIPinSpriteToSprite(lockEstimations[i].sprChartOverlay, lockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(lockEstimations[i].txtRunningSimulation, "text:Simulation Ready to Run")
				OryUIPinTextToCentreOfSprite(lockEstimations[i].txtRunningSimulation, lockEstimations[i].sprChartOverlay, 0, 0)
			elseif (simulationCount < simulationsToTry)
				OryUIPinSpriteToSprite(lockEstimations[i].sprChartOverlay, lockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(lockEstimations[i].txtRunningSimulation, "text:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry))
				OryUIPinTextToCentreOfSprite(lockEstimations[i].txtRunningSimulation, lockEstimations[i].sprChartOverlay, 0, 0)
			else
				OryUIUpdateSprite(lockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			endif
			elementY# = elementY# + GetSpriteHeight(lockEstimations[i].sprBackground) + 2
		next
		if (simulationRan = 0)
			OryUIUpdateButton(btnRerunSimulation, "text:Run Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		else
			OryUIUpdateButton(btnRerunSimulation, "text:Rerun Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif	
		elementY# = elementY# + OryUIGetButtonHeight(btnRerunSimulation) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLockEstimations, "position:-1000,-1000")
			for i = 1 to 4
				OryUIUpdateText(lockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(lockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(lockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			next
			OryUIUpdateButton(btnRerunSimulation, "position:-1000,-1000")
		endif
	endif
	if (OryUIGetButtonReleased(btnRerunSimulation))
		simulationCount = 0
		RunSimulation(1)
	endif
	
	// NEXT BUTTON
	if (loadingSharedLock = 0 or sharedID$ <> "")
		if (redrawScreen = 1)
			OryUIUpdateButton(screen[screenNo].btnNext, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(screen[screenNo].btnNext) + 4
		if (OryUIGetButtonReleased(screen[screenNo].btnNext))
			if (fixed = 0 and maxReds = 0 and maxStickies = 0 and maxYellowsAdd = 0 and maxYellowsRandom = 0 and maxFreezes = 0)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:More Cards Required;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:A variable lock requires a chance to contain at least one of the following cards to be valid[colon]" + chr(10) + chr(10) + "1 Red Card" + chr(10) + "1 Yellow Card (that adds reds)" + chr(10) + "1 Sticky Card" + chr(10) + "1 Freeze Card;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (fixed = 1 and regularity# >= 0.25 and minReds = 0 and maxReds = 0)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Too Short;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:A fixed lock must last at least " + ConvertMinutesToText(regularity# * 60, 1) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (fixed = 1 and regularity# = 0.016667 and minMinutes = 0 and maxMinutes = 0)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Too Short;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:A fixed lock must last at least 1 minute;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				if (creatingSharedLock = 0)
					if (createCopies = 0)
						noOfCopies = 0
					elseif (createCopies = 1)
						noOfCopies = random(minCopies, maxCopies)
					elseif (createCopies = 3)
						if (botChosen = 1 or botChosen = 2)
							if (absoluteMaxCopies >= 2)
								noOfCopies = random(0, 2)
							else
								noOfCopies = random(0, absoluteMaxCopies)
							endif
						else
							if (absoluteMaxCopies >= 4)
								noOfCopies = random(0, 4)
							else
								noOfCopies = random(0, absoluteMaxCopies)
							endif
						endif
					endif
					if (lastCombinationLength <> noOfDigits or generatedCombination$ = "")
						GenerateCombination(noOfDigits, 1)
						lastCombinationLength = noOfDigits
					endif
					if (loadingSharedLock = 0)
						SetScreenToView(constSetCombinationScreen)
					else
						if (hiddenFromOwner = 0)
							if (username$ = keyholderUsername$)
								OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Can't Control Own Lock;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Loading your own lock as a keyholder and lockee is not possible. You can create and run the lock but it will run as a solo lock, and you will not be able to update it as a keyholder.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(dialog, 2)
								OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesLoadLock;text:Run as a Solo Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(dialog)
							else
								if (requireDM = 1 and contactedKeyholder = 0)
									OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Contact Keyholder;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + keyholderUsername$ + " requires that you contact them before loading this lock. Select 'Yes' at the option above if you have contacted them, and have permission to load it.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(dialog, 1)
									OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(dialog)
									shownDialog = 1
								elseif (blockUsersAlreadyLocked = 1 or forceTrust = 1)
									dialogMessage$ as string : dialogMessage$ = "The keyholder requires that you agree to the following before loading[colon]" + chr(10) + chr(10)
									if (fixed = 0 and regularity# = 0.016667)
										dialogMessage$ = dialogMessage$ + "• This lock has been created for testing purposes and will not be included in your lock history and stats." + chr(10)
									endif
									if (blockUsersAlreadyLocked = 1 and testLock = 0)
										dialogMessage$ = dialogMessage$ + "• You will not be able to load locks from other keyholders while locked with this one." + chr(10)
									endif
									if (forceTrust = 1)
										dialogMessage$ = dialogMessage$ + "• You trust them, which will remove all limitations from them as your keyholder and means that they can add/remove as much time as they want, and as often as they want." + chr(10)
									endif
									if (blockTestLocks = 1)
										dialogMessage$ = dialogMessage$ + "• You are loading this lock as a real lock, and will be locking something away." + chr(10)
									endif	
									dialogMessage$ = dialogMessage$ + chr(10) + "Do you agree to the above?"
									OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Do You Agree?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + dialogMessage$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(dialog, 2)
									OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesLoadLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(dialog)
									shownDialog = 1
								elseif (durationMayChangeAlertHidden = 0)
									OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Duration May Change!;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Shared locks can be modified by the lock owner once locked, which means the duration of this lock might increase or decrease at any time." + chr(10) + chr(10) + "Are you sure you want to continue loading this shared lock?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(dialog, 2)
									OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesLoadLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(dialog)
									shownDialog = 1
								else
									SetScreenToView(constSetCombinationScreen)
								endif
							endif
						else
							OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock No Longer Managed!;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock is no longer managed by the lock owner, which means they will not increase/decrease the duration of the lock once it's running. However, the lock can still be loaded and will run as a solo lock with the options they chose when setting it up. There won't be a keyholder controlling it." + chr(10) + chr(10) + "Do you wish to continue loading this shared lock?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(dialog, 2)
							OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesLoadLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(dialog)	
						endif
					endif
				else
					sharedLockSettings$ = BuildSharedLockSettingsString()
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Create Shared Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You're about to create a shared lock with the following settings[colon]" + chr(10) + chr(10) + BuildSharedLockSettingsString() + chr(10) + "Do these look correct?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 2)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesCreateLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
			endif
		endif
	else
		OryUIUpdateButton(screen[screenNo].btnNext, "position:-1000,-1000")
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesLoadLock"))
		if (OryUIGetDialogChecked(dialog))
			durationMayChangeAlertHidden = 1
			SaveLocalVariable("durationMayChangeAlertHidden", "1")
		endif
		SetScreenToView(constSetCombinationScreen)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesCreateLock"))
		shareID$ = RandomShareID()
		CheckNewShareID(1)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "ChangeUsername"))
		OryUIHideDialog(dialog)
		SetScreenToView(constEditProfileScreen)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "CancelChangeUsername") and selectedLockOptionsTab = 1)
		OryUIHideDialog(dialog)
		OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)
		creatingSharedLock = 0
		SetScreenToView(constLockOptionsScreen)
	endif

	// ADVERTS
	if (OryUIAnyTextfieldFocused() = 0 and OryUIAnyInputSpinnerTextfieldFocused() = 0)
		if (adsRemoved = 0 and offline = 0)
			oryUIBottomBannerAdOnScreen = 1
			SetAdvertVisible(1)
		else
			oryUIBottomBannerAdOnScreen = 0
			SetAdvertVisible(0)
		endif
	else
		oryUIBottomBannerAdOnScreen = 0
		SetAdvertVisible(0)
	endif
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
	
	// SCROLL BAR
	if (redrawScreen = 1)
		if (oryUIBottomBannerAdOnScreen = 1) then trackHeightReduction# = 21
		if (oryUIBottomBannerAdOnScreen = 0) then trackHeightReduction# = 14
		trackBarHeight# = 100 - startScrollBarY# - trackHeightReduction#
		OryUIUpdateScrollBar(scrollBar, "contentSize:100," + str(maxScrollY# + 100 - trackHeightReduction#) + ";trackPosition:93," + str(startScrollBarY#) + ";trackSize:4.5," + str(trackBarHeight#) + ";invisibleGripSize:8.5,7;gripSize:4.5,5;gripColorID:" + str(theme[themeSelected].color[3]) + ";showGripIcon:true;gripIconSize:4,5;gripIconColor:255,255,255;trackColor:0,0,0,0")
	endif
endif
