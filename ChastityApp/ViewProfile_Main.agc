
if (screenToView = constViewProfileScreen)
	if (redrawScreen = 1)
		blockedByOther as integer : blockedByOther = FindRelation("blockedByOthers", profileData.id)
		blockedByYou as integer : blockedByYou = FindRelation("blockedByYou", profileData.id)
		follower as integer : follower = FindRelation("followers", profileData.id)
		following as integer : following = FindRelation("following", profileData.id)
		loadingProfile as integer
		pendingByOther as integer : pendingByOther = FindRelation("pendingByOthers", profileData.id)
		pendingByYou as integer : pendingByYou = FindRelation("pendingByYou", profileData.id)
	endif
	
	screenNo = constViewProfileScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)	
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		if (profileData.id <> userDBRow and profileData.id > 0)
			OryUISetTopBarActionCount(screen[screenNo].topBar, 1)
			OryUIUpdateTopBarAction(screen[screenNo].topBar, 1, "name:MoreVert;icon:MoreVert")
		else
			OryUISetTopBarActionCount(screen[screenNo].topBar, 1)
			OryUIUpdateTopBarAction(screen[screenNo].topBar, 1, "name:EditProfile;icon:Edit")
		endif
		OryUIUpdateMenu(screen[screenNo].menuMore, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "editprofile")
		userSelected = 0
		resetOptions = 1
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constEditProfileScreen)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "morevert")
		OryUISetMenuItemCount(screen[screenNo].menuMore, 2)
		OryUIUpdateMenuItem(screen[screenNo].menuMore, 1, "name:Refresh;text:Refresh;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
		if (blockedByYou = 0)
			OryUIUpdateMenuItem(screen[screenNo].menuMore, 2, "name:BlockUser;text:Block;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateMenuItem(screen[screenNo].menuMore, 2, "name:UnblockUser;text:Unblock;colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIShowMenu(screen[screenNo].menuMore, OryUIGetTopBarActionXByIcon(screen[screenNo].topBar, "MoreVert"), OryUIGetTopBarActionYByIcon(screen[screenNo].topBar, "MoreVert") + OryUIGetTopBarActionHeightByIcon(screen[screenNo].topBar, "MoreVert"))
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	OryUIInsertMenuListener(screen[screenNo].menuMore)
	if (OryUIGetMenuItemReleasedName(screen[screenNo].menuMore) = "Refresh")
		GetProfileData(profileData.id, 1)
	endif
	if (OryUIGetMenuItemReleasedName(screen[screenNo].menuMore) = "BlockUser")
		BlockUser(profileData.id, 1)
	endif
	if (OryUIGetMenuItemReleasedName(screen[screenNo].menuMore) = "UnblockUser")
		UnblockUser(profileData.id, 1)
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";alpha:0")
	endif

	// TOP PANEL
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprProfileTopPanel, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = elementY# + 2

	// PULL DOWN TO REFRESH
	if (oryUIScrimVisible = 0)
		if (PullDownToRefresh(screenNo, elementY# - 2, elementY# - 2 + 10, GetSpriteHeight(sprPullToRefreshCircle)))
			GetProfileData(profileData.id, 1)
		endif
	endif
	
	loadingProfile = OryUIIsScriptInHTTPSQueue(httpsQueue, "app/v" + ReplaceString(constVersionNumber$, " ", ".", -1) + "/agkgetprofiledata.php")
	
	hideProfile as integer : hideProfile = 0
	if (loadingProfile = 1) then hideProfile = 1
	if (profileData.privateProfile = 1 and following = 0 and profileData.id <> userDBRow) then hideProfile = 1
	if (blockedByOther = 1 or blockedByYou = 1) then hideProfile = 1

	elementY# = elementY# + 2
	
	// USERNAME
	if (redrawScreen = 1)
		if (loadingProfile = 0)
			OryUIUpdateText(txtProfileUsername, "text:" + profileData.username$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtProfileUsername, "text:Loading Profile...;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	endif
	if (blockedByOther = 0 and blockedByYou = 0)
		elementY# = elementY# + GetTextTotalHeight(txtProfileUsername)
	else
		elementY# = elementY# + GetTextTotalHeight(txtProfileUsername) + 2
	endif
	
	// STATUS
	if (hideProfile = 0)
		statusX# as float : statusX# = (screenNo * 100) + 50 + (GetTextTotalWidth(txtProfileUsername) / 2.0) + (GetSpriteWidth(sprProfileStatus) / 2.0) + 1
		statusY# as float : statusY# = GetTextY(txtProfileUsername) + (GetTextTotalHeight(txtProfileUsername) / 2.0) + 0.2
		if (profileData.statusSelected = 0 or profileData.statusSelected = 1)
			if (timestampNow - profileData.timestampLastActive <= 900)
				OryUIUpdateSprite(sprProfileStatus, "position:" + str(statusX#) + "," + str(statusY#) + ";image:" + str(imgStatusAvailableIcon) + ";alpha:255")
			else
				OryUIUpdateSprite(sprProfileStatus, "position:" + str(statusX#) + "," + str(statusY#) + ";image:" + str(imgStatusOfflineIcon) + ";alpha:255")
			endif
		elseif (profileData.statusSelected = 2)
			OryUIUpdateSprite(sprProfileStatus, "position:" + str(statusX#) + "," + str(statusY#) + ";image:" + str(imgStatusBusyIcon) + ";alpha:255")
		elseif (profileData.statusSelected = 3)
			OryUIUpdateSprite(sprProfileStatus, "position:" + str(statusX#) + "," + str(statusY#) + ";image:" + str(imgStatusSleepingIcon) + ";alpha:255")
		elseif (profileData.statusSelected = 4)
			OryUIUpdateSprite(sprProfileStatus, "position:" + str(statusX#) + "," + str(statusY#) + ";image:" + str(imgStatusOfflineIcon) + ";alpha:255")
		endif
		if (OryUIGetSpriteReleased() = sprProfileStatus)
			statusTitle$ as string : statusTitle$ = ""
			if (GetSpriteImageID(sprProfileStatus) = imgStatusAvailableIcon) then statusTitle$ = profileData.username$ + " is online"
			if (GetSpriteImageID(sprProfileStatus) = imgStatusBusyIcon) then statusTitle$ = profileData.username$ + " is busy"
			if (GetSpriteImageID(sprProfileStatus) = imgStatusOfflineIcon) then statusTitle$ = profileData.username$ + " is offline"
			if (GetSpriteImageID(sprProfileStatus) = imgStatusSleepingIcon) then statusTitle$ = profileData.username$ + " is sleeping"
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:User Status;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:" + statusTitle$ + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		endif
	else
		OryUIUpdateSprite(sprProfileStatus, "position:-1000,-1000")
	endif	

	// USER LEVEL
	if (profileData.mainRoleLevel$ <> "" and hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(txtProfileUserLevel, "text:" + profileData.mainRoleLevel$ + ";position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";alignment:center;colorID:" + str(profileData.mainRoleColour))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtProfileUserLevel) + 0.5
	else
		if (redrawScreen = 1)
			OryUIUpdateText(txtProfileUserLevel, "position:-1000,-1000")
			OryUIUpdateSprite(sprProfileUserLevel, "position:-1000,-1000")
		endif
	endif

	// RATING
	if (profileData.noOfRatings >= 5 and hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprProfileRatingBackground, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateSprite(sprProfileRatingBar, "width:" + str((GetSpriteWidth(sprProfileRatingBackground) / 5) * profileData.averageRating#) + ",2.8;position:" + str(GetSpriteX(sprProfileRatingBackground)) + "," + str(GetSpriteY(sprProfileRatingBackground)))
			for i = 1 to 5
				OryUIUpdateSprite(sprProfileRatingStar[i], "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIPinSpriteToSprite(sprProfileRatingStar[i], sprProfileRatingBackground, GetSpriteWidth(sprProfileRatingStar[i]) * (i - 1), 0)
				OryUIPinSpriteToSprite(sprProfileRatingStarBorder[i], sprProfileRatingStar[i], 0, 0)
			next
		endif
		elementY# = elementY# + GetSpriteHeight(sprProfileRatingBackground) + 0.5
		if (redrawScreen = 1)
			OryUIUpdateText(txtProfileRating, "text:" + str(profileData.averageRating#, 1) + " out of 5.0 (" + str(profileData.noOfRatings) + " Ratings);position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtProfileRating) + 1.5
	else
		if (hideProfile = 0)
			if (redrawScreen = 1)
				OryUIUpdateSprite(sprProfileRatingBackground, "position:-1000,-1000")
				OryUIUpdateSprite(sprProfileRatingBar, "position:-1000,-1000")
				for i = 1 to 5
					OryUIUpdateSprite(sprProfileRatingStar[i], "position:-1000,-1000")
					OryUIUpdateSprite(sprProfileRatingStarBorder[i], "position:-1000,-1000")
				next
			endif
			if (redrawScreen = 1)
				if (profileData.noOfRatings = 0)
					OryUIUpdateText(txtProfileRating, "position:-1000,-1000")
				elseif (profileData.noOfRatings = 1)
					OryUIUpdateText(txtProfileRating, "text:Not enough ratings (1 Rating);position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateText(txtProfileRating, "text:Not enough ratings (" + str(profileData.noOfRatings) + " Ratings);position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				endif	
			endif
			elementY# = elementY# + GetTextTotalHeight(txtProfileRating) + 2
		else
			if (redrawScreen = 1)
				OryUIUpdateSprite(sprProfileRatingBackground, "position:-1000,-1000")
				OryUIUpdateSprite(sprProfileRatingBar, "position:-1000,-1000")
				for i = 1 to 5
					OryUIUpdateSprite(sprProfileRatingStar[i], "position:-1000,-1000")
					OryUIUpdateSprite(sprProfileRatingStarBorder[i], "position:-1000,-1000")
				next
				OryUIUpdateText(txtProfileRating, "position:-1000,-1000")
			endif
		endif
	endif
	
	// PRIVATE ACCOUNT
	if (profileData.id <> userDBRow and loadingProfile = 0 and blockedByYou = 0 and ((profileData.privateProfile = 1 and following = 0) or blockedByOther = 1))
		OryUIUpdateText(txtPrivateAccountLine1, "text:Private Account;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtPrivateAccountLine2, "text:Follow this account to see their profile;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + 6 + GetTextTotalHeight(txtPrivateAccountLine2) + 2
	else
		OryUIUpdateText(txtPrivateAccountLine1, "position:-1000,-1000")
		OryUIUpdateText(txtPrivateAccountLine2, "position:-1000,-1000")
	endif

	// FOLLOWERS/FOLLOWING COUNT
	if (hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(txtFollowersCount, "text:" + str(profileData.followers) + ";position:" + str((screenNo * 100) + 37) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtFollowingCount, "text:" + str(profileData.following) + ";position:" + str((screenNo * 100) + 63) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtFollowersCount) 
		if (redrawScreen = 1)
			OryUIUpdateText(txtFollowersLabel, "text:Followers;position:" + str((screenNo * 100) + 37) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtFollowingLabel, "text:Following;position:" + str((screenNo * 100) + 63) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtFollowersLabel) + 2
		if (redrawScreen = 1)
			followersCountHeight# as float : followersCountHeight# = GetTextTotalHeight(txtFollowersCount) + GetTextTotalHeight(txtFollowersLabel)
			followersCountWidth# as float : followersCountWidth# = GetTextTotalWidth(txtFollowersLabel)
			followersCountY# as float : followersCountY# = GetTextY(txtFollowersCount) + (followersCountHeight# / 2)
			OryUIUpdateSprite(sprFollowersCount, "size:" + str(followersCountWidth# + 2) + "," + str(followersCountHeight# + 1) + ";offset:center;position:" + str((screenNo * 100) + 37) + "," + str(followersCountY#))
			followingCountHeight# as float : followingCountHeight# = GetTextTotalHeight(txtFollowingCount) + GetTextTotalHeight(txtFollowingLabel)
			followingCountWidth# as float : followingCountWidth# = GetTextTotalWidth(txtFollowingLabel)
			followingCountY# as float : followingCountY# = GetTextY(txtFollowingCount) + (followingCountHeight# / 2)
			OryUIUpdateSprite(sprFollowingCount, "size:" + str(followingCountWidth# + 2) + "," + str(followingCountHeight# + 1) + ";offset:center;position:" + str((screenNo * 100) + 63) + "," + str(followingCountY#))
		endif
		if (OryUIGetSpriteReleased() = sprFollowersCount)
			if (profileData.id <> userDBRow)
				GetOthersRelations(profileData.id, 1)
				lastScreenViewed = constViewProfileScreen
				SetScreenToView(constOthersFollowersListScreen)
			else
				GetYourRelations(1)
				lastScreenViewed = constViewProfileScreen
				SetScreenToView(constYourFollowersListScreen)
			endif
		endif
		if (OryUIGetSpriteReleased() = sprFollowingCount)
			if (profileData.id <> userDBRow)
				GetOthersRelations(profileData.id, 1)
				lastScreenViewed = constViewProfileScreen
				SetScreenToView(constOthersFollowingListScreen)
			else
				GetYourRelations(1)
				lastScreenViewed = constViewProfileScreen
				SetScreenToView(constYourFollowingListScreen)
			endif
		endif
	else
		OryUIUpdateText(txtFollowersCount, "position:-1000,-1000")
		OryUIUpdateText(txtFollowingCount, "position:-1000,-1000")
		OryUIUpdateText(txtFollowersLabel, "position:-1000,-1000")
		OryUIUpdateText(txtFollowingLabel, "position:-1000,-1000")
	endif

	// FOLLOW BUTTON
	if (profileData.id <> userDBRow and loadingProfile = 0 and following = 0 and pendingByOther = 0 and blockedByYou = 0)
		if (redrawScreen = 1)
			if (follower = 0)
				OryUIUpdateButton(btnProfileUserFollow, "text:Follow;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
			else
				OryUIUpdateButton(btnProfileUserFollow, "text:Follow Back;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
			endif	
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnProfileUserFollow) + 2
		if (OryUIGetButtonReleased(btnProfileUserFollow))
			if (left(username$, 3) = "CKU")
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Change Username;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Before you can follow people you will need to change your username from the default " + username$ + " username you've been assigned.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 2)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ChangeUsername;text:Change Username;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelChangeUsername;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				FollowUser(profileData.id, 1)
			endif
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserFollow, "position:-1000,-1000")
		endif
	endif
	
	// REQUEST SENT
	if (profileData.id <> userDBRow and loadingProfile = 0 and pendingByOther = 1)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserRequestSent, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].unselectedButtonColor) + ";textColor:255,255,255,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnProfileUserRequestSent) + 2
		if (OryUIGetButtonReleased(btnProfileUserRequestSent))
			UnFollowUser(profileData.id, 1)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserRequestSent, "position:-1000,-1000")
		endif
	endif

	// UNFOLLOW BUTTON
	if (profileData.id <> userDBRow and loadingProfile = 0 and following = 1)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserUnfollow, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnProfileUserUnfollow) + 2
		if (OryUIGetButtonReleased(btnProfileUserUnfollow))
			UnfollowUser(profileData.id, 1)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserUnfollow, "position:-1000,-1000")
		endif
	endif
	
	// UNBLOCK BUTTON
	if (profileData.id <> userDBRow and loadingProfile = 0 and blockedByYou = 1)
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserUnblock, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
		endif
		elementY# = elementY# + OryUIGetButtonHeight(btnProfileUserUnblock) + 2
		if (OryUIGetButtonReleased(btnProfileUserUnblock))
			UnblockUser(profileData.id, 1)
		endif
	else
		if (redrawScreen = 1)
			OryUIUpdateButton(btnProfileUserUnblock, "position:-1000,-1000")
		endif
	endif

	// LAST ONLINE
	if (timestampNow - profileData.timestampLastActive > 86400 and profileData.timestampLastActive > 0 and hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(txtProfileLastOnline, "text:Last Online[colon] " + lower(ConvertMinutesToText((timestampNow - profileData.timestampLastActive) / 60, 0)) + " ago;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + GetTextTotalHeight(txtProfileLastOnline) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateText(txtProfileLastOnline, "position:-1000,-1000")
		endif
	endif
	
	// DISCORD LOGO
	if (profileData.discordID$ <> "" and profileData.discordUsername$ <> "" and hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(txtDiscordName, "text:" + profileData.discordUsername$ + "#" + AddLeadingZeros(str(profileData.discordDiscriminator), 4) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			discordLogoOffset# as float : discordLogoOffset# = (GetTextTotalWidth(txtDiscordName) + 1 + GetSpriteWidth(sprDiscordLogo)) / 2.0
			OryUIUpdateSprite(sprDiscordLogo, "position:" + str((screenNo * 100) + 50 - discordLogoOffset#) + "," + str(elementY#))
			OryUIPinTextToCentreRightOfSprite(txtDiscordName, sprDiscordLogo, 1, 0)
			OryUIUpdateText(txtDiscordName, "alignment:left")
			OryUIUpdateSprite(sprDiscordNameButton, "size:" + str(GetTextTotalWidth(txtDiscordName) + GetSpriteWidth(sprDiscordLogo) + 1) + "," + str(GetSpriteHeight(sprDiscordLogo)))
			OryUIPinSpriteToSprite(sprDiscordNameButton, sprDiscordLogo, 0, 0)
		endif
		elementY# = elementY# + GetSpriteHeight(sprDiscordLogo) + 1
	else
		OryUIUpdateSprite(sprDiscordLogo, "position:-1000,-1000")
		OryUIUpdateSprite(sprDiscordNameButton, "position:-1000,-1000")
		OryUIUpdateText(txtDiscordName, "position:-1000,-1000")
	endif
	if (OryUIGetSpriteReleased() = sprDiscordLogo or OryUIGetSpriteReleased() = sprDiscordNameButton)
		OpenBrowser("https://discordapp.com/channels/@me")
	endif
	
	// TWITTER LOGO
	if (profileData.twitterHandle$ <> "" and hideProfile = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(txtTwitterHandle, "text:" + profileData.twitterHandle$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			twitterLogoOffset# as float : twitterLogoOffset# = (GetTextTotalWidth(txtTwitterHandle) + 1 + GetSpriteWidth(sprTwitterLogo)) / 2.0
			OryUIUpdateSprite(sprTwitterLogo, "position:" + str((screenNo * 100) + 50 - twitterLogoOffset#) + "," + str(elementY#))
			OryUIPinTextToCentreRightOfSprite(txtTwitterHandle, sprTwitterLogo, 1, 0)
			OryUIUpdateText(txtTwitterHandle, "alignment:left")
			OryUIUpdateSprite(sprTwitterHandleButton, "size:" + str(GetTextTotalWidth(txtTwitterHandle) + GetSpriteWidth(sprTwitterLogo) + 1) + "," + str(GetSpriteHeight(sprTwitterLogo)))
			OryUIPinSpriteToSprite(sprTwitterHandleButton, sprTwitterLogo, 0, 0)
		endif
		elementY# = elementY# + GetSpriteHeight(sprTwitterLogo) + 2
	else
		OryUIUpdateSprite(sprTwitterLogo, "position:-1000,-1000")
		OryUIUpdateSprite(sprTwitterHandleButton, "position:-1000,-1000")
		OryUIUpdateText(txtTwitterHandle, "position:-1000,-1000")
	endif
	if (OryUIGetSpriteReleased() = sprTwitterLogo or OryUIGetSpriteReleased() = sprTwitterHandleButton)
		OpenBrowser("https://twitter.com/" + profileData.twitterHandle$)
	endif
	
	elementY# = elementY# + 2

	// TOP PANEL
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprProfileTopPanel, "height:" + str(elementY# - GetSpriteY(sprProfileTopPanel)))
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
	endif
	
	// JUMP TO LAST VIEW OFFSET Y WHEN RETURNING TO THIS SCREEN
	if (screen[screenNo].lastViewY# > 0)
		SetViewOffset(GetViewOffsetX(), screen[screenNo].lastViewY#)
		screen[screenNo].lastViewY# = 0
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
