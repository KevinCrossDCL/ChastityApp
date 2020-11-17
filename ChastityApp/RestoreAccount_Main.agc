
if (screenToView = constRestoreAccountScreen)
	screenNo = constRestoreAccountScreen
	SetLastScreenViewed(selectedLocksTab)
	
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
		OryUIUpdateText(txtRestoreScreenParagraph[1], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtRestoreScreenParagraph[1]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtRestoreScreenParagraph[2], "text:" + userID$ + ";size:5;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,43,255")
		while (GetTextTotalWidth(txtRestoreScreenParagraph[2]) > 90)
			OryUIUpdateText(txtRestoreScreenParagraph[2], "text:" + userID$ + ";size:" + str(GetTextSize(txtRestoreScreenParagraph[2]) - 0.1))
		endwhile
	endif
	if (GetTextHitTest(txtRestoreScreenParagraph[2], ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) and oryUIScrimVisible = 0)
		OryUIUpdateButton(btnCopyText, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# - 2))
		timeShownBtnCopyText# = timer()
	endif
	if (OryUIGetButtonReleased(btnCopyText))
		SetClipboardText(GetTextString(txtRestoreScreenParagraph[2]))
		OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
		OryUIShowTooltip(tooltipCopiedUserID, (screenNo * 100) + 50, GetViewOffsetY() + screenBoundsTop# + 80)
	elseif (OryUIGetSpriteReleased() = screen[screenNo].sprPage)
		OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
	endif
	OryUIAnimateTooltip(tooltipCopiedUserID)
	elementY# = elementY# + GetTextTotalHeight(txtRestoreScreenParagraph[2]) + 2
	if (redrawScreen = 1)
		OryUIUpdateText(txtRestoreScreenParagraph[3], "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtRestoreScreenParagraph[3]) + 2
	
	// ENTER USER ID
	if (redrawScreen = 1)
		OryUIUpdateText(txtRestoreScreenParagraph[4], "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtRestoreScreenParagraph[4]) + 2
	if (redrawScreen = 1)
		OryUIUpdateTextfield(editBoxEnterUserID, "inputText:;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:24;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";helperTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
		OryUIUpdateText(OryUITextfieldCollection[editBoxEnterUserID].txtHelper, "alpha:150")
	endif
	pasteButtons = 0
	if (GetClipboardText() <> "") then inc pasteButtons
	if (GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "") then inc pasteButtons
	if (oryUIScrimVisible = 1) then pasteButtons = 0 // or OryUIGetTextfieldHasFocus(editBoxEnterUserID) = 0) then pasteButtons = 0
	if (pasteButtons = 1)
		if (GetClipboardText() <> "")
			OryUIUpdateButton(btnPasteText, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
			OryUIUpdateButton(btnCloudText, "position:-1000,-1000")
		elseif (GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "")
			OryUIUpdateButton(btnPasteText, "position:-1000,-1000")
			OryUIUpdateButton(btnCloudText, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
		endif
	elseif (pasteButtons = 2)
		OryUIUpdateButton(btnPasteText, "position:" + str((screenNo * 100) + 45) + "," + str(elementY#))
		OryUIUpdateButton(btnCloudText, "position:" + str((screenNo * 100) + 55) + "," + str(elementY#))	
	else
		OryUIUpdateButton(btnPasteText, "position:-1000,-1000")
		OryUIUpdateButton(btnCloudText, "position:-1000,-1000")	
	endif
	if (OryUIGetButtonReleased(btnPasteText)) // and GetClipboardText() <> "")
		OryUIUpdateTextfield(editBoxEnterUserID, "inputText:" + upper(GetClipboardText()))
	elseif (OryUIGetButtonReleased(btnCloudText)) // and GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "")
		OryUIUpdateTextfield(editBoxEnterUserID, "inputText:" + upper(GetCloudDataVariable(lower(constAppName$) + ".userID", "")))
	endif
	OryUIInsertTextFieldListener(editBoxEnterUserID)
	if (OryUIGetTextfieldTrailingIconReleased(editBoxEnterUserID))
		OryUISetTextfieldString(editBoxEnterUserID, "")
		SetEditBoxFocus(OryUITextfieldCollection[editBoxEnterUserID].editBox, 0)
	endif
	elementY# = elementY# + OryUIGetTextfieldHeight(editBoxEnterUserID) + 8.5 //4.5

	// RESTORE BUTTON
	OryUIUpdateButton(screen[screenNo].btnNext, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	if (OryUIGetButtonReleased(screen[screenNo].btnNext))
		restoreUserID$ = ""
		charCount = 0
		for i = 1 to len(OryUIGetTextfieldString(editBoxEnterUserID))
			tmpChar$ = mid(OryUIGetTextfieldString(editBoxEnterUserID), i, 1)
			if (FindString("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", tmpChar$) > 0)
				restoreUserID$ = restoreUserID$ + upper(tmpChar$)
				inc charCount
				if (charCount = 5 or charCount = 10 or charCount = 15)
					restoreUserID$ = restoreUserID$ + "-"
				endif
			endif
		next
		if (len(restoreUserID$) = 0)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Missing User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Please enter a user id to restore locks from a previous install.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (len(restoreUserID$) <> 23)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The user id you've entered is invalid. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			RestoreAccount(restoreUserID$, 1)
		endif
	endif
	elementY# = elementY# + OryUIGetButtonHeight(screen[screenNo].btnNext) - 1.5

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
	SetSpriteSize(screen[screenNo].sprPage, GetSpriteWidth(screen[screenNo].sprPage), elementY# - GetSpriteY(screen[screenNo].sprPage))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50 + (50 - OryUIGetTextfieldHeight(editBoxEnterUserID))
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)

	if (OryUIGetTextfieldHasFocus(editBoxEnterUserID))
		SetViewOffset(GetViewOffsetX(), GetTextY(txtRestoreScreenParagraph[4]) - GetScreenBoundsTop() - OryUIGetTopBarHeight(screen[screenNo].topBar) - 2)
	endif
	
	// SCROLL BAR
	if (redrawScreen = 1)
		if (oryUIBottomBannerAdOnScreen = 1) then trackHeightReduction# = 21
		if (oryUIBottomBannerAdOnScreen = 0) then trackHeightReduction# = 14
		trackBarHeight# = 100 - startScrollBarY# - trackHeightReduction#
		OryUIUpdateScrollBar(scrollBar, "contentSize:100," + str(maxScrollY# + 100 - trackHeightReduction#) + ";trackPosition:93," + str(startScrollBarY#) + ";trackSize:4.5," + str(trackBarHeight#) + ";invisibleGripSize:8.5,7;gripSize:4.5,5;gripColorID:" + str(theme[themeSelected].color[3]) + ";showGripIcon:true;gripIconSize:4,5;gripIconColor:255,255,255;trackColor:0,0,0,0")
	endif
endif
