
if (screenToView = constLockGeneratorResultsScreen)
	if (screenNo <> constLockGeneratorResultsScreen)
		filterLockGeneratorByLabel$ as string : filterLockGeneratorByLabel$ = ""
		sortLockGeneratorByLabel$ as string : sortLockGeneratorByLabel$ = ""
	endif
	screenNo = constLockGeneratorResultsScreen
	
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
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		keepLockGeneratorSettings = 1
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetGeneratedLocks(minMinutes, maxMinutes, regularity#, 1)
		SetScreenToView(constLockGeneratorResultsScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	filterCount = generatedLocks.length + 1
	
	// FILTER BAR
	OryUIUpdateSprite(sprFilterLockGeneratorBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	local drawInterval$ as string
	if (regularity# = 0) then drawInterval$ = ""
	if (regularity# = 0.25) then drawInterval$ = " (15 min. draws)"
	if (regularity# = 0.5) then drawInterval$ = " (30 min. draws)"
	if (regularity# = 1) then drawInterval$ = " (hourly draws)"
	if (regularity# = 3) then drawInterval$ = " (3 hour draws)"
	if (regularity# = 6) then drawInterval$ = " (6 hour draws)"
	if (regularity# = 12) then drawInterval$ = " (12 hour draws)"
	if (regularity# = 24) then drawInterval$ = " (Daily draws)"
	if (filterCount > 0)
		if (filterCount <> generatedLocks[0].noOfMatches)
			OryUIUpdateText(txtLockGeneratorQuery, "text:Approx. " + lower(ConvertMinutesRangeToText(minMinutes, maxMinutes)) + drawInterval$ + chr(10) + "Random " + str(filterCount) + " of " + str(generatedLocks[0].noOfMatches) + " results;colorID:" + str(colorMode[colorModeSelected].barIconColor))
		else	
			if (generatedLocks[0].noOfMatches = 1)
				OryUIUpdateText(txtLockGeneratorQuery, "text:Approx. " + lower(ConvertMinutesRangeToText(minMinutes, maxMinutes)) + drawInterval$ + chr(10) + str(generatedLocks[0].noOfMatches) + " result;colorID:" + str(colorMode[colorModeSelected].barIconColor))
			else
				OryUIUpdateText(txtLockGeneratorQuery, "text:Approx. " + lower(ConvertMinutesRangeToText(minMinutes, maxMinutes)) + drawInterval$ + chr(10) + str(generatedLocks[0].noOfMatches) + " results;colorID:" + str(colorMode[colorModeSelected].barIconColor))
			endif
		endif
	else
		OryUIUpdateText(txtLockGeneratorQuery, "text:Approx. " + lower(ConvertMinutesRangeToText(minMinutes, maxMinutes)) + drawInterval$ + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	endif	
	OryUIPinTextToCentreOfSprite(txtLockGeneratorQuery, sprFilterLockGeneratorBar, 0, 0)
	OryUIUpdateButton(btnLockGeneratorEditQuery, "colorID:" + str(theme[themeSelected].color[3]) + ";position:" + str(((screenNo * 100) + 95) - OryUIGetButtonWidth(btnLockGeneratorEditQuery)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterLockGeneratorBar) / 2)))
	if (OryUIGetButtonReleased(btnLockGeneratorEditQuery))
		keepLockGeneratorSettings = 1
		SetScreenToView(constLockGeneratorScreen)
	endif
	OryUIUpdateSprite(sprFilterLockGeneratorBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterLockGeneratorBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterLockGeneratorBar) + 2

	startScrollBarY# = elementY# - 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetGeneratedLocks(minMinutes, maxMinutes, regularity#, 1)
		SetScreenToView(constLockGeneratorResultsScreen)
	endif

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO GENERATED LOCKS
	if (filterCount = 0)
		OryUIUpdateText(txtNoGeneratedLocks, "text:No Matching Locks;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateText(txtNoGeneratedLocks, "position:-1000,-1000")
	endif

	// LOCKS
	if (redrawScreen = 1)
		for i = 1 to 11
			DestroyItemsInGeneratedLocksCard(i)
			CreateItemsInGeneratedLocksCard(i)
		next
	endif
	if (filterCount >= 0)
		fullCardHeight# = GetSpriteHeight(generatedLocksCard[1].sprBackground) + 2.0
		for i = 1 to 8
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(generatedLocksCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					elementY# = elementY# + GetSpriteHeight(generatedLocksCard[i].sprBackground) + 2
					generatedLocksCard[i].iteration = i
				endif
				if (GetSpriteY(generatedLocksCard[i].sprBackground) < GetViewOffsetY() - GetScreenBoundsTop() - fullCardHeight# and generatedLocksCard[i].iteration + 8 <= filterCount)
					generatedLocksCard[i].iteration = generatedLocksCard[i].iteration + 8
					OryUIUpdateSprite(generatedLocksCard[i].sprBackground, "y:" + str(GetSpriteY(generatedLocksCard[i].sprBackground) + (fullCardHeight# * 8)))
					repositionItemsInCard = 1
				elseif (GetSpriteY(generatedLocksCard[i].sprBackground) > GetViewOffsetY() + screenBoundsTop# + (fullCardHeight# * 8) and generatedLocksCard[i].iteration - 8 >= 1)
					generatedLocksCard[i].iteration = generatedLocksCard[i].iteration - 8
					OryUIUpdateSprite(generatedLocksCard[i].sprBackground, "y:" + str(GetSpriteY(generatedLocksCard[i].sprBackground) - (fullCardHeight# * 8)))
					repositionItemsInCard = 1
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = generatedLocksCard[i].iteration - 1
	
				if (GetSpriteInScreen(generatedLocksCard[i].sprBackground))
					lockInView = 1
				else
					lockInView = 0
				endif
			
				UpdateItemsInGeneratedLocksCard(i, sortedIteration, repositionItemsInCard)
				
				if (lockInView = 1)
					OryUIInsertDialogListener(screen[screenNo].dialog)
					OryUIInsertDialogListener(generatedLocksCard[i].dialog)
	
					if (OryUIGetSwipingVertically() = 0)
						// RESTORE / RESTART
						if (OryUIGetButtonReleased(generatedLocksCard[i].rightButton))
							// CREATE LOCK
							OryUIUpdateDialog(generatedLocksCard[i].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Create Lock?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to create a new lock from these settings?" + chr(10) + chr(10) + "You can change these and other settings on the next screen.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
							OryUISetDialogButtonCount(generatedLocksCard[i].dialog, 2)
							OryUIUpdateDialogButton(generatedLocksCard[i].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CreateLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIUpdateDialogButton(generatedLocksCard[i].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
							OryUIShowDialog(generatedLocksCard[i].dialog)
						endif
						
						if (OryUIGetDialogButtonReleasedByName(generatedLocksCard[i].dialog, "CreateLock"))
							generatedLockSelected = sortedIteration + 1
							previousBreadcrumb = GetPreviousBreadcrumb()
							RemoveLastBreadcrumb()
							if (noOfLocks = 20)
								selectedLockOptionsTab = 2
							else
								if (mainRoleSelected = 1)
									selectedLockOptionsTab = 2
								else
									selectedLockOptionsTab = 1
								endif
							endif
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
