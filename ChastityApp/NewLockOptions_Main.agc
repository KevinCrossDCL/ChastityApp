
if (screenToView = constNewLockOptionsScreen)
	screenNo = constNewLockOptionsScreen
	selectedNewLockTab = screenNo

	// TOP BAR
	if (redrawScreen = 1)
		OryUIUpdateTopBar(screen[screenNo].topBar, "position:" + str(screenNo * 100) + ",0;colorID:" + str(theme[themeSelected].color[3]))
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedIcon(screen[screenNo].topBar)) = "back" or GetRawKeyPressed(27))
		SetScreenToView(selectedLocksTab, 0)
	endif
	elementY# = OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(theme[themeSelected].color[3]) + ";activeColor:255,255,255;inactiveColor:255,255,255")
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 2)
		SetScreenToView(constLoadLockOptionsScreen, 0)
	endif
	elementY# = OryUIGetTopBarHeight(screen[screenNo].topBar) + OryUIGetTabsHeight(screen[screenNo].tabs) + 2

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	//elementY# = OryUIGetTopBarHeight(screen[screenNo].topBar) + OryUIGetTabsHeight(screen[screenNo].tabs) + 2

	// WHO IS THE LOCK FOR?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdWhoIsTheLockFor, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpWhoIsTheLockFor) = "Myself")
			shareable = 0
			userText$ = "You"
			OryUIUpdateTextCard(crdWhoIsTheLockFor, "supportingText:A lock that runs on your device for you to use will be created. It can run with or without a keyholder.")
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpWhoIsTheLockFor) = "Others")
			shareable = 1
			userText$ = "They"
			OryUIUpdateTextCard(crdWhoIsTheLockFor, "supportingText:A lock that runs on other peoples devices that you control.")
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdWhoIsTheLockFor)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpWhoIsTheLockFor, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpWhoIsTheLockFor)
	if (OryUIGetButtonGroupItemReleasedIndex(grpWhoIsTheLockFor) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpWhoIsTheLockFor) + 2

	// IS THIS A TEST LOCK?
	if (shareable = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdIsThisATestLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedIndex(grpIsThisATestLock) = 1)
				testLock = 1
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpIsThisATestLock) = 2)
				testLock = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdIsThisATestLock)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpIsThisATestLock, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpIsThisATestLock)
		if (OryUIGetButtonGroupItemReleasedIndex(grpIsThisATestLock) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpIsThisATestLock) + 2
	else
		if (redrawScreen = 1)
			testLock = 0
			OryUIUpdateTextCard(crdIsThisATestLock, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpIsThisATestLock, "position:-1000,-1000")
		endif
	endif
	
	// WOULD YOU LIKE A BOT TO KEYHOLD?
	if (shareable = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpWouldYouLikeABotToKeyhold) = "Yes")
				botControlled = 1
				OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "supportingText:A bot will choose some of the settings and control the lock.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWouldYouLikeABotToKeyhold) = "No")
				botControlled = 0
				OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "supportingText:This lock will run privately without a bot keyholder.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdWouldYouLikeABotToKeyhold)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpWouldYouLikeABotToKeyhold, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpWouldYouLikeABotToKeyhold)
		if (OryUIGetButtonGroupItemReleasedIndex(grpWouldYouLikeABotToKeyhold) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpWouldYouLikeABotToKeyhold) + 2
	else
		if (redrawScreen = 1)
			botControlled = 0
			OryUIUpdateTextCard(crdWouldYouLikeABotToKeyhold, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpWouldYouLikeABotToKeyhold, "position:-1000,-1000")
		endif
	endif
	
	// WHICH BOT?
	if (botControlled = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdWhichBot, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Hailey")
				botChosen = 1
				OryUIUpdateTextCard(crdWhichBot, "supportingText:Hailey[colon] 'Want me to play with you? xx'" + chr(10) + "Kind Bot | Users Locked[colon] 580" + chr(10) + "4.1 out of 5 stars (1663 Ratings);supportingTextAlignment:center;")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Blaine")
				botChosen = 2
				OryUIUpdateTextCard(crdWhichBot, "supportingText:Blaine[colon] 'Relax, we'll take it one step at a time.'" + chr(10) + "Kind Bot | Users Locked[colon] 109" + chr(10) + "4.1 out of 5 stars (292 Ratings);supportingTextAlignment:center;")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Zoe")
				botChosen = 3
				OryUIUpdateTextCard(crdWhichBot, "supportingText:Zoe[colon] 'You gave me your keys. They're mine!'" + chr(10) + "Mean Bot | Users Locked[colon] 1193" + chr(10) + "4 out of 5 stars (3825 Ratings);supportingTextAlignment:center;")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpWhichBot) = "Chase")
				botChosen = 4
				OryUIUpdateTextCard(crdWhichBot, "supportingText:Chase[colon] 'Access Denied!'" + chr(10) + "Mean Bot | Users Locked[colon] 219" + chr(10) + "4.1 out of 5 stars (771 Ratings);supportingTextAlignment:center;")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdWhichBot)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpWhichBot, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpWhichBot)
		if (OryUIGetButtonGroupItemReleasedIndex(grpWhichBot) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpWhichBot) + 2
	else
		if (redrawScreen = 1)
			botChosen = 0
			OryUIUpdateTextCard(crdWhichBot, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpWhichBot, "position:-1000,-1000")
		endif
	endif

	// DO YOU TRUST THE BOT?
	if (botControlled = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouTrustTheBot, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouTrustTheBot) = "Yes")
				trustKeyholder = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouTrustTheBot) = "No")
				trustKeyholder = 0
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouTrustTheBot)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouTrustTheBot, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpDoYouTrustTheBot)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouTrustTheBot) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouTrustTheBot) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouTrustTheBot, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouTrustTheBot, "position:-1000,-1000")
		endif
	endif

	// TYPE OF LOCK?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdTypeOfLock, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedName(grpTypeOfLock) = "VariableLock")
			fixed = 0
			OryUIUpdateTextCard(crdTypeOfLock, "supportingText:" + userText$ + " will have a chance at regular intervals to unlock. Variable locks use a card system.")
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpTypeOfLock) = "FixedLock")
			fixed = 1
			OryUIUpdateTextCard(crdTypeOfLock, "supportingText:Fixed locks run for a fixed duration.")
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdTypeOfLock)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpTypeOfLock, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpTypeOfLock)
	if (OryUIGetButtonGroupItemReleasedIndex(grpTypeOfLock) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpTypeOfLock) + 2

	// CHANCE REGULARITY?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdChanceRegularity, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "24H")
				regularity# = 24
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 24 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "12H")
				regularity# = 12
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 12 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "6H")
				regularity# = 6
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 6 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "3H")
				regularity# = 3
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 3 hours to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "1H")
				regularity# = 1
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every hour to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "30M")
				regularity# = 0.5
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 30 minutes to unlock early.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpChanceRegularity) = "15M")
				regularity# = 0.25
				OryUIUpdateTextCard(crdChanceRegularity, "supportingText:" + userText$ + " will be given a chance every 15 minutes to unlock early.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdChanceRegularity)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpChanceRegularity, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpChanceRegularity)
		if (OryUIGetButtonGroupItemReleasedIndex(grpChanceRegularity) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpChanceRegularity) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdChanceRegularity, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpChanceRegularity, "position:-1000,-1000")
		endif
	endif

	// UNIT OF TIME?
	if (fixed = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUnitOfTime, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpUnitOfTime) = "Daily")
				regularity# = 24
				OryUIUpdateTextCard(crdUnitOfTime, "supportingText:Lock durations will be measured in days (i.e. 1-365 days)")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpUnitOfTime) = "Hourly")
				regularity# = 1
				OryUIUpdateTextCard(crdUnitOfTime, "supportingText:Lock durations will be measured in hours (i.e. 1-1000 hours)")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdUnitOfTime)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpUnitOfTime, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpUnitOfTime)
		if (OryUIGetButtonGroupItemReleasedIndex(grpUnitOfTime) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpUnitOfTime) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdUnitOfTime, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpUnitOfTime, "position:-1000,-1000")
		endif
	endif

	// CUMULATIVE CHANCES
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCumulativeChances, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpCumulativeChances) = "Yes")
				cumulative = 1
				if (regularity# = 24) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X days. For example if " + lower(userText$) + " were away for 3 days " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 12) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 12 hours. For example if " + lower(userText$) + " were away for 36 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 6) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 6 hours. For example if " + lower(userText$) + " were away for 18 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 3) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 3 hours. For example if " + lower(userText$) + " were away for 9 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 1) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X hours. For example if " + lower(userText$) + " were away for 3 hours " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 0.5) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 30 minutes. For example if " + lower(userText$) + " were away for 90 minutes " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
				if (regularity# = 0.25) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have X chances after being away for X 15 minutes. For example if " + lower(userText$) + " were away for 45 minutes " + lower(userText$) + " would get 3 chances when " + lower(userText$) + " return.")
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCumulativeChances) = "No")
				cumulative = 0
				if (regularity# = 24) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X days. For example if " + lower(userText$) + " were away for 3 days " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 12) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 12 hours. For example if " + lower(userText$) + " were away for 36 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 6) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 6 hours. For example if " + lower(userText$) + " were away for 18 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 3) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 3 hours. For example if " + lower(userText$) + " were away for 9 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 1) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X hours. For example if " + lower(userText$) + " were away for 3 hours " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 0.5) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 30 minutes. For example if " + lower(userText$) + " were away for 90 minutes " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
				if (regularity# = 0.25) then OryUIUpdateTextCard(crdCumulativeChances, "supportingText:" + userText$ + " will have 1 chance after being away for X 15 minutes. For example if " + lower(userText$) + " were away for 45 minutes " + lower(userText$) + " would get 1 chance when " + lower(userText$) + " return.")
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCumulativeChances)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpCumulativeChances, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
		endif
		OryUIInsertButtonGroupListener(grpCumulativeChances)
		if (OryUIGetButtonGroupItemReleasedIndex(grpCumulativeChances) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpCumulativeChances) + 2
	else
		if (redrawScreen = 1)
			cumulative = 0
			OryUIUpdateTextCard(crdCumulativeChances, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpCumulativeChances, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF DIGITS/CHARACTERS IN COMBINATION
	if (combinationType = 1)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdNumberOfDigitsInCombination, "headerText:Number of digits in combination?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDigitsInCombination)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinNumberOfDigitsInCombination, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinNumberOfDigitsInCombination) + 2
	elseif (combinationType = 2 or combinationType = 3)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdNumberOfDigitsInCombination, "headerText:Number of characters in combination?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDigitsInCombination)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinNumberOfDigitsInCombination, "position:" + str((screenNo * 100) + 36.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinNumberOfDigitsInCombination) + 2
	endif
	OryUIInsertInputSpinnerListener(spinNumberOfDigitsInCombination)
	if (OryUIGetInputSpinnerHasFocus(spinNumberOfDigitsInCombination))
		SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfDigitsInCombination) - GetSpriteY(screen[screenNo].sprPage))
	endif
	
	// NUMBER OF RED CARDS / DAYS / HOURS / MINUTES?
	if (fixed = 0)
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 24 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 12) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 12 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 6) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 6 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 3) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 3 hours before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 1 hour before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.5) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 30 minutes before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.25) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of red cards?;supportingText:When a red card is revealed " + lower(userText$) + " will have to wait 15 minutes before " + lower(userText$) + " can pick again.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfRedCards)
		if (regularity# >= 12)
			inputSpinner1Min = 0
			inputSpinner1Max = 365
			inputSpinner2Min = 0
			inputSpinner2Max = 365
		endif
		if (regularity# <= 6)
			inputSpinner1Min = 0
			inputSpinner1Max = 300
			inputSpinner2Min = 0
			inputSpinner2Max = 300
		endif
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRedCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRedCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfRedCards) + 2
	else
		if (regularity# = 24)
			inputSpinner1Min = 0
			inputSpinner1Max = 365
			inputSpinner2Min = 0
			inputSpinner2Max = 365
		endif
		if (regularity# = 1)
			inputSpinner1Min = 0
			inputSpinner1Max = 999
			inputSpinner2Min = 0
			inputSpinner2Max = 999
		endif
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRedCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRedCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards))
		endif
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of days?;supportingText:;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdNumberOfRedCards, "headerText:Number of hours?;supportingText:;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfRedCards)
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfRedCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfRedCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfRedCards) + 2
	endif
	OryUIInsertInputSpinnerListener(spinMinNumberOfRedCards)
	OryUIInsertInputSpinnerListener(spinMaxNumberOfRedCards)
	if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRedCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRedCards))
		SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfRedCards) - GetSpriteY(screen[screenNo].sprPage))
	endif
	minReds = val(OryUIGetInputSpinnerString(spinMinNumberOfRedCards))
	maxReds = val(OryUIGetInputSpinnerString(spinMaxNumberOfRedCards))

	// DO YOU WANT TO ADD YELLOW CARDS?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddYellowCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "Yes")
				yellowCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "No")
				yellowCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddYellowCards) = "BotDecides")
				yellowCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddYellowCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddYellowCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddYellowCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddYellowCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddYellowCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddYellowCards) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddYellowCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddYellowCards) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddYellowCards) + 2
	else
		if (redrawScreen = 1)
			yellowCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddYellowCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddYellowCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF RANDOM YELLOW CARDS?
	if (yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfRandomYellowCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 200
		inputSpinner2Min = 0
		inputSpinner2Max = 200
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRandomYellowCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRandomYellowCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfRandomYellowCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfRandomYellowCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfRandomYellowCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfRandomYellowCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfRandomYellowCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfRandomYellowCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minYellowsRandom = val(OryUIGetInputSpinnerString(spinMinNumberOfRandomYellowCards))
		maxYellowsRandom = val(OryUIGetInputSpinnerString(spinMaxNumberOfRandomYellowCards))
	else
		if (redrawScreen = 1)
			minYellowsRandom = 0
			maxYellowsRandom = 0
			OryUIUpdateTextCard(crdNumberOfRandomYellowCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfRandomYellowCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfRandomYellowCards, "position:-1000,-1000")
		endif
	endif
			
	// NUMBER OF YELLOW CARDS THAT REMOVE RED CARDS?
	if (yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfYellowMinusCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 200
		inputSpinner2Min = 0
		inputSpinner2Max = 200
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowMinusCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowMinusCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfYellowMinusCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfYellowMinusCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfYellowMinusCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowMinusCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfYellowMinusCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfYellowMinusCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minYellowsMinus = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowMinusCards))
		maxYellowsMinus = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowMinusCards))
	else
		if (redrawScreen = 1)
			minYellowsMinus = 0
			maxYellowsMinus = 0
			OryUIUpdateTextCard(crdNumberOfYellowMinusCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowMinusCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowMinusCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF YELLOW CARDS THAT ADD RED CARDS?
	if (yellowCards = 1)
		OryUIUpdateTextCard(crdNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfYellowAddCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 200
		inputSpinner2Min = 0
		inputSpinner2Max = 200
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowAddCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowAddCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfYellowAddCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfYellowAddCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfYellowAddCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfYellowAddCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfYellowAddCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfYellowAddCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minYellowsAdd = val(OryUIGetInputSpinnerString(spinMinNumberOfYellowAddCards))
		maxYellowsAdd = val(OryUIGetInputSpinnerString(spinMaxNumberOfYellowAddCards))
	else
		if (redrawScreen = 1)
			minYellowsAdd = 0
			maxYellowsAdd = 0
			OryUIUpdateTextCard(crdNumberOfYellowAddCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfYellowAddCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfYellowAddCards, "position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD FREEZE CARDS?
	if (fixed = 0)
		if (redrawScreen = 1)
			if (regularity# = 24) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 2-4 days;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 12) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 24-48 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 6) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 12-24 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 3) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 6-12 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 1) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 2-4 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.5) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 1-2 hours;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (regularity# = 0.25) then OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "supportingText:When a freeze card is revealed the lock will be frozen 30-60 minutes;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "Yes")
				freezeCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "No")
				freezeCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddFreezeCards) = "BotDecides")
				freezeCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddFreezeCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddFreezeCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddFreezeCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddFreezeCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddFreezeCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddFreezeCards) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddFreezeCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddFreezeCards) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddFreezeCards) + 2
	else
		if (redrawScreen = 1)
			freezeCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddFreezeCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddFreezeCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF FREEZE CARDS?
	if (freezeCards = 1)
		OryUIUpdateTextCard(crdNumberOfFreezeCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfFreezeCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 20
		inputSpinner2Min = 0
		inputSpinner2Max = 20
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFreezeCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFreezeCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfFreezeCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfFreezeCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfFreezeCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFreezeCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFreezeCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfFreezeCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minFreezes = val(OryUIGetInputSpinnerString(spinMinNumberOfFreezeCards))
		maxFreezes = val(OryUIGetInputSpinnerString(spinMaxNumberOfFreezeCards))
	else
		if (redrawScreen = 1)
			minFreezes = 0
			maxFreezes = 0
			OryUIUpdateTextCard(crdNumberOfFreezeCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfFreezeCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfFreezeCards, "position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD DOUBLE UP CARDS?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddDoubleUpCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "Yes")
				doubleUpCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "No")
				doubleUpCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddDoubleUpCards) = "BotDecides")
				doubleUpCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddDoubleUpCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddDoubleUpCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddDoubleUpCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddDoubleUpCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddDoubleUpCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddDoubleUpCards) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddDoubleUpCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddDoubleUpCards) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddDoubleUpCards) + 2
	else
		if (redrawScreen = 1)
			doubleUpCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddDoubleUpCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddDoubleUpCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF DOUBLE UP CARDS?
	if (doubleUpCards = 1)
		OryUIUpdateTextCard(crdNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfDoubleUpCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 20
		inputSpinner2Min = 0
		inputSpinner2Max = 20
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfDoubleUpCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfDoubleUpCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfDoubleUpCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfDoubleUpCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfDoubleUpCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfDoubleUpCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfDoubleUpCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfDoubleUpCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minDoubleUps = val(OryUIGetInputSpinnerString(spinMinNumberOfDoubleUpCards))
		maxDoubleUps = val(OryUIGetInputSpinnerString(spinMaxNumberOfDoubleUpCards))
	else
		if (redrawScreen = 1)
			minDoubleUps = 0
			maxDoubleUps = 0
			OryUIUpdateTextCard(crdNumberOfDoubleUpCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfDoubleUpCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfDoubleUpCards, "position:-1000,-1000")
		endif
	endif

	// DO YOU WANT TO ADD RESET CARDS?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdDoYouWantToAddResetCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "Yes")
				resetCards = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "No")
				resetCards = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpDoYouWantToAddResetCards) = "BotDecides")
				resetCards = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdDoYouWantToAddResetCards)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpDoYouWantToAddResetCards, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpDoYouWantToAddResetCards, 2)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpDoYouWantToAddResetCards, 3)
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpDoYouWantToAddResetCards, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpDoYouWantToAddResetCards) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)
		endif
		OryUIInsertButtonGroupListener(grpDoYouWantToAddResetCards)
		if (OryUIGetButtonGroupItemReleasedIndex(grpDoYouWantToAddResetCards) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpDoYouWantToAddResetCards) + 2
	else
		if (redrawScreen = 1)
			resetCards = 0
			OryUIUpdateTextCard(crdDoYouWantToAddResetCards, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpDoYouWantToAddResetCards, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF RESET CARDS?
	if (resetCards = 1)
		OryUIUpdateTextCard(crdNumberOfResetCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfResetCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 20
		inputSpinner2Min = 0
		inputSpinner2Max = 20
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfResetCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfResetCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfResetCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfResetCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfResetCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfResetCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfResetCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfResetCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfResetCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfResetCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minResets = val(OryUIGetInputSpinnerString(spinMinNumberOfResetCards))
		maxResets = val(OryUIGetInputSpinnerString(spinMaxNumberOfResetCards))
	else
		if (redrawScreen = 1)
			minResets = 0
			maxResets = 0
			OryUIUpdateTextCard(crdNumberOfResetCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfResetCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfResetCards, "position:-1000,-1000")
		endif
	endif

	// MULTIPLE GREENS REQUIRED?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdMultipleGreensRequired, "supportingText:If multiple green cards are required " + lower(userText$) + " will need to find all green cards that are in play to unlock. Otherwise " + lower(userText$) + " just need to find one green card, and any extra greens added increase the chance of unlocking early.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "Yes")
				multipleGreensRequired = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "No")
				multipleGreensRequired = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpMultipleGreensRequired) = "BotDecides")
				multipleGreensRequired = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdMultipleGreensRequired)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpMultipleGreensRequired, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpMultipleGreensRequired, 2)
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpMultipleGreensRequired, 3)
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpMultipleGreensRequired, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpMultipleGreensRequired) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)
		endif
		OryUIInsertButtonGroupListener(grpMultipleGreensRequired)
		if (OryUIGetButtonGroupItemReleasedIndex(grpMultipleGreensRequired) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpMultipleGreensRequired) + 2
	else
		if (redrawScreen = 1)
			multipleGreensRequired = 0
			OryUIUpdateTextCard(crdMultipleGreensRequired, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpMultipleGreensRequired, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF GREEN CARDS?
	if (multipleGreensRequired = 1)
		OryUIUpdateTextCard(crdNumberOfGreenCards, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfGreenCards)
		inputSpinner1Min = 0
		inputSpinner1Max = 20
		inputSpinner2Min = 0
		inputSpinner2Max = 20
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfGreenCards) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfGreenCards) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfGreenCards))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfGreenCards) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfGreenCards)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfGreenCards)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfGreenCards) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfGreenCards))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfGreenCards) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minGreens = val(OryUIGetInputSpinnerString(spinMinNumberOfGreenCards))
		maxGreens = val(OryUIGetInputSpinnerString(spinMaxNumberOfGreenCards))
	else
		if (redrawScreen = 1)
			minGreens = 0
			maxGreens = 0
			OryUIUpdateTextCard(crdNumberOfGreenCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfGreenCards, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfGreenCards, "position:-1000,-1000")
		endif
	endif

	// HIDE CARD INFORMATION?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdShowCardInformation, "supportingText:If multiple green cards are required " + lower(userText$) + " will need to find all green cards that are in play to unlock. Otherwise " + lower(userText$) + " just need to find one green card, and any extra greens added increase the chance of unlocking early.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpShowCardInformation) = "Yes")
				cardInfoHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpShowCardInformation) = "No")
				cardInfoHidden = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpShowCardInformation) = "BotDecides")
				cardInfoHidden = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdShowCardInformation)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpShowCardInformation, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpShowCardInformation, 2)
				OryUIUpdateButtonGroupItem(grpShowCardInformation, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpShowCardInformation, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpShowCardInformation, 3)
				OryUIUpdateButtonGroupItem(grpShowCardInformation, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpShowCardInformation, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpShowCardInformation, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpShowCardInformation) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpShowCardInformation, 2)
		endif
		OryUIInsertButtonGroupListener(grpShowCardInformation)
		if (OryUIGetButtonGroupItemReleasedIndex(grpShowCardInformation) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpShowCardInformation) + 2
	else
		if (redrawScreen = 1)
			cardInfoHidden = 0
			OryUIUpdateTextCard(crdShowCardInformation, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpShowCardInformation, "position:-1000,-1000")
		endif
	endif

	// HIDE TIMER?
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdHideTimer, "supportingText:If hidden " + lower(userText$) + " will not see how long is left of the lock.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "Yes")
				timerHidden = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "No")
				timerHidden = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpHideTimer) = "BotDecides")
				timerHidden = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdHideTimer)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpHideTimer, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpHideTimer, 2)
				OryUIUpdateButtonGroupItem(grpHideTimer, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideTimer, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpHideTimer, 3)
				OryUIUpdateButtonGroupItem(grpHideTimer, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpHideTimer, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpHideTimer, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpHideTimer) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)
		endif
		OryUIInsertButtonGroupListener(grpHideTimer)
		if (OryUIGetButtonGroupItemReleasedIndex(grpHideTimer) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpHideTimer) + 2
	else
		if (redrawScreen = 1)
			timerHidden = 0
			OryUIUpdateTextCard(crdHideTimer, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpHideTimer, "position:-1000,-1000")
		endif
	endif

	// CREATE FAKE COMBINATION?
	//showFakeCombinationOptions = 0
	//if (shareable = 0 and permanent = 0)
		//if (loadingSharedLock = 0)
			//maxNoOfCopies = 19 - noOfLocks
			//if (fixed = 0 or botControlled = 1) then showFakeCombinationOptions = 1
			//if (fixed = 1 and minReds <> maxReds) then showFakeCombinationOptions = 1
			//if (maxNoOfCopies <= 0) then showFakeCombinationOptions = 0
		//endif
		//if (loadingSharedLock = 1)
			//maxNoOfCopies = maximumCopies
			//if (maxNoOfCopies > 19 - noOfLocks)
				//maxNoOfCopies = 19 - noOfLocks
			//endif
			//if (sharedID$ <> "" and allowCopies = 1 and maxNoOfCopies >= 1) then showFakeCombinationOptions = 1
		//endif
	//endif
	//if (shareable = 1 and permanent = 0)
		//maxNoOfCopies = 19
		//if (fixed = 0) then showFakeCombinationOptions = 1
		//if (fixed = 1 and minReds <> maxReds) then showFakeCombinationOptions = 1
	//endif
	//if (sandboxMode = 1) then showFakeCombinationOptions = 0
	//if (showFakeCombinationOptions = 1)
	if (fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCreateFakeCombination, "supportingText:Create copies with fake combinations?;subLabel:Multiple copies of the same lock can be created, each with a fake combination. " + userText$ + " won't know which one is real or fake until " + lower(userText$) + " try the combination.;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "Yes")
				createCopies = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "No")
				createCopies = 0
			endif
			if (OryUIGetButtonGroupItemSelectedName(grpCreateFakeCombination) = "BotDecides")
				createCopies = 3
			endif
		endif
		elementY# = elementY# + OryUIGetTextCardHeight(crdCreateFakeCombination)
		if (redrawScreen = 1)
			OryUIUpdateButtonGroup(grpCreateFakeCombination, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(theme[themeSelected].color[3]) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
			if (botControlled = 0)
				OryUISetButtonGroupItemCount(grpCreateFakeCombination, 2)
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 2, "name:No;text:No")
			else
				OryUISetButtonGroupItemCount(grpCreateFakeCombination, 3)
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 1, "name:Yes;text:Yes")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 2, "name:No;text:No")
				OryUIUpdateButtonGroupItem(grpCreateFakeCombination, 3, "name:BotDecides;text:Bot Decides")
			endif
			if (OryUIGetButtonGroupItemSelectedIndex(grpCreateFakeCombination) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)
		endif
		OryUIInsertButtonGroupListener(grpCreateFakeCombination)
		if (OryUIGetButtonGroupItemReleasedIndex(grpCreateFakeCombination) > 0) then SetScreenToView(constNewLockOptionsScreen, GetViewOffsetY())
		elementY# = elementY# + OryUIGetButtonGroupHeight(grpCreateFakeCombination) + 2
	else
		if (redrawScreen = 1)
			OryUIUpdateTextCard(crdCreateFakeCombination, "position:-1000,-1000")
			OryUIUpdateButtonGroup(grpCreateFakeCombination, "position:-1000,-1000")
		endif
	endif

	// NUMBER OF FAKE COMBINATION COPIES?
	if (createCopies = 1)
		OryUIUpdateTextCard(crdNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		elementY# = elementY# + OryUIGetTextCardHeight(crdNumberOfFakeCombinationCopies)
		inputSpinner1Min = 0
		inputSpinner1Max = 20
		inputSpinner2Min = 0
		inputSpinner2Max = 20
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFakeCombinationCopies) = 0 and OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFakeCombinationCopies) = 0)
			inputSpinner1Max = val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies))
			inputSpinner2Min = val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies))
		endif
		if (redrawScreen = 1)
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 9.5 + 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "position:" + str((screenNo * 100) + 63.5 - 8) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
		OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "min:" + str(inputSpinner1Min) + ";max:" + str(inputSpinner1Max) + ";step:1")
		OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "min:" + str(inputSpinner2Min) + ";max:" + str(inputSpinner2Max) + ";step:1")
		elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinNumberOfFakeCombinationCopies) + 2
		OryUIInsertInputSpinnerListener(spinMinNumberOfFakeCombinationCopies)
		OryUIInsertInputSpinnerListener(spinMaxNumberOfFakeCombinationCopies)
		if (OryUIGetInputSpinnerHasFocus(spinMinNumberOfFakeCombinationCopies) or OryUIGetInputSpinnerHasFocus(spinMaxNumberOfFakeCombinationCopies))
			SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdNumberOfFakeCombinationCopies) - GetSpriteY(screen[screenNo].sprPage))
		endif
		minCopies = val(OryUIGetInputSpinnerString(spinMinNumberOfFakeCombinationCopies))
		maxCopies = val(OryUIGetInputSpinnerString(spinMaxNumberOfFakeCombinationCopies))
	else
		if (redrawScreen = 1)
			minCopies = 0
			maxCopies = 0
			OryUIUpdateTextCard(crdNumberOfFakeCombinationCopies, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMinNumberOfFakeCombinationCopies, "position:-1000,-1000")
			OryUIUpdateInputSpinner(spinMaxNumberOfFakeCombinationCopies, "position:-1000,-1000")
		endif
	endif
	
remstart


// ENABLE EARLY RELEASE WITH A PURCHASED KEY
if ((loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and keyholderDisabledKey = 0)) and sandboxMode = 0 and permanent = 0)
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionEnableEarlyReleaseWithAPurchasedKey].buttonSelected = 0)
		lockOptions[LockOptionEnableEarlyReleaseWithAPurchasedKey].buttonSelected = 1
	endif
	if (lockOptions[LockOptionEnableEarlyReleaseWithAPurchasedKey].buttonSelected = 1)
		keyDisabled = 0
	elseif (lockOptions[LockOptionEnableEarlyReleaseWithAPurchasedKey].buttonSelected = 2)
		keyDisabled = 1
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionEnableEarlyReleaseWithAPurchasedKey, "label:Enable early release with a purchased key?;subLabel:If enabled, and in case of an emergency " + lower(userText$) + " have the option to purchase a digital key which will finish and unlock the lock automatically.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Yes,No;selected:" + str(lockOptions[LockOptionEnableEarlyReleaseWithAPurchasedKey].buttonSelected))
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionEnableEarlyReleaseWithAPurchasedKey, "position:-1000,-1000")
	if (loadingSharedLock = 1 and keyholderDisabledKey = 1)
		keyDisabled = 1
	//else
	//	keyDisabled = 0
	endif
endif

// NUMBER OF KEYS REQUIRED FOR EMERGENCY RELEASE?
if (((loadingSharedLock = 0 and shareable = 0) or (loadingSharedLock = 1 and sharedID$ <> "" and keyholderDisabledKey = 0)) and keyDisabled = 0 and sandboxMode = 0)
	lockOptionY# = contentHeight# + 2
	if (noOfKeysRequired = 0) then noOfKeysRequired	= 1
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionNoOfKeysRequired, "label:Number of keys required for emergency release?;subLabel:If you want to remove the temptation of buying a key but still want the option available incase of an emergency you can choose how many keys you would need to purchase. Keys aren't lost if used on a fake lock.;subLabel2:1 key required (1 key costs[colon] " + GetInAppPurchaseLocalPrice(1) + ");position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";range:1,50,1;rangeValues:" + str(noOfKeysRequired))
	UpdateNewLockOptionRange(LockOptionNoOfKeysRequired)
	if (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) = 1)
		UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:1 key required (1 key costs[colon] " + GetInAppPurchaseLocalPrice(1) + ")")
	else
		if (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) < 5)
			UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:" + str(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1], 0) + " keys required (2 keys cost[colon] " + GetInAppPurchaseLocalPrice(2) + ")")
		elseif (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) < 10)
			UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:" + str(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1], 0) + " keys required (5 keys cost[colon] " + GetInAppPurchaseLocalPrice(3) + ")")
		elseif (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) < 25)
			UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:" + str(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1], 0) + " keys required (10 keys cost[colon] " + GetInAppPurchaseLocalPrice(4) + ")")
		elseif (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) < 50)
			UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:" + str(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1], 0) + " keys required (25 keys cost[colon] " + GetInAppPurchaseLocalPrice(5) + ")")
		elseif (round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1]) = 50)
			UpdateText(lockOptions[LockOptionNoOfKeysRequired].txtSubLabel2, "string:" + str(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1], 0) + " keys required (50 keys cost[colon] " + GetInAppPurchaseLocalPrice(6) + ")")
		endif
	endif		
	noOfKeysRequired = round(lockOptions[LockOptionNoOfKeysRequired].rangeValue#[1])
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionNoOfKeysRequired, "position:-1000,-1000")
	if (loadingSharedLock = 0) then noOfKeysRequired = 1
endif

// LIMIT THE NUMBER OF USERS
if (shareable = 1 and sandboxMode = 0)
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionLimitNumberOfUsers].buttonSelected = 0)
		lockOptions[LockOptionLimitNumberOfUsers].buttonSelected = 2
	endif
	if (lockOptions[LockOptionLimitNumberOfUsers].buttonSelected = 1)
		limitUsers = 1
	elseif (lockOptions[LockOptionLimitNumberOfUsers].buttonSelected = 2)
		limitUsers = 2
		maximumUsers = 0
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLimitNumberOfUsers, "label:Limit the number of users?;subLabel:You can set the maximum number of users you're willing to manage at one time. Once the lock has reached the maximum number of users, all new users trying to load it will see a message asking them to try again soon.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Yes,No;selected:" + str(lockOptions[LockOptionLimitNumberOfUsers].buttonSelected))
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLimitNumberOfUsers, "position:-1000,-1000")
	if (loadingSharedLock = 0)
		limitUsers = 0
		maximumUsers = 0
	endif
endif

// MAXIMUM NUMBER OF USERS
if (shareable = 1 and limitUsers = 1)
	lockOptionY# = contentHeight# + 2
	if (maximumUsers = 0) then maximumUsers = 40
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionMaximumNumberOfUsers, "label:Maximum number of users?;subLabel:Fake locks aren't included in this count.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";range:1,100,1;rangeValues:" + str(maximumUsers))
	UpdateNewLockOptionRange(LockOptionMaximumNumberOfUsers)
	maximumUsers = round(lockOptions[LockOptionMaximumNumberOfUsers].rangeValue#[1])
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionMaximumNumberOfUsers, "position:-1000,-1000")
	if (loadingSharedLock = 0) then maximumUsers = 0
endif

// BLOCK USERS ALREADY LOCKED?
if (shareable = 1)
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionBlockUsersAlreadyLocked].buttonSelected = 0)
		lockOptions[LockOptionBlockUsersAlreadyLocked].buttonSelected = 2
	endif
	if (lockOptions[LockOptionBlockUsersAlreadyLocked].buttonSelected = 1)
		blockUSersAlreadyLocked = 1
	elseif (lockOptions[LockOptionBlockUsersAlreadyLocked].buttonSelected = 2)
		blockUSersAlreadyLocked = 0
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionBlockUsersAlreadyLocked, "label:Block users already locked?;subLabel:If 'Yes' then the user won't be able to load your lock until their other locks have finished.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Yes,No;selected:" + str(lockOptions[LockOptionBlockUsersAlreadyLocked].buttonSelected))
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionBlockUsersAlreadyLocked, "position:-1000,-1000")
	if (loadingSharedLock = 0) then blockUSersAlreadyLocked = 0
endif

// FORCE TRUST
if (shareable = 1 and sandboxMode = 0)
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionUsersHaveToTrustYou].buttonSelected = 0)
		lockOptions[LockOptionUsersHaveToTrustYou].buttonSelected = 2
	endif
	if (lockOptions[LockOptionUsersHaveToTrustYou].buttonSelected = 1)
		forceTrust = 1
	elseif (lockOptions[LockOptionUsersHaveToTrustYou].buttonSelected = 2)
		forceTrust = 0
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionUsersHaveToTrustYou, "label:Only accept users that trust you?;subLabel:Saying yes will remove the option that asks the user if they trust you as a keyholder. By loading the lock they automatically agree to trusting you. With 'trust', all keyholder limitations are removed.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Yes,No (Recommended);selected:" + str(lockOptions[LockOptionUsersHaveToTrustYou].buttonSelected))
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionUsersHaveToTrustYou, "position:-1000,-1000")
	if (loadingSharedLock = 0) then forceTrust = 0
endif

// LOCK ESTIMATIONS
if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
	if (lockOptionsChanged = 1) then simulationCount = 0
	if (GetSpriteInScreen(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarChartBackground)) then RunSimulation()
	if (simulationCount <= simulationsToTry)
		PinSpriteToCentreOfSprite(sprRunningSimulation[1], lockOptions[LockOptionLockEstimationsTime].sprEstimateBarChartBackground, 0, 0)
		UpdateText(txtRunningSimulation[1], "string:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry)) 
		PinTextToCentreOfSprite(txtRunningSimulation[1], sprRunningSimulation[1], 0, 0)
		PinSpriteToCentreOfSprite(sprRunningSimulation[2], lockOptions[LockOptionLockEstimationsChances].sprEstimateBarChartBackground, 0, 0)
		UpdateText(txtRunningSimulation[2], "string:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry)) 
		PinTextToCentreOfSprite(txtRunningSimulation[2], sprRunningSimulation[2], 0, 0)
		PinSpriteToCentreOfSprite(sprRunningSimulation[3], lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarChartBackground, 0, 0)
		UpdateText(txtRunningSimulation[3], "string:Running Lock Simulation " + str(simulationCount) + " of " + str(simulationsToTry)) 
		PinTextToCentreOfSprite(txtRunningSimulation[3], sprRunningSimulation[3], 0, 0)
		if (simulationMinutesLocked < simulationBestCaseMinutesLocked) then simulationBestCaseMinutesLocked = simulationMinutesLocked
		if (simulationNoOfTurns < simulationBestCaseNoOfTurns) then simulationBestCaseNoOfTurns = simulationNoOfTurns
		if (simulationNoOfCardsDrawn < simulationBestCaseNoOfCardsDrawn) then simulationBestCaseNoOfCardsDrawn = simulationNoOfCardsDrawn
		if (simulationMinutesLocked > simulationWorstCaseMinutesLocked) then simulationWorstCaseMinutesLocked = simulationMinutesLocked
		if (simulationNoOfTurns > simulationWorstCaseNoOfTurns) then simulationWorstCaseNoOfTurns = simulationNoOfTurns
		if (simulationNoOfCardsDrawn > simulationWorstCaseNoOfCardsDrawn) then simulationWorstCaseNoOfCardsDrawn = simulationNoOfCardsDrawn
	endif
	if (simulationCount = simulationsToTry)
		UpdateSprite(sprRunningSimulation[1], "position:-1000,-1000")
		UpdateText(txtRunningSimulation[1], "position:-1000,-1000")
		UpdateSprite(sprRunningSimulation[2], "position:-1000,-1000")
		UpdateText(txtRunningSimulation[2], "position:-1000,-1000") 
		UpdateSprite(sprRunningSimulation[3], "position:-1000,-1000")
		UpdateText(txtRunningSimulation[3], "position:-1000,-1000")
	endif	
endif

// LOCK ESTIMATIONS (TIME)
if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
	lockOptionY# = contentHeight# + 2
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsTime, "label:Lock estimations;subLabel:These estimates are based on 100 test runs of a lock with the above settings. They do not take into account time away from the app, i.e. sleeping. They also do not take into account keyholder updates.;subLabel2:Number of days;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";estimationBar:true")
	UpdateText(lockOptions[LockOptionLockEstimationsTime].txtSubLabel2, "bold:true")
	
	if (regularity# = 24 or ((simulationAverageMinutesLocked / simulationsToTry) / 60) >= 168)
		UpdateText(lockOptions[LockOptionLockEstimationsTime].txtSubLabel2, "string:Number of days")
		bestCase = simulationBestCaseMinutesLocked / 60 / 24
		averageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60 / 24
		worstCase = simulationWorstCaseMinutesLocked / 60 / 24
	else
		UpdateText(lockOptions[LockOptionLockEstimationsTime].txtSubLabel2, "string:Number of hours")
		bestCase = simulationBestCaseMinutesLocked / 60
		averageCase = (simulationAverageMinutesLocked / simulationsToTry) / 60
		worstCase = simulationWorstCaseMinutesLocked / 60
	endif
	
	min = RoundDownWithReducedPrecision(bestCase)
	max = RoundUpWithReducedPrecision(worstCase)
	
	bestCaseWidth# = (70.0 / (max - min)) * (bestCase - min)
	averageCaseWidth# = (70.0 / (max - min)) * (averageCase - min)
	worstCaseWidth# = (70.0 / (max - min)) * (worstCase - min)
		
	UpdateSprite(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarBestCase, "size:" + str(bestCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarAverageCase, "size:" + str(averageCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarWorstCase, "size:" + str(worstCaseWidth#) + ",2")		
	
	UpdateText(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarBestCaseLabel, "string:" + str(bestCase))
	UpdateText(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarAverageCaseLabel, "string:" + str(averageCase))
	UpdateText(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarWorstCaseLabel, "string:" + str(worstCase))
	
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarBestCaseLabel, lockOptions[LockOptionLockEstimationsTime].sprEstimateBarBestCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarBestCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarAverageCaseLabel, lockOptions[LockOptionLockEstimationsTime].sprEstimateBarAverageCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarAverageCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsTime].txtEstimateBarWorstCaseLabel, lockOptions[LockOptionLockEstimationsTime].sprEstimateBarWorstCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsTime].sprEstimateBarWorstCase) + 2, 0)
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsTime, "position:-1000,-1000")
endif

// LOCK ESTIMATIONS (CHANCES)
if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
	lockOptionY# = contentHeight# + 2
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsChances, "label:;subLabel:;subLabel2:Number of chances;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";estimationBar:true")
	UpdateText(lockOptions[LockOptionLockEstimationsChances].txtSubLabel2, "bold:true")
	
	min = RoundDownWithReducedPrecision(simulationBestCaseNoOfTurns)
	max = RoundUpWithReducedPrecision(simulationWorstCaseNoOfTurns)
	
	bestCaseWidth# = (70.0 / (max - min)) * (simulationBestCaseNoOfTurns - min)
	averageCaseWidth# = (70.0 / (max - min)) * ((simulationAverageNoOfTurns / simulationsToTry) - min)
	worstCaseWidth# = (70.0 / (max - min)) * (simulationWorstCaseNoOfTurns - min)
	
	bestCase = simulationBestCaseNoOfTurns
	averageCase = simulationAverageNoOfTurns / simulationsToTry
	worstCase = simulationWorstCaseNoOfTurns
	
	UpdateSprite(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarBestCase, "size:" + str(bestCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarAverageCase, "size:" + str(averageCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarWorstCase, "size:" + str(worstCaseWidth#) + ",2")		
	
	UpdateText(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarBestCaseLabel, "string:" + str(bestCase))
	UpdateText(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarAverageCaseLabel, "string:" + str(averageCase))
	UpdateText(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarWorstCaseLabel, "string:" + str(worstCase))
	
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarBestCaseLabel, lockOptions[LockOptionLockEstimationsChances].sprEstimateBarBestCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarBestCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarAverageCaseLabel, lockOptions[LockOptionLockEstimationsChances].sprEstimateBarAverageCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarAverageCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsChances].txtEstimateBarWorstCaseLabel, lockOptions[LockOptionLockEstimationsChances].sprEstimateBarWorstCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsChances].sprEstimateBarWorstCase) + 2, 0)
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsChances, "position:-1000,-1000")
endif

// LOCK ESTIMATIONS (CARDS DRAWN)
if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
	lockOptionY# = contentHeight# + 2
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsCardsDrawn, "label:;subLabel:;subLabel2:Number of cards drawn;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";estimationBar:true")
	UpdateText(lockOptions[LockOptionLockEstimationsCardsDrawn].txtSubLabel2, "bold:true")
	
	min = RoundDownWithReducedPrecision(simulationBestCaseNoOfCardsDrawn)
	max = RoundUpWithReducedPrecision(simulationWorstCaseNoOfCardsDrawn)
	
	bestCaseWidth# = (70.0 / (max - min)) * (simulationBestCaseNoOfCardsDrawn - min)
	averageCaseWidth# = (70.0 / (max - min)) * ((simulationAverageNoOfCardsDrawn / simulationsToTry) - min)
	worstCaseWidth# = (70.0 / (max - min)) * (simulationWorstCaseNoOfCardsDrawn - min)
	
	bestCase = simulationBestCaseNoOfCardsDrawn
	averageCase = simulationAverageNoOfCardsDrawn / simulationsToTry
	worstCase = simulationWorstCaseNoOfCardsDrawn
	
	UpdateSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarBestCase, "size:" + str(bestCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarAverageCase, "size:" + str(averageCaseWidth#) + ",2")
	UpdateSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarWorstCase, "size:" + str(worstCaseWidth#) + ",2")		
	
	UpdateText(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarBestCaseLabel, "string:" + str(bestCase))
	UpdateText(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarAverageCaseLabel, "string:" + str(averageCase))
	UpdateText(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarWorstCaseLabel, "string:" + str(worstCase))
	
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarBestCaseLabel, lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarBestCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarBestCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarAverageCaseLabel, lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarAverageCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarAverageCase) + 2, 0)
	PinTextToCentreLeftOfSprite(lockOptions[LockOptionLockEstimationsCardsDrawn].txtEstimateBarWorstCaseLabel, lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarWorstCase, GetSpriteWidth(lockOptions[LockOptionLockEstimationsCardsDrawn].sprEstimateBarWorstCase) + 2, 0)
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockEstimationsCardsDrawn, "position:-1000,-1000")
endif

// LOCK ESTIMATIONS (RERUN SIMULATION)
if (fixed = 0 and (loadingSharedLock = 0 or (loadingSharedLock = 1 and sharedID$ <> "" and cardInfoHidden = 0)))
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionLockRerunSimulation].buttonSelected = 0)
		lockOptions[LockOptionLockRerunSimulation].buttonSelected = 1
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionLockRerunSimulation, "label:;subLabel:;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Rerun Simulation")
endif

if (lockOptionsChanged = 1)
	lockOptionY# = contentHeight# + 7.5
	if (loadingSharedLock = 0 or sharedID$ <> "")
		UpdateSprite(screen[screenNo].sprNextButton, "positionByOffset:" + str(GetViewOffsetX() + 50) + "," + str(lockOptionY#))
	else
		UpdateSprite(screen[screenNo].sprNextButton, "position:-1000,-1000")
	endif	
	PinTextToCentreOfSprite(screen[screenNo].txtNextButton, screen[screenNo].sprNextButton, 0, 0)
	contentHeight# = contentHeight# + 30
endif
remend

	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
endif
