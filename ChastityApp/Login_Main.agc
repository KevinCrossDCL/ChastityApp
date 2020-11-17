
OryUISetScreenZoomLimits(1, 1)

if (screenToView = constLoginScreen)
	screenNo = constLoginScreen

	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
	if ((GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		MinimizeApp()
	endif
	
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprLoginBackground, "position:" + str(screenNo * 100) + "," + str(elementY#))
		OryUIUpdateSprite(sprLoginAppLogo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + (GetSpriteHeight(sprLoginAppLogo) / 2) + 2))
	endif
	elementY# = GetSpriteY(sprLoginAppLogo) + GetSpriteHeight(sprLoginAppLogo) - 2
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprLoginAppTitle, "position:" + str(screenNo * 100) + "," + str(elementY#))
	endif
	elementY# = elementY# + GetSpriteHeight(sprLoginAppTitle) + 6
	
	// LOGIN USER ID
	if (redrawScreen = 1)
		OryUIUpdateTextfield(editBoxLoginUserID, "position:" + str((screenNo * 100) + 10) + "," + str(elementY#) + ";maxLength:24;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";helperTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[2].textfieldStrokeColor))
		OryUIUpdateText(OryUITextfieldCollection[editBoxLoginUserID].txtHelper, "color:255,255,255;alpha:150")
	endif
	pasteButtons as integer : pasteButtons = 0
	if (GetClipboardText() <> "") then inc pasteButtons
	if (GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "") then inc pasteButtons
	if (oryUIScrimVisible = 1) then pasteButtons = 0 // or OryUIGetTextfieldHasFocus(editBoxLoginUserID) = 0) then pasteButtons = 0
	if (pasteButtons = 1)
		if (GetClipboardText() <> "")
			OryUIUpdateButton(btnLoginPasteText, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
			OryUIUpdateButton(btnLoginCloudText, "position:-1000,-1000")
		elseif (GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "")
			OryUIUpdateButton(btnLoginPasteText, "position:-1000,-1000")
			OryUIUpdateButton(btnLoginCloudText, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
		endif
	elseif (pasteButtons = 2)
		OryUIUpdateButton(btnLoginPasteText, "position:" + str((screenNo * 100) + 45) + "," + str(elementY#))
		OryUIUpdateButton(btnLoginCloudText, "position:" + str((screenNo * 100) + 55) + "," + str(elementY#))	
	else
		OryUIUpdateButton(btnLoginPasteText, "position:-1000,-1000")
		OryUIUpdateButton(btnLoginCloudText, "position:-1000,-1000")	
	endif
	if (OryUIGetButtonReleased(btnLoginPasteText))
		OryUIUpdateTextfield(editBoxLoginUserID, "inputText:" + upper(GetClipboardText()))
	elseif (OryUIGetButtonReleased(btnLoginCloudText))
		OryUIUpdateTextfield(editBoxLoginUserID, "inputText:" + upper(GetCloudDataVariable(lower(constAppName$) + ".userID", "")))
	endif
	OryUIInsertTextFieldListener(editBoxLoginUserID)
	if (OryUIGetTextfieldTrailingIconReleased(editBoxLoginUserID))
		OryUISetTextfieldString(editBoxLoginUserID, "")
		SetEditBoxFocus(OryUITextfieldCollection[editBoxLoginUserID].editBox, 0)
	endif
	elementY# = elementY# + OryUIGetTextfieldHeight(editBoxLoginUserID) + 7.5
	
	// LOGIN BUTTON
	OryUIUpdateButton(btnLoginUserID, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	if (OryUIGetButtonReleased(btnLoginUserID))
		loginUserID$ as string : loginUserID$ = ""
		charCount as integer : charCount = 0
		tmpChar$ as string : tmpChar$ = ""
		for i = 1 to len(OryUIGetTextfieldString(editBoxLoginUserID))
			tmpChar$ = mid(OryUIGetTextfieldString(editBoxLoginUserID), i, 1)
			if (FindString("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", tmpChar$) > 0)
				loginUserID$ = loginUserID$ + upper(tmpChar$)
				inc charCount
				if (charCount = 5 or charCount = 10 or charCount = 15)
					loginUserID$ = loginUserID$ + "-"
				endif
			endif
		next
		if (len(loginUserID$) = 0)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Missing User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Please enter a user id to log in with.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (len(loginUserID$) <> 23)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The user id you've entered is invalid. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			CheckRestoreUserID(loginUserID$, 1)
		endif
	endif
	elementY# = 70

	// LOG IN WITH TEXT
	if (GetDeviceBaseName() = "android")
		if (redrawScreen = 1)
			OryUIUpdateText(txtLoginWith, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
			lineWidth# as float : lineWidth# = 40 - (GetTextTotalWidth(txtLoginWith) / 2.0) - 10
			OryUIUpdateSprite(sprLoginWithLeftLine, "size:" + str(lineWidth#) + ",0.1;position:" + str((screenNo * 100) + 15) + "," + str(GetTextY(txtLoginWith) + (GetTextTotalHeight(txtLoginWith) / 2.0) - 0.1))
			OryUIUpdateSprite(sprLoginWithRightLine, "size:" + str(lineWidth#) + ",0.1;position:" + str(((screenNo * 100) + 85) - lineWidth#) + "," + str(GetTextY(txtLoginWith) + (GetTextTotalHeight(txtLoginWith) / 2.0) - 0.1))
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateText(txtLoginWith, "position:-1000,-1000")
			OryUIUpdateSprite(sprLoginWithLeftLine, "position:-1000,-1000")
			OryUIUpdateSprite(sprLoginWithRightLine, "position:-1000,-1000")
		endif
	endif
	elementY# = elementY# + GetTextTotalHeight(txtLoginWith) + 2
	
	// LOG IN WITH SOCIAL ACCOUNTS
	if (GetDeviceBaseName() = "android")
		if (redrawScreen = 1)
			OryUIUpdateButton(btnLoginWithDiscord, "position:" + str(((screenNo * 100) + 50) - OryUIGetButtonWidth(btnLoginWithDiscord) - 2) + "," + str(elementY#))
			OryUIPinSpriteToCentreOfSprite(sprLoginWithDiscord, OryUIButtonCollection[btnLoginWithDiscord].sprContainer, 0, 0)
			OryUIUpdateButton(btnLoginWithTwitter, "position:" + str(((screenNo * 100) + 50) + 2) + "," + str(elementY#))
			OryUIPinSpriteToCentreOfSprite(sprLoginWithTwitter, OryUIButtonCollection[btnLoginWithTwitter].sprContainer, 0, 0)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateButton(btnLoginWithDiscord, "position:-1000,-1000")
			OryUIPinSpriteToCentreOfSprite(sprLoginWithDiscord, OryUIButtonCollection[btnLoginWithDiscord].sprContainer, 0, 0)
			OryUIUpdateButton(btnLoginWithTwitter, "position:-1000,-1000")
			OryUIPinSpriteToCentreOfSprite(sprLoginWithTwitter, OryUIButtonCollection[btnLoginWithTwitter].sprContainer, 0, 0)
		endif
	endif
	if (OryUIGetButtonReleased(btnLoginWithDiscord))
		urlUserID$ as string : urlUserID$ = "LOGIN-LOGIN-LOGIN-LOGIN"
		OpenBrowser("https://discordapp.com/oauth2/authorize?response_type=code&redirect_uri=" + constAppMarketingDomain$ + "/oauth2/discord/&scope=identify&state=" + urlUserID$ + "&client_id=" + constDiscordOAUTHClientID$)
	endif
	if (OryUIGetButtonReleased(btnLoginWithTwitter))
		urlUserID$ = "LOGIN-LOGIN-LOGIN-LOGIN"
		OpenBrowser(constAppMarketingDomain$ + "/oauth2/twitter/?state=" + urlUserID$)
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnLoginWithDiscord) + 4.5
	
	// NEW USER?
	if (redrawScreen = 1)
		OryUIUpdateText(txtNewUser, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtNewUser) + 0.5
	if (redrawScreen = 1)
		OryUIUpdateButton(btnNewUser, "position:" + str((screenNo * 100) + 20) + "," + str(elementY#))
	endif
	if (OryUIGetButtonReleased(btnNewUser))
		splashScreenStage$ = "Create New Account"
		SetScreenToView(constSplashScreen)
	endif
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, 0)
endif
