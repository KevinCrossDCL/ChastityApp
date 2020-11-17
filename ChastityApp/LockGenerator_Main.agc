
if (screenToView = constLockGeneratorScreen)
	// LOAD SCREEN IMAGES ONCE
	if (screenNo <> constLockGeneratorScreen)
		if (keepLockGeneratorSettings = 1)
			keepLockGeneratorSettings = 0
		elseif (keepLockGeneratorSettings = 0)
			OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfDays, "inputText:0")
			OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfHours, "inputText:1")
			OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfMinutes, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfDays, "inputText:0")
			OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfHours, "inputText:1")
			OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfMinutes, "inputText:0")
			OryUISetButtonGroupItemSelectedByIndex(grpLockGeneratorRegularity, 8)
		endif
	endif
	screenNo = screenToView

	elementY# = screenBoundsTop#
	
	// SCROLL BAR
	OryUIInsertScrollBarListener(scrollBar)
	
	// JUMP TO LAST VIEW OFFSET Y WHEN RETURNING TO THIS SCREEN
	if (screen[screenNo].lastViewY# > screenBoundsTop#)
		SetViewOffset(GetViewOffsetX(), screen[screenNo].lastViewY#)
		screen[screenNo].lastViewY# = screenBoundsTop#
	endif
	
	// SCROLL TO TOP
	// Would make sense to add to the bottom of this file but it causes the screen to flicker
	if (redrawScreen = 1) then OryUIUpdateScrollToTop(screen[screenNo].scrollToTop, "colorID:" + str(theme[themeSelected].color[3]))
	OryUIInsertScrollToTopListener(screen[screenNo].scrollToTop)	
	
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
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "info")
		SetScreenToView(constLockGeneratorInformationScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2
	
	startScrollBarY# = elementY# - 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif

	// MINIMUM LOCK DURATION?
	if (redrawScreen = 1)
		inputSpinnerTotalMinutesMin = 0
		if (botChosen = 0)
			OryUIUpdateTextCard(crdMinLockGeneratorDuration, "headerText:Minimum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdMinLockGeneratorDuration, "headerText:Approximate minimum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdMinLockGeneratorDuration)
	inputSpinnerDaysMin = 0
	inputSpinnerDaysMax = 365
	inputSpinnerHoursMin = 0
	inputSpinnerHoursMax = 23
	inputSpinnerMinutesMin = 0
	inputSpinnerMinutesMax = 59
	if (inputSpinnerTotalMinutesMin + 1440 > inputSpinnerTotalMinutesMax)
		inputSpinnerDaysMax = OryUIGetInputSpinnerInteger(spinMinLockGeneratorNumberOfDays)
	endif
	if (inputSpinnerTotalMinutesMin + 60 > inputSpinnerTotalMinutesMax)
		inputSpinnerHoursMax = OryUIGetInputSpinnerInteger(spinMinLockGeneratorNumberOfHours)
	endif
	if (inputSpinnerTotalMinutesMin + 1 > inputSpinnerTotalMinutesMax)
		inputSpinnerMinutesMax = OryUIGetInputSpinnerInteger(spinMinLockGeneratorNumberOfMinutes)
	endif
	if (redrawScreen = 1)
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfDays, "position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfHours, "position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfMinutes, "position:" + str((screenNo * 100) + 66.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMinLockGeneratorDays, "position:" + str(OryUIGetInputSpinnerX(spinMinLockGeneratorNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMinLockGeneratorNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMinLockGeneratorHours, "position:" + str(OryUIGetInputSpinnerX(spinMinLockGeneratorNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMinLockGeneratorNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMinLockGeneratorMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMinLockGeneratorNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMinLockGeneratorNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMinLockGeneratorNumberOfDays) + 2
	OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax) + ";step:1")
	OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax) + ";step:1")
	OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax) + ";step:1")
	OryUIInsertInputSpinnerListener(spinMinLockGeneratorNumberOfDays)
	OryUIInsertInputSpinnerListener(spinMinLockGeneratorNumberOfHours)
	OryUIInsertInputSpinnerListener(spinMinLockGeneratorNumberOfMinutes)
	if (OryUIGetInputSpinnerHasFocus(spinMinLockGeneratorNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMinLockGeneratorNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMinLockGeneratorNumberOfMinutes))
		SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinLockGeneratorDuration) - GetSpriteY(screen[screenNo].sprPage))
	endif
	inputSpinnerTotalMinutesMin = (val(OryUIGetInputSpinnerString(spinMinLockGeneratorNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMinLockGeneratorNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMinLockGeneratorNumberOfMinutes))
	minMinutes = inputSpinnerTotalMinutesMin

	// MAXIMUM LOCK DURATION?
	if (redrawScreen = 1)
		inputSpinnerTotalMinutesMax = 0
		if (botChosen = 0)
			OryUIUpdateTextCard(crdMaxLockGeneratorDuration, "headerText:Maximum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateTextCard(crdMaxLockGeneratorDuration, "headerText:Approximate maximum lock duration?;supportingText: ;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdMaxLockGeneratorDuration)
	inputSpinnerDaysMin = 0
	inputSpinnerDaysMax = 365
	inputSpinnerHoursMin = 0
	inputSpinnerHoursMax = 23
	inputSpinnerMinutesMin = 0
	inputSpinnerMinutesMax = 59
	if (inputSpinnerTotalMinutesMax - 1440 < inputSpinnerTotalMinutesMin)
		inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfDays)
	endif
	if (inputSpinnerTotalMinutesMax - 60 < inputSpinnerTotalMinutesMin)
		inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfHours)
	endif
	if (inputSpinnerTotalMinutesMax - 1 < inputSpinnerTotalMinutesMin)
		inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfMinutes)
	endif		
	if (redrawScreen = 1)
		OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfDays, "position:" + str((screenNo * 100) + 6.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfHours, "position:" + str((screenNo * 100) + 36.25) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfMinutes, "position:" + str((screenNo * 100) + 66.5) + "," + str(elementY#) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMaxLockGeneratorDays, "position:" + str(OryUIGetInputSpinnerX(spinMaxLockGeneratorNumberOfDays) + (OryUIGetInputSpinnerWidth(spinMaxLockGeneratorNumberOfDays) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMaxLockGeneratorHours, "position:" + str(OryUIGetInputSpinnerX(spinMaxLockGeneratorNumberOfHours) + (OryUIGetInputSpinnerWidth(spinMaxLockGeneratorNumberOfHours) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateText(txtMaxLockGeneratorMinutes, "position:" + str(OryUIGetInputSpinnerX(spinMaxLockGeneratorNumberOfMinutes) + (OryUIGetInputSpinnerWidth(spinMaxLockGeneratorNumberOfMinutes) / 2)) + "," + str(elementY# - 3.3) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + OryUIGetInputSpinnerHeight(spinMaxLockGeneratorNumberOfDays) + 2
	OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfDays, "min:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMax) + ";step:1")
	OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfHours, "min:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMax) + ";step:1")
	OryUIUpdateInputSpinner(spinMaxLockGeneratorNumberOfMinutes, "min:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMax) + ";step:1")
	OryUIInsertInputSpinnerListener(spinMaxLockGeneratorNumberOfDays)
	OryUIInsertInputSpinnerListener(spinMaxLockGeneratorNumberOfHours)
	OryUIInsertInputSpinnerListener(spinMaxLockGeneratorNumberOfMinutes)
	if (OryUIGetInputSpinnerHasFocus(spinMaxLockGeneratorNumberOfDays) or OryUIGetInputSpinnerHasFocus(spinMaxLockGeneratorNumberOfHours) or OryUIGetInputSpinnerHasFocus(spinMaxLockGeneratorNumberOfMinutes))
		SetViewOffset(GetViewOffsetX(), OryUIGetTextCardY(crdMinLockGeneratorDuration) - GetSpriteY(screen[screenNo].sprPage))
	endif
	inputSpinnerTotalMinutesMax = (val(OryUIGetInputSpinnerString(spinMaxLockGeneratorNumberOfDays)) * 1440) + (val(OryUIGetInputSpinnerString(spinMaxLockGeneratorNumberOfHours)) * 60) + val(OryUIGetInputSpinnerString(spinMaxLockGeneratorNumberOfMinutes))
	maxMinutes = inputSpinnerTotalMinutesMax
	
	// CORRECT MIN VALUES IF GREATER THAN MAX
	if (inputSpinnerTotalMinutesMin > inputSpinnerTotalMinutesMax)
		inputSpinnerDaysMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfDays)
		inputSpinnerHoursMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfHours)
		inputSpinnerMinutesMin = OryUIGetInputSpinnerInteger(spinMaxLockGeneratorNumberOfMinutes)
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfDays, "inputText:" + str(inputSpinnerDaysMin) + ";max:" + str(inputSpinnerDaysMin))
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfHours, "inputText:" + str(inputSpinnerHoursMin) + ";max:" + str(inputSpinnerHoursMin))
		OryUIUpdateInputSpinner(spinMinLockGeneratorNumberOfMinutes, "inputText:" + str(inputSpinnerMinutesMin) + ";max:" + str(inputSpinnerMinutesMin))
	endif

	// REGULARITY?
	if (redrawScreen = 1)
		OryUIUpdateTextCard(crdLockGeneratorRegularity, "headerText:Chance regularity?;position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
		if (OryUIGetButtonGroupItemSelectedIndex(grpLockGeneratorRegularity) = 0) then OryUISetButtonGroupItemSelectedByIndex(grpLockGeneratorRegularity, 1)
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "24H")
			regularity# = 24
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "12H")
			regularity# = 12
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "6H")
			regularity# = 6
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "3H")
			regularity# = 3
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "1H")
			regularity# = 1
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "30M")
			regularity# = 0.5
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "15M")
			regularity# = 0.25
		endif
		if (OryUIGetButtonGroupItemSelectedName(grpLockGeneratorRegularity) = "ANY")
			regularity# = 0
		endif
	endif
	elementY# = elementY# + OryUIGetTextCardHeight(crdLockGeneratorRegularity)
	if (redrawScreen = 1)
		OryUIUpdateButtonGroup(grpLockGeneratorRegularity, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
	endif
	OryUIInsertButtonGroupListener(grpLockGeneratorRegularity)
	if (OryUIGetButtonGroupItemReleasedIndex(grpLockGeneratorRegularity) > 0)
		screen[screenNo].lastViewY# = GetViewOffsetY()
		SetScreenToView(constLockGeneratorScreen)
	endif
	elementY# = elementY# + OryUIGetButtonGroupHeight(grpLockGeneratorRegularity) + 2

	// NEXT BUTTON
	if (redrawScreen = 1)
		OryUIUpdateButton(screen[screenNo].btnNext, "position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(theme[themeSelected].color[3]) + ";textColor:255,255,255,255")
	endif
	elementY# = elementY# + OryUIGetButtonHeight(screen[screenNo].btnNext) + 4
	if (OryUIGetButtonReleased(screen[screenNo].btnNext))
		if (minMinutes = maxMinutes)
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Range Required;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Please set the minimum and maximum durations so that they are both different from each other.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 1)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			GetGeneratedLocks(minMinutes, maxMinutes, regularity#, 1)
			lastScreenViewed = constLockGeneratorScreen
			SetScreenToView(constLockGeneratorResultsScreen)
		endif
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
