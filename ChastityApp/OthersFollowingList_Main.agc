
if (screenToView = constOthersFollowingListScreen)
	if (screenNo <> constOthersFollowingListScreen)
		iterationOffset = 0
		lastFilterCount = -1
		lastOthersFollowingSearchLength as integer : lastOthersFollowingSearchLength = 0
		OryUIUpdateTextfield(editOthersFollowingSearch, "inputText:;")
	endif
	screenNo = constOthersFollowingListScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:" + profileData.username$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetOthersRelations(profileData.id, 1)
		SetScreenToView(constOthersFollowingListScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		SetScreenToView(constOthersFollowersListScreen)
	endif
	
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)

	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetOthersRelations(profileData.id, 1)
		SetScreenToView(constOthersFollowingListScreen)
	endif
	
	// FOLLOWING SEARCH BAR
	if (othersFriends.following.length >= 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetOthersRelations"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprOthersFollowingSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editOthersFollowingSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor) + ";showTrailingIcon:true;trailingIcon:cancel")
		endif
		OryUIInsertTextFieldListener(editOthersFollowingSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editOthersFollowingSearch))
			OryUISetTextfieldString(editOthersFollowingSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editOthersFollowingSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editOthersFollowingSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editOthersFollowingSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editOthersFollowingSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editOthersFollowingSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editOthersFollowingSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editOthersFollowingSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editOthersFollowingSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		elementY# = elementY# + GetSpriteHeight(sprOthersFollowingSearchBar)
	else
		OryUIUpdateSprite(sprOthersFollowingSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editOthersFollowingSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// SORT FOLLOWING
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editOthersFollowingSearch)) <> lastOthersFollowingSearchLength)
		lastOthersFollowingSearchLength = len(OryUIGetTextFieldString(editOthersFollowingSearch))
		SortOthersFollowing(OryUIGetTextfieldString(editOthersFollowingSearch))
	endif

	// NOT FOLLOWING ANYONE
	if (othersFriends.following.length = -1 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetOthersRelations") = 0)
		OryUIUpdateText(txtOthersNotFollowingAnyoneLine1, "text:Not Following Anyone Yet;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		if (filterCount = 0 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetOthersRelations") = 0)
			OryUIUpdateText(txtOthersNotFollowingAnyoneLine1, "text:No Users Found;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtOthersNotFollowingAnyoneLine1, "position:-1000,-1000")
		endif
	endif
	
	// FOLLOWING LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listOthersFollowing, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listOthersFollowing, maxListItemCount)
		else
			OryUISetListItemCount(listOthersFollowing, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listOthersFollowing, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listOthersFollowing)
	for i = 0 to maxListItemCount - 1
		if (i <= OryUIGetListItemCount(listOthersFollowing) - 1)
			if (othersFriends.following.length >= 0)
				sortedIteration = othersFriends.followingSorted[i + iterationOffset].iteration
				
				mainRoleLevel$ = ""
				if (othersFriends.following[sortedIteration].mainRole = 1)
					if (othersFriends.following[sortedIteration].keyholderLevel = 1) then mainRoleLevel$ = "Novice Keyholder"
					if (othersFriends.following[sortedIteration].keyholderLevel = 2) then mainRoleLevel$ = "Keyholder"
					if (othersFriends.following[sortedIteration].keyholderLevel = 3) then mainRoleLevel$ = "Established Keyholder"
					if (othersFriends.following[sortedIteration].keyholderLevel = 4) then mainRoleLevel$ = "Distinguished Keyholder"
					if (othersFriends.following[sortedIteration].keyholderLevel = 5) then mainRoleLevel$ = "Renowned Keyholder"
					mainRoleColour = roleColours.keyholder[othersFriends.following[sortedIteration].keyholderLevel]
				endif
				if (othersFriends.following[sortedIteration].mainRole = 2)
					if (othersFriends.following[sortedIteration].lockeeLevel = 1) then mainRoleLevel$ = "Novice Lockee"
					if (othersFriends.following[sortedIteration].lockeeLevel = 2) then mainRoleLevel$ = "Intermediate Lockee"
					if (othersFriends.following[sortedIteration].lockeeLevel = 3) then mainRoleLevel$ = "Experienced Lockee"
					if (othersFriends.following[sortedIteration].lockeeLevel = 4) then mainRoleLevel$ = "Devoted Lockee"
					mainRoleColour = roleColours.lockee[othersFriends.following[sortedIteration].lockeeLevel]
				endif
				if (mainRoleLevel$ <> "")
					OryUIUpdateListItem(listOthersFollowing, i, "noOfLeftLines:2;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + othersFriends.following[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";leftLine2Text:" + mainRoleLevel$ + ";leftLine2TextSize:2.4;leftLine2TextColorID:" + str(mainRoleColour))
				else
					OryUIUpdateListItem(listOthersFollowing, i, "noOfLeftLines:1;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + othersFriends.following[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				
				if (GetSpriteY(OryUIListCollection[listOthersFollowing].sprItemContainer[i]) >= GetViewOffsetY() and GetSpriteY(OryUIListCollection[listOthersFollowing].sprItemContainer[i]) <= GetViewOffsetY() + GetScreenBoundsBottom())
					if (othersFriends.following[sortedIteration].id <> userDBRow)
						if (FindRelation("following", othersFriends.following[sortedIteration].id) = 0)
							if (FindRelation("pendingbyothers", othersFriends.following[sortedIteration].id) = 0)
								OryUIUpdateListItemRightButton(listOthersFollowing, i, "text:Follow;textSize:2.5;size:18,3.2;colorID:" + str(theme[themeSelected].color[3]))
								if (OryUIGetListItemRightButtonReleased(listOthersFollowing) = i)
									if (left(username$, 3) = "CKU")
										OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can follow people you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
										OryUISetDialogButtonCount(dialog, 2)
										OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
										OryUIShowDialog(dialog)
									else
										FollowUser(othersFriends.following[sortedIteration].id, 1)
									endif
								endif
							else
								OryUIUpdateListItemRightButton(listOthersFollowing, i, "text:Request Sent;textSize:2.5;size:30,3.2;colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
								if (OryUIGetListItemRightButtonReleased(listOthersFollowing) = i)
									UnfollowUser(othersFriends.following[sortedIteration].id, 1)
								endif
							endif
						else
							OryUIUpdateListItemRightButton(listOthersFollowing, i, "text:Unfollow;textSize:2.5;size:22,3.2;colorID:" + str(theme[themeSelected].color[3]))
							if (OryUIGetListItemRightButtonReleased(listOthersFollowing) = i)
								UnfollowUser(othersFriends.following[sortedIteration].id, 1)
							endif
						endif
					else
						OryUIUpdateButton(OryUIListCollection[listOthersFollowing].btnRight[i], "position:-10000,-10000")
					endif
					if (OryUIGetSpriteReleased() = OryUIListCollection[listOthersFollowing].sprItemContainer[i])
						GetProfileData(othersFriends.following[sortedIteration].id, 1)
						lastScreenViewed = constOthersFollowingListScreen
						screen[screenNo].lastViewY# = GetViewOffsetY()
						SetScreenToView(constViewProfileScreen)
					endif
				endif
			endif
		endif
	next
	elementY# = startListY# + (filterCount * listItemHeight#)
	
	// ADVERTS
	if (OryUIAnyTextfieldFocused() = 0 and OryUIAnyInputSpinnerTextfieldFocused() = 0)
		if (adsRemoved = 0)
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
