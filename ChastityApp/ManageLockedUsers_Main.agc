
if (screenToView = constManageLockedUsersScreen)
	if (screenNo <> constManageLockedUsersScreen)
		filterCount = 0
		filterFlagNo as integer : filterFlagNo = 0
		filterLockedUsersByFlagLabel$ as string : filterLockedUsersByFlagLabel$ = ""
		filterLockedUsersByLabel$ as string : filterLockedUsersByLabel$ = ""
		lastLockedUsersSearchLength as integer : lastLockedUsersSearchLength = 0
		OryUIUpdateTextfield(editLockedUsersSearch, "inputText:" + sharedLocksSearchString$)
		if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingDecision")
			filterLockedUsersBy$ = "FilterLockedUsersAwaitingDecision"
		endif
		if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest")
			filterLockedUsersExcludeTestLocks = 0
		endif
		if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedExcludingTest")
			filterLockedUsersExcludeTestLocks = 1
		endif
		sortLockedUsersByLabel$ as string : sortLockedUsersByLabel$ = ""
	endif
	screenNo = constManageLockedUsersScreen
	selectedManageUsersTab = 1
	SetLastScreenViewed(screenNo)
	
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
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 2, 1)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 3)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 3, 1)
		SetScreenToView(constManageDesertedUsersScreen)
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
	OryUIUpdateSprite(sprFilterLockedUsersBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnIconFilterLockedUsers, "position:" + str(OryUIGetButtonX(btnIconFilterLockedUsersByFlags) + OryUIGetButtonWidth(btnIconFilterLockedUsersByFlags) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredLockedUsersBy, "text:" + filterLockedUsersByLabel$ + filterLockedUsersByFlagLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterLockedUsers) + OryUIGetButtonWidth(btnIconFilterLockedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)))
	OryUIUpdateButton(btnIconSortLockedUsers, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortLockedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (sortLockedUsersBy$ <> "SortLockedUsersByRandom")
		OryUIUpdateButton(btnTextSortedDesertedUsersBy, "text:" + sortLockedUsersByLabel$ + " (" + sortLockedUsersOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortLockedUsers) - OryUIGetButtonWidth(btnTextSortedDesertedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)))
	else
		OryUIUpdateButton(btnTextSortedDesertedUsersBy, "text:" + sortLockedUsersByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortLockedUsers) - OryUIGetButtonWidth(btnTextSortedDesertedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockedUsersBar) / 2)))
	endif	
	OryUIUpdateSprite(sprFilterLockedUsersBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterLockedUsersBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterLockedUsersBar) //+ 2
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
	endif
	
	// FILTER MENUS
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterLockedUsersByFlags, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlack") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[1]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlue") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[2]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagGreen") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[3]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagOrange") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[4]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagPurple") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[5]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagRed") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[6]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagYellow") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[7]) + ";color:255,255,255,255")
	if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagAll") then OryUIUpdateButton(btnIconFilterLockedUsersByFlags, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (OryUIGetButtonReleased(btnIconFilterLockedUsersByFlags))
		OryUISetMenuItemCount(menuFilterLockedUsersByFlags, 8)
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 1, "name:FilterLockedUsersFlagBlack;text: ;lefticonID:" + str(imgFlags[1]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 2, "name:FilterLockedUsersFlagBlue;text: ;lefticonID:" + str(imgFlags[2]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 3, "name:FilterLockedUsersFlagGreen;text: ;lefticonID:" + str(imgFlags[3]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 4, "name:FilterLockedUsersFlagOrange;text: ;lefticonID:" + str(imgFlags[4]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 5, "name:FilterLockedUsersFlagPurple;text: ;lefticonID:" + str(imgFlags[5]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 6, "name:FilterLockedUsersFlagRed;text: ;lefticonID:" + str(imgFlags[6]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 7, "name:FilterLockedUsersFlagYellow;text: ;lefticonID:" + str(imgFlags[7]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 8, "name:FilterLockedUsersFlagAll;text: ;lefticonID:" + str(imgFlags[9]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlack") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 1, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlue") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 2, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagGreen") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 3, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagOrange") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 4, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagPurple") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 5, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagRed") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 6, "rightIconID:" + str(imgTickIcon))
		if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagYellow") then OryUIUpdateMenuItem(menuFilterLockedUsersByFlags, 7, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterLockedUsersByFlags, OryUIGetButtonX(btnIconFilterLockedUsersByFlags), OryUIGetButtonY(btnIconFilterLockedUsersByFlags) + OryUIGetButtonHeight(btnIconFilterLockedUsersByFlags))
	endif
	OryUIInsertMenuListener(menuFilterLockedUsersByFlags)
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagBlack" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlack")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlack"
		filterLockedUsersByFlagLabel$ = " (Black Flags)"
		filterFlagNo = 1
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagBlue" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlue")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlue"
		filterLockedUsersByFlagLabel$ = " (Blue Flags)"
		filterFlagNo = 2
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagGreen" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagGreen")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagGreen"
		filterLockedUsersByFlagLabel$ = " (Green Flags)"
		filterFlagNo = 3
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagOrange" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagOrange")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagOrange"
		filterLockedUsersByFlagLabel$ = " (Orange Flags)"
		filterFlagNo = 4
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagPurple" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagPurple")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagPurple"
		filterLockedUsersByFlagLabel$ = " (Purple Flags)"
		filterFlagNo = 5
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagRed" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagRed")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagRed"
		filterLockedUsersByFlagLabel$ = " (Red Flags)"
		filterFlagNo = 6
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagYellow" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagYellow")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagYellow"
		filterLockedUsersByFlagLabel$ = " (Yellow Flags)"
		filterFlagNo = 7
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) = "FilterLockedUsersFlagAll" or filterLockedUsersByFlag$ = "FilterLockedUsersFlagAll")
		filterLockedUsersByFlag$ = "FilterLockedUsersFlagAll"
		filterLockedUsersByFlagLabel$ = ""
		filterFlagNo = 0
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsersByFlags) <> "")
		SaveLocalVariable("filterLockedUsersByFlag", filterLockedUsersByFlag$)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterLockedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterLockedUsers) or OryUIGetButtonReleased(btnTextFilteredLockedUsersBy))
		local menuFilterLockedUsersItemCount as integer
		local menuFilterLockedUsersAllVisible as integer
		local menuFilterLockedUsersAwaitingDecisionVisible as integer
		local menuFilterLockedUsersFavouritesVisible as integer
		local menuFilterLockedUsersFrozenVisible as integer
		local menuFilterLockedUsersLateCheckInsVisible as integer
		local menuFilterLockedUsersMultipleKeyholdersVisible as integer
		local menuFilterLockedUsersTestLocksVisible as integer
		local menuFilterLockedUsersExcludeTestLocksVisible as integer
		menuFilterLockedUsersAllVisible = 1
		menuFilterLockedUsersAwaitingDecisionVisible = 1
		menuFilterLockedUsersFavouritesVisible = 1
		menuFilterLockedUsersFrozenVisible = 1
		menuFilterLockedUsersLateCheckInsVisible = 0
		if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0) then menuFilterLockedUsersLateCheckInsVisible = 1
		menuFilterLockedUsersMultipleKeyholdersVisible = 1
		menuFilterLockedUsersTestLocksVisible = 0
		if (filterLockedUsersExcludeTestLocks = 0) then menuFilterLockedUsersTestLocksVisible = 1	
		menuFilterLockedUsersExcludeTestLocksVisible = 1
		menuFilterLockedUsersItemCount = menuFilterLockedUsersAllVisible + menuFilterLockedUsersAwaitingDecisionVisible + menuFilterLockedUsersFavouritesVisible + menuFilterLockedUsersFrozenVisible + menuFilterLockedUsersLateCheckInsVisible + menuFilterLockedUsersMultipleKeyholdersVisible + menuFilterLockedUsersTestLocksVisible + menuFilterLockedUsersExcludeTestLocksVisible
		
		OryUISetMenuItemCount(menuFilterLockedUsers, menuFilterLockedUsersItemCount)
		menuFilterLockedUsersItemCount = 0
		if (menuFilterLockedUsersAllVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersAll") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersAwaitingDecisionVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersAwaitingDecision;text:Awaiting Decision;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersAwaitingDecision") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersFavouritesVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersFavourites;text:Favourites;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersFavourites") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersFrozenVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersFrozen;text:Frozen;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersFrozen") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersLateCheckInsVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersLateCheckIns;text:Late Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersLateCheckIns") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersMultipleKeyholdersVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersMultipleKeyholders;text:Multiple Keyholders;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersMultipleKeyholders") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersTestLocksVisible = 1)
			inc menuFilterLockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersTestLocks;text:Test Locks;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterLockedUsersBy$ = "FilterLockedUsersTestLocks") then OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterLockedUsersExcludeTestLocksVisible = 1)
			inc menuFilterLockedUsersItemCount
			if (filterLockedUsersExcludeTestLocks = 0)
				OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxUncheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateMenuItem(menuFilterLockedUsers, menuFilterLockedUsersItemCount, "name:FilterLockedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxCheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		OryUIShowMenu(menuFilterLockedUsers, OryUIGetButtonX(btnIconFilterLockedUsers), OryUIGetButtonY(btnIconFilterLockedUsers) + OryUIGetButtonHeight(btnIconFilterLockedUsers))
	endif
	OryUIInsertMenuListener(menuFilterLockedUsers)
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersAll" or filterLockedUsersBy$ = "FilterLockedUsersAll")
		filterLockedUsersBy$ = "FilterLockedUsersAll"
		filterLockedUsersByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersAwaitingDecision" or filterLockedUsersBy$ = "FilterLockedUsersAwaitingDecision")
		filterLockedUsersBy$ = "FilterLockedUsersAwaitingDecision"
		filterLockedUsersByLabel$ = "Awaiting Decision"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersFavourites" or filterLockedUsersBy$ = "FilterLockedUsersFavourites")
		filterLockedUsersBy$ = "FilterLockedUsersFavourites"
		filterLockedUsersByLabel$ = "Favourites"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersFrozen" or filterLockedUsersBy$ = "FilterLockedUsersFrozen")
		filterLockedUsersBy$ = "FilterLockedUsersFrozen"
		filterLockedUsersByLabel$ = "Frozen"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersLateCheckIns" or filterLockedUsersBy$ = "FilterLockedUsersLateCheckIns")
		filterLockedUsersBy$ = "FilterLockedUsersLateCheckIns"
		filterLockedUsersByLabel$ = "Late Check-Ins"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersMultipleKeyholders" or filterLockedUsersBy$ = "FilterLockedUsersMultipleKeyholders")
		filterLockedUsersBy$ = "FilterLockedUsersMultipleKeyholders"
		filterLockedUsersByLabel$ = "Multiple Keyholders"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersTestLocks" or filterLockedUsersBy$ = "FilterLockedUsersTestLocks")
		filterLockedUsersBy$ = "FilterLockedUsersTestLocks"
		filterLockedUsersByLabel$ = "Test Locks"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) = "FilterLockedUsersExcludeTestLocks")
		if (filterLockedUsersExcludeTestLocks = 0)
			filterLockedUsersExcludeTestLocks = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersTestLocks")
				filterLockedUsersBy$ = "FilterLockedUsersAll"
				filterLockedUsersByLabel$ = "All"
			endif
		else
			filterLockedUsersExcludeTestLocks = 0
		endif
		SaveLocalVariable("filterLockedUsersExcludeTestLocks", str(filterLockedUsersExcludeTestLocks))
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterLockedUsers) <> "")
		SaveLocalVariable("filterLockedUsersBy", filterLockedUsersBy$)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortLockedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortLockedUsers) or OryUIGetButtonReleased(btnTextSortedDesertedUsersBy))
		if (sharedLocks[sharedLockSelected, 0].fixed = 0)
			if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0)
				OryUISetMenuItemCount(menuSortLockedUsers, 10)
				OryUIUpdateMenuItem(menuSortLockedUsers, 1, "name:SortLockedUsersByChanceOfGreen;text:Chance of Green;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 2, "name:SortLockedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 3, "name:SortLockedUsersByLastOnline;text:Last Online;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 4, "name:SortLockedUsersByLastPicked;text:Last Picked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 5, "name:SortLockedUsersByLastUpdated;text:Last Updated;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 6, "name:SortLockedUsersByLateCheckIns;text:Late Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 7, "name:SortLockedUsersByRandom;text:Random;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 8, "name:SortLockedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 9, "name:SortLockedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 10, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
				if (sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen") then OryUIUpdateMenuItem(menuSortLockedUsers, 1, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortLockedUsers, 2, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastOnline") then OryUIUpdateMenuItem(menuSortLockedUsers, 3, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastPicked") then OryUIUpdateMenuItem(menuSortLockedUsers, 4, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastUpdated") then OryUIUpdateMenuItem(menuSortLockedUsers, 5, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLateCheckIns") then OryUIUpdateMenuItem(menuSortLockedUsers, 6, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByRandom")
					OryUIUpdateMenuItem(menuSortLockedUsers, 7, "rightIconID:" + str(imgTickIcon))
					OryUISetMenuItemCount(menuSortLockedUsers, 9)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUsername") then OryUIUpdateMenuItem(menuSortLockedUsers, 8, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByUserRating") then OryUIUpdateMenuItem(menuSortLockedUsers, 9, "rightIconID:" + str(imgTickIcon))
			else
				OryUISetMenuItemCount(menuSortLockedUsers, 9)
				OryUIUpdateMenuItem(menuSortLockedUsers, 1, "name:SortLockedUsersByChanceOfGreen;text:Chance of Green;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 2, "name:SortLockedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 3, "name:SortLockedUsersByLastOnline;text:Last Online;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 4, "name:SortLockedUsersByLastPicked;text:Last Picked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 5, "name:SortLockedUsersByLastUpdated;text:Last Updated;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 6, "name:SortLockedUsersByRandom;text:Random;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 7, "name:SortLockedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 8, "name:SortLockedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 9, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
				if (sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen") then OryUIUpdateMenuItem(menuSortLockedUsers, 1, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortLockedUsers, 2, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastOnline") then OryUIUpdateMenuItem(menuSortLockedUsers, 3, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastPicked") then OryUIUpdateMenuItem(menuSortLockedUsers, 4, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastUpdated") then OryUIUpdateMenuItem(menuSortLockedUsers, 5, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByRandom")
					OryUIUpdateMenuItem(menuSortLockedUsers, 6, "rightIconID:" + str(imgTickIcon))
					OryUISetMenuItemCount(menuSortLockedUsers, 8)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUsername") then OryUIUpdateMenuItem(menuSortLockedUsers, 7, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByUserRating") then OryUIUpdateMenuItem(menuSortLockedUsers, 8, "rightIconID:" + str(imgTickIcon))
			endif
		else
			if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0)
				OryUISetMenuItemCount(menuSortLockedUsers, 8)
				OryUIUpdateMenuItem(menuSortLockedUsers, 1, "name:SortLockedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 2, "name:SortLockedUsersByLastOnline;text:Last Online;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 3, "name:SortLockedUsersByLastUpdated;text:Last Updated;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 4, "name:SortLockedUsersByLateCheckIns;text:Late Check-Ins;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 5, "name:SortLockedUsersByRandom;text:Random;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 6, "name:SortLockedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 7, "name:SortLockedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 8, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
				if (sortLockedUsersBy$ = "SortLockedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortLockedUsers, 1, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastOnline") then OryUIUpdateMenuItem(menuSortLockedUsers, 2, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastUpdated") then OryUIUpdateMenuItem(menuSortLockedUsers, 3, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLateCheckIns") then OryUIUpdateMenuItem(menuSortLockedUsers, 4, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByRandom")
					OryUIUpdateMenuItem(menuSortLockedUsers, 5, "rightIconID:" + str(imgTickIcon))
					OryUISetMenuItemCount(menuSortLockedUsers, 7)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUsername") then OryUIUpdateMenuItem(menuSortLockedUsers, 6, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByUserRating") then OryUIUpdateMenuItem(menuSortLockedUsers, 7, "rightIconID:" + str(imgTickIcon))
			else
				OryUISetMenuItemCount(menuSortLockedUsers, 7)
				OryUIUpdateMenuItem(menuSortLockedUsers, 1, "name:SortLockedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 2, "name:SortLockedUsersByLastOnline;text:Last Online;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 3, "name:SortLockedUsersByLastUpdated;text:Last Updated;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 4, "name:SortLockedUsersByRandom;text:Random;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 5, "name:SortLockedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 6, "name:SortLockedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateMenuItem(menuSortLockedUsers, 7, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
				if (sortLockedUsersBy$ = "SortLockedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortLockedUsers, 1, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastOnline") then OryUIUpdateMenuItem(menuSortLockedUsers, 2, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByLastUpdated") then OryUIUpdateMenuItem(menuSortLockedUsers, 3, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByRandom")
					OryUIUpdateMenuItem(menuSortLockedUsers, 4, "rightIconID:" + str(imgTickIcon))
					OryUISetMenuItemCount(menuSortLockedUsers, 6)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUsername") then OryUIUpdateMenuItem(menuSortLockedUsers, 5, "rightIconID:" + str(imgTickIcon))
				if (sortLockedUsersBy$ = "SortLockedUsersByUserRating") then OryUIUpdateMenuItem(menuSortLockedUsers, 6, "rightIconID:" + str(imgTickIcon))
			endif
		endif
		OryUIShowMenu(menuSortLockedUsers, OryUIGetButtonX(btnIconSortLockedUsers), OryUIGetButtonY(btnIconSortLockedUsers) + OryUIGetButtonHeight(btnIconSortLockedUsers))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortLockedUsers, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortLockedUsers)
	OryUIInsertMenuListener(menuSortLockedUsers)
	if (OryUIGetMenuVisible(menuSortLockedUsers) and sortLockedUsersBy$ <> "SortLockedUsersByRandom")
		OryUIUpdateButtonGroup(grpSortLockedUsers, "position:" + str(OryUIGetMenuX(menuSortLockedUsers)) + "," + str(OryUIGetMenuY(menuSortLockedUsers) + OryUIGetMenuHeight(menuSortLockedUsers) - OryUIGetButtonGroupHeight(grpSortLockedUsers)))
	else
		OryUIUpdateButtonGroup(grpSortLockedUsers, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByChanceOfGreen" or sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen")
		sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen"
		sortLockedUsersByLabel$ = "Chance of Green"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByDurationLocked" or sortLockedUsersBy$ = "SortLockedUsersByDurationLocked")
		sortLockedUsersBy$ = "SortLockedUsersByDurationLocked"
		sortLockedUsersByLabel$ = "Duration Locked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByLastOnline" or sortLockedUsersBy$ = "SortLockedUsersByLastOnline")
		sortLockedUsersBy$ = "SortLockedUsersByLastOnline"
		sortLockedUsersByLabel$ = "Last Online"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByLastPicked" or sortLockedUsersBy$ = "SortLockedUsersByLastPicked")
		sortLockedUsersBy$ = "SortLockedUsersByLastPicked"
		sortLockedUsersByLabel$ = "Last Picked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByLastUpdated" or sortLockedUsersBy$ = "SortLockedUsersByLastUpdated")
		sortLockedUsersBy$ = "SortLockedUsersByLastUpdated"
		sortLockedUsersByLabel$ = "Last Updated"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByLateCheckIns" or sortLockedUsersBy$ = "SortLockedUsersByLateCheckIns")
		sortLockedUsersBy$ = "SortLockedUsersByLateCheckIns"
		sortLockedUsersByLabel$ = "Late Check-Ins"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByRandom" or sortLockedUsersBy$ = "SortLockedUsersByRandom")
		sortLockedUsersBy$ = "SortLockedUsersByRandom"
		sortLockedUsersByLabel$ = "Random"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByUsername" or sortLockedUsersBy$ = "SortLockedUsersByUsername")
		sortLockedUsersBy$ = "SortLockedUsersByUsername"
		sortLockedUsersByLabel$ = "Username"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) = "SortLockedUsersByUserRating" or sortLockedUsersBy$ = "SortLockedUsersByUserRating")
		sortLockedUsersBy$ = "SortLockedUsersByUserRating"
		sortLockedUsersByLabel$ = "User Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortLockedUsers) <> "")
		SaveLocalVariable("sortLockedUsersBy", sortLockedUsersBy$)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortLockedUsers, "ASC"))
		sortLockedUsersOrder$ = "ASC"
		SaveLocalVariable("sortLockedUsersOrder", sortLockedUsersOrder$)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortLockedUsers, "DESC"))
		sortLockedUsersOrder$ = "DESC"
		SaveLocalVariable("sortLockedUsersOrder", sortLockedUsersOrder$)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	// if switched between a variable and fixed lock and the selected sort is a variable one only then set as random and refresh screen 
	if ((sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen" or sortLockedUsersBy$ = "SortLockedUsersByLastPicked") and sharedLocks[sharedLockSelected, 0].fixed = 1)
		sortLockedUsersBy$ = "SortLockedUsersByRandom"
		sortLockedUsersByLabel$ = "Random"
		SetScreenToView(constManageLockedUsersScreen)
	endif
	
	// LOCKED USERS LOCKS SEARCH BAR
	if (sharedLocks[sharedLockSelected, 0].lockedUsers > 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetSharedLockUsersData"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprLockedUsersSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editLockedUsersSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editLockedUsersSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editLockedUsersSearch))
			OryUISetTextfieldString(editLockedUsersSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editLockedUsersSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editLockedUsersSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editLockedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editLockedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editLockedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editLockedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editLockedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editLockedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		if (sharedLocksSearchString$ <> OryUIGetTextfieldString(editLockedUsersSearch))
			sharedLocksSearchString$ = ""
		endif
		elementY# = elementY# + GetSpriteHeight(sprLockedUsersSearchBar) + 2
	else
		OryUIUpdateSprite(sprLockedUsersSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editLockedUsersSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	startScrollBarY# = elementY# - 1
	
	// SORT LOCKED USERS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editLockedUsersSearch)) <> lastLockedUsersSearchLength)
		lastLockedUsersSearchLength = len(OryUIGetTextFieldString(editLockedUsersSearch))
		SortLockedUsers(OryUIGetTextfieldString(editLockedUsersSearch))
		redrawScreen = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO LOCKED USERS
	if (sharedLocks[sharedLockSelected, 0].lockedUsers = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData))
			OryUIUpdateText(txtNoLockedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoLockedUsers, "text:No Locked Users;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	elseif (filterCount = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData))
			OryUIUpdateText(txtNoLockedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			if (filterLockedUsersExcludeTestLocks = 0)
				OryUIUpdateText(txtNoLockedUsers, "text:No Locked Users Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateText(txtNoLockedUsers, "text:No Locked Users Matching Filter" + chr(10) + "Excluding Test Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
	else
		OryUIUpdateText(txtNoLockedUsers, "position:-1000,-1000")
	endif

	// LOCKED USERS
	if (redrawScreen = 1)
		for i = 1 to 6
			DestroyItemsInLockedUsersCard(i)
			CreateItemsInLockedUsersCard(i)
		next
	endif
	if (filterCount > 0)
		fullCardHeight# = GetSpriteHeight(userCard[1].sprBackground) + GetSpriteHeight(userCard[1].sprButtonBar) + 2.0
		//if (redrawScreen = 1)
		for i = 1 to 6
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(userCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					elementY# = elementY# + GetSpriteHeight(userCard[i].sprBackground)
					OryUIUpdateSprite(userCard[i].sprButtonBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
					elementY# = elementY# + GetSpriteHeight(userCard[i].sprButtonBar) + 2
					userCard[i].iteration = i
				endif
				if (GetSpriteY(userCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and userCard[i].iteration + 6 <= filterCount)
					userCard[i].iteration = userCard[i].iteration + 6
					OryUIUpdateSprite(userCard[i].sprBackground, "y:" + str(GetSpriteY(userCard[i].sprBackground) + (fullCardHeight# * 6)))
					OryUIUpdateSprite(userCard[i].sprButtonBar, "y:" + str(GetSpriteY(userCard[i].sprBackground) + GetSpriteHeight(userCard[i].sprBackground)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(userCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 6) and userCard[i].iteration - 6 >= 1)
					userCard[i].iteration = userCard[i].iteration - 6
					OryUIUpdateSprite(userCard[i].sprBackground, "y:" + str(GetSpriteY(userCard[i].sprBackground) - (fullCardHeight# * 6)))
					OryUIUpdateSprite(userCard[i].sprButtonBar, "y:" + str(GetSpriteY(userCard[i].sprBackground) + GetSpriteHeight(userCard[i].sprBackground)))
					repositionItemsInCard = 1
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = sharedLockUsersSorted[userCard[i].iteration - 1].iteration

				if (GetSpriteInScreen(userCard[i].sprBackground))
					lockInView = 1
				else
					lockInView = 0
				endif

				UpdateItemsInLockedUsersCard(i, sortedIteration, repositionItemsInCard)
												
				if (lockInView = 1)
					OryUIInsertDialogListener(userCard[i].dialog)
					
					if (OryUIGetSwipingVertically() = 0)
						
						// TRUST KEYHOLDER BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprTrustKeyholder)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Trusted Keyholder;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " said that they trusted you as a keyholder. This means all limitations as a keyholder have been removed;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// MULTIPLE KEYHOLDERS BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprMultipleKeyholders)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Multiple Keyholders;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has at least one other lock controlled by the following keyholder(s)[colon]" + chr(10) + chr(10) + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersOtherKeyholders$[sortedIteration] + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// TEST LOCK
						if (OryUIGetSpriteReleased() = userCard[i].sprTestLock)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Test Lock;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has said that they are testing the lock and therefore probably haven't locked anything away with it. You're free to unlock them early without it affecting your stats or ratings because test locks are not counted towards anyones stats;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// VIEW PROFILE
						if (OryUIGetSpriteReleased() = userCard[i].sprUsernameButton)
							GetProfileData(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[sortedIteration], 1)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constViewProfileScreen)
						endif
						
						// STATUS BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprStatus)
							statusTitle$ = ""
							if (GetSpriteImageID(userCard[i].sprStatus) = imgStatusAvailableIcon) then statusTitle$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " is online"
							if (GetSpriteImageID(userCard[i].sprStatus) = imgStatusBusyIcon) then statusTitle$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " is busy"
							if (GetSpriteImageID(userCard[i].sprStatus) = imgStatusOfflineIcon) then statusTitle$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " is offline"
							if (GetSpriteImageID(userCard[i].sprStatus) = imgStatusSleepingIcon) then statusTitle$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " is sleeping"
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:User Status;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + statusTitle$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// KEYS DISABLED
						if (OryUIGetSpriteReleased() = userCard[i].sprKeysDisabled)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Emergency Keys Disabled;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Keys on this lock have been disabled. " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " can not get out early by purchasing an emergency key.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// FREE UNLOCK
						if (OryUIGetSpriteReleased() = userCard[i].sprFreeUnlock)
							userSelected = sortedIteration
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Free Unlock Enabled;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You have allowed " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " to unlock for free when they need to.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 2)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelFreeUnlock;text:Cancel Free Unlock;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "CancelFreeUnlock"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersKeyholderAllowsFreeUnlockModifiedBy[userSelected] = -1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "", 0, 0, 0)
						endif
						
						// FAKE LOCK
						if (OryUIGetSpriteReleased() = userCard[i].sprFakeLock)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Fake Lock;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This is one of the fake locks. When it ends the combination revealed will be a fake one. It's recommended that you also update fake locks so that the lockee has no idea which is the real one;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// RATING BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprRatingRibbon)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:User Rating;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has an average rating of " + str(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAverageRatingFromKeyholders#[sortedIteration], 2) + " from " + str(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfRatingsFromKeyholders[sortedIteration])+ " ratings;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif

						// FREEZE BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprFreezeLockButton or OryUIGetSpriteReleased() = userCard[i].sprFreezeLockIcon)
							userSelected = sortedIteration
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[sortedIteration] = 1 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[sortedIteration] = 1)
								if (freezeLockAlertHidden = 0)
									dialogShown$ = "Freeze"
									if (sharedLocks[sharedLockSelected, 0].fixed = 0)
										OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unfreeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Unfreezing the lock will allow " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " to be able to pick and reveal cards again;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										OryUISetDialogButtonCount(userCard[i].dialog, 2)
										OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesUnfreezeUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelUnfreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(userCard[i].dialog)
									else
										OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unfreeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Unfreezing the lock will continue the countdown to zero;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										OryUISetDialogButtonCount(userCard[i].dialog, 2)
										OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesUnfreezeUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelUnfreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(userCard[i].dialog)
									endif
								else
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = -1
									UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UnfrozeLock", 0, 0, 1)
								endif
							else
								autoResetPending = 0
								noOfAutoResetsLeft = 0
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[sortedIteration] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[sortedIteration] > 0)
									secondsSinceLastReset = 0
									if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastAutoReset[sortedIteration] > 0 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastFullReset[sortedIteration] > 0)
										secondsSinceLastReset = timestampNow - MaxInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastAutoReset[sortedIteration], sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastFullReset[sortedIteration])
									else
										secondsSinceLastReset = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[sortedIteration]
									endif
									noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[sortedIteration])
									if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[sortedIteration] = 0)
										noOfAutoResetsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfTimesAutoReset[sortedIteration] - noOfAutoResetsPassedSinceLast
										if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
									else
										noOfAutoResetsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMaxAutoResets[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfTimesAutoReset[sortedIteration]
									endif
									secondsLeftUntilAutoReset = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetFrequencyInSeconds[sortedIteration] - secondsSinceLastReset
								endif
								if (noOfAutoResetsLeft > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPaused[sortedIteration] = 0)
									dialogShown$ = "Freeze"
									if (sharedLocks[sharedLockSelected, 0].fixed = 0)
										OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Freeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to freeze the lock for " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once frozen they will not be able to pick any cards until you unfreeze it." + chr(10) + chr(10) + "When this lock auto resets it will unfreeze the lock. To stop this from happening you will need to pause the auto resets first.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
										OryUISetDialogButtonCount(userCard[i].dialog, 3)
										OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesFreezeUser;text:Freeze Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesPauseAutoResets;text:Pause Auto Resets;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelFreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(userCard[i].dialog)
									else
										OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Freeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to freeze the lock for " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once frozen the countdown timer will remain frozen until you unfreeze it." + chr(10) + chr(10) + "When this lock auto resets it will unfreeze the lock. To stop this from happening you will need to pause the auto resets first.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
										OryUISetDialogButtonCount(userCard[i].dialog, 3)
										OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesFreezeUser;text:Freeze Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesPauseAutoResets;text:Pause Auto Resets;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(userCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelFreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(userCard[i].dialog)
									endif
								else
									if (freezeLockAlertHidden = 0)
										dialogShown$ = "Freeze"
										if (sharedLocks[sharedLockSelected, 0].fixed = 0)
											OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Freeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to freeze the lock for " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once frozen they will not be able to pick any cards until you unfreeze it.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
											OryUISetDialogButtonCount(userCard[i].dialog, 2)
											OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesFreezeUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelFreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIShowDialog(userCard[i].dialog)
										else
											OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Freeze Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to freeze the lock for " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once frozen the countdown timer will remain frozen until you unfreeze it.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
											OryUISetDialogButtonCount(userCard[i].dialog, 2)
											OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesFreezeUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelFreezeUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIShowDialog(userCard[i].dialog)
										endif
									else
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = 1
										UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:FrozeLock", 0, 0, 1)
									endif
								endif
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesUnfreezeUser"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[userSelected] = -1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UnfrozeLock", 0, 0, 1)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesFreezeUser"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[userSelected] = 1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:FrozeLock", 0, 0, 1)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesPauseAutoResets"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAutoResetsPausedModifiedBy[userSelected] = 1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:AutoResetsPaused", 0, 0, 1)
						endif
						if (OryUIGetDialogChecked(userCard[i].dialog) and dialogShown$ = "Freeze")
							freezeLockAlertHidden = 1
							SaveLocalVariable("freezeLockAlertHidden", str(freezeLockAlertHidden))
							dialogShown$ = ""
						endif
						
						// HIDE CARD INFO BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprHideCardInfoButton or OryUIGetSpriteReleased() = userCard[i].sprHideCardInfoIcon)
							userSelected = sortedIteration
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHidden[sortedIteration] = 1)
								if (hideCardInfoAlertHidden = 0)
									dialogShown$ = "HideCardInfo"
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Card Information?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to reveal the card information and counts to " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? They will see how many of each colour/card is in the deck.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesRevealCardInfo;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelRevealCardInfo;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
								else
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHiddenModifiedBy[sortedIteration] = -1
									UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:RevealedCardInfo", 0, 0, 1)
								endif
							else
								if (hideCardInfoAlertHidden = 0)
									dialogShown$ = "HideCardInfo"
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Hide Card Information?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to hide the card information and counts from " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once hidden they will not see how many of each color/card is in the deck, or know what updates you've made.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesHideCardInfo;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelHideCardInfo;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
								else
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHiddenModifiedBy[sortedIteration] = 1
									UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:HidCardInfo", 0, 0, 1)
								endif
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesRevealCardInfo"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHiddenModifiedBy[sortedIteration] = -1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:RevealedCardInfo", 0, 0, 1)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesHideCardInfo"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHiddenModifiedBy[sortedIteration] = 1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:HidCardInfo", 0, 0, 1)
						endif
						if (OryUIGetDialogChecked(userCard[i].dialog) and dialogShown$ = "HideCardInfo")
							hideCardInfoAlertHidden = 1
							SaveLocalVariable("hideCardInfoAlertHidden", str(hideCardInfoAlertHidden))
							dialogShown$ = ""
						endif
						
						// HIDE TIMER BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprFixedHideTimerButton or OryUIGetSpriteReleased() = userCard[i].sprFixedHideTimerIcon)
							userSelected = sortedIteration
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHidden[sortedIteration] = 1)
								if (hideTimerAlertHidden = 0)
									dialogShown$ = "HideTimer"
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Timer?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to reveal the timer? " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " will see how long they have left.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesRevealTimer;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelRevealTimer;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
								else
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHiddenModifiedBy[sortedIteration] = -1
									UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:RevealedTimer", 0, 0, 1)
								endif
							else
								if (hideTimerAlertHidden = 0)
									dialogShown$ = "HideTimer"
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Hide Timer?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to hide the timer from " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Once hidden they will not see how long they have left with the lock.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesHideTimer;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelHideTimer;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
								else
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHiddenModifiedBy[sortedIteration] = 1
									UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:HidTimer", 0, 0, 1)
								endif
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesRevealTimer"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHiddenModifiedBy[sortedIteration] = -1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:RevealedTimer", 0, 0, 1)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesHideTimer"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHiddenModifiedBy[sortedIteration] = 1
							UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:HidTimer", 0, 0, 1)
						endif
						if (OryUIGetDialogChecked(userCard[i].dialog) and dialogShown$ = "HideTimer")
							hideTimerAlertHidden = 1
							SaveLocalVariable("hideTimerAlertHidden", str(hideTimerAlertHidden))
							dialogShown$ = ""
						endif
						
						// CHECK-IN
						if (OryUIGetSpriteReleased() = userCard[i].sprCheckInButton or OryUIGetSpriteReleased() = userCard[i].sprCheckInIcon or OryUIGetSpriteReleased() = userCard[i].sprCheckInCooldown)
							userSelected = sortedIteration
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[sortedIteration]  = 0)
								secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[sortedIteration]
								secondsUntilNextCheckIn = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - timestampNow
								if (secondsUntilNextCheckIn > 0)
									checkInDialogTitle$ = "Check-in Not Required Yet"
									checkInDialogBody$ = "First check-in from " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " required in " + lower(ConvertSecondsToText(secondsUntilNextCheckIn, 1))
								else
									lateCheckIn = 0
									if (sharedLocks[sharedLockSelected, 0].fixed = 0)
										if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
											lateCheckIn = 1
										endif
									else
										if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400)))
											lateCheckIn = 1
										endif
									endif
									if (lateCheckIn = 1)
										if (sharedLocks[sharedLockSelected, 0].fixed = 0)
											if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - (sharedLocks[sharedLockSelected, 0].regularity# * 3600)
											else
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration]
											endif	
										else
											if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400))
											else
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration]
											endif	
										endif
										checkInDialogTitle$ = "Check-in Required (Late)"
										checkInDialogBody$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has not checked in and is " + lower(ConvertSecondsToText(secondsCheckInLate, 1)) + " late"
									else
										checkInDialogTitle$ = "Check-in Required"
										checkInDialogBody$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has not checked in, but is not late yet"
									endif 
								endif
							else
								secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[sortedIteration]
								secondsUntilNextCheckIn = (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastCheckedIn[sortedIteration] + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - timestampNow
								checkInDialogTitle$ = "Check-in Not Required Yet"
								checkInDialogBody$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " last checked in " + lower(ConvertSecondsToText(secondsSinceLastCheckIn, 1)) + " ago"
								if (secondsUntilNextCheckIn > 0)
									checkInDialogBody$ = checkInDialogBody$ + chr(10) + chr(10) + "Next check-in required in " + lower(ConvertSecondsToText(secondsUntilNextCheckIn, 1))			
								else
									lateCheckIn = 0
									if (sharedLocks[sharedLockSelected, 0].fixed = 0)
										if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
											if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
												lateCheckIn = 1
											endif
										else
											if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration])
												lateCheckIn = 1
											endif
										endif	
									else
										if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
											if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400)))
												lateCheckIn = 1
											endif
										else
											if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration])
												lateCheckIn = 1
											endif
										endif	
									endif
									if (lateCheckIn = 1)
										if (sharedLocks[sharedLockSelected, 0].fixed = 0)
											if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - (sharedLocks[sharedLockSelected, 0].regularity# * 3600)
											else
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration]
											endif
										else
											if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - (MinInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400))
											else
												secondsCheckInLate = (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCheckInFrequencyInSeconds[sortedIteration]) - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLateCheckInWindowInSeconds[sortedIteration]
											endif
										endif
										checkInDialogTitle$ = "Check-in Required (Late)"
										checkInDialogBody$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has not checked in and is " + lower(ConvertSecondsToText(secondsCheckInLate, 1)) + " late"
									else
										checkInDialogTitle$ = "Check-in Required"
										checkInDialogBody$ = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has not checked in, but is not late yet"
									endif 
								endif
							endif
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:" + checkInDialogTitle$ + ";titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + checkInDialogBody$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;deisionRequired:false")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// UNLOCK USER
						if (OryUIGetSpriteReleased() = userCard[i].sprUnlockButton or OryUIGetSpriteReleased() = userCard[i].sprUnlockIcon)
							userSelected = sortedIteration
							local fakeUnlockMessage$ = ""
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFakeLock[sortedIteration] = 1) then fakeUnlockMessage$ = chr(10) + chr(10) + "You are about to unlock a fake lock."
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock User?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to unlock " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "?" + fakeUnlockMessage$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 2)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesUnlockUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelUnlockUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesUnlockUser"))
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUnlocked[sortedIteration] = 1
							if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[sortedIteration] = 1 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[sortedIteration] = 1)
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = -1
							endif
							UnlockUsersLock(sharedLockSelected, userSelected, "action:UnlockedLock;actionedBy:Keyholder;result:Naturally", 1)
						endif
						
						// RESET USER
						if (OryUIGetSpriteReleased() = userCard[i].sprResetButton or OryUIGetSpriteReleased() = userCard[i].sprResetIcon)
							if (sharedLocks[sharedLockSelected, 0].fixed = 0)
								OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reset Users Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to reset the lock belonging to " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "?" + chr(10) + chr(10) + "Resetting it will start the lock again with the initial settings and card counts. It will not reset the total time locked.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(userCard[i].dialog, 2)
								OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesResetUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelResetUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(userCard[i].dialog)
								userSelected = sortedIteration
							else
								if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reset Users Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to reset the lock belonging to " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "?" + chr(10) + chr(10) + "Resetting it will start the timer again with a random time between the minimum and maximum originally set on this parent lock. It will not reset the total time locked.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesResetUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelResetUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
									userSelected = sortedIteration
								else
									OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reset Users Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to reset the lock belonging to " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + "? Resetting it will start the timer again. It will not reset the total time locked.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(userCard[i].dialog, 2)
									OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesResetUser;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(userCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelResetUser;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(userCard[i].dialog)
									userSelected = sortedIteration
								endif
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(userCard[i].dialog, "YesResetUser"))
							userSelected = sortedIteration
							if (sharedLocks[sharedLockSelected, 0].fixed = 0)
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReset[sortedIteration] = 1
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialDoubleUpCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialDoubleUpCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialDoubleUpCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialDoubleUpCards[sortedIteration])
								endif
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialFreezeCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialFreezeCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialFreezeCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialFreezeCards[sortedIteration])
								endif
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialGreenCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialGreenCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialGreenCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialGreenCards[sortedIteration])
								endif
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration])
								endif
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialResetCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialResetCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialResetCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialResetCards[sortedIteration])
								endif
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialStickyCards[sortedIteration] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[sortedIteration])
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialStickyCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[sortedIteration]
								elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialStickyCards[sortedIteration] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[sortedIteration])	
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCardsModifiedBy[sortedIteration] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCards[sortedIteration] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialStickyCards[sortedIteration])
								endif
								for a = 1 to 6
									if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialYellowCards[sortedIteration, a] > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[sortedIteration, a])
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[sortedIteration, a] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialYellowCards[sortedIteration, a] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[sortedIteration, a]
									elseif (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialYellowCards[sortedIteration, a] < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[sortedIteration, a])	
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[sortedIteration, a] = -(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCards[sortedIteration, a] - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialYellowCards[sortedIteration, a])
									endif
								next	
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCardsPicked[sortedIteration] = 0
								if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByCard[sortedIteration] = 1 or sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[sortedIteration] = 1)
									sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = -1
								endif
								UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:ResetLock", 0, 0, 1)
							else
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReset[sortedIteration] = 1
								if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
									minutesLocked as integer : minutesLocked = (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[sortedIteration]) / 60
									minutesLeft as integer : minutesLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMinutes[sortedIteration] - minutesLocked + (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTotalTimeFrozen[sortedIteration] / 60)
									randomMinutes as integer : randomMinutes = random2(sharedLocks[sharedLockSelected, 0].minRandomMinutes, sharedLocks[sharedLockSelected, 0].maxRandomMinutes)
									if (minutesLeft > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialMinutes[sortedIteration])
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMinutesModifiedBy[sortedIteration] = -(minutesLeft - randomMinutes)//sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialMinutes[sortedIteration])
									elseif (minutesLeft < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialMinutes[sortedIteration])
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMinutesModifiedBy[sortedIteration] = randomMinutes - minutesLeft //sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialMinutes[sortedIteration] - minutesLeft
									endif
									if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[sortedIteration] = 1)
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = -1
									endif
								else
									redCardsPassed as integer : redCardsPassed = floor((timestampNow - MaxInt(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLocked[sortedIteration], sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastFullReset[sortedIteration])) / (sharedLocks[sharedLockSelected, 0].regularity# * 3600))
									redCardsLeft as integer : redCardsLeft = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCards[sortedIteration] - redCardsPassed + (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTotalTimeFrozen[sortedIteration] / (sharedLocks[sharedLockSelected, 0].regularity# * 3600))
									if (redCardsLeft > sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration])
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCardsModifiedBy[sortedIteration] = -(redCardsLeft - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration])
									elseif (redCardsLeft < sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration])
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCardsModifiedBy[sortedIteration] = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialRedCards[sortedIteration] - redCardsLeft
									endif
									if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholder[sortedIteration] = 1)
										sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[sortedIteration] = -1
									endif
								endif
								UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:ResetLock", 0, 0, 1)
							endif
						endif
						
						// EDIT USER
						if (OryUIGetSpriteReleased() = userCard[i].sprEditButton or OryUIGetSpriteReleased() = userCard[i].sprEditIcon)
							userSelected = sortedIteration
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersCardInfoHiddenModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersDoubleUpCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersFreezeCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersGreenCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersInitialMinutesModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersLockFrozenByKeyholderModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersMinutesModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRedCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersResetCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersStickyCardsModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimerHiddenModifiedBy[userSelected] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 1] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 2] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 3] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 4] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 5] = 0
							sharedLocks[sharedLockSelected, selectedManageUsersTab].usersYellowCardsModifiedBy[userSelected, 6] = 0
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constUsersLockUpdateScreen)
						endif

						// MORE
						if (OryUIGetSpriteReleased() = userCard[i].sprMoreButton or OryUIGetSpriteReleased() = userCard[i].sprMoreIcon)
							userSelected = sortedIteration
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constUsersLockInformationScreen)
						endif
						
						// MOOD
						if (OryUIGetSpriteReleased() = userCard[i].sprMoodButton or OryUIGetSpriteReleased() = userCard[i].sprMoodIcon)
							userSelected = sortedIteration
							emojiChosen = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersKeyholderEmojiChosen[sortedIteration]
							emojiColourSelected = sharedLocks[sharedLockSelected, selectedManageUsersTab].usersKeyholderEmojiColourSelected[sortedIteration]
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constEmojisScreen)
						endif
						
						// FAVOURITE USER
						if (OryUIGetSpriteReleased() = userCard[i].sprFavouriteButton or OryUIGetSpriteReleased() = userCard[i].sprFavouriteIcon and GetSpriteImageID(userCard[i].sprFavouriteIcon) = imgFavouriteOff)
							userSelected = sortedIteration
							if (favouriteUsers.find(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[sortedIteration]) = -1) then favouriteUsers.insert(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[sortedIteration])
							favouriteUsers.sort()
							favouriteUsers.save("favouriteUsers.json")
							OryUIUpdateSprite(userCard[i].sprFavouriteIcon, "image:" + str(imgFavouriteOn) + ";color:255,255,255,255")
						elseif (OryUIGetSpriteReleased() = userCard[i].sprFavouriteButton or OryUIGetSpriteReleased() = userCard[i].sprFavouriteIcon and GetSpriteImageID(userCard[i].sprFavouriteIcon) = imgFavouriteOn)
							userSelected = sortedIteration
							favouriteUsers.remove(favouriteUsers.find(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[sortedIteration]))
							favouriteUsers.sort()
							favouriteUsers.save("favouriteUsers.json")
							OryUIUpdateSprite(userCard[i].sprFavouriteIcon, "image:" + str(imgFavouriteOff) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
							if (filterLockedUsersBy$ = "FilterLockedUsersFavourites")
								screen[screenNo].lastViewY# = GetViewOffsetY()
								SetScreenToView(constManageLockedUsersScreen)
							endif
						endif
			
						// FLAGS
						if (OryUIGetSpriteReleased() = userCard[i].sprFlagButton or OryUIGetSpriteReleased() = userCard[i].sprFlagIcon)
							userSelected = sortedIteration
							flagCount = 0
							chosenFlagName$ = ""
							for a = 1 to 7
								if (a = 1) then flagName$ = "FlagBlack"
								if (a = 2) then flagName$ = "FlagBlue"
								if (a = 3) then flagName$ = "FlagGreen"
								if (a = 4) then flagName$ = "FlagOrange"
								if (a = 5) then flagName$ = "FlagPurple"
								if (a = 6) then flagName$ = "FlagRed"
								if (a = 7) then flagName$ = "FlagYellow"
								if (flagChosen = a) then chosenFlagName$ = flagName$
								if (flagChosen <> a)
									inc flagCount
									OryUIUpdateButtonGroupItem(userCard[i].flagButtonGroup, flagCount, "name:" + flagName$ + ";text: ;iconID:" + str(imgFlags[a]))	
								endif
							next
							if (flagCount = 6)
								OryUIUpdateButtonGroupItem(userCard[i].flagButtonGroup, 7, "name:FlagCancel;text: ;iconID:" + str(imgFlags[9]))
								OryUIUpdateButtonGroupItem(userCard[i].flagButtonGroup, 8, "name:" + chosenFlagName$ + ";text: ;iconID:" + str(imgFlags[flagChosen]))
							else
								OryUIUpdateButtonGroupItem(userCard[i].flagButtonGroup, 8, "name:FlagCancel;text: ;iconID:" + str(imgBlank))
							endif
							OryUISetButtonGroupItemSelectedByIndex(userCard[i].flagButtonGroup, 8)
							OryUIDisableScreenScrolling()
							OryUIUpdateSprite(userCard[i].sprScrim, "position:" + str(GetViewOffsetX()) + "," + str(GetViewOffsetY() + screenBoundsTop#))
							OryUIUpdateButtonGroup(userCard[i].flagButtonGroup, "offset:" + str(OryUIGetButtonGroupWidth(userCard[i].flagButtonGroup)) + "," + str(OryUIGetButtonGroupHeight(userCard[i].flagButtonGroup) / 2) + ";position:" + str(GetSpriteX(userCard[i].sprFlagButton) + GetSpriteWidth(userCard[i].sprFlagButton)) + "," + str(GetSpriteY(userCard[i].sprFlagButton) + (GetSpriteHeight(userCard[i].sprFlagButton) / 2)) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(theme[themeSelected].color[2]))
						elseif (OryUIGetSpritePressed() = userCard[i].sprScrim)
							OryUIEnableScreenScrolling()
							OryUIUpdateSprite(userCard[i].sprScrim, "position:-1000,-1000")
							OryUIUpdateButtonGroup(userCard[i].flagButtonGroup, "position:-1000,-1000")
						endif
						OryUIInsertButtonGroupListener(userCard[i].flagButtonGroup)
						flagChosen = -1
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagCancel")) then flagChosen = 0
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagBlack")) then flagChosen = 1
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagBlue")) then flagChosen = 2
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagGreen")) then flagChosen = 3
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagOrange")) then flagChosen = 4
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagPurple")) then flagChosen = 5
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagRed")) then flagChosen = 6
						if (OryUIGetButtonGroupItemReleasedByName(userCard[i].flagButtonGroup, "FlagYellow")) then flagChosen = 7
						if (flagChosen >= 0)
							OryUIEnableScreenScrolling()
							AddUserFlag(flagChosen, sharedLocks[sharedLockSelected, selectedManageUsersTab].usersID[sortedIteration])
							if (flagChosen = 0)
								OryUIUpdateSprite(userCard[i].sprFlagIcon, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
							else
								OryUIUpdateSprite(userCard[i].sprFlagIcon, "image:" + str(imgFlags[flagChosen]) + ";color:255,255,255,255")
							endif
							OryUIUpdateSprite(userCard[i].sprScrim, "position:-1000,-1000")
							OryUIUpdateButtonGroup(userCard[i].flagButtonGroup, "position:-1000,-1000")
							
							if (filterLockedUsersByFlag$ <> "FilterLockedUsersFlagAll" and flagChosen <> filterFlagNo)
								screen[screenNo].lastViewY# = GetViewOffsetY()
								SetScreenToView(constManageLockedUsersScreen)
							endif
						endif
					
					endif
					
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * filterCount) - 2
	endif
	
	// LAST REFRESHED BAR
	OryUIUpdateSprite(sprLockedUsersLastRefreshedBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + abs(screenBoundsTop#) + 97) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateSprite(sprLockedUsersLastRefreshedBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + abs(screenBoundsTop#) + 96))
	secondsSinceLastSync as integer : secondsSinceLastSync = timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].timestampLastSync
	timeSinceLastSync$ as string : timeSinceLastSync$ = ""
	if (secondsSinceLastSync > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].timestampLastSync > 0)
		if (secondsSinceLastSync = 1)
			timeSinceLastSync$ = "1 second ago"
		elseif (secondsSinceLastSync < 60)
			timeSinceLastSync$ = str(secondsSinceLastSync) + " seconds ago"
		elseif (secondsSinceLastSync < 119)
			timeSinceLastSync$ = "1 minute ago"
		elseif (secondsSinceLastSync < 3600)
			timeSinceLastSync$ = str(secondsSinceLastSync / 60) + " minutes ago"
		elseif (secondsSinceLastSync < 7200)
			timeSinceLastSync$ = "1 hour ago"
		elseif (secondsSinceLastSync >= 7200)
			timeSinceLastSync$ = str(secondsSinceLastSync / 60 / 60) + " hours ago"
		endif
	else
		timeSinceLastSync$ = "N/A"
	endif
	OryUIUpdateText(txtLockedUsersLastRefreshed, "text:Last Refreshed[colon] " + timeSinceLastSync$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	OryUIPinTextToCentreOfSprite(txtLockedUsersLastRefreshed, sprLockedUsersLastRefreshedBar, 0, 0)
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50 //7 // + 20
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
