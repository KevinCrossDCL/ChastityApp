
OryUIHideFloatingActionButton(fabSaveLockInformation)
if (screenToView = constLockInformationScreen)
	// RESET OPTIONS WHEN FIRST COMING TO THE SCREEN
	if (screenNo <> constLockInformationScreen)
		OryUIUpdateTextfield(editBoxLockName, "inputText:" + locks[lockSelected].lockName$)
		if (locks[lockSelected].test = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpTestLock, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpTestLock, 1)
		endif
		if (locks[lockSelected].trustKeyholder = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpTrustTheKeyholder, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpTrustTheKeyholder, 1)
		endif
		if (locks[lockSelected].blockBotFromUnlocking = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpBlockBotFromUnlockingEarly, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpBlockBotFromUnlockingEarly, 1)
		endif
		if (locks[lockSelected].keyDisabled = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpDisableKeys, 2)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpDisableKeys, 1)
		endif
	endif
	
	screenNo = constLockInformationScreen

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
		if (locks[lockSelected].build < 195)
			// LOCKS CREATED BEFORE 2.5.2.ALPHA.4
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:ID " + str(locks[lockSelected].groupID) + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		else
			// NEW LOCKS CREATED IN OR AFTER 2.5.2.ALPHA.4
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:ID " + str(locks[lockSelected].groupID) + AddLeadingZeros(str(locks[lockSelected].id - locks[lockSelected].groupID), 2) + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		endif
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		GetLockLog(lockSelected, 1)
		SetScreenToView(constLockLogScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs) + 2

	startScrollBarY# = elementY# - 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// LOCK NAME
	if (locks[lockSelected].sharedID$ = "" or locks[lockSelected].botChosen > 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLockName, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock Name;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText: ;supportingTextColor:41,128,185,255")
			OryUIUpdateTextfield(editBoxLockName, "position:" + str((screenNo * 100) + 5) + "," + str(elementY# + 5) + ";maxLength:25;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editBoxLockName)
		if (OryUIGetTextfieldTrailingIconReleased(editBoxLockName))
			OryUISetTextfieldString(editBoxLockName, "")
			SetEditBoxFocus(OryUITextfieldCollection[editBoxLockName].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editBoxLockName) = 0 and OryUIGetTextfieldString(editBoxLockName) <> locks[lockSelected].lockName$)
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLockName) + 5
	else
		if (locks[lockSelected].lockName$ <> "")
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdLockName, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock Name;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + locks[lockSelected].lockName$ + ";supportingTextColor:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateTextfield(editBoxLockName, "position:-1000,-1000")
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdLockName)
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdLockName, "position:-1000,-1000")
				OryUIUpdateTextfield(editBoxLockName, "position:-1000,-1000")
			endif
		endif
	endif
	
	// API LOCK IDs
	if (redrawScreen = 1)
		apiLockIDs$ as string : apiLockIDs$ = ""
		if (locks[lockSelected].build < 195)
			// LOCKS CREATED BEFORE 2.5.2.ALPHA.4
			apiLockIDs$ = "LockGroupID = " + str(locks[lockSelected].groupID)
		else
			// NEW LOCKS CREATED IN OR AFTER 2.5.2.ALPHA.4
			apiLockIDs$ = "LockGroupID = " + str(locks[lockSelected].groupID) + chr(10) + "LockID = " + str(locks[lockSelected].groupID) + AddLeadingZeros(str(locks[lockSelected].id - locks[lockSelected].groupID), 2)
		endif
		if (locks[lockSelected].lockName$ <> "") then apiLockIDs$ = apiLockIDs$ + chr(10) + "LockName = " + chr(34) + locks[lockSelected].lockName$ + chr(34)
		OryUIUpdateTextCard(crdAPILockIDs, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:API Lock ID(s);headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + apiLockIDs$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdAPILockIDs)
	
	// QR CODE URL
	if (len(locks[lockSelected].sharedID$) = 15)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdQRCodeURL, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Original QR Code;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText: ;supportingTextColorID:" + str(colorMode[colorModeSelected].urlColor))
		endif
		OryUIUpdateButton(btnQRCodeURL, "text:" + ReplaceString(constAppMarketingDomain$, "https://", "", -1) + "/sharedlock/" + locks[lockSelected].sharedID$ + ";position:" + str((screenNo * 100) + 3) + "," + str(elementY# + 3.5) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColor:41,128,185,255;textSize:2.5")
		if (OryUIGetButtonReleased(btnQRCodeURL))
			OpenBrowser(constAppMarketingDomain$ + "/sharedlock/" + locks[lockSelected].sharedID$)
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdQRCodeURL)
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdQRCodeURL, "position:-1000,-1000")
			OryUIUpdateButton(btnQRCodeURL, "position:-1000,-1000")
		endif
	endif

	// LOCK TYPE
	if (redrawScreen = 1)
		lockType$ as string : lockType$ = ""
		if (locks[lockSelected].fixed = 0)
			lockType$ = "Variable | "
			if (locks[lockSelected].regularity# = 0.016667) then lockType$ = lockType$ + "Every Minute | "
			if (locks[lockSelected].regularity# = 0.25) then lockType$ = lockType$ + "Every 15 Mins | "
			if (locks[lockSelected].regularity# = 0.5) then lockType$ = lockType$ + "Every 30 Mins | "
			if (locks[lockSelected].regularity# = 1) then lockType$ = lockType$ + "Hourly | "
			if (locks[lockSelected].regularity# = 3) then lockType$ = lockType$ + "Every 3 Hrs | "
			if (locks[lockSelected].regularity# = 6) then lockType$ = lockType$ + "Every 6 Hrs | "
			if (locks[lockSelected].regularity# = 12) then lockType$ = lockType$ + "Every 12 Hrs | "
			if (locks[lockSelected].regularity# = 24) then lockType$ = lockType$ + "Daily | "
			if (locks[lockSelected].cumulative = 0) then lockType$ = lockType$ + "Non-Cumulative | "
			if (locks[lockSelected].cumulative = 1) then lockType$ = lockType$ + "Cumulative | "
		elseif (locks[lockSelected].fixed = 1)
			lockType$ = "Fixed | "
			if (locks[lockSelected].timerHidden = 1) then lockType$ = lockType$ + "Timer Hidden | "
		endif
		if (right(lockType$, 3) = " | ") then lockType$ = mid(lockType$, 1, len(lockType$) - 3)
		if (locks[lockSelected].test = 1) then lockType$ = lockType$ + chr(10) + "Test Lock | "
		if (right(lockType$, 3) = " | ") then lockType$ = mid(lockType$, 1, len(lockType$) - 3)
		OryUIUpdateTextCard(crdLockType, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Lock Type;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + lockType$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdLockType)
	
	// TIME LOCKED
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdTimeLocked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Time Locked;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	if (locks[lockSelected].unlocked = 0)
		secondsLocked = timestampNow - locks[lockSelected].timestampLocked
	else
		secondsLocked = locks[lockSelected].timestampUnlocked - locks[lockSelected].timestampLocked
	endif
	dd = floor(secondsLocked / 60 / 60 / 24)
	hh = floor(mod(secondsLocked / 60 / 60, 24))
	mm = floor(mod(secondsLocked / 60, 60))
	ss = floor(mod(secondsLocked, 60))
	keyholderUsername$ = ""
	if (locks[lockSelected].keyholderUsername$ <> "") then keyholderUsername$ = " by " + locks[lockSelected].keyholderUsername$
	if (timestampFromServer > 0)
		if (dd > 0)
			OryUIUpdateTextCard(crdTimeLocked, "supportingText:Locked for " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" + keyholderUsername$ + chr(10) + "Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (hh > 0)
			OryUIUpdateTextCard(crdTimeLocked, "supportingText:Locked for " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" + keyholderUsername$ + chr(10) + "Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (mm > 0)
			OryUIUpdateTextCard(crdTimeLocked, "supportingText:Locked for " + str(mm) + "m " + str(ss) + "s" + keyholderUsername$ + chr(10) + "Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (ss >= 0)
			OryUIUpdateTextCard(crdTimeLocked, "supportingText:Locked for " + str(ss) + "s" + keyholderUsername$ + chr(10) + "Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdTimeLocked, "supportingText:Locked for N/A" + keyholderUsername$ + chr(10) + "Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	else
		OryUIUpdateTextCard(crdTimeLocked, "supportingText:Requires Server Time;supportingTextColor:192,57,42,255")
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdTimeLocked)

	// CHECK-IN
	if (locks[lockSelected].checkInFrequencyInSeconds > 0 and locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (timestampFromServer > 0)
			local secondsCheckInLate as integer
			local secondsSinceLastCheckIn as integer
			local secondsUntilNextCheckIn as integer
			local lastCheckedIn$ as string
			local lateCheckIn as integer
			if (locks[lockSelected].timestampLastCheckedIn = 0)
				secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLocked
				secondsUntilNextCheckIn = (locks[lockSelected].timestampLocked + locks[lockSelected].checkInFrequencyInSeconds) - timestampNow
				if (secondsUntilNextCheckIn > 0)
					dd = floor(secondsUntilNextCheckIn / 60 / 60 / 24)
					hh = floor(mod(secondsUntilNextCheckIn / 60 / 60, 24))
					mm = floor(mod(secondsUntilNextCheckIn / 60, 60))
					ss = floor(mod(secondsUntilNextCheckIn, 60))
					if (dd > 0)
						lastCheckedIn$ = "First check-in required in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (hh > 0)
						lastCheckedIn$ = "First check-in required in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (mm > 0)
						lastCheckedIn$ = "First check-in required in " + str(mm) + "m " + str(ss) + "s"
					elseif (ss >= 0)
						lastCheckedIn$ = "First check-in required in " + str(ss) + "s"
					endif
				else
					lastCheckedIn$ = "Check-in required" + chr(10)
					lateCheckIn = 0
					if (locks[lockSelected].fixed = 0)
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].regularity# * 3600)
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					else
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400)))
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					endif
					if (lateCheckIn = 1)
						if (locks[lockSelected].fixed = 0)
							if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - (locks[lockSelected].regularity# * 3600)
							else
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - locks[lockSelected].lateCheckInWindowInSeconds
							endif
						else
							if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400))
							else
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - locks[lockSelected].lateCheckInWindowInSeconds
							endif
						endif
						dd = floor(secondsCheckInLate / 60 / 60 / 24)
						hh = floor(mod(secondsCheckInLate / 60 / 60, 24))
						mm = floor(mod(secondsCheckInLate / 60, 60))
						ss = floor(mod(secondsCheckInLate, 60))
						if (dd > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (hh > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (mm > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(mm) + "m " + str(ss) + "s late"
						elseif (ss >= 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(ss) + "s late"
						endif
					else
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "You are not late yet"
					endif 
				endif
			else
				secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLastCheckedIn
				secondsUntilNextCheckIn = (locks[lockSelected].timestampLastCheckedIn + locks[lockSelected].checkInFrequencyInSeconds) - timestampNow
				dd = floor(secondsSinceLastCheckIn / 60 / 60 / 24)
				hh = floor(mod(secondsSinceLastCheckIn / 60 / 60, 24))
				mm = floor(mod(secondsSinceLastCheckIn / 60, 60))
				ss = floor(mod(secondsSinceLastCheckIn, 60))
				if (dd > 0)
					lastCheckedIn$ = "Last checked in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago" 
				elseif (hh > 0)
					lastCheckedIn$ = "Last checked in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s ago"
				elseif (mm > 0)
					lastCheckedIn$ = "Last checked in " + str(mm) + "m " + str(ss) + "s ago"
				elseif (ss >= 0)
					lastCheckedIn$ = "Last checked in " + str(ss) + "s ago"
				endif
				if (secondsUntilNextCheckIn > 0)
					dd = floor(secondsUntilNextCheckIn / 60 / 60 / 24)
					hh = floor(mod(secondsUntilNextCheckIn / 60 / 60, 24))
					mm = floor(mod(secondsUntilNextCheckIn / 60, 60))
					ss = floor(mod(secondsUntilNextCheckIn, 60))
					if (dd > 0)
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "Next check-in required in " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s" 
					elseif (hh > 0)
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "Next check-in required in " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
					elseif (mm > 0)
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "Next check-in required in " + str(mm) + "m " + str(ss) + "s"
					elseif (ss >= 0)
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "Next check-in required in " + str(ss) + "s"
					endif
				else
					lastCheckedIn$ = lastCheckedIn$ + chr(10) + "Check-in required" + chr(10)
					lateCheckIn = 0
					if (locks[lockSelected].fixed = 0)
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].regularity# * 3600)
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					else
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400)))
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds > locks[lockSelected].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					endif
					if (lateCheckIn = 1)
						if (locks[lockSelected].fixed = 0)
							if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - (locks[lockSelected].regularity# * 3600)
							else
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - locks[lockSelected].lateCheckInWindowInSeconds
							endif
						else
							if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400))
							else
								secondsCheckInLate = (secondsSinceLastCheckIn - locks[lockSelected].checkInFrequencyInSeconds) - locks[lockSelected].lateCheckInWindowInSeconds
							endif
						endif
						dd = floor(secondsCheckInLate / 60 / 60 / 24)
						hh = floor(mod(secondsCheckInLate / 60 / 60, 24))
						mm = floor(mod(secondsCheckInLate / 60, 60))
						ss = floor(mod(secondsCheckInLate, 60))
						if (dd > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (hh > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s late"
						elseif (mm > 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(mm) + "m " + str(ss) + "s late"
						elseif (ss >= 0)
							lastCheckedIn$ = lastCheckedIn$ + "You are " + str(ss) + "s late"
						endif
					else
						lastCheckedIn$ = lastCheckedIn$ + chr(10) + "You are not late yet"
					endif 
				endif
			endif
			OryUIUpdateTextCard(crdCheckIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Check-In;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + lastCheckedIn$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdCheckIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Check-In;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Requires Server Time;supportingTextColor:192,57,42,255")
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCheckIn)
		if (secondsUntilNextCheckIn <= 0 and timestampFromServer > 0)
			OryUIUpdateButton(btnCheckIn, "text:Check-In;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		else
			OryUIUpdateButton(btnCheckIn, "text:Check-In;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor) + ";textColor:128,128,128,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnCheckIn) + 2
		if (OryUIGetButtonReleased(btnCheckIn))
			if (secondsUntilNextCheckIn <= 0)
				locks[lockSelected].timestampLastCheckedIn = timestampNow
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:CheckedIn;actionedBy:Lockee;result:" + str(timestampNow) + ";totalActionTime:" + str(secondsSinceLastCheckIn), 1)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Check-In Yet;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot check-in at the moment. Please try again later.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
	else
		OryUIUpdateTextCard(crdCheckIn, "position:-1000,-1000")
		OryUIUpdateButton(btnCheckIn, "position:-1000,-1000")
	endif
	
	// RESETS IN
	if (locks[lockSelected].fixed = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].maximumAutoResets > 0 and locks[lockSelected].resetFrequencyInSeconds > 0)
		if (timestampFromServer > 0)
			secondsSinceLastReset as integer : secondsSinceLastReset = 0
			if (locks[lockSelected].timestampLastAutoReset > 0 or locks[lockSelected].timestampLastFullReset > 0)
				secondsSinceLastReset = timestampNow - MaxInt(locks[lockSelected].timestampLastAutoReset, locks[lockSelected].timestampLastFullReset)
			else
				secondsSinceLastReset = timestampNow - locks[lockSelected].timestampLocked
			endif
			noOfAutoResetsPassedSinceLast as integer : noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / locks[lockSelected].resetFrequencyInSeconds)
			if (locks[lockSelected].autoResetsPaused = 0)
				noOfAutoResetsLeft as integer : noOfAutoResetsLeft = locks[lockSelected].maximumAutoResets - locks[lockSelected].noOfTimesAutoReset - noOfAutoResetsPassedSinceLast
				if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
			else
				noOfAutoResetsLeft = locks[lockSelected].maximumAutoResets - locks[lockSelected].noOfTimesAutoReset
			endif
			secondsLeftUntilAutoReset as integer : secondsLeftUntilAutoReset = locks[lockSelected].resetFrequencyInSeconds - secondsSinceLastReset
			if (noOfAutoResetsLeft > 0)
				if (redrawScreen = 1)
					OryUIUpdateTextCard(crdResetsIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Auto Resets;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:XXXX;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				
				dd = floor(secondsLeftUntilAutoReset / 60 / 60 / 24)
				hh = floor(mod(secondsLeftUntilAutoReset / 60 / 60, 24))
				mm = floor(mod(secondsLeftUntilAutoReset / 60, 60))
				ss = floor(mod(secondsLeftUntilAutoReset, 60))
				resetsIn$ as string : resetsIn$ = ""
				if (locks[lockSelected].autoResetsPaused = 1)
					noOfAutoResetsLeft = locks[lockSelected].maximumAutoResets - locks[lockSelected].noOfTimesAutoReset
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
					resetsIn$ = "Auto resets when you go back"
				endif
				if (locks[lockSelected].cardInfoHidden = 1)
					OryUIUpdateTextCard(crdResetsIn, "supportingText:Auto reset information hidden;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateTextCard(crdResetsIn, "supportingText:" + resetsIn$ + chr(10) + str(noOfAutoResetsLeft) + " auto reset(s) left;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				elementY# = elementY# + OryUIGetTextCardHeight(crdResetsIn)
			else
				OryUIUpdateTextCard(crdResetsIn, "position:-1000,-1000")
			endif
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdResetsIn, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Auto Resets;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Requires Server Time;supportingTextColorID:192,57,42,255")
			endif
		endif
	else
		OryUIUpdateTextCard(crdResetsIn, "position:-1000,-1000")
	endif
	
	// LAST X UPDATES
	if (redrawScreen = 1)
		noOfUpdates as integer : noOfUpdates = 0
		for i = 0 to 4
			if (locks[lockSelected].lastXUpdates[i].update$ <> "")
				noOfUpdates = noOfUpdates + 1
			else
				exit
			endif
		next
	endif
	if (noOfUpdates > 0)
		if (redrawScreen = 1)
			if (noOfUpdates < 5)
				OryUIUpdateTextCard(crdLastXUpdates, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Keyholder Updates;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdLastXUpdates, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Last 5 Keyholder Updates;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif	
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdLastXUpdates) - 1
		textColor$ as string : textColor$ = str(GetColorRed(colorMode[colorModeSelected].textColor)) + "," + str(GetColorGreen(colorMode[colorModeSelected].textColor)) + "," + str(GetColorBlue(colorMode[colorModeSelected].textColor))
		OryUIUpdateList(listLastXUpdates, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";itemSize:92,6;showItemDivider:true")
		OryUISetListItemCount(listLastXUpdates, noOfUpdates)
		for i = 0 to noOfUpdates
			if (left(locks[lockSelected].lastXUpdates[i].update$, 1) = " ")
				locks[lockSelected].lastXUpdates[i].update$ = Mid(locks[lockSelected].lastXUpdates[i].update$, 2, len(locks[lockSelected].lastXUpdates[i].update$))
			endif
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, " cards", "", -1)
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, " card", "", -1)
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, "adding ", "+", -1)
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, "freezing it", "Froze lock", -1)
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, "revealing the information", "Revealing card information", -1)
			locks[lockSelected].lastXUpdates[i].update$ = ReplaceString(locks[lockSelected].lastXUpdates[i].update$, "removing ", "-", -1)
			locks[lockSelected].lastXUpdates[i].update$ = upper(Mid(locks[lockSelected].lastXUpdates[i].update$, 1, 1)) + Mid(locks[lockSelected].lastXUpdates[i].update$, 2, len(locks[lockSelected].lastXUpdates[i].update$))
			secondsSinceAction as integer : secondsSinceAction = timestampNow - locks[lockSelected].lastXUpdates[i].timestampUpdated
			updatedWhen$ as string : updatedWhen$ = ""
			if (floor(secondsSinceAction / 60 / 60 / 24) >= 1)
				updatedWhen$ = str(floor(secondsSinceAction / 60 / 60 / 24)) + "d"
			elseif (floor(secondsSinceAction / 60 / 60) >= 1)
				updatedWhen$ = str(floor(secondsSinceAction / 60 / 60)) + "h"
			elseif (floor(secondsSinceAction / 60) >= 1)
				updatedWhen$ = str(floor(secondsSinceAction / 60)) + "m"
			else
				updatedWhen$ = str(secondsSinceAction) + "s"
			endif
			OryUIUpdateListItem(listLastXUpdates, i, "colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + OryUIWrapText(locks[lockSelected].lastXUpdates[i].update$, 2.5, 75) + ";leftLine1TextSize:2.5;leftLine1TextColor:" + textColor$ + ",255;rightLine1Text:" + updatedWhen$ + ";rightLine1TextSize:2.5;rightLine1TextColor:" + textColor$ + ",130")
		next
		elementY# = elementY# + OryUIGetListHeight(listLastXUpdates) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdLastXUpdates, "position:-1000,-1000")
			OryUIUpdateList(listLastXUpdates, "position:-1000,-1000")
			OryUISetListItemCount(listLastXUpdates, 0)
		endif
	endif

	// CARDS LAST PICKED
	if (locks[lockSelected].fixed = 0)
		noOfCardsInDiscardPile as integer : noOfCardsInDiscardPile = CountStringTokens(locks[lockSelected].discardPile$, ",")
		if (noOfCardsInDiscardPile > 10) then noOfCardsInDiscardPile = 10
		if (noOfCardsInDiscardPile > 0)
			if (redrawScreen = 1)
				if (noOfCardsInDiscardPile > 1)
					OryUIUpdateTextCard(crdCardsLastPicked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Newest First;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateTextCard(crdCardsLastPicked, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif	
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdCardsLastPicked)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdDiscardPileImages, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";height:" + str(GetSpriteHeight(sprDiscardPile[1]) + 2) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				startX# = (100.0 - ((noOfCardsInDiscardPile * GetSpriteWidth(sprDiscardPile[1])) + (noOfCardsInDiscardPile - 1))) / 2.0
				for i = 1 to 10
					if (i <= noOfCardsInDiscardPile)
						discardPileCard$ as string : discardPileCard$ = GetStringToken(locks[lockSelected].discardPile$, ",", i)
						if (discardPileCard$ = "DoubleUp") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardDoubleUp100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "Freeze") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardFreeze100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "GoAgain") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardGoAgain) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "Green") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardGreen100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "Red") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardRed100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "Reset") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardReset100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "Sticky") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardSticky100) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "YellowAdd1") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardYellowAdd1) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "YellowAdd2") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardYellowAdd2) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "YellowAdd3") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardYellowAdd3) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "YellowMinus1") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardYellowMinus1) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
						if (discardPileCard$ = "YellowMinus2") then OryUIUpdateSprite(sprDiscardPile[i], "image:" + str(imgCardYellowMinus2) + ";position:" + str((screenNo * 100) + startX# + ((i - 1) * (GetSpriteWidth(sprDiscardPile[i]) + 1))) + "," + str(elementY#))
					else
						OryUIUpdateSprite(sprDiscardPile[i], "position:-1000,-1000")
					endif
				next
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(crdDiscardPileImages)
		else
			if (redrawScreen = 1)
				OryUIUpdateTextCard(crdCardsLastPicked, "position:-1000,-1000")
				OryUIUpdateTextCard(crdDiscardPileImages, "position:-1000,-1000")
				for i = 1 to 10
					OryUIUpdateSprite(sprDiscardPile[i], "position:-1000,-1000")
				next
			endif
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCardsLastPicked, "position:-1000,-1000")
			OryUIUpdateTextCard(crdDiscardPileImages, "position:-1000,-1000")
			for i = 1 to 10
				OryUIUpdateSprite(sprDiscardPile[i], "position:-1000,-1000")
			next
		endif
	endif
	
//~	// FREEZE LOCK?
//~	if ((locks[lockSelected].sharedID$ = "" or locks[lockSelected].botChosen > 0) and locks[lockSelected].lockFrozenByCard = 0 and locks[lockSelected].lockFrozenByKeyholder = 0)
//~		if (redrawScreen = 1)
//~			OryUIUpdateTextCard(crdFreezeLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Freeze Lock?;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Pressing the 'Freeze Lock' button below will freeze the lock for a random amount of time between " + lower(ReplaceString(ConvertMinutesRangeToText(locks[lockSelected].regularity# * 60, locks[lockSelected].regularity# * 60 * 8), "-", "and", -1)) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
//~		endif
//~		elementY# = elementY# + OryUIGetTextCardHeight(crdFreezeLock)
//~		if (redrawScreen = 1)
//~			OryUIUpdateButton(btnFreezeLock, "text:Freeze Lock;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
//~		endif
//~		elementY# = elementY# + OryUIGetButtonHeight(btnFreezeLock) + 2
//~		if (OryUIGetButtonReleased(btnFreezeLock))
//~			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Freeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to freeze the lock for a random amount of time between " + lower(ReplaceString(ConvertMinutesRangeToText(locks[lockSelected].regularity# * 60, locks[lockSelected].regularity# * 60 * 8), "-", "and", -1)) + "?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
//~			OryUISetDialogButtonCount(dialog, 2)
//~			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesFreezeLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
//~			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
//~			OryUIShowDialog(dialog)
//~		endif
//~		if (OryUIGetDialogButtonReleasedByName(dialog, "YesFreezeLock"))
//~			noOfChances = 0
//~			if (locks[lockSelected].regularity# = 0.016667)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60)
//~			elseif (locks[lockSelected].regularity# = 0.25)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 15)
//~			elseif (locks[lockSelected].regularity# = 0.5)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 30)
//~			elseif (locks[lockSelected].regularity# = 1)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60)
//~			elseif (locks[lockSelected].regularity# = 3)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 3)
//~			elseif (locks[lockSelected].regularity# = 6)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 6)
//~			elseif (locks[lockSelected].regularity# = 12)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 12)
//~			elseif (locks[lockSelected].regularity# = 24)
//~				noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 24)
//~			endif
//~			if (locks[lockSelected].cumulative = 0 and noOfChances > 1) then noOfChances = 1
//~			locks[lockSelected].chancesAccumulatedBeforeFreeze = noOfChances
//~			if (locks[lockSelected].chancesAccumulatedBeforeFreeze < 0) then locks[lockSelected].chancesAccumulatedBeforeFreeze = 0
//~			locks[lockSelected].lockFrozenByCard = 1
//~			locks[lockSelected].timestampFrozenByCard = timestampNow
//~			if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(60, 480)
//~			if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(900, 7200)
//~			if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(1800, 14400)
//~			if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(3600, 43200)
//~			if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(10800, 86400)
//~			if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(21600, 172800)
//~			if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(43200, 345600)
//~			if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(86400, 691200)
//~			UpdateLocksData(lockSelected)
//~			UpdateLocksDatabase(lockSelected, "action:LockeeUpdate;actionedBy:Lockee;result:FrozeLock", 0)
//~			screen[screenNo].lastViewY# = GetViewOffsetY()
//~			SetScreenToView(constLockInformationScreen)
//~		endif
//~	else
//~		OryUIUpdateTextCard(crdFreezeLock, "position:-1000,-1000")
//~		OryUIUpdateButton(btnFreezeLock, "position:-1000,-1000")
//~	endif
	
	// CARD COUNTS
	if (locks[lockSelected].fixed = 0 and locks[lockSelected].unlocked = 0)
		if (redrawScreen = 1)
			if (locks[lockSelected].multipleGreensRequired = 0)
				OryUIUpdateTextCard(crdCardCounts, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Card Counts;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You need to find one green card to unlock;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdCardCounts, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerText:Card Counts;headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You need to find all green cards to unlock;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCardCounts)
		if (redrawScreen = 1)
			offsetX# = 92.0 / 7.0
			OryUIUpdateSprite(sprCardsInLock[1], "image:" + str(imgCardGreen100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 0.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[2], "image:" + str(imgCardRed100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 1.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[3], "image:" + str(imgCardSticky100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 2.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[4], "image:" + str(imgCardYellowRandom100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 3.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[5], "image:" + str(imgCardFreeze100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 4.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[6], "image:" + str(imgCardDoubleUp100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 5.5)) + "," + str(elementY#))
			OryUIUpdateSprite(sprCardsInLock[7], "image:" + str(imgCardReset100) + ";position:" + str((screenNo * 100) + 4 + (offsetX# * 6.5)) + "," + str(elementY#))
			if (locks[lockSelected].cardInfoHidden = 0)
				OryUIUpdateText(txtCardsInLockCount[1], "text:" + str(locks[lockSelected].greenCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[2], "text:" + str(locks[lockSelected].redCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[3], "text:" + str(locks[lockSelected].stickyCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[4], "text:" + str(locks[lockSelected].yellowCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[5], "text:" + str(locks[lockSelected].freezeCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[6], "text:" + str(locks[lockSelected].doubleUpCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[7], "text:" + str(locks[lockSelected].resetCards) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				totalCards# as float : totalCards# = GetNoOfCards(lockSelected)
				greenPercentage$ as string : greenPercentage$ = str((locks[lockSelected].greenCards / totalCards#) * 100.0, 2)
				if (right(greenPercentage$, 3) = ".00") then greenPercentage$ = ReplaceString(greenPercentage$, ".00", "", -1)
				if (totalCards# = 0) then greenPercentage$ = "0"
				redPercentage$ as string : redPercentage$ = str((locks[lockSelected].redCards / totalCards#) * 100.0, 2)
				if (right(redPercentage$, 3) = ".00") then redPercentage$ = ReplaceString(redPercentage$, ".00", "", -1)
				if (totalCards# = 0) then redPercentage$ = "0"
				stickyPercentage$ as string : stickyPercentage$ = str((locks[lockSelected].stickyCards / totalCards#) * 100.0, 2)
				if (right(stickyPercentage$, 3) = ".00") then stickyPercentage$ = ReplaceString(stickyPercentage$, ".00", "", -1)
				if (totalCards# = 0) then stickyPercentage$ = "0"
				yellowPercentage$ as string : yellowPercentage$ = str((locks[lockSelected].yellowCards / totalCards#) * 100.0, 2)
				if (right(yellowPercentage$, 3) = ".00") then yellowPercentage$ = ReplaceString(yellowPercentage$, ".00", "", -1)
				if (totalCards# = 0) then yellowPercentage$ = "0"
				freezePercentage$ as string : freezePercentage$ = str((locks[lockSelected].freezeCards / totalCards#) * 100.0, 2)
				if (right(freezePercentage$, 3) = ".00") then freezePercentage$ = ReplaceString(freezePercentage$, ".00", "", -1)
				if (totalCards# = 0) then freezePercentage$ = "0"
				doubleUpPercentage$ as string : doubleUpPercentage$ = str((locks[lockSelected].doubleUpCards / totalCards#) * 100.0, 2)
				if (right(doubleUpPercentage$, 3) = ".00") then doubleUpPercentage$ = ReplaceString(doubleUpPercentage$, ".00", "", -1)
				if (totalCards# = 0) then doubleUpPercentage$ = "0"
				resetPercentage$ as string : resetPercentage$ = str((locks[lockSelected].resetCards / totalCards#) * 100.0, 2)
				if (right(resetPercentage$, 3) = ".00") then resetPercentage$ = ReplaceString(resetPercentage$, ".00", "", -1)
				if (totalCards# = 0) then resetPercentage$ = "0"
				OryUIUpdateText(txtCardsInLockPercentage[1], "text:" + greenPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[2], "text:" + redPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[3], "text:" + stickyPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[4], "text:" + yellowPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[5], "text:" + freezePercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[6], "text:" + doubleUpPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[7], "text:" + resetPercentage$ + "%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateSprite(sprCardsInLockSecretSticker[1], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[2], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[3], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[4], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[5], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[6], "position:-1000,-1000")
				OryUIUpdateSprite(sprCardsInLockSecretSticker[7], "position:-1000,-1000")
			else
				OryUIUpdateText(txtCardsInLockCount[1], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[2], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[3], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[4], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[5], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[6], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockCount[7], "text:??;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[1], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[2], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[3], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[4], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[5], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[6], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(txtCardsInLockPercentage[7], "text:??%;colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[1], sprCardsInLock[1], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[2], sprCardsInLock[2], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[3], sprCardsInLock[3], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[4], sprCardsInLock[4], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[5], sprCardsInLock[5], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[6], sprCardsInLock[6], 0, -2.5)
				OryUIPinSpriteToBottomCentreOfSprite(sprCardsInLockSecretSticker[7], sprCardsInLock[7], 0, -2.5)
			endif
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[1], sprCardsInLock[1], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[2], sprCardsInLock[2], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[3], sprCardsInLock[3], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[4], sprCardsInLock[4], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[5], sprCardsInLock[5], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[6], sprCardsInLock[6], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockCount[7], sprCardsInLock[7], 0, 3)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[1], sprCardsInLock[1], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[2], sprCardsInLock[2], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[3], sprCardsInLock[3], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[4], sprCardsInLock[4], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[5], sprCardsInLock[5], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[6], sprCardsInLock[6], 0, 5)
			OryUIPinTextToBottomCentreOfSprite(txtCardsInLockPercentage[7], sprCardsInLock[7], 0, 5)
			
			tmpY# as float : tmpY# = GetSpriteY(sprCardsInLock[1]) + GetSpriteHeight(sprCardsInLock[1]) + 3.5 + GetTextTotalHeight(txtCardsInLockPercentage[1])
			tmpHeight# as float : tmpHeight# = GetSpriteHeight(sprCardsInLock[1]) + 3.5 + GetTextTotalHeight(txtCardsInLockPercentage[1])	
			if (locks[lockSelected].readyToUnlock = 0)
				OryUIUpdateButton(btnCardsInLockAdd[1], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[1]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[1])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[2], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[2]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[2])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[3], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[3]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[3])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[4], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[4]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[4])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[5], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[5]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[5])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[6], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[6]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[6])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				OryUIUpdateButton(btnCardsInLockAdd[7], "offset:" + str(OryUIGetButtonWidth(btnCardsInLockAdd[7]) / 2) + ",0;position:" + str(GetSpriteXByOffset(sprCardsInLock[7])) + "," + str(tmpY#) + ";colorID:" + str(theme[themeSelected].color[3]))
				tmpHeight# = tmpHeight# + OryUIGetButtonHeight(btnCardsInLockAdd[1])
			else
				OryUIUpdateButton(btnCardsInLockAdd[1], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[2], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[3], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[4], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[5], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[6], "position:-1000,-1000")
				OryUIUpdateButton(btnCardsInLockAdd[7], "position:-1000,-1000")
			endif
				
			OryUIUpdateTextCard(crdCardImages, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";height:" + str(tmpHeight#))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCardImages) + 2
		
		// ADD GREEN CARD
		if (OryUIGetButtonReleased(btnCardsInLockAdd[1]))
			if (locks[lockSelected].greenCards + locks[lockSelected].greensPickedSinceReset <= cappedGreenCards - 1 and totalCards# <= cappedTotalCards - 1 and locks[lockSelected].multipleGreensRequired = 1)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Green Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 green card to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:AddGreen;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "AddGreen"))
			AddGreenCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD RED CARDS
		if (OryUIGetButtonReleased(btnCardsInLockAdd[2]))
			if (locks[lockSelected].redCards <= cappedRedCards - 4 and totalCards# <= cappedTotalCards - 4)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add red cards to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 5)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add1Red;text:Add 1 Red;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add2Reds;text:Add 2 Reds;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add3Reds;text:Add 3 Reds;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add1To4Reds;text:Add 1 to 4 Reds;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 5, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add1Red"))
			AddRedCards(lockSelected, 1, 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add2Reds"))
			AddRedCards(lockSelected, 2, 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add3Reds"))
			AddRedCards(lockSelected, 3, 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add1To4Reds"))
			AddRedCards(lockSelected, random(1, 4), 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD STICKY CARD
		if (OryUIGetButtonReleased(btnCardsInLockAdd[3]))
			if (locks[lockSelected].stickyCards <= cappedStickyCards - 1 and totalCards# <= cappedTotalCards - 1)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:AddSticky;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "AddSticky"))
			AddStickyCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD YELLOW CARDS
		if (OryUIGetButtonReleased(btnCardsInLockAdd[4]))
			if (locks[lockSelected].yellowCards <= cappedYellowCardsTotal - 4 and totalCards# <= cappedTotalCards - 4 and locks[lockSelected].keyholderUsername$ = "")
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add Yellow Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add yellow cards to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 5)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add1Yellow;text:Add 1 Yellow;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add2Yellows;text:Add 2 Yellows;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add3Yellows;text:Add 3 Yellows;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Add1To4Yellows;text:Add 1 to 4 Yellows;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 5, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add1Yellow"))
			AddRandomYellowCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add2Yellows"))
			AddRandomYellowCards(lockSelected, 2)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add3Yellows"))
			AddRandomYellowCards(lockSelected, 3)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "Add1To4Yellows"))
			AddRandomYellowCards(lockSelected, random(1, 4))
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD FREEZE CARD
		if (OryUIGetButtonReleased(btnCardsInLockAdd[5]))
			if (locks[lockSelected].freezeCards <= cappedFreezeCards - 1 and totalCards# <= cappedTotalCards = 1)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:AddFreeze;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "AddFreeze"))
			AddFreezeCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD DOUBLE UP CARD
		if (OryUIGetButtonReleased(btnCardsInLockAdd[6]))
			if (locks[lockSelected].doubleUpCards <= cappedDoubleUpCards - 1 and totalCards# <= cappedTotalCards - 1)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Double Up Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 double up card to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:AddDoubleUp;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "AddDoubleUp"))
			AddDoubleUpCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		// ADD RESET CARD
		if (OryUIGetButtonReleased(btnCardsInLockAdd[7]))
			if (locks[lockSelected].resetCards <= cappedResetCards - 1 and totalCards# <= cappedTotalCards - 1 and locks[lockSelected].greenCards <= locks[lockSelected].initialGreenCards and locks[lockSelected].redCards <= locks[lockSelected].initialRedCards and locks[lockSelected].yellowCards <= locks[lockSelected].initialYellowCards and locks[lockSelected].stickyCards <= locks[lockSelected].initialStickyCards and locks[lockSelected].freezeCards <= locks[lockSelected].initialFreezeCards and locks[lockSelected].doubleUpCards <= locks[lockSelected].initialDoubleUpCards and locks[lockSelected].keyholderUsername$ = "")
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Reset Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 reset card to the deck? This may increase the duration of the lock and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:AddReset;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add this card at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "AddReset"))
			AddResetCards(lockSelected, 1)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCardCounts, "position:-1000,-1000")	
			OryUIUpdateSprite(sprCardsInLock[1], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[2], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[3], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[4], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[5], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[6], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLock[7], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[1], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[2], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[3], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[4], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[5], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[6], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockCount[7], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[1], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[2], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[3], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[4], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[5], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[6], "position:-1000,-1000")
			OryUIUpdateText(txtCardsInLockPercentage[7], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[1], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[2], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[3], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[4], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[5], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[6], "position:-1000,-1000")
			OryUIUpdateSprite(sprCardsInLockSecretSticker[7], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[1], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[2], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[3], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[4], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[5], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[6], "position:-1000,-1000")
			OryUIUpdateButton(btnCardsInLockAdd[7], "position:-1000,-1000")
			OryUIUpdateTextCard(crdCardImages, "position:-1000,-1000")
		endif
	endif
	
	// LOCK ESTIMATIONS
	if (locks[lockSelected].fixed = 0 and locks[lockSelected].cardInfoHidden = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			if (locks[lockSelected].sharedID$ <> "" or locks[lockSelected].botChosen > 0)
				if (locks[lockSelected].cumulative = 0) then OryUIUpdateTextCard(crdCurrentLockEstimations, "supportingText:These estimates are based on 100 test runs of this lock. They do not take into account time away from the app, i.e. sleeping. Nor do they take into account keyholder updates. They also do not take into account any cards you've added above but not yet saved.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				if (locks[lockSelected].cumulative = 1) then OryUIUpdateTextCard(crdCurrentLockEstimations, "supportingText:These estimates are based on 100 test runs of this lock. They do not take into account keyholder updates. Nor do they take into account any cards you've added above but not yet saved.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				if (locks[lockSelected].cumulative = 0) then OryUIUpdateTextCard(crdCurrentLockEstimations, "supportingText:These estimates are based on 100 test runs of this lock. They do not take into account time away from the app, i.e. sleeping. Nor do they take into account any cards you've added above but not yet saved.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
				if (locks[lockSelected].cumulative = 1) then OryUIUpdateTextCard(crdCurrentLockEstimations, "supportingText:These estimates are based on 100 test runs of this lock. They do not take into account any cards you've added above but not yet saved.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCurrentLockEstimations)

		if (redrawScreen = 1)
			simulationCount = 0
		endif
		if (simulationCount = 0)
			botChosen = locks[lockSelected].botChosen
			fixed = 0
			maxAutoResets = locks[lockSelected].maximumAutoResets - locks[lockSelected].noOfTimesAutoReset
			minDoubleUps = locks[lockSelected].doubleUpCards
			maxDoubleUps = locks[lockSelected].doubleUpCards
			minFreezes = locks[lockSelected].freezeCards
			maxFreezes = locks[lockSelected].freezeCards
			minGreens = locks[lockSelected].greenCards
			maxGreens = locks[lockSelected].greenCards
			minReds = locks[lockSelected].redCards
			maxReds = locks[lockSelected].redCards
			minResets = locks[lockSelected].resetCards
			maxResets = locks[lockSelected].resetCards
			minStickies = locks[lockSelected].stickyCards
			maxStickies = locks[lockSelected].stickyCards
			minYellowsRandom = 0
			maxYellowsRandom = 0
			minYellowsAdd = 0
			maxYellowsAdd = 0
			minYellowsMinus = 0
			maxYellowsMinus = 0
			minYellowsAdd1 = locks[lockSelected].noOfAdd1Cards
			maxYellowsAdd1 = locks[lockSelected].noOfAdd1Cards
			minYellowsAdd2 = locks[lockSelected].noOfAdd2Cards
			maxYellowsAdd2 = locks[lockSelected].noOfAdd2Cards
			minYellowsAdd3 = locks[lockSelected].noOfAdd3Cards
			maxYellowsAdd3 = locks[lockSelected].noOfAdd3Cards
			minYellowsMinus1 = locks[lockSelected].noOfMinus1Cards
			maxYellowsMinus1 = locks[lockSelected].noOfMinus1Cards
			minYellowsMinus2 = locks[lockSelected].noOfMinus2Cards
			maxYellowsMinus2 = locks[lockSelected].noOfMinus2Cards
			multipleGreensRequired = locks[lockSelected].multipleGreensRequired
			regularity# = locks[lockSelected].regularity#
			resetFrequencyInSeconds = locks[lockSelected].resetFrequencyInSeconds
			simulationInitialDoubleUps = locks[lockSelected].initialDoubleUpCards
			simulationInitialFreezes = locks[lockSelected].initialFreezeCards
			simulationInitialGreens = locks[lockSelected].initialGreenCards
			simulationInitialReds = locks[lockSelected].initialRedCards
			simulationInitialResets = locks[lockSelected].initialResetCards
			simulationInitialStickies = locks[lockSelected].initialStickyCards
			simulationInitialYellowsAdd1 = locks[lockSelected].initialYellowAdd1Cards
			simulationInitialYellowsAdd2 = locks[lockSelected].initialYellowAdd2Cards
			simulationInitialYellowsAdd3 = locks[lockSelected].initialYellowAdd3Cards
			simulationInitialYellowsMinus1 = locks[lockSelected].initialYellowMinus1Cards
			simulationInitialYellowsMinus2 = locks[lockSelected].initialYellowMinus2Cards
			simulationAverageMinutesLocked = 0
			simulationAverageNoOfTurns = 0
			simulationAverageNoOfCardsDrawn = 0
			simulationAverageNoOfLockResets = 0
			simulationBestCaseMinutesLocked = 9999999999
			simulationBestCaseNoOfTurns = 9999999999
			simulationBestCaseNoOfCardsDrawn = 9999999999
			simulationBestCaseNoOfLockResets = 9999999999
			simulationSecondsUntilUnfreezes = 0
			if (locks[lockSelected].lockFrozenByCard = 1 and locks[lockSelected].timestampUnfreezes > timestampNow) then simulationSecondsUntilUnfreezes = locks[lockSelected].timestampUnfreezes - timestampNow
			simulationWorstCaseMinutesLocked = 0
			simulationWorstCaseNoOfTurns = 0
			simulationWorstCaseNoOfCardsDrawn = 0
			simulationWorstCaseNoOfLockResets = 0
			if (locks[lockSelected].maximumRedCards = 0)
				simulationMinimumRedCards = 1
			elseif (locks[lockSelected].minimumRedCards = locks[lockSelected].maximumRedCards)
				simulationMinimumRedCards = 1
			else
				simulationMinimumRedCards = locks[lockSelected].minimumRedCards
				//simulationMinimumRedCards = simulationMinimumRedCards - floor((timestampNow - locks[lockSelected].timestampLocked) / (locks[lockSelected].regularity# * 3600))
				//if (simulationMinimumRedCards < 1) then simulationMinimumRedCards = 1
			endif
			if (locks[lockSelected].timestampLastFullReset > locks[lockSelected].timestampLocked)
				simulationMinimumRedCards = simulationMinimumRedCards - floor((timestampNow - locks[lockSelected].timestampLastFullReset) / (locks[lockSelected].regularity# * 3600))	
			else
				simulationMinimumRedCards = simulationMinimumRedCards - floor((timestampNow - locks[lockSelected].timestampLocked) / (locks[lockSelected].regularity# * 3600))
			endif
			if (simulationMinimumRedCards < 1) then simulationMinimumRedCards = 0
		endif
		
		if (simulationCount > 0)
			RunSimulation(0)
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
				OryUIUpdateText(currentLockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
				continue
			endif
			currentLockChartTitle$ as string : currentLockChartTitle$ = ""
			currentLockBestCase as integer : currentLockBestCase = 0
			currentLockAverageCase as integer : currentLockAverageCase = 0
			currentLockWorstCase as integer : currentLockWorstCase = 0
			if (i = 1)
				if (locks[lockSelected].regularity# = 24 or ((simulationAverageMinutesLocked / simulationsToTry) / 60) >= 168)
					currentLockChartTitle$ = "Number of days left"
					currentLockBestCase = simulationBestCaseMinutesLocked / 60 / 24
					currentLockAverageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60 / 24
					currentLockWorstCase = simulationWorstCaseMinutesLocked / 60 / 24
				else
					currentLockChartTitle$ = "Number of hours left"
					currentLockBestCase = simulationBestCaseMinutesLocked / 60
					currentLockAverageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60
					currentLockWorstCase = simulationWorstCaseMinutesLocked / 60
				endif
			endif
			if (i = 2)
				currentLockChartTitle$ = "Number of chances left"
				currentLockBestCase = simulationBestCaseNoOfTurns
				currentLockAverageCase = simulationAverageNoOfTurns / simulationsToTry
				currentLockWorstCase = simulationWorstCaseNoOfTurns
			endif
			if (i = 3)
				currentLockChartTitle$ = "Number of cards drawn"
				currentLockBestCase = simulationBestCaseNoOfCardsDrawn
				currentLockAverageCase = simulationAverageNoOfCardsDrawn / simulationsToTry
				currentLockWorstCase = simulationWorstCaseNoOfCardsDrawn
			endif
			if (i = 4)
				currentLockChartTitle$ = "Number of resets (card and scheduled)"
				currentLockBestCase = simulationBestCaseNoOfLockResets
				currentLockAverageCase = simulationAverageNoOfLockResets / simulationsToTry
				currentLockWorstCase = simulationWorstCaseNoOfLockResets
			endif
			currentLockMin as integer : currentLockMin = RoundDownWithReducedPrecision(currentLockBestCase)
			currentLockMax as integer : currentLockMax = RoundUpWithReducedPrecision(currentLockWorstCase)
			currentLockBestCaseWidth# as float : currentLockBestCaseWidth# = (70.0 / (currentLockMax - currentLockMin)) * (currentLockBestCase - currentLockMin)
			currentLockAverageCaseWidth# as float : currentLockAverageCaseWidth# = (70.0 / (currentLockMax - currentLockMin)) * (currentLockAverageCase - currentLockMin)
			currentLockWorstCaseWidth# as float : currentLockWorstCaseWidth# = (70.0 / (currentLockMax - currentLockMin)) * (currentLockWorstCase - currentLockMin)
			OryUIUpdateText(currentLockEstimations[i].txtChartTitle, "text:" + currentLockChartTitle$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			elementY# = elementY# + GetTextTotalHeight(currentLockEstimations[i].txtChartTitle) + 1
			OryUIUpdateSprite(currentLockEstimations[i].sprBackground, "position:" + str((screenNo * 100) + 15) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			OryUIUpdateSprite(currentLockEstimations[i].sprBestCaseBar, "width:" + str(currentLockBestCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 0.5) + ";colorID:" + str(theme[themeSelected].color[2]))
			OryUIUpdateSprite(currentLockEstimations[i].sprAverageCaseBar, "width:" + str(currentLockAverageCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 3) + ";colorID:" + str(theme[themeSelected].color[3]))
			OryUIUpdateSprite(currentLockEstimations[i].sprWorstCaseBar, "width:" + str(currentLockWorstCaseWidth#) + ";position:" + str((screenNo * 100) + 15) + "," + str(elementY# + 5.5) + ";colorID:" + str(theme[themeSelected].color[4]))
			OryUIUpdateText(currentLockEstimations[i].txtBestCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(currentLockEstimations[i].txtAverageCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(currentLockEstimations[i].txtWorstCaseTitle, "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(currentLockEstimations[i].txtBestCaseLabel, "text:" + str(currentLockBestCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(currentLockEstimations[i].txtAverageCaseLabel, "text:" + str(currentLockAverageCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(currentLockEstimations[i].txtWorstCaseLabel, "text:" + str(currentLockWorstCase) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtBestCaseTitle, currentLockEstimations[i].sprBestCaseBar, -(GetTextTotalWidth(currentLockEstimations[i].txtBestCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtAverageCaseTitle, currentLockEstimations[i].sprAverageCaseBar, -(GetTextTotalWidth(currentLockEstimations[i].txtAverageCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtWorstCaseTitle, currentLockEstimations[i].sprWorstCaseBar, -(GetTextTotalWidth(currentLockEstimations[i].txtWorstCaseTitle) + 1), 0)
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtBestCaseLabel, currentLockEstimations[i].sprBestCaseBar, GetSpriteWidth(currentLockEstimations[i].sprBestCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtAverageCaseLabel, currentLockEstimations[i].sprAverageCaseBar, GetSpriteWidth(currentLockEstimations[i].sprAverageCaseBar) + 2, 0)
			OryUIPinTextToCentreLeftOfSprite(currentLockEstimations[i].txtWorstCaseLabel, currentLockEstimations[i].sprWorstCaseBar, GetSpriteWidth(currentLockEstimations[i].sprWorstCaseBar) + 2, 0)
			if (simulationCount = 0)
				OryUIPinSpriteToSprite(currentLockEstimations[i].sprChartOverlay, currentLockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(currentLockEstimations[i].txtRunningSimulation, "text:Simulation Ready to Run")
				OryUIPinTextToCentreOfSprite(currentLockEstimations[i].txtRunningSimulation, currentLockEstimations[i].sprChartOverlay, 0, 0)
			elseif (simulationCount < simulationsToTry)
				OryUIPinSpriteToSprite(currentLockEstimations[i].sprChartOverlay, currentLockEstimations[i].sprBackground, 0, 0)
				OryUIUpdateText(currentLockEstimations[i].txtRunningSimulation, "text:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry))
				OryUIPinTextToCentreOfSprite(currentLockEstimations[i].txtRunningSimulation, currentLockEstimations[i].sprChartOverlay, 0, 0)
			else
				OryUIUpdateSprite(currentLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			endif
			elementY# = elementY# + GetSpriteHeight(currentLockEstimations[i].sprBackground) + 2
		next
		if (simulationRan = 0)
			OryUIUpdateButton(btnRerunCurrentLockSimulation, "text:Run Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		else
			OryUIUpdateButton(btnRerunCurrentLockSimulation, "text:Rerun Simulation;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif	
		elementY# = elementY# + OryUIGetButtonHeight(btnRerunCurrentLockSimulation) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCurrentLockEstimations, "position:-1000,-1000")
			for i = 1 to 4
				OryUIUpdateText(currentLockEstimations[i].txtChartTitle, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprBackground, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtBestCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtAverageCaseTitle, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtWorstCaseTitle, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprBestCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprAverageCaseBar, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprWorstCaseBar, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtBestCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtAverageCaseLabel, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtWorstCaseLabel, "position:-1000,-1000")
				OryUIUpdateSprite(currentLockEstimations[i].sprChartOverlay, "position:-1000,-1000")
				OryUIUpdateText(currentLockEstimations[i].txtRunningSimulation, "position:-1000,-1000")
			next
			OryUIUpdateButton(btnRerunCurrentLockSimulation, "position:-1000,-1000")
		endif
	endif
	if (OryUIGetButtonReleased(btnRerunCurrentLockSimulation))
		simulationCount = 0
		RunSimulation(0)
	endif
	
	// ADD TIME
	inputSpinnerTotalMinutes as integer
	inputSpinnerTotalReds as integer
	if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdAddTimeToLock, "headerText:Add Time?;supportingText:This can not be undone once time has been added.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			inputSpinnerTotalMinutesMin as integer : inputSpinnerTotalMinutesMin = 0
			inputSpinnerTotalMinutesMax as integer : inputSpinnerTotalMinutesMax = 0
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdAddTimeToLock)

		if (locks[lockSelected].lockFrozenByKeyholder = 1)
			// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
			if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLocked + locks[lockSelected].totalTimeFrozen + (60 * locks[lockSelected].minutes)) - locks[lockSelected].timestampFrozenByKeyholder
		else
			// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
			if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLocked + locks[lockSelected].totalTimeFrozen + (60 * locks[lockSelected].minutes)) - timestampNow
		endif
		dd = floor(secondsLeft / 60 / 60 / 24)
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMinAddTimeToLock, "headerText:Minimum time to add;headerTextAlignment:center;headerTextSize:3;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMinAddTimeToLock)
		
		inputSpinnerDaysMin as integer
		inputSpinnerDaysMax as integer
		inputSpinnerHoursMin as integer
		inputSpinnerHoursMax as integer
		inputSpinnerMinutesMin as integer
		inputSpinnerMinutesMax as integer
		if (locks[lockSelected].timerHidden = 1)
			inputSpinnerDaysMin = 0
			inputSpinnerDaysMax = 399
			inputSpinnerHoursMin = 0
			inputSpinnerHoursMax = 23
			inputSpinnerMinutesMin = 0
			inputSpinnerMinutesMax = 59
		else
			inputSpinnerDaysMin = 0
			inputSpinnerDaysMax = 399 - dd
			inputSpinnerHoursMin = 0
			inputSpinnerHoursMax = 23
			inputSpinnerMinutesMin = 0
			inputSpinnerMinutesMax = 59
			if (inputSpinnerDaysMax = 0) then inputSpinnerHoursMax = 23 - hh
			if (inputSpinnerHoursMax = 0) then inputSpinnerMinutesMax = 59 - mm
		endif
		
		inputSpinnerTotalMinutesMin = (val(OryUIGetInputSpinnerString(spinMinAddNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMinAddNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMinAddNumberOfMinutes))
		if (locks[lockSelected].timerHidden = 1)
			if (inputSpinnerTotalMinutesMin + (secondsLeft / 60) > 576000)
				inputSpinnerTotalMinutesMin = inputSpinnerTotalMinutesMin - ((inputSpinnerTotalMinutesMin + (secondsLeft / 60)) - 576000)
			endif
		endif
		inputSpinnerTotalMinutesMax = (val(OryUIGetInputSpinnerString(spinMaxAddNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMaxAddNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMaxAddNumberOfMinutes))
		if (locks[lockSelected].timerHidden = 1)
			if (inputSpinnerTotalMinutesMax + (secondsLeft / 60) > 576000)
				inputSpinnerTotalMinutesMax = inputSpinnerTotalMinutesMax - ((inputSpinnerTotalMinutesMax + (secondsLeft / 60)) - 576000)
			endif
		endif
		
		if (inputSpinnerTotalMinutesMin + 1440 > inputSpinnerTotalMinutesMax)
			inputSpinnerDaysMax = OryUIGetInputSpinnerInteger(spinMinAddNumberOfDays)
		endif
		if (inputSpinnerTotalMinutesMin + 60 > inputSpinnerTotalMinutesMax)
			inputSpinnerHoursMax = OryUIGetInputSpinnerInteger(spinMinAddNumberOfHours)
		endif
		if (inputSpinnerTotalMinutesMin + 1 > inputSpinnerTotalMinutesMax)
			inputSpinnerMinutesMax = OryUIGetInputSpinnerInteger(spinMinAddNumberOfMinutes)
		endif
		
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinAddNumberOfDays, "inputText:0;position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMinAddNumberOfHours, "inputText:0;position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMinAddNumberOfMinutes, "inputText:0;step:1;position:" + str((screenNo * 100) + 66.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinAddDays, "position:" + str(OryUIGetInputSpinnerX(spinMinAddNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMinAddNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinAddHours, "position:" + str(OryUIGetInputSpinnerX(spinMinAddNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMinAddNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMinAddMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMinAddNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMinAddNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinAddNumberOfDays) + 2
		OryUIUpdateInputSpinner(spinMinAddNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax))
		OryUIUpdateInputSpinner(spinMinAddNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax))
		OryUIUpdateInputSpinner(spinMinAddNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax))
		OryUIInsertInputSpinnerListener(spinMinAddNumberOfDays)
		OryUIInsertInputSpinnerListener(spinMinAddNumberOfHours)
		OryUIInsertInputSpinnerListener(spinMinAddNumberOfMinutes)
		if (OryUIGetInputSpinnerHasFocus(spinMinAddNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMinAddNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMinAddNumberOfMinutes))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinAddTimeToLock) - GetSpriteY(screen[screenNo].sprPage))
		endif

		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMaxAddTimeToLock, "headerText:Maximum time to add;headerTextAlignment:center;headerTextSize:3;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMaxAddTimeToLock)
		
		if (locks[lockSelected].timerHidden = 1)
			inputSpinnerDaysMin = 0
			inputSpinnerDaysMax = 399
			inputSpinnerHoursMin = 0
			inputSpinnerHoursMax = 23
			inputSpinnerMinutesMin = 0
			inputSpinnerMinutesMax = 59
		else
			inputSpinnerDaysMin = 0
			inputSpinnerDaysMax = 399 - dd
			inputSpinnerHoursMin = 0
			inputSpinnerHoursMax = 23
			inputSpinnerMinutesMin = 0
			inputSpinnerMinutesMax = 59
			if (inputSpinnerDaysMax = 0) then inputSpinnerHoursMax = 23 - hh
			if (inputSpinnerHoursMax = 0) then inputSpinnerMinutesMax = 59 - mm
		endif

		inputSpinnerTotalMinutesMin = (val(OryUIGetInputSpinnerString(spinMinAddNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMinAddNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMinAddNumberOfMinutes))
		if (locks[lockSelected].timerHidden = 1)
			if (inputSpinnerTotalMinutesMin + (secondsLeft / 60) > 576000)
				inputSpinnerTotalMinutesMin = inputSpinnerTotalMinutesMin - ((inputSpinnerTotalMinutesMin + (secondsLeft / 60)) - 576000)
			endif
		endif
		inputSpinnerTotalMinutesMax = (val(OryUIGetInputSpinnerString(spinMaxAddNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMaxAddNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMaxAddNumberOfMinutes))
		if (locks[lockSelected].timerHidden = 1)
			if (inputSpinnerTotalMinutesMax + (secondsLeft / 60) > 576000)
				inputSpinnerTotalMinutesMax = inputSpinnerTotalMinutesMax - ((inputSpinnerTotalMinutesMax + (secondsLeft / 60)) - 576000)
			endif
		endif
		
		if (inputSpinnerTotalMinutesMax - 1440 < inputSpinnerTotalMinutesMin)
			inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfDays)
		endif
		if (inputSpinnerTotalMinutesMax - 60 < inputSpinnerTotalMinutesMin)
			inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfHours)
		endif
		if (inputSpinnerTotalMinutesMax - 1 < inputSpinnerTotalMinutesMin)
			inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfMinutes)
		endif	
		
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMaxAddNumberOfDays, "inputText:0;position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxAddNumberOfHours, "inputText:0;position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxAddNumberOfMinutes, "inputText:0;step:1;position:" + str((screenNo * 100) + 66.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxAddDays, "position:" + str(OryUIGetInputSpinnerX(spinMaxAddNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMaxAddNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxAddHours, "position:" + str(OryUIGetInputSpinnerX(spinMaxAddNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMaxAddNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtMaxAddMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMaxAddNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMaxAddNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMaxAddNumberOfDays) + 2
		OryUIUpdateInputSpinner(spinMaxAddNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax))
		OryUIUpdateInputSpinner(spinMaxAddNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax))
		OryUIUpdateInputSpinner(spinMaxAddNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax))
		OryUIInsertInputSpinnerListener(spinMaxAddNumberOfDays)
		OryUIInsertInputSpinnerListener(spinMaxAddNumberOfHours)
		OryUIInsertInputSpinnerListener(spinMaxAddNumberOfMinutes)
		if (OryUIGetInputSpinnerHasFocus(spinMaxAddNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMaxAddNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMaxAddNumberOfMinutes))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMaxAddTimeToLock) - GetSpriteY(screen[screenNo].sprPage))
		endif

		// CORRECT MIN VALUES IF GREATER THAN MAX
		if (inputSpinnerTotalMinutesMin > inputSpinnerTotalMinutesMax)
			inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfDays)
			inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfHours)
			inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxAddNumberOfMinutes)
			OryUIUpdateInputSpinner(spinMinAddNumberOfDays, "inputText:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMin))
			OryUIUpdateInputSpinner(spinMinAddNumberOfHours, "inputText:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMin))
			OryUIUpdateInputSpinner(spinMinAddNumberOfMinutes, "inputText:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMin))
		endif
	
		if (inputSpinnerTotalMinutesMin > 0 or inputSpinnerTotalMinutesMax > 0)
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif	
	else
		if (redrawScreen = 1)
			inputSpinnerTotalMinutes = 0
			inputSpinnerTotalReds = 0
			OryUIUpdateTextCard(crdAddTimeToLock, "position:-1000,-1000")
			OryUIUpdateTextCard(crdMinAddTimeToLock, "position:-1000,-1000")
			OryUIUpdateText(txtMinAddDays, "position:-1000,-1000")
			OryUIUpdateText(txtMinAddHours, "position:-1000,-1000")
			OryUIUpdateText(txtMinAddMinutes, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinAddNumberOfDays, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinAddNumberOfHours, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinAddNumberOfMinutes, "position:-1000,-1000")
			OryUIUpdateTextCard(crdMaxAddTimeToLock, "position:-1000,-1000")
			OryUIUpdateText(txtMaxAddDays, "position:-1000,-1000")
			OryUIUpdateText(txtMaxAddHours, "position:-1000,-1000")
			OryUIUpdateText(txtMaxAddMinutes, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxAddNumberOfDays, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxAddNumberOfHours, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxAddNumberOfMinutes, "position:-1000,-1000")
		endif
	endif

	// TEST LOCK?
	if ((locks[lockSelected].keyholderUsername$ = "" or locks[lockSelected].botChosen > 0) and ((locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# >= 0.25) or locks[lockSelected].fixed = 1) and ((locks[lockSelected].test = 0 and timestampNow - locks[lockSelected].timestampLocked <= 86400) or locks[lockSelected].test = 1) and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdTestLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpTestLock) = "Yes")
				testLock = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpTestLock) = "No")
				testLock = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdTestLock)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpTestLock, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpTestLock)
		if (OryUIGetButtonGroupItemReleasedIndex(grpTestLock) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (testLock <> locks[lockSelected].test)
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpTestLock) + 2
	else
		if (redrawScreen = 1)
			testLock = locks[lockSelected].test
			OryUIUpdateTextCard(crdTestLock, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpTestLock, "position:-1000,-1000")
		endif
	endif
	
	// TRUST THE KEYHOLDER?
	if (locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].trustKeyholder = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdTrustTheKeyholder, "headerText:Do you trust " + locks[lockSelected].keyholderUsername$ + "?;supportingText:Trusting the keyholder will remove all limitations from them as your keyholder on this lock and any other locks within the same group that may have been created at the same time i.e. fake copies. This means that they can add/remove as much time as they want, and as often as they want. It also means that the lock can run for a lot longer than you expected. This can not be undone once changed.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdTrustTheKeyholder)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpTrustTheKeyholder, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpTrustTheKeyholder)
		if (OryUIGetButtonGroupItemReleasedIndex(grpTrustTheKeyholder) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpTrustTheKeyholder) = "Yes")
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpTrustTheKeyholder) + 2
	else
		OryUIUpdateTextCard(crdTrustTheKeyholder, "position:-1000,-1000")
		OryUIUpdateButtonGroup(grpTrustTheKeyholder, "position:-1000,-1000")
	endif

	// BLOCK BOT FROM UNLOCKING
	if (locks[lockSelected].botChosen > 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdBlockBotFromUnlockingEarly, "headerText:Block " + locks[lockSelected].keyholderUsername$ + " from unlocking you?;supportingText:If yes, " + locks[lockSelected].keyholderUsername$ + " won't unlock this lock. This is useful if you don't want the bot to unlock you too early. You can change this option at any time.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdBlockBotFromUnlockingEarly)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpBlockBotFromUnlockingEarly, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpBlockBotFromUnlockingEarly)
		if (OryUIGetButtonGroupItemReleasedIndex(grpBlockBotFromUnlockingEarly) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if ((OryUIGetButtonGroupItemSelectedName(grpBlockBotFromUnlockingEarly) = "Yes" and locks[lockSelected].blockBotFromUnlocking = 0) or (OryUIGetButtonGroupItemSelectedName(grpBlockBotFromUnlockingEarly) = "No" and locks[lockSelected].blockBotFromUnlocking = 1))
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpBlockBotFromUnlockingEarly) + 2
	else
		OryUIUpdateTextCard(crdBlockBotFromUnlockingEarly, "position:-1000,-1000")
		OryUIUpdateButtonGroup(grpBlockBotFromUnlockingEarly, "position:-1000,-1000")
	endif
	
	// DISABLE KEYS?
	if (locks[lockSelected].keyDisabled = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
		if (redrawScreen = 1)
			if (locks[lockSelected].keyholderUsername$ <> "")
				OryUIUpdateTextCard(crdDisableKeys, "supportingText:If disabled you won't be able to purchase digital keys to unlock early if you need to in an emergency. It will disable keys on all locks within the same group of locks that were created at the same time, if fake copies were created. It's recommended to leave the keys enabled if this is the first time you've locked with this keyholder. This can not be undone once changed.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdDisableKeys, "supportingText:If disabled you won't be able to purchase digital keys to unlock early if you need to in an emergency. It will disable keys on all locks within the same group of locks that were created at the same time, if fake copies were created. This can not be undone once changed.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif	
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDisableKeys)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDisableKeys, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpDisableKeys)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDisableKeys) > 0)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpDisableKeys) = "Yes")
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDisableKeys) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDisableKeys, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDisableKeys, "position:-1000,-1000")
		endif
	endif
	
	// INCREASE NUMBER OF KEYS REQUIRED FOR EMERGENCY RELEASE?
	if (locks[lockSelected].keyDisabled = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0 and OryUIGetButtonGroupItemSelectedName(grpDisableKeys) = "No")
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdIncreaseNumberOfKeysRequired, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdIncreaseNumberOfKeysRequired)
		if (redrawScreen = 1)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtIncreaseNumberOfKeysRequired) + 1
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinIncreaseNumberOfKeysRequired, "min:" + str(locks[lockSelected].noOfKeysRequired) + ";max:50;position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinIncreaseNumberOfKeysRequired) + 2
		OryUIInsertInputSpinnerListener(spinIncreaseNumberOfKeysRequired)
		if (OryUIGetInputSpinnerHasFocus(spinIncreaseNumberOfKeysRequired))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdIncreaseNumberOfKeysRequired) - GetSpriteY(screen[screenNo].sprPage))
		endif
		noOfKeysRequired = val(OryUIGetInputSpinnerString(spinIncreaseNumberOfKeysRequired))
		if (noOfKeysRequired = 1)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:1 key required (1 key costs[colon] " + GetInAppPurchaseLocalPrice(1) + ")")
		elseif (noOfKeysRequired < 5)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (2 keys costs[colon] " + GetInAppPurchaseLocalPrice(2) + ")")
		elseif (noOfKeysRequired < 10)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (5 keys costs[colon] " + GetInAppPurchaseLocalPrice(3) + ")")
		elseif (noOfKeysRequired < 25)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (10 keys costs[colon] " + GetInAppPurchaseLocalPrice(4) + ")")
		elseif (noOfKeysRequired < 50)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:" + str(noOfKeysRequired, 0) + " keys required (25 keys costs[colon] " + GetInAppPurchaseLocalPrice(5) + ")")
		elseif (noOfKeysRequired = 50)
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "text:50 keys required (50 keys costs[colon] " + GetInAppPurchaseLocalPrice(6) + ")")
		endif
		if (noOfKeysRequired <> locks[lockSelected].noOfKeysRequired)
			OryUIShowFloatingActionButton(fabSaveLockInformation)
		endif
	else
		if (redrawScreen = 1)
			noOfKeysRequired = locks[lockSelected].noOfKeysRequired
			OryUIUpdateTextCard(crdIncreaseNumberOfKeysRequired, "position:-1000,-1000")
			OryUIUpdateText(txtIncreaseNumberOfKeysRequired, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinIncreaseNumberOfKeysRequired, "inputText:1;position:-1000,-1000")
		endif
	endif
	
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveLockInformation, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	// SAVE BUTTON
	if (OryUIGetFloatingActionButtonReleased(fabSaveLockInformation))
		validUpdate as integer : validUpdate = 1
		logUpdate$ as string : logUpdate$ = ""
		if (OryUIGetTextfieldString(editBoxLockName) <> locks[lockSelected].lockName$)
			if (FindString(OryUIGetTextfieldString(editBoxLockName), "&") or FindString(OryUIGetTextfieldString(editBoxLockName), "="))
				validUpdate = 0
				newLockName$ = OryUIGetTextfieldString(editBoxLockName)
				newLockName$ = ReplaceString(newLockName$, "&", "", -1)
				newLockName$ = ReplaceString(newLockName$, "=", "", -1)
				OryUIUpdateTextfield(editBoxLockName, "inputText:" + newLockName$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Lock Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Lock names can't contain the following characters[colon] & and =." + chr(10) + chr(10) + "For your convenience all instances of these characters have been removed (but not yet saved).;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (len(OryUIGetTextfieldString(editBoxLockName)) = 0)
				OryUIUpdateTextfield(editBoxLockName, "inputText:" + locks[lockSelected].lockName$)
			elseif (len(OryUIGetTextfieldString(editBoxLockName)) > 25)
				validUpdate = 0
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Lock Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Lock names should be less than 26 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif	
		endif
		if (validUpdate = 1)
			if (OryUIGetTextfieldString(editBoxLockName) <> locks[lockSelected].lockName$)
				newLockName$ = OryUIGetTextfieldString(editBoxLockName)
				locks[lockSelected].lockName$ = newLockName$
			endif
			if ((locks[lockSelected].keyholderUsername$ = "" or locks[lockSelected].botChosen > 0) and ((locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# >= 0.25) or locks[lockSelected].fixed = 1) and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
				if (locks[lockSelected].test = 0 and OryUIGetButtonGroupItemSelectedName(grpTestLock) = "Yes")
					locks[lockSelected].test = 1
				elseif (locks[lockSelected].test = 1 and OryUIGetButtonGroupItemSelectedName(grpTestLock) = "No")
					locks[lockSelected].test = 0
				endif
			endif
			if (locks[lockSelected].trustKeyholder = 0)
				if (OryUIGetButtonGroupItemSelectedName(grpTrustTheKeyholder) = "Yes")
					locks[lockSelected].trustKeyholder = 1
					for i = 1 to noOfLocks
						if (locks[i].groupID = locks[lockSelected].groupID and i <> lockSelected)
							locks[i].trustKeyholder = 1
						endif
					next
				endif
			endif
			if (locks[lockSelected].botChosen > 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].readyToUnlock = 0)
				if (locks[lockSelected].blockBotFromUnlocking = 0 and OryUIGetButtonGroupItemSelectedName(grpBlockBotFromUnlockingEarly) = "Yes")
					locks[lockSelected].blockBotFromUnlocking = 1
				elseif (locks[lockSelected].blockBotFromUnlocking = 1 and OryUIGetButtonGroupItemSelectedName(grpBlockBotFromUnlockingEarly) = "No")
					locks[lockSelected].blockBotFromUnlocking = 0
				endif
			endif
			if (locks[lockSelected].keyDisabled = 0)
				if (OryUIGetButtonGroupItemSelectedName(grpDisableKeys) = "Yes")
					locks[lockSelected].keyDisabled = 1
					for i = 1 to noOfLocks
						if (locks[i].groupID = locks[lockSelected].groupID and i <> lockSelected)
							locks[i].keyDisabled = 1
						endif
					next
				else
					if (noOfKeysRequired <> locks[lockSelected].noOfKeysRequired)
						locks[lockSelected].noOfKeysRequired = noOfKeysRequired
						for i = 1 to noOfLocks
							if (locks[i].groupID = locks[lockSelected].groupID and i <> lockSelected)
								locks[i].noOfKeysRequired = noOfKeysRequired
							endif
						next
					endif
				endif
			endif
			if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667)
				if (inputSpinnerTotalMinutesMin > 0 or inputSpinnerTotalMinutesMax > 0)
					minutesToAdd as integer : minutesToAdd = random2(inputSpinnerTotalMinutesMin, inputSpinnerTotalMinutesMax)
					if (minutesToAdd = 0) then minutesToAdd = 1
					locks[lockSelected].minutes = locks[lockSelected].minutes + minutesToAdd
					locks[lockSelected].minutesAdded = locks[lockSelected].minutesAdded + minutesToAdd
					logUpdate$ = "action:AddedTime;actionedBy:Lockee;result:" + str(minutesToAdd)
					OryUIUpdateInputSpinner(spinMinAddNumberOfDays, "inputText:0")
					OryUIUpdateInputSpinner(spinMinAddNumberOfHours, "inputText:0")
					OryUIUpdateInputSpinner(spinMinAddNumberOfMinutes, "inputText:0")
					OryUIUpdateInputSpinner(spinMaxAddNumberOfDays, "inputText:0")
					OryUIUpdateInputSpinner(spinMaxAddNumberOfHours, "inputText:0")
					OryUIUpdateInputSpinner(spinMaxAddNumberOfMinutes, "inputText:0")
				endif
			endif
			UpdateLocksData(lockSelected)
			UpdateLocksDatabase(lockSelected, logUpdate$, 1)
			for i = 1 to noOfLocks
				if (locks[i].groupID = locks[lockSelected].groupID and i <> lockSelected)
					UpdateLocksData(i)
					UpdateLocksDatabase(i, "", 1)
				endif
			next
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockInformationScreen)
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
