
// HTTPS QUEUE
if (screenNo <> constSplashScreen and (oryUIScrimVisible = 0 or screenNo = constCardsScreen))
	OryUIInsertHTTPSQueueListener(httpsQueue)
endif



// ACCEPT FOLLOW REQUEST
if (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].AcceptFollowRequest)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Accepted Follow Request")
		OryUIUpdateTooltip(tooltip, "text:Request Approved")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		GetYourRelations(1)
	endif
	
	
	
// ADD NEW API PROJECT
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].AddNewAPIProject)
	ReceivedNewAPIProject()
	showAPIProject = apiProjects.length
	screen[screenNo].lastViewY# = GetViewOffsetY()
	SetScreenToView(constAPIDashboardScreen)


// ADD NEW SHARE ID
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].CreateNewSharedLock)
	sharedLockJustCreated = 1
	GetSharedLocksData(1)



// ADD NEW USER USER ID
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].AddNewUserID)
	GetAccountData(1)



// BLOCK USER
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].BlockUser)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Blocked")
		OryUIUpdateTooltip(tooltip, "text:User Blocked")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		GetYourRelations(1)
	endif
	
		
		
// CHECK NEW SHARE ID
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].CheckNewShareID)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "New")
		CreateNewSharedLock(1)
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Used")
		shareID$ = RandomShareID()
		CheckNewShareID(1)
	endif



// CHECK NEW USER ID
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].CheckNewUserID)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "New")
		splashScreenStage$ = "Restore Account"
		SaveLocalVariable("userID", userID$)
		AddNewUserID(1)
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Used")
		splashScreenStage$ = "Create New Account"
		userID$ = ""
	endif



// CHECK NEW USERNAME
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].CheckNewUsername)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Free")
		newUsername$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "CheckNewUsername=", "", -1)
		UpdateUsername(newUsername$, 1)
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Taken")
		newUsername$ = ""
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Username Taken;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:That username has already been taken. Please try another.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	else
		newUsername$ = ""
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Connection Error;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Username couldn't be checked. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif


// CHECK RESTORE USER ID
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].CheckRestoreID)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Exists")
		restoreUserID$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "CheckRestoreUserID=", "", -1)
		RestoreAccount(restoreUserID$, 1)
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Invalid")
		if (screenNo = constSplashScreen)
			LogOut()
			SetScreenToView(constLoginScreen)
		endif
		if (screenNo = constLoginScreen)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:User ID Not Recognised;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The user id you've entered is not recognised.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	endif
	
	

// DECLINE FOLLOW REQUEST
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DeclineFollowRequest)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Declined Follow Request")
		OryUIUpdateTooltip(tooltip, "text:Declined Request")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		GetYourRelations(1)
	endif
	
	
	
// DELETE API PROJECT
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DeleteAPIProject)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Deleted")
		apiProject as integer : apiProject = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "DeleteAPIProject=", "", -1))
		apiProjects.remove(apiProject)
		apiProjects.save("apiProjects.json")
		if (screenNo = constAPIDashboardScreen or screenNo = constAPIProjectSettingsScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constAPIDashboardScreen)
		endif
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Not Deleted")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Problem Deleting API Project;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was a problem deleting the API project. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:OkProblemDeletingAPIProject;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif



// DELETE LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DeleteLock)
	lockID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "DeleteMyLock=", "", -1))
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Deleted")
		lockNo = 0
		for i = 1 to 20
			if (locks[i].id = lockID)
				lockNo = i
				exit
			endif
		next
		if (lockNo >= 1 and lockNo <= 20)
			ReceivedDeleteLockResponse(lockNo)
			if (screenNo = constMyLocksScreen)
				screen[screenNo].lastViewY# = GetViewOffsetY()
				SetScreenToView(constMyLocksScreen)
			endif
		endif
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Not Deleted")
		lockNo = 0
		for i = 1 to 20
			if (locks[i].id = lockID)
				lockNo = i
				exit
			endif
		next
		if (lockNo >= 1 and lockNo <= 20)
			locks[lockNo].deleting = 0
		endif
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Problem Deleting Lock;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was a problem deleting the lock. Please try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:OkProblemDeletingMyLock;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	endif



// DELETE SHARED LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DeleteSharedLock)
	GetSharedLocksData(1)



// DISCONNECT DISCORD
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = "oauth2/discord/disconnect.php" or OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DisconnectDiscord)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "DisconnectedDiscord")
		discordDiscriminator = 0
		SaveLocalVariable("discordDiscriminator", str(discordDiscriminator))
		discordUsername$ = ""
		SaveLocalVariable("discordName", discordUsername$)
		discordID$ = ""
		SaveLocalVariable("discordID", discordID$)
		OryUIDeleteListItem(listConnectDiscord, 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constEditProfileScreen)
	endif



// DISCONNECT TWITTER
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = "oauth2/twitter/disconnect.php" or OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].DisconnectTwitter)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "DisconnectedTwitter")
		twitterHandle$ = ""
		SaveLocalVariable("twitterHandle", twitterHandle$)
		OryUIDeleteListItem(listConnectTwitter, 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constEditProfileScreen)
	endif



// FOLLOW USER
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].FollowUser)
	profileID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "FollowUser=", "", -1))
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Following")
		OryUIUpdateTooltip(tooltip, "text:Following User")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		if (screenNo = constViewProfileScreen) then inc profileData.followers
		GetYourRelations(1)
	elseif (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Request Sent Successfully")
		OryUIUpdateTooltip(tooltip, "text:Request Sent")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		GetYourRelations(1)
	endif

		

// GET ACCOUNT DATA
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetAccountData)
	splashScreenStage$ = "Get Keyholders Data"
	ReceivedAccountData()
	if (screenNo = constEditProfileScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constEditProfileScreen)
	endif



// GET API PROJECTS
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetAPIProjects)
	ReceivedAPIProjects()
	if (screenNo = constAPIDashboardScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constAPIDashboardScreen)
	endif

	

// GET KEYHOLDERS DATA
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetKeyholdersData)
	splashScreenStage$ = "Get Lock Updates"
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Locks")
		ReceivedKeyholdersData()
		if (screenNo = constMyLocksScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(screenNo)
		endif
	endif
	
	
	
// GET LOCK LOG
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetLockLog)
	lockID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "GetLockLog=", "", -1))
	lockNo = 0
	for i = 1 to 20
		if (locks[i].id = lockID)
			lockNo = i
			exit
		endif
	next
	if (lockNo > 0)
		ReceivedLockLog(lockNo)
		if (screenNo = constLockLogScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constLockLogScreen)
		endif
	endif



// GET LOCK TEMPLATES
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetLockTemplates)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Matches")
		ReceivedGeneratedLocks()
		if (screenNo = constLockGeneratorResultsScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(screenNo)
		endif
	endif
	
	
	
// GET LOCK UPDATES
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetLockUpdates)
	splashScreenStage$ = "Get Shared Locks Data"
	noOfLockUpdatesAvailable = 0
	timestampLastReceivedUpdateResponse = timestampNow
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Updates")
		lockUpdatesDialogMessage$ = ReceivedLockUpdates()
		if (noOfLockUpdatesAvailable = 1) then lockUpdatesDialogTitle$ = "Lock Updated"
		if (noOfLockUpdatesAvailable > 1) then lockUpdatesDialogTitle$ = "Locks Updated"
		if (screenNo = constMyLocksScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(screenNo)
		endif
	endif



// GET MY LOCKS DELETED
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetMyLocksDeleted)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Deleted Locks")
		ReceivedMyLocksDeleted()
		SetScreenToView(constMyLocksDeletedScreen)
	endif
	
	

// GET OTHERS RELATIONS
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetOthersRelations)
	ReceivedOthersRelations()
	if (screenNo = constOthersFollowersListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constOthersFollowersListScreen)
	endif
	if (screenNo = constOthersFollowingListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constOthersFollowingListScreen)
	endif
	if (screenNo = constViewProfileScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constViewProfileScreen)
	endif
	
	
	
// GET PROFILE DATA
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetProfileData)
	profileID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "GetProfileData=", "", -1))
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Profile Found")
		ReceivedProfileData()
		if (screenNo = constViewProfileScreen)
			SetScreenToView(constViewProfileScreen)
		endif
	endif

	

// GET SERVER VARIABLES
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetServerVariables)
	ReceivedServerVariables()



// GET SHARED LOCK INFORMATION
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetSharedLockInformation)
	if (left(OryUIGetHTTPSQueueRequestResponse(httpsQueue), 5) = "Error")
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = mid(OryUIGetHTTPSQueueRequestResponse(httpsQueue), 7, -1)
		if (sharedLockError$ = "Congratulations, your Discord has been linked to your account.")
			GetAccountData(1)
		else
			selectedLockOptionsTab = 2
			SetScreenToView(constLockOptionsScreen)
		endif
	else
		ReceivedSharedLockInformation()
		selectedLockOptionsTab = 2
		SetScreenToView(constLockOptionsScreen)
	endif



// GET SHARED LOCKS
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetSharedLocksData)
	splashScreenStage$ = "Get Relations"
	ReceivedSharedLocksData()
	if (screenNo = constSharedLocksScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLocksScreen)
	endif
	if (screenNo = constSharedLocksDeletedScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLocksDeletedScreen)
	endif	
	if (screenNo = constSharedLockInformationScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constSharedLockInformationScreen)
	endif
	if (sharedLockJustCreated = 1)
		sharedLockJustCreated = 0
		sharedLockSelected = 1
		shareID$ = sharedLocks[sharedLockSelected, 0].shareID$
		encodedQRCode = EncodeQRCode(constAppName$ + "-Shareable-Lock-" + shareID$, 0)
		SaveImage(encodedQRCode, shareID$ + ".png")
		SetScreenToView(constShareLockScreen)
	endif



// GET SHARED LOCKS DELETED
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetSharedLocksDeleted)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "No Deleted Locks")
		ReceivedSharedLocksDeleted()
		SetScreenToView(constSharedLocksDeletedScreen)
	endif
	
	
	
// GET SHARED LOCK USERS
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData)
	sharedLockParameters$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "GetSharedLockUsersData=", "", -1)
	sharedLockNo = 0
	if (CountStringTokens(sharedLockParameters$, ",") = 2)
		sharedLockID$ as string : sharedLockID$ = GetStringToken(sharedLockParameters$, ",", 1)
		usersTab = val(GetStringToken(sharedLockParameters$, ",", 2))
	endif
	for i = 0 to sharedLocks.length - 1
		if (sharedLocks[i, 0].shareID$ = sharedLockID$)
			sharedLockNo = i
			exit
		endif
	next
	if (sharedLockNo > 0)
		ReceivedSharedLockUserData(sharedLockNo, usersTab)
		if (screenNo = constManageLockedUsersScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constManageLockedUsersScreen)
		endif
		if (screenNo = constManageUnlockedUsersScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constManageUnlockedUsersScreen)
		endif
		if (screenNo = constManageDesertedUsersScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constManageDesertedUsersScreen)
		endif
	endif



// GET USER LOG
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetUserLog)
	sharedLockParameters$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "GetUserLog=", "", -1)
	sharedLockNo = 0
	if (CountStringTokens(sharedLockParameters$, ",") = 3)
		sharedLockNo = val(GetStringToken(sharedLockParameters$, ",", 1))
		userNo = val(GetStringToken(sharedLockParameters$, ",", 2))
		usersTab = val(GetStringToken(sharedLockParameters$, ",", 3))
	endif
	if (sharedLockNo > 0)
		ReceivedUserLogData(sharedLockNo, userNo, usersTab)
		if (screenNo = constUsersLockLogScreen)
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constUsersLockLogScreen)
		endif
	endif



// GET YOUR RELATIONS
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].GetYourRelations)
	splashScreenStage$ = "Last Stage"
	ReceivedYourRelations()
	if (screenNo = constYourBlockedUsersListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constYourBlockedUsersListScreen)
	endif
	if (screenNo = constYourFollowersListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constYourFollowersListScreen)
	endif
	if (screenNo = constYourFollowingListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constYourFollowingListScreen)
	endif
	if (screenNo = constYourFollowRequestsListScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constYourFollowRequestsListScreen)
	endif
	if (screenNo = constViewProfileScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constViewProfileScreen)
	endif
	
	

// REMOVE USER FROM LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].RemoveUserFromLock)
	sharedLockParameters$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "RemoveUserFromLock=", "", -1)
	sharedLockNo = 0
	if (CountStringTokens(sharedLockParameters$, ",") = 3)
		sharedLockNo = val(GetStringToken(sharedLockParameters$, ",", 1))
		userNo = val(GetStringToken(sharedLockParameters$, ",", 2))
		usersTab = val(GetStringToken(sharedLockParameters$, ",", 3))
	endif
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Shared Lock And User Match Failed")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock & User Match Failed;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was a problem finding a match between the lock and user. The user may have deleted the lock or is experiencing account issues. Please press the refresh button above and try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	else
		ReceivedUpdateUsersLock(sharedLockNo, usersTab, userNo)
		GetSharedLockUsersData(sharedLocks[sharedLockNo, 0].shareID$, 1, 0)
		ShowTooltipAfterScreenRefresh("Deleted User From Lock")
		screen[screenNo].lastViewY# = GetViewOffsetY()
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(constManageLockedUsersScreen)
	endif
	
	
	
// RESET API CLIENT SECRET
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].ResetAPIClientSecret)
	apiProjectIndex as integer : apiProjectIndex = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "ResetAPIClientSecret=", "", -1))
	ReceivedNewAPIClientSecret(apiProjectIndex)
	if (apiProjectIndex = showAPIProject and screenNo = constAPIProjectSettingsScreen)
		apiClientSecret$ = apiProjects[showAPIProject].clientSecret$
		apiClientSecretOriginal$ = apiClientSecret$
	endif
	OryUIUpdateTooltip(tooltip, "text:Client Secret Reset")
	OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
	
	

// RESTORE ACCOUNT
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].RestoreAccount)
	splashScreenStage$ = "Get Account Data"
	restoreUserID$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "RestoreAccount=", "", -1)
	ResetLockData()
	userDBRow = 0
	userID$ = restoreUserID$
	SaveLocalVariable("userID", userID$)
	ReceivedRestoreAccount()
	GetLocksData()
	SetScreenToView(constSplashScreen)

	

// RESTORE DELETED SHARED LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].RestoreDeletedSharedLock)
	deletedSharedLockJustRestored = 1
	GetSharedLocksDeleted(1)
	GetSharedLocksData(0)
	
	
	
// UNBLOCK USER
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UnblockUser)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Unblocked")
		OryUIUpdateTooltip(tooltip, "text:User Unblocked")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		GetYourRelations(1)
	endif
	
	

// UNFOLLOW USER
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UnfollowUser)
	profileID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "UnfollowUser=", "", -1))
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Unfollowed")
		OryUIUpdateTooltip(tooltip, "text:Unfollowed User")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)	
		if (screenNo = constViewProfileScreen) then dec profileData.followers
		GetYourRelations(1)
	endif
	
	
	
// UNLOCK USERS LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UnlockUsersLock)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Shared Lock And User Match Failed")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock & User Match Failed;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was a problem finding a match between the lock and user. The user may have deleted the lock or is experiencing account issues. Please press the refresh button above and try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	else
		OryUIUpdateTooltip(tooltip, "text:Unlocked lock")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 0)
	endif



// UPDATE ACCOUNT
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateAccount)
	ResetAllNotifications()
	


// UPDATE API PROJECT
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateAPIProject)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Updated")
		apiProjects.save("apiProjects.json")
		if (screenNo = constAPIProjectSettingsScreen)
			OryUIUpdateTooltip(tooltip, "text:Updated API Project")
			OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		endif
	endif
	
	
	
// UPDATE LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateLocksDatabase)
	lockID = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "UpdateMyLock=", "", -1))
	lockNo = 0
	for i = 1 to 20
		if (locks[i].id = lockID)
			lockNo = i
			exit
		endif
	next
	if (lockNo > 0)
		ReceivedUpdateLocksDatabaseResponse(lockNo)
		if (screenNo = constLockInformationScreen)
			OryUIUpdateTooltip(tooltip, "text:Updated Lock")
			OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		endif
		if (screenNo = constCreateLocksScreen)
			inc locksSavedInDB
		endif
	endif

	

// UPDATE SHARED LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateSharedLock)
	sharedLockNo = val(ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "UpdateSharedLock=", "", -1))
	if (sharedLockNo > 0)
		OryUIUpdateTooltip(tooltip, "text:Updated Shared Lock")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
		sharedLocks[sharedLockSelected, 0].blockUsersAlreadyLocked = blockUsersAlreadyLocked
		sharedLocks[sharedLockSelected, 0].blockUsersWithStatsHidden = blockUsersWithStatsHidden
		sharedLocks[sharedLockSelected, 0].cardInfoHidden = cardInfoHidden
		sharedLocks[sharedLockSelected, 0].forceTrust = forceTrust
		sharedLocks[sharedLockSelected, 0].keyDisabled = keyDisabled
		sharedLocks[sharedLockSelected, 0].maxRandomCopies = maxCopies
		sharedLocks[sharedLockSelected, 0].maxUsers = maxUsers
		sharedLocks[sharedLockSelected, 0].minRandomCopies = minCopies
		if (newLockName$ <> sharedLocks[sharedLockSelected, 0].lockName$)
			sharedLocks[sharedLockSelected, 0].lockName$ = newLockName$
		endif
		sharedLocks[sharedLockSelected, 0].requireDM = requireDM
		sharedLocks[sharedLockSelected, 0].timerHidden = timerHidden
		GetSharedLocksData(1)
	endif
	
	
	
// UPDATE USERNAME
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateUsername)
	username$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "UpdateUsername=", "", -1)
	SaveLocalVariable("username", username$)
	OryUIUpdateTooltip(tooltip, "text:Updated username")
	OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)



// UPDATE USERS LOCK
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateUsersLock)
	sharedLockParameters$ = ReplaceString(OryUIGetHTTPSQueueRequestName(httpsQueue), "UpdateUsersLock=", "", -1)
	sharedLockNo = 0
	if (CountStringTokens(sharedLockParameters$, ",") = 3)
		sharedLockNo = val(GetStringToken(sharedLockParameters$, ",", 1))
		userNo = val(GetStringToken(sharedLockParameters$, ",", 2))
		usersTab = val(GetStringToken(sharedLockParameters$, ",", 3))
	endif
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Shared Lock And User Match Failed")
		OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock & User Match Failed;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There was a problem finding a match between the lock and user. The user may have deleted the lock or is experiencing account issues. Please press the refresh button above and try again.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(dialog, 1)
		OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(dialog)
	else
		ReceivedUpdateUsersLock(sharedLockNo, usersTab, userNo)
		GetSharedLockUsersData(sharedLocks[sharedLockNo, 0].shareID$, 1, 0)
		ShowTooltipAfterScreenRefresh("Updated Lock")
		screen[screenNo].lastViewY# = GetViewOffsetY()
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(constManageLockedUsersScreen)
	endif



// UPDATE USERS RATING
elseif (OryUIGetHTTPSQueueRequestScript(httpsQueue) = URLs[0].URLPath + "/" + URLs[0].UpdateUsersRatingFromKeyholder)
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) = "Successfully Updated")
		OryUIUpdateTooltip(tooltip, "text:Updated Rating")
		OryUIShowTooltip(tooltip, GetViewOffsetX() + 50, GetViewOffsetY() + screenBoundsTop# + 90)
	endif



endif



// PROBLEM DELETING MY LOCK
if (OryUIGetDialogButtonReleasedByName(dialog, "OkProblemDeletingMyLock"))
	if (screenNo = constMyLocksScreen)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constMyLocksScreen)
	endif
endif
	
// RESTORED ACCOUNT
if (OryUIGetDialogButtonReleasedByName(dialog, "OkRestoredAccount"))
	if (screenNo = constRestoreAccountScreen)
		SetScreenToView(selectedLocksTab)
	endif
endif
