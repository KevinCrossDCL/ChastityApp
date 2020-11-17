
if (screenToView = constSetCombinationScreen)
	screenNo = constSetCombinationScreen
	SetLastScreenViewed(selectedNewLockTab)

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
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	startScrollBarY# = elementY# - 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// INSTRUCTIONS
	if (redrawScreen = 1)
		OryUIUpdateText(txtSetCombinationScreenParagraph[1], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[1]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtSetCombinationScreenParagraph[2], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";color:192,57,43,255")
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[2]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtSetCombinationScreenParagraph[3], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[3]) + 2
	if (redrawScreen = 1)
		longestCombination$ as string : longestCombination$ = ""
		for i = 1 to noOfDigits
			longestCombination$ = longestCombination$ + "W"
		next
		OryUIUpdateText(txtSetCombinationScreenParagraph[4], "size:9;text:" + longestCombination$ + ";position:-1000,-1000")
		while (GetTextTotalWidth(txtSetCombinationScreenParagraph[4]) > 80)
			OryUIUpdateText(txtSetCombinationScreenParagraph[4], "size:" + str(GetTextSize(txtSetCombinationScreenParagraph[4]) - 0.1))
		endwhile
		OryUIUpdateText(txtSetCombinationScreenParagraph[4], "text:" + generatedCombination$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,43,255")
		OryUIUpdateButton(btnRegenerateCombination, "size:-1," + str((GetTextSize(txtSetCombinationScreenParagraph[4]) / 9.0) * 5.0) + ";position:" + str((screenNo * 100) + 92) + "," + str(GetTextY(txtSetCombinationScreenParagraph[4]) + (GetTextTotalHeight(txtSetCombinationScreenParagraph[4]) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif	
	if (OryUIGetButtonReleased(btnRegenerateCombination))
		for i = 1 to 8
			GenerateCombination(noOfDigits, 1)
			OryUIUpdateText(txtSetCombinationScreenParagraph[4], "text:" + generatedCombination$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,43,255")
			Sync()
		next
	endif
	if (GetTextHitTest(txtSetCombinationScreenParagraph[4], ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) and oryUIScrimVisible = 0)
		OryUIUpdateButton(btnCopyText, "position:" + str((screenNo * 100) + 50) + "," + str(GetTextY(txtSetCombinationScreenParagraph[4]) - 2))
		timeShownBtnCopyText# = timer()
	endif
	if (OryUIGetButtonReleased(btnCopyText))
		SetClipboardText(GetTextString(txtSetCombinationScreenParagraph[4]))
		OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
		OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
		OryUIShowTooltip(tooltip, (screenNo * 100) + 50, GetViewOffsetY() + screenBoundsTop# + 80)
	elseif (OryUIGetSpriteReleased() = screen[screenNo].sprPage)
		OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[4]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtSetCombinationScreenParagraph[5], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[5]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtSetCombinationScreenParagraph[6], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";color:192,57,43,255")
	endif
	elementY# = elementY# + GetTextTotalHeight(txtSetCombinationScreenParagraph[6]) + 2

	// NEXT BUTTON
	if (redrawScreen = 1)
		OryUIUpdateButton(screen[screenNo].btnNext, "enabled:false;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	if (timestampNow > 1500000000)
		OryUIUpdateButton(screen[screenNo].btnNext, "enabled:true;colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	else
		GetServerVariables(1)
		OryUIUpdateButton(screen[screenNo].btnNext, "enabled:false;colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor) + ";textColor:128,128,128,255")
		offline = 1
	endif
	if (OryUIGetButtonReleased(screen[screenNo].btnNext))
		if (noOfDigits = 0 or generatedCombination$ = "")
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Combination Error;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There seems to be a problem with the combination for this lock. If you've just set your lockbox or safe with one that's shown above please unlock it and go back a screen, and come back to have the app generate a new combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			lockGroupID = 0
			ClearBreadcrumbs()
			SetScreenToView(constCreateLocksScreen)
		endif
	endif
	elementY# = elementY# + OryUIGetButtonHeight(screen[screenNo].btnNext) + 4

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
