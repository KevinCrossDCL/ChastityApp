
if (screenToView = constManageDesertedUsersScreen)
	if (screenNo <> constManageDesertedUsersScreen)
		filterCount = 0
		filterDesertedUsersByLabel$ as string : filterDesertedUsersByLabel$ = ""
		filterDesertedUsersByFlagLabel$ as string : filterDesertedUsersByFlagLabel$ = ""
		lastDesertedUsersSearchLength as integer : lastDesertedUsersSearchLength = 0
		OryUIUpdateTextfield(editDesertedUsersSearch, "inputText:" + sharedLocksSearchString$)
		if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating")
			filterDesertedUsersBy$ = "FilterDesertedUsersAwaitingRating"
		endif
		sortDesertedUsersByLabel$ as string : sortDesertedUsersByLabel$ = ""
	endif
	screenNo = constManageDesertedUsersScreen
	selectedManageUsersTab = 3
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
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 3, 1)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 3)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
		SetScreenToView(constManageLockedUsersScreen)
	endif
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 2, 1)
		SetScreenToView(constManageUnlockedUsersScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterDesertedUsersBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnIconFilterDesertedUsers, "position:" + str(OryUIGetButtonX(btnIconFilterDesertedUsersByFlags) + OryUIGetButtonWidth(btnIconFilterDesertedUsersByFlags) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredDesertedUsersBy, "text:" + filterDesertedUsersByLabel$ + filterDesertedUsersByFlagLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterDesertedUsers) + OryUIGetButtonWidth(btnIconFilterDesertedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)))
	OryUIUpdateButton(btnIconSortDesertedUsers, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortDesertedUsers)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (sortDesertedUsersBy$ <> "SortDesertedUsersByRandom")
		OryUIUpdateButton(btnTextSortedDesertedUsersBy, "text:" + sortDesertedUsersByLabel$ + " (" + sortDesertedUsersOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortDesertedUsers) - OryUIGetButtonWidth(btnTextSortedDesertedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)))
	else
		OryUIUpdateButton(btnTextSortedDesertedUsersBy, "text:" + sortDesertedUsersByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortDesertedUsers) - OryUIGetButtonWidth(btnTextSortedDesertedUsersBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterDesertedUsersBar) / 2)))
	endif	
	OryUIUpdateSprite(sprFilterDesertedUsersBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterDesertedUsersBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterDesertedUsersBar) //+ 2
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 3, 1)
	endif
	
	// FILTER MENUS
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterDesertedUsersByFlags, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlack") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[1]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlue") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[2]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagGreen") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[3]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagOrange") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[4]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagPurple") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[5]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagRed") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[6]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagYellow") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[7]) + ";color:255,255,255,255")
	if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagAll") then OryUIUpdateButton(btnIconFilterDesertedUsersByFlags, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (OryUIGetButtonReleased(btnIconFilterDesertedUsersByFlags))
		OryUISetMenuItemCount(menuFilterDesertedUsersByFlags, 8)
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 1, "name:FilterDesertedUsersFlagBlack;text: ;lefticonID:" + str(imgFlags[1]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 2, "name:FilterDesertedUsersFlagBlue;text: ;lefticonID:" + str(imgFlags[2]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 3, "name:FilterDesertedUsersFlagGreen;text: ;lefticonID:" + str(imgFlags[3]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 4, "name:FilterDesertedUsersFlagOrange;text: ;lefticonID:" + str(imgFlags[4]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 5, "name:FilterDesertedUsersFlagPurple;text: ;lefticonID:" + str(imgFlags[5]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 6, "name:FilterDesertedUsersFlagRed;text: ;lefticonID:" + str(imgFlags[6]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 7, "name:FilterDesertedUsersFlagYellow;text: ;lefticonID:" + str(imgFlags[7]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 8, "name:FilterDesertedUsersFlagAll;text: ;lefticonID:" + str(imgFlags[9]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlack") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 1, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlue") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 2, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagGreen") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 3, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagOrange") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 4, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagPurple") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 5, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagRed") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 6, "rightIconID:" + str(imgTickIcon))
		if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagYellow") then OryUIUpdateMenuItem(menuFilterDesertedUsersByFlags, 7, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterDesertedUsersByFlags, OryUIGetButtonX(btnIconFilterDesertedUsersByFlags), OryUIGetButtonY(btnIconFilterDesertedUsersByFlags) + OryUIGetButtonHeight(btnIconFilterDesertedUsersByFlags))
	endif
	OryUIInsertMenuListener(menuFilterDesertedUsersByFlags)
		if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagBlack" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlack")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlack"
		filterDesertedUsersByFlagLabel$ = " (Black Flags)"
		filterFlagNo = 1
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagBlue" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlue")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlue"
		filterDesertedUsersByFlagLabel$ = " (Blue Flags)"
		filterFlagNo = 2
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagGreen" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagGreen")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagGreen"
		filterDesertedUsersByFlagLabel$ = " (Green Flags)"
		filterFlagNo = 3
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagOrange" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagOrange")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagOrange"
		filterDesertedUsersByFlagLabel$ = " (Orange Flags)"
		filterFlagNo = 4
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagPurple" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagPurple")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagPurple"
		filterDesertedUsersByFlagLabel$ = " (Purple Flags)"
		filterFlagNo = 5
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagRed" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagRed")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagRed"
		filterDesertedUsersByFlagLabel$ = " (Red Flags)"
		filterFlagNo = 6
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagYellow" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagYellow")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagYellow"
		filterDesertedUsersByFlagLabel$ = " (Yellow Flags)"
		filterFlagNo = 7
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) = "FilterDesertedUsersFlagAll" or filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagAll")
		filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagAll"
		filterDesertedUsersByFlagLabel$ = ""
		filterFlagNo = 0
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsersByFlags) <> "")
		SaveLocalVariable("filterDesertedUsersByFlag", filterDesertedUsersByFlag$)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterDesertedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterDesertedUsers) or OryUIGetButtonReleased(btnTextFilteredDesertedUsersBy))
		local menuFilterDesertedUsersItemCount as integer
		local menuFilterDesertedUsersAllVisible as integer
		local menuFilterDesertedUsersAwaitingRatingVisible as integer
		local menuFilterDesertedUsersFavouritesVisible as integer
		local menuFilterDesertedUsersTestLocksVisible as integer
		local menuFilterDesertedUsersExcludeTestLocksVisible as integer
		menuFilterDesertedUsersAllVisible = 1
		menuFilterDesertedUsersAwaitingRatingVisible = 1
		menuFilterDesertedUsersFavouritesVisible = 1	
		menuFilterDesertedUsersTestLocksVisible = 0
		if (filterDesertedUsersExcludeTestLocks = 0) then menuFilterDesertedUsersTestLocksVisible = 1
		menuFilterDesertedUsersExcludeTestLocksVisible = 1
		menuFilterDesertedUsersItemCount = menuFilterDesertedUsersAllVisible + menuFilterDesertedUsersAwaitingRatingVisible + menuFilterDesertedUsersFavouritesVisible + menuFilterDesertedUsersTestLocksVisible + menuFilterDesertedUsersExcludeTestLocksVisible
		
		OryUISetMenuItemCount(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount)
		menuFilterDesertedUsersItemCount = 0
		if (menuFilterDesertedUsersAllVisible = 1)
			inc menuFilterDesertedUsersItemCount
			OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterDesertedUsersBy$ = "FilterDesertedUsersAll") then OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterDesertedUsersAwaitingRatingVisible = 1)
			inc menuFilterDesertedUsersItemCount
			OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersAwaitingRating;text:Pending Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterDesertedUsersBy$ = "FilterDesertedUsersAwaitingRating") then OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterDesertedUsersFavouritesVisible = 1)
			inc menuFilterDesertedUsersItemCount
			OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersFavourites;text:Favourites;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterDesertedUsersBy$ = "FilterDesertedUsersFavourites") then OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterDesertedUsersTestLocksVisible = 1)
			inc menuFilterDesertedUsersItemCount
			OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersTestLocks;text:Test Locks;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			if (filterDesertedUsersBy$ = "FilterDesertedUsersTestLocks") then OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "rightIconID:" + str(imgTickIcon))
		endif
		if (menuFilterDesertedUsersExcludeTestLocksVisible = 1)
			inc menuFilterDesertedUsersItemCount
			if (filterDesertedUsersExcludeTestLocks = 0)
				OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxUncheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateMenuItem(menuFilterDesertedUsers, menuFilterDesertedUsersItemCount, "name:FilterDesertedUsersExcludeTestLocks;text:Exclude Test Locks;colorID:" + str(colorMode[colorModeSelected].barColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(oryUICheckboxCheckedImage) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		OryUIShowMenu(menuFilterDesertedUsers, OryUIGetButtonX(btnIconFilterDesertedUsers), OryUIGetButtonY(btnIconFilterDesertedUsers) + OryUIGetButtonHeight(btnIconFilterDesertedUsers))		
	
	endif
	OryUIInsertMenuListener(menuFilterDesertedUsers)
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) = "FilterDesertedUsersAll" or filterDesertedUsersBy$ = "FilterDesertedUsersAll")
		filterDesertedUsersBy$ = "FilterDesertedUsersAll"
		filterDesertedUsersByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) = "FilterDesertedUsersAwaitingRating" or filterDesertedUsersBy$ = "FilterDesertedUsersAwaitingRating")
		filterDesertedUsersBy$ = "FilterDesertedUsersAwaitingRating"
		filterDesertedUsersByLabel$ = "Pending Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) = "FilterDesertedUsersFavourites" or filterDesertedUsersBy$ = "FilterDesertedUsersFavourites")
		filterDesertedUsersBy$ = "FilterDesertedUsersFavourites"
		filterDesertedUsersByLabel$ = "Favourites"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) = "FilterDesertedUsersTestLocks" or filterDesertedUsersBy$ = "FilterDesertedUsersTestLocks")
		filterDesertedUsersBy$ = "FilterDesertedUsersTestLocks"
		filterDesertedUsersByLabel$ = "Test Locks"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) = "FilterDesertedUsersExcludeTestLocks")
		if (filterDesertedUsersExcludeTestLocks = 0)
			filterDesertedUsersExcludeTestLocks = 1
			if (filterDesertedUsersBy$ = "FilterDesertedUsersTestLocks")
				filterDesertedUsersBy$ = "FilterDesertedUsersAll"
				filterDesertedUsersByLabel$ = "All"
			endif
		else
			filterDesertedUsersExcludeTestLocks = 0
		endif
		SaveLocalVariable("filterDesertedUsersExcludeTestLocks", str(filterDesertedUsersExcludeTestLocks))
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterDesertedUsers) <> "")
		SaveLocalVariable("filterDesertedUsersBy", filterDesertedUsersBy$)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortDesertedUsers, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortDesertedUsers) or OryUIGetButtonReleased(btnTextSortedDesertedUsersBy))
		OryUISetMenuItemCount(menuSortDesertedUsers, 5)
		OryUIUpdateMenuItem(menuSortDesertedUsers, 1, "name:SortDesertedUsersByDateDeleted;text:Date Deleted;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortDesertedUsers, 2, "name:SortDesertedUsersByDurationLocked;text:Duration Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortDesertedUsers, 3, "name:SortDesertedUsersByUsername;text:Username;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortDesertedUsers, 4, "name:SortDesertedUsersByUserRating;text:User Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortDesertedUsers, 5, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted") then OryUIUpdateMenuItem(menuSortDesertedUsers, 1, "rightIconID:" + str(imgTickIcon))
		if (sortDesertedUsersBy$ = "SortDesertedUsersByDurationLocked") then OryUIUpdateMenuItem(menuSortDesertedUsers, 2, "rightIconID:" + str(imgTickIcon))
		if (sortDesertedUsersBy$ = "SortDesertedUsersByUsername") then OryUIUpdateMenuItem(menuSortDesertedUsers, 3, "rightIconID:" + str(imgTickIcon))
		if (sortDesertedUsersBy$ = "SortDesertedUsersByUserRating") then OryUIUpdateMenuItem(menuSortDesertedUsers, 4, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortDesertedUsers, OryUIGetButtonX(btnIconSortDesertedUsers), OryUIGetButtonY(btnIconSortDesertedUsers) + OryUIGetButtonHeight(btnIconSortDesertedUsers))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortDesertedUsers, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortDesertedUsers)
	OryUIInsertMenuListener(menuSortDesertedUsers)
	if (OryUIGetMenuVisible(menuSortDesertedUsers) and sortDesertedUsersBy$ <> "SortDesertedUsersByRandom")
		OryUIUpdateButtonGroup(grpSortDesertedUsers, "position:" + str(OryUIGetMenuX(menuSortDesertedUsers)) + "," + str(OryUIGetMenuY(menuSortDesertedUsers) + OryUIGetMenuHeight(menuSortDesertedUsers) - OryUIGetButtonGroupHeight(grpSortDesertedUsers)))
	else
		OryUIUpdateButtonGroup(grpSortDesertedUsers, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortDesertedUsers) = "SortDesertedUsersByDateDeleted" or sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted")
		sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted"
		sortDesertedUsersByLabel$ = "Date Deleted"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortDesertedUsers) = "SortDesertedUsersByDurationLocked" or sortDesertedUsersBy$ = "SortDesertedUsersByDurationLocked")
		sortDesertedUsersBy$ = "SortDesertedUsersByDurationLocked"
		sortDesertedUsersByLabel$ = "Duration Locked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortDesertedUsers) = "SortDesertedUsersByUsername" or sortDesertedUsersBy$ = "SortDesertedUsersByUsername")
		sortDesertedUsersBy$ = "SortDesertedUsersByUsername"
		sortDesertedUsersByLabel$ = "Username"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortDesertedUsers) = "SortDesertedUsersByUserRating" or sortDesertedUsersBy$ = "SortDesertedUsersByUserRating")
		sortDesertedUsersBy$ = "SortDesertedUsersByUserRating"
		sortDesertedUsersByLabel$ = "User Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortDesertedUsers) <> "")
		SaveLocalVariable("sortDesertedUsersBy", sortDesertedUsersBy$)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortDesertedUsers, "ASC"))
		sortDesertedUsersOrder$ = "ASC"
		SaveLocalVariable("sortDesertedUsersOrder", sortDesertedUsersOrder$)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortDesertedUsers, "DESC"))
		sortDesertedUsersOrder$ = "DESC"
		SaveLocalVariable("sortDesertedUsersOrder", sortDesertedUsersOrder$)
		SetScreenToView(constManageDesertedUsersScreen)
	endif
	
	// DESERTED USERS LOCKS SEARCH BAR
	if (sharedLocks[sharedLockSelected, 0].desertedUsers > 0 or OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprDesertedUsersSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editDesertedUsersSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editDesertedUsersSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editDesertedUsersSearch))
			OryUISetTextfieldString(editDesertedUsersSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editDesertedUsersSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editDesertedUsersSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editDesertedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editDesertedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editDesertedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editDesertedUsersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editDesertedUsersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editDesertedUsersSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		if (sharedLocksSearchString$ <> OryUIGetTextfieldString(editDesertedUsersSearch))
			sharedLocksSearchString$ = ""
		endif
		elementY# = elementY# + GetSpriteHeight(sprDesertedUsersSearchBar) + 2
	else
		OryUIUpdateSprite(sprDesertedUsersSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editDesertedUsersSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	startScrollBarY# = elementY# - 1

	// SORT DESERTED USERS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editDesertedUsersSearch)) <> lastDesertedUsersSearchLength)
		lastDesertedUsersSearchLength = len(OryUIGetTextFieldString(editDesertedUsersSearch))
		SortDesertedUsers(OryUIGetTextfieldString(editDesertedUsersSearch))
		redrawScreen = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO DESERTED USERS
	if (sharedLocks[sharedLockSelected, 0].desertedUsers = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData))
			OryUIUpdateText(txtNoDesertedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoDesertedUsers, "text:No Deserted Users;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	elseif (filterCount = 0)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData))
			OryUIUpdateText(txtNoDesertedUsers, "text:Loading Data...;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			if (filterDesertedUsersExcludeTestLocks = 0)
				OryUIUpdateText(txtNoDesertedUsers, "text:No Deserted Users Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateText(txtNoDesertedUsers, "text:No Deserted Users Matching Filter" + chr(10) + "Excluding Test Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
	else
		OryUIUpdateText(txtNoDesertedUsers, "position:-1000,-1000")
	endif
	
	// DESERTED USERS
	if (redrawScreen = 1)
		for i = 1 to 8
			DestroyItemsInDesertedUsersCard(i)
			CreateItemsInDesertedUsersCard(i)
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

				UpdateItemsInDesertedUsersCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(userCard[i].dialog)
					
					if (OryUIGetSwipingVertically() = 0)
						
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
								UpdateItemsInDesertedUsersCard(i, sortedIteration, 1)
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
							if (filterDesertedUsersBy$ = "FilterDesertedUsersFavourites")
								screen[screenNo].lastViewY# = GetViewOffsetY()
								SetScreenToView(constManageDesertedUsersScreen)
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
							
							if (filterDesertedUsersByFlag$ <> "FilterDesertedUsersFlagAll" and flagChosen <> filterFlagNo)
								screen[screenNo].lastViewY# = GetViewOffsetY()
								SetScreenToView(constManageDesertedUsersScreen)
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
