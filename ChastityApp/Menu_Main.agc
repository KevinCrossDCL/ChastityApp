
// MAIN
oryUIDefaults.navigationDrawerColor#[1] = GetColorRed(colorMode[colorModeSelected].navigationDrawerColor)
oryUIDefaults.navigationDrawerColor#[2] = GetColorGreen(colorMode[colorModeSelected].navigationDrawerColor)
oryUIDefaults.navigationDrawerColor#[3] = GetColorBlue(colorMode[colorModeSelected].navigationDrawerColor)
oryUIDefaults.navigationDrawerColor#[4] = 255
oryUIDefaults.navigationDrawerShowOptionRightText = 1
oryUIDefaults.navigationDrawerShowShadow = 1

// STATUS BAR
oryUIDefaults.navigationDrawerStatusBarColor#[1] = GetColorRed(colorMode[colorModeSelected].navigationDrawerStatusBarColor)
oryUIDefaults.navigationDrawerStatusBarColor#[2] = GetColorGreen(colorMode[colorModeSelected].navigationDrawerStatusBarColor)
oryUIDefaults.navigationDrawerStatusBarColor#[3] = GetColorBlue(colorMode[colorModeSelected].navigationDrawerStatusBarColor)
oryUIDefaults.navigationDrawerStatusBarColor#[4] = 255

// SUBTITLE
oryUIDefaults.navigationDrawerSubtitleColor#[1] = GetColorRed(colorMode[colorModeSelected].navigationDrawerSubtitleColor)
oryUIDefaults.navigationDrawerSubtitleColor#[2] = GetColorGreen(colorMode[colorModeSelected].navigationDrawerSubtitleColor)
oryUIDefaults.navigationDrawerSubtitleColor#[3] = GetColorBlue(colorMode[colorModeSelected].navigationDrawerSubtitleColor)
oryUIDefaults.navigationDrawerSubtitleColor#[4] = 255
oryUIDefaults.navigationDrawerSubtitleTextColor#[1] = 255
oryUIDefaults.navigationDrawerSubtitleTextColor#[2] = 255
oryUIDefaults.navigationDrawerSubtitleTextColor#[3] = 255
oryUIDefaults.navigationDrawerSubtitleTextColor#[4] = 255
oryUIDefaults.navigationDrawerSubtitleTextLeftPadding# = 3.5

// OPTION
oryUIDefaults.navigationDrawerOptionActiveOverlayColor#[1] = GetColorRed(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionActiveOverlayColor#[2] = GetColorGreen(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionActiveOverlayColor#[3] = GetColorBlue(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionActiveOverlayColor#[4] = 66
oryUIDefaults.navigationDrawerOptionColor#[1] = GetColorRed(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionColor#[2] = GetColorGreen(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionColor#[3] = GetColorBlue(colorMode[colorModeSelected].navigationDrawerOptionActiveOverlayColor)
oryUIDefaults.navigationDrawerOptionColor#[4] = 255
oryUIDefaults.navigationDrawerOptionIconColor#[1] = GetColorRed(colorMode[colorModeSelected].textColor)
oryUIDefaults.navigationDrawerOptionIconColor#[2] = GetColorGreen(colorMode[colorModeSelected].textColor)
oryUIDefaults.navigationDrawerOptionIconColor#[3] = GetColorBlue(colorMode[colorModeSelected].textColor)
oryUIDefaults.navigationDrawerOptionIconColor#[4] = 255
oryUIDefaults.navigationDrawerOptionRightTextColor#[1] = 241
oryUIDefaults.navigationDrawerOptionRightTextColor#[2] = 196
oryUIDefaults.navigationDrawerOptionRightTextColor#[3] = 15
oryUIDefaults.navigationDrawerOptionRightTextColor#[4] = 255
oryUIDefaults.navigationDrawerOptionTextColor#[1] = 255
oryUIDefaults.navigationDrawerOptionTextColor#[2] = 255
oryUIDefaults.navigationDrawerOptionTextColor#[3] = 255
oryUIDefaults.navigationDrawerOptionTextColor#[4] = 255

navigationDrawerItems as integer : navigationDrawerItems = 26 // 26

navigationDrawerItemCount as integer : navigationDrawerItemCount = 0
if (disableCreationOfNewLocks = 0 and noOfLocks < 20 and offline = 0 and maintenance = 0 and timestampNow > 1500000000) then navigationDrawerItems = navigationDrawerItems + 2
if (disableCreationOfNewLocks = 0) then navigationDrawerItems = navigationDrawerItems + 2 // Shared Locks and Lock Templates
if (offline = 0 and maintenance = 0 and timestampNow > 1500000000) then navigationDrawerItems = navigationDrawerItems + 3
if (adsRemoved = 0 and offline = 0 and maintenance = 0) then navigationDrawerItems = navigationDrawerItems + 1
if (GetDeviceBaseName() = "ios") then navigationDrawerItems = navigationDrawerItems + 1
//~if (allowAccountTransfers = 1 and offline = 0 and maintenance = 0) then navigationDrawerItems = navigationDrawerItems + 1
OryUISetNavigationDrawerItemCount(navigationDrawer, navigationDrawerItems)

inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:ACCOUNT")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Profile;itemType:option;text:Profile;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:RecentActivity;itemType:option;text:Recent Activity;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Friends;itemType:option;text:Friends;rightText:;")
//~if (allowAccountTransfers = 1 and offline = 0 and maintenance = 0)
//~	inc navigationDrawerItemCount
//~	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:TransferAccount;itemType:option;text:Transfer Account;rightText:;")
//~endif
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:ShowMyUserID;itemType:option;text:Show My User ID;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:LogOut;itemType:option;text:Log Out;rightText:;")

inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:MY LOCKS (" + str(noOfLocks) + "/20)")
if (disableCreationOfNewLocks = 0 and noOfLocks < 20 and offline = 0 and maintenance = 0 and timestampNow > 1500000000)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:NewMyLock;itemType:option;text:New Lock;rightText:;")
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:LoadLock;itemType:option;text:Load Lock;rightText:;")
endif
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:MyLocks;itemType:option;text:View Locks;rightText:;")
if (noOfLocks < 20 and offline = 0 and maintenance = 0 and timestampNow > 1500000000)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:MyLocksDeleted;itemType:option;text:My Deleted Locks;rightText:;")
endif
if (offline = 0 and maintenance = 0 and timestampNow > 1500000000)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:RefreshLocksFromServer;itemType:option;text:Refresh Locks From Server;rightText:;")
endif

inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:SHARED LOCKS (" + str(noOfSharedLocks) + ")")
if (disableCreationOfNewLocks = 0 and offline = 0 and maintenance = 0 and timestampNow > 1500000000)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:NewSharedLock;itemType:option;text:New Shared Lock;rightText:;")
endif
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:SharedLocks;itemType:option;text:View My Shared Locks;rightText:;")
if (offline = 0 and maintenance = 0 and timestampNow > 1500000000)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:SharedLocksDeleted;itemType:option;text:Deleted Shared Locks;rightText:;")
endif

inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:KEYS (" + str(noOfKeys) + ")")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Buy1Key;itemType:option;text:Buy 1 Key;rightText:" + GetInAppPurchaseLocalPrice(1))
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Buy2Keys;itemType:option;text:Buy 2 Keys;rightText:" + GetInAppPurchaseLocalPrice(2))
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Buy5Keys;itemType:option;text:Buy 5 Keys;rightText:" + GetInAppPurchaseLocalPrice(3))

inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:MORE")

//~inc navigationDrawerItemCount
//~OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:FindUsers;itemType:option;text:Find Users;rightText:;")

if (disableCreationOfNewLocks = 0)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:LockTemplates;itemType:option;text:Lock Templates;rightText:;")
endif
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:RandomCombinations;itemType:option;text:Random Combinations;rightText:;")
if (adsRemoved = 0 and offline = 0 and maintenance = 0)
	inc navigationDrawerItemCount
	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:RemoveAds;itemType:option;text:Remove Ads;rightText:" + GetInAppPurchaseLocalPrice(0))
endif
//~if (GetDeviceBaseName() = "ios")
//~	inc navigationDrawerItemCount
//~	OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:RestorePurchases;itemType:option;text:Restore Purchases;rightText:;")
//~endif
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Settings;itemType:option;text:Settings;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:About;itemType:option;text:About;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Help;itemType:option;text:Help;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:Forums;itemType:option;text:Forums;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:DiscordChat;itemType:option;text:Discord Chat;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:API;itemType:option;text:API;rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "name:KieraAnd" + constAppName$ + ";itemType:option;text:Kiera + " + constAppName$ + ";rightText:;")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:")
inc navigationDrawerItemCount
OryUIUpdateNavigationDrawerItem(navigationDrawer, navigationDrawerItemCount, "itemType:subtitle;subtitleText:")

if (screenNo = constMyLocksScreen) then OryUISetNavigationDrawerItemSelectedByName(navigationDrawer, "MyLocks")
if (screenNo = constSharedLocksScreen) then OryUISetNavigationDrawerItemSelectedByName(navigationDrawer, "SharedLocks")

OryUIInsertNavigationDrawerListener(navigationDrawer)
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "RecentActivity"))
	GetRecentActivity(1)
	SetScreenToView(constRecentActivityScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "NewMyLock"))
	sharedID$ = ""
	sharedLockName$ = ""
	sharedLockError$ = ""
	sharedLockInfo$ = ""	
	selectedLockOptionsTab = 1
	GenerateCombination(noOfDigits, 1)
	ResetNewLockOptions()
	OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)
	resetOptions = 1
	SetScreenToView(constLockOptionsScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "LoadLock"))
	sharedID$ = ""
	sharedLockName$ = ""
	sharedLockError$ = ""
	sharedLockInfo$ = ""	
	selectedLockOptionsTab = 2
	ResetNewLockOptions()
	SetScreenToView(constLockOptionsScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "MyLocks") and screenNo <> constMyLocksScreen)
	SetScreenToView(constMyLocksScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "MyLocksDeleted"))
	GetMyLocksDeleted(1)
	SetScreenToView(constMyLocksDeletedScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "RefreshLocksFromServer"))
	RestoreAccount(userID$, 1)
	//SetScreenToView(constMyLocksDeletedScreen)
endif

if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "NewSharedLock"))
	sharedID$ = ""
	sharedLockName$ = ""
	sharedLockError$ = ""
	sharedLockInfo$ = ""	
	selectedLockOptionsTab = 1
	ResetNewLockOptions()
	OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 2)
	resetOptions = 1
	SetScreenToView(constLockOptionsScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "SharedLocks") and screenNo <> constSharedLocksScreen)
	selectedLockOptionsTab = 2
	SetScreenToView(constSharedLocksScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "SharedLocksDeleted"))
	GetSharedLocksDeleted(1)
	SetScreenToView(constSharedLocksDeletedScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Friends"))
	SetScreenToView(constYourFollowersListScreen)
endif

if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "ShowMyUserID"))
	dialogShown$ = "ShowMyUserID"
	OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Save Your User ID;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + userID$ + chr(10) + chr(10) + "All of your locks are backed up online with the above user id. Please take a note of this unique user id in case you need to restore these locks on a new device, or after a new install. You can restore locks from another user id from the main menu." + chr(10) + chr(10) + "Please note that your user id and username are different and that locks can't be restored without your user id, even if you remember your username." + chr(10) + chr(10) + "Do not share your user id with others.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
	OryUISetDialogButtonCount(dialog, 2)
	OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CopyUserID;text:Copy User ID;textColorID:" + str(colorMode[colorModeSelected].textColor))
	OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
	OryUIShowDialog(dialog)
endif
if (OryUIGetDialogButtonReleasedByName(dialog, "CopyUserID"))
	SetClipboardText(userID$)
	OryUIUpdateTooltip(tooltip, "text:Copied to clipboard")
	OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
endif

if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Buy1Key"))
	if (PurchaseInApp(1) = 1)
		SavePurchasedKeys(1)
	endif
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Buy2Keys"))
	if (PurchaseInApp(2) = 1)
		SavePurchasedKeys(2)
	endif
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Buy5Keys"))
	if (PurchaseInApp(3) = 1)
		SavePurchasedKeys(5)
	endif
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Profile"))
	GetProfileData(userDBRow, 1)			
	SetScreenToView(constViewProfileScreen)
endif
//~if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "FindUsers"))
//~	SetScreenToView(constFindUsersScreen)
//~endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "LockTemplates"))
	SetScreenToView(constLockGeneratorScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "RandomCombinations"))
	SetScreenToView(constRandomCombinationsToolScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Settings"))
	SetScreenToView(constSettingsScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "RemoveAds"))
	if (PurchaseInApp(0) = 1)
		adsRemoved = 1
		SaveLocalVariable("adsRemoved", str(adsRemoved))
	endif
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "RestorePurchases"))
	InAppPurchaseRestore()
	if (GetInAppPurchaseAvailable(0) = 1)
		adsRemoved = 1
		SaveLocalVariable("adsRemoved", "1")
		if (oryUIDialogVisible = 0)
			dialogShown$ = "PurchasesRestored"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Purchases Restored;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Your previous purchase of the 'Removal of ads' in-app has been restored.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) +  ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:false")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	else
		if (oryUIDialogVisible = 0)
			dialogShown$ = "NoPurchaseHistory"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:No Purchase History Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:No purchase for the 'Removal of ads' in-app was found with your App Store account.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) +  ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:false")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	endif
endif
//~if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "TransferAccount"))
//~	SetScreenToView(constTransferAccountScreen)
//~endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "LogOut"))
	if (logoutAlertHidden = 0)
		if (oryUIDialogVisible = 0)
			dialogShown$ = "LogOut"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Log Out?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to log out?" + chr(10) + chr(10) + "Before logging out please make sure you have taken a screenshot of your user ID shown below, or have written it down. You will need it to log in to this account again." + chr(10) + chr(10) + userID$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesLogOut;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelLogOut;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	else
		LogOut()
	endif
endif
if (OryUIGetDialogButtonReleasedByName(dialog, "CancelLogOut"))
	if (OryUIGetDialogChecked(dialog) and dialogShown$ = "LogOut")
		logoutAlertHidden = 1
		SaveLocalVariable("logoutAlertHidden", str(logoutAlertHidden))
	endif
endif
if (OryUIGetDialogButtonReleasedByName(dialog, "YesLogOut"))
	if (OryUIGetDialogChecked(dialog) and dialogShown$ = "LogOut")
		logoutAlertHidden = 1
		SaveLocalVariable("logoutAlertHidden", str(logoutAlertHidden))
	endif
	splashScreenStage$ = "Display Login Screen"
	LogOut()
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "About"))
	SetScreenToView(constAboutScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Help"))
	OpenBrowser(constAppMarketingDomain$ + "/help/")
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "Forums"))
	OpenBrowser(constAppForums$)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "DiscordChat"))
	OpenBrowser(constFollowDiscord$)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "API"))
	SetScreenToView(constAPIDashboardScreen)
endif
if (OryUIGetNavigationDrawerItemReleasedByName(navigationDrawer, "KieraAnd" + constAppName$))
	OpenBrowser("https://kiera." + lower(constAppName$) + ".com")
endif
