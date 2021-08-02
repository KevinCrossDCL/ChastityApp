
if (screenToView = constYourFollowersListScreen)
	if (screenNo <> constYourFollowersListScreen)
		if (imgPendingFollowRequests = 0) then imgPendingFollowRequests = LoadImage("PendingFollowRequests.png")
		iterationOffset = 0
		lastFilterCount = -1
		lastYourFollowersSearchLength as integer : lastYourFollowersSearchLength = 0
		if (searchStringFromPreviousScreen$ <> "")
			OryUIUpdateTextfield(editYourFollowersSearch, "inputText:" + searchStringFromPreviousScreen$)
		else
			OryUIUpdateTextfield(editYourFollowersSearch, "inputText:;")
		endif
		searchStringFromPreviousScreen$ = ""
	endif
	screenNo = constYourFollowersListScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)

	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:" + username$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetYourRelations(1)
		SetScreenToView(constYourFollowersListScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		SetScreenToView(constYourFollowingListScreen)
	endif
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 3)
		SetScreenToView(constYourBlockedUsersListScreen)
	endif
	
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetYourRelations(1)
		SetScreenToView(constYourFollowersListScreen)
	endif
	
	// FOLLOWERS SEARCH BAR
	if (yourFriends.followers.length >= 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprYourFollowersSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editYourFollowersSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor) + ";showTrailingIcon:true;trailingIcon:clear")
		endif
		OryUIInsertTextFieldListener(editYourFollowersSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editYourFollowersSearch))
			OryUISetTextfieldString(editYourFollowersSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editYourFollowersSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editYourFollowersSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editYourFollowersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editYourFollowersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editYourFollowersSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editYourFollowersSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editYourFollowersSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editYourFollowersSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		elementY# = elementY# + GetSpriteHeight(sprYourFollowersSearchBar)
	else
		OryUIUpdateSprite(sprYourFollowersSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editYourFollowersSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif

	startScrollBarY# = elementY# + 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// PENDING LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listYourPending, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	listItemHeight# = 8.0
	if (yourFriends.pendingByYou.length >= 0)
		OryUISetListItemCount(listYourPending, 1)
	else
		OryUISetListItemCount(listYourPending, 0)
	endif
	OryUIInsertListListener(listYourPending)
	if (yourFriends.pendingByYou.length >= 0)
		if (yourFriends.pendingByYou.length = 0)
			OryUIUpdateListItem(listYourPending, 0, "noOfLeftLines:2;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftThumbnailImage:" + str(imgPendingFollowRequests) + ";leftLine1Text:1 follow request;leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";leftLine2Text:Approve or ignore requests;leftLine2TextSize:2.4;leftLine2TextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateListItem(listYourPending, 0, "noOfLeftLines:2;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftThumbnailImage:" + str(imgPendingFollowRequests) + ";leftLine1Text:" + str(yourFriends.pendingByYou.length + 1) + " follow requests;leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";leftLine2Text:Approve or ignore requests;leftLine2TextSize:2.4;leftLine2TextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		SetTextColorAlpha(OryUIListCollection[listYourPending].txtItemLeftLine2[0], 150)
		elementY# = OryUIGetListY(listYourPending) + listItemHeight#
		if (OryUIGetSpriteReleased() = OryUIListCollection[listYourPending].sprItemContainer[0] or OryUIGetSpriteReleased() = OryUIListCollection[listYourPending].sprItemLeftThumbnail[0])
			lastScreenViewed = constYourFollowersListScreen
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constYourFollowRequestsListScreen)
		endif
	endif
	
	// SORT FOLLOWERS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editYourFollowersSearch)) <> lastYourFollowersSearchLength)
		lastYourFollowersSearchLength = len(OryUIGetTextFieldString(editYourFollowersSearch))
		SortYourFollowers(OryUIGetTextfieldString(editYourFollowersSearch))
		contentHeightChanged = 1
	endif
	
	// NO FOLLOWERS
	if (yourFriends.followers.length = -1 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations") = 0)
		OryUIUpdateText(txtYourNoFollowersLine1, "text:No Followers Yet;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtYourNoFollowersLine2, "text:" + OryUIWrapText("When people follow you, they'll be listed here", 2.6, 94) + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		if (filterCount = 0 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations") = 0)
			OryUIUpdateText(txtYourNoFollowersLine1, "text:No Users Found;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtYourNoFollowersLine2, "text:Try refining your search;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtYourNoFollowersLine1, "position:-1000,-1000")
			OryUIUpdateText(txtYourNoFollowersLine2, "position:-1000,-1000")
		endif
	endif
	
	// FOLLOWERS LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listYourFollowers, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listYourFollowers, maxListItemCount)
		else
			OryUISetListItemCount(listYourFollowers, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listYourFollowers, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listYourFollowers)
	for i = 0 to maxListItemCount - 1
		if (i <= OryUIGetListItemCount(listYourFollowers) - 1)
			if (yourFriends.followers.length >= 0)
				sortedIteration = yourFriends.followersSorted[i + iterationOffset].iteration
				
				mainRoleLevel$ = ""
				if (yourFriends.followers[sortedIteration].mainRole = 1)
					if (yourFriends.followers[sortedIteration].keyholderLevel = 1) then mainRoleLevel$ = "Novice Keyholder"
					if (yourFriends.followers[sortedIteration].keyholderLevel = 2) then mainRoleLevel$ = "Keyholder"
					if (yourFriends.followers[sortedIteration].keyholderLevel = 3) then mainRoleLevel$ = "Established Keyholder"
					if (yourFriends.followers[sortedIteration].keyholderLevel = 4) then mainRoleLevel$ = "Distinguished Keyholder"
					if (yourFriends.followers[sortedIteration].keyholderLevel = 5) then mainRoleLevel$ = "Renowned Keyholder"
					mainRoleColour = roleColours.keyholder[yourFriends.followers[sortedIteration].keyholderLevel]
				endif
				if (yourFriends.followers[sortedIteration].mainRole = 2)
					if (yourFriends.followers[sortedIteration].lockeeLevel = 1) then mainRoleLevel$ = "Novice Lockee"
					if (yourFriends.followers[sortedIteration].lockeeLevel = 2) then mainRoleLevel$ = "Intermediate Lockee"
					if (yourFriends.followers[sortedIteration].lockeeLevel = 3) then mainRoleLevel$ = "Experienced Lockee"
					if (yourFriends.followers[sortedIteration].lockeeLevel = 4) then mainRoleLevel$ = "Devoted Lockee"
					mainRoleColour = roleColours.lockee[yourFriends.followers[sortedIteration].lockeeLevel]
				endif
				if (mainRoleLevel$ <> "")
					OryUIUpdateListItem(listYourFollowers, i, "noOfLeftLines:2;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + yourFriends.followers[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";leftLine2Text:" + mainRoleLevel$ + ";leftLine2TextSize:2.4;leftLine2TextColorID:" + str(mainRoleColour))
				else
					OryUIUpdateListItem(listYourFollowers, i, "noOfLeftLines:1;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + yourFriends.followers[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				
				if (GetSpriteY(OryUIListCollection[listYourFollowers].sprItemContainer[i]) >= GetViewOffsetY() and GetSpriteY(OryUIListCollection[listYourFollowers].sprItemContainer[i]) <= GetViewOffsetY() + GetScreenBoundsBottom())
					if (FindRelation("following", yourFriends.followers[sortedIteration].id) = 0)
						if (FindRelation("pendingbyothers", yourFriends.followers[sortedIteration].id) = 0)
							OryUIUpdateListItemRightButton(listYourFollowers, i, "text:Follow;textSize:2.5;size:18,3.2;colorID:" + str(theme[themeSelected].color[3]))
							if (OryUIGetListItemRightButtonReleased(listYourFollowers) = i)
								if (left(username$, 3) = "CKU")
									OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can follow people you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(dialog, 2)
									OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(dialog)
								else
									FollowUser(yourFriends.followers[sortedIteration].id, 1)
								endif
							endif
						else
							OryUIUpdateListItemRightButton(listYourFollowers, i, "text:Request Sent;textSize:2.5;size:30,3.2;colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
							if (OryUIGetListItemRightButtonReleased(listYourFollowers) = i)
								UnfollowUser(yourFriends.followers[sortedIteration].id, 1)
							endif
						endif
					else
						OryUIUpdateListItemRightButton(listYourFollowers, i, "text:Unfollow;textSize:2.5;size:22,3.2;colorID:" + str(theme[themeSelected].color[3]))
						if (OryUIGetListItemRightButtonReleased(listYourFollowers) = i)
							UnfollowUser(yourFriends.followers[sortedIteration].id, 1)
						endif
					endif
					if (OryUIGetSpriteReleased() = OryUIListCollection[listYourFollowers].sprItemContainer[i])
						GetProfileData(yourFriends.followers[sortedIteration].id, 1)
						lastScreenViewed = constYourFollowersListScreen
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
