
OryUIHideFloatingActionButton(fabChangeAvatar)
OryUIHideFloatingActionButton(fabSaveProfile)
if (screenToView = constEditProfileScreen)
	screenNo = constEditProfileScreen

	// RESET OPTIONS
	if (resetOptions = 1)
		OryUIUpdateTextfield(editBoxAppUsername, "inputText:" + username$)
		OryUISetButtonGroupItemSelectedByIndex(grpSetStatus, statusSelected)
		OryUISetButtonGroupItemSelectedByIndex(grpMainRole, mainRoleSelected)
		if (privateProfile = 1)
			OryUISetButtonGroupItemSelectedByIndex(grpPrivateProfile, 1)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpPrivateProfile, 2)
		endif
		if (showKeyholderStatsOnProfile = 1 and showLockeeStatsOnProfile = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpShowStatsOnProfile, 1)
		endif
		if (showKeyholderStatsOnProfile = 0 and showLockeeStatsOnProfile = 1)
			OryUISetButtonGroupItemSelectedByIndex(grpShowStatsOnProfile, 2)
		endif
		if (showKeyholderStatsOnProfile = 1 and showLockeeStatsOnProfile = 1)
			OryUISetButtonGroupItemSelectedByIndex(grpShowStatsOnProfile, 3)
		endif
		if (showKeyholderStatsOnProfile = 0 and showLockeeStatsOnProfile = 0)
			OryUISetButtonGroupItemSelectedByIndex(grpShowStatsOnProfile, 4)
		endif
		resetOptions = 0
	endif
		
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

	elementY# = elementY# + OryUIGetButtonHeight(btnViewProfile)
	
	// APP USERNAME
	if (redrawScreen = 1)
		OryUIUpdateTextfield(editBoxAppUsername, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";maxLength:15;backgroundColorID:" + str(colorMode[colorModeSelected].textfieldColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";strokeColorID:" + str(colorMode[colorModeSelected].textfieldStrokeColor))
	endif
	OryUIInsertTextFieldListener(editBoxAppUsername)
	if (OryUIGetTextfieldTrailingIconReleased(editBoxAppUsername))
		OryUISetTextfieldString(editBoxAppUsername, "")
		SetEditBoxFocus(OryUITextfieldCollection[editBoxAppUsername].editBox, 0)
	endif
	if (OryUIGetTextfieldString(editBoxAppUsername) <> username$)
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	elementY# = elementY# + OryUIGetTextfieldHeight(editBoxAppUsername) + 2

	// PRIVATE PROFILE?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdPrivateProfile, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdPrivateProfile)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpPrivateProfile, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpPrivateProfile)
	if (privateProfile = 1 and OryUIGetButtonGroupItemSelectedIndex(grpPrivateProfile) = 2)
		OryUIShowFloatingActionButton(fabSaveProfile)
	elseif (privateProfile = 0 and OryUIGetButtonGroupItemSelectedIndex(grpPrivateProfile) = 1)
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpPrivateProfile) + 2
	
	// SET STATUS
	OryUIUpdateTextCard(crdSetStatus, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	elementY# = elementY# + OryUIGetTextCardHeight(crdSetStatus)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSetStatus, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSetStatus)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSetStatus) = 1) then OryUIUpdateTextCard(crdSetStatus, "supportingText:Seen by others as 'Online' when active.")
	if (OryUIGetButtonGroupItemSelectedIndex(grpSetStatus) = 2) then OryUIUpdateTextCard(crdSetStatus, "supportingText:Seen by others as 'Busy'.")
	if (OryUIGetButtonGroupItemSelectedIndex(grpSetStatus) = 3) then OryUIUpdateTextCard(crdSetStatus, "supportingText:Seen by others as 'Sleeping'. Notifications are also disabled.")
	if (OryUIGetButtonGroupItemSelectedIndex(grpSetStatus) = 4) then OryUIUpdateTextCard(crdSetStatus, "supportingText:Seen by others as 'Offline'. Even when active.")
	if (OryUIGetButtonGroupItemSelectedIndex(grpSetStatus) <> statusSelected)
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	if (OryUIGetButtonGroupItemReleasedIndex(grpSetStatus) > 0)
		SetScreenToView(screenNo)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSetStatus) + 2

	// MAIN ROLE
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdMainRole, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdMainRole)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpMainRole, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpMainRole)
	if (OryUIGetButtonGroupItemSelectedIndex(grpMainRole) <> mainRoleSelected)
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpMainRole) + 2

	// SHOW STATS ON PROFILE
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdShowStatsOnProfile, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdShowStatsOnProfile)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpShowStatsOnProfile, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpShowStatsOnProfile)
	if (OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 1 and (showKeyholderStatsOnProfile = 0 or showLockeeStatsOnProfile = 1))
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 2 and (showLockeeStatsOnProfile = 0 or showKeyholderStatsOnProfile = 1))
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 3 and (showKeyholderStatsOnProfile = 0 or showLockeeStatsOnProfile = 0))
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 4 and (showKeyholderStatsOnProfile = 1 or showLockeeStatsOnProfile = 1))
		OryUIShowFloatingActionButton(fabSaveProfile)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpShowStatsOnProfile) + 2
	
	// APP USER ID
	if (redrawScreen = 1)
		appUserIDVisible as integer : appUserIDVisible = 0
		OryUIUpdateTextCard(crdAppUserIDInfo, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdAppUserIDInfo) - 1
	if (appUserIDVisible = 0)
		OryUIUpdateTextCard(crdAppUserID, "supportingText:***********************;supportingTextBold:false;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateButton(btnShowAppUserID, "text:Show")
	else
		OryUIUpdateTextCard(crdAppUserID, "supportingText:" + userID$ + ";supportingTextBold:true;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateButton(btnShowAppUserID, "text:Hide")
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdAppUserID)
	if (redrawScreen = 1)
		OryUIUpdateButton(btnShowAppUserID, "position:" + str((screenNo * 100) + 29) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	if (OryUIGetButtonReleased(btnShowAppUserID))
		if (appUserIDVisible = 0)
			appUserIDVisible = 1
		else
			appUserIDVisible = 0
		endif
	endif
	if (redrawScreen = 1)
		OryUIUpdateButton(btnCopyAppUserID, "position:" + str((screenNo * 100) + 51) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	if (OryUIGetButtonReleased(btnCopyAppUserID))
		SetClipboardText(userID$)
		OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnShowAppUserID) + 2
	
	// CONNECT SOCIAL ACCOUNTS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdConnectSocialAccounts, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdConnectSocialAccounts)
	if (redrawScreen = 1)
		OryUIUpdateButton(btnDiscord, "position:" + str(((screenNo * 100) + 50) - OryUIGetButtonWidth(btnDiscord) - 1) + "," + str(elementY#))
		OryUIPinSpriteToCentreOfSprite(sprDiscord, OryUIButtonCollection[btnDiscord].sprContainer, 0, 0)
		OryUIUpdateButton(btnTwitter, "position:" + str(((screenNo * 100) + 50) + 1) + "," + str(elementY#))
		OryUIPinSpriteToCentreOfSprite(sprTwitter, OryUIButtonCollection[btnTwitter].sprContainer, 0, 0)
	endif
	if (OryUIGetButtonReleased(btnDiscord))
		urlUserID$ = userID$
		OpenBrowser("https://discordapp.com/oauth2/authorize?response_type=code&redirect_uri=" + constAppMarketingDomain$ + "/oauth2/discord/&scope=identify&state=" + urlUserID$ + "&client_id=" + constDiscordOAUTHClientID$)
	endif
	if (OryUIGetButtonReleased(btnTwitter))
		urlUserID$ = userID$
		OpenBrowser(constAppMarketingDomain$ + "/oauth2/twitter/?state=" + urlUserID$)
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnDiscord) + 2
	
	// SOCIAL ACCOUNT LISTS
	// DISCORD
	if (redrawScreen = 1)
		if (discordDiscriminator > 0 and discordUsername$ <> "" and discordID$ <> "")
			OryUIUpdateList(listConnectDiscord, "noOfLeftLines:1;showLeftThumbnail:true;showRightIcon:true;width:90;itemSize:90,6;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";depth:18")
			OryUISetListItemCount(listConnectDiscord, 1)
			OryUIUpdateListItem(listConnectDiscord, 0, "color:114,137,218,255;leftThumbnailImage:" + str(imgDiscordLogo) + ";leftLine1Text:" + discordUsername$ + "#" + AddLeadingZeros(str(discordDiscriminator), 4) + ";leftLine1TextColor:255,255,255,255;rightIcon:Delete;rightIconColor:255,255,255,255")
		endif
	endif
	OryUIInsertListListener(listConnectDiscord)
	if (OryUIGetListItemRightIconReleased(listConnectDiscord) >= 0 and lower(OryUIGetListItemRightIconReleasedType(listConnectDiscord)) = "custom")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Disconnect Discord?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Disconnecting Discord might make it harder to find you on Discord.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 2)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesDisconnectDiscord;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesDisconnectDiscord"))
		DisconnectDiscord(1)
	endif
	elementY# = elementY# + OryUIGetListHeight(listConnectDiscord) + 1
	// TWITTER
	if (redrawScreen = 1)
		if (twitterHandle$ <> "")
			OryUIUpdateList(listConnectTwitter, "noOfLeftLines:1;showLeftThumbnail:true;showRightIcon:true;width:90;itemSize:90,6;position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";depth:18")
			OryUISetListItemCount(listConnectTwitter, 1)
			OryUIUpdateListItem(listConnectTwitter, 0, "color:29,161,242,255;leftThumbnailImage:" + str(imgTwitterLogo) + ";leftLine1Text:" + twitterHandle$ + ";leftLine1TextColor:255,255,255,255;rightIcon:Delete;rightIconColor:255,255,255,255")
		endif
	endif
	OryUIInsertListListener(listConnectTwitter)
	if (OryUIGetListItemRightIconReleased(listConnectTwitter) >= 0 and lower(OryUIGetListItemRightIconReleasedType(listConnectTwitter)) = "custom")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Disconnect Twitter?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Disconnecting Twitter will remove your Twitter handle from your profile and account.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 2)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesDisconnectTwitter;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesDisconnectTwitter"))
		DisconnectTwitter(1)
	endif
	elementY# = elementY# + OryUIGetListHeight(listConnectTwitter) + 2

	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveProfile, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	// SAVE BUTTON
	if (OryUIGetFloatingActionButtonReleased(fabSaveProfile))
		if (OryUIGetTextfieldString(editBoxAppUsername) <> username$)
			if (StripString(OryUIGetTextfieldString(editBoxAppUsername), "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz") <> "")
				newUsername$ = ""
				for i = 1 to len(OryUIGetTextfieldString(editBoxAppUsername))
					if (FindString("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", mid(OryUIGetTextfieldString(editBoxAppUsername), i, 1)) > 0)
						newUsername$ = newUsername$ + mid(OryUIGetTextfieldString(editBoxAppUsername), i, 1)
					endif
				next
				OryUIUpdateTextfield(editBoxAppUsername, "inputText:" + newUsername$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Usernames should only contain alphanumeric characters." + chr(10) + chr(10) + "For your convenience all other characters have been removed.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (len(OryUIGetTextfieldString(editBoxAppUsername)) = 0)
				OryUIUpdateTextfield(editBoxAppUsername, "inputText:" + username$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Usernames can not be blank." + chr(10) + chr(10) + "Your username has reverted back to your current one.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (len(OryUIGetTextfieldString(editBoxAppUsername)) < 4)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Usernames should be longer than 3 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (len(OryUIGetTextfieldString(editBoxAppUsername)) > 15)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Usernames should be less than 16 characters.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			elseif (upper(left(OryUIGetTextfieldString(editBoxAppUsername), 3)) = "CKU" and OryUIGetTextfieldString(editBoxAppUsername) <> defaultUsername$)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Aside from your default assigned username '" + defaultUsername$ + "', usernames can't start with CKU. Please try another.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				newUsername$ = OryUIGetTextfieldString(editBoxAppUsername)
				CheckNewUsername(newUsername$, 1)
			endif
		endif
		
		if (OryUIGetButtonGroupItemSelectedIndex(grpPrivateProfile) = 1)
			privateProfile = 1
		else
			privateProfile = 0
		endif
		
		if (OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 1)
			showKeyholderStatsOnProfile = 1
			SaveLocalVariable("showKeyholderStatsOnProfile", str(showKeyholderStatsOnProfile))
			showLockeeStatsOnProfile = 0
			SaveLocalVariable("showLockeeStatsOnProfile", str(showLockeeStatsOnProfile))
		elseif (	OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 2)
			showKeyholderStatsOnProfile = 0
			SaveLocalVariable("showKeyholderStatsOnProfile", str(showKeyholderStatsOnProfile))
			showLockeeStatsOnProfile = 1
			SaveLocalVariable("showLockeeStatsOnProfile", str(showLockeeStatsOnProfile))
		elseif (	OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 3)
			showKeyholderStatsOnProfile = 1
			SaveLocalVariable("showKeyholderStatsOnProfile", str(showKeyholderStatsOnProfile))
			showLockeeStatsOnProfile = 1
			SaveLocalVariable("showLockeeStatsOnProfile", str(showLockeeStatsOnProfile))
		elseif (	OryUIGetButtonGroupItemSelectedIndex(grpShowStatsOnProfile) = 4)
			showKeyholderStatsOnProfile = 0
			SaveLocalVariable("showKeyholderStatsOnProfile", str(showKeyholderStatsOnProfile))
			showLockeeStatsOnProfile = 0
			SaveLocalVariable("showLockeeStatsOnProfile", str(showLockeeStatsOnProfile))
		endif
		
		statusSelected = OryUIGetButtonGroupItemSelectedIndex(grpSetStatus)
		SaveLocalVariable("statusSelected", str(statusSelected))
		
		mainRoleSelected = OryUIGetButtonGroupItemSelectedIndex(grpMainRole)
		SaveLocalVariable("mainRoleSelected", str(mainRoleSelected))
		UpdateAccount(0)
	endif

	// VIEW PROFILE BUTTON
	if (OryUIGetFloatingActionButtonVisible(fabSaveProfile) = 0)
		OryUIUpdateButton(btnViewProfile, "position:" + str((screenNo * 100) + 97) + "," + str(GetSpriteY(screen[screenNo].sprPage)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateButton(btnViewProfile, "position:-1000,-1000")
	endif
	if (OryUIGetButtonReleased(btnViewProfile))
		GetProfileData(userDBRow, 1)
		lastScreenViewed = constEditProfileScreen
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constViewProfileScreen)
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
		OryUIHideFloatingActionButton(fabSaveProfile)
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
