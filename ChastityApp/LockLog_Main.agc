
if (screenToView = constLockLogScreen)
	if (screenNo <> constLockLogScreen)
		filterLogByLabel$ as string : filterLogByLabel$ = ""
		if (imgListAddedCards = 0) then imgListAddedCards = LoadImage("ListAddedCards.png")
		if (imgListAddedTime = 0) then imgListAddedTime = LoadImage("ListAddedTime.png")
		if (imgListAutoResetLock = 0) then imgListAutoResetLock = LoadImage("ListAutoResetLock.png")
		if (imgListBlank = 0) then imgListBlank = LoadImage("ListBlank.png")
		if (imgListCheckedIn = 0) then imgListCheckedIn = LoadImage("ListCheckedIn.png")
		if (imgListCheckedInLate = 0) then imgListCheckedInLate = LoadImage("ListCheckedInLate.png")
		if (imgListDeletedLock = 0) then imgListDeletedLock = LoadImage("ListDeletedLock.png")
		if (imgListDoubleUpCard = 0) then imgListDoubleUpCard = LoadImage("ListDoubleUpCard.png")
		if (imgListFreezeCard = 0) then imgListFreezeCard = LoadImage("ListFreezeCard.png")
		if (imgListFrozen = 0) then imgListFrozen = LoadImage("ListFrozen.png")
		if (imgListGoAgainCard = 0) then imgListGoAgainCard = LoadImage("ListGoAgainCard.png")
		if (imgListGreenCard = 0) then imgListGreenCard = LoadImage("ListGreenCard.png")
		if (imgListHidden = 0) then imgListHidden = LoadImage("ListHidden.png")
		if (imgListHiddenWhite = 0) then imgListHiddenWhite = LoadImage("ListHiddenWhite.png")
		if (imgListLocked = 0) then imgListLocked = LoadImage("ListLocked.png")
		if (imgListOldVersion = 0) then imgListOldVersion = LoadImage("ListOldVersion.png")
		if (imgListRatedLock = 0) then imgListRatedLock = LoadImage("ListRatedLock.png")
		if (imgListRedCard = 0) then imgListRedCard = LoadImage("ListRedCard.png")
		if (imgListRemovedCards = 0) then imgListRemovedCards = LoadImage("ListRemovedCards.png")
		if (imgListRemovedTime = 0) then imgListRemovedTime = LoadImage("ListRemovedTime.png")
		if (imgListResetCard = 0) then imgListResetCard = LoadImage("ListResetCard.png")
		if (imgListResetLock = 0) then imgListResetLock = LoadImage("ListResetLock.png")
		if (imgListRestoredLock = 0) then imgListRestoredLock = LoadImage("ListRestoredLock.png")
		if (imgListStickyCard = 0) then imgListStickyCard = LoadImage("ListStickyCard.png")
		if (imgListUnfrozen = 0) then imgListUnfrozen = LoadImage("ListUnfrozen.png")
		if (imgListUnlocked = 0) then imgListUnlocked = LoadImage("ListUnlocked.png")
		if (imgListUpdateHidden = 0) then imgListUpdateHidden = LoadImage("ListUpdateHidden.png")
		if (imgListVisible = 0) then imgListVisible = LoadImage("ListVisible.png")
		if (imgListVisibleWhite = 0) then imgListVisibleWhite = LoadImage("ListVisibleWhite.png")
		if (imgListYellowAdd1Card = 0) then imgListYellowAdd1Card = LoadImage("ListYellowAdd1Card.png")
		if (imgListYellowAdd2Card = 0) then imgListYellowAdd2Card = LoadImage("ListYellowAdd2Card.png")
		if (imgListYellowAdd3Card = 0) then imgListYellowAdd3Card = LoadImage("ListYellowAdd3Card.png")
		if (imgListYellowMinus1Card = 0) then imgListYellowMinus1Card = LoadImage("ListYellowMinus1Card.png")
		if (imgListYellowMinus2Card = 0) then imgListYellowMinus2Card = LoadImage("ListYellowMinus2Card.png")
		iterationOffset = 0
		lastFilterCount = -1
		sortLogByLabel$ as string : sortLogByLabel$ = ""
	endif
	screenNo = constLockLogScreen
	
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
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		locks[lockSelected].lockLog.length = -1
		GetLockLog(lockSelected, 1)
		SetScreenToView(constLockLogScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		SetScreenToView(constLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterLogBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterLog, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLogBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredLogBy, "text:" + filterLogByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterLog) + OryUIGetButtonWidth(btnIconFilterLog)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLogBar) / 2)))
	OryUIUpdateButton(btnIconSortLog, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortLog)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLogBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextSortedLogBy, "text:" + sortLogByLabel$ + " (" + sortLogOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortLog) - OryUIGetButtonWidth(btnTextSortedLogBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLogBar) / 2)))
	OryUIUpdateSprite(sprFilterLogBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterLogBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterLogBar)

	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		locks[lockSelected].lockLog.length = -1
		GetLockLog(lockSelected, 1)
		SetScreenToView(constLockLogScreen)
	endif
	
	// FILTER MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterLog, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterLog) or OryUIGetButtonReleased(btnTextFilteredLogBy))
		if (locks[lockSelected].fixed = 0)
			if (locks[lockSelected].sharedID$ <> "")
				OryUISetMenuItemCount(menuFilterLog, 12)
				OryUIUpdateMenuItem(menuFilterLog, 1, "name:FilterLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 2, "name:FilterLogCardsAdded;text:Cards Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 3, "name:FilterLogCardsPicked;text:Cards Picked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 4, "name:FilterLogCardsRemoved;text:Cards Removed;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 5, "name:FilterLogCheckIns;text:Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 6, "name:FilterLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 7, "name:FilterLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 8, "name:FilterLogKeyholderUpdates;text:Keyholder Updates;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 9, "name:FilterLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 10, "name:FilterLogMoodEmojis;text:Mood Emojis;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 11, "name:FilterLogReadyToUnlock;text:Ready to Unlock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 12, "name:FilterLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				if (filterLogBy$ = "FilterLogAll") then OryUIUpdateMenuItem(menuFilterLog, 1, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCardsAdded") then OryUIUpdateMenuItem(menuFilterLog, 2, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCardsPicked") then OryUIUpdateMenuItem(menuFilterLog, 3, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCardsRemoved") then OryUIUpdateMenuItem(menuFilterLog, 4, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCheckIns") then OryUIUpdateMenuItem(menuFilterLog, 5, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogDecisions") then OryUIUpdateMenuItem(menuFilterLog, 6, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterLog, 7, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogKeyholderUpdates") then OryUIUpdateMenuItem(menuFilterLog, 8, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogLockResets") then OryUIUpdateMenuItem(menuFilterLog, 9, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogMoodEmojis") then OryUIUpdateMenuItem(menuFilterLog, 10, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogReadyToUnlock") then OryUIUpdateMenuItem(menuFilterLog, 11, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogStartEnd") then OryUIUpdateMenuItem(menuFilterLog, 12, "rightIconID:" + str(imgTickIcon))
			else
				OryUISetMenuItemCount(menuFilterLog, 8)
				OryUIUpdateMenuItem(menuFilterLog, 1, "name:FilterLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 2, "name:FilterLogCardsAdded;text:Cards Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 3, "name:FilterLogCardsPicked;text:Cards Picked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 4, "name:FilterLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 5, "name:FilterLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 6, "name:FilterLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 7, "name:FilterLogReadyToUnlock;text:Ready to Unlock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 8, "name:FilterLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				if (filterLogBy$ = "FilterLogAll") then OryUIUpdateMenuItem(menuFilterLog, 1, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCardsAdded") then OryUIUpdateMenuItem(menuFilterLog, 2, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCardsPicked") then OryUIUpdateMenuItem(menuFilterLog, 3, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogDecisions") then OryUIUpdateMenuItem(menuFilterLog, 4, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterLog, 5, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogLockResets") then OryUIUpdateMenuItem(menuFilterLog, 6, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogReadyToUnlock") then OryUIUpdateMenuItem(menuFilterLog, 7, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogStartEnd") then OryUIUpdateMenuItem(menuFilterLog, 8, "rightIconID:" + str(imgTickIcon))
			endif
		else
			if (locks[lockSelected].sharedID$ <> "")
				OryUISetMenuItemCount(menuFilterLog, 11)
				OryUIUpdateMenuItem(menuFilterLog, 1, "name:FilterLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 2, "name:FilterLogCheckIns;text:Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 3, "name:FilterLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 4, "name:FilterLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 5, "name:FilterLogKeyholderUpdates;text:Keyholder Updates;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 6, "name:FilterLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 7, "name:FilterLogMoodEmojis;text:Mood Emojis;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 8, "name:FilterLogReadyToUnlock;text:Ready to Unlock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 9, "name:FilterLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 10, "name:FilterLogTimeAdded;text:Time Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 11, "name:FilterLogTimeRemoved;text:Time Removed;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				if (filterLogBy$ = "FilterLogAll") then OryUIUpdateMenuItem(menuFilterLog, 1, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogCheckIns") then OryUIUpdateMenuItem(menuFilterLog, 2, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogDecisions") then OryUIUpdateMenuItem(menuFilterLog, 3, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterLog, 4, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogKeyholderUpdates") then OryUIUpdateMenuItem(menuFilterLog, 5, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogLockResets") then OryUIUpdateMenuItem(menuFilterLog, 6, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogMoodEmojis") then OryUIUpdateMenuItem(menuFilterLog, 7, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogReadyToUnlock") then OryUIUpdateMenuItem(menuFilterLog, 8, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogStartEnd") then OryUIUpdateMenuItem(menuFilterLog, 9, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogTimeAdded") then OryUIUpdateMenuItem(menuFilterLog, 10, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogTimeRemoved") then OryUIUpdateMenuItem(menuFilterLog, 11, "rightIconID:" + str(imgTickIcon))
			else
				OryUISetMenuItemCount(menuFilterLog, 7)
				OryUIUpdateMenuItem(menuFilterLog, 1, "name:FilterLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 2, "name:FilterLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 3, "name:FilterLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 4, "name:FilterLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 5, "name:FilterLogReadyToUnlock;text:Ready to Unlock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 6, "name:FilterLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuFilterLog, 7, "name:FilterLogTimeAdded;text:Time Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				if (filterLogBy$ = "FilterLogAll") then OryUIUpdateMenuItem(menuFilterLog, 1, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogDecisions") then OryUIUpdateMenuItem(menuFilterLog, 2, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterLog, 3, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogLockResets") then OryUIUpdateMenuItem(menuFilterLog, 4, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogReadyToUnlock") then OryUIUpdateMenuItem(menuFilterLog, 5, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogStartEnd") then OryUIUpdateMenuItem(menuFilterLog, 6, "rightIconID:" + str(imgTickIcon))
				if (filterLogBy$ = "FilterLogTimeAdded") then OryUIUpdateMenuItem(menuFilterLog, 7, "rightIconID:" + str(imgTickIcon))
			endif
		endif
		OryUIShowMenu(menuFilterLog, OryUIGetButtonX(btnIconFilterLog), OryUIGetButtonY(btnIconFilterLog) + OryUIGetButtonHeight(btnIconFilterLog))
	endif
	OryUIInsertMenuListener(menuFilterLog)
	if (filterLogByLabel$ = "")
		filterLogBy$ = "FilterLogAll"
		filterLogByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogAll" or filterLogBy$ = "FilterLogAll")
		filterLogBy$ = "FilterLogAll"
		filterLogByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogCardsAdded" or filterLogBy$ = "FilterLogCardsAdded")
		filterLogBy$ = "FilterLogCardsAdded"
		filterLogByLabel$ = "Cards Added"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogCardsPicked" or filterLogBy$ = "FilterLogCardsPicked")
		filterLogBy$ = "FilterLogCardsPicked"
		filterLogByLabel$ = "Cards Picked"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogCardsRemoved" or filterLogBy$ = "FilterLogCardsRemoved")
		filterLogBy$ = "FilterLogCardsRemoved"
		filterLogByLabel$ = "Cards Removed"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogCheckIns" or filterLogBy$ = "FilterLogCheckIns")
		filterLogBy$ = "FilterLogCheckIns"
		filterLogByLabel$ = "Check-Ins"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogDecisions" or filterLogBy$ = "FilterLogDecisions")
		filterLogBy$ = "FilterLogDecisions"
		filterLogByLabel$ = "Decisions"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogFreezeUnfreeze" or filterLogBy$ = "FilterLogFreezeUnfreeze")
		filterLogBy$ = "FilterLogFreezeUnfreeze"
		filterLogByLabel$ = "Freeze / Unfreeze"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogKeyholderUpdates" or filterLogBy$ = "FilterLogKeyholderUpdates")
		filterLogBy$ = "FilterLogKeyholderUpdates"
		filterLogByLabel$ = "Keyholder Updates"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogLockResets" or filterLogBy$ = "FilterLogLockResets")
		filterLogBy$ = "FilterLogLockResets"
		filterLogByLabel$ = "Lock Resets"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogMoodEmojis" or filterLogBy$ = "FilterLogMoodEmojis")
		filterLogBy$ = "FilterLogMoodEmojis"
		filterLogByLabel$ = "Mood Emojis"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogReadyToUnlock" or filterLogBy$ = "FilterLogReadyToUnlock")
		filterLogBy$ = "FilterLogReadyToUnlock"
		filterLogByLabel$ = "Ready to Unlock"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogStartEnd" or filterLogBy$ = "FilterLogStartEnd")
		filterLogBy$ = "FilterLogStartEnd"
		filterLogByLabel$ = "Start & End"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogTimeAdded" or filterLogBy$ = "FilterLogTimeAdded")
		filterLogBy$ = "FilterLogTimeAdded"
		filterLogByLabel$ = "Time Added"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) = "FilterLogTimeRemoved" or filterLogBy$ = "FilterLogTimeRemoved")
		filterLogBy$ = "FilterLogTimeRemoved"
		filterLogByLabel$ = "Time Removed"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLog) <> "")
		SaveLocalVariable("filterLogBy", filterLogBy$)
		SetScreenToView(constLockLogScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortLog, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortLog) or OryUIGetButtonReleased(btnTextSortedLogBy))
		OryUISetMenuItemCount(menuSortLog, 2)
		OryUIUpdateMenuItem(menuSortLog, 1, "name:SortLogByTime;text:Time;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortLog, 2, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortLogBy$ = "SortLogByTime") then OryUIUpdateMenuItem(menuSortLog, 1, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortLog, OryUIGetButtonX(btnIconSortLog), OryUIGetButtonY(btnIconSortLog) + OryUIGetButtonHeight(btnIconSortLog))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortLog, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortLog)
	OryUIInsertMenuListener(menuSortLog)
	if (OryUIGetMenuVisible(menuSortLog))
		OryUIUpdateButtonGroup(grpSortLog, "position:" + str(OryUIGetMenuX(menuSortLog)) + "," + str(OryUIGetMenuY(menuSortLog) + OryUIGetMenuHeight(menuSortLog) - OryUIGetButtonGroupHeight(grpSortLog)))
	else
		OryUIUpdateButtonGroup(grpSortLog, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLog) = "SortLogByTime" or sortLogBy$ = "SortLogByTime")
		sortLogBy$ = "SortLogByTime"
		sortLogByLabel$ = "Time"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLog) <> "")
		SaveLocalVariable("sortLogBy", sortLogBy$)
		SetScreenToView(constLockLogScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortLog, "ASC"))
		sortLogOrder$ = "ASC"
		SaveLocalVariable("sortLogOrder", sortLogOrder$)
		SetScreenToView(constLockLogScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortLog, "DESC"))
		sortLogOrder$ = "DESC"
		SaveLocalVariable("sortLogOrder", sortLogOrder$)
		SetScreenToView(constLockLogScreen)
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// SORT LIST
	if (redrawScreen = 1)
		SortLog()
		contentHeightChanged = 1
	endif
	
	// NO LOG ITEMS
	if (filterCount = 0)
		OryUIUpdateText(txtNoLogItems, "text:No Log Items Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateText(txtNoLogItems, "position:-1000,-1000")
	endif
	
	// LOG LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listLockLog, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listLockLog, maxListItemCount)
		else
			OryUISetListItemCount(listLockLog, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listLockLog, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listLockLog)
	for i = 0 to maxListItemCount - 1
		if (i <= OryUIGetListItemCount(listLockLog) - 1)
			if (locks[lockSelected].lockLog.length >= 0)
				sortedIteration = lockLogSorted[i + iterationOffset].iteration
				
				leftImageID as integer : leftImageID = 0
				line1$ as string : line1$ = ""
				line2$ as string : line2$ = " "
				logItemAction$ as string : logItemAction$ = locks[lockSelected].lockLog[sortedIteration].action$
				logItemActionedBy$ as string : logItemActionedBy$ = locks[lockSelected].lockLog[sortedIteration].actionedBy$
				logItemActionedWhen$ as string : logItemActionedWhen$ = "" 
				logItemHidden as integer : logItemHidden = locks[lockSelected].lockLog[sortedIteration].hidden
				logItemResult$ as string : logItemResult$ = locks[lockSelected].lockLog[sortedIteration].result$
				logItemTimestamp as integer : logItemTimestamp = locks[lockSelected].lockLog[sortedIteration].timestamp
				logItemTotalActionTime as integer : logItemTotalActionTime = locks[lockSelected].lockLog[sortedIteration].totalActionTime
				noOfLeftLines as integer : noOfLeftLines = 1
				//updatesHidden as integer : updatesHidden = 0
				whom1$ as string : whom1$ = ""
				whom2$ as string : whom2$ = ""
				
				if (logItemActionedBy$ = "Lockee")
					whom1$ = "You"
					whom2$ = "Your"
				elseif (logItemActionedBy$ = "Keyholder")
					whom1$ = locks[lockSelected].keyholderUsername$
					whom2$ = locks[lockSelected].keyholderUsername$
				else
					whom1$ = "The app"
					whom2$ = "The app"
				endif
				
				if (logItemAction$ = "AddedCards" or logItemAction$ = "RemovedCards")
					noOfLeftLines = 2
					noOfCardsAdded as integer : noOfCardsAdded = val(GetStringToken(logItemResult$, "*", 1))
					cardType$ as string : cardType$ = ""
					if (locks[lockSelected].fixed = 0)
						if (logItemAction$ = "AddedCards")
							if (noOfCardsAdded = 1)
								line1$ = whom1$ + " added a card"
							else
								line1$ = whom1$ + " added cards"
							endif
							leftImageID = imgListAddedCards
						endif
						if (logItemAction$ = "RemovedCards")
							if (noOfCardsAdded = 1)
								line1$ = whom1$ + " removed a card"
							else
								line1$ = whom1$ + " removed cards"
							endif
							leftImageID = imgListRemovedCards
						endif
						cardType$ = GetStringToken(logItemResult$, "*", 2)
						if (cardType$ = "DoubleUpCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 double up card"
							else
								line2$ = str(noOfCardsAdded) + " double up cards"
							endif
						endif
						if (cardType$ = "FreezeCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 freeze card"
							else
								line2$ = str(noOfCardsAdded) + " freeze cards"
							endif
						endif
						if (cardType$ = "GreenCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 green card"
							else
								line2$ = str(noOfCardsAdded) + " green cards"
							endif
						endif
						if (cardType$ = "RandomYellowCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 random yellow card"
							else
								line2$ = str(noOfCardsAdded) + " random yellow cards"
							endif
						endif
						if (cardType$ = "RedCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 red card"
							else
								line2$ = str(noOfCardsAdded) + " red cards"
							endif
						endif
						if (cardType$ = "ResetCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 reset card"
							else
								line2$ = str(noOfCardsAdded) + " reset cards"
							endif
						endif
						if (cardType$ = "StickyCard")
							if (noOfCardsAdded = 1)
								line2$ = "1 sticky card"
							else
								line2$ = str(noOfCardsAdded) + " sticky cards"
							endif
						endif
						if (logItemActionedBy$ = "Keyholder" and left(cardType$, 6) = "Yellow")
							if (noOfCardsAdded = 1)
								line2$ = "1 yellow card"
							else
								line2$ = str(noOfCardsAdded) + " yellow cards"
							endif
						else
							if (cardType$ = "YellowAdd1Card")
								if (noOfCardsAdded = 1)
									line2$ = "1 'Add 1 red' yellow card"
								else
									line2$ = str(noOfCardsAdded) + " 'Add 1 red' yellow cards"
								endif
							endif
							if (cardType$ = "YellowAdd2Card")
								if (noOfCardsAdded = 1)
									line2$ = "1 'Add 2 reds' yellow card"
								else
									line2$ = str(noOfCardsAdded) + " 'Add 2 reds' yellow cards"
								endif
							endif
							if (cardType$ = "YellowAdd3Card")
								if (noOfCardsAdded = 1)
									line2$ = "1 'Add 3 reds' yellow card"
								else
									line2$ = str(noOfCardsAdded) + " 'Add 3 reds' yellow cards"
								endif
							endif
							if (cardType$ = "YellowMinus1Card")
								if (noOfCardsAdded = 1)
									line2$ = "1 'Remove 1 red' yellow card"
								else
									line2$ = str(noOfCardsAdded) + " 'Remove 1 red' yellow cards"
								endif
							endif
							if (cardType$ = "YellowMinus2Card")
								if (noOfCardsAdded = 1)
									line2$ = "1 'Remove 2 reds' yellow card"
								else
									line2$ = str(noOfCardsAdded) + " 'Remove 2 reds' yellow cards"
								endif
							endif
						endif
						if (logItemHidden = -1)
							line2$ = "(Unhidden) " + line2$
						endif
						if (logItemHidden = 1)
							line1$ = whom1$ + " updated the lock"
							line2$ = "Update hidden"
							leftImageID = imgListUpdateHidden
						endif
					endif
					// OLD SHARED FIXED LOCKS CREATED BEFORE V2.5.0
					if (locks[lockSelected].fixed = 1)
						if (logItemAction$ = "AddedCards")
							line1$ = whom1$ + " added time"
							leftImageID = imgListAddedTime
						endif
						if (logItemAction$ = "RemovedCards")
							line1$ = whom1$ + " removed time"
							leftImageID = imgListRemovedTime
						endif
						cardType$ = GetStringToken(logItemResult$, "*", 2)
						if (cardType$ = "RedCard")
							line2$ = lower(ConvertMinutesToText(noOfCardsAdded * (locks[lockSelected].regularity# * 60), 1))
						endif
						if (logItemHidden = -1)
							line2$ = "(Unhidden) " + line2$
						endif
						if (logItemHidden = 1)
							line1$ = whom1$ + " updated the lock"
							line2$ = "Update hidden"
							leftImageID = imgListUpdateHidden
						endif
					endif
				endif
				if (logItemAction$ = "AddedTime" or logItemAction$ = "RemovedTime")
					noOfLeftLines = 2
					noOfMinutesModifiedBy as integer : noOfMinutesModifiedBy = val(logItemResult$)
					if (logItemAction$ = "AddedTime")
						line1$ = whom1$ + " added time"
						leftImageID = imgListAddedTime
					endif
					if (logItemAction$ = "RemovedTime")
						line1$ = whom1$ + " removed time"
						leftImageID = imgListRemovedTime
					endif
					line2$ = lower(ConvertMinutesToText(noOfMinutesModifiedBy, 1))
					if (logItemHidden = -1)
						line2$ = "(Unhidden) " + line2$
					endif
					if (logItemHidden = 1)
						line1$ = whom1$ + " updated the lock"
						line2$ = "Update hidden"
						leftImageID = imgListUpdateHidden
					endif
				endif
				if (logItemAction$ = "AutoResetLock")
					noOfLeftLines = 1
					line1$ = "Lock auto reset"
					noOfResetsMissed as integer : noOfResetsMissed = (logItemTotalActionTime / locks[lockSelected].resetFrequencyInSeconds) - 1
					if (noOfResetsMissed = 0)
						if (logItemTimestamp - val(logItemResult$) > 60)
							noOfLeftLines = 2
							line2$ = lower(ConvertSecondsToText(logItemTimestamp - val(logItemResult$), 0)) + " after scheduled reset"
						endif
					elseif (noOfResetsMissed = 1)
						noOfLeftLines = 2
						line2$ = "1 auto reset missed while away"
					elseif (noOfResetsMissed > 1)
						noOfLeftLines = 2
						line2$ = str(noOfResetsMissed) + " auto resets missed while away"
					endif
					leftImageID = imgListAutoResetLock
				endif
				if (logItemAction$ = "CardFreezeEnded")
					noOfLeftLines = 2
					line1$ = "Card freeze ended"
					if (logItemTotalActionTime > 0)
						dd = floor(logItemTotalActionTime / 60 / 60 / 24)
						hh = floor(mod(logItemTotalActionTime / 60 / 60, 24))
						mm = floor(mod(logItemTotalActionTime / 60, 60))
						ss = floor(mod(logItemTotalActionTime, 60))
						if (dd >= 1)
							line2$ = "After " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (hh >= 1)
							line2$ = "After " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (mm >= 1)
							line2$ = "After " + str(mm) + "m " + str(ss) + "s "
						else
							line2$ = "After " + str(ss) + "s"
						endif
					endif
					leftImageID = imgListUnfrozen
				endif
				if (logItemAction$ = "CardFreezeStarted")
					noOfLeftLines = 1
					line1$ = "Card freeze started"
					line2$ = " "
					leftImageID = imgListFrozen
				endif
				if (logItemAction$ = "Decision")
					noOfLeftLines = 1
					if (logItemResult$ = "DecideLater")
						if (sortedIteration = OryUIGetListItemCount(listLockLog) - 1)
							noOfLeftLines = 2
							line1$ = "Ready to unlock"
							if (whom2$ = "Your" or whom2$ = "The app")
								line2$ = "Awaiting your decision"
							else
								line2$ = "Awaiting decision from " + whom2$
							endif
						else
							noOfLeftLines = 1
							line1$ = "Ready to unlock"
							line2$ = " "
						endif
						leftImageID = imgListBlank
					endif
					if (logItemResult$ = "ResetLock")
						line1$ = whom1$ + " reset the lock"
						line2$ = " "
						leftImageID = imgListResetLock
					endif
					if (logItemResult$ = "ResetLockWithSurpriseMe")
						line1$ = whom1$ + " reset the lock with 'Surprise Me'"
						line2$ = " "
						leftImageID = imgListResetLock
					endif
					if (logItemResult$ = "LetKeyholderDecide")
						line1$ = whom1$ + " asked " + locks[lockSelected].keyholderUsername$ + " to decide"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					if (logItemResult$ = "PutGreenBack")
						line1$ = whom1$ + " put back last found green"
						line2$ = " "
						leftImageID = imgListGreenCard
					endif
					if (logItemResult$ = "Decline Unlock")
						line1$ = whom1$ + " declined an unlock"
						line2$ = " "
						leftImageID = imgListBlank
					endif
				endif
				if (logItemAction$ = "CheckedIn")
					noOfLeftLines = 2
					line1$ = whom1$ + " checked in"
					if (locks[lockSelected].fixed = 0)
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - (locks[lockSelected].regularity# * 3600) > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - (locks[lockSelected].regularity# * 3600), 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						else
							if (logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - locks[lockSelected].lateCheckInWindowInSeconds > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - locks[lockSelected].lateCheckInWindowInSeconds, 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						endif
					else
						if (locks[lockSelected].lateCheckInWindowInSeconds = 0)
							if (logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400)) > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - (MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400)), 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						else
							if (logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - locks[lockSelected].lateCheckInWindowInSeconds > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - locks[lockSelected].checkInFrequencyInSeconds - locks[lockSelected].lateCheckInWindowInSeconds, 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						endif
					endif
				endif
				if (logItemAction$ = "DeletedLock")
					noOfLeftLines = 1
					line1$ = whom1$ + " deleted the lock"
					line2$ = " "
					leftImageID = imgListDeletedLock
				endif
				if (logItemAction$ = "FakeUpdate")
					noOfLeftLines = 2
					line1$ = whom1$ + " updated the lock"
					line2$ = "Update hidden"
					leftImageID = imgListBlank
				endif
				if (logItemAction$ = "KeyholderFreezeEnded")
					noOfLeftLines = 2
					line1$ = whom1$ + " unfroze the lock"
					if (logItemTotalActionTime > 0)
						dd = floor(logItemTotalActionTime / 60 / 60 / 24)
						hh = floor(mod(logItemTotalActionTime / 60 / 60, 24))
						mm = floor(mod(logItemTotalActionTime / 60, 60))
						ss = floor(mod(logItemTotalActionTime, 60))
						if (dd >= 1)
							line2$ = "After " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (hh >= 1)
							line2$ = "After " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (mm >= 1)
							line2$ = "After " + str(mm) + "m " + str(ss) + "s "
						else
							line2$ = "After " + str(ss) + "s"
						endif
					endif
					leftImageID = imgListUnfrozen
				endif
				if (logItemAction$ = "KeyholderFreezeStarted")
					noOfLeftLines = 1
					line1$ = whom1$ + " froze the lock"
					line2$ = " "
					leftImageID = imgListFrozen
				endif
				if (logItemAction$ = "KeyholderUpdate")
					noOfLeftLines = 1
					if (logItemResult$ = "AutoResetsPaused")
						line1$ = whom1$ + " paused auto resets"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					if (logItemResult$ = "AutoResetsUnpaused")
						line1$ = whom1$ + " unpaused auto resets"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					
					if (logItemResult$ = "SwitchedToCumulative")
						line1$ = whom1$ + " set lock as cumulative"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					if (logItemResult$ = "SwitchedToNonCumulative")
						line1$ = whom1$ + " set lock as non-cumulative"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					
					if (logItemResult$ = "HidCardInfo")
						line1$ = whom1$ + " hid the card info"
						line2$ = " "
						if (colorModeSelected <> 2)
							leftImageID = imgListHidden
						else
							leftImageID = imgListHiddenWhite
						endif
					endif
					if (logItemResult$ = "HidTimer")
						line1$ = whom1$ + " hid the timer"
						line2$ = " "
						if (colorModeSelected <> 2)
							leftImageID = imgListHidden
						else
							leftImageID = imgListHiddenWhite
						endif
					endif
					if (logItemResult$ = "ResetLock")
						line1$ = whom1$ + " reset the lock"
						line2$ = " "
						leftImageID = imgListResetLock
					endif
					if (logItemResult$ = "RevealedCardInfo")
						line1$ = whom1$ + " revealed the card info"
						line2$ = " "
						if (colorModeSelected <> 2)
							leftImageID = imgListVisible
						else
							leftImageID = imgListVisibleWhite
						endif
					endif
					if (logItemResult$ = "RevealedTimer")
						line1$ = whom1$ + " revealed the timer"
						line2$ = " "
						if (colorModeSelected <> 2)
							leftImageID = imgListVisible
						else
							leftImageID = imgListVisibleWhite
						endif
					endif
					if (logItemResult$ = "UnlockedLock")
						noOfLeftLines = 2
						line1$ = whom1$ + " unlocked the lock"
						line2$ = ""
						secondsLocked = locks[lockSelected].timestampUnlocked - locks[lockSelected].timestampLocked
						dd = floor(secondsLocked / 60 / 60 / 24)
						hh = floor(mod(secondsLocked / 60 / 60, 24))
						mm = floor(mod(secondsLocked / 60, 60))
						ss = floor(mod(secondsLocked, 60))
						if (dd >= 1)
							line2$ = line2$ + "After " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (hh >= 1)
							line2$ = line2$ + "After " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
						elseif (mm >= 1)
							line2$ = line2$ + "After " + str(mm) + "m " + str(ss) + "s "
						else
							line2$ = line2$ + "After " + str(ss) + "s"
						endif
						leftImageID = imgListUnlocked
					endif
				endif
				if (logItemAction$ = "OldVersion")
					logItemTimestamp = locks[lockSelected].timestampLocked
					noOfLeftLines = 1
					line1$ = "Actions before this weren't tracked"
					line2$ = " "
					leftImageID = imgListOldVersion
				endif
				if (logItemAction$ = "PickedACard")
					noOfLeftLines = 2
					line1$ = whom1$ + " picked a card"
					if (logItemResult$ = "DoubleUpCard")
						line2$ = "Double up card"
						leftImageID = imgListDoubleUpCard
					endif
					if (logItemResult$ = "FreezeCard")
						line2$ = "Freeze card"
						leftImageID = imgListFreezeCard
					endif
					if (logItemResult$ = "GoAgainCard")
						line2$ = "Go again card"
						leftImageID = imgListGoAgainCard
					endif
					if (logItemResult$ = "GreenCard")
						line2$ = "Green card"
						leftImageID = imgListGreenCard
					endif
					if (logItemResult$ = "RedCard")
						line2$ = "Red card"
						leftImageID = imgListRedCard
					endif
					if (logItemResult$ = "ResetCard")
						line2$ = "Reset card"
						leftImageID = imgListResetCard
					endif
					if (logItemResult$ = "StickyCard")
						line2$ = "Sticky card"
						leftImageID = imgListStickyCard
					endif
					if (logItemResult$ = "YellowAdd1Card")
						line2$ = "'Add 1 red' yellow card"
						leftImageID = imgListYellowAdd1Card
					endif
					if (logItemResult$ = "YellowAdd2Card")
						line2$ = "'Add 2 reds' yellow card"
						leftImageID = imgListYellowAdd2Card
					endif
					if (logItemResult$ = "YellowAdd3Card")
						line2$ = "'Add 3 reds' yellow card"
						leftImageID = imgListYellowAdd3Card
					endif
					if (logItemResult$ = "YellowMinus1Card")
						line2$ = "'Remove 1 red' yellow card"
						leftImageID = imgListYellowMinus1Card
					endif
					if (logItemResult$ = "YellowMinus2Card")
						line2$ = "'Remove 2 reds' yellow card"
						leftImageID = imgListYellowMinus2Card
					endif
				endif
				if (logItemAction$ = "RatedLock")
					noOfLeftLines = 2
					line1$ = whom1$ + " rated the lock"
					if (logItemActionedBy$ = "Keyholder")
						line2$ = "Rating hidden"
					elseif (logItemActionedBy$ = "Lockee")
						if (val(logItemResult$) = 1)
							line2$ = "1 star"
						else
							line2$ = logItemResult$ + " stars"
						endif
					endif
					leftImageID = imgListRatedLock
				endif
				if (logItemAction$ = "ReadyToUnlock")
					if (logItemResult$ = "DecideLater")
						if (sortedIteration = OryUIGetListItemCount(listLockLog) - 1)
							noOfLeftLines = 2
							line1$ = "Ready to unlock"
							if (whom2$ = "Your" or whom2$ = "The app")
								line2$ = "Awaiting your decision"
							else
								line2$ = "Awaiting decision from " + whom2$
							endif
						else
							noOfLeftLines = 1
							line1$ = "Ready to unlock"
							line2$ = " "
						endif
					endif
					leftImageID = imgListBlank
				endif
				if (logItemAction$ = "RestoredLock")
					noOfLeftLines = 1
					line1$ = "You restored the lock"
					line2$ = " "
					leftImageID = imgListRestoredLock
				endif
				if (logItemAction$ = "SetMoodEmoji")
					noOfLeftLines = 1
					emojiChosen = val(ReplaceString(GetStringToken(logItemResult$, ",", 1), "Emoji=", "", -1))
					emojiColourSelected = val(ReplaceString(GetStringToken(logItemResult$, ",", 2), "Colour=", "", -1))
					if (emojiColourSelected = 0) then emojiColourSelected = 1
					if (logItemActionedBy$ = "Keyholder")
						if (emojiChosen = 0)
							line1$ = whom1$ + " removed their mood"
							leftImageID = imgListBlank
						else
							line1$ = whom1$ + " set their mood"
							leftImageID = imgEmojis[emojiColourSelected, emojiChosen]
						endif
					elseif (logItemActionedBy$ = "Lockee")
						if (emojiChosen = 0)
							line1$ = "You removed your mood"
							leftImageID = imgListBlank
						else
							line1$ = "You set your mood"
							leftImageID = imgEmojis[emojiColourSelected, emojiChosen]
						endif
					endif
					line2$ = " "
				endif
				if (logItemAction$ = "StartedLock")
					noOfLeftLines = 2
					line1$ = whom1$ + " started the lock"
					line2$ = AddOrdinalSuffix(GetDaysFromUnix(locks[lockSelected].timestampLocked))
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 1) then line2$ = line2$ + " Jan"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 2) then line2$ = line2$ + " Feb"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 3) then line2$ = line2$ + " Mar"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 4) then line2$ = line2$ + " Apr"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 5) then line2$ = line2$ + " May"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 6) then line2$ = line2$ + " Jun"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 7) then line2$ = line2$ + " Jul"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 8) then line2$ = line2$ + " Aug"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 9) then line2$ = line2$ + " Sep"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 10) then line2$ = line2$ + " Oct"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 11) then line2$ = line2$ + " Nov"
					if (GetMonthFromUnix(locks[lockSelected].timestampLocked) = 12) then line2$ = line2$ + " Dec"
					line2$ = line2$ + " " + str(GetYearFromUnix(locks[lockSelected].timestampLocked))
					line2$ = line2$ + " " + str(GetHoursFromUnix(locks[lockSelected].timestampLocked))
					line2$ = line2$ + "[colon]" + AddLeadingZeros(str(GetMinutesFromUnix(locks[lockSelected].timestampLocked)), 2)
					line2$ = line2$ + " UTC"
					leftImageID = imgListLocked
				endif
				if (logItemAction$ = "UnlockedLock")
					noOfLeftLines = 2
					line1$ = whom1$ + " unlocked the lock"
					line2$ = ""
					secondsLocked = locks[lockSelected].timestampUnlocked - locks[lockSelected].timestampLocked
					dd = floor(secondsLocked / 60 / 60 / 24)
					hh = floor(mod(secondsLocked / 60 / 60, 24))
					mm = floor(mod(secondsLocked / 60, 60))
					ss = floor(mod(secondsLocked, 60))
					if (logItemResult$ = "Key") then line2$ = "Key Used. "
					if (logItemResult$ = "Keys") then line2$ = "Keys Used. "
					if (logItemResult$ = "NaturallyWithSurpriseMe") then line2$ = "Choosing 'Surprise Me'. "
					if (dd >= 1)
						line2$ = line2$ + "After " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
					elseif (hh >= 1)
						line2$ = line2$ + "After " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s "
					elseif (mm >= 1)
						line2$ = line2$ + "After " + str(mm) + "m " + str(ss) + "s "
					else
						line2$ = line2$ + "After " + str(ss) + "s"
					endif
					leftImageID = imgListUnlocked
				endif
				
				secondsSinceAction = timestampNow - logItemTimestamp
				if (floor(secondsSinceAction / 60 / 60 / 24) >= 1)
					logItemActionedWhen$ = str(floor(secondsSinceAction / 60 / 60 / 24)) + "d"
				elseif (floor(secondsSinceAction / 60 / 60) >= 1)
					logItemActionedWhen$ = str(floor(secondsSinceAction / 60 / 60)) + "h"
				elseif (floor(secondsSinceAction / 60) >= 1)
					logItemActionedWhen$ = str(floor(secondsSinceAction / 60)) + "m"
				else
					logItemActionedWhen$ = str(secondsSinceAction) + "s"
				endif
			
				textColor$ = str(GetColorRed(colorMode[colorModeSelected].textColor)) + "," + str(GetColorGreen(colorMode[colorModeSelected].textColor)) + "," + str(GetColorBlue(colorMode[colorModeSelected].textColor))
				OryUIUpdateListItem(listLockLog, i, "colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftThumbnailImage:" + str(leftImageID) + ";leftLine1Text:" + line1$ + ";leftLine1TextSize:2.8;leftLine1TextColor:" + textColor$ + ",255;leftLine2Text:" + line2$ + ";leftLine2TextSize:2.6;leftLine2TextColor:" + textColor$ + ",150;rightLine1Text:" + logItemActionedWhen$ + ";rightLine1TextSize:2.5;rightLine1TextColor:" + textColor$ + ",130;noOfLeftLines:" + str(noOfLeftLines))
			endif
		endif
	next
	elementY# = startListY# + (filterCount * listItemHeight#)

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
	if (contentHeightChanged = 1)
		OryUISetScrollBarContentSize(scrollBar, 100, maxScrollY# + 100 - trackHeightReduction#)
		contentHeightChanged = 0
	endif
endif
