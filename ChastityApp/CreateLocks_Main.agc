
if (screenToView = constCreateLocksScreen)
	if (screenNo <> constCreateLocksScreen)
		loadingSharedLock = 0
	endif
	screenNo = constCreateLocksScreen

	elementY# = screenBoundsTop#
	
	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";alpha:0")
	endif

	// DO NOT CLOSE APP
	if (redrawScreen = 1)
		OryUIUpdateText(txtDoNotCloseApp, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";depth:19")
	endif
	elementY# = elementY# + GetTextTotalHeight(txtDoNotCloseApp) + 2

	// CREATE LOCKS ON DEVICE
	if (redrawScreen = 1)
		locksCreated as integer : locksCreated = 0
		if (lockGroupID = 0)
			lockGroupID = timestampNow
		endif
		locksSavedInDB = 0
		realLock as integer : realLock = random(0, noOfCopies)
	endif
	if (locksCreated <> noOfCopies + 1)
		if (locksCreated = realLock)
			CreateNewLock(generatedCombination$, 0, locksCreated + 1, noOfCopies + 1)
			GenerateCombination(noOfDigits, 1)
		else
			fakeCombination$ as string : fakeCombination$ = GenerateCombination(noOfDigits, 0)
			CreateNewLock(fakeCombination$, 1, locksCreated + 1, noOfCopies + 1)
		endif
		inc locksCreated
	endif
	
	// CREATING LOCKS PROGRESS BAR
	if (locksSavedInDB + 1 <= noOfCopies + 1)
		OryUIUpdateText(txtCreatingLocksProgress, "text:Creating lock " + str(locksSavedInDB + 1) + " of " + str(noOfCopies + 1))
	endif
	OryUIUpdateProgressIndicator(creatingLocksProgressBar, "position:" + str((screenNo * 100) + 10) + ",51;colorID:" + str(theme[themeSelected].color[3]))
	OryUIUpdateText(txtCreatingLocksProgress, "position:" + str((screenNo * 100) + 50) + "," + str(49 - GetTextTotalHeight(txtCreatingLocksProgress)) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	OryUISetProgressIndicatorPercentage(creatingLocksProgressBar, ((locksSavedInDB * 1.0) / (noOfCopies * 1.0)) * 100.0)
	if (locksSavedInDB = noOfCopies + 1)
		lockJustCreated = 1
		SetScreenToView(constRandomCombinationsScreen)
	endif
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
endif
