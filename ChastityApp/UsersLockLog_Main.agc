
if (screenToView = constUsersLockLogScreen)
	if (screenNo <> constUsersLockLogScreen)
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
		filterUsersLogByLabel$ as string : filterUsersLogByLabel$ = ""
		lastFilterCount = -1
		sortUsersLogByLabel$ as string : sortUsersLogByLabel$ = ""
	endif
	screenNo = constUsersLockLogScreen
	
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
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetUserLog(sharedLockSelected, userSelected, selectedManageUsersTab, 1)
		SetScreenToView(constUsersLockLogScreen)
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
	OryUISetTabsButtonSelectedByName(screen[screenNo].tabs, "Log")
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
		SetScreenToView(constUsersLockUpdateScreen)
	endif
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Info")
		SetScreenToView(constUsersLockInformationScreen)
	endif
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Log")
		GetUserLog(sharedLockSelected, userSelected, selectedManageUsersTab, 1)
		SetScreenToView(constUsersLockLogScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterUsersLogBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterUsersLog, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUsersLogBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredUsersLogBy, "text:" + filterUsersLogByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterUsersLog) + OryUIGetButtonWidth(btnIconFilterUsersLog)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUsersLogBar) / 2)))
	OryUIUpdateButton(btnIconSortUsersLog, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortUsersLog)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUsersLogBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextSortedUsersLogBy, "text:" + sortUsersLogByLabel$ + " (" + sortUsersLogOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortUsersLog) - OryUIGetButtonWidth(btnTextSortedUsersLogBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUsersLogBar) / 2)))
	OryUIUpdateSprite(sprFilterLogBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterUsersLogBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterUsersLogBar)

	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetUserLog(sharedLockSelected, userSelected, selectedManageUsersTab, 1)
		SetScreenToView(constUsersLockLogScreen)
	endif
	
	// FILTER MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterUsersLog, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterUsersLog) or OryUIGetButtonReleased(btnTextFilteredUsersLogBy))
		if (locks[lockSelected].fixed = 0)
			OryUISetMenuItemCount(menuFilterUsersLog, 11)
			OryUIUpdateMenuItem(menuFilterUsersLog, 1, "name:FilterUsersLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 2, "name:FilterUsersLogCardsAdded;text:Cards Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 3, "name:FilterUsersLogCardsPicked;text:Cards Picked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 4, "name:FilterUsersLogCardsRemoved;text:Cards Removed;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 5, "name:FilterUsersLogCheckIns;text:Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 6, "name:FilterUsersLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 7, "name:FilterUsersLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 8, "name:FilterUsersLogKeyholderUpdates;text:Keyholder Updates;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 9, "name:FilterUsersLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 10, "name:FilterUsersLogMoodEmojis;text:Mood Emojis;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 11, "name:FilterUsersLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUsersLogBy$ = "FilterUsersLogAll") then OryUIUpdateMenuItem(menuFilterUsersLog, 1, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogCardsAdded") then OryUIUpdateMenuItem(menuFilterUsersLog, 2, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogCardsPicked") then OryUIUpdateMenuItem(menuFilterUsersLog, 3, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogCardsRemoved") then OryUIUpdateMenuItem(menuFilterUsersLog, 4, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogCheckIns") then OryUIUpdateMenuItem(menuFilterUsersLog, 5, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogDecisions") then OryUIUpdateMenuItem(menuFilterUsersLog, 6, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterUsersLog, 7, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogKeyholderUpdates") then OryUIUpdateMenuItem(menuFilterUsersLog, 8, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogLockResets") then OryUIUpdateMenuItem(menuFilterUsersLog, 9, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogMoodEmojis") then OryUIUpdateMenuItem(menuFilterUsersLog, 10, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogStartEnd") then OryUIUpdateMenuItem(menuFilterUsersLog, 11, "rightIconID:" + str(imgTickIcon))
		else
			OryUISetMenuItemCount(menuFilterUsersLog, 9)
			OryUIUpdateMenuItem(menuFilterUsersLog, 1, "name:FilterUsersLogAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 2, "name:FilterUsersLogCheckIns;text:Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 3, "name:FilterUsersLogDecisions;text:Decisions;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 4, "name:FilterUsersLogFreezeUnfreeze;text:Freeze / Unfreeze;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 5, "name:FilterUsersLogKeyholderUpdates;text:Keyholder Updates;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 6, "name:FilterUsersLogLockResets;text:Lock Resets;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 7, "name:FilterUsersLogMoodEmojis;text:Mood Emojis;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 8, "name:FilterUsersLogStartEnd;text:Start & End;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateMenuItem(menuFilterUsersLog, 9, "name:FilterUsersLogTimeAdded;text:Time Added;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUsersLogBy$ = "FilterUsersLogAll") then OryUIUpdateMenuItem(menuFilterUsersLog, 1, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogCheckIns") then OryUIUpdateMenuItem(menuFilterUsersLog, 2, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogDecisions") then OryUIUpdateMenuItem(menuFilterUsersLog, 3, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze") then OryUIUpdateMenuItem(menuFilterUsersLog, 4, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogKeyholderUpdates") then OryUIUpdateMenuItem(menuFilterUsersLog, 5, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogLockResets") then OryUIUpdateMenuItem(menuFilterUsersLog, 6, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogMoodEmojis") then OryUIUpdateMenuItem(menuFilterUsersLog, 7, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogStartEnd") then OryUIUpdateMenuItem(menuFilterUsersLog, 8, "rightIconID:" + str(imgTickIcon))
			if (filterUsersLogBy$ = "FilterUsersLogTimeAdded") then OryUIUpdateMenuItem(menuFilterUsersLog, 9, "rightIconID:" + str(imgTickIcon))
		endif
		OryUIShowMenu(menuFilterUsersLog, OryUIGetButtonX(btnIconFilterUsersLog), OryUIGetButtonY(btnIconFilterUsersLog) + OryUIGetButtonHeight(btnIconFilterUsersLog))
	endif
	OryUIInsertMenuListener(menuFilterUsersLog)
	if (filterUsersLogByLabel$ = "")
		filterUsersLogBy$ = "FilterUsersLogAll"
		filterUsersLogByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogAll" or filterUsersLogBy$ = "FilterUsersLogAll")
		filterUsersLogBy$ = "FilterUsersLogAll"
		filterUsersLogByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogCardsAdded" or filterUsersLogBy$ = "FilterUsersLogCardsAdded")
		filterUsersLogBy$ = "FilterUsersLogCardsAdded"
		filterUsersLogByLabel$ = "Cards Added"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogCardsPicked" or filterUsersLogBy$ = "FilterUsersLogCardsPicked")
		filterUsersLogBy$ = "FilterUsersLogCardsPicked"
		filterUsersLogByLabel$ = "Cards Picked"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogCardsRemoved" or filterUsersLogBy$ = "FilterUsersLogCardsRemoved")
		filterUsersLogBy$ = "FilterUsersLogCardsRemoved"
		filterUsersLogByLabel$ = "Cards Removed"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogCheckIns" or filterUsersLogBy$ = "FilterUsersLogCheckIns")
		filterUsersLogBy$ = "FilterUsersLogCheckIns"
		filterUsersLogByLabel$ = "Check-Ins"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogDecisions" or filterUsersLogBy$ = "FilterUsersLogDecisions")
		filterUsersLogBy$ = "FilterUsersLogDecisions"
		filterUsersLogByLabel$ = "Decisions"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogFreezeUnfreeze" or filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze")
		filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze"
		filterUsersLogByLabel$ = "Freeze / Unfreeze"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogKeyholderUpdates" or filterUsersLogBy$ = "FilterUsersLogKeyholderUpdates")
		filterUsersLogBy$ = "FilterUsersLogKeyholderUpdates"
		filterUsersLogByLabel$ = "Keyholder Updates"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogLockResets" or filterUsersLogBy$ = "FilterUsersLogLockResets")
		filterUsersLogBy$ = "FilterUsersLogLockResets"
		filterUsersLogByLabel$ = "Lock Resets"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogMoodEmojis" or filterUsersLogBy$ = "FilterUsersLogMoodEmojis")
		filterUsersLogBy$ = "FilterUsersLogMoodEmojis"
		filterUsersLogByLabel$ = "Mood Emojis"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogStartEnd" or filterUsersLogBy$ = "FilterUsersLogStartEnd")
		filterUsersLogBy$ = "FilterUsersLogStartEnd"
		filterUsersLogByLabel$ = "Start & End"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) = "FilterUsersLogTimeAdded" or filterUsersLogBy$ = "FilterUsersLogTimeAdded")
		filterUsersLogBy$ = "FilterUsersLogTimeAdded"
		filterUsersLogByLabel$ = "Time Added"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUsersLog) <> "")
		SaveLocalVariable("filterUsersLogBy", filterUsersLogBy$)
		SetScreenToView(constUsersLockLogScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortUsersLog, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortUsersLog) or OryUIGetButtonReleased(btnTextSortedUsersLogBy))
		OryUISetMenuItemCount(menuSortUsersLog, 2)
		OryUIUpdateMenuItem(menuSortUsersLog, 1, "name:SortUsersLogByTime;text:Time;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortUsersLog, 2, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortUsersLogBy$ = "SortUsersLogByTime") then OryUIUpdateMenuItem(menuSortUsersLog, 1, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortUsersLog, OryUIGetButtonX(btnIconSortUsersLog), OryUIGetButtonY(btnIconSortUsersLog) + OryUIGetButtonHeight(btnIconSortUsersLog))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortUsersLog, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortUsersLog)
	OryUIInsertMenuListener(menuSortUsersLog)
	if (OryUIGetMenuVisible(menuSortUsersLog))
		OryUIUpdateButtonGroup(grpSortUsersLog, "position:" + str(OryUIGetMenuX(menuSortUsersLog)) + "," + str(OryUIGetMenuY(menuSortUsersLog) + OryUIGetMenuHeight(menuSortUsersLog) - OryUIGetButtonGroupHeight(grpSortUsersLog)))
	else
		OryUIUpdateButtonGroup(grpSortUsersLog, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUsersLog) = "SortUsersLogByTime" or sortUsersLogBy$ = "SortUsersLogByTime")
		sortUsersLogBy$ = "SortUsersLogByTime"
		sortUsersLogByLabel$ = "Time"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUsersLog) <> "")
		SaveLocalVariable("sortUsersLogBy", sortUsersLogBy$)
		SetScreenToView(constUsersLockLogScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortUsersLog, "ASC"))
		sortUsersLogOrder$ = "ASC"
		SaveLocalVariable("sortUsersLogOrder", sortUsersLogOrder$)
		SetScreenToView(constUsersLockLogScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortUsersLog, "DESC"))
		sortUsersLogOrder$ = "DESC"
		SaveLocalVariable("sortUsersLogOrder", sortUsersLogOrder$)
		SetScreenToView(constUsersLockLogScreen)
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// SORT LIST
	if (redrawScreen = 1)
		SortUsersLog(sharedLockSelected, selectedManageUsersTab, userSelected)
	endif
	
	// NO LOG ITEMS
	if (filterCount = 0)
		OryUIUpdateText(txtUsersNoLogItems, "text:No Log Items Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateText(txtUsersNoLogItems, "position:-1000,-1000")
	endif
	
	// LOG LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listUsersLog, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listUsersLog, maxListItemCount)
		else
			OryUISetListItemCount(listUsersLog, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listUsersLog, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listUsersLog)
	for i = 0 to maxListItemCount - 1
		if (i <= OryUIGetListItemCount(listUsersLog) - 1)
			if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected].length >= 0)
				sortedIteration = usersLogSorted[i + iterationOffset].iteration
				
				leftImageID = 0
				line1$ = ""
				line2$ = " "
				logItemAction$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected, sortedIteration].action$
				logItemActionedBy$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected, sortedIteration].actionedBy$
				logItemActionedWhen$ = "" 
				logItemResult$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected, sortedIteration].result$
				logItemTimestamp = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected, sortedIteration].timestamp
				logItemTotalActionTime = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLog[userSelected, sortedIteration].totalActionTime
				
				if (logItemActionedBy$ = "Keyholder")
					whom1$ = "You"
					whom2$ = "Your"
				elseif (logItemActionedBy$ = "Lockee")
					whom1$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected]
					whom2$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected]
				else
					whom1$ = "The app"
					whom2$ = "The app"
				endif
	
				if (logItemAction$ = "AddedCards" or logItemAction$ = "RemovedCards")
					noOfLeftLines = 2
					noOfCardsModifiedBy as integer : noOfCardsModifiedBy = val(GetStringToken(logItemResult$, "*", 1))
					if (sharedLocks[sharedLockSelected, 0].fixed = 0)
						if (logItemAction$ = "AddedCards")
							if (noOfCardsModifiedBy = 1)
								line1$ = whom1$ + " added a card"
							else
								line1$ = whom1$ + " added cards"
							endif
							leftImageID = imgListAddedCards
						endif
						if (logItemAction$ = "RemovedCards")
							if (noOfCardsModifiedBy = 1)
								line1$ = whom1$ + " removed a card"
							else
								line1$ = whom1$ + " removed cards"
							endif
							leftImageID = imgListRemovedCards
						endif
						cardType$ = GetStringToken(logItemResult$, "*", 2)
						if (cardType$ = "DoubleUpCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 double up card"
							else
								line2$ = str(noOfCardsModifiedBy) + " double up cards"
							endif
						endif
						if (cardType$ = "FreezeCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 freeze card"
							else
								line2$ = str(noOfCardsModifiedBy) + " freeze cards"
							endif
						endif
						if (cardType$ = "GreenCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 green card"
							else
								line2$ = str(noOfCardsModifiedBy) + " green cards"
							endif
						endif
						if (cardType$ = "RandomYellowCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 random yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " random yellow cards"
							endif
						endif
						if (cardType$ = "RedCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 red card"
							else
								line2$ = str(noOfCardsModifiedBy) + " red cards"
							endif
						endif
						if (cardType$ = "ResetCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 reset card"
							else
								line2$ = str(noOfCardsModifiedBy) + " reset cards"
							endif
						endif
						if (cardType$ = "StickyCard")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 sticky card"
							else
								line2$ = str(noOfCardsModifiedBy) + " sticky cards"
							endif
						endif
						if (cardType$ = "YellowAdd1Card")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 'Add 1 red' yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " 'Add 1 red' yellow cards"
							endif
						endif
						if (cardType$ = "YellowAdd2Card")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 'Add 2 reds' yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " 'Add 2 reds' yellow cards"
							endif
						endif
						if (cardType$ = "YellowAdd3Card")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 'Add 3 reds' yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " 'Add 3 reds' yellow cards"
							endif
						endif
						if (cardType$ = "YellowMinus1Card")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 'Remove 1 red' yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " 'Remove 1 red' yellow cards"
							endif
						endif
						if (cardType$ = "YellowMinus2Card")
							if (noOfCardsModifiedBy = 1)
								line2$ = "1 'Remove 2 reds' yellow card"
							else
								line2$ = str(noOfCardsModifiedBy) + " 'Remove 2 reds' yellow cards"
							endif
						endif
					endif
					// OLD SHARED FIXED LOCKS CREATED BEFORE V2.5.0
					if (sharedLocks[sharedLockSelected, 0].fixed = 1)
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
							line2$ = lower(ConvertMinutesToText(noOfCardsModifiedBy * (sharedLocks[sharedLockSelected, 0].regularity# * 60), 1))
						endif
					endif
				endif
				if (logItemAction$ = "AddedTime" or logItemAction$ = "RemovedTime")
					noOfLeftLines = 2
					noOfMinutesModifiedBy = val(logItemResult$)
					if (logItemAction$ = "AddedTime")
						line1$ = whom1$ + " added time"
						leftImageID = imgListAddedTime
					endif
					if (logItemAction$ = "RemovedTime")
						line1$ = whom1$ + " removed time"
						leftImageID = imgListRemovedTime
					endif
					line2$ = lower(ConvertMinutesToText(noOfMinutesModifiedBy, 1))
				endif	
				if (logItemAction$ = "AutoResetLock")
					noOfLeftLines = 1
					line1$ = "Lock auto reset"
					noOfResetsMissed = (logItemTotalActionTime / sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[userSelected]) - 1
					if (noOfResetsMissed = 0)
						if (logItemTimestamp - val(logItemResult$) > 60)
							noOfLeftLines = 2
							line2$ = lower(ConvertSecondsToText(logItemTimestamp - val(logItemResult$), 0)) + " after scheduled reset"
						endif
					elseif (noOfResetsMissed = 1)
						noOfLeftLines = 2
						line2$ = "1 auto reset missed while lockee was away"
					elseif (noOfResetsMissed > 1)
						noOfLeftLines = 2
						line2$ = str(noOfResetsMissed) + " auto resets missed while lockee was away"
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
					noOfLeftLines = 2
					line1$ = "Card freeze started"
					if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnfreezes[userSelected] - timestampNow > 0)
						line2$ = "Unfreezes in " + lower(ConvertMinutesToText((sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnfreezes[userSelected] - timestampNow) / 60, 1))
					elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnfreezes[userSelected] - timestampNow <= 0 and sortedIteration = OryUIGetListItemCount(listUsersLog) - 1)
						line2$ = "Unfreezes when lockee returns to the app"
					else
						noOfLeftLines = 1
						line2$ = " "
					endif
					leftImageID = imgListFrozen
				endif
				if (logItemAction$ = "CheckedIn")
					noOfLeftLines = 2
					line1$ = whom1$ + " checked in"
					if (sharedLocks[sharedLockSelected, 0].fixed = 0)
						if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected] = 0)
							if (logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - (sharedLocks[sharedLockSelected, 0].regularity# * 3600) > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - (sharedLocks[sharedLockSelected, 0].regularity# * 3600), 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						else
							if (logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected] > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected], 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						endif
					else
						if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected] = 0)
							if (logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] / 2, 86400)) > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] / 2, 86400)), 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						else
							if (logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected] > 0)
								line2$ = lower(ConvertSecondsToText(logItemTotalActionTime - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[userSelected], 1)) + " late"
								leftImageID = imgListCheckedInLate
							else
								line2$ = "On time"
								leftImageID = imgListCheckedIn
							endif
						endif
					endif
				endif
				if (logItemAction$ = "Decision")
					noOfLeftLines = 1
					if (logItemResult$ = "DecideLater")
						if (sortedIteration = OryUIGetListItemCount(listLockLog) - 1)
							noOfLeftLines = 2
							line1$ = "Ready to unlock"
							if (whom2$ = "Your")
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
						leftImageID = imgListResetLock
					endif
					if (logItemResult$ = "ResetLockWithSurpriseMe")
						line1$ = whom1$ + " reset the lock with 'Surprise Me'"
						leftImageID = imgListResetLock
					endif
					if (logItemResult$ = "LetKeyholderDecide")
						line1$ = whom1$ + " asked you to decide"
						line2$ = " "
						leftImageID = imgListBlank
					endif
					if (logItemResult$ = "PutGreenBack")
						line1$ = whom1$ + " put back last found green"
						line2$ = " "
						leftImageID = imgListGreenCard
					endif
				endif
				if (logItemAction$ = "DeletedLock")
					noOfLeftLines = 1
					line1$ = whom1$ + " deleted the lock"
					line2$ = " "
					leftImageID = imgListDeletedLock
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
					if (logItemAction$ = "UnlockedLock")
						noOfLeftLines = 2
						line1$ = whom1$ + " unlocked the lock"
						line2$ = ""
						secondsLocked = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnlocked[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
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
					logItemTimestamp = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
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
						if (val(logItemResult$) = 1)
							line2$ = "1 star"
						else
							line2$ = logItemResult$ + " stars"
						endif
					elseif (logItemActionedBy$ = "Lockee")
						line2$ = "Rating hidden"
					endif
					leftImageID = imgListRatedLock
				endif
				if (logItemAction$ = "ReadyToUnlock")
					if (logItemResult$ = "DecideLater")
						if (sortedIteration = OryUIGetListItemCount(listUsersLog) - 1)
							noOfLeftLines = 2
							line1$ = "Ready to unlock"
							if (whom1$ = "You")
								line2$ = "Awaiting decision from you"
							else
								line2$ = "Awaiting decision from " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected]
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
					line1$ = whom1$ + " restored the lock"
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
							line1$ = "You removed your mood"
							leftImageID = imgListBlank
						else
							line1$ = "You set your mood"
							leftImageID = imgEmojis[emojiColourSelected, emojiChosen]
						endif
					elseif (logItemActionedBy$ = "Lockee")
						if (emojiChosen = 0)
							line1$ = whom1$ + " removed their mood"
							leftImageID = imgListBlank
						else
							line1$ = whom1$ + " set their mood"
							leftImageID = imgEmojis[emojiColourSelected, emojiChosen]
						endif
					endif
					line2$ = " "
				endif
				if (logItemAction$ = "StartedLock")
					noOfLeftLines = 2
					line1$ = whom1$ + " started the lock"
					line2$ = AddOrdinalSuffix(GetDaysFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]))
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 1) then line2$ = line2$ + " Jan"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 2) then line2$ = line2$ + " Feb"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 3) then line2$ = line2$ + " Mar"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 4) then line2$ = line2$ + " Apr"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 5) then line2$ = line2$ + " May"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 6) then line2$ = line2$ + " Jun"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 7) then line2$ = line2$ + " Jul"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 8) then line2$ = line2$ + " Aug"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 9) then line2$ = line2$ + " Sep"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 10) then line2$ = line2$ + " Oct"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 11) then line2$ = line2$ + " Nov"
					if (GetMonthFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]) = 12) then line2$ = line2$ + " Dec"
					line2$ = line2$ + " " + str(GetYearFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]))
					line2$ = line2$ + " " + str(GetHoursFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]))
					line2$ = line2$ + "[colon]" + AddLeadingZeros(str(GetMinutesFromUnix(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected])), 2)
					line2$ = line2$ + " UTC"
					leftImageID = imgListLocked
				endif
				if (logItemAction$ = "UnlockedLock")
					noOfLeftLines = 2
					line1$ = whom1$ + " unlocked the lock"
					line2$ = ""
					secondsLocked = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampUnlocked[userSelected] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[userSelected]
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
				OryUIUpdateListItem(listUsersLog, i, "colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftThumbnailImage:" + str(leftImageID) + ";leftLine1Text:" + line1$ + ";leftLine1TextSize:2.8;leftLine1TextColor:" + textColor$ + ",255;leftLine2Text:" + line2$ + ";leftLine2TextSize:2.6;leftLine2TextColor:" + textColor$ + ",150;rightLine1Text:" + logItemActionedWhen$ + ";rightLine1TextSize:2.5;rightLine1TextColor:" + textColor$ + ",130;noOfLeftLines:" + str(noOfLeftLines))
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
endif
