
if (screenToView = constManageUnlockedUsersScreen)
	if (screenNo <> constManageUnlockedUsersScreen)
		filterCount = 0
		filterUnlockedUsersByFlagLabel$ as string : filterUnlockedUsersByFlagLabel$ = ""
		filterUnlockedUsersByLabel$ as string : filterUnlockedUsersByLabel$ = ""
		lastUnlockedUsersSearchLength as integer : lastUnlockedUsersSearchLength = 0
		OryUIUpdateTextfield(editUnlockedUsersSearch, "inputText:" + sharedLocksSearchString$)
		if (filterSharedLocksBy$ = "FilterUnlockedLocksAwaitingRating")
			filterUnlockedUsersBy$ = "FilterUnlockedUsersAwaitingRating"
		endif
		sortUnlockedUsersByLabel$ as string : sortUnlockedUsersByLabel$ = ""
	endif
	screenNo = constManageUnlockedUsersScreen
	selectedManageUsersTab = 2
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
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 2, 1)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 3)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 3, 1)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterUnlockedUsersBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnIconFilterUnlockedUsers, "position:" + str(OryUIGetButtonX(btnIconFilterUnlockedUsersByFlags) + OryUIGetButtonWidth(btnIconFilterUnlockedUsersByFlags) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredUnlockedUsersBy, "text:" + filterUnlockedUsersByLabel$ + filterUnlockedUsersByFlagLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterUnlockedUsers) + OryUIGetButtonWidth(btnIconFilterUnlockedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)))
	OryUIUpdateButton(btnIconSortUnlockedUsers, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortUnlockedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (sortUnlockedUsersBy$ <> "SortUnlockedUsersByRandom")
		OryUIUpdateButton(btnTextSortedUnlockedUsersBy, "text:" + sortUnlockedUsersByLabel$ + " (" + sortUnlockedUsersOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortUnlockedUsers) - OryUIGetButtonWidth(btnTextSortedUnlockedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)))
	else
		OryUIUpdateButton(btnTextSortedUnlockedUsersBy, "text:" + sortUnlockedUsersByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortUnlockedUsers) - OryUIGetButtonWidth(btnTextSortedUnlockedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterUnlockedUsersBar) / 2)))
	endif	
	OryUIUpdateSprite(sprFilterUnlockedUsersBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterUnlockedUsersBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterUnlockedUsersBar) //+ 2
	
	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 2, 1)
	endif
	
	// FILTER MENUS
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterUnlockedUsersByFlags, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlack") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[1]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlue") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[2]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagGreen") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[3]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagOrange") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[4]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagPurple") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[5]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagRed") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[6]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagYellow") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[7]) + ";color:255,255,255,255")
	if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagAll") then OryUIUpdateButton(btnIconFilterUnlockedUsersByFlags, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (OryUIGetButtonReleased(btnIconFilterUnlockedUsersByFlags))
		OryUISetMenuItemCount(menuFilterUnlockedUsersByFlags, 8)
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 1, "name:FilterUnlockedUsersFlagBlack;text: ;lefticonID:" + str(imgFlags[1]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 2, "name:FilterUnlockedUsersFlagBlue;text: ;lefticonID:" + str(imgFlags[2]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 3, "name:FilterUnlockedUsersFlagGreen;text: ;lefticonID:" + str(imgFlags[3]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 4, "name:FilterUnlockedUsersFlagOrange;text: ;lefticonID:" + str(imgFlags[4]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 5, "name:FilterUnlockedUsersFlagPurple;text: ;lefticonID:" + str(imgFlags[5]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 6, "name:FilterUnlockedUsersFlagRed;text: ;lefticonID:" + str(imgFlags[6]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 7, "name:FilterUnlockedUsersFlagYellow;text: ;lefticonID:" + str(imgFlags[7]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 8, "name:FilterUnlockedUsersFlagAll;text: ;lefticonID:" + str(imgFlags[9]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlack") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 1, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlue") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 2, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagGreen") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 3, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagOrange") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 4, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagPurple") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 5, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagRed") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 6, "rightIconID:" + str(imgTickIcon))
		if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagYellow") then OryUIUpdateMenuItem(menuFilterUnlockedUsersByFlags, 7, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterUnlockedUsersByFlags, OryUIGetButtonX(btnIconFilterUnlockedUsersByFlags), OryUIGetButtonY(btnIconFilterUnlockedUsersByFlags) + OryUIGetButtonHeight(btnIconFilterUnlockedUsersByFlags))
	endif
	OryUIInsertMenuListener(menuFilterUnlockedUsersByFlags)
		if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagBlack" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlack")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlack"
		filterUnlockedUsersByFlagLabel$ = " (Black Flags)"
		filterFlagNo = 1
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagBlue" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlue")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlue"
		filterUnlockedUsersByFlagLabel$ = " (Blue Flags)"
		filterFlagNo = 2
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagGreen" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagGreen")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagGreen"
		filterUnlockedUsersByFlagLabel$ = " (Green Flags)"
		filterFlagNo = 3
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagOrange" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagOrange")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagOrange"
		filterUnlockedUsersByFlagLabel$ = " (Orange Flags)"
		filterFlagNo = 4
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagPurple" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagPurple")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagPurple"
		filterUnlockedUsersByFlagLabel$ = " (Purple Flags)"
		filterFlagNo = 5
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagRed" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagRed")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagRed"
		filterUnlockedUsersByFlagLabel$ = " (Red Flags)"
		filterFlagNo = 6
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagYellow" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagYellow")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagYellow"
		filterUnlockedUsersByFlagLabel$ = " (Yellow Flags)"
		filterFlagNo = 7
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) = "FilterUnlockedUsersFlagAll" or filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagAll")
		filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagAll"
		filterUnlockedUsersByFlagLabel$ = ""
		filterFlagNo = 0
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsersByFlags) <> "")
		SaveLocalVariable("filterUnlockedUsersByFlag", filterUnlockedUsersByFlag$)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterUnlockedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterUnlockedUsers) or OryUIGetButtonReleased(btnTextFilteredUnlockedUsersBy))
		local menuFilterUnlockedUsersItemCount as integer
		local menuFilterUnlockedUsersAllVisible as integer
		local menuFilterUnlockedUsersAwaitingRatingVisible as integer
		local menuFilterUnlockedUsersFavouritesVisible as integer
		local menuFilterUnlockedUsersUsedKeyVisible as integer
		local menuFilterUnlockedUsersTestLocksVisible as integer
		local menuFilterUnlockedUsersExcludeTestLocksVisible as integer
		menuFilterUnlockedUsersAllVisible = 1
		menuFilterUnlockedUsersAwaitingRatingVisible = 1
		menuFilterUnlockedUsersFavouritesVisible = 1	
		menuFilterUnlockedUsersUsedKeyVisible = 1	
		menuFilterUnlockedUsersTestLocksVisible = 0
		if (filterUnlockedUsersExcludeTestLocks = 0) then menuFilterUnlockedUsersTestLocksVisible = 1	
		menuFilterUnlockedUsersExcludeTestLocksVisible = 1
		menuFilterUnlockedUsersItemCount = menuFilterUnlockedUsersAllVisible + menuFilterUnlockedUsersAwaitingRatingVisible + menuFilterUnlockedUsersFavouritesVisible + menuFilterUnlockedUsersUsedKeyVisible + menuFilterUnlockedUsersTestLocksVisible + menuFilterUnlockedUsersExcludeTestLocksVisible
		
		OryUISetMenuItemCount(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount)
		menuFilterUnlockedUsersItemCount = 0
		if (menuFilterUnlockedUsersAllVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersAll") then OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterUnlockedUsersAwaitingRatingVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersAwaitingRating;text:Pending Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersAwaitingRating") then OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterUnlockedUsersFavouritesVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersFavourites;text:Favourites;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersFavourites") then OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterUnlockedUsersUsedKeyVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersUsedKey;text:Used Key;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersUsedKey") then OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterUnlockedUsersTestLocksVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersTestLocks;text:Test Locks;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersTestLocks") then OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterUnlockedUsersExcludeTestLocksVisible = 1)
			inc menuFilterUnlockedUsersItemCount
			if (filterUnlockedUsersExcludeTestLocks = 0)
				OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxUncheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateMenuItem(menuFilterUnlockedUsers, menuFilterUnlockedUsersItemCount, "name:FilterUnlockedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxCheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		OryUIShowMenu(menuFilterUnlockedUsers, OryUIGetButtonX(btnIconFilterUnlockedUsers), OryUIGetButtonY(btnIconFilterUnlockedUsers) + OryUIGetButtonHeight(btnIconFilterUnlockedUsers))		
	endif
	OryUIInsertMenuListener(menuFilterUnlockedUsers)
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersAll" or filterUnlockedUsersBy$ = "FilterUnlockedUsersAll")
		filterUnlockedUsersBy$ = "FilterUnlockedUsersAll"
		filterUnlockedUsersByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersAwaitingRating" or filterUnlockedUsersBy$ = "FilterUnlockedUsersAwaitingRating")
		filterUnlockedUsersBy$ = "FilterUnlockedUsersAwaitingRating"
		filterUnlockedUsersByLabel$ = "Pending Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersFavourites" or filterUnlockedUsersBy$ = "FilterUnlockedUsersFavourites")
		filterUnlockedUsersBy$ = "FilterUnlockedUsersFavourites"
		filterUnlockedUsersByLabel$ = "Favourites"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersUsedKey" or filterUnlockedUsersBy$ = "FilterUnlockedUsersUsedKey")
		filterUnlockedUsersBy$ = "FilterUnlockedUsersUsedKey"
		filterUnlockedUsersByLabel$ = "Used Key"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersTestLocks" or filterUnlockedUsersBy$ = "FilterUnlockedUsersTestLocks")
		filterUnlockedUsersBy$ = "FilterUnlockedUsersTestLocks"
		filterUnlockedUsersByLabel$ = "Test Locks"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) = "FilterUnlockedUsersExcludeTestLocks")
		if (filterUnlockedUsersExcludeTestLocks = 0)
			filterUnlockedUsersExcludeTestLocks = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersTestLocks")
				filterUnlockedUsersBy$ = "FilterUnlockedUsersAll"
				filterUnlockedUsersByLabel$ = "All"
			endif
		else
			filterUnlockedUsersExcludeTestLocks = 0
		endif
		SaveLocalVariable("filterUnlockedUsersExcludeTestLocks", str(filterUnlockedUsersExcludeTestLocks))
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterUnlockedUsers) <> "")
		SaveLocalVariable("filterUnlockedUsersBy", filterUnlockedUsersBy$)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortUnlockedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortUnlockedUsers) or OryUIGetButtonReleased(btnTextSortedUnlockedUsersBy))
		OryUISetMenuItemCount(menuSortUnlockedUsers, 5)
		OryUIUpdateMenuItem(menuSortUnlockedUsers, 1, "name:SortUnlockedUsersByDateUnlocked;text:Date Unlocked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortUnlockedUsers, 2, "name:SortUnlockedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortUnlockedUsers, 3, "name:SortUnlockedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortUnlockedUsers, 4, "name:SortUnlockedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortUnlockedUsers, 5, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked") then OryUIUpdateMenuItem(menuSortUnlockedUsers, 1, "rightIconID:" + str(imgTickIcon))
		if (sortUnlockedUsersBy$ = "SortUnlockedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortUnlockedUsers, 2, "rightIconID:" + str(imgTickIcon))
		if (sortUnlockedUsersBy$ = "SortUnlockedUsersByUsername") then OryUIUpdateMenuItem(menuSortUnlockedUsers, 3, "rightIconID:" + str(imgTickIcon))
		if (sortUnlockedUsersBy$ = "SortUnlockedUsersByUserRating") then OryUIUpdateMenuItem(menuSortUnlockedUsers, 4, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortUnlockedUsers, OryUIGetButtonX(btnIconSortUnlockedUsers), OryUIGetButtonY(btnIconSortUnlockedUsers) + OryUIGetButtonHeight(btnIconSortUnlockedUsers))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortUnlockedUsers, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortUnlockedUsers)
	OryUIInsertMenuListener(menuSortUnlockedUsers)
	if (OryUIGetMenuVisible(menuSortUnlockedUsers) and sortUnlockedUsersBy$ <> "SortUnlockedUsersByRandom")
		OryUIUpdateButtonGroup(grpSortUnlockedUsers, "position:" + str(OryUIGetMenuX(menuSortUnlockedUsers)) + "," + str(OryUIGetMenuY(menuSortUnlockedUsers) + OryUIGetMenuHeight(menuSortUnlockedUsers) - OryUIGetButtonGroupHeight(grpSortUnlockedUsers)))
	else
		OryUIUpdateButtonGroup(grpSortUnlockedUsers, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUnlockedUsers) = "SortUnlockedUsersByDateUnlocked" or sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked")
		sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked"
		sortUnlockedUsersByLabel$ = "Date Unlocked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUnlockedUsers) = "SortUnlockedUsersByDurationLocked" or sortUnlockedUsersBy$ = "SortUnlockedUsersByDurationLocked")
		sortUnlockedUsersBy$ = "SortUnlockedUsersByDurationLocked"
		sortUnlockedUsersByLabel$ = "Duration Locked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUnlockedUsers) = "SortUnlockedUsersByUsername" or sortUnlockedUsersBy$ = "SortUnlockedUsersByUsername")
		sortUnlockedUsersBy$ = "SortUnlockedUsersByUsername"
		sortUnlockedUsersByLabel$ = "Username"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUnlockedUsers) = "SortUnlockedUsersByUserRating" or sortUnlockedUsersBy$ = "SortUnlockedUsersByUserRating")
		sortUnlockedUsersBy$ = "SortUnlockedUsersByUserRating"
		sortUnlockedUsersByLabel$ = "User Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortUnlockedUsers) <> "")
		SaveLocalVariable("sortUnlockedUsersBy", sortUnlockedUsersBy$)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortUnlockedUsers, "ASC"))
		sortUnlockedUsersOrder$ = "ASC"
		SaveLocalVariable("sortUnlockedUsersOrder", sortUnlockedUsersOrder$)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortUnlockedUsers, "DESC"))
		sortUnlockedUsersOrder$ = "DESC"
		SaveLocalVariable("sortUnlockedUsersOrder", sortUnlockedUsersOrder$)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	
	// UNLOCKED USERS LOCKS SEARCH BAR
	if (sharedLocks[sharedLockSelected, 0].unlockedUsers > 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetSharedLockUsersData"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprUnlockedUsersSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editUnlockedUsersSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editUnlockedUsersSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editUnlockedUsersSearch))
			OryUISetTextfieldString(editUnlockedUsersSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editUnlockedUsersSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editUnlockedUsersSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editUnlockedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editUnlockedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editUnlockedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editUnlockedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editUnlockedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editUnlockedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		if (sharedLocksSearchString$ <> OryUIGetTextfieldString(editUnlockedUsersSearch))
			sharedLocksSearchString$ = ""
		endif
		elementY# = elementY# + GetSpriteHeight(sprUnlockedUsersSearchBar) + 2
	else
		OryUIUpdateSprite(sprUnlockedUsersSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editUnlockedUsersSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	// SORT UNLOCKED USERS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editUnlockedUsersSearch)) <> lastUnlockedUsersSearchLength)
		lastUnlockedUsersSearchLength = len(OryUIGetTextFieldString(editUnlockedUsersSearch))
		SortUnlockedUsers(OryUIGetTextfieldString(editUnlockedUsersSearch))
		redrawScreen = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO UNLOCKED USERS
	if (sharedLocks[sharedLockSelected, 0].unlockedUsers = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, "app/v" + ReplaceString(constVersionNumber$, " ", ".", -1) + "/agkgetsharedlockusers.php"))
			OryUIUpdateText(txtNoUnlockedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoUnlockedUsers, "text:No Unlocked Users;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	elseif (filterCount = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, "app/v" + ReplaceString(constVersionNumber$, " ", ".", -1) + "/agkgetsharedlockusers.php"))
			OryUIUpdateText(txtNoUnlockedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			if (filterUnlockedUsersExcludeTestLocks = 0)
				OryUIUpdateText(txtNoUnlockedUsers, "text:No Unlocked Users Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateText(txtNoUnlockedUsers, "text:No Unlocked Users Matching Filter" + chr(10) + "Excluding Test Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
	else
		OryUIUpdateText(txtNoUnlockedUsers, "position:-1000,-1000")
	endif
	
	// UNLOCKED USERS
	if (redrawScreen = 1)
		for i = 1 to 8
			DestroyItemsInUnLockedUsersCard(i)
			CreateItemsInUnLockedUsersCard(i)
		next
	endif
	if (filterCount > 0)
		fullCardHeight# = GetSpriteHeight(userCard[1].sprBackground) + GetSpriteHeight(userCard[1].sprButtonBar) + 2.0
		for i = 1 to 8
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(userCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					elementY# = elementY# + GetSpriteHeight(userCard[i].sprBackground)
					OryUIUpdateSprite(userCard[i].sprButtonBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
					elementY# = elementY# + GetSpriteHeight(userCard[i].sprButtonBar) + 2
					userCard[i].iteration = i
				endif
				if (GetSpriteY(userCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and userCard[i].iteration + 8 <= filterCount)
					userCard[i].iteration = userCard[i].iteration + 8
					OryUIUpdateSprite(userCard[i].sprBackground, "y:" + str(GetSpriteY(userCard[i].sprBackground) + (fullCardHeight# * 8)))
					OryUIUpdateSprite(userCard[i].sprButtonBar, "y:" + str(GetSpriteY(userCard[i].sprBackground) + GetSpriteHeight(userCard[i].sprBackground)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(userCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 8) and userCard[i].iteration - 8 >= 1)
					userCard[i].iteration = userCard[i].iteration - 8
					OryUIUpdateSprite(userCard[i].sprBackground, "y:" + str(GetSpriteY(userCard[i].sprBackground) - (fullCardHeight# * 8)))
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

				UpdateItemsInUnlockedUsersCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(userCard[i].dialog)
					
					if (OryUIGetSwipingVertically() = 0)
						
						// USED KEY BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprUsedKey)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Used Key;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " purchased an emergency key to unlock early;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
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
						
						// RATING BUTTON
						if (OryUIGetSpriteReleased() = userCard[i].sprRatingRibbon)
							OryUIUpdateDialog(userCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:User Rating;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[sortedIteration] + " has an average rating of " + str(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersAverageRatingFromKeyholders#[sortedIteration], 2) + " from " + str(sharedLocks[sharedLockSelected, selectedManageUsersTab].usersNoOfRatingsFromKeyholders[sortedIteration])+ " ratings;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(userCard[i].dialog, 1)
							OryUIUpdateDialogButton(userCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(userCard[i].dialog)
						endif
						
						// RATING
						for a = 1 to 5
							if (OryUIGetSpriteReleased() = userCard[i].sprRatingStar[a] and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRatingFromKeyholder[sortedIteration] <> a)
								userSelected = sortedIteration
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersRatingFromKeyholder[sortedIteration] = a
								sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampKeyholderRated[sortedIteration] = timestampNow
								UpdateUsersRatingFromKeyholder(sharedLockSelected, selectedManageUsersTab, userSelected, "action:RatedLock;actionedBy:Keyholder;result:" + str(a) + ";private:1", 0)
								UpdateItemsInUnlockedUsersCard(i, sortedIteration, 1)
							endif
						next

						// MORE
						if (OryUIGetSpriteReleased() = userCard[i].sprMoreButton or OryUIGetSpriteReleased() = userCard[i].sprMoreIcon)
							userSelected = sortedIteration
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constUsersLockInformationScreen)
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
								SetScreenToView(constManageUnlockedUsersScreen)
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
								SetScreenToView(constManageUnlockedUsersScreen)
							endif
						endif
					
					endif
					
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * filterCount) - 2
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
