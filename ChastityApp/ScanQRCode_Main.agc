
if (screenToView = constScanQRCodeScreen)
	if (screenNo <> constScanQRCodeScreen)
		if (imgScanFrame = 0) then imgScanFrame = LoadImage("ScanFrame.png")
		if (imgScanLine = 0) then imgScanLine = LoadImage("ScanLine.png")
	endif
	screenNo = constScanQRCodeScreen
	SetLastScreenViewed(constLockOptionsScreen)

	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		SetDeviceCameraToImage(0, 0)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = ""
		sharedLockInfo$ = ""
		selectedLockOptionsTab = 2
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	// SCAN FRAME
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprScanFrame, "position:" + str((screenNo * 100) + 50) + "," + str(GetScreenBoundsTop() + 50 + (OryUIGetTopBarHeight(screen[screenNo].topBar) / 2)) + ";image:" + str(imgScanFrame) + ";colorID:" + str(theme[themeSelected].color[1]) + ";alpha:128")
	endif

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";alpha:0")
	endif

	// CAMERA
	if (redrawScreen = 1)
		OryUIUpdateSprite(sprCam, "position:" + str(screenNo * 100) + ",0;image:0")
	endif

	// ADVERTS
	SetAdvertVisible(0)
	
	// SCANNING IMAGE
	imgCam as integer : imgCam = 1
	timeCameraStarted# as float : timeCameraStarted# = timer()
	timedOut as integer : timedOut = 0
	cycleCounter as integer : cycleCounter = 3
	sharedID$ = ""
	SetDeviceCameraToImage(0, 0)
	while (sharedID$ = "")
		inc cycleCounter
		if (timeCameraStarted# + 10 < timer())
			timedOut = 1
			exit
		endif

		OryUIInsertTopBarListener(screen[screenNo].topBar)
		if (lower(OryUIGetTopBarNavigationReleasedIcon(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1))
			SetDeviceCameraToImage(0, 0)
			sharedID$ = ""
			sharedLockName$ = ""
			sharedLockError$ = ""
			sharedLockInfo$ = ""
			selectedLockOptionsTab = 2
			previousBreadcrumb = GetPreviousBreadcrumb()
			RemoveLastBreadcrumb()
			SetScreenToView(previousBreadcrumb)		
		endif
		if (mod(cycleCounter, 4) = 0)
			SetDeviceCameraToImage(0, imgCam)
			SetSpriteImage(sprCam, imgCam)
			sharedID$ = DecodeQRCode(imgCam)
		endif
		
		// SCAN LINE
		SetSpriteScissor(sprScanLine, GetSpriteX(sprScanFrame), GetSpriteY(sprScanFrame), GetSpriteX(sprScanFrame) + GetSpriteWidth(sprScanFrame), GetSpriteY(sprScanFrame) + GetSpriteHeight(sprScanFrame))
		OryUIUpdateSprite(sprScanLine, "position:" + str((screenNo * 100) + 50) + "," + str(GetSpriteYByOffset(sprScanLine) + scanLineDirection#) + ";image:" + str(imgScanLine) + ";colorID:" + str(theme[themeSelected].color[1]) + ";alpha:192")
		if (GetSpriteYByOffset(sprScanLine) > GetSpriteYByOffset(sprScanFrame) + (GetSpriteHeight(sprScanFrame) / 2))
			OryUIUpdateSprite(sprScanLine, "y:" + str(GetSpriteYByOffset(sprScanFrame) + (GetSpriteHeight(sprScanFrame) / 2)))
			scanLineDirection# = -1
			SetSpriteAngle(sprScanLine, 180)
		endif
		if (GetSpriteYByOffset(sprScanLine) < GetSpriteYByOffset(sprScanFrame) - (GetSpriteHeight(sprScanFrame) / 2))
			OryUIUpdateSprite(sprScanLine, "y:" + str(GetSpriteYByOffset(sprScanFrame) - (GetSpriteHeight(sprScanFrame) / 2)))
			scanLineDirection# = 1
			SetSpriteAngle(sprScanLine, 0)
		endif
	
		Sync()
	endwhile
	SetDeviceCameraToImage(0, 0)
	if (timedOut = 1)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "Timed out. Please try again."
		sharedLockInfo$ = ""
		SetScreenToView(constLockOptionsScreen)
	elseif (left(sharedID$, len(constAppName$) + 16) <> constAppName$ + "-Shareable-Lock-" or len(sharedID$) <> 31 + len(constAppName$))
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "Not a valid " + constAppName$ + " QR code. Please try again."
		sharedLockInfo$ = ""
		SetScreenToView(constLockOptionsScreen)
	else
		sharedID$ = mid(sharedID$, len(constAppName$) + 17, 15)
		sharedLockName$ = ""
		sharedLockError$ = ""
		GetSharedLockInformation(sharedID$, 1)
		SetScreenToView(constLockOptionsScreen)
	endif
	
	// SCROLL LIMITS
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, 0)
endif
