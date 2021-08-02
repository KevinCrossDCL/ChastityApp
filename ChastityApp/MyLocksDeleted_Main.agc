
if (screenToView = constMyLocksDeletedScreen)
	if (screenNo <> constMyLocksDeletedScreen)
		
	endif
	screenNo = constMyLocksDeletedScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:My Deleted Locks" + chr(10) + "Last 30 Days;position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetMyLocksDeleted(1)
		SetScreenToView(constMyLocksDeletedScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2
	
	startScrollBarY# = elementY# - 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetMyLocksDeleted(1)
		SetScreenToView(constMyLocksDeletedScreen)
	endif

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
	endif

	// NO MY LOCKS DELETED
	if (redrawScreen = 1)
		filterCount = locksDeleted.myLocks.length + 1
		if (filterCount = 0 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetMyLocksDeleted") = 0)
			OryUIUpdateText(txtNoMyLocksDeleted, "text:No Deleted Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoMyLocksDeleted, "position:-1000,-1000")
		endif
	endif
	
	// LOCKS
	if (redrawScreen = 1)
		for i = 1 to 11
			DestroyItemsInMyLockDeletedCard(i)
			CreateItemsInMyLockDeletedCard(i)
		next
	endif
	if (filterCount > 0)
		fullCardHeight# = GetSpriteHeight(lockDeletedCard[1].sprBackground) + 2.0
		for i = 1 to 8
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(lockDeletedCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					elementY# = elementY# + GetSpriteHeight(lockDeletedCard[i].sprBackground) + 2
					lockDeletedCard[i].iteration = i
				endif
				if (GetSpriteY(lockDeletedCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and lockDeletedCard[i].iteration + 8 <= filterCount)
					lockDeletedCard[i].iteration = lockDeletedCard[i].iteration + 8
					OryUIUpdateSprite(lockDeletedCard[i].sprBackground, "y:" + str(GetSpriteY(lockDeletedCard[i].sprBackground) + (fullCardHeight# * 8)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(lockDeletedCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 8) and lockDeletedCard[i].iteration - 8 >= 1)
					lockDeletedCard[i].iteration = lockDeletedCard[i].iteration - 8
					OryUIUpdateSprite(lockDeletedCard[i].sprBackground, "y:" + str(GetSpriteY(lockDeletedCard[i].sprBackground) - (fullCardHeight# * 8)))
					repositionItemsInCard = 1
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = lockDeletedCard[i].iteration - 1
				
				if (GetSpriteInScreen(lockDeletedCard[i].sprBackground))
					lockInView = 1
				else
					lockInView = 0
				endif
			
				UpdateItemsInMyLockDeletedCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(screen[screenNo].dialog)
					OryUIInsertDialogListener(lockDeletedCard[i].dialog)
	
					if (OryUIGetSwipingVertically() = 0)
						
						// VIEW KEYHOLDER PROFILE
						if (OryUIGetSpriteReleased() = lockDeletedCard[i].sprUsernameButton)
							GetProfileData(locksDeleted.myLocks[sortedIteration].keyholderID, 1)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constViewProfileScreen)
						endif
						
						// RESTORE / RESTART
						if (OryUIGetButtonReleased(lockDeletedCard[i].rightButton))
							if (locksDeleted.myLocks[sortedIteration].unlocked = 0 and timestampNow - locksDeleted.myLocks[sortedIteration].timestampDeleted <= 86400)
								// RESTORE LOCK
								if (noOfLocks = 20)
									OryUIUpdateDialog(lockDeletedCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Too Many Locks;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You currently have too many locks and so can not restore this one. Please delete any completed or test locks and try again when ready.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockDeletedCard[i].dialog, 1)
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockDeletedCard[i].dialog)
								else
									OryUIUpdateDialog(lockDeletedCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Restore Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Restoring this lock will continue where it left off before it was deleted. All settings, including the combination will remain the same.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockDeletedCard[i].dialog, 2)
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RestoreLock;text:Restore Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockDeletedCard[i].dialog)
								endif
							else
								// RELOAD LOCK
								if (noOfLocks = 20)
									OryUIUpdateDialog(lockDeletedCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Too Many Locks;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You currently have too many locks in your list of active locks and so can not reload this one. Please delete any completed or test locks and try again when ready.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockDeletedCard[i].dialog, 1)
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockDeletedCard[i].dialog)
								else
									OryUIUpdateDialog(lockDeletedCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reload Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This will reload and start a new lock with the settings the keyholder set up for this lock.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
									OryUISetDialogButtonCount(lockDeletedCard[i].dialog, 2)
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ReloadLock;text:Reload Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
									OryUIShowDialog(lockDeletedCard[i].dialog)
								endif
							endif
						endif
						
						if (OryUIGetDialogButtonReleasedByName(lockDeletedCard[i].dialog, "RestoreLock"))
							RestoreDeletedMyLock(sortedIteration)
						endif
						if (OryUIGetDialogButtonReleasedByName(lockDeletedCard[i].dialog, "ReloadLock"))
							sharedID$ = locksDeleted.myLocks[sortedIteration].sharedID$
							GetSharedLockInformation(sharedID$, 1)
							previousBreadcrumb = GetPreviousBreadcrumb()
							RemoveLastBreadcrumb()
							selectedLockOptionsTab = 2
							SetScreenToView(constLockOptionsScreen)
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
	if (contentHeightChanged = 1)
		OryUISetScrollBarContentSize(scrollBar, 100, maxScrollY# + 100 - trackHeightReduction#)
		contentHeightChanged = 0
	endif
endif
