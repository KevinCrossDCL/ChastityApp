
if (screenToView = constAboutScreen)
	if (screenNo <> constAboutScreen)
		if (imgAppLogo = 0) then imgAppLogo = LoadImage("AppLogo.png")
		if (imgMadeWithAppGameKit = 0) then imgMadeWithAppGameKit = LoadImage("MadeWithAppGameKit.png")
		if (imgFacebookIcon = 0) then imgFacebookIcon = LoadImage("FacebookIcon.png")
		if (imgTwitterIcon = 0) then imgTwitterIcon = LoadImage("TwitterIcon.png")
		if (imgDiscordIcon = 0) then imgDiscordIcon = LoadImage("DiscordIcon.png")
		if (imgGitHubIcon = 0) then imgGitHubIcon = LoadImage("GitHubIcon.png")
		if (imgEmailIcon = 0) then imgEmailIcon = LoadImage("EmailIcon.png")
	endif
	screenNo = constAboutScreen
	
	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
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
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = elementY# + 2
	
	// APP LOGO
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprAppLogo, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";image:" + str(imgAppLogo) + ";offset:" + str(GetSpriteWidth(sprAppLogo) / 2) + ",0")
	endif
	elementY# = elementY# + GetSpriteHeight(sprAppLogo) + 1
	
	// APP TITLE
	if (redrawScreen = 1)
		OryUIUpdateText(txtAppTitle, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtAppTitle) + 1
	
	// APP VERSION
	if (redrawScreen = 1)
		OryUIUpdateText(txtAppVersion, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtAppVersion) + 4
	
	// VERSION HISTORY
	if (redrawScreen = 1)
		OryUIUpdateButton(btnVersionHistory, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";enabledColorID:" + str(colorMode[colorModeSelected].pageColor) + ";enabledTextColorID:" + str(colorMode[colorModeSelected].urlColor))
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnVersionHistory) + 2
	if (OryUIGetButtonReleased(btnVersionHistory))
		OpenBrowser(constAppMarketingDomain$ + "/version-history")
	endif
	
	// PRIVACY POLICY
	if (redrawScreen = 1)
		OryUIUpdateButton(btnPrivacyPolicy, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";enabledColorID:" + str(colorMode[colorModeSelected].pageColor) + ";enabledTextColorID:" + str(colorMode[colorModeSelected].urlColor))
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnPrivacyPolicy) + 2
	if (OryUIGetButtonReleased(btnPrivacyPolicy))
		OpenBrowser(constAppMarketingDomain$ + "/privacy-policy")
	endif
	
	// TERMS & CONDITIONS
	if (redrawScreen = 1)
		OryUIUpdateButton(btnTermsAndConditions, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";enabledColorID:" + str(colorMode[colorModeSelected].pageColor) + ";enabledTextColorID:" + str(colorMode[colorModeSelected].urlColor))
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnTermsAndConditions) + 2
	if (OryUIGetButtonReleased(btnTermsAndConditions))
		OpenBrowser(constAppMarketingDomain$ + "/terms-conditions")
	endif
	
	// APP SERVER TIME TITLE
	if (redrawScreen = 1)
		OryUIUpdateText(txtAppServerTimeTitle, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtAppServerTimeTitle) + 1
	
	// APP SERVER TIME
	local appServerTime$ as string
	appServerTime$ = AddOrdinalSuffix(GetDaysFromUnix(timestampNow))
	if (GetMonthFromUnix(timestampNow) = 1) then appServerTime$ = appServerTime$ + " Jan"
	if (GetMonthFromUnix(timestampNow) = 2) then appServerTime$ = appServerTime$ + " Feb"
	if (GetMonthFromUnix(timestampNow) = 3) then appServerTime$ = appServerTime$ + " Mar"
	if (GetMonthFromUnix(timestampNow) = 4) then appServerTime$ = appServerTime$ + " Apr"
	if (GetMonthFromUnix(timestampNow) = 5) then appServerTime$ = appServerTime$ + " May"
	if (GetMonthFromUnix(timestampNow) = 6) then appServerTime$ = appServerTime$ + " Jun"
	if (GetMonthFromUnix(timestampNow) = 7) then appServerTime$ = appServerTime$ + " Jul"
	if (GetMonthFromUnix(timestampNow) = 8) then appServerTime$ = appServerTime$ + " Aug"
	if (GetMonthFromUnix(timestampNow) = 9) then appServerTime$ = appServerTime$ + " Sep"
	if (GetMonthFromUnix(timestampNow) = 10) then appServerTime$ = appServerTime$ + " Oct"
	if (GetMonthFromUnix(timestampNow) = 11) then appServerTime$ = appServerTime$ + " Nov"
	if (GetMonthFromUnix(timestampNow) = 12) then appServerTime$ = appServerTime$ + " Dec"
	appServerTime$ = appServerTime$ + " " + str(GetYearFromUnix(timestampNow))
	appServerTime$ = appServerTime$ + " " + AddLeadingZeros(str(GetHoursFromUnix(timestampNow)), 2)
	appServerTime$ = appServerTime$ + "[colon]" + AddLeadingZeros(str(GetMinutesFromUnix(timestampNow)), 2)
	appServerTime$ = appServerTime$ + "[colon]" + AddLeadingZeros(str(GetSecondsFromUnix(timestampNow)), 2)
	appServerTime$ = appServerTime$ + " UTC"	
	OryUIUpdateText(txtAppServerTime, "text:" + appServerTime$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elementY# = elementY# + GetTextTotalHeight(txtAppServerTime) + 4
	
	// MADE WITH APPGAMEKIT
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprMadeWithAppGameKit, "position:" + str((screenNo * 100) + 98 - GetSpriteWidth(sprMadeWithAppGameKit)) + "," + str((abs(screenBoundsTop#) + 99) - GetSpriteHeight(sprMadeWithAppGameKit)) + ";image:" + str(imgMadeWithAppGameKit))
	endif
	if (OryUIGetSpriteReleased() = sprMadeWithAppGameKit)
		OpenBrowser("https://appgamekit.com")
	endif
	
	// FOLLOW BUTTONS
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpFollowButtons, "position:" + str((screenNo * 100) + 50) + "," + str((abs(screenBoundsTop#) + 85)) + ";selectedColorID:" + str(colorMode[colorModeSelected].pageColor) + ";selectedIconColorID:" + str(colorMode[colorModeSelected].textColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].pageColor) + ";unselectedIconColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateButtonGroupItem(grpFollowButtons, 1, "name:Facebook;text: ;iconID:" + str(imgFacebookIcon))	
		OryUIUpdateButtonGroupItem(grpFollowButtons, 2, "name:Twitter;text: ;iconID:" + str(imgTwitterIcon))	
		OryUIUpdateButtonGroupItem(grpFollowButtons, 3, "name:Discord;text: ;iconID:" + str(imgDiscordIcon))	
		OryUIUpdateButtonGroupItem(grpFollowButtons, 4, "name:GitHub;text: ;iconID:" + str(imgGitHubIcon))	
		OryUIUpdateButtonGroupItem(grpFollowButtons, 5, "name:Email;text: ;iconID:" + str(imgEmailIcon))	
	endif
	OryUIInsertButtonGroupListener(grpFollowButtons)
	if (OryUIGetButtonGroupItemReleasedByName(grpFollowButtons, "Facebook"))
		OpenBrowser(constFollowFacebook$)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpFollowButtons, "Twitter"))
		OpenBrowser(constFollowTwitter$)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpFollowButtons, "Discord"))
		OpenBrowser(constFollowDiscord$)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpFollowButtons, "GitHub"))
		OpenBrowser(constFollowGitHub$)
	endif
	if (OryUIGetButtonGroupItemReleasedByName(grpFollowButtons, "Email"))
		OpenBrowser("mailto:" + constFollowEmail$ + "?subject=" + constAppName$ + " Feedback (v" + constVersionNumber$ + " - " + store$ + ")")
	endif
	
	// MAINTAINED BY ONE
	if (redrawScreen = 1)
		OryUIUpdateText(txtMaintainedByOne, "position:" + str((screenNo * 100) + 50) + "," + str((abs(screenBoundsTop#) + 94) - GetTextTotalHeight(txtMaintainedByOne)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif

	// COPYRIGHT
	if (redrawScreen = 1)
		OryUIUpdateText(txtCopyright, "text:© " + constCompanyName$ + " " + str(GetYearFromUnix(GetUnixTime())) + ";position:" + str((screenNo * 100) + 50) + "," + str((abs(screenBoundsTop#) + 98) - GetTextTotalHeight(txtCopyright)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = 100 + abs(screenBoundsTop#)
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, 0)
endif
