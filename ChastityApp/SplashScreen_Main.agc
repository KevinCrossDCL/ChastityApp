
OryUISetScreenZoomLimits(1, 1)

if (screenToView = constSplashScreen)
	screenNo = constSplashScreen
	
	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprLoginBackground, "position:" + str(screenNo * 100) + "," + str(elementY#))
		OryUIUpdateSprite(sprLoginAppLogo, "position:" + str((constSplashScreen * 100) + 50) + ",50")
	endif
	
	if (OryUIGetHTTPSQueueFailedCount(httpsQueue) < 10)
				
		// ACCEPT TERMS
		if (splashScreenStage$ = "Accept Terms")
			if (accept20200516TermsAlertHidden = 0)
				if (OryUIGetDialogVisible(dialog) = 0)
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Accept Terms;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:By continuing to use " + constAppName$ + " you will be agreeing to the Terms & Conditions and the Privacy Policy" + chr(10) + chr(10) + "Last Updated May 16th 2020;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 3)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ViewTerms;text:View Terms & Conditions;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ViewPrivacy;text:View Privacy Policy;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Accept;text:Accept;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
			else
				splashScreenStage$ = "Connect to Server"
			endif
			if (OryUIGetDialogButtonReleasedByName(dialog, "ViewTerms"))
				OryUIHideDialog(dialog)
				OpenBrowser(constAppMarketingDomain$ + "/terms-conditions")
				SetScreenToView(constSplashScreen)
			endif
			if (OryUIGetDialogButtonReleasedByName(dialog, "ViewPrivacy"))
				OryUIHideDialog(dialog)
				OpenBrowser(constAppMarketingDomain$ + "/privacy-policy")
				SetScreenToView(constSplashScreen)
			endif
			if (OryUIGetDialogButtonReleasedByName(dialog, "Accept"))
				splashScreenStage$ = "Connect to Server"
				OryUIHideDialog(dialog)
				accept20200516TermsAlertHidden = 1
				SaveLocalVariable("accept20200516TermsAlertHidden", str(accept20200516TermsAlertHidden))
				SetScreenToView(constSplashScreen)
			endif
		endif
	
		// CONNECT TO SERVER
		if (splashScreenStage$ = "Connect to Server")
			splashScreenStage$ = "Connecting to Server"
			GetServerVariables(1)
		endif
		if (splashScreenStage$ = "Connecting to Server")
			if (timestampFromServer > 1500000000)
				OryUIUpdateText(txtSplashScreenLoadingLine, "text: ;")
				SetRandomSeed(timestampNow)
				databaseRandomSeed = timestampNow
				if (userID$ = "")
					splashScreenStage$ = "Check Cloud for User ID"
				else
					splashScreenStage$ = "Get Account Data"
					GetLocksData()
				endif
			endif
		endif
		
		// CHECK CLOUD FOR USER ID
		if (splashScreenStage$ = "Check Cloud for User ID")
			cloudName$ as string
			if (GetDeviceBaseName() = "android") then cloudName$ = "Google Cloud"
			if (GetDeviceBaseName() = "ios") then cloudName$ = "iCloud"
			if (GetCloudDataVariable(lower(constAppName$) + ".userID", "") <> "")
				if (OryUIGetDialogVisible(dialog) = 0)
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:" + cloudName$ + " Data Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:A user ID was found in your " + cloudName$ + " account from a previous install or a different device. Would you like to use and login with this user ID?" + chr(10) + chr(10) + GetCloudDataVariable(lower(constAppName$) + ".userID", "") + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 2)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesRestoreFromCloud;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:No;text:No;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
				if (OryUIGetDialogButtonReleasedByName(dialog, "YesRestoreFromCloud"))
					splashScreenStage$ = "Restore Account"
					OryUIHideDialog(dialog)
					userID$ = GetCloudDataVariable(lower(constAppName$) + ".userID", "")
					SaveLocalVariable("userID", userID$)
				endif
				if (OryUIGetDialogButtonReleasedByName(dialog, "No"))
					splashScreenStage$ = "Display Login Screen"
					OryUIHideDialog(dialog)
					SetScreenToView(constLoginScreen)
				endif
			else
				if (userID$ = "")
					splashScreenStage$ = "Display Login Screen"
					SetScreenToView(constLoginScreen)
				else
					splashScreenStage$ = "Restore Account"
				endif
			endif
		endif
		
		// LOGIN SCREEN
		
		// CREATE NEW ACCOUNT
		if (splashScreenStage$ = "Create New Account")
			OryUIUpdateProgressIndicator(splashScreenLoadBar, "position:" + str((constSplashScreen * 100) + 10) + ",94")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 0)
			splashScreenStage$ = "Creating New Account"
			ResetData()
			OryUIUpdateText(txtSplashScreenLoadingLine, "text:Setting Up New Account...")
			userID$ = RandomUserID()
			CheckNewUserID(1)
		endif

		// RESTORE ACCOUNT
		if (splashScreenStage$ = "Restore Account")
			if (userID$ = "")
				splashScreenStage$ = "Display Login Screen"
				SetScreenToView(constLoginScreen)
			endif
			OryUIUpdateProgressIndicator(splashScreenLoadBar, "position:" + str((constSplashScreen * 100) + 10) + ",94")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 14.28)
			OryUIUpdateText(txtSplashScreenLoadingLine, "text: ;")
			splashScreenStage$ = "Restoring Account"
			RestoreAccount(userID$, 1)
		endif
		
		// GET ACCOUNT DATA
		if (splashScreenStage$ = "Get Account Data")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 28.57)
			splashScreenStage$ = "Getting Account Data"
			GetAccountData(1)
		endif

		// GET KEYHOLDERS DATA
		if (splashScreenStage$ = "Get Keyholders Data")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 42.85)
			splashScreenStage$ = "Getting Keyholders Data"
			GetKeyholdersData(1)
		endif
		
		// GET LOCK UPDATES
		if (splashScreenStage$ = "Get Lock Updates")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 57.14)
			splashScreenStage$ = "Getting Lock Updates"
			GetLockUpdates(1)
		endif
		
		// GET SHARED LOCKS DATA
		if (splashScreenStage$ = "Get Shared Locks Data")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 71.42)
			splashScreenStage$ = "Getting Shared Locks Data"
			GetSharedLocksData(1)
		endif
		
		// GET RELATIONS
		if (splashScreenStage$ = "Get Relations")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 85.71)
			splashScreenStage$ = "Getting Relations"
			GetYourRelations(1)
		endif
		
		// LAST STAGE
		if (splashScreenStage$ = "Last Stage")
			OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 100)
			if (notificationsOn = 2)
				pushNotificationToken$ = ""
			else
				if (pushNotificationToken$ = "" and (store$ = "App Store" or store$ = "Google Play") and offline = 0) then RequestPushNotificationToken()
			endif
			UpdateAccount(0)
			GetAPIProjects(0)
			if (GetInAppPurchaseAvailable(0) = 1)
				adsRemoved = 1
				SaveLocalVariable("adsRemoved", "1")
			endif
			SetScreenToView(selectedLocksTab)
		endif

		OryUIInsertHTTPSQueueListener(httpsQueue)
	endif
	
	// FAILED TO CONNECT
	if (OryUIGetHTTPSQueueFailedCount(httpsQueue) >= 10)
//~		if (userID$ <> "" and userDBRow > 0)
//~			if (timestampFromServer <= 1500000000)
//~				if (OryUIGetDialogVisible(dialog) = 0)
//~					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Connection Problem;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + constAppName$ + " is experiencing problems connecting to the server." + chr(10) + chr(10) + "It will now go into offline mode.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
//~					OryUISetDialogButtonCount(dialog, 1)
//~					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
//~					OryUIShowDialog(dialog)
//~				endif
//~			endif
//~			if (OryUIGetDialogButtonReleasedByName(dialog, "Ok"))
//~				OryUIClearHTTPSQueue(httpsQueue)
//~				OryUIResetHTTPSQueueFailedCount(httpsQueue)
//~				SetOfflineValue(1)
//~				OryUIHideDialog(dialog)
//~				SetScreenToView(selectedLocksTab)
//~			endif
//~		else
			if (OryUIGetDialogVisible(dialog) = 0)
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Connection Problem;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + constAppName$ + " is experiencing problems connecting to the server." + chr(10) + chr(10) + "Please try again later.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ViewStatusPage;text:View Status Page;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
			if (OryUIGetDialogButtonReleasedByName(dialog, "ViewStatusPage"))
				OryUIClearHTTPSQueue(httpsQueue)
				OryUIResetHTTPSQueueFailedCount(httpsQueue)
				SetOfflineValue(1)
				OryUIHideDialog(dialog)
				OpenBrowser(constAppStatusDomain$)
				//SetScreenToView(selectedLocksTab)
			endif
			if (OryUIGetDialogButtonReleasedByName(dialog, "Ok"))
				OryUIClearHTTPSQueue(httpsQueue)
				OryUIResetHTTPSQueueFailedCount(httpsQueue)
				SetOfflineValue(1)
				OryUIHideDialog(dialog)
				//SetScreenToView(selectedLocksTab)
			endif
//~		endif
	endif
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, 0)
endif
