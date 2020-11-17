
if (screenToView = constLoadLockOptionsScreen)
	screenNo = constLoadLockOptionsScreen
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
		OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedID(screen[screenNo].tabs) = 1)
		SetScreenToView(constNewLockOptionsScreen, 0)
	endif
	elementY# = OryUIGetTopBarHeight(screen[screenNo].topBar) + OryUIGetTabsHeight(screen[screenNo].tabs) + 2

	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = OryUIGetTopBarHeight(screen[screenNo].topBar) + OryUIGetTabsHeight(screen[screenNo].tabs) + 2
	
	// SCROLL LIMITS
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 20
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, screenNo * 100, 0, maxScrollY#)
endif
