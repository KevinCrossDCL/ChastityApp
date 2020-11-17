
OryUIHideFloatingActionButton(fabSaveAPIProjectSettings)
if (screenToView = constAPIProjectSettingsScreen)
	// RESET OPTIONS WHEN FIRST COMING TO THE SCREEN
	if (screenNo <> constAPIProjectSettingsScreen)
		if (showAPIProject = -1)
			apiName$ as string : apiName$ = ""
			apiNameOriginal$ as string : apiNameOriginal$ = apiName$
			OryUIUpdateTextfield(editBoxAPIProjectName, "inputText:" + apiName$ + ";")
			apiDontKnow as integer : apiDontKnow = 0
			apiDontKnowOriginal as integer : apiDontKnowOriginal = apiDontKnow
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiMobileApp as integer : apiMobileApp = 0
			apiMobileAppOriginal as integer : apiMobileAppOriginal = apiMobileApp
			OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxUncheckedImage))
			apiDesktopApp as integer : apiDesktopApp = 0
			apiDesktopAppOriginal as integer : apiDesktopAppOriginal = apiDesktopApp
			OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxUncheckedImage))
			apiWebsite as integer : apiWebsite = 0
			apiWebsiteOriginal as integer : apiWebsiteOriginal = apiWebsite
			OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxUncheckedImage))
			apiBot as integer : apiBot = 0
			apiBotOriginal as integer : apiBotOriginal = apiBot
			OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxUncheckedImage))
			apiLockBox as integer : apiLockBox = 0
			apiLockBoxOriginal as integer : apiLockBoxOriginal = apiLockBox
			OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxUncheckedImage))
			apiSomethingElse as integer : apiSomethingElse = 0
			apiSomethingElseOriginal as integer : apiSomethingElseOriginal = apiSomethingElse
			OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxUncheckedImage))
			apiClientID$ as string : apiClientID$ = ""
			apiClientIDOriginal$ as string : apiClientIDOriginal$ = apiClientID$
			apiClientSecret$ as string : apiClientSecret$ = ""
			apiClientSecretOriginal$ as string : apiClientSecretOriginal$ = apiClientSecret$
		endif
		if (showAPIProject >= 0)
			if (apiProjects.length >= showAPIProject)
				apiName$ = apiProjects[showAPIProject].name$
				apiNameOriginal$ = apiName$
				apiDontKnow = apiProjects[showAPIProject].dontKnow
				apiDontKnowOriginal = apiDontKnow
				if (apiDontKnow = 0)
					OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiMobileApp = apiProjects[showAPIProject].mobileApp
				apiMobileAppOriginal = apiMobileApp
				if (apiMobileApp = 0)
					OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiDesktopApp = apiProjects[showAPIProject].desktopApp
				apiDesktopAppOriginal = apiDesktopApp
				if (apiDesktopApp = 0)
					OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiWebsite = apiProjects[showAPIProject].website
				apiWebsiteOriginal = apiWebsite
				if (apiWebsite = 0)
					OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiBot = apiProjects[showAPIProject].bot
				apiBotOriginal = apiBot
				if (apiBot = 0)
					OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiLockBox = apiProjects[showAPIProject].lockBox
				apiLockBoxOriginal = apiLockBox
				if (apiLockBox = 0)
					OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiSomethingElse = apiProjects[showAPIProject].somethingElse
				apiSomethingElseOriginal = apiSomethingElse
				if (apiSomethingElse = 0)
					OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxUncheckedImage))
				else
					OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxCheckedImage))
				endif
				apiClientID$ = apiProjects[showAPIProject].clientID$
				apiClientIDOriginal$ = apiClientID$
				apiClientSecret$ = apiProjects[showAPIProject].clientSecret$
				apiClientSecretOriginal$ = apiClientSecret$
			endif
		endif
	endif
	
	screenNo = constAPIProjectSettingsScreen

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
	elementY# = elementY# + 2

	// PROJECT NAME
	if (redrawScreen = 1)
		OryUIUpdateTextfield(editBoxAPIProjectName, "inputText:" + apiName$ + ";position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:30;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
	endif
	OryUIInsertTextFieldListener(editBoxAPIProjectName)
	if (OryUIGetTextfieldTrailingIconReleased(editBoxAPIProjectName))
		OryUISetTextfieldString(editBoxAPIProjectName, "")
		SetEditBoxFocus(OryUITextfieldCollection[editBoxAPIProjectName].editBox, 0)
	endif
	if (OryUIGetTextfieldString(editBoxAPIProjectName) <> apiNameOriginal$)
		OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	endif
	elementY# = elementY# + OryUIGetTextfieldHeight(editBoxAPIProjectName) + 2

	// WHAT ARE YOU BUILDING?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdWhatAreYouBuilding, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdWhatAreYouBuilding)
	if (redrawScreen = 1)
		if (apiDontKnow = 0)
			OryUIUpdateSprite(chkBoxDontKnow, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxDontKnow, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxDontKnow, chkBoxDontKnow, 2, 0)
		OryUIUpdateText(txtChkBoxDontKnow, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxDontKnow)
	if (OryUIGetSpriteReleased() = chkBoxDontKnow)
		if (GetSpriteImageID(chkBoxDontKnow) = oryUICheckboxUncheckedImage)
			apiDontKnow = 1
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxCheckedImage))
			apiMobileApp = 0
			OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxUncheckedImage))
			apiDesktopApp = 0
			OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxUncheckedImage))
			apiWebsite = 0
			OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxUncheckedImage))
			apiBot = 0
			OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxUncheckedImage))
			apiLockBox = 0
			OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxUncheckedImage))
			apiSomethingElse = 0
			OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxUncheckedImage))
		else
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiMobileApp <> apiMobileAppOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	
	if (redrawScreen = 1)
		if (apiMobileApp = 0)
			OryUIUpdateSprite(chkBoxMobileApp, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxMobileApp, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxMobileApp, chkBoxMobileApp, 2, 0)
		OryUIUpdateText(txtChkBoxMobileApp, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxMobileApp)
	if (OryUIGetSpriteReleased() = chkBoxMobileApp)
		if (GetSpriteImageID(chkBoxMobileApp) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiMobileApp = 1
			OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiMobileApp = 0
			OryUIUpdateSprite(chkBoxMobileApp, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiMobileApp <> apiMobileAppOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	if (redrawScreen = 1)
		if (apiDesktopApp = 0)
			OryUIUpdateSprite(chkBoxDesktopApp, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxDesktopApp, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxDesktopApp, chkBoxDesktopApp, 2, 0)
		OryUIUpdateText(txtChkBoxDesktopApp, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxDesktopApp)
	if (OryUIGetSpriteReleased() = chkBoxDesktopApp)
		if (GetSpriteImageID(chkBoxDesktopApp) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiDesktopApp = 1
			OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiDesktopApp = 0
			OryUIUpdateSprite(chkBoxDesktopApp, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiDesktopApp <> apiDesktopAppOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	if (redrawScreen = 1)
		if (apiWebsite = 0)
			OryUIUpdateSprite(chkBoxWebsite, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxWebsite, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxWebsite, chkBoxWebsite, 2, 0)
		OryUIUpdateText(txtChkBoxWebsite, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxWebsite)
	if (OryUIGetSpriteReleased() = chkBoxWebsite)
		if (GetSpriteImageID(chkBoxWebsite) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiWebsite = 1
			OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiWebsite = 0
			OryUIUpdateSprite(chkBoxWebsite, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiWebsite <> apiWebsiteOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	if (redrawScreen = 1)
		if (apiBot = 0)
			OryUIUpdateSprite(chkBoxBot, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxBot, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxBot, chkBoxBot, 2, 0)
		OryUIUpdateText(txtChkBoxBot, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxBot)
	if (OryUIGetSpriteReleased() = chkBoxBot)
		if (GetSpriteImageID(chkBoxBot) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiBot = 1
			OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiBot = 0
			OryUIUpdateSprite(chkBoxBot, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiBot <> apiBotOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	if (redrawScreen = 1)
		if (apiLockBox = 0)
			OryUIUpdateSprite(chkBoxLockBox, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxLockBox, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxLockBox, chkBoxLockBox, 2, 0)
		OryUIUpdateText(txtChkBoxLockBox, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxLockBox)
	if (OryUIGetSpriteReleased() = chkBoxLockBox)
		if (GetSpriteImageID(chkBoxLockBox) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiLockBox = 1
			OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiLockBox = 0
			OryUIUpdateSprite(chkBoxLockBox, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiLockBox <> apiLockBoxOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	if (redrawScreen = 1)
		if (apiSomethingElse = 0)
			OryUIUpdateSprite(chkBoxSomethingElse, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxUncheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateSprite(chkBoxSomethingElse, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";image:" + str(oryUICheckboxCheckedImage) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIPinTextToCentreRightOfSprite(txtChkBoxSomethingElse, chkBoxSomethingElse, 2, 0)
		OryUIUpdateText(txtChkBoxSomethingElse, "alignment:left;colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetSpriteHeight(chkBoxSomethingElse)
	if (OryUIGetSpriteReleased() = chkBoxSomethingElse)
		if (GetSpriteImageID(chkBoxSomethingElse) = oryUICheckboxUncheckedImage)
			apiDontKnow = 0
			OryUIUpdateSprite(chkBoxDontKnow, "image:" + str(oryUICheckboxUncheckedImage))
			apiSomethingElse = 1
			OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxCheckedImage))
		else
			apiSomethingElse = 0
			OryUIUpdateSprite(chkBoxSomethingElse, "image:" + str(oryUICheckboxUncheckedImage))
		endif
	endif
	if (apiSomethingElse <> apiSomethingElseOriginal) then OryUIShowFloatingActionButton(fabSaveAPIProjectSettings)
	
	// CLIENT ID
	if (apiClientID$ <> "")
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdClientID, "supportingText:" + apiClientID$ + ";supportingTextBold:false;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdClientID)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnCopyClientID, "position:" + str((screenNo * 100) + 40) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		if (OryUIGetButtonReleased(btnCopyClientID))
			SetClipboardText(apiClientID$)
			OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
			OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnCopyClientID) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdClientID, "position:-1000,-1000")
			OryUIUpdateButton(btnCopyClientID, "position:-1000,-1000")
		endif
		elementY# = elementY# + 1
	endif
	
	// CLIENT SECRET
	if (apiClientSecret$ <> "")
		if (redrawScreen = 1)
			apiClientSecretVisible as integer : apiClientSecretVisible = 0
		endif
		if (apiClientSecretVisible = 0)
			OryUIUpdateTextCard(crdClientSecret, "supportingText:********************************;supportingTextBold:false;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateButton(btnShowClientSecret, "text:Show")
		else
			OryUIUpdateTextCard(crdClientSecret, "supportingText:" + apiClientSecret$ + ";supportingTextBold:false;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateButton(btnShowClientSecret, "text:Hide")
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdClientSecret)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnShowClientSecret, "position:" + str((screenNo * 100) + 18) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		if (OryUIGetButtonReleased(btnShowClientSecret))
			if (apiClientSecretVisible = 0)
				apiClientSecretVisible = 1
			else
				apiClientSecretVisible = 0
			endif
		endif
		if (redrawScreen = 1)
			OryUIUpdateButton(btnCopyClientSecret, "position:" + str((screenNo * 100) + 40) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		if (OryUIGetButtonReleased(btnCopyClientSecret))
			SetClipboardText(apiClientSecret$)
			OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
			OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		endif
		if (redrawScreen = 1)
			OryUIUpdateButton(btnResetClientSecret, "position:" + str((screenNo * 100) + 62) + "," + str(elementY#) + ";color:192,57,42,255;textColor:255,255,255,255")
		endif
		if (OryUIGetButtonReleased(btnResetClientSecret))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reset Client Secret?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Resetting your client secret will invalidate all existing integrations and refresh tokens, and should only be done when you suspect that your client secret has been compromised." + chr(10) + chr(10) + "Resetting your client secret is permanent and cannot be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ResetClientSecret;text:Reset;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "ResetClientSecret"))
			ResetAPIClientSecret(showAPIProject, 1)
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnShowClientSecret) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdClientSecret, "position:-1000,-1000")
			OryUIUpdateButton(btnShowClientSecret, "position:-1000,-1000")
			OryUIUpdateButton(btnCopyClientSecret, "position:-1000,-1000")
			OryUIUpdateButton(btnResetClientSecret, "position:-1000,-1000")
		endif
		elementY# = elementY# + 1
	endif
	
	// DELETE PROJECT BUTTON
	if (showAPIProject >= 0)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnDeleteAPIProject, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 4) + ";color:192,57,42,255;textColor:255,255,255,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnDeleteAPIProject) + 6
		if (OryUIGetButtonReleased(btnDeleteAPIProject))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Delete API Project?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to delete this API project? Deleting it will invalidate all existing integrations, and should only be done when you no longer want to manage this project." + chr(10) + chr(10) + "Deleting it is permanent and cannot be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeleteAPIProject;text:Delete;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
		if (OryUIGetDialogButtonReleasedByName(dialog, "DeleteAPIProject"))
			DeleteAPIProject(showAPIProject, 1)
		endif
	endif

	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveAPIProjectSettings, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	// SAVE BUTTON
	if (OryUIGetFloatingActionButtonReleased(fabSaveAPIProjectSettings))
		apiNameValid as integer : apiNameValid = 0
		if (StripString(OryUIGetTextfieldString(editBoxAPIProjectName), "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _-'!") <> "")
			newAPIName$ as string : newAPIName$ = ""
			for i = 1 to len(OryUIGetTextfieldString(editBoxAPIProjectName))
				if (FindString("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _-'!", mid(OryUIGetTextfieldString(editBoxAPIProjectName), i, 1)) > 0)
					newAPIName$ = newAPIName$ + mid(OryUIGetTextfieldString(editBoxAPIProjectName), i, 1)
				endif
			next
			OryUIUpdateTextfield(editBoxAPIProjectName, "inputText:" + newAPIName$)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Project Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:API project names should only contain certain characters." + chr(10) + chr(10) + "For your convenience all invalid characters have been removed.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (len(OryUIGetTextfieldString(editBoxAPIProjectName)) = 0)
			OryUIUpdateTextfield(editBoxAPIProjectName, "inputText:" + apiNameOriginal$)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Project Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:API project names can not be blank.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (len(OryUIGetTextfieldString(editBoxAPIProjectName)) < 4)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Project Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:API project names should be longer than 3 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (len(OryUIGetTextfieldString(editBoxAPIProjectName)) > 30)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Project Name;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:API project names should be less than 30 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			newAPIName$ = OryUIGetTextfieldString(editBoxAPIProjectName)
			apiNameValid = 1
		endif
		if (apiNameValid = 1)
			if (showAPIProject = -1)
				newAPIProject.bot = apiBot
				newAPIProject.desktopApp = apiDesktopApp
				newAPIProject.dontKnow = apiDontKnow
				newAPIProject.lockBox = apiLockBox
				newAPIProject.mobileApp = apiMobileApp
				newAPIProject.name$ = newAPIName$
				newAPIProject.somethingElse = apiSomethingElse
				newAPIProject.website = apiWebsite
				AddNewAPIProject(1)
			endif
			if (showAPIProject >= 0)
				apiProjects[showAPIProject].bot = apiBot
				apiProjects[showAPIProject].desktopApp = apiDesktopApp
				apiProjects[showAPIProject].dontKnow = apiDontKnow
				apiProjects[showAPIProject].lockBox = apiLockBox
				apiProjects[showAPIProject].mobileApp = apiMobileApp
				apiProjects[showAPIProject].name$ = newAPIName$
				apiProjects[showAPIProject].somethingElse = apiSomethingElse
				apiProjects[showAPIProject].website = apiWebsite
				apiBotOriginal = apiBot
				apiDesktopAppOriginal = apiDesktopApp
				apiDontKnowOriginal = apiDontKnow
				apiLockBoxOriginal = apiLockBox
				apiMobileAppOriginal = apiMobileApp
				apiNameOriginal$ = newAPIName$
				apiSomethingElseOriginal = apiSomethingElse
				apiWebsiteOriginal = apiWebsite
				UpdateAPIProject(showAPIProject, 1)
			endif
		endif
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
		OryUIHideFloatingActionButton(fabSaveAPIProjectSettings)
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
