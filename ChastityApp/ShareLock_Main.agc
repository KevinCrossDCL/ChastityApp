
if (screenToView = constShareLockScreen)
	if (screenNo <> constShareLockScreen)
		if (imgLogo = 0) then imgLogo = LoadImage("AppLogo.png")
	endif
	screenNo = constShareLockScreen

	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
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
		ClearBreadcrumbs()
		SetScreenToView(constSharedLocksScreen)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "share")
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:App Lock")
		OryUIUpdateSprite(OryUITopBarCollection[screen[screenNo].topBar].sprNavigationIcon, "alpha:0")
		OryUIUpdateSprite(OryUITopBarCollection[screen[screenNo].topBar].actions[0].sprIcon, "alpha:0")
		Render()
		imgScreenshot as integer : imgScreenshot = GetImage(GetScreenBoundsLeft(), GetScreenBoundsTop(), GetScreenBoundsRight() + abs(GetScreenBoundsLeft()), GetScreenBoundsBottom() + abs(GetScreenBoundsTop()))
		ClearScreen()
		SaveImage(imgScreenshot, constAppName$ + "-Shareable-Lock-" + shareID$ + ".png")
		ShareImage(constAppName$ + "-Shareable-Lock-" + shareID$ + ".png")
		OryUIUpdateTopBar(screen[screenNo].topBar, "text:Share Lock")
		OryUIUpdateSprite(OryUITopBarCollection[screen[screenNo].topBar].sprNavigationIcon, "alpha:255")
		OryUIUpdateSprite(OryUITopBarCollection[screen[screenNo].topBar].actions[0].sprIcon, "alpha:255")
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str(screenNo * 100) + "," + str(elementY#))
	endif
	elementY# = elementY# + 2

	// QR CODE BACKGROUND
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprQRCodeBackground, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + (GetSpriteHeight(sprQRCodeBackground) / 2)))
	endif
	elementY# = elementY# + GetSpriteHeight(sprQRCodeBackground)
	
	// QR CODE
	if (redrawScreen = 1)
		shareID$ = sharedLocks[sharedLockSelected, 0].shareID$
		encodedQRCode as integer : encodedQRCode = EncodeQRCode(constAppName$ + "-Shareable-Lock-" + shareID$, 0)
		SaveImage(encodedQRCode, shareID$ + ".png")
		OryUIUpdateSprite(sprEncodedQRCode, "image:" + str(LoadImage(shareID$ + ".png")))
		OryUIPinSpriteToCentreOfSprite(sprEncodedQRCode, sprQRCodeBackground, 0, 0)
		verticalGap# as float : verticalGap# = (GetSpriteHeight(sprQRCodeBackground) - GetSpriteHeight(sprEncodedQRCode)) / 2.0
	endif
	
	// QR APP LOGO
	if (redrawScreen = 1)
		OryUIPinSpriteToCentreOfSprite(sprQRBlackCircle, sprQRCodeBackground, 0, 0)
		OryUIPinSpriteToCentreOfSprite(sprQRWhiteCircle, sprQRCodeBackground, 0, 0)
		OryUIUpdateSprite(sprQRLogo, "image:" + str(imgLogo))
		OryUIPinSpriteToCentreOfSprite(sprQRLogo, sprQRCodeBackground, 0, 0)
	endif
	
	// QR LOCK NAME
	if (redrawScreen = 1)
		if (sharedLocks[sharedLockSelected, 0].lockName$ <> "")
			OryUIUpdateText(txtQRLockName, "text:" + sharedLocks[sharedLockSelected, 0].lockName$)
		else
			OryUIUpdateText(txtQRLockName, "text: ")
		endif
		OryUIPinTextToTopLeftOfSprite(txtQRLockName, sprQRCodeBackground, GetTextTotalHeight(txtQRLockName) * 2, (verticalGap# - GetTextTotalHeight(txtQRLockName)) / 2)
	endif
	
	// QR SHARE ID
	if (redrawScreen = 1)
		OryUIUpdateText(txtQRShareID, "text:" + shareID$)
		OryUIPinTextToTopRightOfSprite(txtQRShareID, sprQRCodeBackground, -GetTextTotalHeight(txtQRShareID) * 2, (verticalGap# - GetTextTotalHeight(txtQRShareID)) / 2)
	endif
	
	// QR DOWNLOAD
	if (redrawScreen = 1)
		for a = 24 to 36
			SetTextCharColor(txtQRDownload, a, 0, 0, 255, 255)
		next
		OryUIUpdateText(txtQRDownload, "position:" + str(GetSpriteX(sprQRCodeBackground) + GetSpriteWidth(sprQRCodeBackground) - ((verticalGap# - GetTextTotalHeight(txtQRDownload)) / 2)) + "," + str(GetSpriteY(sprQRCodeBackground) + GetSpriteHeight(sprQRCodeBackground) / 2) + ";angle:90")
	endif
	
	// QR CREATED BY
	if (redrawScreen = 1)
		OryUIUpdateText(txtQRCreatedBy, "text:Created by " + username$)
		OryUIPinTextToBottomLeftOfSprite(txtQRCreatedBy, sprQRCodeBackground, GetTextTotalHeight(txtQRCreatedBy) * 2, -(verticalGap# - GetTextTotalHeight(txtQRLockName)) / 2)
	endif
	
	// QR MINIMUM VERSION REQUIRED
	if (redrawScreen = 1)
		OryUIUpdateText(txtQRVersion, "text:Requires V" + sharedLocks[sharedLockSelected, 0].minVersionRequired$ + "+")
		OryUIPinTextToBottomRightOfSprite(txtQRVersion, sprQRCodeBackground, -GetTextTotalHeight(txtQRVersion) * 2, -(verticalGap# - GetTextTotalHeight(txtQRShareID)) / 2)
	endif
	
	// LOCK INFORMATION
	if (redrawScreen = 1)
		if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
			SetSpriteSize(sprLockTestLock, GetSpriteWidth(sprQRCodeBackground), 4.5)
			OryUIUpdateSprite(sprLockTestLock, "offset:" + str(GetSpriteWidth(sprLockInformation) / 2) + ",0;position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
			elementY# = elementY# + GetSpriteHeight(sprLockTestLock)
			OryUIUpdateText(txtLockTestLock, "text:TEST LOCK;color:255,0,0,255")
			OryUIPinTextToCentreOfSprite(txtLockTestLock, sprLockTestLock, 0, 0)
		else
			OryUIUpdateSprite(sprLockTestLock, "position:-1000,-1000")
			OryUIUpdateText(txtLockTestLock, "position:-1000,-1000")
		endif
		SetSpriteSize(sprLockInformation, GetSpriteWidth(sprQRCodeBackground), 94 - elementY#)
		OryUIUpdateSprite(sprLockInformation, "offset:" + str(GetSpriteWidth(sprLockInformation) / 2) + ",0;position:" + str((screenNo * 100) + 50) + "," + str(elementY#))
		sharedLockSettings$ = BuildSharedLockSettingsString()
		OryUIUpdateText(txtLockInformation, "text:" + sharedLockSettings$ + ";color:58,128,113,255")
		if (startLockSettingsBlueFont <> endLockSettingsBlueFont)
			for i = startLockSettingsBlueFont to endLockSettingsBlueFont - 1
				SetTextCharColor(txtLockInformation, i, 0, 0, 255, 255)
			next
		endif
		if (startLockSettingsRedFont <> endLockSettingsRedFont)
			for i = startLockSettingsRedFont to endLockSettingsRedFont
				SetTextCharColor(txtLockInformation, i, 255, 0, 0, 255)
			next
		endif
		while (GetTextTotalHeight(txtLockInformation) > GetSpriteHeight(sprLockInformation))
			OryUIUpdateText(txtLockInformation, "size:" + str(GetTextSize(txtLockInformation) - 0.1))
		endwhile
			
		OryUIPinTextToCentreOfSprite(txtLockInformation, sprLockInformation, 0, 0)
	endif
	
	// DOWNLOAD APP
	if (redrawScreen = 1)
		OryUIUpdateText(txtDownload, "position:" + str((screenNo * 100) + 50) + ",94")
		OryUIUpdateText(txtDomain, "position:" + str((screenNo * 100) + 50) + ",96.5")
	endif
	elementY# = 100
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, 0)
endif
