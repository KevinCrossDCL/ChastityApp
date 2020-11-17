
OryUIHideFloatingActionButton(fabAddAPIProject)
if (screenToView = constAPIDashboardScreen)
	screenNo = constAPIDashboardScreen

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
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar) + 2

	startScrollBarY# = elementY# - 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif

	// NO API PROJECTS
	if (redrawScreen = 1)
		if (apiProjects.length = -1)
			OryUIUpdateText(txtNoAPIProjects, "text:No API Projects;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(txtPressPlusToCreateAPIProject, "text:Press the + button below to create a new project;position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 6) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			OryUIUpdateText(txtNoAPIProjects, "position:-1000,-1000")
			OryUIUpdateText(txtPressPlusToCreateAPIProject, "position:-1000,-1000")
		endif
	endif

	// PROJECTS
	if (redrawScreen = 1)
		for i = 0 to 2
			DestroyItemsInAPIProjectCard(i)
			CreateItemsInAPIProjectCard(i)
		next
	endif
	filterCount = apiProjects.length
	if (filterCount >= 0)
		fullCardHeight# = GetSpriteHeight(apiProjectCard[0].sprBackground) + GetSpriteHeight(apiProjectCard[0].sprButtonBar) + 2.0
		for i = 0 to 2
			repositionItemsInCard = 0
			if (filterCount >= i)
				if (redrawScreen = 1)
					OryUIUpdateSprite(apiProjectCard[i].sprBackground, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
					elementY# = elementY# + GetSpriteHeight(apiProjectCard[i].sprBackground)
					OryUIUpdateSprite(apiProjectCard[i].sprButtonBar, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
					elementY# = elementY# + GetSpriteHeight(apiProjectCard[i].sprButtonBar) + 2
					apiProjectCard[i].iteration = i
				endif
				if (redrawScreen = 1) then repositionItemsInCard = 1
				
				sortedIteration = i

				UpdateItemsInAPIProjectCard(i, sortedIteration, repositionItemsInCard)
				
				OryUIInsertDialogListener(apiProjectCard[i].dialog)
					
				if (OryUIGetSwipingVertically() = 0)
					
					// EDIT PROJECT
					if (OryUIGetSpriteReleased() = apiProjectCard[i].sprEditButton or OryUIGetSpriteReleased() = apiProjectCard[i].sprEditIcon)
						showAPIProject = i
						screen[screenNo].lastViewY# = GetViewOffsetY()
						SetScreenToView(constAPIProjectSettingsScreen)
					endif
	
				endif
			endif
		next
		
		elementY# = GetSpriteY(screen[screenNo].sprPage) + (fullCardHeight# * (filterCount + 1)) + 2
	else
		elementY# = elementY# + 14
	endif
	
	// API DOCUMENTATION
	if (redrawScreen = 1)
		OryUIUpdateText(txtDocumentation, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	elementY# = elementY# + GetTextTotalHeight(txtDocumentation) + 2
	if (redrawScreen = 1)
		OryUIUpdateButton(btnDocumentation, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";enabledColorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";enabledTextColorID:" + str(colorMode[colorModeSelected].urlColor))
	endif
	elementY# = elementY# + OryUIGetButtonHeight(btnDocumentation) + 2
	if (OryUIGetButtonReleased(btnDocumentation))
		OpenBrowser(constAppAPIDocumentsURL$)
	endif
	
	// ADD BUTTON
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabAddAPIProject, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	if (oryUIScrimVisible = 0 and filterCount < 2) then OryUIShowFloatingActionButton(fabAddAPIProject)
	if (OryUIGetFloatingActionButtonReleased(fabAddAPIProject))
		showAPIProject = -1
		SetScreenToView(constAPIProjectSettingsScreen)
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
		OryUIHideFloatingActionButton(fabAddAPIProject)
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
