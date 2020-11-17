
OryUIHideFloatingActionButton(fabAddMyLock)
if (screenToView = constMyLocksScreen)
	if (screenNo <> constMyLocksScreen)
		filterMyLocksByFlagLabel$ as string : filterMyLocksByFlagLabel$ = ""
		filterMyLocksByLabel$ as string : filterMyLocksByLabel$ = ""
		lastMyLocksSearchLength as integer : lastMyLocksSearchLength = 0
		OryUIUpdateTextfield(editMyLocksSearch, "inputText:;")
		sortMyLocksByLabel$ as string : sortMyLocksByLabel$ = ""
	endif
	screenNo = constMyLocksScreen
	selectedLocksTab = 1
	SetLastScreenViewed(screenNo)

	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	if (OryUIGetNavigationDrawerVisible(navigationDrawer) = 0)
		OryUIInsertScrollBarListener(scrollBar)
	else
		OryUIHideScrollBar(scrollBar)
	endif
	
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
		if (statusSelected = 1) then OryUIUpdateSprite(sprMyLocksStatusIcon, "image:" + str(imgStatusAvailableIcon))
		if (statusSelected = 2) then OryUIUpdateSprite(sprMyLocksStatusIcon, "image:" + str(imgStatusBusyIcon))
		if (statusSelected = 3) then OryUIUpdateSprite(sprMyLocksStatusIcon, "image:" + str(imgStatusSleepingIcon))
		if (statusSelected = 4) then OryUIUpdateSprite(sprMyLocksStatusIcon, "image:" + str(imgStatusOfflineIcon))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	OryUIPinSpriteToBottomRightOfSprite(sprMyLocksStatusIcon, OryUITopBarCollection[screen[screenNo].topBar].actions[0].sprIcon, -((GetSpriteWidth(sprMyLocksStatusIcon) * 0.8) / 2), -((GetSpriteHeight(sprMyLocksStatusIcon) * 0.8) / 2))
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "menu")
		OryUIShowNavigationDrawer(navigationDrawer)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "profile")
		GetProfileData(userDBRow, 1)
		SetScreenToView(constViewProfileScreen)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		if (offline = 1 or maintenance = 1 or timestampNow <= 1500000000) then GetServerVariables(1)
		GetAccountData(0)
		GetLocksData()
		if (noOfLocks > 0)
			GetKeyholdersData(0)
			GetLockUpdates(1)
		endif
	endif
	if (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1)
		if (OryUIGetNavigationDrawerVisible(navigationDrawer))
			OryUIHideNavigationDrawer(navigationDrawer)
		else
			if (oryUIScrimVisible = 0)
				previousBreadcrumb = GetPreviousBreadcrumb()
				RemoveLastBreadcrumb()
				SetScreenToView(previousBreadcrumb)
			endif
		endif
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
		
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		SaveLocalVariable("selectedLocksTab", "2")
		SetScreenToView(constSharedLocksScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterMyLocksBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterMyLocksByFlags, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnIconFilterMyLocks, "position:" + str(OryUIGetButtonX(btnIconFilterMyLocksByFlags) + OryUIGetButtonWidth(btnIconFilterMyLocksByFlags) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredMyLocksBy, "text:" + filterMyLocksByLabel$ + filterMyLocksByFlagLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterMyLocks) + OryUIGetButtonWidth(btnIconFilterMyLocks)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)))
	OryUIUpdateButton(btnIconSortMyLocks, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortMyLocks)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextSortedMyLocksBy, "text:" + sortMyLocksByLabel$ + " (" + sortMyLocksOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortMyLocks) - OryUIGetButtonWidth(btnTextSortedMyLocksBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)))
	OryUIUpdateSprite(sprFilterMyLocksBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterMyLocksBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterMyLocksBar) //+ 2
	
	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (oryUIScrimVisible = 0)
		if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
			if (offline = 1 or maintenance = 1 or timestampNow <= 1500000000) then GetServerVariables(1)
			GetAccountData(0)
			GetLocksData()
			if (noOfLocks > 0)
				GetKeyholdersData(0)
				GetLockUpdates(1)
			endif
		endif
	endif
	
	// FILTER MENUS
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterMyLocksByFlags, "coloriD:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlack") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[1]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlue") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[2]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagGreen") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[3]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagOrange") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[4]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagPurple") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[5]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagRed") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[6]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagYellow") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[7]) + ";color:255,255,255,255")
	if (filterMyLocksByFlag$ = "FilterMyLocksFlagAll") then OryUIUpdateButton(btnIconFilterMyLocksByFlags, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	if (OryUIGetButtonReleased(btnIconFilterMyLocksByFlags))
		OryUISetMenuItemCount(menuFilterMyLocksByFlags, 8)
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 1, "name:FilterMyLocksFlagBlack;text: ;lefticonID:" + str(imgFlags[1]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 2, "name:FilterMyLocksFlagBlue;text: ;lefticonID:" + str(imgFlags[2]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 3, "name:FilterMyLocksFlagGreen;text: ;lefticonID:" + str(imgFlags[3]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 4, "name:FilterMyLocksFlagOrange;text: ;lefticonID:" + str(imgFlags[4]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 5, "name:FilterMyLocksFlagPurple;text: ;lefticonID:" + str(imgFlags[5]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 6, "name:FilterMyLocksFlagRed;text: ;lefticonID:" + str(imgFlags[6]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 7, "name:FilterMyLocksFlagYellow;text: ;lefticonID:" + str(imgFlags[7]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 8, "name:FilterMyLocksFlagAll;text: ;lefticonID:" + str(imgFlags[9]) + ";leftIconColor:255,255,255,255;colorID:" + str(colorMode[colorModeSelected].menuColor))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlack") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 1, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlue") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 2, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagGreen") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 3, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagOrange") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 4, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagPurple") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 5, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagRed") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 6, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksByFlag$ = "FilterMyLocksFlagYellow") then OryUIUpdateMenuItem(menuFilterMyLocksByFlags, 7, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterMyLocksByFlags, OryUIGetButtonX(btnIconFilterMyLocksByFlags), OryUIGetButtonY(btnIconFilterMyLocksByFlags) + OryUIGetButtonHeight(btnIconFilterMyLocksByFlags))
	endif
	OryUIInsertMenuListener(menuFilterMyLocksByFlags)
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagBlack" or filterMyLocksByFlag$ = "FilterMyLocksFlagBlack")
		filterMyLocksByFlag$ = "FilterMyLocksFlagBlack"
		filterMyLocksByFlagLabel$ = " (Black Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagBlue" or filterMyLocksByFlag$ = "FilterMyLocksFlagBlue")
		filterMyLocksByFlag$ = "FilterMyLocksFlagBlue"
		filterMyLocksByFlagLabel$ = " (Blue Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagGreen" or filterMyLocksByFlag$ = "FilterMyLocksFlagGreen")
		filterMyLocksByFlag$ = "FilterMyLocksFlagGreen"
		filterMyLocksByFlagLabel$ = " (Green Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagOrange" or filterMyLocksByFlag$ = "FilterMyLocksFlagOrange")
		filterMyLocksByFlag$ = "FilterMyLocksFlagOrange"
		filterMyLocksByFlagLabel$ = " (Orange Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagPurple" or filterMyLocksByFlag$ = "FilterMyLocksFlagPurple")
		filterMyLocksByFlag$ = "FilterMyLocksFlagPurple"
		filterMyLocksByFlagLabel$ = " (Purple Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagRed" or filterMyLocksByFlag$ = "FilterMyLocksFlagRed")
		filterMyLocksByFlag$ = "FilterMyLocksFlagRed"
		filterMyLocksByFlagLabel$ = " (Red Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagYellow" or filterMyLocksByFlag$ = "FilterMyLocksFlagYellow")
		filterMyLocksByFlag$ = "FilterMyLocksFlagYellow"
		filterMyLocksByFlagLabel$ = " (Yellow Flags)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) = "FilterMyLocksFlagAll" or filterMyLocksByFlag$ = "FilterMyLocksFlagAll")
		filterMyLocksByFlag$ = "FilterMyLocksFlagAll"
		filterMyLocksByFlagLabel$ = ""
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocksByFlags) <> "")
		SaveLocalVariable("filterMyLocksByFlag", filterMyLocksByFlag$)
		SetScreenToView(constMyLocksScreen)
	endif
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterMyLocks, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterMyLocks) or OryUIGetButtonReleased(btnTextFilteredMyLocksBy))
		OryUISetMenuItemCount(menuFilterMyLocks, 7)
		OryUIUpdateMenuItem(menuFilterMyLocks, 1, "name:FilterMyLocksAll;text:All;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 2, "name:FilterMyLocksFixed;text:Fixed;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 3, "name:FilterMyLocksVariable;text:Variable;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 4, "name:FilterMyLocksActive;text:Active;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 5, "name:FilterMyLocksReadyToPick;text:Ready to pick;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 6, "name:FilterMyLocksReadyToUnlock;text:Ready to unlock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterMyLocks, 7, "name:FilterMyLocksUnlocked;text:Unlocked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		if (filterMyLocksBy$ = "FilterMyLocksAll") then OryUIUpdateMenuItem(menuFilterMyLocks, 1, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksFixed") then OryUIUpdateMenuItem(menuFilterMyLocks, 2, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksVariable") then OryUIUpdateMenuItem(menuFilterMyLocks, 3, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksActive") then OryUIUpdateMenuItem(menuFilterMyLocks, 4, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksReadyToPick") then OryUIUpdateMenuItem(menuFilterMyLocks, 5, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksReadyToUnlock") then OryUIUpdateMenuItem(menuFilterMyLocks, 6, "rightIconID:" + str(imgTickIcon))
		if (filterMyLocksBy$ = "FilterMyLocksUnlocked") then OryUIUpdateMenuItem(menuFilterMyLocks, 7, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterMyLocks, OryUIGetButtonX(btnIconFilterMyLocks), OryUIGetButtonY(btnIconFilterMyLocks) + OryUIGetButtonHeight(btnIconFilterMyLocks))
	endif
	OryUIInsertMenuListener(menuFilterMyLocks)
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksAll" or filterMyLocksBy$ = "FilterMyLocksAll")
		filterMyLocksBy$ = "FilterMyLocksAll"
		filterMyLocksByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksFixed" or filterMyLocksBy$ = "FilterMyLocksFixed")
		filterMyLocksBy$ = "FilterMyLocksFixed"
		filterMyLocksByLabel$ = "Fixed"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksVariable" or filterMyLocksBy$ = "FilterMyLocksVariable")
		filterMyLocksBy$ = "FilterMyLocksVariable"
		filterMyLocksByLabel$ = "Variable"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksActive" or filterMyLocksBy$ = "FilterMyLocksActive")
		filterMyLocksBy$ = "FilterMyLocksActive"
		filterMyLocksByLabel$ = "Active"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksReadyToPick" or filterMyLocksBy$ = "FilterMyLocksReadyToPick")
		filterMyLocksBy$ = "FilterMyLocksReadyToPick"
		filterMyLocksByLabel$ = "Ready to pick"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksReadyToUnlock" or filterMyLocksBy$ = "FilterMyLocksReadyToUnlock")
		filterMyLocksBy$ = "FilterMyLocksReadyToUnlock"
		filterMyLocksByLabel$ = "Ready to unlock"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) = "FilterMyLocksUnlocked" or filterMyLocksBy$ = "FilterMyLocksUnlocked")
		filterMyLocksBy$ = "FilterMyLocksUnlocked"
		filterMyLocksByLabel$ = "Unlocked"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterMyLocks) <> "")
		SaveLocalVariable("filterMyLocksBy", filterMyLocksBy$)
		SetScreenToView(constMyLocksScreen)
	endif
	
	// SORT MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortMyLocks, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortMyLocks) or OryUIGetButtonReleased(btnTextSortedMyLocksBy))
		OryUISetMenuItemCount(menuSortMyLocks, 4)
		OryUIUpdateMenuItem(menuSortMyLocks, 1, "name:SortMyLocksByCreated;text:Created;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortMyLocks, 2, "name:SortMyLocksByDuration;text:Duration;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortMyLocks, 3, "name:SortMyLocksByTimeLeft;text:Time Left;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortMyLocks, 4, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortMyLocksBy$ = "SortMyLocksByCreated") then OryUIUpdateMenuItem(menuSortMyLocks, 1, "rightIconID:" + str(imgTickIcon))
		if (sortMyLocksBy$ = "SortMyLocksByDuration") then OryUIUpdateMenuItem(menuSortMyLocks, 2, "rightIconID:" + str(imgTickIcon))
		if (sortMyLocksBy$ = "SortMyLocksByTimeLeft") then OryUIUpdateMenuItem(menuSortMyLocks, 3, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortMyLocks, OryUIGetButtonX(btnIconSortMyLocks), OryUIGetButtonY(btnIconSortMyLocks) + OryUIGetButtonHeight(btnIconSortMyLocks))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortMyLocks, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortMyLocks)
	OryUIInsertMenuListener(menuSortMyLocks)
	if (OryUIGetMenuVisible(menuSortMyLocks))
		OryUIUpdateButtonGroup(grpSortMyLocks, "position:" + str(OryUIGetMenuX(menuSortMyLocks)) + "," + str(OryUIGetMenuY(menuSortMyLocks) + OryUIGetMenuHeight(menuSortMyLocks) - OryUIGetButtonGroupHeight(grpSortMyLocks)))
	else
		OryUIUpdateButtonGroup(grpSortMyLocks, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortMyLocks) = "SortMyLocksByCreated" or sortMyLocksBy$ = "SortMyLocksByCreated")
		sortMyLocksBy$ = "SortMyLocksByCreated"
		sortMyLocksByLabel$ = "Created"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortMyLocks) = "SortMyLocksByDuration" or sortMyLocksBy$ = "SortMyLocksByDuration")
		sortMyLocksBy$ = "SortMyLocksByDuration"
		sortMyLocksByLabel$ = "Duration"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortMyLocks) = "SortMyLocksByTimeLeft" or sortMyLocksBy$ = "SortMyLocksByTimeLeft")
		sortMyLocksBy$ = "SortMyLocksByTimeLeft"
		sortMyLocksByLabel$ = "Time Left"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortMyLocks) <> "")
		SaveLocalVariable("sortMyLocksBy", sortMyLocksBy$)
		SetScreenToView(constMyLocksScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortMyLocks, "ASC"))
		sortMyLocksOrder$ = "ASC"
		SaveLocalVariable("sortMyLocksOrder", sortMyLocksOrder$)
		SetScreenToView(constMyLocksScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortMyLocks, "DESC"))
		sortMyLocksOrder$ = "DESC"
		SaveLocalVariable("sortMyLocksOrder", sortMyLocksOrder$)
		SetScreenToView(constMyLocksScreen)
	endif
	
	// MY LOCKS SEARCH BAR
	if (noOfLocks > 0)
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprMyLocksSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editMyLocksSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editMyLocksSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editMyLocksSearch))
			OryUISetTextfieldString(editMyLocksSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editMyLocksSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editMyLocksSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editMyLocksSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editMyLocksSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editMyLocksSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editMyLocksSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editMyLocksSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editMyLocksSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		elementY# = elementY# + GetSpriteHeight(sprMyLocksSearchBar) + 2
	else
		OryUIUpdateSprite(sprMyLocksSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editMyLocksSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	// SORT MY LOCKS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editMyLocksSearch)) <> lastMyLocksSearchLength)
		lastMyLocksSearchLength = len(OryUIGetTextFieldString(editMyLocksSearch))
		SortMyLocks(OryUIGetTextfieldString(editMyLocksSearch))
		redrawScreen = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif

	// NO LOCKS
	if (noOfLocks = 0)
		if (disableCreationOfNewLocks = 0)
			OryUIUpdateText(txtNoMyLocks, "text:No Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtPressPlusToCreateMyLock, "text:Press + below to create new locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoMyLocks, "text:No Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtPressPlusToCreateMyLock, "text:Creation of new locks have been disabled." + chr(10) + "Check the Discord server or forums for news.;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	elseif (filterCount = 0)
		OryUIUpdateText(txtNoMyLocks, "text:No Locks Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtPressPlusToCreateMyLock, "position:-1000,-1000")
	else
		OryUIUpdateText(txtNoMyLocks, "position:-1000,-1000")
		OryUIUpdateText(txtPressPlusToCreateMyLock, "position:-1000,-1000")
	endif

	// LOCKS
	if (redrawScreen = 1)
		for i = 1 to 5
			DestroyItemsInMyLockCard(i)
			CreateItemsInMyLockCard(i)
		next
	endif
	if (filterCount > 0)
		fullCardHeight# = GetSpriteHeight(lockCard[1].sprBackground) + GetSpriteHeight(lockCard[1].sprButtonBar) + 2.0
		for i = 1 to 5
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(lockCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					OryUIUpdateSprite(lockCard[i].sprOverlay, "position:" + str(screenNo * 100) + "," + str(GetSpriteY(lockCard[i].sprBackground) + 3) + ";alpha:0")
					elementY# = elementY# + GetSpriteHeight(lockCard[i].sprBackground)
					OryUIUpdateSprite(lockCard[i].sprButtonBar, "position:" + str(screenNo * 100) + "," + str(GetSpriteY(lockCard[i].sprBackground) + GetSpriteHeight(lockCard[i].sprBackground)) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
					elementY# = elementY# + GetSpriteHeight(lockCard[i].sprButtonBar) + 2
					lockCard[i].iteration = i
				endif
				if (GetSpriteY(lockCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and lockCard[i].iteration + 5 <= filterCount)
					lockCard[i].iteration = lockCard[i].iteration + 5
					OryUIUpdateSprite(lockCard[i].sprBackground, "y:" + str(GetSpriteY(lockCard[i].sprBackground) + (fullCardHeight# * 5)))
					OryUIUpdateSprite(lockCard[i].sprOverlay, "y:" + str(GetSpriteY(lockCard[i].sprBackground) + 3))
					OryUIUpdateSprite(lockCard[i].sprButtonBar, "y:" + str(GetSpriteY(lockCard[i].sprBackground) + GetSpriteHeight(lockCard[i].sprBackground)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(lockCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 5) and lockCard[i].iteration - 5 >= 1)
					lockCard[i].iteration = lockCard[i].iteration - 5
					OryUIUpdateSprite(lockCard[i].sprBackground, "y:" + str(GetSpriteY(lockCard[i].sprBackground) - (fullCardHeight# * 5)))
					OryUIUpdateSprite(lockCard[i].sprOverlay, "y:" + str(GetSpriteY(lockCard[i].sprBackground) + 3))
					OryUIUpdateSprite(lockCard[i].sprButtonBar, "y:" + str(GetSpriteY(lockCard[i].sprBackground) + GetSpriteHeight(lockCard[i].sprBackground)))
					repositionItemsInCard = 1
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = locksSorted[lockCard[i].iteration - 1].iteration

				if (GetSpriteInScreen(lockCard[i].sprBackground))
					lockInView = 1
				else
					lockInView = 0
				endif
			
				UpdateItemsInMyLockCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(screen[screenNo].dialog)
					OryUIInsertDialogListener(lockCard[i].dialog)
	
					if (OryUIGetSwipingVertically() = 0)
						
						if (OryUIGetSpriteReleased() = lockCard[i].sprOverlay)
							lockSelected = sortedIteration
							if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLastPicked + 60) - timestampNow
							if (locks[lockSelected].regularity# = 0.25) then secondsLeft = (locks[lockSelected].timestampLastPicked + 900) - timestampNow
							if (locks[lockSelected].regularity# = 0.5) then secondsLeft = (locks[lockSelected].timestampLastPicked + 1800) - timestampNow
							if (locks[lockSelected].regularity# = 1) then secondsLeft = (locks[lockSelected].timestampLastPicked + 3600) - timestampNow
							if (locks[lockSelected].regularity# = 3) then secondsLeft = (locks[lockSelected].timestampLastPicked + 10800) - timestampNow
							if (locks[lockSelected].regularity# = 6) then secondsLeft = (locks[lockSelected].timestampLastPicked + 21600) - timestampNow
							if (locks[lockSelected].regularity# = 12) then secondsLeft = (locks[lockSelected].timestampLastPicked + 43200) - timestampNow
							if (locks[lockSelected].regularity# = 24) then secondsLeft = (locks[lockSelected].timestampLastPicked + 86400) - timestampNow
							if (locks[lockSelected].readyToUnlock = 0)
								if (locks[lockSelected].deleting = 0 and locks[lockSelected].unlocked = 0 and locks[lockSelected].fixed = 0 and secondsLeft <= 0 and locks[lockSelected].lockFrozenByKeyholder = 0 and locks[lockSelected].lockFrozenByCard = 0)
									noOfCards = GetNoOfCards(lockSelected)
									if (locks[lockSelected].regularity# = 0.016667) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60)
									if (locks[lockSelected].regularity# = 0.25) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 15)
									if (locks[lockSelected].regularity# = 0.5) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 30)
									if (locks[lockSelected].regularity# = 1) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60)
									if (locks[lockSelected].regularity# = 3) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 3)
									if (locks[lockSelected].regularity# = 6) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 6)
									if (locks[lockSelected].regularity# = 12) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 12)
									if (locks[lockSelected].regularity# = 24) then noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 24)
									if (noOfChances >= noOfCards) then noOfChances = noOfCards
									if (locks[lockSelected].cumulative = 0 and noOfChances > 1) then noOfChances = 1
									cardsPageNo = 1
									screen[screenNo].lastViewY# = GetViewOffsetY()
									SetScreenToView(constCardsScreen)
								endif
							else
								maxWaitTime as integer : maxWaitTime = 0
								if (locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# <= 3) then maxWaitTime = 3600 * 3
								if (locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# >= 6) then maxWaitTime = 3600 * 6
								if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667 and (locks[lockSelected].botChosen > 0 or (locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))) then maxWaitTime = 3600 * 3
								if (maxWaitTime - (timestampNow - locks[lockSelected].timestampRequestedKeyholdersDecision) <= 0)
									revealCombinationVisible as integer : revealCombinationVisible = 1
									resetLockVisible as integer : resetLockVisible = 0
									surpriseMeVisible as integer : surpriseMeVisible = 0
									letKeyholderDecideVisible as integer : letKeyholderDecideVisible = 0
									putGreenBackVisible as integer : putGreenBackVisible = 1
									decideLaterVisible as integer : decideLaterVisible = 1
									if (locks[lockSelected].fixed = 0)
										resetLockVisible = 1
										surpriseMeVisible = 1
									endif
									if (locks[lockSelected].fixed = 1)
										putGreenBackVisible = 0
									endif
									if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667)
										resetLockVisible = 1
										surpriseMeVisible = 1
									endif
									if (locks[lockSelected].keyholderDecisionDisabled = 0 and (locks[lockSelected].fixed = 0 and (locks[lockSelected].keyholderBuildNumberInstalled >= 115 or locks[lockSelected].botChosen > 0) and locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))
										letKeyholderDecideVisible = 1
									endif
									if (locks[lockSelected].keyholderDecisionDisabled = 0 and (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667 and (locks[lockSelected].botChosen > 0 or (locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))))
										letKeyholderDecideVisible = 1
									endif
									totalDialogButtons as integer : totalDialogButtons = revealCombinationVisible + resetLockVisible + surpriseMeVisible + letKeyholderDecideVisible + putGreenBackVisible + decideLaterVisible
									if (resetLockVisible = 1)
										OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									else
										OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Would you like to reveal the combination?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									endif
									OryUISetDialogButtonCount(lockCard[i].dialog, totalDialogButtons)
									dialogButtonCount as integer : dialogButtonCount = 0
									if (revealCombinationVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (resetLockVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (surpriseMeVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (letKeyholderDecideVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:LetKeyholderDecide;text:Let Keyholder Decide;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (putGreenBackVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (decideLaterVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									OryUIShowDialog(lockCard[i].dialog)
								endif
							endif
						endif
	
						// COPY COMBINATION
						if (locks[sortedIteration].unlocked = 1)
							if (GetTextHitTest(lockCard[i].txtCombination, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) and oryUIScrimVisible = 0)
								OryUIUpdateButton(btnCopyText, "position:" + str((screenNo * 100) + 50) + "," + str(GetTextY(lockCard[i].txtCombination) - 2))
								timeShownBtnCopyText# = timer()
								stringForCopyButton$ = GetTextString(lockCard[i].txtCombination)
							endif
							if (OryUIGetButtonReleased(btnCopyText))
								SetClipboardText(stringForCopyButton$)
								OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
								OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
								OryUIShowTooltip(tooltip, (screenNo * 100) + 50, GetViewOffsetY() + screenBoundsTop# + 80)
							elseif (OryUIGetSpriteReleased() = screen[screenNo].sprPage)
								OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
							endif
						endif
	
						// VIEW KEYHOLDER PROFILE
						if (OryUIGetSpriteReleased() = lockCard[i].sprUsernameButton)
							lockSelected = sortedIteration
							GetProfileData(locks[lockSelected].keyholderID, 1)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constViewProfileScreen)
						endif
							
						// DELETE BUTTON
						if (OryUIGetSpriteReleased() = lockCard[i].sprDeleteButton or OryUIGetSpriteReleased() = lockCard[i].sprDeleteIcon)
							lockSelected = sortedIteration
							if (locks[lockSelected].unlocked = 0)
								if (enableLockDeletions = 1)
									OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Delete Active Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to delete the lock before it has finished?" + chr(10) + chr(10) + "This will delete the lock and the combination with it. It can't be undone and the combination can't be retreived once deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockCard[i].dialog, 2)
									OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteLock;text:Delete Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockCard[i].dialog)
								else
									OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Deletion of Locks Disabled;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:If you want to delete this lock, you will need to enable deletion of active locks on the settings page. You can disable it again afterwards if needed.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockCard[i].dialog, 1)
									OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockCard[i].dialog)
								endif
							else
								OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Delete Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This will delete the lock and the combination with it. It can't be undone and the combination can't be retreived once deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(lockCard[i].dialog, 2)
								OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteLock;text:Delete Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(lockCard[i].dialog)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "DeleteLock"))
							lockSelected = sortedIteration
							DeleteLock(lockSelected, 0)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif

						// UNLOCK BUTTON
						if (OryUIGetSpriteReleased() = lockCard[i].sprUnlockButton or OryUIGetSpriteReleased() = lockCard[i].sprUnlockIcon)
							lockSelected = sortedIteration
							if (locks[lockSelected].unlocked = 0)
								maxWaitTime = 0
								if (locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# <= 3) then maxWaitTime = 3600 * 3
								if (locks[lockSelected].fixed = 0 and locks[lockSelected].regularity# >= 6) then maxWaitTime = 3600 * 6
								if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667 and (locks[lockSelected].botChosen > 0 or (locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))) then maxWaitTime = 3600 * 3
								if (locks[lockSelected].readyToUnlock = 0 or (locks[lockSelected].readyToUnlock = 1 and maxWaitTime - (timestampNow - locks[lockSelected].timestampRequestedKeyholdersDecision) > 0))
									if (locks[lockSelected].timestampHiddenFromOwner >= locks[lockSelected].timestampLocked and locks[lockSelected].hiddenFromOwnerAlertHidden = 0)
										if (locks[lockSelected].keyDisabled = 1 or locks[lockSelected].keyholderDisabledKey = 1)
											OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock For Free?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The keyholder no longer manages this lock so you can unlock for free if you want." + chr(10) + chr(10) + "If you choose 'No' the key(s) will be enabled but they will need to be purchased to unlock early. You can also decide later if you want to wait." + chr(10) + chr(10) + "The free unlock option will disappear if the keyholder restores the deleted lock. It may have been deleted by mistake.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										else
											OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock For Free?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The keyholder no longer manages this lock so you can unlock for free if you want." + chr(10) + chr(10) + "If you choose 'No' the key(s) will need to be purchased to unlock early. You can also decide later if you want to wait." + chr(10) + chr(10) + "The free unlock option will disappear if the keyholder restores the deleted lock. It may have been deleted by mistake.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										endif	
										OryUISetDialogButtonCount(lockCard[i].dialog, 3)
										OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:FreeUnlock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:NoFreeUnlock;text:No;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(lockCard[i].dialog)
									elseif (locks[lockSelected].timestampRemovedByKeyholder >= locks[lockSelected].timestampLocked and locks[lockSelected].removedByKeyholderAlertHidden = 0)
										if (locks[lockSelected].keyDisabled = 1 or locks[lockSelected].keyholderDisabledKey = 1)
											OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock For Free?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The keyholder no longer manages this lock so you can unlock for free if you want." + chr(10) + chr(10) + "If you choose 'No' the key(s) will be enabled but they will need to be purchased to unlock early. You can also decide later if you want to wait.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										else
											OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock For Free?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The keyholder no longer manages this lock so you can unlock for free if you want." + chr(10) + chr(10) + "If you choose 'No' the key(s) will need to be purchased to unlock early. You can also decide later if you want to wait.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
										endif	
										OryUISetDialogButtonCount(lockCard[i].dialog, 3)
										OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:FreeUnlock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:NoFreeUnlock;text:No;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(lockCard[i].dialog)
									else
										if (locks[lockSelected].keyDisabled = 0)
											if (locks[lockSelected].noOfKeysRequired <= 1)
												if (noOfKeys = 0)
													OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You will need to purchase a key to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
													OryUISetDialogButtonCount(lockCard[i].dialog, 4)
													OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy1Key;text:Buy 1 Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy2Keys;text:Buy 2 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy5Keys;text:Buy 5 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIUpdateDialogButton(lockCard[i].dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIShowDialog(lockCard[i].dialog)
												else
													OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This will require one of your keys to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
													OryUISetDialogButtonCount(lockCard[i].dialog, 2)
													OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:UseKey;text:Use Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIShowDialog(lockCard[i].dialog)
												endif
											else
												if (noOfKeys < locks[lockSelected].noOfKeysRequired)
													if (locks[lockSelected].noOfKeysRequired - noOfKeys = 1)
														OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock requires " + str(locks[lockSelected].noOfKeysRequired) + " key(s) to unlock and you have " + str(noOfKeys) + " key(s). You will need to purchase 1 extra key to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
													else
														if (noOfKeys > 0)
															OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock requires " + str(locks[lockSelected].noOfKeysRequired) + " key(s) to unlock and you have " + str(noOfKeys) + " key(s). You will need to purchase " + str(locks[lockSelected].noOfKeysRequired - noOfKeys) + " extra key(s) to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
														else
															OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock requires " + str(locks[lockSelected].noOfKeysRequired) + " key(s) to unlock and you have " + str(noOfKeys) + " key(s). You will need to purchase " + str(locks[lockSelected].noOfKeysRequired - noOfKeys) + " key(s) to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
														endif
													endif
													if (locks[lockSelected].noOfKeysRequired - noOfKeys > 25)
														OryUISetDialogButtonCount(lockCard[i].dialog, 7)
														OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy1Key;text:Buy 1 Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy2Keys;text:Buy 2 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy5Keys;text:Buy 5 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy10Keys;text:Buy 10 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 5, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy25Keys;text:Buy 25 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 6, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy50Keys;text:Buy 50 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 7, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													elseif (locks[lockSelected].noOfKeysRequired - noOfKeys > 10)
														OryUISetDialogButtonCount(lockCard[i].dialog, 6)
														OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy1Key;text:Buy 1 Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy2Keys;text:Buy 2 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy5Keys;text:Buy 5 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy10Keys;text:Buy 10 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 5, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy25Keys;text:Buy 25 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 6, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													elseif (locks[lockSelected].noOfKeysRequired - noOfKeys > 5)
														OryUISetDialogButtonCount(lockCard[i].dialog, 5)
														OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy1Key;text:Buy 1 Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy2Keys;text:Buy 2 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy5Keys;text:Buy 5 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy10Keys;text:Buy 10 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 5, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													else
														OryUISetDialogButtonCount(lockCard[i].dialog, 4)
														OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy1Key;text:Buy 1 Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy2Keys;text:Buy 2 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Buy5Keys;text:Buy 5 Keys;textColorID:" + str(colorMode[colorModeSelected].textColor))
														OryUIUpdateDialogButton(lockCard[i].dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													endif
													OryUIShowDialog(lockCard[i].dialog)
												else
													OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Unlock Early?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This will require " + str(locks[i].noOfKeysRequired) + " of your keys to unlock early.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
													OryUISetDialogButtonCount(lockCard[i].dialog, 2)
													OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:UseKey;text:Use Key;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
													OryUIShowDialog(lockCard[i].dialog)
												endif
											endif
										endif
									endif
								else
									revealCombinationVisible = 1
									resetLockVisible = 0
									surpriseMeVisible = 0
									letKeyholderDecideVisible = 0
									putGreenBackVisible = 0
									decideLaterVisible = 1
									if (locks[lockSelected].fixed = 0)
										resetLockVisible = 1
										surpriseMeVisible = 1
									endif
									if (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667)
										resetLockVisible = 1
										surpriseMeVisible = 1
									endif
									if (locks[lockSelected].keyholderDecisionDisabled = 0 and (locks[lockSelected].fixed = 0 and (locks[lockSelected].keyholderBuildNumberInstalled >= 115 or locks[lockSelected].botChosen > 0) and locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))
										letKeyholderDecideVisible = 1
									endif
									if (locks[lockSelected].keyholderDecisionDisabled = 0 and (locks[lockSelected].fixed = 1 and locks[lockSelected].regularity# = 0.016667 and (locks[lockSelected].botChosen > 0 or (locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0))))
										letKeyholderDecideVisible = 1
									endif
									if (locks[lockSelected].fixed = 0 and GetNoOfCards(lockSelected) > 0)
										putGreenBackVisible = 1
									endif
									totalDialogButtons = revealCombinationVisible + resetLockVisible + surpriseMeVisible + letKeyholderDecideVisible + putGreenBackVisible + decideLaterVisible
									if (resetLockVisible = 1)
										OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									else
										OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Would you like to reveal the combination?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									endif
									OryUISetDialogButtonCount(lockCard[i].dialog, totalDialogButtons)
									dialogButtonCount = 0
									if (revealCombinationVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (resetLockVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (surpriseMeVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (letKeyholderDecideVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:LetKeyholderDecide;text:Let Keyholder Decide;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (putGreenBackVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									if (decideLaterVisible = 1)
										inc dialogButtonCount
										OryUIUpdateDialogButton(lockCard[i].dialog, dialogButtonCount, "colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
									endif
									OryUIShowDialog(lockCard[i].dialog)
								endif
							endif
						endif
						surpriseMe as integer : surpriseMe = 0
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "FreeUnlock"))
							UnlockLock(lockSelected, "Lockee", "FreeUnlock")
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "NoFreeUnlock"))
							if (locks[lockSelected].keyholderDisabledKey = 1) then locks[lockSelected].keyDisabled = 1
							if (locks[lockSelected].hiddenFromOwner = 1) then locks[lockSelected].hiddenFromOwnerAlertHidden = 1
							if (locks[lockSelected].removedByKeyholder = 1) then locks[lockSelected].removedByKeyholderAlertHidden = 1
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "", 0)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy1Key"))
							if (PurchaseInApp(1) = 1)
								SavePurchasedKeys(1)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy2Keys"))
							if (PurchaseInApp(2) = 1)
								SavePurchasedKeys(2)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy5Keys"))
							if (PurchaseInApp(3) = 1)
								SavePurchasedKeys(5)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy10Keys"))
							if (PurchaseInApp(4) = 1)
								SavePurchasedKeys(10)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy25Keys"))
							if (PurchaseInApp(5) = 1)
								SavePurchasedKeys(25)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "Buy50Keys"))
							if (PurchaseInApp(6) = 1)
								SavePurchasedKeys(50)
								UseKeys(i, lockSelected)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "DecideLater"))
							locks[lockSelected].readyToUnlock = 1
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "", 0)
						endif
						
						// END OF LOCK ACTIONS CONFIRM DIALOGS
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "SurpriseMe"))
							OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the app to randomly choose if the lock resets or unlocks? It will pick randomly with a 50/50 chance.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
							OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedSurpriseMe;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(screen[screenNo].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "RevealCombination"))
							OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the lock to end and show you the combination?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
							OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedRevealCombination;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(screen[screenNo].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "ResetLock"))
							OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the lock to reset?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
							OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedResetLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(screen[screenNo].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "LetKeyholderDecide"))
							OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to let the keyholder decide? You will have to wait for a few hours to give them a chance to decide. After that the decision will come back to you.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
							OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedLetKeyholderDecide;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(screen[screenNo].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "PutGreenBack"))
							dialogButtonReleased$ = ""
							OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to put the last green found back into the deck to be found again?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
							OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedPutGreenBack;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(screen[screenNo].dialog)
						endif
	
						// END OF LOCK ACTIONS CONFIRMED
						surpriseMe = 0
						if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "ConfirmedSurpriseMe"))
							surpriseMe = random(1, 100)
						endif
						if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "ConfirmedLetKeyholderDecide"))
							locks[lockSelected].readyToUnlock = 1
							locks[lockSelected].timestampRequestedKeyholdersDecision = timestampNow
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:LetKeyholderDecide", 1)
							SendNotificationToKeyholder(locks[lockSelected].sharedID$, "RequestKeyholdersDecision", 0)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
						if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "ConfirmedPutGreenBack"))
							inc locks[lockSelected].greenCards
							dec locks[lockSelected].greensPickedSinceReset
							locks[lockSelected].readyToUnlock = 0
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:PutGreenBack", 1)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
						if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "ConfirmedResetLock") or (surpriseMe >= 51 and surpriseMe <= 100))
							locks[lockSelected].lockFrozenByCard = 0
							locks[lockSelected].lockFrozenByKeyholder = 0
							locks[lockSelected].readyToUnlock = 0
							locks[lockSelected].timestampLastFullReset = timestampNow
							locks[lockSelected].timestampLastReset = timestampNow
							inc locks[lockSelected].noOfTimesFullReset
							inc locks[lockSelected].noOfTimesReset
							if (locks[lockSelected].fixed = 0)
								if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampLastPicked = timestampNow - 60
								if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampLastPicked = timestampNow - 900
								if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampLastPicked = timestampNow - 1800
								if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampLastPicked = timestampNow - 3600
								if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampLastPicked = timestampNow - 10800
								if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampLastPicked = timestampNow - 21600
								if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampLastPicked = timestampNow - 43200
								if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampLastPicked = timestampNow - 86400
								locks[lockSelected].pickedCountSinceReset = 0
								locks[lockSelected].greenCards = locks[lockSelected].initialGreenCards
								locks[lockSelected].greensPickedSinceReset = 0
								locks[lockSelected].hideGreensUntilPickCount = 0
								locks[lockSelected].redCards = locks[lockSelected].initialRedCards
								locks[lockSelected].yellowCards = locks[lockSelected].initialYellowCards
								locks[lockSelected].noOfAdd1Cards = locks[lockSelected].initialYellowAdd1Cards
								locks[lockSelected].noOfAdd2Cards = locks[lockSelected].initialYellowAdd2Cards
								locks[lockSelected].noOfAdd3Cards = locks[lockSelected].initialYellowAdd3Cards
								locks[lockSelected].noOfMinus1Cards = locks[lockSelected].initialYellowMinus1Cards
								locks[lockSelected].noOfMinus2Cards = locks[lockSelected].initialYellowMinus2Cards
								locks[lockSelected].yellowCards = locks[lockSelected].noOfAdd1Cards + locks[lockSelected].noOfAdd2Cards + locks[lockSelected].noOfAdd3Cards + locks[lockSelected].noOfMinus1Cards + locks[lockSelected].noOfMinus2Cards
								locks[lockSelected].stickyCards = locks[lockSelected].initialStickyCards
								locks[lockSelected].freezeCards = locks[lockSelected].initialFreezeCards
								locks[lockSelected].doubleUpCards = locks[lockSelected].initialDoubleUpCards
								locks[lockSelected].resetCards = locks[lockSelected].initialResetCards
								locks[lockSelected].goAgainCards = 0
								if (locks[lockSelected].cardInfoHidden = 1) then locks[lockSelected].goAgainCards = floor((GetNoOfCards(i) / 100.0) * locks[lockSelected].goAgainCardsPercentage#)
								if (locks[lockSelected].goAgainCards > cappedGoAgainCards) then locks[lockSelected].goAgainCards = cappedGoAgainCards
							else
								// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
								if (locks[lockSelected].regularity# >= 0.25)
									locks[lockSelected].redCards = floor((timestampNow - locks[lockSelected].timestampLocked) / (locks[lockSelected].regularity# * 3600)) + locks[lockSelected].initialRedCards
								endif
								// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
								if (locks[lockSelected].regularity# = 0.016667)
									locks[lockSelected].minutes = floor((timestampNow - locks[lockSelected].timestampLocked) / 60) + locks[lockSelected].initialMinutes
								endif
							endif
							
							locks[lockSelected].autoResetsPaused = 0
							locks[lockSelected].noOfTimesAutoReset = 0
						
							UpdateLocksData(lockSelected)
							if (surpriseMe <= 50)
								UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:ResetLock", 0)
							else
								UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:ResetLockWithSurpriseMe", 0)
							endif
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
						if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "ConfirmedRevealCombination") or (surpriseMe >= 1 and surpriseMe <= 50))
							if (surpriseMe = 0 or surpriseMe >= 51)
								UnlockLock(lockSelected, "Lockee", "Naturally")
							else
								UnlockLock(lockSelected, "Lockee", "NaturallyWithSurpriseMe")
							endif
							inc noOfLocksNaturallyUnlocked
							SaveLocalVariable("noOfLocksNaturallyUnlocked", str(noOfLocksNaturallyUnlocked))
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "UseKey"))
							UseKeys(i, lockSelected)
						endif

						// CHECK-IN
						if (OryUIGetSpriteReleased() = lockCard[i].sprCheckInButton or OryUIGetSpriteReleased() = lockCard[i].sprCheckInIcon or OryUIGetSpriteReleased() = lockCard[i].sprCheckInCooldown)
							lockSelected = sortedIteration
							local checkInDialogBody$ as string
							local checkInDialogTitle$ as string
							local checkInRequired as integer
							if (locks[lockSelected].timestampLastCheckedIn = 0)
								secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLocked
								secondsUntilNextCheckIn = (locks[lockSelected].timestampLocked + locks[lockSelected].checkInFrequencyInSeconds) - timestampNow
								if (secondsUntilNextCheckIn > 0)
									checkInDialogTitle$ = "Check-in Not Required Yet"
									checkInDialogBody$ = "First check-in required in " + lower(ConvertSecondsToText(secondsUntilNextCheckIn, 1))
								else
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
										checkInDialogTitle$ = "Check-in Required (Late)"
										checkInDialogBody$ = "You are " + lower(ConvertSecondsToText(secondsCheckInLate, 1)) + " late"
									else
										checkInDialogTitle$ = "Check-in Required"
										checkInDialogBody$ = "You are not late yet"
									endif 
								endif
							else
								secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLastCheckedIn
								secondsUntilNextCheckIn = (locks[lockSelected].timestampLastCheckedIn + locks[lockSelected].checkInFrequencyInSeconds) - timestampNow
								checkInDialogTitle$ = "Check-in Not Required Yet"
								checkInDialogBody$ = "Last checked in " + lower(ConvertSecondsToText(secondsSinceLastCheckIn, 1)) + " ago"
								if (secondsUntilNextCheckIn > 0)
									checkInDialogBody$ = checkInDialogBody$ + chr(10) + chr(10) + "Next check-in required in " + lower(ConvertSecondsToText(secondsUntilNextCheckIn, 1))			
								else
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
										checkInDialogTitle$ = "Check-in Required (Late)"
										checkInDialogBody$ = "You are " + lower(ConvertSecondsToText(secondsCheckInLate, 1)) + " late"
									else
										checkInDialogTitle$ = "Check-in Required"
										checkInDialogBody$ = "You are not late yet"
									endif 
								endif
							endif
							if (secondsUntilNextCheckIn > 0)
								OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:" + checkInDialogTitle$ + ";titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + checkInDialogBody$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;deisionRequired:false")
								OryUISetDialogButtonCount(lockCard[i].dialog, 1)
								OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(lockCard[i].dialog)
							else
								OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:" + checkInDialogTitle$ + ";titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + checkInDialogBody$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;deisionRequired:false")
								OryUISetDialogButtonCount(lockCard[i].dialog, 2)
								OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CheckIn;text:Check-in;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(lockCard[i].dialog)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "CheckIn"))
							lockSelected = sortedIteration
							if (locks[lockSelected].timestampLastCheckedIn = 0)
								secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLocked
							else
								secondsSinceLastCheckIn = timestampNow - locks[lockSelected].timestampLastCheckedIn
							endif
							locks[lockSelected].timestampLastCheckedIn = timestampNow
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "action:CheckedIn;actionedBy:Lockee;result:" + str(timestampNow) + ";totalActionTime:" + str(secondsSinceLastCheckIn), 1)
						endif
							
						// CLEAN
						if (OryUIGetSpriteReleased() = lockCard[i].sprCleanButton or OryUIGetSpriteReleased() = lockCard[i].sprCleanIcon)
							lockSelected = sortedIteration
							if (locks[lockSelected].timestampRequestedCleanTime > locks[lockSelected].timestampDeniedCleanTime and locks[lockSelected].timestampRequestedCleanTime > locks[lockSelected].timestampCleanTimeRequestBlockedUntil)
								if (locks[lockSelected].timestampRequestedCleanTime > locks[lockSelected].timestampStartedCleanTime)
									OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Awaiting Keyholders Decision;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You have already requested to be unlocked briefly so that you can clean." + chr(10) + chr(10) + "You will need to wait for " + locks[lockButtonSelected].keyholderUsername$ + " to accept or decline your request.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;deisionRequired:false")
									OryUISetDialogButtonCount(lockCard[i].dialog, 2)
									OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelRequest;text:Cancel Request;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockCard[i].dialog)
								endif
							else
								OryUIUpdateDialog(lockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Request Time To Clean?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Would you like to ask " + locks[lockButtonSelected].keyholderUsername$ + " to be unlocked briefly so that you can clean?" + chr(10) + chr(10) + "Once requested you will not be able to ask again until they accept or decline." + chr(10) + chr(10) + "If they decline you might not be able to ask again for some time.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(lockCard[i].dialog, 2)
								OryUIUpdateDialogButton(lockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesRequestTimeToClean;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(lockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(lockCard[i].dialog)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "CancelRequest"))
							lockSelected = sortedIteration
							locks[lockSelected].timestampRequestedCleanTime = 0
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "action:CancelledRequestToClean;actionedBy:Lockee", 1)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockCard[i].dialog, "YesRequestTimeToClean"))
							lockSelected = sortedIteration
							locks[lockSelected].timestampRequestedCleanTime = timestampNow
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "action:RequestedTimeToClean;actionedBy:Lockee", 1)
						endif
						
						// RATING
						for a = 1 to 5
							if (OryUIGetSpriteReleased() = lockCard[i].sprRatingStar[a])
								lockSelected = sortedIteration
								if (locks[lockSelected].rating <> a)
									locks[lockSelected].rating = a
									locks[lockSelected].timestampRated = timestampNow
									UpdateLocksData(lockSelected)
									UpdateLocksDatabase(lockSelected, "action:RatedLock;actionedBy:Lockee;result:" + str(a) + ";private:1", 1)
								endif
							endif
						next
						
						// MOOD
						if (OryUIGetSpriteReleased() = lockCard[i].sprMoodButton or OryUIGetSpriteReleased() = lockCard[i].sprMoodIcon)
							lockSelected = sortedIteration
							lastScreenViewY# = GetViewOffsetY()
							emojiChosen = locks[lockSelected].emojiChosen
							emojiColourSelected = locks[lockSelected].emojiColourSelected
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constEmojisScreen)
						endif

						// MORE
						if (OryUIGetSpriteReleased() = lockCard[i].sprMoreButton or OryUIGetSpriteReleased() = lockCard[i].sprMoreIcon)
							lockSelected = sortedIteration
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constLockInformationScreen)
						endif

						// FLAGS
						if (OryUIGetSpriteReleased() = lockCard[i].sprFlagButton or OryUIGetSpriteReleased() = lockCard[i].sprFlagIcon)
							lockSelected = sortedIteration
							flagCount as integer : flagCount = 0
							chosenFlagName$ as string : chosenFlagName$ = ""
							flagName$ as string : flagName$ = ""
							for a = 1 to 7
								if (a = 1) then flagName$ = "FlagBlack"
								if (a = 2) then flagName$ = "FlagBlue"
								if (a = 3) then flagName$ = "FlagGreen"
								if (a = 4) then flagName$ = "FlagOrange"
								if (a = 5) then flagName$ = "FlagPurple"
								if (a = 6) then flagName$ = "FlagRed"
								if (a = 7) then flagName$ = "FlagYellow"
								if (locks[lockSelected].flagChosen = a) then chosenFlagName$ = flagName$
								if (locks[lockSelected].flagChosen <> a)
									inc flagCount
									OryUIUpdateButtonGroupItem(lockCard[i].flagButtonGroup, flagCount, "name:" + flagName$ + ";text: ;iconID:" + str(imgFlags[a]))	
								endif
							next
							if (flagCount = 6)
								OryUIUpdateButtonGroupItem(lockCard[i].flagButtonGroup, 7, "name:FlagCancel;text: ;iconID:" + str(imgFlags[9]))
								OryUIUpdateButtonGroupItem(lockCard[i].flagButtonGroup, 8, "name:" + chosenFlagName$ + ";text: ;iconID:" + str(imgFlags[locks[lockSelected].flagChosen]))
							else
								OryUIUpdateButtonGroupItem(lockCard[i].flagButtonGroup, 8, "name:FlagCancel;text: ;iconID:" + str(imgBlank))
							endif
							OryUISetButtonGroupItemSelectedByIndex(lockCard[i].flagButtonGroup, 8)
							OryUIDisableScreenScrolling()
							OryUIUpdateSprite(lockCard[i].sprScrim, "position:" + str(GetViewOffsetX()) + "," + str(GetViewOffsetY() + screenBoundsTop#))
							oryUIScrimVisible = 1
							oryUIScrimDepth = 6
							OryUIUpdateButtonGroup(lockCard[i].flagButtonGroup, "offset:" + str(OryUIGetButtonGroupWidth(lockCard[i].flagButtonGroup)) + "," + str(OryUIGetButtonGroupHeight(lockCard[i].flagButtonGroup) / 2) + ";position:" + str(GetSpriteX(lockCard[i].sprFlagButton) + GetSpriteWidth(lockCard[i].sprFlagButton)) + "," + str(GetSpriteY(lockCard[i].sprFlagButton) + (GetSpriteHeight(lockCard[i].sprFlagButton) / 2)) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(theme[themeSelected].color[2]))
						elseif (OryUIGetSpritePressed() = lockCard[i].sprScrim)
							OryUIEnableScreenScrolling()
							OryUIUpdateSprite(lockCard[i].sprScrim, "position:-1000,-1000")
							oryUIScrimVisible = 0
							OryUIUpdateButtonGroup(lockCard[i].flagButtonGroup, "position:-1000,-1000")
						endif
						OryUIInsertButtonGroupListener(lockCard[i].flagButtonGroup)
						flagChosen as integer : flagChosen = -1
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagCancel")) then flagChosen = 0
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagBlack")) then flagChosen = 1
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagBlue")) then flagChosen = 2
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagGreen")) then flagChosen = 3
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagOrange")) then flagChosen = 4
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagPurple")) then flagChosen = 5
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagRed")) then flagChosen = 6
						if (OryUIGetButtonGroupItemReleasedByName(lockCard[i].flagButtonGroup, "FlagYellow")) then flagChosen = 7
						if (flagChosen >= 0)
							OryUIEnableScreenScrolling()
							locks[lockSelected].flagChosen = flagChosen
							UpdateLocksData(lockSelected)
							UpdateLocksDatabase(lockSelected, "", 0)
							OryUIUpdateSprite(lockCard[i].sprScrim, "position:-1000,-1000")
							oryUIScrimVisible = 0
							OryUIUpdateButtonGroup(lockCard[i].flagButtonGroup, "position:-1000,-1000")
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
					endif
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * filterCount) - 2
	endif
	
	// ADD BUTTON
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabAddMyLock, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	if (disableCreationOfNewLocks = 0 and oryUIScrimVisible = 0 and noOfLocks < 20 and offline = 0 and maintenance = 0 and timestampFromServer > 1500000000) then OryUIShowFloatingActionButton(fabAddMyLock)
	if (OryUIGetFloatingActionButtonReleased(fabAddMyLock))
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = ""
		sharedLockInfo$ = ""	
		selectedLockOptionsTab = 1
		GenerateCombination(noOfDigits, 1)
		ResetNewLockOptions()
		OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)
		resetOptions = 1
		SetScreenToView(constLockOptionsScreen)
	endif

	// ADVERTS
	if (OryUIGetNavigationDrawerVisible(navigationDrawer) = 0 and OryUIAnyTextfieldFocused() = 0 and OryUIAnyInputSpinnerTextfieldFocused() = 0)
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
		OryUIHideFloatingActionButton(fabAddMyLock)
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
