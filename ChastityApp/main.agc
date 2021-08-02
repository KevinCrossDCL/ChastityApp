
//   Created: 10/12/2016
//	 Updated: 02/08/2021

#option_explicit

SetSoundDeviceMode(0)
SetClearColor(0, 0, 0)
ClearScreen()
SetOrientationAllowed(1, 1, 0, 0)
SetPrintColor(255, 0, 0)
SetPrintSize(2)
SetScissor(0, 0, 0, 0)
SetSleepMode(1)
SetSyncRate(60, 0)
UseNewDefaultFonts(1)
SetImmersiveMode(1)

#insert "ProjectVariables.agc"
 
global tmpVersionNumber$ as string
tmpVersionNumber$ = ReplaceString(constVersionNumber$, " ", "_", -1)
tmpVersionNumber$ = ReplaceString(tmpVersionNumber$, ".", "_", -1)	

#constant constSplashScreen 0
#constant constMyLocksScreen 1
#constant constSharedLocksScreen 2
#constant constYourFollowersListScreen 3
#constant constYourFollowingListScreen 4
#constant constYourBlockedUsersListScreen 5
#constant constYourFollowRequestsListScreen 6
#constant constOthersFollowersListScreen 7
#constant constOthersFollowingListScreen 8
#constant constLockInformationScreen 9
#constant constLockLogScreen 10
#constant constSharedLockInformationScreen 11
#constant constLockOptionsScreen 12
#constant constScanQRCodeScreen 13
#constant constSetCombinationScreen 14
#constant constCreateLocksScreen 15
#constant constRandomCombinationsScreen 16
#constant constRestoreAccountScreen 17
#constant constSettingsScreen 18
#constant constShareLockScreen 19
#constant constViewProfileScreen 20
#constant constEditProfileScreen 21
#constant constEditAvatarScreen 23
#constant constManageLockedUsersScreen 25
#constant constManageUnlockedUsersScreen 26
#constant constManageDesertedUsersScreen 27
#constant constUsersLockUpdateScreen 28
#constant constUsersLockInformationScreen 29
#constant constUsersLockLogScreen 30
#constant constEmojisScreen 31
#constant constAboutScreen 32
#constant constAPIDashboardScreen 33
#constant constAPIProjectSettingsScreen 34
#constant constMyLocksDeletedScreen 35
#constant constSharedLocksDeletedScreen 36
#constant constLockExtrasScreen 37
#constant constLockGeneratorScreen 38
#constant constLockGeneratorInformationScreen 39
#constant constLockGeneratorResultsScreen 40
#constant constRecentActivityScreen 50
#constant constRandomCombinationsToolScreen 70
#constant constCardsScreen 100
#constant constLoginScreen 200
#constant constRegisterScreen 300

#insert "..\OryUI Framework\OryUI.agc"
#insert "..\OryUI Framework\OryUIButton.agc"
#insert "..\OryUI Framework\OryUIButtonGroup.agc"
#insert "..\OryUI Framework\OryUICheckbox.agc"
#insert "..\OryUI Framework\OryUIDialog.agc"
#insert "..\OryUI Framework\OryUIEditAvatarScreen.agc"
#insert "..\OryUI Framework\OryUIFloatingActionButton.agc"
#insert "..\OryUI Framework\OryUIHTTPSQueue.agc"
#insert "..\OryUI Framework\OryUIInputSpinner.agc"
#insert "..\OryUI Framework\OryUIList.agc"
#insert "..\OryUI Framework\OryUIMedia.agc"
#insert "..\OryUI Framework\OryUIMenu.agc"
#insert "..\OryUI Framework\OryUINavigationDrawer.agc"
#insert "..\OryUI Framework\OryUIPagination.agc"
#insert "..\OryUI Framework\OryUIProgressIndicator.agc"
#insert "..\OryUI Framework\OryUIScrollBar.agc"
#insert "..\OryUI Framework\OryUIScrollToTop.agc"
#insert "..\OryUI Framework\OryUISprite.agc"
#insert "..\OryUI Framework\OryUISwitch.agc"
#insert "..\OryUI Framework\OryUITabs.agc"
#insert "..\OryUI Framework\OryUIText.agc"
#insert "..\OryUI Framework\OryUITextCard.agc"
#insert "..\OryUI Framework\OryUITextfield.agc"
#insert "..\OryUI Framework\OryUITooltip.agc"
#insert "..\OryUI Framework\OryUITopBar.agc"
#insert "..\OryUI Framework\OryUITouch.agc"
#insert "..\OryUI Framework\OryUIDefaultSettings.agc"

#insert "Globals.agc"

// ADDED TO GET RID OF THE BLANK SCREEN BEFORE SPLASH SCREEN IS SHOWN.
global imgGradientBackgroundDark as integer : imgGradientBackgroundDark = LoadImage("GradientBackgroundDark.png")
global imgGradientBackgroundLight as integer : imgGradientBackgroundLight = LoadImage("GradientBackgroundLight.png")
global sprPreSplashScreenGradient as integer : sprPreSplashScreenGradient = CreateSprite(0)
SetSpriteSize(sprPreSplashScreenGradient, -1, 100)
SetSpriteOffset(sprPreSplashScreenGradient, GetSpriteWidth(sprPreSplashScreenGradient) / 2, GetSpriteHeight(sprPreSplashScreenGradient) / 2)
SetSpritePositionByOffset(sprPreSplashScreenGradient, 50, 50)
if (colorModeSelected <> 2)
	SetSpriteColor(sprPreSplashScreenGradient, 255, 255, 255, 255)
	SetSpriteImage(sprPreSplashScreenGradient, imgGradientBackgroundLight)
else
	SetSpriteColor(sprPreSplashScreenGradient, 0, 0, 0, 255)
endif

Sync()

#insert "Images.agc"
#insert "Types.agc"
#insert "Themes.agc"

global pleaseWait as integer : pleaseWait = OryUICreateProgressIndicator("progressType:circular;size:-1,15;offset:center;colorID:" + str(theme[themeSelected].color[3]) + ";fixToScreen:true;position:-1000,-1000;depth:1")
OryUIUpdateProgressIndicator(pleaseWait, "colorID:" + str(theme[themeSelected].color[3]) + ";position:50,50")

if (debugMode = 1)
	SetErrorMode(1)
endif

if (GetDeviceBaseName() = "android")
	LoadConsentStatusAdMob("pub-xxxxxxxxxxxxxxxx", constAppMarketingDomain$ + "/privacy-policy")
	while (GetConsentStatusAdMob() < 0)
		Sync()
	endwhile
	if (GetConsentStatusAdMob() = 0) 
		RequestConsentAdMob()
		local timeout# as float : timeout# = Timer() + 1
		while (GetConsentStatusAdMob() < 0 and Timer() < timeout#)
			Sync()
		endwhile
	endif

	store$ = "Google Play"
	SetAdMobDetails(constAdMobAndroid$)
	SetPushNotificationKeys("SenderID", constPushNotificationSenderID$)
	InAppPurchaseSetTitle(constAppName$)
	//InAppPurchaseSetKeys(constInAppPurchaseSetKeyAndroid$, "")
	InAppPurchaseAddProductID("remove_ads", 0)
	InAppPurchaseAddProductID("1_key", 0)
	InAppPurchaseAddProductID("2_keys", 0)
	InAppPurchaseAddProductID("5_keys", 0)
	InAppPurchaseAddProductID("10_keys", 0)
	InAppPurchaseAddProductID("25_keys", 0)
	InAppPurchaseAddProductID("50_keys", 0)
	InAppPurchaseSetup()
elseif (GetDeviceBaseName() = "ios")
//~	LoadConsentStatusAdMob("pub-xxxxxxxxxxxxxxxx", constAppMarketingDomain$ + "/privacy-policy")
//~	while (GetConsentStatusAdMob() < 0)
//~		Sync()
//~	endwhile
//~	if (GetConsentStatusAdMob() = 0) 
//~		RequestConsentAdMob()
//~		timeout# = Timer() + 2
//~		while (GetConsentStatusAdMob() < 0 and Timer() < timeout#)
//~			Sync()
//~		endwhile
//~	endif

	store$ = "App Store"
//~	SetAdMobDetails(constAdMobiOS$)
	SetPushNotificationKeys("SenderID", constPushNotificationSenderID$)
	InAppPurchaseSetTitle(constAppName$)
	InAppPurchaseAddProductID("remove_ads", 0)
	InAppPurchaseAddProductID("1_key", 0)
	InAppPurchaseAddProductID("2_keys", 0)
	InAppPurchaseAddProductID("5_keys", 0)
	InAppPurchaseAddProductID("10_keys", 0)
	InAppPurchaseAddProductID("25_keys", 0)
	InAppPurchaseAddProductID("50_keys", 0)
	InAppPurchaseSetup()
elseif (GetDeviceBaseName() = "mac")
	store$ = "Mac Store"
	SetWindowSize(405, 832, 0)
	//SetWindowSize(428, 926, 0)
	SetDisplayAspect(-1)
	SetWindowTitle(constAppName$)
endif

SetClearColor(GetColorRed(colorMode[colorModeSelected].backgroundColor), GetColorGreen(colorMode[colorModeSelected].backgroundColor), GetColorBlue(colorMode[colorModeSelected].backgroundColor))

global btnCopyText as integer : btnCopyText = OryUICreateButton("size:-1,5;text: ;offset:center;position:-1000,-1000;color:255,255,255,255;image:" + str(imgCopyText) + ";depth:14")
global timeShownBtnCopyText# as float : timeShownBtnCopyText# = 0
domain$ = ReplaceString(domain$, "http://", "", -1)
domain$ = ReplaceString(domain$, "https://", "", -1)
httpsQueue = OryUICreateHTTPSQueue("domain:" + domain$ + ";ssl:" + str(ssl) + ";delay:0.05;timeout:10000")
dialog = OryUICreateDialog("autoHeight:true")
global scrollBar as integer : scrollBar = OryUICreateScrollBar("alwaysVisible:false;autoResize:false;direction:vertical;draggable:true;scrollType:fastscroll")
tooltip = OryUICreateTooltip("")

global sprOfflineMode as integer : sprOfflineMode = OryUICreateSprite("size:100,9;position:-1000,-1000;color:192,57,42,255;depth:2;")
global txtOfflineMode as integer : txtOfflineMode = OryUICreateText("text:Offline!" + chr(10) + "Will try to connect again in xx:xx" + chr(10) + "Tap to try again now;position:-1000,-1000;size:2.8;depth:1")

global sprPullToRefreshCircle : sprPullToRefreshCircle = OryUICreateSprite("size:-1,5;offset:center;position:-1000,-1000;image:" + str(imgPullToRefreshCircle) + ";depth:1")
global sprPullToRefreshIcon : sprPullToRefreshIcon = OryUICreateSprite("size:-1,5;offset:center;position:-1000,-1000;image:" + str(imgPullToRefreshIcon) + ";alpha:0;depth:0")

#insert "SplashScreen_Layout.agc"
#insert "Login_Layout.agc"
Sync()
#insert "Menu_Layout.agc"
#insert "MyLocks_Layout.agc"
#insert "SharedLocks_Layout.agc"
Sync()
#insert "YourFollowersList_Layout.agc"
#insert "YourFollowingList_Layout.agc"
#insert "YourBlockedUsersList_Layout.agc"
#insert "YourFollowRequestsList_Layout.agc"
Sync()
#insert "OthersFollowersList_Layout.agc"
#insert "OthersFollowingList_Layout.agc"
Sync()
#insert "LockInformation_Layout.agc"
#insert "LockLog_Layout.agc"
Sync()
#insert "SharedLockInformation_Layout.agc"
Sync()
#insert "LockOptions_Layout.agc"
#insert "ScanQRCode_Layout.agc"
#insert "SetCombination_Layout.agc"
#insert "CreateLocks_Layout.agc"
#insert "RandomCombinations_Layout.agc"
Sync()
#insert "Settings_Layout.agc"
Sync()
#insert "ShareLock_Layout.agc"
Sync()
#insert "ViewProfile_Layout.agc"
#insert "EditProfile_Layout.agc"
Sync()
#insert "ManageLockedUsers_Layout.agc"
#insert "ManageUnlockedUsers_Layout.agc"
#insert "ManageDesertedUsers_Layout.agc"
Sync()
#insert "UsersLockUpdate_Layout.agc"
#insert "UsersLockInformation_Layout.agc"
#insert "UsersLockLog_Layout.agc"
Sync()
#insert "Emojis_Layout.agc"
Sync()
#insert "About_Layout.agc"
Sync()
#insert "APIDashboard_Layout.agc"
#insert "APIProjectSettings_Layout.agc"
Sync()
#insert "MyLocksDeleted_Layout.agc"
#insert "SharedLocksDeleted_Layout.agc"
Sync()
#insert "LockGenerator_Layout.agc"
#insert "LockGeneratorInformation_Layout.agc"
#insert "LockGeneratorResults_Layout.agc"
#insert "Cards_Layout.agc"
Sync()
#insert "RecentActivity_Layout.agc"
#insert "RandomCombinationsTool_Layout.agc"
Sync()

SetSpritePosition(sprPreSplashScreenGradient, -1000,-1000)

callCount as integer : callCount = 0
secondsLast1MinuteRefresh as integer : secondsLast1MinuteRefresh = GetSeconds()
secondsLast5MinuteRefresh as integer : secondsLast5MinuteRefresh = GetSeconds()

shownBannedAlertThisSession as integer : shownBannedAlertThisSession = 0
shownDeactivatingAlertThisSession as integer : shownDeactivatingAlertThisSession = 0
shownSaveYourUserIDAlertThisSession as integer : shownSaveYourUserIDAlertThisSession = 0

screenToView = constSplashScreen

OryUIDisableFlickScroll()

do
	if (debugMode = 1)
		print("### DEBUG MODE ###")
		print("Offline Status: " + str(offline))
		print("Timestamp Now: " + str(timestampNow))
		print("Unix Timestamp Now: " + str(GetUnixTime()))
		print("Device Timestamp Offset: " + str(deviceTimestampOffset))
		if (GetUnixTime() - timestampNow < -30 or GetUnixTime() - timestampNow > 30)
			print("Server and Device Times Have Slipped")
		endif
		print("Seconds Until 1 Minute Refresh: " + str(60 - (GetSeconds() - secondsLast1MinuteRefresh)))
		print("Seconds Until 5 Minute Refresh: " + str(300 - (GetSeconds() - secondsLast5MinuteRefresh)))
		print("FPS: " + str(ScreenFPS()))
		if (GetErrorOccurred()) then log(GetLastError())
		OryUIPrintHTTPSQueue(httpsQueue)
	endif
	if (developerMode = 1 or developerShowCards = 1)
		print("")
		print("### DEVELOPER MODE ON ###")
		print("")
	endif

	OryUIStartTrackingTouch()
	
	OryUIInsertDialogListener(dialog)
	
	secondsRunning = GetSeconds()
	if (screenNo <> constSplashScreen and screenNo <> constLoginScreen)
		if (GetInternetState() = 0)
			SetOfflineValue(1)
		elseif (offline = 1)
			
		else
			noInternet = 0
			timestampNow = timestampFromServer + secondsRunning
		endif

		if (lastDeviceHeight# <> GetDeviceHeight())
			lastDeviceHeight# = GetDeviceHeight()
			SetImmersiveMode(1)
			if (GetDeviceBaseName() <> "mac") then SetScreenResolution(0, 0)
			screenBoundsTop# = GetScreenBoundsTop()
			bannerAdsCreated = 0
		endif
		
		if (bannerAdsCreated = 0)
			DeleteAdvert()
			CreateAdvert(0, 1, 2, 0)
			SetAdvertLocation(1, 2, 100)
			SetAdvertVisible(0)
			bannerAdsCreated = 1
		endif
	endif

	if (changingScreen = 1)
		SetViewOffset(screenToView * 100, screenToViewY#)
		changingScreen = 0
		redrawScreen = 1
	endif
	
	// SHOW TOOLTIP AFTER SCREEN REFRESH
	if (tooltipTextForAfterScreenRefresh$ <> "")
		OryUIUpdateTooltip(tooltip, "text:" + tooltipTextForAfterScreenRefresh$)
		OryUIShowTooltip(tooltip, GetViewOffsetX() + screenBoundsTop# + 50, GetViewOffsetY() + 90)
		tooltipTextForAfterScreenRefresh$ = ""
	endif
					
	#insert "SplashScreen_Main.agc"
	#insert "Login_Main.agc"
	#insert "Menu_Main.agc"
	#insert "MyLocks_Main.agc"				
	#insert "SharedLocks_Main.agc"
	#insert "YourFollowersList_Main.agc"
	#insert "YourFollowingList_Main.agc"
	#insert "YourBlockedUsersList_Main.agc"
	#insert "YourFollowRequestsList_Main.agc"
	#insert "OthersFollowersList_Main.agc"
	#insert "OthersFollowingList_Main.agc"
	#insert "LockInformation_Main.agc"	
	#insert "LockLog_Main.agc"	
	#insert "SharedLockInformation_Main.agc"				
	#insert "LockOptions_Main.agc"
	#insert "ScanQRCode_Main.agc"
	#insert "SetCombination_Main.agc"
	#insert "CreateLocks_Main.agc"
	#insert "RandomCombinations_Main.agc"
	#insert "Settings_Main.agc"			
	#insert "ShareLock_Main.agc"
	#insert "ViewProfile_Main.agc"		
	#insert "EditProfile_Main.agc"
	#insert "ManageLockedUsers_Main.agc"	
	#insert "ManageUnlockedUsers_Main.agc"
	#insert "ManageDesertedUsers_Main.agc"
	#insert "UsersLockUpdate_Main.agc"		
	#insert "UsersLockInformation_Main.agc"		
	#insert "UsersLockLog_Main.agc"			
	#insert "Emojis_Main.agc"		
	#insert "About_Main.agc"
	#insert "APIDashboard_Main.agc"				
	#insert "APIProjectSettings_Main.agc"
	#insert "MyLocksDeleted_Main.agc"
	#insert "SharedLocksDeleted_Main.agc"
	#insert "LockGenerator_Main.agc"
	#insert "LockGeneratorInformation_Main.agc"
	#insert "LockGeneratorResults_Main.agc"
	#insert "Cards_Main.agc"
	#insert "RecentActivity_Main.agc"
	#insert "TransferAccount_Main.agc"
	#insert "RandomCombinationsTool_Main.agc"

	#insert "HTTPSQueueResponse.agc"
	
	if (OryUIGetSwipingVertically() = 1 or timer() - 1 > timeShownBtnCopyText#)
		OryUIUpdateButton(btnCopyText, "position:-1000,-1000")
	endif
					
	if (screenNo <> constSplashScreen and screenNo <> constLoginScreen)
		if (userID$ = "")
			splashScreenStage$ = "Display Login Screen"
			SetScreenToView(constLoginScreen)
		endif
	endif
	
	// BANNED ACCOUNT
	if (oryUIDialogVisible = 0 and banned = 1 and bannedAlertHidden = 0 and shownBannedAlertThisSession = 0 and screenNo <> constSplashScreen and screenNo <> constLoginScreen)
		dialogShown$ = "BannedAccount"
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Account Restricted;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Your account has been restricted for the following reason(s)[colon]" + chr(10) + chr(10) + reasonBanned$ + chr(10) + chr(10) + "Some features have been disabled.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
		shownBannedAlertThisSession = 1
	endif
	if (OryUIGetDialogChecked(dialog) and dialogShown$ = "BannedAccount")
		bannedAlertHidden = 1
		SaveLocalVariable("bannedAlertHidden", str(bannedAlertHidden))
		dialogShown$ = ""
	endif
									
	// SAVE YOUR USER ID ALERT
	if (oryUIDialogVisible = 0 and banned = 0 and saveYourUserIDAlertHidden = 0 and shownSaveYourUserIDAlertThisSession = 0 and screenNo <> constSplashScreen and screenNo <> constLoginScreen)
		if (userID$ <> GetCloudDataVariable(lower(constAppName$) + ".userID", ""))
			dialogShown$ = "SaveUserID"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Save Your User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + userID$ + chr(10) + chr(10) + "All of your locks are backed up online with the above user id. Please take a note of this unique user id in case you need to restore these locks on a new device, or after a new install. You can restore locks from another user id from the main menu." + chr(10) + chr(10) + "Please note that your user id and username are different and that locks can't be restored without your user id, even if you remember your username." + chr(10) + chr(10) + "Do not share your user id with others.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CopyUserID;text:Copy User ID;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
		shownSaveYourUserIDAlertThisSession = 1
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "CopyUserID"))
		SetClipboardText(userID$)
		OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
	endif
	if (OryUIGetDialogChecked(dialog) and dialogShown$ = "SaveUserID")
		saveYourUserIDAlertHidden = 1
		SaveLocalVariable("saveYourUserIDAlertHidden", str(saveYourUserIDAlertHidden))
		dialogShown$ = ""
	endif
	
	// DEACTIVATING VERSION ALERT
	if (oryUIDialogVisible = 0 and deactivatingVersionAlertHidden = 0 and shownDeactivatingAlertThisSession = 0 and screenNo <> constSplashScreen)
		if (dateDeactivatingVersion$ <> "")
			dialogShown$ = "DeactivatingVersion"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Deactivating Version Soon;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:For technical and security reasons this version of " + constAppName$ + " will be deactivated on " + dateDeactivatingVersion$ + "." + chr(10) + chr(10) + "To minimise disruptions to your locks please update to the latest version of " + constAppName$ + " before that date.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
		shownDeactivatingAlertThisSession = 1
	endif
	if (OryUIGetDialogChecked(dialog) and dialogShown$ = "DeactivatingVersion")
		deactivatingVersionAlertHidden = 1
		tmpVersionNumber$ = ReplaceString(constVersionNumber$, " ", "_", -1)
		tmpVersionNumber$ = ReplaceString(tmpVersionNumber$, ".", "_", -1)
		SaveLocalVariable("deactivatingVersionAlertHidden_v" + tmpVersionNumber$, str(deactivatingVersionAlertHidden))
		dialogShown$ = ""
	endif
	
	// FREE ITEMS ALERT
	if (oryUIDialogVisible = 0 and screenNo <> constSplashScreen)
		if (freeKeysAvailable = 1)
			inc callCount
			noOfKeys = noOfKeys + freeKeysAvailable
			SaveLocalVariable("noOfKeys", str(noOfKeys))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Free Key Given;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You've been given a free key. You can use this at any time to unlock a lock;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
			freeKeysAvailable = 0
		elseif (freeKeysAvailable > 1)
			noOfKeys = noOfKeys + freeKeysAvailable
			SaveLocalVariable("noOfKeys", str(noOfKeys))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Free Keys Given;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You've been given " + str(freeKeysAvailable) + " free keys. You can use these at any time to unlock your locks;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
			freeKeysAvailable = 0
		endif
		if (freeAdsRemovalAvailable = 1 and adsRemoved = 0)
			freeAdsRemovalAvailable = 0
			adsRemoved = 1
			SaveLocalVariable("adsRemoved", str(adsRemoved))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Free Ads Removal Given;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You've been given a free ads removal token. Ads will now be removed the app.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	endif
	
	// FAKE LOCK UNLOCKED
	if (oryUIDialogVisible = 0 and fakeLockUnlocked = 1 and screenNo = constMyLocksScreen)
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Fake Lock Unlocked;supportingText:You've just unlocked a fake lock so you get to keep the key(s) to use again.;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;decisionRequired:true")
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
		fakeLockUnlocked = 0
	endif
	
	// DELETE MY LOCK JUST RESTORED
	if (deletedMyLockJustRestored = 1)
		deletedMyLockJustRestored = 0
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Restored;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Your lock has been restored and can be accessed from the 'My Locks' screen.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	
	// DELETE SHARED LOCK JUST RESTORED
	if (deletedSharedLockJustRestored = 1 and OryUIIsNameInHTTPSQueue(httpsQueue, "GetSharedLocksDeleted") = 0)
		deletedSharedLockJustRestored = 0
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Restored;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Your lock has been restored and can be accessed from the 'Shared Locks' screen.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	
	// AUTO RESETS
	if (oryUIDialogVisible = 0 and noOfLocksAutoReset = 0 and (screenNo = constMyLocksScreen or screenNo = constCardsScreen) and timestampFromServer > 1500000000)
		for i = 1 to noOfLocks
			if (locks[i].fixed = 0 and locks[i].unlocked = 0 and locks[i].readyToUnlock = 0 and locks[i].maximumAutoResets > 0 and locks[i].autoResetsPaused = 0 and locks[i].resetFrequencyInSeconds > 0)
				secondsSinceLastReset = 0
				if (locks[i].timestampLastAutoReset > 0 or locks[i].timestampLastFullReset > 0)
					secondsSinceLastReset = timestampNow - MaxInt(locks[i].timestampLastAutoReset, locks[i].timestampLastFullReset)
				else
					secondsSinceLastReset = timestampNow - locks[i].timestampLocked
				endif
				timestampAutoReset as integer : timestampAutoReset = 0
				noOfAutoResetsSinceLast as integer : noOfAutoResetsSinceLast = 0
				// NON-CUMULATIVE
				if (locks[i].cumulative = 0)
					timestampAutoReset = timestampNow
					noOfAutoResetsSinceLast = 1
				endif
				// CUMULATIVE
				if (locks[i].cumulative = 1)
					noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / locks[i].resetFrequencyInSeconds)
					noOfAutoResetsLeft = locks[i].maximumAutoResets - locks[i].noOfTimesAutoReset - noOfAutoResetsPassedSinceLast
					if (noOfAutoResetsLeft <= 0 and locks[i].noOfTimesAutoReset < locks[i].maximumAutoResets) then noOfAutoResetsLeft = locks[i].maximumAutoResets - locks[i].noOfTimesAutoReset
					if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
					if (noOfAutoResetsPassedSinceLast > 0)
						if (locks[i].timestampLastAutoReset > 0 or locks[i].timestampLastFullReset)
							timestampAutoReset = MaxInt(locks[i].timestampLastAutoReset, locks[i].timestampLastFullReset) + (noOfAutoResetsPassedSinceLast * locks[i].resetFrequencyInSeconds)
						else
							timestampAutoReset = locks[i].timestampLocked + (noOfAutoResetsPassedSinceLast * locks[i].resetFrequencyInSeconds)
						endif
						noOfAutoResetsSinceLast = noOfAutoResetsPassedSinceLast
					else
						secondsSinceLastReset = 0
					endif
				endif
				if (secondsSinceLastReset > locks[i].resetFrequencyInSeconds and locks[i].noOfTimesAutoReset < locks[i].maximumAutoResets)
					locks[i].doubleUpCards = locks[i].initialDoubleUpCards
					locks[i].freezeCards = locks[i].initialFreezeCards
					locks[i].goAgainCards = 0
					if (locks[i].cardInfoHidden = 1) then locks[i].goAgainCards = floor((GetNoOfCards(i) / 100.0) * locks[i].goAgainCardsPercentage#)
					if (locks[i].goAgainCards > cappedGoAgainCards) then locks[i].goAgainCards = cappedGoAgainCards
					locks[i].greenCards = locks[i].initialGreenCards
					locks[i].greensPickedSinceReset = 0
					locks[i].hideGreensUntilPickCount = 0
					if (locks[i].lockFrozenByCard = 1 and locks[i].timestampFrozenByCard > 0)
						locks[i].totalTimeFrozen = locks[i].totalTimeFrozen + (timestampAutoReset - locks[i].timestampFrozenByCard)
						locks[i].timestampFrozenByCard = 0
					endif
					locks[i].lockFrozenByCard = 0
					if (locks[i].lockFrozenByKeyholder = 1 and locks[i].timestampFrozenByKeyholder > 0)
						locks[i].totalTimeFrozen = locks[i].totalTimeFrozen + (timestampAutoReset - locks[i].timestampFrozenByKeyholder)
						locks[i].timestampFrozenByKeyholder = 0
					endif
					locks[i].lockFrozenByKeyholder = 0
					locks[i].noOfAdd1Cards = locks[i].initialYellowAdd1Cards
					locks[i].noOfAdd2Cards = locks[i].initialYellowAdd2Cards
					locks[i].noOfAdd3Cards = locks[i].initialYellowAdd3Cards
					locks[i].noOfMinus1Cards = locks[i].initialYellowMinus1Cards
					locks[i].noOfMinus2Cards = locks[i].initialYellowMinus2Cards
					locks[i].pickedCountSinceReset = 0
					locks[i].readyToUnlock = 0
					locks[i].redCards = locks[i].initialRedCards
					if (locks[i].regularity# = 0.016667) then locks[i].timestampLastPicked = timestampAutoReset - 60
					if (locks[i].regularity# = 0.25) then locks[i].timestampLastPicked = timestampAutoReset - 900
					if (locks[i].regularity# = 0.5) then locks[i].timestampLastPicked = timestampAutoReset - 1800
					if (locks[i].regularity# = 1) then locks[i].timestampLastPicked = timestampAutoReset - 3600
					if (locks[i].regularity# = 3) then locks[i].timestampLastPicked = timestampAutoReset - 10800
					if (locks[i].regularity# = 6) then locks[i].timestampLastPicked = timestampAutoReset - 21600
					if (locks[i].regularity# = 12) then locks[i].timestampLastPicked = timestampAutoReset - 43200
					if (locks[i].regularity# = 24) then locks[i].timestampLastPicked = timestampAutoReset - 86400
					locks[i].resetCards = locks[i].initialResetCards
					locks[i].stickyCards = locks[i].initialStickyCards
					locks[i].timestampLastAutoReset = timestampAutoReset
					if (locks[i].regularity# = 0.016667)
						locks[i].timestampLastPicked = timestampAutoReset - 60
					else
						locks[i].timestampLastPicked = timestampAutoReset - (locks[i].regularity# * 3600)
					endif
					locks[i].timestampLastReset = timestampAutoReset
					locks[i].timestampRequestedKeyholdersDecision = 0
					locks[i].yellowCards = locks[i].noOfAdd1Cards + locks[i].noOfAdd2Cards + locks[i].noOfAdd3Cards + locks[i].noOfMinus1Cards + locks[i].noOfMinus2Cards
					locks[i].noOfTimesAutoReset = locks[i].noOfTimesAutoReset + noOfAutoResetsSinceLast
					locks[i].noOfTimesReset = locks[i].noOfTimesReset + noOfAutoResetsSinceLast
					locks[i].timestampRibbonAdded = timestampNow
					locks[i].ribbonType$ = "Auto Reset Lock"
					inc noOfLocksAutoReset
					UpdateLocksData(i)
					UpdateLocksDatabase(i, "action:AutoResetLock;actionedBy:App;result:" + str(timestampAutoReset) + ";totalActionTime:" + str(noOfAutoResetsSinceLast * locks[i].resetFrequencyInSeconds), 0)
				endif
			endif
		next
		if (noOfLocksAutoReset > 0) then SetScreenToView(constMyLocksScreen)
	endif
	if (oryUIDialogVisible = 0 and noOfLocksAutoReset > 0 and screenNo = constMyLocksScreen)
		noOfLocksAutoReset = 0
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock(s) Auto Reset;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:One or more of your locks have auto reset.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif
	
	// LOCK UPDATES
	if (oryUIDialogVisible = 0 and lockUpdatesDialogMessage$ <> "" and screenNo = constMyLocksScreen)
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:" + lockUpdatesDialogTitle$ + ";titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + lockUpdatesDialogMessage$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
		lockUpdatesDialogMessage$ = ""
		lockUpdatesDialogTitle$ = ""
		noOfLockUpdatesAvailable = 0
	endif
	
	// PLEASE WAIT WHEEL
	if (redrawScreen = 1)
		if (screenNo = constSplashScreen or screenNo = constLoginScreen or screenNo = constRegisterScreen)
			OryUIUpdateProgressIndicator(pleaseWait, "size:-1,15;colorID:" + str(theme[themeSelected].color[3]))
		else
			OryUIUpdateProgressIndicator(pleaseWait, "size:-1,10;colorID:" + str(theme[themeSelected].color[3]))
		endif
	endif
	showPleaseWaitWheel = 0
	if (OryUIGetHTTPSQueueItemCount(httpsQueue) > 0 and offline = 0) then showPleaseWaitWheel = 1
	if (screenNo <> constSplashScreen)
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetKeyholdersData) = 1) then showPleaseWaitWheel = 0
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLocksData) = 1)
			if (screenNo <> constSharedLocksScreen) then showPleaseWaitWheel = 0
		endif
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData) = 1)
			if (screenNo <> constManageLockedUsersScreen and screenNo <> constManageUnlockedUsersScreen and screenNo <> constManageDesertedUsersScreen) then showPleaseWaitWheel = 0
		endif
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].UpdateAccount) = 1)
			if (screenNo <> constSettingsScreen) then showPleaseWaitWheel = 0
		endif
		if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].UpdateLocksDatabase) = 1)
			if (screenNo = constCardsScreen)
				if (largeCardVisible = 0 or noOfChances > 1) then showPleaseWaitWheel = 0
				if (left(deck[shuffledDeck[cardChosen]].value$, 6) = "Yellow") then showPleaseWaitWheel = 0
				if (deck[shuffledDeck[cardChosen]].value$ = "Freeze") then showPleaseWaitWheel = 1
				if (noOfChances = 0 and deck[shuffledDeck[cardChosen]].value$ = "Green") then showPleaseWaitWheel = 1
				if (noOfChances = 1 and deck[shuffledDeck[cardChosen]].value$ = "Red") then showPleaseWaitWheel = 1
				if (noOfChances = 1 and deck[shuffledDeck[cardChosen]].value$ = "Sticky") then showPleaseWaitWheel = 1
			endif
		endif
	endif
	if (screenNo = constCreateLocksScreen) then showPleaseWaitWheel = 0
	if (screenNo = constRandomCombinationsScreen) then showPleaseWaitWheel = 0
	if (screenNo = constSetCombinationScreen) then showPleaseWaitWheel = 0
	if (screenNo = constShareLockScreen) then showPleaseWaitWheel = 0	
	if (OryUIGetNavigationDrawerVisible(navigationDrawer) = 1) then showPleaseWaitWheel = 0
	if (oryUIDialogVisible = 1) then showPleaseWaitWheel = 0
	if (showPleaseWaitWheel = 1)
		OryUIUpdateProgressIndicator(pleaseWait, "position:50,50")
	else
		OryUIUpdateProgressIndicator(pleaseWait, "position:-1000,-1000")
	endif
	
	// OFFLINE
	offlineReason$ as string : offlineReason$ = ""
	offlineWaitTime as integer : offlineWaitTime = 0
	if (GetInternetState() = 0) then noInternet = 1
	if (offline = 1 and GetInternetState() = 1) then offlineReason$ = "Connection Problem"
	if (offline = 1 and GetInternetState() = 0) then offlineReason$ = "No Internet Connection"
	if (maintenance = 1) then offlineReason$ = "Server Maintenance"
	if ((maintenance = 1 or offline = 1 and oryUIDialogVisible = 0) and OryUIGetNavigationDrawerVisible(navigationDrawer) = 0)
		SetAdvertVisible(0)
		OryUIUpdateSprite(sprOfflineMode, "position:" + str(GetViewOffsetX()) + "," + str(GetViewOffsetY() + screenBoundsTop# + 91))
		if (GetInternetState() = 0)
			OryUIUpdateText(txtOfflineMode, "text:Offline (" + offlineReason$ + ")" + chr(10) + "Connect to Wi-Fi or mobile data" + chr(10) + "Tap to try again now")
		else
			if (60 - mod(secondsRunning, 60) > 1) then OryUIUpdateText(txtOfflineMode, "text:Offline (" + offlineReason$ + ")" + chr(10) + "Will try to connect again in " + str(60 - mod(secondsRunning, 60)) + " seconds" + chr(10) + "Tap to try again now")
			if (60 - mod(secondsRunning, 60) = 1) then OryUIUpdateText(txtOfflineMode, "text:Offline (" + offlineReason$ + ")" + chr(10) + "Will try to connect again in 1 second" + chr(10) + "Tap to try again now")
			if (OryUIIsNameInHTTPSQueue(httpsQueue, "GetServerVariables")) then OryUIUpdateText(txtOfflineMode, "text:Checking Connection" + chr(10) + "Please Wait...")
			// FAILED TO CONNECT
			if (OryUIGetHTTPSQueueFailedCount(httpsQueue) >= 10)
				OryUIClearHTTPSQueue(httpsQueue)
				OryUIResetHTTPSQueueFailedCount(httpsQueue)
				SetOfflineValue(1)
			endif
		endif
		OryUIPinTextToCentreOfSprite(txtOfflineMode, sprOfflineMode, 0, 0)
	else
		OryUIUpdateSprite(sprOfflineMode, "position:-1000,-1000")
		OryUIUpdateText(txtOfflineMode, "position:-1000,-1000")
	endif
	if (offline = 1 and screenNo = constCardsScreen)
		ClearLargeCard()
		OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
		OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
		cardChosen = 0
		cardSelected = 0
		screenNo = selectedLocksTab
		SetScreenToView(selectedLocksTab)
	endif
	if (OryUIGetSpriteReleased() = sprOfflineMode)
		GetServerVariables(1)
		GetAccountData(0)
	endif
	
	OryUIAnimateTooltip(tooltip)
	
syncScreen:	
	OryUIEndTrackingTouch()

	redrawScreen = 0
	UpdateAllTweens(GetFrameTime())
	Sync()

    if (notificationsOn = 2)
		pushNotificationToken$ = ""
	else
		if (pushNotificationToken$ = "" and (store$ = "App Store" or store$ = "Google Play") and offline = 0) then RequestPushNotificationToken()
	endif
	
	if (GetResumed())
		resumed = 1
		timestampBeforeResumed as integer : timestampBeforeResumed = lastFrameUnixTime
		timestampResumed as integer : timestampResumed = GetUnixTime()
		if (timestampResumed - timestampBeforeResumed >= 300)
			if (OryUIHTTPSQueueCollection[httpsQueue].http > 0)
				OryUIDeleteHTTPSQueue(httpsQueue)
				httpsQueue = OryUICreateHTTPSQueue("domain:" + domain$ + ";ssl:" + str(ssl) + ";delay:0.05;timeout:10000")
				//OryUIHTTPSQueueCollection[httpsQueue].http = CreateHTTPConnection()
				//SetHTTPHost(OryUIHTTPSQueueCollection[httpsQueue].http, OryUIHTTPSQueueCollection[httpsQueue].domain$, OryUIHTTPSQueueCollection[httpsQueue].ssl)
				//SetHTTPTimeout(OryUIHTTPSQueueCollection[httpsQueue].http, OryUIHTTPSQueueCollection[httpsQueue].timeout)
			endif
		endif
		if (screenNo = constCardsScreen and ((timestampResumed - timestampBeforeResumed >= 30) or timestampNow < 1500000000))
			OryUIHideDialog(dialog)
			ClearLargeCard()
			OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
			OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
			cardChosen = 0
			cardSelected = 0
			secondsLast5MinuteRefresh = GetSeconds()
			secondsLast1MinuteRefresh = GetSeconds()
			timestampFromServer = 0
			timestampNow = 0
			GetServerVariables(1)
			ClearBreadcrumbs()
			screenToView = selectedLocksTab
			changingScreen = 1
			AddBreadcrumb(selectedLocksTab)
		elseif (timestampResumed - timestampBeforeResumed >= 15)
			if (OryUIGetNavigationDrawerVisible(navigationDrawer)) then OryUIHideNavigationDrawer(navigationDrawer)
			secondsLast5MinuteRefresh = GetSeconds()
			secondsLast1MinuteRefresh = GetSeconds()
			GetServerVariables(1)
			if (screenNo = constMyLocksScreen or screenNo = constSharedLocksScreen) then ClearBreadcrumbs()
			screenToView = screenNo
			changingScreen = 1
			AddBreadcrumb(screenNo)
		endif
	endif
	if (screenNo <> constSplashScreen and screenNo <> constLoginScreen and screenNo <> constSetCombinationScreen and screenNo <> constRandomCombinationsScreen)
		if (resumed = 1 and timestampNow > 1500000000 and noOfLocksAutoReset = 0)
			resumed = 0
			GetLocksData()
			GetAccountData(0)
			if (screenNo = constSharedLocksScreen)
				GetSharedLocksData(1)
				if (OryUIGetNavigationDrawerVisible(navigationDrawer) = 0 and noOfLocks > 0)
					GetKeyholdersData(0)
					GetLockUpdates(0)
				endif
			else
				if (OryUIGetNavigationDrawerVisible(navigationDrawer) = 0 and noOfLocks > 0)
					GetKeyholdersData(0)
					GetLockUpdates(0)
				endif
				GetSharedLocksData(0)
			endif
			UpdateAccount(0)
			if (screenNo = constMyLocksScreen)
				ClearBreadcrumbs()
				screenToView = screenNo
				changingScreen = 1
				AddBreadcrumb(screenNo)
			endif
		endif
		if (resumed = 0)
			if (OryUIGetSwipingVertically() = 0 and OryUIGetSwipingHorizontally() = 0)
				if (GetUnixTime() - timestampNow < -30 or GetUnixTime() - timestampNow > 30)
					if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetServerVariables) = 0)
						secondsLast5MinuteRefresh = GetSeconds()
						secondsLast1MinuteRefresh = GetSeconds()
						GetServerVariables(0)
						UpdateAccount(0)
						if (noOfLocks > 0)
							GetKeyholdersData(0)
							GetLockUpdates(0)
						endif
					endif
				endif
				if (GetSeconds() - secondsLast5MinuteRefresh < 0) then secondsLast5MinuteRefresh = GetSeconds()
				if (GetSeconds() - secondsLast5MinuteRefresh >= 300 and (screenNo = constMyLocksScreen or screenNo = constSharedLocksScreen))
					secondsLast5MinuteRefresh = GetSeconds()
					secondsLast1MinuteRefresh = GetSeconds()
					GetServerVariables(0)
					UpdateAccount(0)
					if (noOfLocks > 0)
						GetKeyholdersData(0)
						GetLockUpdates(0)
					endif
				endif
				if (GetSeconds() - secondsLast1MinuteRefresh < 0) then secondsLast1MinuteRefresh = GetSeconds()
				if (GetSeconds() - secondsLast1MinuteRefresh >= 60 and (screenNo = constMyLocksScreen or screenNo = constSharedLocksScreen) and OryUIGetNavigationDrawerVisible(navigationDrawer) = 0)
					secondsLast1MinuteRefresh = GetSeconds()
					if (offline = 1 or maintenance = 1) then GetServerVariables(1)
					if (noOfLocks > 0)
						GetKeyholdersData(0)
						GetLockUpdates(0)
					endif
				endif
			endif
		endif
		if (timestampNow < 1500000000 and offline = 0)
			SetOfflineValue(1)
			if (OryUIFindScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetServerVariables) = 0)
				secondsLast5MinuteRefresh = GetSeconds()
				secondsLast1MinuteRefresh = GetSeconds()
				timestampFromServer = 0
				timestampNow = 0
				GetServerVariables(1)
			endif
			if (screenNo = constCardsScreen)
				OryUIHideDialog(dialog)
				ClearLargeCard()
				OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
				OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
				cardChosen = 0
				cardSelected = 0
				ClearBreadcrumbs()
				screenToView = selectedLocksTab
				changingScreen = 1
				AddBreadcrumb(selectedLocksTab)
			endif
		endif
	endif
	
	if (FindString(GetURLSchemeText(), "oauth2/discord") > 0 or FindString(GetURLSchemeText(), "oauth2/twitter") > 0)
		if (FindString(GetURLSchemeText(), "loginUserID=") > 0)
			newAccount as integer : newAccount = 0
			oauth2$ as string : oauth2$ = ""
			for i = 1 to CountStringTokens(GetURLSchemeText(), "&")
				parameter$ as string : parameter$ = GetStringToken(GetURLSchemeText(), "&", i)
				variable$ as string : variable$ = TrimString(GetStringToken(parameter$, "=", 1), " ")
				value$ as string : value$ = GetStringToken(parameter$, "=", 2)
				if (variable$ = "loginUserID")
					loginUserID$ = ""
					charCount = 0
					intentPos as integer : intentPos = FindString(value$, "#Intent;")
					encryptedUserID$ as string : encryptedUserID$ = ""
					if (intentPos > 0)
						encryptedUserID$ = Mid(value$, 1, intentPos - 1)
					else
						encryptedUserID$ = value$
					endif
					decryptedUserID$ as string : decryptedUserID$ = Mid(encryptedUserID$, 1, Len(encryptedUserID$) - 1)
					for i = 1 to len(decryptedUserID$)
						tmpChar$ = mid(decryptedUserID$, i, 1)
						if (FindString("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", tmpChar$) > 0)
							loginUserID$ = loginUserID$ + upper(tmpChar$)
							inc charCount
							if (charCount = 5 or charCount = 10 or charCount = 15)
								loginUserID$ = loginUserID$ + "-"
							endif
						endif
					next
					if (len(loginUserID$) <> 23)
						OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Invalid Request;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was an error logging in. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
						OryUISetDialogButtonCount(dialog, 1)
						OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
						OryUIShowDialog(dialog)
					else
						OryUIUpdateTextfield(editBoxLoginUserID, "inputText:" + loginUserID$)
						CheckRestoreUserID(loginUserID$, 1)
					endif
				endif
				if (variable$ = "newAccount")
					newAccount = val(value$)
				endif
				if (variable$ = "oauth2")
					if (value$ = "discord") then oauth2$ = "Discord"
					if (value$ = "twitter") then oauth2$ = "Twitter"
				endif
			next
			ClearURLSchemeText()
			if (newAccount = 1)
				newAccount = 0
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:New Account Created;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was no " + constAppName$ + " account connected to your " + oauth2$ + " account, so a new " + constAppName$ + " account has been created." + chr(10) + chr(10) + "You can now log in with your " + oauth2$ + " account.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 1)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		else
			GetAccountData(1)
			ClearURLSchemeText()
		endif
		
	endif
	if (oryUIDialogVisible = 0 and FindString(GetURLSchemeText(), "sharedlock") > 0 and OryUIIsNameInHTTPSQueue(httpsQueue, "GetServerVariables") = 0 and offline = 0 and screenNo <> constSplashScreen)
		GetLocksData()
		if (disableCreationOfNewLocks = 1)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Creation Disabled;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Creation of new locks have been disabled." + chr(10) + chr(10) + "Check out the " + constAppName$ + " Discord server or forums for news.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (left(username$, 3) = "CKU")
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can load shared locks you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		elseif (noOfLocks >= 20)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Too Many Locks;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You have the maximum number of locks allowed, and can't load anymore." + chr(10) + chr(10) + "You would need to finish or delete some from your list before you can start any new locks.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			loadingSharedLock = 1
			sharedID$ = upper(GetStringToken(Mid(GetURLSchemeText(), FindString(GetURLSchemeText(), "sharedlock", 1, 0) + 10, -1), "/", 1))
			sharedLockName$ = ""
			sharedLockError$ = ""
			sharedLockInfo$ = ""
			GenerateCombination(noOfDigits, 1)
			GetSharedLockInformation(sharedID$, 1)
		endif
		ClearURLSchemeText()
	endif
	
	lastFrameUnixTime = GetUnixTime()
loop

#insert "FunctionsCommon.agc"
#insert "Functions.agc"

OryUIDeleteHTTPSQueue(httpsQueue)

