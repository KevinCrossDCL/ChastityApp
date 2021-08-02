
OryUIHideFloatingActionButton(fabSaveSharedLockInformation)
if (screenToView = constSharedLockInformationScreen)
	// RESET OPTIONS WHEN FIRST COMING TO THE SCREEN
	if (screenNo <> constSharedLockInformationScreen)
		local agreeToCheckInChange as integer
		
		OryUIUpdateTextfield(editBoxSharedLockName, "inputText:" + sharedLocks[sharedLockSelected, 0].lockName$)
		if (sharedLocks[sharedLockSelected, 0].temporarilyDisabled = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpTemporarilyDisable, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpTemporarilyDisable, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].shareInAPI = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpShareInAPI, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpShareInAPI, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].cardInfoHidden = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockShowCardInformation, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockShowCardInformation, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].timerHidden = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockHideTimer, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockHideTimer, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].maxRandomCopies = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCreateFakeCombination, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCreateFakeCombination, 1)
		endif
		OryUIUpdateInputSpinner(spinSharedLockMinNumberOfFakeCombinationCopies, "inputText:" + str(sharedLocks[sharedLockSelected, 0].minRandomCopies))
		OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfFakeCombinationCopies, "inputText:" + str(sharedLocks[sharedLockSelected, 0].maxRandomCopies))
		if (sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockScheduleAutoResets, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockScheduleAutoResets, 1)
			inputSpinnerValue as integer : inputSpinnerValue = 0
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 86400
			if (sharedLocks[sharedLockSelected, 0].regularity# = 12) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 43200
			if (sharedLocks[sharedLockSelected, 0].regularity# = 6) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 21600
			if (sharedLocks[sharedLockSelected, 0].regularity# = 3) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 10800
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 3600
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 1800
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 900
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then inputSpinnerValue = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds / 60
			OryUIUpdateInputSpinner(spinSharedLockResetFrequency, "inputText:" + str(inputSpinnerValue))
			OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfAutoResets, "inputText:" + str(sharedLocks[sharedLockSelected, 0].maxAutoResets))
		endif
		if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCheckInsRequired, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCheckInsRequired, 1)
			inputSpinnerValue = 0
			if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds < 3600)
				inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds / 900)
			elseif (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds < 86400)
				inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds / 3600) + 3
			else
				inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds / 86400) + 27
			endif
			OryUIUpdateInputSpinner(spinSharedLockCheckInFrequency, "inputText:" + str(inputSpinnerValue))
			inputSpinnerValue = 0
			if (sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds = 0)
				if (fixed = 0)
					if ((sharedLocks[sharedLockSelected, 0].regularity# * 3600) < 3600)
						inputSpinnerValue = round((sharedLocks[sharedLockSelected, 0].regularity# * 3600) / 900)
					elseif ((sharedLocks[sharedLockSelected, 0].regularity# * 3600) < 86400)
						inputSpinnerValue = round((sharedLocks[sharedLockSelected, 0].regularity# * 3600) / 3600) + 3
					else
						inputSpinnerValue = round((sharedLocks[sharedLockSelected, 0].regularity# * 3600) / 86400) + 27
					endif
				else
					if (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400) < 3600)
						inputSpinnerValue = round(MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400) / 900)
					elseif (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400) < 86400)
						inputSpinnerValue = round(MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400) / 3600) + 3
					else
						inputSpinnerValue = round(MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400) / 86400) + 27
					endif
				endif	
			else
				if (sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds < 3600)
					inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds / 900)
				elseif (sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds < 86400)
					inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds / 3600) + 3
				else
					inputSpinnerValue = round(sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds / 86400) + 27
				endif
			endif
			OryUIUpdateInputSpinner(spinSharedLockLateCheckIns, "inputText:" + str(inputSpinnerValue))
		endif
		if (sharedLocks[sharedLockSelected, 0].keyDisabled = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, 1)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, 2)
		endif
		if (sharedLocks[sharedLockSelected, 0].startLockFrozen = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockStartLockFrozen, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockStartLockFrozen, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].keyholderDecisionDisabled = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockDisableKeyholderDecision, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockDisableKeyholderDecision, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].maxUsers = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockLimitNumberOfUsers, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockLimitNumberOfUsers, 1)
		endif
		OryUIUpdateInputSpinner(spinSharedLockMaximumNumberOfUsers, "inputText:" + str(sharedLocks[sharedLockSelected, 0].maxUsers))
		if (sharedLocks[sharedLockSelected, 0].blockTestLocks = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockTestLocks, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockTestLocks, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].minRatingRequired = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithSpecificRating, 2)
			OryUIUpdateInputSpinner(spinSharedLockMinimumRatingRequired, "inputText:1")
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithSpecificRating, 1)
			OryUIUpdateInputSpinner(spinSharedLockMinimumRatingRequired, "inputText:" + str(sharedLocks[sharedLockSelected, 0].minRatingRequired))
		endif	
		if (sharedLocks[sharedLockSelected, 0].blockUsersAlreadyLocked = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersAlreadyLocked, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersAlreadyLocked, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].blockUsersWithStatsHidden = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithStatsHidden, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithStatsHidden, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].forceTrust = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockForceTrust, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockForceTrust, 1)
		endif
		if (sharedLocks[sharedLockSelected, 0].requireDM = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockRequireDM, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSharedLockRequireDM, 1)
		endif
	endif
	
	screenNo = constSharedLockInformationScreen
	
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
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:ID " + sharedLocks[sharedLockSelected, 0].shareID$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	startScrollBarY# = elementY# - 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// LOCK NAME
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockName, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock Name;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText: ;supportingTextColor:41,128,185,255")
		OryUIUpdateTextfield(editBoxSharedLockName, "position:" + str((screenNo * 100) + 5) + "," + str(elementY# + 5) + ";maxLength:25;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
	endif
	OryUIInsertTextFieldListener(editBoxSharedLockName)
	if (OryUIGetTextfieldTrailingIconReleased(editBoxSharedLockName))
		OryUISetTextfieldString(editBoxSharedLockName, "")
		SetEditBoxFocus(OryUITextfieldCollection[editBoxSharedLockName].editBox, 0)
	endif
	if (OryUIGetTextfieldHasFocus(editBoxSharedLockName) = 0 and OryUIGetTextfieldString(editBoxSharedLockName) <> sharedLocks[sharedLockSelected, 0].lockName$)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockName) + 5
	
	// QR CODE URL
	if (len(sharedLocks[sharedLockSelected, 0].shareID$) = 15)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockQRCodeURL, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock URL;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText: ;supportingTextColorID:" + str(colorMode[colorModeSelected].urlColor))
			OryUIUpdateButton(btnSharedLockQRCodeURL, "text:" + ReplaceString(constAppMarketingDomain$, "https://", "", -1) + "/sharedlock/" + sharedLocks[sharedLockSelected, 0].shareID$ + ";position:" + str((screenNo * 100) + 3) + "," + str(elementY# + 3.5) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColor:41,128,185,255;textSize:2.5")
		endif
		if (OryUIGetButtonReleased(btnSharedLockQRCodeURL))
			OpenBrowser(constAppMarketingDomain$ + "/sharedlock/" + sharedLocks[sharedLockSelected, 0].shareID$)
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockQRCodeURL)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockQRCodeURL, "position:-1000,-1000")
			OryUIUpdateButton(btnSharedLockQRCodeURL, "position:-1000,-1000")
		endif
	endif
	
	// LOCK CONFIGURATION
	if (redrawScreen = 1)
		loadingSharedLock = 0
		sharedLockSettings$ as string : sharedLockSettings$ = BuildSharedLockSettingsString()
		OryUIUpdateTextCard(crdSharedLockConfiguration, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock Configuration;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLockSettings$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextAlignment:center")
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockConfiguration)

	// TEMPORARILY DISABLE LOCK?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdTemporarilyDisable, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpTemporarilyDisable) = "Yes")
			temporarilyDisabled = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpTemporarilyDisable) = "No")
			temporarilyDisabled = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdTemporarilyDisable)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpTemporarilyDisable, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpTemporarilyDisable)
	if (OryUIGetButtonGroupItemReleasedIndex(grpTemporarilyDisable) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpTemporarilyDisable) + 2
	if (temporarilyDisabled <> sharedLocks[sharedLockSelected, 0].temporarilyDisabled)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	
	// SHARE IN APP API
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdShareInAPI, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpShareInAPI) = "Yes")
			shareInAPI = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpShareInAPI) = "No")
			shareInAPI = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdShareInAPI)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpShareInAPI, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpShareInAPI)
	if (OryUIGetButtonGroupItemReleasedIndex(grpShareInAPI) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpShareInAPI) + 2
	if (shareInAPI <> sharedLocks[sharedLockSelected, 0].shareInAPI)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	// HIDE CARD INFORMATION?
	//if (VersionCompare(sharedLocks[sharedLockSelected, 0].minVersionRequired$, "2.4.0 alpha 1") >= 0 and sharedLocks[sharedLockSelected, 0].fixed = 0)
	if (sharedLocks[sharedLockSelected, 0].fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockShowCardInformation, "supportingText:If hidden, all new locks loaded will have the card information hidden.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockShowCardInformation) = "Yes")
				cardInfoHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockShowCardInformation) = "No")
				cardInfoHidden = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockShowCardInformation)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockShowCardInformation, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockShowCardInformation)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockShowCardInformation) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockShowCardInformation) + 2
		if (cardInfoHidden <> sharedLocks[sharedLockSelected, 0].cardInfoHidden)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			cardInfoHidden = sharedLocks[sharedLockSelected, 0].cardInfoHidden
			OryUIUpdateTextCard(crdSharedLockShowCardInformation, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockShowCardInformation, "position:-1000,-1000")
		endif
	endif

	// HIDE TIMER?
	if (sharedLocks[sharedLockSelected, 0].fixed = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockHideTimer, "supportingText:If hidden, all new locks loaded will have the timer hidden.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockHideTimer) = "Yes")
				timerHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockHideTimer) = "No")
				timerHidden = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockHideTimer)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockHideTimer, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockHideTimer)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockHideTimer) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockHideTimer) + 2
		if (timerHidden <> sharedLocks[sharedLockSelected, 0].timerHidden)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			timerHidden = sharedLocks[sharedLockSelected, 0].timerHidden
			OryUIUpdateTextCard(crdSharedLockHideTimer, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockHideTimer, "position:-1000,-1000")
		endif
	endif

	// CREATE FAKE COMBINATION?
	showFakeCombinationOptions = 0
	if (sharedLocks[sharedLockSelected, 0].fixed = 0) then showFakeCombinationOptions = 1
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].minRandomReds <> sharedLocks[sharedLockSelected, 0].maxRandomReds) then showFakeCombinationOptions = 1
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].minRandomMinutes <> sharedLocks[sharedLockSelected, 0].maxRandomMinutes) then showFakeCombinationOptions = 1
	if (showFakeCombinationOptions = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockCreateFakeCombination, "headerText:Allow copies with fake combinations?;supportingText:Multiple copies of this lock can be created when new locks are loaded, each with a fake combination. They won't know which one is real or fake until they try the combination.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockCreateFakeCombination)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockCreateFakeCombination, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockCreateFakeCombination) = "Yes")
				createCopies = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockCreateFakeCombination) = "No")
				createCopies = 0
			endif
		endif
		OryUIInsertButtonGroupListener(grpSharedLockCreateFakeCombination)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockCreateFakeCombination) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockCreateFakeCombination) + 2
		if (createCopies = 1 and sharedLocks[sharedLockSelected, 0].maxRandomCopies = 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		elseif (createCopies = 0 and sharedLocks[sharedLockSelected, 0].maxRandomCopies > 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			createCopies = 0
			OryUIUpdateTextCard(crdSharedLockCreateFakeCombination, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockCreateFakeCombination, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF FAKE COMBINATION COPIES?
	if (createCopies = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockNumberOfFakeCombinationCopies, "headerText:Number of fake combination copies?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockNumberOfFakeCombinationCopies)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockMinNumberOfFakeCombinationCopies) = 0 and OryUIGetInputSpinnerHasFocus(spinSharedLockMaxNumberOfFakeCombinationCopies) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinSharedLockMaxNumberOfFakeCombinationCopies))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinSharedLockMinNumberOfFakeCombinationCopies))
		endif
		if (inputSpinner2Min = 0) then inputSpinner2Min = 1
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockMinNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtSharedLockNumberOfFakeCombinationCopiesTo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 0.5) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinSharedLockMinNumberOfFakeCombinationCopies, "min:0;max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfFakeCombinationCopies, "min:" + str(inputSpinner2Min) + ";max:19;step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockMinNumberOfFakeCombinationCopies) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockMinNumberOfFakeCombinationCopies)
		OryUIInsertInputSpinnerListener(spinSharedLockMaxNumberOfFakeCombinationCopies)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockMinNumberOfFakeCombinationCopies) or OryUIGetInputSpinnerHasFocus(spinSharedLockMaxNumberOfFakeCombinationCopies))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockNumberOfFakeCombinationCopies) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minCopies = val(OryUIGetInputSpinnerString(spinSharedLockMinNumberOfFakeCombinationCopies))
		maxCopies = val(OryUIGetInputSpinnerString(spinSharedLockMaxNumberOfFakeCombinationCopies))
		if (minCopies <> sharedLocks[sharedLockSelected, 0].minRandomCopies)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		elseif (maxCopies <> sharedLocks[sharedLockSelected, 0].maxRandomCopies)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			if (createCopies = 1)
				minCopies = sharedLocks[sharedLockSelected, 0].minRandomCopies
				maxCopies = sharedLocks[sharedLockSelected, 0].maxRandomCopies
			else
				minCopies = 0
				maxCopies = 0
			endif
			OryUIUpdateTextCard(crdSharedLockNumberOfFakeCombinationCopies, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockMinNumberOfFakeCombinationCopies, "position:-1000,-1000")
			OryUIUpdateText(txtSharedLockNumberOfFakeCombinationCopiesTo, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfFakeCombinationCopies, "position:-1000,-1000")
		endif
	endif
	
	// SCHEDULE AUTO RESETS?
	if (sharedLocks[sharedLockSelected, 0].fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockScheduleAutoResets, "supportingText:If yes, you will be able to set how often the lock resets. The reset will act like a keyholder reset which resets all card counts including double up and reset cards.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockScheduleAutoResets) = "Yes")
				autoResetLock = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockScheduleAutoResets) = "No")
				autoResetLock = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockScheduleAutoResets)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockScheduleAutoResets, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockScheduleAutoResets)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockScheduleAutoResets) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		if (autoResetLock = 0 and sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds > 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		elseif (autoResetLock = 1 and sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds = 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockScheduleAutoResets) + 2
	else
		if (redrawScreen = 1)
			autoResetLock = 0
			OryUIUpdateTextCard(crdSharedLockScheduleAutoResets, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockScheduleAutoResets, "position:-1000,-1000")
		endif
	endif

	// RESET FREQUENCY
	if (sharedLocks[sharedLockSelected, 0].fixed = 0 and autoResetLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockResetFrequency, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockResetFrequency)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockResetFrequency, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtSharedLockResetFrequency, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinSharedLockResetFrequency) + (OryUIGetInputSpinnerHeight(spinSharedLockResetFrequency) / 2) - (GetTextTotalHeight(txtSharedLockResetFrequency) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (sharedLocks[sharedLockSelected, 0].regularity# >= 1) then OryUIUpdateText(txtSharedLockResetFrequency, "size:3")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 0.5) then OryUIUpdateText(txtSharedLockResetFrequency, "size:2.5")
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockResetFrequency) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockResetFrequency)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockResetFrequency))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockResetFrequency) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 86400
		if (sharedLocks[sharedLockSelected, 0].regularity# = 12) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 43200
		if (sharedLocks[sharedLockSelected, 0].regularity# = 6) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 21600
		if (sharedLocks[sharedLockSelected, 0].regularity# = 3) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 10800
		if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 3600
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 1800
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 900
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then resetFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockResetFrequency)) * 60
		if (resetFrequencyInSeconds <> sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
		OryUIUpdateText(txtSharedLockResetFrequency, "text:Every " + ConvertSecondsToText(resetFrequencyInSeconds, 1))
	else
		if (redrawScreen = 1)
			resetFrequencyInSeconds = 0
			OryUIUpdateTextCard(crdSharedLockResetFrequency, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockResetFrequency, "position:-1000,-1000")
			OryUIUpdateText(txtSharedLockResetFrequency, "position:-1000,-1000")
		endif
	endif
	
	// MAXIMUM NUMBER OF AUTO RESETS?
	if (sharedLocks[sharedLockSelected, 0].fixed = 0 and autoResetLock = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockMaxNumberOfAutoResets, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockMaxNumberOfAutoResets)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfAutoResets, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockMaxNumberOfAutoResets) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockMaxNumberOfAutoResets)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockMaxNumberOfAutoResets))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockMaxNumberOfAutoResets) - GetSpriteY(screen[screenNo].sprPage))
		endif
		maxAutoResets = val(OryUIGetInputSpinnerString(spinSharedLockMaxNumberOfAutoResets))
		if (maxAutoResets <> sharedLocks[sharedLockSelected, 0].maxAutoResets)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			maxAutoResets = 0
			OryUIUpdateTextCard(crdSharedLockMaxNumberOfAutoResets, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockMaxNumberOfAutoResets, "position:-1000,-1000")
		endif
	endif

	// CHECK-INS REQUIRED?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockCheckInsRequired, "supportingText:If yes, you will be able to set how often they need to check-in. Check-ins will be logged so that you can see if they checked in early or late. How you act on these check-ins is up to you. The app doesn't do anything but track/record them.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockCheckInsRequired) = "Yes")
			checkInsRequired = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockCheckInsRequired) = "No")
			checkInsRequired = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockCheckInsRequired)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockCheckInsRequired, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockCheckInsRequired)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockCheckInsRequired) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	if (checkInsRequired = 0 and sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	elseif (checkInsRequired = 1 and sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds = 0)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockCheckInsRequired) + 2

	// AGREE TO CHECK-IN CHANGE?
	if (checkInsRequired = 1 and sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0 and sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockAgreeToCheckInChange, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockAgreeToCheckInChange) = "Yes")
				agreeToCheckInChange = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockAgreeToCheckInChange) = "No")
				agreeToCheckInChange = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockAgreeToCheckInChange)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockAgreeToCheckInChange, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockAgreeToCheckInChange)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockAgreeToCheckInChange) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		if (checkInsRequired = 0 and sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		elseif (checkInsRequired = 1 and sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds = 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockAgreeToCheckInChange) + 2
	else
		agreeToCheckInChange = 1
		OryUIUpdateTextCard(crdSharedLockAgreeToCheckInChange, "position:-1000,-1000")
		OryUIUpdateButtonGroup(grpSharedLockAgreeToCheckInChange, "position:-1000,-1000")
	endif
	if (sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds > 0) then agreeToCheckInChange = 1

	// CHECK IN FREQUENCY
	if (checkInsRequired = 1 and agreeToCheckInChange = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockCheckInFrequency, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockCheckInFrequency)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockCheckInFrequency, "min:2;max:426;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtSharedLockCheckInFrequency, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinSharedLockCheckInFrequency) + (OryUIGetInputSpinnerHeight(spinSharedLockCheckInFrequency) / 2) - (GetTextTotalHeight(txtSharedLockCheckInFrequency) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (sharedLocks[sharedLockSelected, 0].regularity# >= 1 or sharedLocks[sharedLockSelected, 0].fixed = 1) then OryUIUpdateText(txtSharedLockCheckInFrequency, "size:3")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 0.5 and sharedLocks[sharedLockSelected, 0].fixed = 0) then OryUIUpdateText(txtSharedLockCheckInFrequency, "size:2.5")
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockCheckInFrequency) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockCheckInFrequency)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockCheckInFrequency))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockCheckInFrequency) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) < 4)
			checkInFrequencyInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) * 900
		elseif (val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) < 52) // 28
			checkInFrequencyInSeconds = (val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) - 3) * 3600
		else
			checkInFrequencyInSeconds = (val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) - 49) * 86400 // 27
		endif
		if (checkInFrequencyInSeconds <> sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
		OryUIUpdateText(txtSharedLockCheckInFrequency, "text:Every " + ConvertSecondsToText(checkInFrequencyInSeconds, 1))
	else
		if (redrawScreen = 1)
			checkInFrequencyInSeconds = 0
			OryUIUpdateTextCard(crdSharedLockCheckInFrequency, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockCheckInFrequency, "position:-1000,-1000")
			OryUIUpdateText(txtSharedLockCheckInFrequency, "position:-1000,-1000")
		endif
	endif
	
	// LATE CHECK-INS
	if (checkInsRequired = 1 and agreeToCheckInChange = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockLateCheckIns, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockLateCheckIns)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockLateCheckIns, "min:1;max:426;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateText(txtSharedLockLateCheckIns, "position:" + str((screenNo * 100) + 50) + "," + str(OryUIGetInputSpinnerY(spinSharedLockLateCheckIns) + (OryUIGetInputSpinnerHeight(spinSharedLockLateCheckIns) / 2) - (GetTextTotalHeight(txtSharedLockLateCheckIns) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			if (sharedLocks[sharedLockSelected, 0].regularity# >= 1 or fixed = 1) then OryUIUpdateText(txtSharedLockLateCheckIns, "size:3")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 0.5 and fixed = 0) then OryUIUpdateText(txtSharedLockLateCheckIns, "size:2.5")
		endif
		OryUIUpdateInputSpinner(spinSharedLockLateCheckIns, "max:" + str(val(OryUIGetInputSpinnerString(spinSharedLockCheckInFrequency)) - 1, 0))
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockLateCheckIns) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockLateCheckIns)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockLateCheckIns))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockLateCheckIns) - GetSpriteY(screen[screenNo].sprPage))
		endif
		if (val(OryUIGetInputSpinnerString(spinSharedLockLateCheckIns)) < 4)
			lateCheckInWindowInSeconds = val(OryUIGetInputSpinnerString(spinSharedLockLateCheckIns)) * 900
		elseif (val(OryUIGetInputSpinnerString(spinSharedLockLateCheckIns)) < 52) // 28
			lateCheckInWindowInSeconds = (val(OryUIGetInputSpinnerString(spinSharedLockLateCheckIns)) - 3) * 3600
		else
			lateCheckInWindowInSeconds = (val(OryUIGetInputSpinnerString(spinSharedLockLateCheckIns)) - 49) * 86400 // 27
		endif
		if (lateCheckInWindowInSeconds <> sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
		OryUIUpdateText(txtSharedLockLateCheckIns, "text:Every " + ConvertSecondsToText(lateCheckInWindowInSeconds, 1))
	else
		if (redrawScreen = 1)
			lateCheckInWindowInSeconds = 0
			OryUIUpdateTextCard(crdSharedLockLateCheckIns, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockLateCheckIns, "position:-1000,-1000")
			OryUIUpdateText(txtSharedLockLateCheckIns, "position:-1000,-1000")
		endif
	endif

	// ENABLE EARLY RELEASE WITH A PURCHASED KEY
	if (sharedLocks[sharedLockSelected, 0].keyDisabled = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockEnableEarlyReleaseWithAPurchasedKey, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockEnableEarlyReleaseWithAPurchasedKey) = "Yes")
				keyDisabled = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockEnableEarlyReleaseWithAPurchasedKey) = "No")
				keyDisabled = 1
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockEnableEarlyReleaseWithAPurchasedKey)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockEnableEarlyReleaseWithAPurchasedKey)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockEnableEarlyReleaseWithAPurchasedKey) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockEnableEarlyReleaseWithAPurchasedKey) + 2
		if (keyDisabled <> sharedLocks[sharedLockSelected, 0].keyDisabled)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			keyDisabled = sharedLocks[sharedLockSelected, 0].keyDisabled
			OryUIUpdateTextCard(crdSharedLockEnableEarlyReleaseWithAPurchasedKey, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, "position:-1000,-1000")
		endif
	endif
	
	// START LOCK FROZEN
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockStartLockFrozen, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockStartLockFrozen) = "Yes")
			startLockFrozen = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockStartLockFrozen) = "No")
			startLockFrozen = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockStartLockFrozen)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockStartLockFrozen, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockStartLockFrozen)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockStartLockFrozen) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockStartLockFrozen) + 2
	if (startLockFrozen <> sharedLocks[sharedLockSelected, 0].startLockFrozen)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	
	// DISABLE KEYHOLDER DECISION AT END OF LOCK
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockDisableKeyholderDecision, "supportingText:If disabled, they will not have the option at the end of the lock to ask for your decision as to whether the combination is revealed, or the lock is reset. If you're running this as a short lock for scenarios that might be considered dangerous, and worried that you might not always be available to make the decision when they request it, then it's a good idea to disable it.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockDisableKeyholderDecision) = "Yes")
			keyholderDecisionDisabled = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockDisableKeyholderDecision) = "No")
			keyholderDecisionDisabled = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockDisableKeyholderDecision)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockDisableKeyholderDecision, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockDisableKeyholderDecision)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockDisableKeyholderDecision) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockDisableKeyholderDecision) + 2
	if (keyholderDecisionDisabled <> sharedLocks[sharedLockSelected, 0].keyholderDecisionDisabled)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	// LIMIT THE NUMBER OF USERS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockLimitNumberOfUsers, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockLimitNumberOfUsers) = "Yes")
			limitUsers = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockLimitNumberOfUsers) = "No")
			limitUsers = 0
			maxUsers = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockLimitNumberOfUsers)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockLimitNumberOfUsers, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockLimitNumberOfUsers)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockLimitNumberOfUsers) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockLimitNumberOfUsers) + 2
	if (limitUsers = 1 and sharedLocks[sharedLockSelected, 0].maxUsers = 0)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	elseif (limitUsers = 0 and sharedLocks[sharedLockSelected, 0].maxUsers > 0)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	// MAXIMUM NUMBER OF USERS?
	if (limitUsers = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockMaximumNumberOfUsers, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockMaximumNumberOfUsers)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockMaximumNumberOfUsers, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockMaximumNumberOfUsers) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockMaximumNumberOfUsers)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockMaximumNumberOfUsers))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockMaximumNumberOfUsers) - GetSpriteY(screen[screenNo].sprPage))
		endif
		maxUsers = val(OryUIGetInputSpinnerString(spinSharedLockMaximumNumberOfUsers))
		if (maxUsers <> sharedLocks[sharedLockSelected, 0].maxUsers)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockMaximumNumberOfUsers, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockMaximumNumberOfUsers, "position:-1000,-1000")
		endif
	endif
	
	// BLOCK TEST LOCKS?
	if ((sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 0].regularity# >= 0.25) or sharedLocks[sharedLockSelected, 0].fixed = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockBlockTestLocks, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockTestLocks) = "Yes")
				blockTestLocks = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockTestLocks) = "No")
				blockTestLocks = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockBlockTestLocks)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSharedLockBlockTestLocks, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSharedLockBlockTestLocks)
		if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockBlockTestLocks) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSharedLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockBlockTestLocks) + 2
		if (blockTestLocks = 1 and sharedLocks[sharedLockSelected, 0].blockTestLocks = 0)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		elseif (blockTestLocks = 0 and sharedLocks[sharedLockSelected, 0].blockTestLocks = 1)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif	
	else
		if (redrawScreen = 1)
			blockTestLocks = 0
			OryUIUpdateTextCard(crdSharedLockBlockTestLocks, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSharedLockBlockTestLocks, "inputText:1;position:-1000,-1000")
		endif
	endif
	
	// BLOCK USERS WITH A SPECIFIC RATING?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockBlockUsersWithSpecificRating, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersWithSpecificRating) = "Yes")
			blockUsersWithSpecificRating = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersWithSpecificRating) = "No")
			blockUsersWithSpecificRating = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockBlockUsersWithSpecificRating)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockBlockUsersWithSpecificRating, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockBlockUsersWithSpecificRating)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockBlockUsersWithSpecificRating) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockBlockUsersWithSpecificRating) + 2
	if (blockUsersWithSpecificRating = 1 and sharedLocks[sharedLockSelected, 0].minRatingRequired = 0)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	elseif (blockUsersWithSpecificRating = 0 and sharedLocks[sharedLockSelected, 0].minRatingRequired > 1)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	
	// MINIMUM RATING REQUIRED?
	if (blockUsersWithSpecificRating = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSharedLockMinimumRatingRequired, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockMinimumRatingRequired)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinSharedLockMinimumRatingRequired, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinSharedLockMinimumRatingRequired) + 2
		OryUIInsertInputSpinnerListener(spinSharedLockMinimumRatingRequired)
		if (OryUIGetInputSpinnerHasFocus(spinSharedLockMinimumRatingRequired))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdSharedLockMinimumRatingRequired) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minRatingRequired = val(OryUIGetInputSpinnerString(spinSharedLockMinimumRatingRequired))
		if (minRatingRequired <> sharedLocks[sharedLockSelected, 0].minRatingRequired)
			OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
		endif
	else
		if (redrawScreen = 1)
			minRatingRequired = 0
			OryUIUpdateTextCard(crdSharedLockMinimumRatingRequired, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinSharedLockMinimumRatingRequired, "inputText:1;position:-1000,-1000")
		endif
	endif
	
	// BLOCK USERS ALREADY LOCKED?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockBlockUsersAlreadyLocked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersAlreadyLocked) = "Yes")
			blockUsersAlreadyLocked = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersAlreadyLocked) = "No")
			blockUsersAlreadyLocked = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockBlockUsersAlreadyLocked)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockBlockUsersAlreadyLocked, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockBlockUsersAlreadyLocked)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockBlockUsersAlreadyLocked) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockBlockUsersAlreadyLocked) + 2
	if (blockUsersAlreadyLocked <> sharedLocks[sharedLockSelected, 0].blockUsersAlreadyLocked)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	// BLOCK USERS WITH STATS HIDDEN?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockBlockUsersWithStatsHidden, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersWithStatsHidden) = "Yes")
			blockUsersWithStatsHidden = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockBlockUsersWithStatsHidden) = "No")
			blockUsersWithStatsHidden = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockBlockUsersWithStatsHidden)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockBlockUsersWithStatsHidden, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockBlockUsersWithStatsHidden)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockBlockUsersWithStatsHidden) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockBlockUsersWithStatsHidden) + 2
	if (blockUsersWithStatsHidden <> sharedLocks[sharedLockSelected, 0].blockUsersWithStatsHidden)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif
	
	// FORCE TRUST?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockForceTrust, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockForceTrust) = "Yes")
			forceTrust = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockForceTrust) = "No")
			forceTrust = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockForceTrust)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockForceTrust, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockForceTrust)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockForceTrust) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockForceTrust) + 2
	if (forceTrust <> sharedLocks[sharedLockSelected, 0].forceTrust)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	// REQUIRE DM BEFORE LOADING
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSharedLockRequireDM, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockRequireDM) = "Yes")
			requireDM = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpSharedLockRequireDM) = "No")
			requireDM = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSharedLockRequireDM)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSharedLockRequireDM, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSharedLockRequireDM)
	if (OryUIGetButtonGroupItemReleasedIndex(grpSharedLockRequireDM) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSharedLockRequireDM) + 2
	if (requireDM <> sharedLocks[sharedLockSelected, 0].requireDM)
		OryUIShowFloatingActionButton(fabSaveSharedLockInformation)
	endif

	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveSharedLockInformation, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	// SAVE BUTTON
	if (OryUIGetFloatingActionButtonReleased(fabSaveSharedLockInformation))
		validName as integer : validName = 1
		newLockName$ = sharedLocks[sharedLockSelected, 0].lockName$
		if (OryUIGetTextfieldString(editBoxSharedLockName) <> sharedLocks[sharedLockSelected, 0].lockName$)
			if (FindString(OryUIGetTextfieldString(editBoxSharedLockName), "&") or FindString(OryUIGetTextfieldString(editBoxSharedLockName), "="))
				validName = 0
				newLockName$ = OryUIGetTextfieldString(editBoxSharedLockName)
				newLockName$ = ReplaceString(newLockName$, "&", "", -1)
				newLockName$ = ReplaceString(newLockName$, "=", "", -1)
				OryUIUpdateTextfield(editBoxSharedLockName, "inputText:" + newLockName$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Lock Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Lock names can't contain the following characters[colon] & and =." + chr(10) + chr(10) + "For your convenience all instances of these characters have been removed (but not yet saved).;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (len(OryUIGetTextfieldString(editBoxSharedLockName)) > 25)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Lock Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Lock names should be less than 26 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
				validName = 0
			else
				newLockName$ = OryUIGetTextfieldString(editBoxSharedLockName)
			endif
		endif
		if (validName = 1)
			//2.3.0
			newMinVersionRequired$ as string : newMinVersionRequired$ = "2.3.0"
			if (sharedLocks[sharedLockSelected, 0].minRandomResets > 0 or sharedLocks[sharedLockSelected, 0].maxRandomResets > 0) then newMinVersionRequired$ = "2.3.0"
			//2.3.4
			if (sharedLocks[sharedLockSelected, 0].minRandomGreens > 1 or sharedLocks[sharedLockSelected, 0].maxRandomGreens > 1) then newMinVersionRequired$ = "2.3.4"
			if (sharedLocks[sharedLockSelected, 0].minRandomDoubleUps > 0 or sharedLocks[sharedLockSelected, 0].maxRandomDoubleUps > 0) then newMinVersionRequired$ = "2.3.4"
			if (sharedLocks[sharedLockSelected, 0].multipleGreensRequired = 1) then newMinVersionRequired$ = "2.3.4"
			//2.4.0
			if (cardInfoHidden = 1) then newMinVersionRequired$ = "2.4.0"
			if (sharedLocks[sharedLockSelected, 0].maxRandomYellowsAdd > 0) then newMinVersionRequired$ = "2.4.0"
			if (sharedLocks[sharedLockSelected, 0].maxRandomYellowsMinus > 0) then newMinVersionRequired$ = "2.4.0"
			if (sharedLocks[sharedLockSelected, 0].minRandomFreezes > 0 or sharedLocks[sharedLockSelected, 0].maxRandomFreezes > 0) then newMinVersionRequired$ = "2.4.0"
			if (maxUsers > 0) then newMinVersionRequired$ = "2.4.0"
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5 or (sharedLocks[sharedLockSelected, 0].regularity# > 1 and sharedLocks[sharedLockSelected, 0].regularity# < 24)) then newMinVersionRequired$ = "2.4.0"
			if (blockUsersAlreadyLocked = 1) then newMinVersionRequired$ = "2.4.0"
			//2.5.0
			if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].build >= 134) then newMinVersionRequired$ = "2.5.0"
			if (minCopies > 0) then newMinVersionRequired$ = "2.5.0"
			if (requireDM = 1) then newMinVersionRequired$ = "2.5.0"
			if (blockUsersWithStatsHidden = 1) then newMinVersionRequired$ = "2.5.0"
			//2.5.2
			if (keyholderDecisionDisabled = 1) then newMinVersionRequired$ = "2.5.2"
			if (maxAutoResets > 0) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomDoubleUps > 20 or sharedLocks[sharedLockSelected, 0].maxRandomDoubleUps > 20) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomFreezes > 20 or sharedLocks[sharedLockSelected, 0].maxRandomFreezes > 20) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomGreens > 20 or sharedLocks[sharedLockSelected, 0].maxRandomGreens > 20) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomReds > 399 or sharedLocks[sharedLockSelected, 0].maxRandomReds > 399) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomResets > 20 or sharedLocks[sharedLockSelected, 0].maxRandomResets > 399) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomYellows > 200 or sharedLocks[sharedLockSelected, 0].maxRandomYellows > 200) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomYellowsAdd > 200 or sharedLocks[sharedLockSelected, 0].maxRandomYellowsAdd > 200) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRandomYellowsMinus > 200 or sharedLocks[sharedLockSelected, 0].maxRandomYellowsMinus > 200) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].minRatingRequired = 1) then newMinVersionRequired$ = "2.5.2"
			if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then newMinVersionRequired$ = "2.5.2"
			//2.5.3
			if (sharedLocks[sharedLockSelected, 0].minRandomStickies > 0 or sharedLocks[sharedLockSelected, 0].maxRandomStickies > 0) then newMinVersionRequired$ = "2.5.3"
			//2.5.4
			if (sharedLocks[sharedLockSelected, 0].minRandomStickies > 30 or sharedLocks[sharedLockSelected, 0].maxRandomStickies > 30) then newMinVersionRequired$ = "2.5.4"
			if (sharedLocks[sharedLockSelected, 0].minRandomDoubleUps > 30 or sharedLocks[sharedLockSelected, 0].maxRandomDoubleUps > 30) then newMinVersionRequired$ = "2.5.4"
			if (sharedLocks[sharedLockSelected, 0].minRandomFreezes > 30 or sharedLocks[sharedLockSelected, 0].maxRandomFreezes > 30) then newMinVersionRequired$ = "2.5.4"
			if (sharedLocks[sharedLockSelected, 0].minRandomGreens > 30 or sharedLocks[sharedLockSelected, 0].maxRandomGreens > 30) then newMinVersionRequired$ = "2.5.4"
			if (sharedLocks[sharedLockSelected, 0].minRandomResets > 30 or sharedLocks[sharedLockSelected, 0].maxRandomResets > 30) then newMinVersionRequired$ = "2.5.4"		
			//2.6.2
			if (startLockFrozen = 1) then newMinVersionRequired$ = "2.6.2"
			//2.6.3
			if (checkInFrequencyInSeconds > 0) then newMinVersionRequired$ = "2.6.3"
			//2.6.5
			if (temporarilyDisabled > 0) then newMinVersionRequired$ = "2.6.5"
			//2.6.8
			if (lateCheckInWindowInSeconds > 0) then newMinVersionRequired$ = "2.6.8"
			
			if (newMinVersionRequired$ <> sharedLocks[sharedLockSelected, 0].minVersionRequired$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Changing Minimum Version Required;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The minimum version of " + constAppName$ + " required to load this lock would be changing from version " + sharedLocks[sharedLockSelected, 0].minVersionRequired$ + " to version " + newMinVersionRequired$ + chr(10) + chr(10) + "Do you want to make these changes?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesChangeSharedLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)	
			else
				UpdateSharedLock(sharedLockSelected, 0)
			endif
		endif
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesChangeSharedLock"))
		UpdateSharedLock(sharedLockSelected, 0)
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
