
OryUIHideFloatingActionButton(fabSaveEmoji)
if (screenToView = constEmojisScreen)
	screenNo = constEmojisScreen
	
	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// JUMP TO LAST VIEW OFFSET Y WHEN RETURNING TO THIS SCREEN
	if (screen[screenNo].lastViewY# > screenBoundsTop#)
		SetViewOffset(GetViewOffsetX(), screen[screenNo].lastViewY#)
		screen[screenNo].lastViewY# = screenBoundsTop#
	endif
	
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
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";alpha:0")
	endif

	// EMOJIS
	if (redrawScreen = 1)
		emojiCount = 0
		emojiX# as float : emojiX# = 0
		emojiY# as float : emojiY# = 0
		for y = 0 to 12
			for x = 0 to 5
				inc emojiCount
				emojiWidth# = GetSpriteWidth(sprEmojis[emojiCount])
				emojiX# = (screenNo * 100.0) + 3 + ((94.0 / 6.0) * x)
				emojiY# = elementY# + (y * (GetSpriteHeight(sprEmojis[emojiCount]) + 1))
				OryUIUpdateSprite(sprEmojis[emojiCount], "position:" + str(emojiX#) + "," + str(emojiY#) + ";image:" + str(imgEmojis[emojiColourSelected, emojiCount]))
			next
		next
		OryUIUpdateSprite(sprEmojiBorder, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	for i = 1 to 78
		if (OryUIGetSpriteReleased() = sprEmojis[i])
			if (i <> emojiChosen)
				emojiChosen = i
				exit
			else
				emojiChosen = 0
			endif
		endif
	next
	if (emojiChosen > 0)
		OryUIPinSpriteToSprite(sprEmojiBorder, sprEmojis[emojiChosen], 0, 0)
	else
		OryUIUpdateSprite(sprEmojiBorder, "position:-1000,-1000")
	endif
	elementY# = GetSpriteY(sprEmojis[78]) + GetSpriteHeight(sprEmojis[78]) + 2

	// EMOJI COLOUR
	emojiColourX# as float : emojiColourX# = 0
	for x = 1 to 7
		emojiColourX# = (screenNo * 100.0) + ((100 / 7.0) * (x - 1))
		OryUIUpdateSprite(sprEmojiColour[x], "position:" + str(emojiColourX#) + "," + str(GetViewOffsetY() + abs(screenBoundsTop#) + 100 - GetSpriteHeight(sprEmojiColour[x])))
		if (OryUIGetSpriteReleased() = sprEmojiColour[x])
			emojiColourSelected = x
			screen[screenNo].lastViewY# = GetViewOffsetY()
			SetScreenToView(constEmojisScreen)
		endif
	next
	OryUIPinSpriteToSprite(sprEmojiColourBorder, sprEmojiColour[emojiColourSelected], 0, 0)
	OryUIUpdateSprite(sprEmojiColourShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + abs(screenBoundsTop#) + 100 - GetSpriteHeight(sprEmojiColour[1]) - 1))

	// SAVE EMOJI
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabSaveEmoji, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	if (lastScreenViewed = constMyLocksScreen)
		if (emojiChosen > 0 or locks[lockSelected].emojiChosen > 0)
			if ((emojiChosen <> locks[lockSelected].emojiChosen or emojiColourSelected <> locks[lockSelected].emojiColourSelected))
				OryUIShowFloatingActionButton(fabSaveEmoji)
			endif
		endif
		if (OryUIGetFloatingActionButtonReleased(fabSaveEmoji))
			locks[lockSelected].emojiChosen = emojiChosen
			locks[lockSelected].emojiColourSelected = emojiColourSelected
			UpdateLocksData(lockSelected)
			UpdateLocksDatabase(lockSelected, "action:SetMoodEmoji;actionedBy:Lockee;result:Emoji=" + str(emojiChosen) + ",Colour=" + str(emojiColourSelected), 0)
			SetScreenToView(constMyLocksScreen)
		endif
	endif
	if (lastScreenViewed = constManageLockedUsersScreen)
		if (emojiChosen > 0 or sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiChosen[userSelected] > 0)
			if ((emojiChosen <> sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiChosen[userSelected] or emojiColourSelected <> sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiColourSelected[userSelected]))
				OryUIShowFloatingActionButton(fabSaveEmoji)
			endif
		endif
		if (OryUIGetFloatingActionButtonReleased(fabSaveEmoji))
			sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiChosen[userSelected] = emojiChosen
			sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiColourSelected[userSelected] = emojiColourSelected
			UpdateKeyholdersEmoji(sharedLockSelected, userSelected, "action:SetMoodEmoji;actionedBy:Keyholder;result:Emoji=" + str(emojiChosen) + ",Colour=" + str(emojiColourSelected), 0)
			previousBreadcrumb = GetPreviousBreadcrumb()
			RemoveLastBreadcrumb()
			SetScreenToView(constManageLockedUsersScreen)
		endif
	endif
	
	// ADVERTS
	if (OryUIGetFloatingActionButtonVisible(fabSaveEmoji))
		oryUIBottomBannerAdOnScreen = 1
	else
		oryUIBottomBannerAdOnScreen = 0
	endif
	SetAdvertVisible(0)
	
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
