
OryUIHideFloatingActionButton(fabAddTime)
if (screenToView = constRandomCombinationsScreen)
	// LOAD SCREEN IMAGES ONCE
	if (screenNo <> constRandomCombinationsScreen)
		if (imgAudioOff = 0) then imgAudioOff = LoadImage("AudioOff.png")
		if (imgAudioOn = 0) then imgAudioOn = LoadImage("AudioOn.png")
		if (imgAdd10s = 0) then imgAdd10s = LoadImage("Add10s.png")
		if (imgAdd15s = 0) then imgAdd15s = LoadImage("Add15s.png")
		if (imgAdd20s = 0) then imgAdd20s = LoadImage("Add20s.png")
		if (imgAdd25s = 0) then imgAdd25s = LoadImage("Add25s.png")
		if (imgAdd30s = 0) then imgAdd30s = LoadImage("Add30s.png")
	endif
	screenNo = constRandomCombinationsScreen

	elementY# = screenBoundsTop#
	
	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
	endif
	if (OryUIGetTopBarActionCount(screen[screenNo].topBar) = 0)
		if (GetTextToSpeechReady())
			OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Audio;iconID:" + str(imgAudioOff))
		endif
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		if (randomCombinationAudioOn = 1) then StopSpeaking()
		GetKeyholdersData(0)
		ClearBreadcrumbs()
		SetScreenToView(constMyLocksScreen)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "audio")
		if (randomCombinationAudioOn = 0)
			randomCombinationAudioOn = 1
			SaveLocalVariable("randomCombinationAudioOn", "1")
		else
			StopSpeaking()
			randomCombinationAudioOn = 0
			SaveLocalVariable("randomCombinationAudioOn", "0")
		endif
	endif
	if (randomCombinationAudioOn = 0)
		OryUIUpdateTopBarAction(screen[screenNo].topBar, 1, "iconID:" + str(imgAudioOff))
	else
		OryUIUpdateTopBarAction(screen[screenNo].topBar, 1, "iconID:" + str(imgAudioOn))
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";alpha:0")
	endif

	// RANDOM COMBINATIONS
	timerMax as integer : timerMax = 60
	if (noOfDigits = 3) then timerMax = 60
	if (noOfDigits = 4) then timerMax = 60
	if (noOfDigits = 5) then timerMax = 50
	if (noOfDigits = 6) then timerMax = 40
	if (noOfDigits = 7) then timerMax = 30
	if (noOfDigits >= 8) then timerMax = 20
	if (redrawScreen = 1)
		startTime as integer : startTime = GetSeconds()
		for a = 1 to 20
			for b = 1 to 10
				randomCombination[a].timeToStart[b] = 0
				randomCombination[a].timeToDestroy[b] = 0
			next
		next
	endif
	durationInSeconds as integer : durationInSeconds = GetSeconds() - startTime
	secondsLeft = timerMax - durationInSeconds
	if (secondsLeft < 0) then secondsLeft = 0
	if (secondsLeft > timerMax) then secondsLeft = timerMax
	noOfColumns as integer : noOfColumns = floor(24 / noOfDigits)
	if (noOfColumns < 2) then noOfColumns = 2
	if (noOfColumns > 5) then noOfColumns = 5
	textSize# as float : textSize# = (100 / (noOfColumns * noOfDigits))
	noOfRows as integer : noOfRows = (100 - elementY# - OryUIGetProgressIndicatorHeight(timerBar) - 4) / textSize#
	columnX# as float : columnX# = 100.0 / noOfColumns
	columnY# as float : columnY# = (100 - elementY# - OryUIGetProgressIndicatorHeight(timerBar) - 4) / noOfRows
	for a = 1 to 20
		for b = 1 to 10
			if (a <= noOfRows and b <= noOfColumns and secondsLeft > 0)
				if (randomCombination[a].timeToDestroy[b] = secondsLeft or randomCombination[a].timeToDestroy[b] = 0)
					randomCombination[a].timeToStart[b] = secondsLeft - random2(1, noOfDigits)
					randomCombination[a].timeToDestroy[b] = timerMax
					OryUIUpdateText(randomCombination[a].txtCombination[b], "alpha:0")
				endif
				if (randomCombination[a].timeToStart[b] = secondsLeft)
					randomCombination[a].timeToStart[b] = secondsLeft + 1
					randomCombination[a].timeToDestroy[b] = secondsLeft - 2
					fakeCombination$ = GenerateCombination(noOfDigits, 0)
					OryUIUpdateText(randomCombination[a].txtCombination[b], "text:" + fakeCombination$ + ";size:" + str(textSize#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
					if (GetTextToSpeechReady() = 1 and randomCombinationAudioOn = 1)
						Speak(AddSpacesBetweenEachCharacter(fakeCombination$))
					endif
					tweenID as integer : tweenID = CreateTweenText(2)
					SetTweenTextAlpha(tweenID, 255, 0, TweenLinear())
					PlayTweenText(tweenID, randomCombination[a].txtCombination[b], 0)
				endif
				OryUIUpdateText(randomCombination[a].txtCombination[b], "position:" + str((screenNo * 100) + (columnX# * b) - (columnX# / 2)) + "," + str(elementY# + (columnY# * a) - (columnY#)))
			else
				OryUIUpdateText(randomCombination[a].txtCombination[b], "position:-1000,-1000")
			endif
		next
	next

	if (GetRawKeyPressed(49)) then inc locksCreated
	if (secondsLeft = 0)
		if (randomCombinationAudioOn = 1) then StopSpeaking()
		GetKeyholdersData(0)
		ClearBreadcrumbs()
		SetScreenToView(constMyLocksScreen)
	endif

	// TIMER BAR
	if (secondsLeft > 0)
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprAddTimeHolder, "position:" + str((screenNo * 100) + 50) + "," + str(93.5 + abs(screenBoundsTop#)))
			iconID as integer : iconID = 0
			if (timerMax = 60) then iconID = imgAdd30s
			if (timerMax = 50) then iconID = imgAdd25s
			if (timerMax = 40) then iconID = imgAdd20s
			if (timerMax = 30) then iconID = imgAdd15s
			if (timerMax = 20) then iconID = imgAdd10s
			OryUIUpdateFloatingActionButton(fabAddTime, "iconID:" + str(iconID) + ";iconattachToSpriteID:" + str(sprAddTimeHolder) + ";placement:bottomCenter;colorID:" + str(theme[themeSelected].color[3]))
		endif
		if (secondsLeft < (timerMax / 2) and secondsLeft > 0)
			OryUIShowFloatingActionButton(fabAddTime)
			SetSpritePositionByOffset(OryUIFloatingActionButtonCollection[fabAddTime].sprShadow, 50, 94.5 + abs(screenBoundsTop#))
			SetSpritePositionByOffset(OryUIFloatingActionButtonCollection[fabAddTime].sprContainer, 50, 94 + abs(screenBoundsTop#))
			OryUIPinSpriteToCentreOfSprite(OryUIFloatingActionButtonCollection[fabAddTime].sprIcon, OryUIFloatingActionButtonCollection[fabAddTime].sprContainer, 0, 0)
		endif
		if (OryUIGetFloatingActionButtonReleased(fabAddTime))
			startTime = startTime + (timerMax / 2)
			for a = 1 to 20
				for b = 1 to 10
					randomCombination[a].timeToDestroy[b] = randomCombination[a].timeToDestroy[b] + (timerMax / 2)
					randomCombination[a].timeToStart[b] = randomCombination[a].timeToStart[b] + (timerMax / 2)
				next
			next
		endif
		OryUIUpdateProgressIndicator(timerBar, "position:" + str(screenNo * 100) + "," + str(95 + abs(screenBoundsTop#)) + ";colorID:" + str(theme[themeSelected].color[2]))
		OryUISetProgressIndicatorPercentage(timerBar, (100.0 / timerMax) * (timerMax - durationInSeconds))
		OryUIUpdateText(txtTimer, "text:" + str(secondsLeft))
		if (redrawScreen = 1)
			OryUIUpdateSprite(sprTimerBackground, "size:" + str(OryUIGetProgressIndicatorWidth(timerBar)) + "," + str(OryUIGetProgressIndicatorHeight(timerBar)) + ";position:" + str(OryUIGetProgressIndicatorX(timerBar)) + "," + str(OryUIGetProgressIndicatorY(timerBar)) + ";colorID:" + str(theme[themeSelected].color[5]))
		endif
		OryUIPinTextToCentreOfSprite(txtTimer, sprTimerBackground, 0, 0)
	else
		OryUIUpdateProgressIndicator(timerBar, "position:-1000,-1000")
		OryUIUpdateText(txtTimer, "position:-1000,-1000")
		OryUIUpdateSprite(sprTimerBackground, "position:-1000,-1000")
	endif
	
	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
endif
