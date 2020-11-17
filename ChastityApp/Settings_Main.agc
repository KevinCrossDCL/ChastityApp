
if (screenToView = constSettingsScreen)
	if (screenNo <> constSettingsScreen)
		if (imgThemeBorder = 0) then imgThemeBorder = LoadImage("ThemeBorder.png")
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsTheme, themeSelected)
		if (fps = 30)
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsFramesPerSecond, 1)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsFramesPerSecond, 2)
		endif
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsAllowNotifications, notificationsOn)
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsCombinationType, combinationType)
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsUniqueCombinations, allowDuplicatesInCombination)		
		if (showCombinationsToKeyholders = 1)
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsShowCombinationsToKeyholders, 1)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsShowCombinationsToKeyholders, 2)
		endif
		OryUISetButtonGroupItemSelectedByIndex(grpEnableLockDeletions, enableLockDeletions)
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsShowCardAnimations, cardAnimationsOn)
		if (visibleInPublicStats = 1)
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsDisplayUsernameInStats, 1)
		else
			OryUISetButtonGroupItemSelectedByIndex(grpSettingsDisplayUsernameInStats, 2)
		endif
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsCloudData, 2)
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsShowTargetedAds, showTargetedAds)
	endif
	screenNo = constSettingsScreen

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

	// THEME
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsTheme, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsTheme)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsTheme, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#))
	endif
	OryUIInsertButtonGroupListener(grpSettingsTheme)
	for i = 0 to OryUIGetButtonGroupItemCount(grpSettingsTheme) - 1
		OryUIUpdateButtonGroupItem(grpSettingsTheme, i + 1, "colorID:" + str(theme[i + 1].color[3]))
		if (OryUIGetButtonGroupItemReleasedByIndex(grpSettingsTheme, i + 1) and themeSelected <> i + 1)
			themeSelected = i + 1
			ChangeTheme(themeSelected)
			SaveLocalVariable("themeSelected", str(themeSelected))
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSettingsScreen)
		endif
		if (themeSelected = i + 1)
			OryUIUpdateSprite(sprThemeButtonBorder, "size:" + str(OryUIGetButtonGroupItemWidth(grpSettingsTheme, i + 1)) + "," + str(OryUIGetButtonGroupItemHeight(grpSettingsTheme, i + 1)) + ";image:" + str(imgThemeBorder) + ";colorID:" + str(theme[themeSelected].color[1]))
			OryUIPinSpriteToSprite(sprThemeButtonBorder, OryUIButtonGroupCollection[grpSettingsTheme].buttons[i].sprContainer, 0, 0)
		endif
	next
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsTheme) + 2

	// COLOR MODE
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsColorMode, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsColorMode)
	if (redrawScreen = 1)
		OryUISetButtonGroupItemSelectedByIndex(grpSettingsColorMode, colorModeSelected)
		OryUIUpdateButtonGroup(grpSettingsColorMode, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsColorMode)
	for i = 0 to OryUIGetButtonGroupItemCount(grpSettingsColorMode) - 1
		if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsColorMode) = i + 1 and colorModeSelected <> i + 1)
			colorModeSelected = i + 1
			SaveLocalVariable("colorModeSelected", str(colorModeSelected))
			SetClearColor(GetColorRed(colorMode[colorModeSelected].backgroundColor), GetColorGreen(colorMode[colorModeSelected].backgroundColor), GetColorBlue(colorMode[colorModeSelected].backgroundColor))
			ChangeTheme(themeSelected)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constSettingsScreen)
		endif
	next
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsColorMode) + 2

	// FRAMES PER SECOND
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsFramesPerSecond, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:On older devices you may find that 30 frames per second (fps) reduces the battery usage of the app, but may also see minor speed issues in places. On newer devices you might not notice any difference between the two.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsFramesPerSecond)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsFramesPerSecond, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsFramesPerSecond)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsFramesPerSecond) = 1 and fps <> 30)
		fps = 30
		SaveLocalVariable("fps", str(fps))
		SetSyncRate(30, 0)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsFramesPerSecond) = 2 and fps <> 60)
		fps = 60
		SaveLocalVariable("fps", str(fps))
		SetSyncRate(60, 0)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsFramesPerSecond) + 2
	
	// ALLOW NOTIFICATIONS?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsAllowNotifications, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsAllowNotifications)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsAllowNotifications, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsAllowNotifications)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsAllowNotifications) = 1 and notificationsOn <> 1)
		notificationsOn = 1
		SaveLocalVariable("notificationsOn", str(notificationsOn))
		ResetAllNotifications()
		RequestPushNotificationToken()
		UpdateAccount(0)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsAllowNotifications) = 2 and notificationsOn <> 2)
		notificationsOn = 2
		SaveLocalVariable("notificationsOn", str(notificationsOn))
		ResetAllNotifications()
		pushNotificationToken$ = ""
		UpdateAccount(0)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsAllowNotifications) + 2

	// COMBINATION TYPE
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsCombinationType, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (combinationType = 1) then OryUIUpdateTextCard(crdSettingsCombinationType, "supportingText:Combinations containing numbers only. Will be applied to all newly created locks.")
		if (combinationType = 2) then OryUIUpdateTextCard(crdSettingsCombinationType, "supportingText:Combinations containing letters only. Will be applied to all newly created locks.")
		if (combinationType = 3) then OryUIUpdateTextCard(crdSettingsCombinationType, "supportingText:Combinations containing numbers and letters. Will be applied to all newly created locks.")
		if (combinationType = 4) then OryUIUpdateTextCard(crdSettingsCombinationType, "supportingText:Combinations containing numbers but with directions for turning dials. Will be applied to all newly created locks.")	
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsCombinationType)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsCombinationType, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsCombinationType)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsCombinationType) <> combinationType)
		combinationType = OryUIGetButtonGroupItemSelectedIndex(grpSettingsCombinationType)
		SaveLocalVariable("combinationType", str(combinationType))
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSettingsScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsCombinationType) + 2
	
	// ALLOW DUPLICATE DIGITS/CHARACTERS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsUniqueCombinations, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsUniqueCombinations)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsUniqueCombinations, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsUniqueCombinations)
	if (allowDuplicatesInCombination = 1 and OryUIGetButtonGroupItemSelectedIndex(grpSettingsUniqueCombinations) = 2)
		allowDuplicatesInCombination = 2
		SaveLocalVariable("allowDuplicatesInCombination", str(allowDuplicatesInCombination))
		UpdateAccount(0)
		if (combinationType = 1 and noOfDigits > 10)
			noOfDigits = 10
			SaveLocalVariable("noOfDigits", str(noOfDigits))
		endif
	elseif (allowDuplicatesInCombination = 2 and OryUIGetButtonGroupItemSelectedIndex(grpSettingsUniqueCombinations) = 1)
		allowDuplicatesInCombination = 1
		SaveLocalVariable("allowDuplicatesInCombination", str(allowDuplicatesInCombination))
		UpdateAccount(0)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsUniqueCombinations) + 2

	// SHOW COMBINATIONS TO KEYHOLDERS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsShowCombinationsToKeyholders, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsShowCombinationsToKeyholders)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsShowCombinationsToKeyholders, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsShowCombinationsToKeyholders)
	if (showCombinationsToKeyholders = 1 and OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowCombinationsToKeyholders) = 2)
		showCombinationsToKeyholders = 0
		SaveLocalVariable("showCombinationsToKeyholders", str(showCombinationsToKeyholders))
		UpdateAccount(0)
	elseif (showCombinationsToKeyholders = 0 and OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowCombinationsToKeyholders) = 1)
		showCombinationsToKeyholders = 1
		SaveLocalVariable("showCombinationsToKeyholders", str(showCombinationsToKeyholders))
		UpdateAccount(0)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsShowCombinationsToKeyholders) + 2

	// ENABLE ACTIVE LOCK DELETIONS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdEnableLockDeletions, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdEnableLockDeletions)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpEnableLockDeletions, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpEnableLockDeletions)
	if (OryUIGetButtonGroupItemSelectedIndex(grpEnableLockDeletions) = 1 and enableLockDeletions <> 1)
		enableLockDeletions = 1
		SaveLocalVariable("enableLockDeletions", str(enableLockDeletions))
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpEnableLockDeletions) = 2 and enableLockDeletions <> 2)
		enableLockDeletions = 2
		SaveLocalVariable("enableLockDeletions", str(enableLockDeletions))
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpEnableLockDeletions) + 2

	// SHOW CARD SHUFFLE ANIMATIONS?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsShowCardAnimations, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsShowCardAnimations)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsShowCardAnimations, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsShowCardAnimations)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowCardAnimations) <> cardAnimationsOn)
		cardAnimationsOn = OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowCardAnimations)
		SaveLocalVariable("cardAnimationsOn", str(cardAnimationsOn))
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsShowCardAnimations) + 2

	// DISPLAY USERNAME IN PUBLIC STATS, LISTS, AND DATA?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsDisplayUsernameInStats, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsDisplayUsernameInStats)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpSettingsDisplayUsernameInStats, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpSettingsDisplayUsernameInStats)
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsDisplayUsernameInStats) = 1 and visibleInPublicStats = 0)
		visibleInPublicStats = 1
		SaveLocalVariable("visibleInPublicStats", str(visibleInPublicStats))
		UpdateAccount(0)
	endif
	if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsDisplayUsernameInStats) = 2 and visibleInPublicStats = 1)
		visibleInPublicStats = 0
		SaveLocalVariable("visibleInPublicStats", str(visibleInPublicStats))
		UpdateAccount(0)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsDisplayUsernameInStats) + 2

	// SAVE USER DATA TO THE CLOUD?
	if ((GetCloudDataAllowed() <> -2 and GetDeviceBaseName() = "ios") or (GetCloudDataAllowed() = 1 and GetDeviceBaseName() = "android"))
		cloudUserID$ as string : cloudUserID$ = GetCloudDataVariable(lower(constAppName$) + ".userID", "")
		if (GetDeviceBaseName() = "android") then cloudName$ = "Google Cloud"
		if (GetDeviceBaseName() = "ios") then cloudName$ = "iCloud"
		if (redrawScreen = 1)
			if (cloudUserID$ = "")
				OryUIUpdateTextCard(crdSettingsCloudData, "headerText:Save user id in your " + cloudName$ + " account?;supportingText:Your user id will be saved in your " + cloudName$ + " account. This will make it easier to restore your account at a later date, after a fresh install on this or another device.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			elseif (userID$ = cloudUserID$)
				OryUIUpdateTextCard(crdSettingsCloudData, "headerText:Delete user id from your " + cloudName$ + " account?;supportingText:Your user id is saved in your " + cloudName$ + " account. Deleting it will mean that this account will no longer be saved in your " + cloudName$ + " account. It can still be restored by choosing Restore Account from the menu but you will need to write down the user ID you're about to delete if you think you might need it in the future." + chr(10) + chr(10) + cloudName$ + " user id[colon] " + cloudUserID$ + ";position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			else
				OryUIUpdateTextCard(crdSettingsCloudData, "headerText:Replace user id in your " + cloudName$ + " account?;supportingText:The user id saved in your " + cloudName$ + " account is different from your user id registered on this device. You can replace the " + cloudName$ + " user id with your current one one which will make it easier to restore this account at a later date, after a fresh install on this or another device. Replacing it will mean that the user id currently saved in your " + cloudName$ + " account will no longer be saved in your " + cloudName$ + " account. It can still be restored by choosing Restore Account from the menu but you will need to write down the user ID you're about to replace if you think you might need it in the future." + chr(10) + chr(10) + "Device user id[colon] " + userID$ + chr(10) + cloudName$ + " user id[colon] " + cloudUserID$ + ";position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsCloudData)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSettingsCloudData, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		if (OryUIGetButtonGroupItemReleasedByIndex(grpSettingsCloudData, 1))
			cloudDataAllowed as integer : cloudDataAllowed = GetCloudDataAllowed()
			if (cloudDataAllowed = 0)
				SetupCloudData("")
			elseif (cloudDataAllowed = -1)
			
			elseif (cloudDataAllowed = -2)
			
			elseif (cloudDataAllowed = 1)
				if (cloudUserID$ = "")
				SetCloudDataVariable(lower(constAppName$) + ".userID", userID$)
				elseif (userID$ = cloudUserID$)
					SetCloudDataVariable(lower(constAppName$) + ".userID", "")
				else
					SetCloudDataVariable(lower(constAppName$) + ".userID", userID$)
				endif
			endif
		endif
		OryUIInsertButtonGroupListener(grpSettingsCloudData)
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsCloudData) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSettingsCloudData, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSettingsCloudData, "position:-1000,-1000")
		endif
	endif

	// SHOW TARGETED ADS?
	if (adsRemoved = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSettingsShowTargetedAds, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsShowTargetedAds)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpSettingsShowTargetedAds, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpSettingsShowTargetedAds)
		if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowTargetedAds) = 1 and showTargetedAds <> 1)
			showTargetedAds = 1
			SaveLocalVariable("showTargetedAds", str(showTargetedAds))
			OverrideConsentAdMob(2)
			OverrideConsentChartboost(2)
			RequestAdvertRefresh()
			SetAdvertVisible(1)
		endif
		if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowTargetedAds) = 2 and showTargetedAds <> 2)
			showTargetedAds = 2
			SaveLocalVariable("showTargetedAds", str(showTargetedAds))
			OverrideConsentAdMob(1)
			OverrideConsentChartboost(1)
			RequestAdvertRefresh()
			SetAdvertVisible(1)
		endif
		if (OryUIGetButtonGroupItemSelectedIndex(grpSettingsShowTargetedAds) = 3)
			if (PurchaseInApp(0) = 1)
				adsRemoved = 1
				SaveLocalVariable("adsRemoved", str(adsRemoved))
			else
				OryUISetButtonGroupItemSelectedByIndex(grpSettingsShowTargetedAds, showTargetedAds)
			endif
		endif
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpSettingsShowTargetedAds) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdSettingsShowTargetedAds, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpSettingsShowTargetedAds, "position:-1000,-1000")
		endif
	endif
	
	// RE-ENABLE HIDDEN ALERTS
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdSettingsReenableHiddenAlerts, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdSettingsReenableHiddenAlerts)
	if (redrawScreen = 1)
		OryUIUpdateButton(btnSettingsReenableHiddenAlerts, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	if (OryUIGetButtonReleased(btnSettingsReenableHiddenAlerts))
		shownSaveYourUserIDAlertThisSession = 1
		ResetHiddenAlerts()
		OryUIUpdateTooltip(tooltip, "text:Reset Alerts")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnSettingsReenableHiddenAlerts) + 2

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
