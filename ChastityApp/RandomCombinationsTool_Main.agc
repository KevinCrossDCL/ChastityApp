
OryUIHideFloatingActionButton(fabAddTime)
if (screenToView = constRandomCombinationsToolScreen)
	// LOAD SCREEN IMAGES ONCE
	if (screenNo <> constRandomCombinationsToolScreen)
		if (imgAudioOff = 0) then imgAudioOff = LoadImage("AudioOff.png")
		if (imgAudioOn = 0) then imgAudioOn = LoadImage("AudioOn.png")
		local lengthOfCombinations as integer : lengthOfCombinations = noOfDigits
	endif
	screenNo = constRandomCombinationsToolScreen

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
		ClearBreadcrumbs()
		SetScreenToView(selectedLocksTab)
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
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// NUMBER OF DIGITS/CHARACTERS IN COMBINATION
	maxDigits = 12
	if (allowDuplicatesInCombination = 2 and combinationType = 1) then maxDigits = 10
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdLengthOfCombinations, "position:" + str((screenNo * 100)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdLengthOfCombinations)
	if (redrawScreen = 1)
		OryUIUpdateInputSpinner(spinLengthOfCombinations, "defaultValue:" + str(lengthOfCombinations) + ";max:" + str(maxDigits) + ";position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetInputSpinnerHeight(spinLengthOfCombinations) + 1
	OryUIInsertInputSpinnerListener(spinLengthOfCombinations)
	if (OryUIGetInputSpinnerHasFocus(spinLengthOfCombinations))
		SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdLengthOfCombinations) - GetSpriteY(screen[screenNo].sprPage))
	endif
	lengthOfCombinations = val(OryUIGetInputSpinnerString(spinLengthOfCombinations))
	if (OryUIGetInputSpinnerChangedValue(spinLengthOfCombinations))
		SetScreenToView(constRandomCombinationsToolScreen)
		//SaveLocalVariable("noOfDigits", str(noOfDigits))
	endif
	
	// RANDOM COMBINATIONS
	timerMax = 999
	if (redrawScreen = 1)
		startTime = GetSeconds()
		for a = 1 to 20
			for b = 1 to 10
				randomCombination[a].timeToStart[b] = 0
				randomCombination[a].timeToDestroy[b] = 0
			next
		next
	endif
	if (GetSeconds() - startTime >= timerMax)
		startTime = GetSeconds()
	endif
	durationInSeconds = GetSeconds() - startTime
	secondsLeft = timerMax - durationInSeconds
	noOfColumns = floor(24 / lengthOfCombinations)
	if (noOfColumns < 2) then noOfColumns = 2
	if (noOfColumns > 5) then noOfColumns = 5
	textSize# = (100 / (noOfColumns * lengthOfCombinations))
	noOfRows = (100 - elementY# - OryUIGetProgressIndicatorHeight(timerBar) - 4) / textSize#
	columnX# = 100.0 / noOfColumns
	columnY# = (100 - elementY# - OryUIGetProgressIndicatorHeight(timerBar) - 4) / noOfRows
	for a = 1 to 20
		for b = 1 to 10
			if (a <= noOfRows and b <= noOfColumns and secondsLeft > 0)
				if (randomCombination[a].timeToDestroy[b] = secondsLeft or randomCombination[a].timeToDestroy[b] = 0)
					randomCombination[a].timeToStart[b] = secondsLeft - random2(1, lengthOfCombinations)
					randomCombination[a].timeToDestroy[b] = timerMax
					OryUIUpdateText(randomCombination[a].txtCombination[b], "alpha:0")
				endif
				if (randomCombination[a].timeToStart[b] = secondsLeft)
					randomCombination[a].timeToStart[b] = secondsLeft + 1
					randomCombination[a].timeToDestroy[b] = secondsLeft - 2
					fakeCombination$ = GenerateCombination(lengthOfCombinations, 0)
					OryUIUpdateText(randomCombination[a].txtCombination[b], "text:" + fakeCombination$ + ";size:" + str(textSize#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
					if (GetTextToSpeechReady() = 1 and randomCombinationAudioOn = 1)
						Speak(AddSpacesBetweenEachCharacter(fakeCombination$))
					endif
					tweenID = CreateTweenText(2)
					SetTweenTextAlpha(tweenID, 255, 0, TweenLinear())
					PlayTweenText(tweenID, randomCombination[a].txtCombination[b], 0)
				endif
				OryUIUpdateText(randomCombination[a].txtCombination[b], "position:" + str((screenNo * 100) + (columnX# * b) - (columnX# / 2)) + "," + str(elementY# + (columnY# * a) - (columnY#)))
			else
				OryUIUpdateText(randomCombination[a].txtCombination[b], "position:-1000,-1000")
			endif
		next
	next

	// QUIT BUTTON
	if (redrawScreen = 1)
		OryUIUpdateButton(btnQuitRandomCombinationsTool, "position:" + str((screenNo * 100) + 50) + "," + str(92 + abs(screenBoundsTop#)) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	if (OryUIGetButtonReleased(btnQuitRandomCombinationsTool))
		if (randomCombinationAudioOn = 1) then StopSpeaking()
		ClearBreadcrumbs()
		SetScreenToView(selectedLocksTab)
	endif

	// ADVERTS
	SetAdvertVisible(0)
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
endif
