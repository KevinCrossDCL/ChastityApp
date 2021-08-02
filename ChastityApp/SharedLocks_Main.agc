
OryUIHideFloatingActionButton(fabAddSharedLock)
if (screenToView = constSharedLocksScreen)
	if (screenNo <> constSharedLocksScreen)
		filterSharedLocksByLabel$ as string : filterSharedLocksByLabel$ = ""
		lastSharedLocksSearchLength as integer : lastSharedLocksSearchLength = 0
		OryUIUpdateTextfield(editSharedLocksSearch, "inputText:;")
		OryUIUpdateTextfield(editSharedLocksSearch, "inputText:" + sharedLocksSearchString$ + ";")
		sortSharedLocksByLabel$ as string : sortSharedLocksByLabel$ = ""
	endif

	screenNo = constSharedLocksScreen
	selectedLocksTab = 2
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
		if (statusSelected = 1) then OryUIUpdateSprite(sprSharedLocksStatusIcon, "image:" + str(imgStatusAvailableIcon))
		if (statusSelected = 2) then OryUIUpdateSprite(sprSharedLocksStatusIcon, "image:" + str(imgStatusBusyIcon))
		if (statusSelected = 3) then OryUIUpdateSprite(sprSharedLocksStatusIcon, "image:" + str(imgStatusSleepingIcon))
		if (statusSelected = 4) then OryUIUpdateSprite(sprSharedLocksStatusIcon, "image:" + str(imgStatusOfflineIcon))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	OryUIPinSpriteToBottomRightOfSprite(sprSharedLocksStatusIcon, OryUITopBarCollection[screen[screenNo].topBar].actions[0].sprIcon, -((GetSpriteWidth(sprMyLocksStatusIcon) * 0.8) / 2), -((GetSpriteHeight(sprMyLocksStatusIcon) * 0.8) / 2))
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "menu")
		OryUIShowNavigationDrawer(navigationDrawer)
	endif
	if (GetRawKeyPressed(27))
		OryUIHideNavigationDrawer(navigationDrawer)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "profile")
		GetProfileData(userDBRow, 1)
		SetScreenToView(constViewProfileScreen)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		if (offline = 1 or maintenance = 1 or timestampNow <= 1500000000) then GetServerVariables(1)
		GetAccountData(0)
		GetSharedLocksData(1)
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
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		SaveLocalVariable("selectedLocksTab", "1")
		SetScreenToView(constMyLocksScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	// FILTER BAR
	OryUIUpdateSprite(sprFilterSharedLocksBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterSharedLocks, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterSharedLocksBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredSharedLocksBy, "text:" + filterSharedLocksByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterSharedLocks) + OryUIGetButtonWidth(btnIconFilterSharedLocks)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterSharedLocksBar) / 2)))
	OryUIUpdateButton(btnIconSortSharedLocks, "position:" + str((screenNo * 100) + 98 - OryUIGetButtonWidth(btnIconSortSharedLocks)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterSharedLocksBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextSortedSharedLocksBy, "text:" + sortSharedLocksByLabel$ + " (" + sortSharedLocksOrder$ + ");textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconSortSharedLocks) - OryUIGetButtonWidth(btnTextSortedSharedLocksBy)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterSharedLocksBar) / 2)))
	OryUIUpdateSprite(sprFilterSharedLocksBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterSharedLocksBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterSharedLocksBar) // + 2

	// PULL DOWN TO REFRESH
	if (oryUIScrimVisible = 0)
		if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
			if (offline = 1 or maintenance = 1 or timestampNow <= 1500000000) then GetServerVariables(1)
			GetAccountData(0)
			GetSharedLocksData(1)
		endif
	endif
	
	// FILTER/SORT MENUS
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterSharedLocks, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterSharedLocks) or OryUIGetButtonReleased(btnTextFilteredSharedLocksBy))
		OryUISetMenuItemCount(menuFilterSharedLocks, 8)
		OryUIUpdateMenuItem(menuFilterSharedLocks, 1, "name:FilterSharedLocksAll;text:All;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 2, "name:FilterSharedLocksFixed;text:Fixed;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 3, "name:FilterSharedLocksVariable;text:Variable;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 4, "name:FilterSharedLocksHasUsersLockedIncludingTest;text:Has Users Locked (incl. Test);rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 5, "name:FilterSharedLocksHasUsersLockedExcludingTest;text:Has Users Locked (excl. Test);rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 6, "name:FilterSharedLocksAwaitingDecision;text:Awaiting Your Decision;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 7, "name:FilterSharedLocksAwaitingRating;text:Pending Rating;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterSharedLocks, 8, "name:FilterSharedLocksTemporarilyDisabled;text:Temporarily Disabled;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		if (filterSharedLocksBy$ = "FilterSharedLocksAll") then OryUIUpdateMenuItem(menuFilterSharedLocks, 1, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksFixed") then OryUIUpdateMenuItem(menuFilterSharedLocks, 2, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksVariable") then OryUIUpdateMenuItem(menuFilterSharedLocks, 3, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest") then OryUIUpdateMenuItem(menuFilterSharedLocks, 4, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedExcludingTest") then OryUIUpdateMenuItem(menuFilterSharedLocks, 5, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingDecision") then OryUIUpdateMenuItem(menuFilterSharedLocks, 6, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating") then OryUIUpdateMenuItem(menuFilterSharedLocks, 7, "rightIconID:" + str(imgTickIcon))
		if (filterSharedLocksBy$ = "FilterSharedLocksTemporarilyDisabled") then OryUIUpdateMenuItem(menuFilterSharedLocks, 8, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterSharedLocks, OryUIGetButtonX(btnIconFilterSharedLocks), OryUIGetButtonY(btnIconFilterSharedLocks) + OryUIGetButtonHeight(btnIconFilterSharedLocks))
	endif
	OryUIInsertMenuListener(menuFilterSharedLocks)
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksAll" or filterSharedLocksBy$ = "FilterSharedLocksAll")
		filterSharedLocksBy$ = "FilterSharedLocksAll"
		filterSharedLocksByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksFixed" or filterSharedLocksBy$ = "FilterSharedLocksFixed")
		filterSharedLocksBy$ = "FilterSharedLocksFixed"
		filterSharedLocksByLabel$ = "Fixed"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksVariable" or filterSharedLocksBy$ = "FilterSharedLocksVariable")
		filterSharedLocksBy$ = "FilterSharedLocksVariable"
		filterSharedLocksByLabel$ = "Variable"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksHasUsersLockedIncludingTest" or filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest")
		filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest"
		filterSharedLocksByLabel$ = "Has Users Locked (incl. Test)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksHasUsersLockedExcludingTest" or filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedExcludingTest")
		filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedExcludingTest"
		filterSharedLocksByLabel$ = "Has Users Locked (excl. Test)"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksAwaitingDecision" or filterSharedLocksBy$ = "FilterSharedLocksAwaitingDecision")
		filterSharedLocksBy$ = "FilterSharedLocksAwaitingDecision"
		filterSharedLocksByLabel$ = "Awaiting Your Decision"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksAwaitingRating" or filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating")
		filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating"
		filterSharedLocksByLabel$ = "Pending Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) = "FilterSharedLocksTemporarilyDisabled" or filterSharedLocksBy$ = "FilterSharedLocksTemporarilyDisabled")
		filterSharedLocksBy$ = "FilterSharedLocksTemporarilyDisabled"
		filterSharedLocksByLabel$ = "Temporarily Disabled"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterSharedLocks) <> "")
		SaveLocalVariable("filterSharedLocksBy", filterSharedLocksBy$)
		SetScreenToView(constSharedLocksScreen)
	endif
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuSortSharedLocks, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconSortSharedLocks) or OryUIGetButtonReleased(btnTextSortedSharedLocksBy))
		OryUISetMenuItemCount(menuSortSharedLocks, 5)
		OryUIUpdateMenuItem(menuSortSharedLocks, 1, "name:SortSharedLocksByCreated;text:Created;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortSharedLocks, 2, "name:SortSharedLocksByName;text:Name;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortSharedLocks, 3, "name:SortSharedLocksByRating;text:Rating;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortSharedLocks, 4, "name:SortSharedLocksByUserCount;text:Users Locked;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuSortSharedLocks, 5, "text: ;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";rightIconID:" + str(imgBlank))
		if (sortSharedLocksBy$ = "SortSharedLocksByCreated") then OryUIUpdateMenuItem(menuSortSharedLocks, 1, "rightIconID:" + str(imgTickIcon))
		if (sortSharedLocksBy$ = "SortSharedLocksByName") then OryUIUpdateMenuItem(menuSortSharedLocks, 2, "rightIconID:" + str(imgTickIcon))
		if (sortSharedLocksBy$ = "SortSharedLocksByRating") then OryUIUpdateMenuItem(menuSortSharedLocks, 3, "rightIconID:" + str(imgTickIcon))
		if (sortSharedLocksBy$ = "SortSharedLocksByUserCount") then OryUIUpdateMenuItem(menuSortSharedLocks, 4, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuSortSharedLocks, OryUIGetButtonX(btnIconSortSharedLocks), OryUIGetButtonY(btnIconSortSharedLocks) + OryUIGetButtonHeight(btnIconSortSharedLocks))
	endif
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSortSharedLocks, "selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSortSharedLocks)
	OryUIInsertMenuListener(menuSortSharedLocks)
	if (OryUIGetMenuVisible(menuSortSharedLocks))
		OryUIUpdateButtonGroup(grpSortSharedLocks, "position:" + str(OryUIGetMenuX(menuSortSharedLocks)) + "," + str(OryUIGetMenuY(menuSortSharedLocks) + OryUIGetMenuHeight(menuSortSharedLocks) - OryUIGetButtonGroupHeight(grpSortSharedLocks)))
	else
		OryUIUpdateButtonGroup(grpSortSharedLocks, "position:-1000,-1000")
	endif
	if (OryUIGetMenuItemReleasedName(menuSortSharedLocks) = "SortSharedLocksByCreated" or sortSharedLocksBy$ = "SortSharedLocksByCreated")
		sortSharedLocksBy$ = "SortSharedLocksByCreated"
		sortSharedLocksByLabel$ = "Created"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortSharedLocks) = "SortSharedLocksByName" or sortSharedLocksBy$ = "SortSharedLocksByName")
		sortSharedLocksBy$ = "SortSharedLocksByName"
		sortSharedLocksByLabel$ = "Name"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortSharedLocks) = "SortSharedLocksByRating" or sortSharedLocksBy$ = "SortSharedLocksByRating")
		sortSharedLocksBy$ = "SortSharedLocksByRating"
		sortSharedLocksByLabel$ = "Rating"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortSharedLocks) = "SortSharedLocksByUserCount" or sortSharedLocksBy$ = "SortSharedLocksByUserCount")
		sortSharedLocksBy$ = "SortSharedLocksByUserCount"
		sortSharedLocksByLabel$ = "Users Locked"
	endif
	if (OryUIGetMenuItemReleasedName(menuSortSharedLocks) <> "")
		SaveLocalVariable("sortSharedLocksBy", sortSharedLocksBy$)
		SetScreenToView(constSharedLocksScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortSharedLocks, "ASC"))
		sortSharedLocksOrder$ = "ASC"
		SaveLocalVariable("sortSharedLocksOrder", sortSharedLocksOrder$)
		SetScreenToView(constSharedLocksScreen)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpSortSharedLocks, "DESC"))
		sortSharedLocksOrder$ = "DESC"
		SaveLocalVariable("sortSharedLocksOrder", sortSharedLocksOrder$)
		SetScreenToView(constSharedLocksScreen)
	endif
	
	// SHARED LOCKS SEARCH BAR
	if (noOfSharedLocks > 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetSharedLocks"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprSharedLocksSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editSharedLocksSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		endif
		OryUIInsertTextFieldListener(editSharedLocksSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editSharedLocksSearch))
			OryUISetTextfieldString(editSharedLocksSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editSharedLocksSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editSharedLocksSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editSharedLocksSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editSharedLocksSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editSharedLocksSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editSharedLocksSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editSharedLocksSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editSharedLocksSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		elementY# = elementY# + GetSpriteHeight(sprSharedLocksSearchBar) + 2
	else
		OryUIUpdateSprite(sprSharedLocksSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editSharedLocksSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	startScrollBarY# = elementY# - 1
	
	// SORT SHARED LOCKS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editSharedLocksSearch)) <> lastSharedLocksSearchLength)
		lastSharedLocksSearchLength = len(OryUIGetTextFieldString(editSharedLocksSearch))
		SortSharedLocks(OryUIGetTextfieldString(editSharedLocksSearch))
		redrawScreen = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO LOCKS
	if (noOfSharedLocks = 0)
		if (disableCreationOfNewLocks = 0)
			OryUIUpdateText(txtNoSharedLocks, "text:No Shared Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtPressPlusToCreateSharedLock, "text:Press + below to create new locks to share;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoSharedLocks, "text:No Shared Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtPressPlusToCreateSharedLock, "text:Creation of new locks have been disabled." + chr(10) + "Check the Discord server or forums for news.;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	elseif (filterCount = 0)
		OryUIUpdateText(txtNoSharedLocks, "text:No Shared Locks Matching Filter;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtPressPlusToCreateSharedLock, "position:-1000,-1000")
	else
		OryUIUpdateText(txtNoSharedLocks, "position:-1000,-1000")
		OryUIUpdateText(txtPressPlusToCreateSharedLock, "position:-1000,-1000")
	endif
	
	// SHARED LOCKS
	if (redrawScreen = 1)
		for i = 1 to 5
			DestroyItemsInSharedLockCard(i)
			CreateItemsInSharedLockCard(i)
		next
	endif
	if (filterCount > 0)
		fullCardHeight# = GetSpriteHeight(sharedLockCard[1].sprBackground) + GetSpriteHeight(sharedLockCard[1].sprButtonBar) + 2.0
		for i = 1 to 5
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(sharedLockCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					OryUIUpdateSprite(sharedLockCard[i].sprOverlay, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
					elementY# = elementY# + GetSpriteHeight(sharedLockCard[i].sprBackground)
					OryUIUpdateSprite(sharedLockCard[i].sprButtonBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
					elementY# = elementY# + GetSpriteHeight(sharedLockCard[i].sprButtonBar) + 2
					sharedLockCard[i].iteration = i
				endif
				if (GetSpriteY(sharedLockCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and sharedLockCard[i].iteration + 5 <= filterCount)
					sharedLockCard[i].iteration = sharedLockCard[i].iteration + 5
					OryUIUpdateSprite(sharedLockCard[i].sprBackground, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground) + (fullCardHeight# * 5)))
					OryUIUpdateSprite(sharedLockCard[i].sprOverlay, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground)))
					OryUIUpdateSprite(sharedLockCard[i].sprButtonBar, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground) + GetSpriteHeight(sharedLockCard[i].sprBackground)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(sharedLockCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 5) and sharedLockCard[i].iteration - 5 >= 1)
					sharedLockCard[i].iteration = sharedLockCard[i].iteration - 5
					OryUIUpdateSprite(sharedLockCard[i].sprBackground, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground) - (fullCardHeight# * 5)))
					OryUIUpdateSprite(sharedLockCard[i].sprOverlay, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground)))
					OryUIUpdateSprite(sharedLockCard[i].sprButtonBar, "y:" + str(GetSpriteY(sharedLockCard[i].sprBackground) + GetSpriteHeight(sharedLockCard[i].sprBackground)))
					repositionItemsInCard = 1
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = sharedLocksSorted[sharedLockCard[i].iteration - 1].iteration
				
				if (GetSpriteInScreen(sharedLockCard[i].sprBackground))
					lockInView = 1
				else
					lockInView = 0
				endif
				
				UpdateItemsInSharedLockCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(sharedLockCard[i].dialog)
					
					if (OryUIGetSwipingVertically() = 0)
						
						// DELETE BUTTON
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprDeleteButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprDeleteIcon)
							if (enableLockDeletions = 1)
								OryUIUpdateDialog(sharedLockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Delete Shared Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This will delete the lock from your list and will no longer be managed by you. Once deleted you will not be able to track how many users are using the lock, or manage it again in the future." + chr(10) + chr(10) + "Any users currently locked will have a chance to unlock for free, or continue running the lock as a solo lock. And all users that are frozen will be unfrozen." + chr(10) + chr(10) + "You won't receive any further ratings for it once deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(sharedLockCard[i].dialog, 2)
								OryUIUpdateDialogButton(sharedLockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteLock;text:Delete Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIUpdateDialogButton(sharedLockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(sharedLockCard[i].dialog)
							else
								OryUIUpdateDialog(sharedLockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Deletion of Locks Disabled;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:If you want to delete this active lock, you will need to enable deletion of locks on the settings page. You can disable it again afterwards if needed.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(sharedLockCard[i].dialog, 1)
								OryUIUpdateDialogButton(sharedLockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(sharedLockCard[i].dialog)
							endif
						endif
						if (OryUIGetDialogButtonReleasedByName(sharedLockCard[i].dialog, "DeleteLock"))
							sharedLockSelected = sortedIteration
							DeleteSharedLock(sharedLockSelected, 0)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constSharedLocksScreen)
						endif
						
						// CLONE LOCK
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprCloneButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprCloneIcon)
							OryUIUpdateDialog(sharedLockCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Clone Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Do you want to create a new lock from this locks settings?" + chr(10) + chr(10) + "You can change some or all of the settings on the next screen.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(sharedLockCard[i].dialog, 2)
							OryUIUpdateDialogButton(sharedLockCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CloneLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(sharedLockCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(sharedLockCard[i].dialog)
						endif
						if (OryUIGetDialogButtonReleasedByName(sharedLockCard[i].dialog, "CloneLock"))
							sharedLockToClone = sortedIteration
							sharedLockName$ = ""
							selectedLockOptionsTab = 1
							OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 2)
							SetScreenToView(constLockOptionsScreen)
						endif
						
						// MANAGE USERS BUTTON
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprManageButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprManageIcon)
							usersPageNo = 1
							sharedLockSelected = sortedIteration
							sharedLocksSearchString$ = ""
							screen[screenNo].lastViewY# = GetViewOffsetY()
							if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating" and sharedLocks[sortedIteration, 0].unlockedUsersAwaitingRating > 0)
								GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 2, 1)
								SetScreenToView(constManageUnlockedUsersScreen)
							elseif (filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating" and sharedLocks[sortedIteration, 0].desertedUsersAwaitingRating > 0)
								GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 3, 1)
								SetScreenToView(constManageDesertedUsersScreen)
							else
								GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 1, 1)
								SetScreenToView(constManageLockedUsersScreen)
							endif
						endif
						
						// SHOW MATCHING USERS BUTTONS
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprShowMatchingUsersButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprShowMatchingUsersIcon)
							lockedUserMatches as integer : lockedUserMatches = FindString(sharedLocks[sortedIteration, 0].lockedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch))
							unlockedUserMatches as integer : unlockedUserMatches= FindString(sharedLocks[sortedIteration, 0].unlockedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch))
							desertedUserMatches as integer : desertedUserMatches = FindString(sharedLocks[sortedIteration, 0].desertedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch))
							itemCount = 0
							if (lockedUserMatches > 0) then inc itemCount
							if (unlockedUserMatches > 0) then inc itemCount
							if (desertedUserMatches > 0) then inc itemCount
							OryUISetMenuItemCount(sharedLockCard[i].menuShowMatchingUsers, itemCount)
							itemCount = 0
							if (lockedUserMatches > 0)
								inc itemCount
								OryUIUpdateMenuItem(sharedLockCard[i].menuShowMatchingUsers, itemCount, "name:ShowLockedMatches;text:Show 'Locked' matches;textSize:2.8;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
							endif
							if (unlockedUserMatches > 0)
								inc itemCount
								OryUIUpdateMenuItem(sharedLockCard[i].menuShowMatchingUsers, itemCount, "name:ShowUnlockedMatches;text:Show 'Unlocked' matches;textSize:2.8;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
							endif
							if (desertedUserMatches > 0)
								inc itemCount
								OryUIUpdateMenuItem(sharedLockCard[i].menuShowMatchingUsers, itemCount, "name:ShowDesertedMatches;text:Show 'Deserted' matches;textSize:2.8;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
							endif
							OryUIShowMenu(sharedLockCard[i].menuShowMatchingUsers, GetSpriteX(sharedLockCard[i].sprShareButton), GetSpriteY(sharedLockCard[i].sprShareButton) + GetSpriteHeight(sharedLockCard[i].sprShareButton))
						endif
						OryUIInsertMenuListener(sharedLockCard[i].menuShowMatchingUsers)
						if (OryUIGetMenuItemReleasedName(sharedLockCard[i].menuShowMatchingUsers) = "ShowLockedMatches")
							GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 1, 1)
							usersPageNo = 1
							sharedLockSelected = sortedIteration
							sharedLocksSearchString$ = OryUIGetTextFieldString(editSharedLocksSearch)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constManageLockedUsersScreen)
						endif
						if (OryUIGetMenuItemReleasedName(sharedLockCard[i].menuShowMatchingUsers) = "ShowUnlockedMatches")
							GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 2, 1)
							usersPageNo = 1
							sharedLockSelected = sortedIteration
							sharedLocksSearchString$ = OryUIGetTextFieldString(editSharedLocksSearch)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constManageUnlockedUsersScreen)
						endif
						if (OryUIGetMenuItemReleasedName(sharedLockCard[i].menuShowMatchingUsers) = "ShowDesertedMatches")
							GetSharedLockUsersData(sharedLocks[sortedIteration, 0].shareID$, 3, 1)
							usersPageNo = 1
							sharedLockSelected = sortedIteration
							sharedLocksSearchString$ = OryUIGetTextFieldString(editSharedLocksSearch)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constManageDesertedUsersScreen)
						endif
						
						// MORE BUTTON
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprMoreButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprMoreIcon)
							sharedLockSelected = sortedIteration
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constSharedLockInformationScreen)
						endif
						
						// SHARE BUTTON
						if (OryUIGetSpriteReleased() = sharedLockCard[i].sprShareButton or OryUIGetSpriteReleased() = sharedLockCard[i].sprShareIcon)
							OryUISetMenuItemCount(sharedLockCard[i].menuShare, 2)
							OryUIUpdateMenuItem(sharedLockCard[i].menuShare, 1, "name:ShowQRCode;text:Show QR Code;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateMenuItem(sharedLockCard[i].menuShare, 2, "name:CopyLink;text:Copy Link;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowMenu(sharedLockCard[i].menuShare, GetSpriteX(sharedLockCard[i].sprShareButton), GetSpriteY(sharedLockCard[i].sprShareButton) + GetSpriteHeight(sharedLockCard[i].sprShareButton))
						endif
						OryUIInsertMenuListener(sharedLockCard[i].menuShare)
						if (OryUIGetMenuItemReleasedName(sharedLockCard[i].menuShare) = "ShowQRCode")
							sharedLockSelected = sortedIteration
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constShareLockScreen)
						endif
						if (OryUIGetMenuItemReleasedName(sharedLockCard[i].menuShare) = "CopyLink")
							SetClipboardText(constAppMarketingDomain$ + "/sharedlock/" + sharedLocks[sortedIteration, 0].shareID$)
							OryUIUpdateTooltip(tooltip, "text:Copied Link")
							if (GetViewOffsetY() = 0)
								OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
							else
								OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 80)
							endif
						endif
					endif
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * filterCount) - 2
	endif

	// ADD BUTTON
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabAddSharedLock, "colorID:" + str(theme[themeSelected].color[3]))
		OryUIUpdateFloatingActionButton(fabAddSharedLock, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	if (disableCreationOfNewLocks = 0 and oryUIScrimVisible = 0 and offline = 0 and maintenance = 0 and timestampFromServer > 1500000000) then OryUIShowFloatingActionButton(fabAddSharedLock)
	if (OryUIGetFloatingActionButtonReleased(fabAddSharedLock))
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = ""
		sharedLockInfo$ = ""	
		selectedLockOptionsTab = 1
		ResetNewLockOptions()
		OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 2)
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
		OryUIHideFloatingActionButton(fabAddSharedLock)
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
