
if (screenToView = constSharedLocksDeletedScreen)
	if (screenNo <> constSharedLocksDeletedScreen)
		
	endif
	screenNo = constSharedLocksDeletedScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// JUMP TO LAST VIEW OFFSET Y WHEN RETURNING TO THIS SCREEN
//~	if (screen[screenNo].lastViewY# > screenBoundsTop#)
//~		SetViewOffset(GetViewOffsetX(), screen[screenNo].lastViewY#)
//~		screen[screenNo].lastViewY# = screenBoundsTop#
//~	endif
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:Deleted Locks" + chr(10) + "Last 30 Days;position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetSharedLocksDeleted(1)
		SetScreenToView(constSharedLocksDeletedScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2
	
	startScrollBarY# = elementY# - 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetSharedLocksDeleted(1)
		SetScreenToView(constSharedLocksDeletedScreen)
	endif

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";alpha:0")
	endif

	// NO SHARED LOCKS DELETED
	if (redrawScreen = 1)
		filterCount = locksDeleted.sharedLocks.length + 1
		if (filterCount = 0 and OryUIFindNameInHTTPSQueue(httpsQueue, "GetSharedLocksDeleted") = 0)
			OryUIUpdateText(txtNoSharedLocksDeleted, "text:No Deleted Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoSharedLocksDeleted, "position:-1000,-1000")
		endif
	endif
	
	// LOCKS
	if (redrawScreen = 1)
		for i = 1 to 11
			DestroyItemsInSharedLockDeletedCard(i)
			CreateItemsInSharedLockDeletedCard(i)
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
			
				UpdateItemsInSharedLockDeletedCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(screen[screenNo].dialog)
					OryUIInsertDialogListener(lockDeletedCard[i].dialog)
	
					if (OryUIGetSwipingVertically() = 0)
						
						
						// RESTORE / RESTART
						if (OryUIGetButtonReleased(lockDeletedCard[i].rightButton))
							OryUIUpdateDialog(lockDeletedCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Restore Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Restoring this lock will continue where it left off before it was deleted. All settings, including the combination will remain the same.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(lockDeletedCard[i].dialog, 2)
							OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RestoreLock;text:Restore Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(lockDeletedCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(lockDeletedCard[i].dialog)
						endif
						
						if (OryUIGetDialogButtonReleasedByName(lockDeletedCard[i].dialog, "RestoreLock"))
							RestoreDeletedSharedLock(sortedIteration, 1)
						endif
						
					endif
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * filterCount) - 2
	endif
	
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
