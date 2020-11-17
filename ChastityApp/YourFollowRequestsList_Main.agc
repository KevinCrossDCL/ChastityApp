
if (screenToView = constYourFollowRequestsListScreen)
	if (screenNo <> constYourFollowRequestsListScreen)
		iterationOffset = 0
		lastFilterCount = -1
		lastYourFollowRequestsSearchLength as integer : lastYourFollowRequestsSearchLength = 0
		OryUIUpdateTextfield(editYourFollowRequestsSearch, "inputText:;")
	endif
	screenNo = constYourFollowRequestsListScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:Follow Requests;position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetYourRelations(1)
		SetScreenToView(constYourFollowRequestsListScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetYourRelations(1)
		SetScreenToView(constYourFollowRequestsListScreen)
	endif
	
	// FOLLOW REQUESTS SEARCH BAR
	if (yourFriends.pendingByYou.length >= 0 or OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations"))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprYourFollowRequestsSearchBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateTextfield(editYourFollowRequestsSearch, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor) + ";showTrailingIcon:true;trailingIcon:cancel")
		endif
		OryUIInsertTextFieldListener(editYourFollowRequestsSearch)
		if (OryUIGetTextfieldTrailingIconReleased(editYourFollowRequestsSearch))
			OryUISetTextfieldString(editYourFollowRequestsSearch, "")
			SetEditBoxFocus(OryUITextfieldCollection[editYourFollowRequestsSearch].editBox, 0)
		endif
		if (OryUIGetTextfieldHasFocus(editYourFollowRequestsSearch))
			SetViewoffset(GetViewOffsetX(), 0)
			OryUIUpdateSprite(OryUITextfieldCollection[editYourFollowRequestsSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editYourFollowRequestsSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editYourFollowRequestsSearch].sprActivationIndicator)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";alpha:255")
		else
			OryUIUpdateSprite(OryUITextfieldCollection[editYourFollowRequestsSearch].sprActivationIndicator, "size:" + str(GetSpriteWidth(OryUITextfieldCollection[editYourFollowRequestsSearch].sprContainer)) + "," + str(GetSpriteHeight(OryUITextfieldCollection[editYourFollowRequestsSearch].sprActivationIndicator)) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:50")
		endif
		elementY# = elementY# + GetSpriteHeight(sprYourFollowRequestsSearchBar)
	else
		OryUIUpdateSprite(sprYourFollowRequestsSearchBar, "position:-1000,-1000")
		OryUIUpdateTextfield(editYourFollowRequestsSearch, "position:-1000,-1000")
		elementY# = elementY# + 2
	endif

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// SORT FOLLOW REQUESTS
	if (redrawScreen = 1 or len(OryUIGetTextFieldString(editYourFollowRequestsSearch)) <> lastYourFollowRequestsSearchLength)
		lastYourFollowRequestsSearchLength = len(OryUIGetTextFieldString(editYourFollowRequestsSearch))
		SortYourFollowRequests(OryUIGetTextfieldString(editYourFollowRequestsSearch))
	endif

	// NO FOLLOW REQUESTS
	if (yourFriends.pendingByYou.length = -1 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations") = 0)
		OryUIUpdateText(txtYourNoFollowRequestsLine1, "text:No Follow Requests;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtYourNoFollowRequestsLine2, "text:" + OryUIWrapText("When people ask to follow you, they will be listed here", 2.6, 94) + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		if (filterCount = 0 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetYourRelations") = 0)
			OryUIUpdateText(txtYourNoFollowRequestsLine1, "text:No Users Found;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtYourNoFollowRequestsLine2, "text:Try refining your search;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtYourNoFollowRequestsLine1, "position:-1000,-1000")
			OryUIUpdateText(txtYourNoFollowRequestsLine2, "position:-1000,-1000")
		endif
	endif
	
	// FOLLOW REQUESTS LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listYourFollowRequests, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listYourFollowRequests, maxListItemCount)
		else
			OryUISetListItemCount(listYourFollowRequests, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listYourFollowRequests, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listYourFollowRequests)
	for i = 0 to maxListItemCount - 1
		if (i <= OryUIGetListItemCount(listYourFollowRequests) - 1)
			if (yourFriends.pendingByYou.length >= 0)
				sortedIteration = yourFriends.pendingByYouSorted[i + iterationOffset].iteration
				
				mainRoleLevel$ = ""
				if (yourFriends.pendingByYou[sortedIteration].mainRole = 1)
					if (yourFriends.pendingByYou[sortedIteration].keyholderLevel = 1) then mainRoleLevel$ = "Novice Keyholder"
					if (yourFriends.pendingByYou[sortedIteration].keyholderLevel = 2) then mainRoleLevel$ = "Keyholder"
					if (yourFriends.pendingByYou[sortedIteration].keyholderLevel = 3) then mainRoleLevel$ = "Established Keyholder"
					if (yourFriends.pendingByYou[sortedIteration].keyholderLevel = 4) then mainRoleLevel$ = "Distinguished Keyholder"
					if (yourFriends.pendingByYou[sortedIteration].keyholderLevel = 5) then mainRoleLevel$ = "Renowned Keyholder"
					mainRoleColour = roleColours.keyholder[yourFriends.pendingByYou[sortedIteration].keyholderLevel]
				endif
				if (yourFriends.pendingByYou[sortedIteration].mainRole = 2)
					if (yourFriends.pendingByYou[sortedIteration].lockeeLevel = 1) then mainRoleLevel$ = "Novice Lockee"
					if (yourFriends.pendingByYou[sortedIteration].lockeeLevel = 2) then mainRoleLevel$ = "Intermediate Lockee"
					if (yourFriends.pendingByYou[sortedIteration].lockeeLevel = 3) then mainRoleLevel$ = "Experienced Lockee"
					if (yourFriends.pendingByYou[sortedIteration].lockeeLevel = 4) then mainRoleLevel$ = "Devoted Lockee"
					mainRoleColour = roleColours.lockee[yourFriends.pendingByYou[sortedIteration].lockeeLevel]
				endif
				if (mainRoleLevel$ <> "")
					OryUIUpdateListItem(listYourFollowRequests, i, "noOfLeftLines:2;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + yourFriends.pendingByYou[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";leftLine2Text:" + mainRoleLevel$ + ";leftLine2TextSize:2.4;leftLine2TextColorID:" + str(mainRoleColour) + ";rightIcon:Cancel")
				else
					OryUIUpdateListItem(listYourFollowRequests, i, "noOfLeftLines:1;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftLine1Text:" + yourFriends.pendingByYou[sortedIteration].username$ + ";leftLine1TextSize:2.8;leftLine1TextColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIcon:Cancel")
				endif
				
				if (GetSpriteY(OryUIListCollection[listYourFollowRequests].sprItemContainer[i]) >= GetViewOffsetY() and GetSpriteY(OryUIListCollection[listYourFollowRequests].sprItemContainer[i]) <= GetViewOffsetY() + GetScreenBoundsBottom())
					OryUIUpdateListItemRightButton(listYourFollowRequests, i, "text:Confirm;textSize:2.5;size:22,3.2;colorID:" + str(theme[themeSelected].color[3]))
					if (OryUIGetListItemRightButtonReleased(listYourFollowRequests) = i)
						AcceptFollowRequest(yourFriends.pendingByYou[sortedIteration].id, 1)
					elseif (OryUIGetListItemRightIconReleased(listYourFollowRequests) = i)
						DeclineFollowRequest(yourFriends.pendingByYou[sortedIteration].id, 1)
					elseif (OryUIGetSpriteReleased() = OryUIListCollection[listYourFollowRequests].sprItemContainer[i])
						GetProfileData(yourFriends.pendingByYou[sortedIteration].id, 1)
						lastScreenViewed = constYourFollowRequestsListScreen
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
