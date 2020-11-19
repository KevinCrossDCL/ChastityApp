
OryUIHideFloatingActionButton(fabSaveUsersLockInformation)
if (screenToView = constUsersLockInformationScreen)
	// RESET OPTIONS WHEN FIRST COMING TO THE SCREEN
	if (screenNo <> constUsersLockInformationScreen)
		if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpUsersPauseAutoResets, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpUsersPauseAutoResets, 1)
		endif
		if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpUsersToggleCumulative, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpUsersToggleCumulative, 1)
		endif
	endif
	
	screenNo = constUsersLockInformationScreen
	
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
		if (sharedLocks[sharedLockSelected, 0].lockName$ <> "")
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:" + sharedLocks[sharedLockSelected, 0].lockName$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		else
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:ID " + sharedLocks[sharedLockSelected, 0].shareID$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		endif
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
	endif
	updateTabVisible = 0
	infoTabVisible = 1
	logTabVisible = 0
	tabCounter = 0
	allowModification = 0
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTrustKeyholder[userSelected] = 0)
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.25)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 300) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.5)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 900) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 1800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 3)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 6)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 10800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 12)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 21600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 24)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 43200) then allowModification = 1
		endif
	else
		allowModification = 1
	endif
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReadyToUnlock[userSelected] = 1) then allowModification = 0
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReadyToUnlock[userSelected] = 0 and allowModification = 1) then updateTabVisible = 1
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersBuildNumberInstalled[userSelected] >= 134) then logTabVisible = 1
	noOfTabs = updateTabVisible + infoTabVisible + logTabVisible
	OryUISetTabsButtonCount(screen[screenNo].tabs, noOfTabs)
	OryUISetTabsButtonSelectedByName(screen[screenNo].tabs, "Info")
	if (updateTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Update;text:Update")
	endif
	if (infoTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Info;text:Info")
	endif
	if (logTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Log;text:Log")
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Update")
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		SetScreenToView(constUsersLockUpdateScreen)
	endif
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Info")
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		SetScreenToView(constUsersLockInformationScreen)
	endif
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Log")
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		GetUserLog(sharedLockSelected, userSelected, selectedManageUsersTab, 1)
		SetScreenToView(constUsersLockLogScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	startScrollBarY# = elementY# + 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = elementY# + 2
	
	// USERNAME
	if (redrawScreen = 1)
		SetUsernameColorArray(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMainRole[userSelected], sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMainRoleLevel[userSelected])
		OryUIUpdateText(txtUsersLockUsername, "text:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected] + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:" + str(usernameColor[0]) + "," + str(usernameColor[1]) + "," + str(usernameColor[2]) + "," + str(usernameColor[3]))
		OryUIUpdateSprite(sprUsersLockUsernameButton, "size:" + str(GetTextTotalWidth(txtUsersLockUsername)) + "," + str(GetTextTotalHeight(txtUsersLockUsername)) + ";offset:center;position:" + str(GetTextX(txtUsersLockUsername)) + "," + str(GetTextY(txtUsersLockUsername) + (GetTextTotalHeight(txtUsersLockUsername) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtUsersLockUsername)
	
	// COMBINATION
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCombination$[userSelected] <> "")
		if (redrawScreen = 1)
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFakeLock[userSelected] = 1)
				fakeCombination$ = " (Fake)"
			else
				fakeCombination$ = ""
			endif
			OryUIUpdateTextCard(crdUsersLockCombination, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCombination$[userSelected] + fakeCombination$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		if (GetTextHitTest(OryUITextCardCollection[crdUsersLockCombination].txtSupportingText, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) and oryUIScrimVisible = 0)
			OryUIUpdateButton(btnCopyText, "position:" + str((screenNo * 100) + 50) + "," + str(GetTextY(OryUITextCardCollection[crdUsersLockCombination].txtSupportingText) - 2))
			timeShownBtnCopyText# = timer()
		endif
		if (OryUIGetButtonReleased(btnCopyText))
			SetClipboardText(GetTextString(OryUITextCardCollection[crdUsersLockCombination].txtSupportingText))
			OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
			OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
			OryUIShowTooltip(tooltip, (screenNo * 100) + 50, GetViewOffsetY() + screenBoundsTop# + 80)
		elseif (OryUIGetSpriteReleased() = screen[screenNo].sprPage)
			OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
		endif	
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockCombination)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockCombination, "position:-1000,-1000")
		endif
	endif
	
	// TIME LOCKED
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	dateLockedSince$ as string : dateLockedSince$ = ""
	if (selectedManageUsersTab = 1)
		secondsLocked = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
		dateLockedSince$ = chr(10) + "Locked " + ReformatDateString(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDateLocked$[userSelected], "DD/MM/YYYY", dateFormat$)
	elseif (selectedManageUsersTab = 2)
		secondsLocked = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnlocked[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
		dateLockedSince$ = ""
	else
		secondsLocked = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampDeleted[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
		dateLockedSince$ = ""
	endif
	dd = floor(secondsLocked / 60 / 60 / 24)
	hh = floor(mod(secondsLocked / 60 / 60, 24))
	mm = floor(mod(secondsLocked / 60, 60))
	ss = floor(mod(secondsLocked, 60))
	if (dd > 0)
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "supportingText:Locked for " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" + dateLockedSince$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (hh > 0)
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "supportingText:Locked for " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" + dateLockedSince$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (mm > 0)
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "supportingText:Locked for " + str(mm) + "m " + str(ss) + "s" + dateLockedSince$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (ss >= 0)
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "supportingText:Locked for " + str(ss) + "s" + dateLockedSince$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateTextCard(crdUsersLockTimeLocked, "supportingText:Locked for N/A;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockTimeLocked)
	
	// LAST CHECKED IN
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] > 0)
		if (timestampFromServer > 0)
			local secondsUsersCheckInLate as integer
			local secondsSinceUsersLastCheckIn as integer
			local secondsUntilUsersNextCheckIn as integer
			local userLastCheckedIn$ as string
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[userSelected] = 0)
				secondsSinceUsersLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
				secondsUntilUsersNextCheckIn = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - timestampNow
				if (secondsUntilUsersNextCheckIn > 0)
					dd = floor(secondsUntilUsersNextCheckIn / 60 / 60 / 24)
					hh = floor(mod(secondsUntilUsersNextCheckIn / 60 / 60, 24))
					mm = floor(mod(secondsUntilUsersNextCheckIn / 60, 60))
					ss = floor(mod(secondsUntilUsersNextCheckIn, 60))
					if (dd > 0)
						userLastCheckedIn$ = "First check-in required in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (hh > 0)
						userLastCheckedIn$ = "First check-in required in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (mm > 0)
						userLastCheckedIn$ = "First check-in required in " + str(mm) + "m " + str(ss) + "s"
					elseif (ss >= 0)
						userLastCheckedIn$ = "First check-in required in " + str(ss) + "s"
					endif
				else
					userLastCheckedIn$ = "Awaiting check-in"
					if (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
						if (sharedLocks[sharedLockSelected, 0].fixed = 0)
							secondsUsersCheckInLate = (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - (sharedLocks[sharedLockSelected, 0].regularity# * 3600)
						else
							secondsUsersCheckInLate = (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] / 2)
							if (secondsUsersCheckInLate > 86400) then secondsUsersCheckInLate = 86400
						endif
						dd = floor(secondsUsersCheckInLate / 60 / 60 / 24)
						hh = floor(mod(secondsUsersCheckInLate / 60 / 60, 24))
						mm = floor(mod(secondsUsersCheckInLate / 60, 60))
						ss = floor(mod(secondsUsersCheckInLate, 60))
						if (dd > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (hh > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (mm > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(mm) + "m " + str(ss) + "s late"
						elseif (ss >= 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(ss) + "s late"
						endif
					else
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are not late yet"
					endif 
				endif
			else
				secondsSinceUsersLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[userSelected]
				secondsUntilUsersNextCheckIn = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[userSelected] + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - timestampNow
				dd = floor(secondsSinceUsersLastCheckIn / 60 / 60 / 24)
				hh = floor(mod(secondsSinceUsersLastCheckIn / 60 / 60, 24))
				mm = floor(mod(secondsSinceUsersLastCheckIn / 60, 60))
				ss = floor(mod(secondsSinceUsersLastCheckIn, 60))
				if (dd > 0)
					userLastCheckedIn$ = "Last checked in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago" 
				elseif (hh > 0)
					userLastCheckedIn$ = "Last checked in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago"
				elseif (mm > 0)
					userLastCheckedIn$ = "Last checked in " + str(mm) + "m " + str(ss) + "s ago"
				elseif (ss >= 0)
					userLastCheckedIn$ = "Last checked in " + str(ss) + "s ago"
				endif
				if (secondsUntilUsersNextCheckIn > 0)
					dd = floor(secondsUntilUsersNextCheckIn / 60 / 60 / 24)
					hh = floor(mod(secondsUntilUsersNextCheckIn / 60 / 60, 24))
					mm = floor(mod(secondsUntilUsersNextCheckIn / 60, 60))
					ss = floor(mod(secondsUntilUsersNextCheckIn, 60))
					if (dd > 0)
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "Next check-in required in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" 
					elseif (hh > 0)
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "Next check-in required in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (mm > 0)
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "Next check-in required in " + str(mm) + "m " + str(ss) + "s"
					elseif (ss >= 0)
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "Next check-in required in " + str(ss) + "s"
					endif
				else
					userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "Awaiting check-in"
					if (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
						if (sharedLocks[sharedLockSelected, 0].fixed = 0)
							secondsUsersCheckInLate = (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - (sharedLocks[sharedLockSelected, 0].regularity# * 3600)
						else
							secondsUsersCheckInLate = (secondsSinceUsersLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected]) - (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] / 2)
							if (secondsUsersCheckInLate > 86400) then secondsUsersCheckInLate = 86400
						endif
						dd = floor(secondsUsersCheckInLate / 60 / 60 / 24)
						hh = floor(mod(secondsUsersCheckInLate / 60 / 60, 24))
						mm = floor(mod(secondsUsersCheckInLate / 60, 60))
						ss = floor(mod(secondsUsersCheckInLate, 60))
						if (dd > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (hh > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (mm > 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(mm) + "m " + str(ss) + "s late"
						elseif (ss >= 0)
							userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are " + str(ss) + "s late"
						endif
					else
						userLastCheckedIn$ = userLastCheckedIn$ + chr(10) + "They are not late yet"
					endif 
				endif
			endif
			OryUIUpdateTextCard(crdUsersLastCheckedIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Check-Ins;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + userLastCheckedIn$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdUsersLastCheckedIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Check-Ins;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Requires Server Time;supportingTextColor:192,57,42,255")
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLastCheckedIn)
	else
		OryUIUpdateTextCard(crdUsersLastCheckedIn, "position:-1000,-1000")
	endif
	
	// LAST UPDATED
	if (selectedManageUsersTab = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockLastUpdated, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		secondsLastUpdated as integer : secondsLastUpdated = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected]
		dd = floor(secondsLastUpdated / 60 / 60 / 24)
		hh = floor(mod(secondsLastUpdated / 60 / 60, 24))
		mm = floor(mod(secondsLastUpdated / 60, 60))
		ss = floor(mod(secondsLastUpdated, 60))
		if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] > 0)
			if (dd > 0)
				OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:" + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			elseif (hh > 0)
				OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:" + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			elseif (mm > 0)
				OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:" + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			elseif (ss >= 0)
				OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:" + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:N/A;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		else
			OryUIUpdateTextCard(crdUsersLockLastUpdated, "supportingText:Not yet updated;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockLastUpdated)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockLastUpdated, "position:-1000,-1000")
		endif
	endif
	
	// LAST ONLINE
	if (selectedManageUsersTab = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		secondsLastActive as integer : secondsLastActive = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLastActive[userSelected]
		dd = floor(secondsLastActive / 60 / 60 / 24)
		hh = floor(mod(secondsLastActive / 60 / 60, 24))
		mm = floor(mod(secondsLastActive / 60, 60))
		ss = floor(mod(secondsLastActive, 60))
		if (dd > 0)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "supportingText:" + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (hh > 0)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "supportingText:" + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (mm > 0)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "supportingText:" + str(mm) + "m " + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (ss >= 0)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "supportingText:" + str(ss) + "s ago;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdUsersLockLastOnline, "supportingText:N/A;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockLastOnline)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockLastOnline, "position:-1000,-1000")
		endif
	endif
	
	// LOCK FROZEN
	if (selectedManageUsersTab = 1 and (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[userSelected] = 1 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[userSelected] = 1))
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockFrozen, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText: ;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		frozenBy$ as string : frozenBy$ = ""
		if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[userSelected] = 1)
			secondsFrozen as integer : secondsFrozen = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampFrozenByCard[userSelected]
			secondsUnfreezes as integer : secondsUnfreezes = 0
			frozenBy$ = "Frozen by card "
			if (sharedLocks[sharedLockSelected, 0].fixed = 0)
				secondsUnfreezes = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnfreezes[userSelected] - timestampNow
			else
				secondsUnfreezes = -9
			endif
		else
			secondsFrozen = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampFrozenByKeyholder[userSelected]
			frozenBy$ = "Frozen by you "
			secondsUnfreezes = -9
		endif
		dd = floor(secondsFrozen / 60 / 60 / 24)
		hh = floor(mod(secondsFrozen / 60 / 60, 24))
		mm = floor(mod(secondsFrozen / 60, 60))
		ss = floor(mod(secondsFrozen, 60))
		frozenTime$ as string : frozenTime$ = ""
		if (dd > 0)
			frozenTime$ = frozenBy$ + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago"
		elseif (hh > 0)
			frozenTime$ = frozenBy$ + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago"
		elseif (mm > 0)
			frozenTime$ = frozenBy$ + str(mm) + "m " + str(ss) + "s ago"
		elseif (ss >= 0)
			frozenTime$ = frozenBy$ + str(ss) + "s ago"
		else
			frozenTime$ = "N/A"
		endif
		dd = floor(secondsUnfreezes / 60 / 60 / 24)
		hh = floor(mod(secondsUnfreezes / 60 / 60, 24))
		mm = floor(mod(secondsUnfreezes / 60, 60))
		ss = floor(mod(secondsUnfreezes, 60))
		unfrozenTime$ as string : unfrozenTime$ = ""
		if (dd > 0)
			unfrozenTime$ = chr(10) + "Unfreezes in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
		elseif (hh > 0)
			unfrozenTime$ = chr(10) + "Unfreezes in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
		elseif (mm > 0)
			unfrozenTime$ = chr(10) + "Unfreezes in " + str(mm) + "m " + str(ss) + "s"
		elseif (ss >= 0)
			unfrozenTime$ = chr(10) + "Unfreezes in " + str(ss) + "s"
		else
			unfrozenTime$ = ""
		endif
		OryUIUpdateTextCard(crdUsersLockFrozen, "supportingText:" + frozenTime$ + unfrozenTime$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockFrozen)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockFrozen, "position:-1000,-1000")
		endif
	endif
	
	// RESETS IN
	autoResetPending as integer : autoResetPending = 0
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected] > 0)
		if (timestampFromServer > 0)
			secondsSinceLastReset = 0
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastAutoReset[userSelected] > 0 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastFullReset[userSelected] > 0)
				secondsSinceLastReset = timestampNow - MaxInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastAutoReset[userSelected], sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastFullReset[userSelected])
			else
				secondsSinceLastReset = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
			endif
			noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected])
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 0)
				noOfAutoResetsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfTimesAutoReset[userSelected] - noOfAutoResetsPassedSinceLast
				if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
			else
				noOfAutoResetsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfTimesAutoReset[userSelected]
			endif
			secondsLeftUntilAutoReset = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected] - secondsSinceLastReset
			if (noOfAutoResetsLeft > 0)
				if (redrawScreen = 1)
					OryUIUpdateTextCard(crdUsersLockResetsIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Auto Resets;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				
				dd = floor(secondsLeftUntilAutoReset / 60 / 60 / 24)
				hh = floor(mod(secondsLeftUntilAutoReset / 60 / 60, 24))
				mm = floor(mod(secondsLeftUntilAutoReset / 60, 60))
				ss = floor(mod(secondsLeftUntilAutoReset, 60))
				if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 1)
					noOfAutoResetsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfTimesAutoReset[userSelected]
					resetsIn$ = "Auto resets paused"
				elseif (dd > 0)
					resetsIn$ = "Auto resets in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
				elseif (hh > 0)
					resetsIn$ = "Auto resets in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
				elseif (mm > 0)
					resetsIn$ = "Auto resets in " + str(mm) + "m " + str(ss) + "s"
				elseif (ss >= 0)
					resetsIn$ = "Auto resets in " + str(ss) + "s"
				else
					resetsIn$ = "Auto resets when user opens the app"
					autoResetPending = 1
				endif
				OryUIUpdateTextCard(crdUsersLockResetsIn, "supportingText:" + resetsIn$ + chr(10) + str(noOfAutoResetsLeft) + " auto reset(s) left;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockResetsIn)
			else
				OryUIUpdateTextCard(crdUsersLockResetsIn, "position:-1000,-1000")
			endif
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdUsersLockResetsIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Auto Resets;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Requires Server Time;supportingTextColorID:192,57,42,255")
			endif
		endif
	else
		OryUIUpdateTextCard(crdUsersLockResetsIn, "position:-1000,-1000")
	endif
	
	// PAUSE AUTO RESETS?
	if (selectedManageUsersTab = 1 and noOfAutoResetsLeft > 0 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected] > 0 and timestampFromServer > 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersPauseAutoResets, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersPauseAutoResets)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpUsersPauseAutoResets, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateButtonGroupItem(grpUsersPauseAutoResets, 1, "name:Yes;text:Yes")
			OryUIUpdateButtonGroupItem(grpUsersPauseAutoResets, 2, "name:No;text:No")
		endif
		OryUIInsertButtonGroupListener(grpUsersPauseAutoResets)
		if (OryUIGetButtonGroupItemReleasedIndex(grpUsersPauseAutoResets) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constUsersLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpUsersPauseAutoResets) + 2
		if (OryUIGetButtonGroupItemSelectedName(grpUsersPauseAutoResets) = "Yes")
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 0)
				OryUIShowFloatingActionButton(fabSaveUsersLockInformation)
			endif
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpUsersPauseAutoResets) = "No")
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 1)
				OryUIShowFloatingActionButton(fabSaveUsersLockInformation)
			endif
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersPauseAutoResets, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpUsersPauseAutoResets, "position:-1000,-1000")
		endif
	endif

	// CHANCES ACCUMULATED
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersBuildNumberInstalled[userSelected] >= 134 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 0].cumulative = 1)
		noOfChances = 0
		if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 15)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 30)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 60)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 3) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 60 / 3)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 6) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 60 / 6)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 12) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 60 / 12)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then noOfChances = floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected]) / 60 / 60 / 24)
		endif
		noOfChances = noOfChances + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersChancesAccumulatedBeforeFreeze[userSelected]
		if (noOfChances > 1)										
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdUsersLockChancesAccumulated, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + str(noOfChances) + " chances;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockChancesAccumulated)
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdUsersLockChancesAccumulated, "position:-1000,-1000")
			endif
		endif
	else
		noOfChances = 0
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockChancesAccumulated, "position:-1000,-1000")
		endif
	endif
	
	// TOGGLE CUMULATIVE / NON-CUMULATIVE
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTrustKeyholder[userSelected] = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersBuildNumberInstalled[userSelected] >= 275)
		if (redrawScreen = 1)
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 1)
				OryUIUpdateTextCard(crdUsersToggleCumulative, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This users lock is currently cumulative. Switching it to non-cumulative will stop chances from accumulating, and will wipe any extra chances already accumulated;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdUsersToggleCumulative, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This users lock is currently non-cumulative. Switching it to cumulative will allow it to accumulate chances while they are away from the app;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif	
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersToggleCumulative)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpUsersToggleCumulative, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateButtonGroupItem(grpUsersToggleCumulative, 1, "name:Cumulative;text:Cumulative")
			OryUIUpdateButtonGroupItem(grpUsersToggleCumulative, 2, "name:NonCumulative;text:Non-Cumulative")
		endif
		OryUIInsertButtonGroupListener(grpUsersToggleCumulative)
		if (OryUIGetButtonGroupItemReleasedIndex(grpUsersToggleCumulative) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constUsersLockInformationScreen)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpUsersToggleCumulative) + 2
		if (OryUIGetButtonGroupItemSelectedName(grpUsersToggleCumulative) = "Cumulative")
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 0)
				OryUIShowFloatingActionButton(fabSaveUsersLockInformation)
			endif
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpUsersToggleCumulative) = "NonCumulative")
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 1)
				OryUIShowFloatingActionButton(fabSaveUsersLockInformation)
			endif
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersToggleCumulative, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpUsersToggleCumulative, "position:-1000,-1000")
		endif
	endif
	
	// NEXT CHANCE IN
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersBuildNumberInstalled[userSelected] >= 134 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 0].cumulative = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected])
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 60) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 900) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 1800) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 3600) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 3) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 10800) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 6) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 21600) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 12) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 43200) - timestampNow
		if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] + 86400) - timestampNow
		dd = floor(secondsLeft / 60 / 60 / 24)
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		if (dd > 0)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:" + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (hh > 0)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:" + str(hh) + "h " + str(mm) + "m " + str(ss) + "s;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (mm > 0)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:" + str(mm) + "m " + str(ss) + "s;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (ss > 0)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:" + str(ss) + "s;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (timestampNow > 1500000000)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:Ready to pick now;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "supportingText:N/A;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockNextChanceIn)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockNextChanceIn, "position:-1000,-1000")
		endif
	endif
	
	// CARDS LAST PICKED
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, 0].fixed = 0)
		noOfDiscardPileCards as integer : noOfDiscardPileCards = CountStringTokens(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDiscardPile$[userSelected], ",")
		if (noOfDiscardPileCards > 10) then noOfDiscardPileCards = 10
		if (noOfDiscardPileCards > 0)
			if (redrawScreen = 1)
				if (noOfDiscardPileCards > 1)
					OryUIUpdateTextCard(crdUsersLockCardsLastPicked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Newest First;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateTextCard(crdUsersLockCardsLastPicked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif	
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockCardsLastPicked)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdUsersLockDiscardPileImages, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";height:" + str(GetSpriteHeight(sprCardsInDiscardPile[1]) + 2) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				startX# = (100.0 - ((noOfDiscardPileCards * GetSpriteWidth(sprCardsInDiscardPile[1])) + (noOfDiscardPileCards - 1))) / 2.0
				for i = 0 to 10
					if (i <= noOfDiscardPileCards)
						usersDiscardPileCard$ as string : usersDiscardPileCard$ = GetStringToken(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDiscardPile$[userSelected], ",", i)
						if (usersDiscardPileCard$ = "DoubleUp") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardDoubleUp100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "Freeze") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardFreeze100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "GoAgain") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardGoAgain) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "Green") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardGreen100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "Red") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardRed100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "Reset") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardReset100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "Sticky") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardSticky100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "YellowAdd1") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardYellowAdd1) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "YellowAdd2") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardYellowAdd2) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "YellowAdd3") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardYellowAdd3) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "YellowMinus1") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardYellowMinus1) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (usersDiscardPileCard$ = "YellowMinus2") then OryUIUpdateSprite(sprCardsInDiscardPile[i], "image:" + str(imgCardYellowMinus2) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprCardsInDiscardPile[i]) + 1))) + "," + str(elementY#))
					else
						OryUIUpdateSprite(sprCardsInDiscardPile[i], "position:-1000,-1000")
					endif
				next
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockDiscardPileImages)
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdUsersLockCardsLastPicked, "position:-1000,-1000")
				OryUIUpdateTextCard(crdUsersLockDiscardPileImages, "position:-1000,-1000")
				for i = 1 to 10
					OryUIUpdateSprite(sprCardsInDiscardPile[i], "position:-1000,-1000")
				next
			endif
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockCardsLastPicked, "position:-1000,-1000")
			OryUIUpdateTextCard(crdUsersLockDiscardPileImages, "position:-1000,-1000")
			for i = 1 to 10
				OryUIUpdateSprite(sprCardsInDiscardPile[i], "position:-1000,-1000")
			next
		endif
	endif

	// LOCK ESTIMATIONS
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReadyToUnlock[userSelected] = 0)
		if (redrawScreen = 1)
			if (sharedLocks[sharedLockSelected, 0].cumulative = 0) then OryUIUpdateTextCard(crdUsersLockEstimations, "supportingText:These estimates are based on 100 test runs of this users lock. They do not take into account time they are away from the app, i.e. sleeping.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (sharedLocks[sharedLockSelected, 0].cumulative = 1) then OryUIUpdateTextCard(crdUsersLockEstimations, "supportingText:These estimates are based on 100 test runs of this users lock.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUsersLockEstimations)

		if (redrawScreen = 1)
			simulationCount = 0
		endif
		if (simulationCount = 0)
			botChosen = 0
			fixed = 0
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] > 0)
				maxAutoResets = noOfAutoResetsLeft
			else
				maxAutoResets = 0
			endif
			minDoubleUps = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[userSelected]
			maxDoubleUps = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[userSelected]
			minFreezes = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[userSelected]
			maxFreezes = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[userSelected]
			minGreens = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[userSelected]
			maxGreens = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[userSelected]
			minReds = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[userSelected]
			maxReds = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[userSelected]
			minResets = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[userSelected]
			maxResets = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[userSelected]
			minStickies = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[userSelected]
			maxStickies = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[userSelected]
			minYellowsRandom = 0
			maxYellowsRandom = 0
			minYellowsAdd = 0
			maxYellowsAdd = 0
			minYellowsMinus = 0
			maxYellowsMinus = 0
			minYellowsAdd1 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 3]
			maxYellowsAdd1 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 3]
			minYellowsAdd2 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 4]
			maxYellowsAdd2 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 4]
			minYellowsAdd3 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 5]
			maxYellowsAdd3 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 5]
			minYellowsMinus1 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 2]
			maxYellowsMinus1 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 2]
			minYellowsMinus2 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 1]
			maxYellowsMinus2 = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[userSelected, 1]
			multipleGreensRequired = sharedLocks[sharedLockSelected, 0].multipleGreensRequired
			regularity# = sharedLocks[sharedLockSelected, 0].regularity#
			resetFrequencyInSeconds = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected]
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
			if (sharedLocks[sharedLockSelected, 0].maxRandomReds = 0)
				simulationMinimumRedCards = 1
			elseif (sharedLocks[sharedLockSelected, 0].minRandomReds = sharedLocks[sharedLockSelected, 0].maxRandomReds)
				simulationMinimumRedCards = 1
			else
				simulationMinimumRedCards = sharedLocks[sharedLockSelected, 0].minRandomReds
				simulationMinimumRedCards = simulationMinimumRedCards - floor((timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) / (sharedLocks[sharedLockSelected, 0].regularity# * 3600))
				if (simulationMinimumRedCards < 1) then simulationMinimumRedCards = 1
			endif
		endif
		
		if (simulationCount > 0)
			RunSimulation()
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
			if (i = 4 and maxResets = 0 and resetFrequencyInSeconds = 0)
				OryUIUpdateText(usersLockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
				continue
			endif
			usersLockChartTitle$ as string : usersLockChartTitle$ = ""
			usersLockBestCase as integer : usersLockBestCase = 0
			usersLockAverageCase as integer : usersLockAverageCase = 0
			usersLockWorstCase as integer : usersLockWorstCase = 0
			if (i = 1)
				if (sharedLocks[sharedLockSelected, 0].regularity# = 24 or ((simulationAverageMinutesLocked / simulationsToTry) / 60) >= 168)
					usersLockChartTitle$ = "Number of days left"
					usersLockBestCase = simulationBestCaseMinutesLocked / 60 / 24
					usersLockAverageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60 / 24
					usersLockWorstCase = simulationWorstCaseMinutesLocked / 60 / 24
				else
					usersLockChartTitle$ = "Number of hours left"
					usersLockBestCase = simulationBestCaseMinutesLocked / 60
					usersLockAverageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60
					usersLockWorstCase = simulationWorstCaseMinutesLocked / 60
				endif
			endif
			if (i = 2)
				usersLockChartTitle$ = "Number of chances left"
				usersLockBestCase = simulationBestCaseNoOfTurns
				usersLockAverageCase = simulationAverageNoOfTurns / simulationsToTry
				usersLockWorstCase = simulationWorstCaseNoOfTurns
			endif
			if (i = 3)
				usersLockChartTitle$ = "Number of cards drawn"
				usersLockBestCase = simulationBestCaseNoOfCardsDrawn
				usersLockAverageCase = simulationAverageNoOfCardsDrawn / simulationsToTry
				usersLockWorstCase = simulationWorstCaseNoOfCardsDrawn
			endif
			if (i = 4)
				usersLockChartTitle$ = "Number of resets (card and scheduled)"
				usersLockBestCase = simulationBestCaseNoOfLockResets
				usersLockAverageCase = simulationAverageNoOfLockResets / simulationsToTry
				usersLockWorstCase = simulationWorstCaseNoOfLockResets
			endif
			usersLockMin as integer : usersLockMin = RoundDownWithReducedPrecision(usersLockBestCase)
			usersLockMax as integer : usersLockMax = RoundUpWithReducedPrecision(usersLockWorstCase)
			usersLockBestCaseWidth# as float : usersLockBestCaseWidth# = (70.0 / (usersLockMax - usersLockMin)) * (usersLockBestCase - usersLockMin)
			usersLockAverageCaseWidth# as float : usersLockAverageCaseWidth# = (70.0 / (usersLockMax - usersLockMin)) * (usersLockAverageCase - usersLockMin)
			usersLockWorstCaseWidth# as float : usersLockWorstCaseWidth# = (70.0 / (usersLockMax - usersLockMin)) * (usersLockWorstCase - usersLockMin)
			OryUIUpdateText(usersLockEstimations[i].txtChartTitle, "text:" + usersLockChartTitle$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			elementY# = elementY# + GetTextTotalHeight(usersLockEstimations[i].txtChartTitle) + 1
			OryUIUpdateSprite(usersLockEstimations[i].sprBackground, "position:" + str((screenNo * 100) + 15) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateSprite(usersLockEstimations[i].sprBestCaseBar, "width:" + str(usersLockBestCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 0.5) + ";colorID:" + str(theme[themeSelected].color[2]))
			OryUIUpdateSprite(usersLockEstimations[i].sprAverageCaseBar, "width:" + str(usersLockAverageCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 3) + ";colorID:" + str(theme[themeSelected].color[3]))
			OryUIUpdateSprite(usersLockEstimations[i].sprWorstCaseBar, "width:" + str(usersLockWorstCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 5.5) + ";colorID:" + str(theme[themeSelected].color[4]))
			OryUIUpdateText(usersLockEstimations[i].txtBestCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(usersLockEstimations[i].txtAverageCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(usersLockEstimations[i].txtWorstCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(usersLockEstimations[i].txtBestCaseLabel, "text:" + str(usersLockBestCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(usersLockEstimations[i].txtAverageCaseLabel, "text:" + str(usersLockAverageCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(usersLockEstimations[i].txtWorstCaseLabel, "text:" + str(usersLockWorstCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtBestCaseTitle, usersLockEstimations[i].sprBestCaseBar, -(GetTextTotalWidth(usersLockEstimations[i].txtBestCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtAverageCaseTitle, usersLockEstimations[i].sprAverageCaseBar, -(GetTextTotalWidth(usersLockEstimations[i].txtAverageCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtWorstCaseTitle, usersLockEstimations[i].sprWorstCaseBar, -(GetTextTotalWidth(usersLockEstimations[i].txtWorstCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtBestCaseLabel, usersLockEstimations[i].sprBestCaseBar, GetSpriteWidth(usersLockEstimations[i].sprBestCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtAverageCaseLabel, usersLockEstimations[i].sprAverageCaseBar, GetSpriteWidth(usersLockEstimations[i].sprAverageCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(usersLockEstimations[i].txtWorstCaseLabel, usersLockEstimations[i].sprWorstCaseBar, GetSpriteWidth(usersLockEstimations[i].sprWorstCaseBar) + 2, 0)
			if (simulationCount = 0)
				OryUIPinSpriteToSprite(usersLockEstimations[i].sprChartOverlay, usersLockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(usersLockEstimations[i].txtRunningSimulation, "text:Simulation Ready to Run")
				OryUIPinTextToCentreOfSprite(usersLockEstimations[i].txtRunningSimulation, usersLockEstimations[i].sprChartOverlay, 0, 0)
			elseif (simulationCount < simulationsToTry)
				OryUIPinSpriteToSprite(usersLockEstimations[i].sprChartOverlay, usersLockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(usersLockEstimations[i].txtRunningSimulation, "text:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry))
				OryUIPinTextToCentreOfSprite(usersLockEstimations[i].txtRunningSimulation, usersLockEstimations[i].sprChartOverlay, 0, 0)
			else
				OryUIUpdateSprite(usersLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			endif
			elementY# = elementY# + GetSpriteHeight(usersLockEstimations[i].sprBackground) + 2
		next
		if (simulationRan = 0)
			OryUIUpdateButton(btnRerunUsersLockSimulation, "text:Run Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		else
			OryUIUpdateButton(btnRerunUsersLockSimulation, "text:Rerun Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif	
		elementY# = elementY# + OryUIGetButtonHeight(btnRerunUsersLockSimulation) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUsersLockEstimations, "position:-1000,-1000")
			for i = 1 to 4
				OryUIUpdateText(usersLockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(usersLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(usersLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			next
			OryUIUpdateButton(btnRerunUsersLockSimulation, "position:-1000,-1000")
		endif
	endif
	if (OryUIGetButtonReleased(btnRerunUsersLockSimulation))
		simulationCount = 0
		RunSimulation()
	endif
	
	// DELETE USER FROM LOCK
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdDeleteUserFromLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Deleting " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected] + " from this lock will mean you will no longer be able to manage their lock. They will be given a choice to either unlock for free, or continue the lock as a solo lock. Any keyholder freeze effects will be removed. Once removed, neither of you will be able to rate the other, and they will not be able to rate this lock.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdDeleteUserFromLock) + 2
	if (redrawScreen = 1)
		OryUIUpdateButton(btnDeleteUserFromLock, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,42,255;textColor:255,255,255,255")
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnDeleteUserFromLock) + 2
	if (OryUIGetButtonReleased(btnDeleteUserFromLock))
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Delete User From Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to delete " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected] + " from this lock? This cannot be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 3)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteUser;text:Delete;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteAndBlockUser;text:Delete & Block;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "DeleteUser"))
		RemoveUserFromLock(sharedLockSelected, selectedManageUsersTab, userSelected, 1)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "DeleteAndBlockUser"))
		BlockUser(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[userSelected], 1)
		RemoveUserFromLock(sharedLockSelected, selectedManageUsersTab, userSelected, 1)
	endif
	
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveUsersLockInformation, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	// SAVE BUTTON
	if (OryUIGetFloatingActionButtonReleased(fabSaveUsersLockInformation))
		if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[userSelected] = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[userSelected] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected] > 0 and timestampFromServer > 0)
			if (OryUIGetButtonGroupItemSelectedName(grpUsersPauseAutoResets) = "Yes")
				if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 0)
					sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPausedModifiedBy[userSelected] = 1
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:AutoResetsPaused", 0, 0)
				endif
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpUsersPauseAutoResets) = "No")
				if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[userSelected] = 1)
					sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPausedModifiedBy[userSelected] = -1
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:AutoResetsUnpaused", 0, 0)
				endif
			endif
		endif
		if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[userSelected] = 0)
			if (OryUIGetButtonGroupItemSelectedName(grpUsersToggleCumulative) = "Cumulative")
				if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 0)
					sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulativeModifiedBy[userSelected] = 1
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:SwitchedToCumulative", 0, 0)
				endif
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpUsersToggleCumulative) = "NonCumulative")
				if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulative[userSelected] = 1)
					sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCumulativeModifiedBy[userSelected] = -1
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:SwitchedToNonCumulative", 0, 0)
					if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] < timestampNow - (sharedLocks[sharedLockSelected, 0].regularity# * 3600))
						sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastPicked[userSelected] = timestampNow - (sharedLocks[sharedLockSelected, 0].regularity# * 3600)
					endif
				endif
			endif
		endif
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
