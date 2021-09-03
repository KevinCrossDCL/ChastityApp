
if (screenToView = constCardsScreen)
	// RESET PAGINATION ELEMENT
	if (screenNo <> constCardsScreen)
		cardIndexToSlideOutAfterMovedTo as integer : cardIndexToSlideOutAfterMovedTo = 0
		redsAddedThisPick as integer : redsAddedThisPick = 0
		OryUISetPaginationSelectedPage(cardPages, 1)
		if (imgFeltBackground = 0) then imgFeltBackground = LoadImage("FeltBackground.jpg")
		if (locks[lockSelected].lockFrozenByCard = 1 or locks[lockSelected].lockFrozenByKeyholder = 1) // or locks[lockSelected].lockFrozenByLockee = 1)
			SetScreenToView(constMyLocksScreen)
		endif
		showEndOfLockDialog as integer : showEndOfLockDialog = 0
	endif
	
	screenNo = constCardsScreen
	SetLastScreenViewed(screenNo)
	
	elementY# = screenBoundsTop#

	if (redrawScreen = 1) then OryUIHideScrollBar(scrollBar)

	if (redrawScreen = 1) then screen[screenNo].startScreenDrawTime# = timer()
	
	if (redrawScreen = 1 and OryUIGetPaginationSelectedPage(cardPages) > 0)
		noOfCards = GetNoOfCards(lockSelected)
		noOfCardScreens# = ceil(noOfCards / (noOfCardColsPerScreen# * maxNoOfCardRows#))
		if (OryUIGetPaginationSelectedPage(cardPages) > noOfCardScreens#)
			SetViewOffset((constCardsScreen * 100) + ((noOfCardScreens# - 1) * 100), 0)
		else
			SetViewOffset((constCardsScreen * 100) + ((OryUIGetPaginationSelectedPage(cardPages) - 1) * 100), 0)
		endif
	endif
	if (GetTweenCustomPlaying(tweenScrollCardsScreen))
		if (GetTweenCustomFloat1(tweenScrollCardsScreen) >= (constCardsScreen * 100.0))
			SetViewOffset(GetTweenCustomFloat1(tweenScrollCardsScreen), 0)
		endif
	else
		if (GetTweenCustomExists(tweenScrollCardsScreen))
			SetViewOffset(GetTweenCustomFloat1(tweenScrollCardsScreen), 0)
			DeleteTween(tweenScrollCardsScreen)
		endif
		OryUISetPaginationSelectedPage(cardPages, floor((GetViewOffsetX() - (constCardsScreen * 100)) / 100) + 1)
	endif
	
	// FELT BACKGROUND
	if (redrawScreen = 1)
		if (colorModeSelected = 1)
			OryUIUpdateSprite(sprFeltBackground, "position:" + str(screenNo * 100) + ",0;colorID:" + str(theme[themeSelected].color[3]) + ";image:" + str(imgFeltBackground))
		else
			OryUIUpdateSprite(sprFeltBackground, "position:" + str(screenNo * 100) + ",0;colorID:" + str(theme[10].color[3]) + ";image:" + str(imgFeltBackground))
		endif
	endif
	OryUIUpdateSprite(sprFeltBackground, "x:" + str(GetViewOffsetX()))

	// TOP BAR
	if (redrawScreen = 1)
		if (locks[lockSelected].keyholderUsername$ = "")
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		else
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:Locked " + ReformatDateString(locks[lockSelected].dateLocked$, "DD/MM/YYYY", dateFormat$) + chr(10) + "By " + locks[lockSelected].keyholderUsername$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		endif	
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (GetRawKeyPressed(27) and cardSelected > 0)
		SlideInCard(cardSelected)
		cardSelected = 0
	elseif (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and oryUIScrimVisible = 0))
		ClearLargeCard()
		OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
		OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
		cardChosen = 0
		cardSelected = 0
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "info")
		ClearLargeCard()
		OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
		OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
		cardChosen = 0
		cardSelected = 0
		SetScreenToView(constLockInformationScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)

	// ADD CARDS TRAY
	enableAdd1RedCard as integer : enableAdd1RedCard = 1
	enableAdd2RedCards as integer : enableAdd2RedCards = 1
	enableAddRandomRedCards as integer : enableAddRandomRedCards = 1
	enableAddYellowRandomCard as integer : enableAddYellowRandomCard = 1
	enableAddStickyCard as integer : enableAddStickyCard = 1
	enableAddFreezeCard as integer : enableAddFreezeCard = 1
	enableAddDoubleUpCard as integer : enableAddDoubleUpCard = 1
	enableAddResetCard as integer : enableAddResetCard = 1
	if (locks[lockSelected].redCards >= cappedRedCards or noOfCards >= cappedTotalCards)
		enableAdd1RedCard = 0
		enableAdd2RedCards = 0
		enableAddRandomRedCards = 0
	endif
	if (locks[lockSelected].redCards >= cappedRedCards - 1 or noOfCards >= cappedTotalCards - 1)
		enableAdd2RedCards = 0
		enableAddRandomRedCards = 0
	endif
	if (locks[lockSelected].redCards >= cappedRedCards - 2 or noOfCards >= cappedTotalCards - 2)
		enableAddRandomRedCards = 0
	endif	
	if (locks[lockSelected].yellowCards >= cappedYellowCardsTotal or noOfCards >= cappedTotalCards or locks[lockSelected].keyholderUsername$ <> "")
		enableAddYellowRandomCard = 0
	endif
	if (locks[lockSelected].stickyCards >= cappedStickyCards or noOfCards >= cappedTotalCards)
		enableAddStickyCard = 0
	endif
	if (locks[lockSelected].freezeCards >= cappedFreezeCards or noOfCards >= cappedTotalCards)
		enableAddFreezeCard = 0
	endif
	if (locks[lockSelected].doubleUpCards >= cappedDoubleUpCards or noOfCards >= cappedTotalCards)
		enableAddDoubleUpCard = 0
	endif
	if (locks[lockSelected].resetCards >= cappedResetCards or noOfCards >= cappedTotalCards or locks[lockSelected].greenCards > locks[lockSelected].initialGreenCards or locks[lockSelected].redCards > locks[lockSelected].initialRedCards or locks[lockSelected].yellowCards > locks[lockSelected].initialYellowCards or locks[lockSelected].stickyCards > locks[lockSelected].initialStickyCards or locks[lockSelected].freezeCards > locks[lockSelected].initialFreezeCards or locks[lockSelected].doubleUpCards > locks[lockSelected].initialDoubleUpCards or locks[lockSelected].keyholderUsername$ <> "")
		enableAddResetCard = 0
	endif
	if (redrawScreen = 1)
		if (colorModeSelected = 1)
			OryUIUpdateSprite(sprAddCards, "colorID:" + str(theme[themeSelected].color[2]))
		else
			OryUIUpdateSprite(sprAddCards, "colorID:" + str(theme[10].color[2]))
		endif
	endif
	OryUIUpdateSprite(sprAddCards, "position:" + str(GetViewOffsetX()) + "," + str(elementY#))
	OryUIUpdateSprite(sprAddCardsTray, "position:" + str(GetViewOffsetX()) + "," + str(elementY#))
	OryUIUpdateButton(btnAdd1RedCard, "position:" + str(GetViewOffsetX() + 8) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateSprite(sprRedCard1Of1, "position:" + str(GetViewOffsetX() + 19.75) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))	
	OryUIUpdateButton(btnAdd2RedCards, "position:" + str(GetViewOffsetX() + 20) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))

	OryUIUpdateSprite(sprRedCard1Of3, "position:" + str(GetViewOffsetX() + 31.25) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	OryUIUpdateSprite(sprRedCard2Of3, "position:" + str(GetViewOffsetX() + 31.5) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	OryUIUpdateSprite(sprRedCard3Of3, "position:" + str(GetViewOffsetX() + 31.75) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	OryUIUpdateButton(btnAdd1To4RedRandom, "position:" + str(GetViewOffsetX() + 32) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateButton(btnAdd1StickyCard, "position:" + str(GetViewOffsetX() + 44) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateButton(btnAdd1YellowRandom, "position:" + str(GetViewOffsetX() + 56) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateButton(btnAdd1FreezeCard, "position:" + str(GetViewOffsetX() + 68) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateButton(btnAdd1DoubleUpCard, "position:" + str(GetViewOffsetX() + 80) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))
	
	OryUIUpdateButton(btnAdd1ResetCard, "position:" + str(GetViewOffsetX() + 92) + "," + str(elementY# + (GetSpriteHeight(sprAddCardsTray) / 2)))

	OryUIPinTextToCentreOfSprite(txtAddCards, sprAddCards, 0, 0)
	OryUIInsertDialogListener(screen[screenNo].dialog)
	if (cardSelected = 0 and largeCardVisible = 0)
		// ADD 1 RED CARD
		if (OryUIGetButtonReleased(btnAdd1RedCard) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAdd1RedCard)
				if (add1RedCardAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 1 minute and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 15 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 30 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 1 hour and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 3 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 6 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 12 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Red Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 red card to the deck? This may increase the duration of the lock by 1 day and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1Red;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1RedCard"
				else
					AddRedCards(lockSelected, 1, 0)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has too many red cards. You cannot add more red cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1Red"))
			AddRedCards(lockSelected, 1, 0)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1RedCard")
			add1RedCardAlertHidden = 1
			SaveLocalVariable("add1RedCardAlertHidden", str(add1RedCardAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 2 RED CARDS
		if (OryUIGetButtonReleased(btnAdd2RedCards) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAdd2RedCards)
				if (add2RedCardsAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 2 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 30 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 1 hour and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 2 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 6 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 12 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 1 day and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 2 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 2 red cards to the deck? This may increase the duration of the lock by 2 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd2Reds;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add2RedCards"
				else
					AddRedCards(lockSelected, 2, 0)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Cards;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has too many red cards. You cannot add more red cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd2Reds"))
			AddRedCards(lockSelected, 2, 0)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add2RedCards")
			add2RedCardsAlertHidden = 1
			SaveLocalVariable("add2RedCardsAlertHidden", str(add2RedCardsAlertHidden))
			dialogShown$ = ""
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd3Reds"))
			AddRedCards(lockSelected, 3, 0)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add3RedCards")
			add3RedCardsAlertHidden = 1
			SaveLocalVariable("add3RedCardsAlertHidden", str(add3RedCardsAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 TO 4 RED CARDS
		if (OryUIGetButtonReleased(btnAdd1To4RedRandom) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddRandomRedCards)
				if (add1To4RedCardsAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 4 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 1 hour and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 2 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 4 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 12 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 1 day and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 2 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1-4 Red Cards?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1-4 red cards to the deck? This may increase the duration of the lock by up to 4 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1To4Reds;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1To4RedCards"
				else
					AddRedCards(lockSelected, random(1, 4), 0)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Cards;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has too many red cards. You cannot add more red cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1To4Reds"))
			AddRedCards(lockSelected, random(1, 4), 0)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1To4RedCards")
			add1To4RedCardsAlertHidden = 1
			SaveLocalVariable("add1To4RedCardsAlertHidden", str(add1To4RedCardsAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 RANDOM YELLOW CARDS
		if (OryUIGetButtonReleased(btnAdd1YellowRandom) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddYellowRandomCard)
				if (add1RandomYellowCardAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 4 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 1 hour and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 2 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 4 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 12 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 1 day and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 2 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Random Yellow Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 random yellow card to the deck? This may increase the duration of the lock by up to 4 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1Yellow;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1YellowCard"
				else
					AddRandomYellowCards(lockSelected, 1)
				endif
			else
				if (locks[lockSelected].keyholderUsername$ <> "")
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add yellow cards to a lock controlled by a keyholder.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
				else
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has too many yellow cards. You cannot add more yellow cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
				endif
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1Yellow"))
			AddRandomYellowCards(lockSelected, 1)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1YellowCard")
			add1RandomYellowCardAlertHidden = 1
			SaveLocalVariable("add1RandomYellowCardAlertHidden", str(add1RandomYellowCardAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 STICKY CARD
		if (OryUIGetButtonReleased(btnAdd1StickyCard) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddStickyCard)
				if (add1StickyCardAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 1 minute and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 15 minutes and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 30 minutes and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 1 hour and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 3 hours and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 6 hours and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 12 hours and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Sticky Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 sticky card to the deck? This may increase the duration of the lock by 1 day and can't be undone. A sticky card also goes back into play after being revealed for a chance to be picked again and does not get discarded.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1Sticky;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1StickyCard"
				else
					AddStickyCards(lockSelected, 1)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has either too many cards or too many sticky cards. You cannot add more sticky cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1Sticky"))
			AddStickyCards(lockSelected, 1)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1StickyCard")
			add1StickyCardAlertHidden = 1
			SaveLocalVariable("add1StickyCardAlertHidden", str(add1StickyCardAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 FREEZE CARD
		if (OryUIGetButtonReleased(btnAdd1FreezeCard) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddFreezeCard)
				if (add1FreezeCardAlertHidden = 0)
					if (locks[lockSelected].regularity# = 0.016667) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 4 minutes and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.25) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 1 hour and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 0.5) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 2 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 1) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 4 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 3) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 12 hours and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 6) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 1 day and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 12) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 2 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					if (locks[lockSelected].regularity# = 24) then OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Freeze Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 freeze card to the deck? This may increase the duration of the lock by up to 4 days and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1Freeze;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1FreezeCard"
				else
					AddFreezeCards(lockSelected, 1)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has either too many cards or too many freeze cards. You cannot add more freeze cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1Freeze"))
			AddFreezeCards(lockSelected, 1)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1FreezeCard")
			add1FreezeCardAlertHidden = 1
			SaveLocalVariable("add1FreezeCardAlertHidden", str(add1FreezeCardAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 DOUBLE UP CARD
		if (OryUIGetButtonReleased(btnAdd1DoubleUpCard) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddDoubleUpCard)
				if (add1DoubleUpCardAlertHidden = 0)
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Double Up Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 double up card to the deck? This will double the amount of reds and yellows in play if drawn and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1DoubleUp;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1DoubleUpCard"
				else
					AddDoubleUpCards(lockSelected, 1)
				endif
			else
				OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has either too many cards or too many double up cards. You cannot add more double up cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
				OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(screen[screenNo].dialog)
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1DoubleUp"))
			AddDoubleUpCards(lockSelected, 1)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1DoubleUpCard")
			add1DoubleUpCardAlertHidden = 1
			SaveLocalVariable("add1DoubleUpCardAlertHidden", str(add1DoubleUpCardAlertHidden))
			dialogShown$ = ""
		endif
		// ADD 1 RESET CARD
		if (OryUIGetButtonReleased(btnAdd1ResetCard) and OryUIGetSpriteReleased() <> sprAddCards)
			if (enableAddResetCard)
				if (add1ResetCardAlertHidden = 0)
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Add 1 Reset Card?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to add 1 reset card to the deck? This will reset and start the lock again if drawn and can't be undone.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:true;checkboxColorID:" + str(colorMode[colorModeSelected].textColor) + ";checkboxText:Do not show again;checkBoxTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesAdd1Reset;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
					dialogShown$ = "Add1ResetCard"
				else
					AddResetCards(lockSelected, 1)
				endif
			else
				if (locks[lockSelected].keyholderUsername$ <> "")
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:You cannot add reset cards to a lock controlled by a keyholder.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
				else
					OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Cannot Add Card;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:This lock has either too many cards or the lock has more cards than it started with. You cannot add more reset cards at the moment.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(screen[screenNo].dialog, 1)
					OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(screen[screenNo].dialog)
				endif	
			endif
		endif
		if (OryUIGetDialogButtonReleasedByName(screen[screenNo].dialog, "YesAdd1Reset"))
			AddResetCards(lockSelected, 1)
		endif
		if (OryUIGetDialogChecked(screen[screenNo].dialog) and dialogShown$ = "Add1ResetCard")
			add1ResetCardAlertHidden = 1
			SaveLocalVariable("add1ResetCardAlertHidden", str(add1ResetCardAlertHidden))
			dialogShown$ = ""
		endif
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#))
	endif
	elementY# = elementY# + 2
	
	// DISCARD PILES
	OryUIUpdateSprite(sprDiscardPileCover, "position:" + str(GetViewOffsetX() + 10) + ",82")
	if (largeCardVisible = 0)
	for i = 0 to 20
		if (discardPile[i].value$ <> "")
			if (discardPile[i].value$ = "DoubleUp") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardDoubleUp100) + ";alpha:255")
			if (discardPile[i].value$ = "Freeze") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardFreeze100) + ";alpha:255")
			if (discardPile[i].value$ = "GoAgain") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardGoAgain) + ";alpha:255")
			if (discardPile[i].value$ = "Green") then OryUIUpdateSprite(discardPile[i].sprite, "position:-1000,-1000;alpha:0")
			if (discardPile[i].value$ = "Red") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardRed100) + ";alpha:255")
			if (discardPile[i].value$ = "Reset") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardReset100) + ";alpha:255")
			if (discardPile[i].value$ = "Sticky") then OryUIUpdateSprite(discardPile[i].sprite, "position:-1000,-1000;alpha:0")
			if (discardPile[i].value$ = "YellowAdd1") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd1) + ";alpha:255")
			if (discardPile[i].value$ = "YellowAdd2") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd2) + ";alpha:255")
			if (discardPile[i].value$ = "YellowAdd3") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd3) + ";alpha:255")
			if (discardPile[i].value$ = "YellowMinus2") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowMinus2) + ";alpha:255")
			if (discardPile[i].value$ = "YellowMinus1") then OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowMinus1) + ";alpha:255")
		else
			OryUIUpdateSprite(discardPile[i].sprite, "position:" + str(GetViewOffsetX() + 50) + ",89;alpha:0")
		endif
	next
	for i = 0 to noOfGreenPileSprites
		if (greenPile[i].value$ = "Green")
			OryUIUpdateSprite(greenPile[i].sprite, "position:" + str(GetViewOffsetX() + 75) + ",89;image:" + str(imgCardGreen025) + ";alpha:255")
		else
			OryUIUpdateSprite(greenPile[i].sprite, "position:" + str(GetViewOffsetX() + 75) + ",89;image:" + str(imgCardGreen025) + ";alpha:0")
		endif
	next
	endif
	if (greenPile[1].value$ = "Green")
		if (locks[lockSelected].cardInfoHidden = 0)
			OryUIUpdateText(txtGreensFound, "text:" + str(locks[lockSelected].greensPickedSinceReset) + "/" + str(locks[lockSelected].greenCards + locks[lockSelected].greensPickedSinceReset) + ";position:" + str(GetViewOffsetX() + 75) + "," + str(89 - (GetTextTotalHeight(txtGreensFound) / 2)))
		else
			OryUIUpdateText(txtGreensFound, "text:" + str(locks[lockSelected].greensPickedSinceReset) + "/??;position:" + str(GetViewOffsetX() + 75) + "," + str(89 - (GetTextTotalHeight(txtGreensFound) / 2)))
		endif			
	else
		OryUIUpdateText(txtGreensFound, "position:-1000,-1000")
	endif
	
	// CARDS
	if (redrawScreen = 1)
		cardPageSelected = 1
		CreateDeck(lockSelected)
		ShuffleDeck(0)
		DealDeck()
	endif
	chancesPassed as integer : chancesPassed = 0
	if (locks[lockSelected].timestampLastFullReset > locks[lockSelected].timestampLocked)
		if (locks[lockSelected].regularity# = 0.016667) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 60)
		if (locks[lockSelected].regularity# = 0.25) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 900)
		if (locks[lockSelected].regularity# = 0.5) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 1800)
		if (locks[lockSelected].regularity# = 1) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 3600)	
		if (locks[lockSelected].regularity# = 3) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 10800)	
		if (locks[lockSelected].regularity# = 6) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 21600)	
		if (locks[lockSelected].regularity# = 12) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 43200)	
		if (locks[lockSelected].regularity# = 24) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLastFullReset) / 86400)
	else
		if (locks[lockSelected].regularity# = 0.016667) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 60)
		if (locks[lockSelected].regularity# = 0.25) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 900)
		if (locks[lockSelected].regularity# = 0.5) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 1800)
		if (locks[lockSelected].regularity# = 1) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 3600)	
		if (locks[lockSelected].regularity# = 3) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 10800)	
		if (locks[lockSelected].regularity# = 6) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 21600)	
		if (locks[lockSelected].regularity# = 12) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 43200)	
		if (locks[lockSelected].regularity# = 24) then chancesPassed = floor((timestampNow - locks[lockSelected].timestampLocked) / 86400)
	endif
	for i = 1 to noOfCardSprites + 4
		if (GetSpriteExists(cards[i].sprite))
			if (developerShowCards = 1)
				if (deck[shuffledDeck[cards[i].id]].value$ = "DoubleUp") then OryUIUpdateSprite(cards[i].sprite, "color:142,68,173,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "Freeze") then OryUIUpdateSprite(cards[i].sprite, "color:170,195,195,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "GoAgain") then OryUIUpdateSprite(cards[i].sprite, "color:145,145,145,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "Green") then OryUIUpdateSprite(cards[i].sprite, "color:22,160,133,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "Red") then OryUIUpdateSprite(cards[i].sprite, "color:192,57,42,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "Reset") then OryUIUpdateSprite(cards[i].sprite, "color:41,128,185,255")
				if (deck[shuffledDeck[cards[i].id]].value$ = "Sticky") then OryUIUpdateSprite(cards[i].sprite, "color:235,136,0,255")
				if (left(deck[shuffledDeck[cards[i].id]].value$, 6) = "Yellow") then OryUIUpdateSprite(cards[i].sprite, "color:241,196,15,255")
			endif
			if (GetSpriteWidth(cards[i].sprite) > cardWidth# / GetDisplayAspect() or GetSpriteHeight(cards[i].sprite) > cardHeight#)
				SetSpriteDepth(cards[i].sprite, 2)
			else
				SetSpriteDepth(cards[i].sprite, cards[i].originalDepth)
			endif
			if (redrawScreen = 1)
				if (GetSpriteXByOffset(cards[i].sprite) <= GetViewOffsetX() - (GetSpriteWidth(cards[i].sprite) / 2.0))
					if (GetSpriteXByOffset(cards[i].sprite) + 101 < (screenNo + noOfCardScreens#) * 100)
						newCardID as integer : newCardID = cards[i].id + ((noOfCardRows * noOfCardCols) * cardPageSelected)
						if (newCardID >= 1 and newCardID <= noOfCards)
							cards[i].id = newCardID
							OryUIUpdateSprite(cards[i].sprite, "position:" + str(GetSpriteXByOffset(cards[i].sprite) + 25 + (cardPageSelected * 100)) + "," + str(GetSpriteYByOffset(cards[i].sprite)) + ";angle:" + str(deck[newCardID].angle#) + ";group:" + str(1000 + cards[i].id))
						endif
					endif
				endif
			elseif (redrawScreen = 0)
				if (GetSpriteXByOffset(cards[i].sprite) <= GetViewOffsetX() - (GetSpriteWidth(cards[i].sprite) / 2.0))
					if (GetSpriteXByOffset(cards[i].sprite) + 101 < (screenNo + noOfCardScreens#) * 100)
						newCardID = cards[i].id + (noOfCardRows * noOfCardCols)
						if (newCardID >= 1 and newCardID <= noOfCards)
							cards[i].id = newCardID
							OryUIUpdateSprite(cards[i].sprite, "position:" + str(GetSpriteXByOffset(cards[i].sprite) + 125) + "," + str(GetSpriteYByOffset(cards[i].sprite)) + ";angle:" + str(deck[newCardID].angle#) + ";group:" + str(1000 + cards[i].id))
						endif
					endif
				elseif (GetSpriteXByOffset(cards[i].sprite) >= GetViewOffsetX() + 100 + (GetSpriteWidth(cards[i].sprite) / 2.0))
					if (GetSpriteXByOffset(cards[i].sprite) - 126 > constCardsScreen * 100)
						newCardID = cards[i].id - (noOfCardRows * noOfCardCols)
						if (newCardID >= 1)
							cards[i].id = newCardID
							OryUIUpdateSprite(cards[i].sprite, "position:" + str(GetSpriteXByOffset(cards[i].sprite) - 125) + "," + str(GetSpriteYByOffset(cards[i].sprite)) + ";angle:" + str(deck[newCardID].angle#) + ";group:" + str(1000 + cards[i].id))
						endif
					endif
				endif
			endif
		endif
	next

	// PAGE BUTTONS
	if (redrawScreen = 1)
		OryUIUpdatePagination(cardPages, "selectedColor:" + str(GetColorRed(theme[themeSelected].color[3])) + "," + str(GetColorGreen(theme[themeSelected].color[3])) + "," + str(GetColorBlue(theme[themeSelected].color[3])) + ",128;depth:20")
	endif
	if (noOfCardScreens# > 1)
		OryUIUpdatePagination(cardPages, "position:" + str(GetViewOffsetX()) + ",75;noOfPages:" + str(noOfCardScreens#))
	else
		OryUIUpdatePagination(cardPages, "position:-1000,-1000")
	endif
	if (cardsScrimVisible = 0 and largeCardVisible = 0) then OryUIInsertPaginationListener(cardPages)
	if (OryUIGetPaginationChanged(cardPages))
		newViewX# = (constCardsScreen * 100) + ((OryUIGetPaginationSelectedPage(cardPages) - 1) * 100)
		timeToScroll# as float : timeToScroll# = (abs(newViewX# - GetViewOffsetX()) / 100) * 0.1
		if (timeToScroll# > 1) then timeToScroll# = 1
		tweenScrollCardsScreen = CreateTweenCustom(timeToScroll#)
		SetTweenCustomFloat1(tweenScrollCardsScreen, GetViewOffsetX(), newViewX#, TweenLinear())
		PlayTweenCustom(tweenScrollCardsScreen, 0)
	endif
	cardPageSelected = OryUIGetPaginationSelectedPage(cardPages)

	// NO OF CHANCES
	noOfChances = 0
	if (locks[lockSelected].regularity# = 0.016667)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60)
	elseif (locks[lockSelected].regularity# = 0.25)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 15)
	elseif (locks[lockSelected].regularity# = 0.5)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 30)
	elseif (locks[lockSelected].regularity# = 1)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60)
	elseif (locks[lockSelected].regularity# = 3)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 3)
	elseif (locks[lockSelected].regularity# = 6)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 6)
	elseif (locks[lockSelected].regularity# = 12)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 12)
	elseif (locks[lockSelected].regularity# = 24)
		noOfChances = floor((timestampNow - locks[lockSelected].timestampLastPicked) / 60 / 60 / 24)
	endif

	if (locks[lockSelected].cumulative = 0 and noOfChances > 1) then noOfChances = 1
	OryUIUpdateSprite(sprNoOfChancesBar, "position:" + str(GetViewOffsetX()) + "," + str(94 + abs(screenBoundsTop#)))
	if (noOfChances > 0)
		OryUIUpdateText(txtNoOfChances, "text:Chances[colon] " + str(noOfChances))
	else
		OryUIUpdateText(txtNoOfChances, "text:Please try again later")
	endif
	if (locks[lockSelected].readyToUnlock = 1) then OryUIUpdateText(txtNoOfChances, "text: ;")
	OryUIPinTextToCentreOfSprite(txtNoOfChances, sprNoOfChancesBar, 0, 0)

	// LARGE CARD
	if (GetTweenCustomPlaying(tweenScrollCardsScreen) = 0)
		if (cardIndexToSlideOutAfterMovedTo > 0)
			SlideOutCard(cardIndexToSlideOutAfterMovedTo, true)
			OryUIUpdateButton(btnCancelCard, "position:" + str(GetSpriteX(cards[cardIndexToSlideOutAfterMovedTo].sprite) + GetSpriteWidth(cards[cardIndexToSlideOutAfterMovedTo].sprite)) + "," + str(GetSpriteY(cards[cardIndexToSlideOutAfterMovedTo].sprite)))
			OryUIUpdateButton(btnViewCard, "position:" + str(GetSpriteX(cards[cardIndexToSlideOutAfterMovedTo].sprite) + (GetSpriteWidth(cards[cardIndexToSlideOutAfterMovedTo].sprite) / 2)) + "," + str(GetSpriteY(cards[cardIndexToSlideOutAfterMovedTo].sprite) + (GetSpriteHeight(cards[cardIndexToSlideOutAfterMovedTo].sprite) / 2)))
			OryUIPinTextToBottomCentreOfSprite(OryUIButtonCollection[btnViewCard].txtLabel, OryUIButtonCollection[btnViewCard].sprContainer, 0, 0)
			cardIndexToSlideOutAfterMovedTo = 0
		endif
	endif
	if (cardSelected > 0 and cardChosen = 0)
		if (OryUIGetButtonReleased(btnCancelCard))
			SlideInCard(cardSpritesIndex)
			cardSelected = 0
		endif
		if (OryUIGetButtonReleased(btnViewCard))
			OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
			OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
			// SWITCH THE GREEN OR RESET CARD WITH ANOTHER IF MINIMUM DURATION NOT REACHED
			if (chancesPassed < locks[lockSelected].minimumRedCards)
				if (deck[shuffledDeck[cardSelected]].value$ = "Green" or (deck[shuffledDeck[cardSelected]].value$ = "Reset" and locks[lockSelected].pickedCount = 0))
					selectedID as integer : selectedID = cardSelected
					selectedValue$ as string : selectedValue$ = deck[shuffledDeck[cardSelected]].value$
					for i = 1 to noOfCards
						if (deck[shuffledDeck[i]].value$ = "Green" or (deck[shuffledDeck[i]].value$ = "Reset" and locks[lockSelected].pickedCount = 0))
									
						else
							shuffledID as integer : shuffledID = i
							shuffledValue$ as string : shuffledValue$ = deck[shuffledDeck[i]].value$
							deck[shuffledDeck[cardSelected]].id = shuffledID
							deck[shuffledDeck[cardSelected]].value$ = shuffledValue$
							deck[shuffledDeck[i]].id = selectedID
							deck[shuffledDeck[i]].value$ = selectedValue$
							exit
						endif
					next
				endif
			endif
			cardChosen = cardSelected
			// SHOW LARGE CARDS OR MOVE TO DISCARD PILE
			if (deck[shuffledDeck[cardChosen]].value$ = "DoubleUp")
				if (locks[lockSelected].redCards > 0 or locks[lockSelected].yellowCards > 0)
					inc locks[lockSelected].pickedCount
					inc locks[lockSelected].pickedCountIncludingYellows
					inc locks[lockSelected].pickedCountSinceReset
					inc locks[lockSelected].doubleUpCardsPicked
					dec locks[lockSelected].doubleUpCards
					if (locks[lockSelected].redCards < cappedRedCards)
						locks[lockSelected].redCards = locks[lockSelected].redCards * 2
						if (locks[lockSelected].redCards > cappedRedCards) then locks[lockSelected].redCards = cappedRedCards
					endif
					if (locks[lockSelected].noOfAdd1Cards < cappedYellowCardsEachType)
						locks[lockSelected].noOfAdd1Cards = locks[lockSelected].noOfAdd1Cards * 2
						if (locks[lockSelected].noOfAdd1Cards > cappedYellowCardsEachType) then locks[lockSelected].noOfAdd1Cards = cappedYellowCardsEachType
					endif
					if (locks[lockSelected].noOfAdd2Cards < cappedYellowCardsEachType)
						locks[lockSelected].noOfAdd2Cards = locks[lockSelected].noOfAdd2Cards * 2
						if (locks[lockSelected].noOfAdd2Cards > cappedYellowCardsEachType) then locks[lockSelected].noOfAdd2Cards = cappedYellowCardsEachType
					endif
					if (locks[lockSelected].noOfAdd3Cards < cappedYellowCardsEachType)
						locks[lockSelected].noOfAdd3Cards = locks[lockSelected].noOfAdd3Cards * 2
						if (locks[lockSelected].noOfAdd3Cards > cappedYellowCardsEachType) then locks[lockSelected].noOfAdd3Cards = cappedYellowCardsEachType
					endif
					if (locks[lockSelected].noOfMinus1Cards < cappedYellowCardsEachType)
						locks[lockSelected].noOfMinus1Cards = locks[lockSelected].noOfMinus1Cards * 2
						if (locks[lockSelected].noOfMinus1Cards > cappedYellowCardsEachType) then locks[lockSelected].noOfMinus1Cards = cappedYellowCardsEachType
					endif
					if (locks[lockSelected].noOfMinus2Cards < cappedYellowCardsEachType)
						locks[lockSelected].noOfMinus2Cards = locks[lockSelected].noOfMinus2Cards * 2
						if (locks[lockSelected].noOfMinus2Cards > cappedYellowCardsEachType) then locks[lockSelected].noOfMinus2Cards = cappedYellowCardsEachType
					endif
					locks[lockSelected].yellowCards = locks[lockSelected].noOfAdd1Cards + locks[lockSelected].noOfAdd2Cards + locks[lockSelected].noOfAdd3Cards + locks[lockSelected].noOfMinus1Cards + locks[lockSelected].noOfMinus2Cards
					locks[lockSelected].goAgainCards = locks[lockSelected].goAgainCards * 2
					if (locks[lockSelected].goAgainCards > cappedGoAgainCards) then locks[lockSelected].goAgainCards = cappedGoAgainCards
					locks[lockSelected].timestampRealLastPicked = timestampNow
					noOfCards = GetNoOfCards(lockSelected)
					AddToDiscardPile("DoubleUp", 1)
					UpdateLocksData(lockSelected)
					UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:DoubleUpCard", 0)
				else
					inc locks[lockSelected].pickedCount
					inc locks[lockSelected].pickedCountIncludingYellows
					inc locks[lockSelected].pickedCountSinceReset
					inc locks[lockSelected].doubleUpCardsPicked
					dec locks[lockSelected].doubleUpCards
					locks[lockSelected].timestampRealLastPicked = timestampNow
					AddToDiscardPile("DoubleUp", 1)
					UpdateLocksData(lockSelected)
					UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:DoubleUpCard", 0)
				endif
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				ShowLargeCard("DoubleUp", "", "", "Tap to continue...")
				DeleteSprite(cards[cardSpritesIndex].sprite)
				if (locks[lockSelected].redCards = 0 and locks[lockSelected].yellowCards = 0)
					largeCardDepth = GetSpriteDepth(largeCard.sprite)
					cardsScrimVisible = 1
					OryUIUpdateSprite(sprCardsScrim, "depth:10")
					OryUIUpdateSprite(largeCard.sprite, "depth:9")
					OryUIUpdateText(largeCard.txtBottom, "depth:8")
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:No Red or Yellow Cards;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:There were no red or yellow cards to double up so this card has no affect.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 1)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
			elseif (deck[shuffledDeck[cardChosen]].value$ = "Freeze")
				inc locks[lockSelected].pickedCount
				inc locks[lockSelected].pickedCountIncludingYellows
				inc locks[lockSelected].pickedCountSinceReset
				dec locks[lockSelected].freezeCards
				locks[lockSelected].chancesAccumulatedBeforeFreeze = noOfChances
				if (locks[lockSelected].chancesAccumulatedBeforeFreeze < 0) then locks[lockSelected].chancesAccumulatedBeforeFreeze = 0
				locks[lockSelected].lockFrozenByCard = 1
				locks[lockSelected].lockFrozenByKeyholder = 0
				//locks[lockSelected].lockFrozenByLockee = 0
				locks[lockSelected].timestampFrozenByCard = timestampNow
				locks[lockSelected].timestampLastPicked = timestampNow
				locks[lockSelected].timestampRealLastPicked = timestampNow
				if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(120, 240)
				if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(1800, 3600)
				if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(3600, 7200)
				if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(7200, 14400)
				if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(21600, 43200)
				if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(43200, 86400)
				if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(86400, 172800)
				if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampUnfreezes = timestampNow + random2(172800, 345600)
				noOfCards = GetNoOfCards(lockSelected)
				AddToDiscardPile("Freeze", 1)
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:FreezeCard", 0)
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				ShowLargeCard("Freeze", "", "", "Tap to continue...")
				DeleteSprite(cards[cardSpritesIndex].sprite)		
			elseif (deck[shuffledDeck[cardChosen]].value$ = "GoAgain")
				dec locks[lockSelected].goAgainCards
				locks[lockSelected].timestampRealLastPicked = timestampNow
				AddToDiscardPile("GoAgain", 1)
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:GoAgainCard", 0)
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				ShowLargeCard("GoAgain", "", "", "Tap to continue...")
				DeleteSprite(cards[cardSpritesIndex].sprite)
			elseif (deck[shuffledDeck[cardChosen]].value$ = "Green")
				inc locks[lockSelected].noOfTimesGreenCardRevealed
				inc locks[lockSelected].pickedCount
				inc locks[lockSelected].pickedCountIncludingYellows
				inc locks[lockSelected].pickedCountSinceReset
				dec locks[lockSelected].greenCards
				inc locks[lockSelected].greensPickedSinceReset
				locks[lockSelected].timestampRealLastPicked = timestampNow
				dec noOfCards
				if (locks[lockSelected].multipleGreensRequired = 0)
					locks[lockSelected].readyToUnlock = 1
					noOfChances = 0
					AddToDiscardPile("Green", 1)
					UpdateLocksData(lockSelected)
					UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:GreenCard", 1)			
				else
					if (locks[lockSelected].greenCards = 0)
						locks[lockSelected].readyToUnlock = 1
						noOfChances = 0
						AddToDiscardPile("Green", 1)
						UpdateLocksData(lockSelected)
						UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:GreenCard", 1)
					else
						AddToDiscardPile("Green", 1)
						UpdateLocksData(lockSelected)
						UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:GreenCard", 0)
					endif
				endif
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				greensFound$ as string : greensFound$ = ""
				if (locks[lockSelected].cardInfoHidden = 0)
					greensFound$ = str(locks[lockSelected].greensPickedSinceReset) + "/" + str(locks[lockSelected].greenCards + locks[lockSelected].greensPickedSinceReset)
				else
					greensFound$ = str(locks[lockSelected].greensPickedSinceReset) + "/??"
				endif
				ShowLargeCard("Green", "Greens Found", greensFound$, "Tap to continue...")
				OryUIPinTextToCentreOfSprite(largeCard.txtTop, largeCard.sprite, 0, -(GetTextTotalHeight(largeCard.txtCenter) / 2) - 1)
				OryUIPinTextToCentreOfSprite(largeCard.txtCenter, largeCard.sprite, 0, 0)			
				OryUIPinTextToCentreOfSprite(largeCard.txtBottom, largeCard.sprite, 0, (GetSpriteHeight(largeCard.sprite) / 2) - 6)
				DeleteSprite(cards[cardSpritesIndex].sprite)
				
				if (locks[lockSelected].multipleGreensRequired = 0)
					largeCardDepth = GetSpriteDepth(largeCard.sprite)
					cardsScrimVisible = 1
					OryUIUpdateSprite(sprCardsScrim, "depth:10")
					OryUIUpdateSprite(largeCard.sprite, "depth:9")
					OryUIUpdateText(largeCard.txtTop, "text:;depth:8")
					OryUIUpdateText(largeCard.txtCenter, "text:;depth:8")
					OryUIUpdateText(largeCard.txtBottom, "text:;depth:8")
					showEndOfLockDialog = 1
				else
					if (locks[lockSelected].greenCards = 0)
						largeCardDepth = GetSpriteDepth(largeCard.sprite)
						cardsScrimVisible = 1
						OryUIUpdateSprite(sprCardsScrim, "depth:10")
						OryUIUpdateSprite(largeCard.sprite, "depth:9")
						OryUIUpdateText(largeCard.txtTop, "text:;depth:8")
						OryUIUpdateText(largeCard.txtCenter, "text:;depth:8")
						OryUIUpdateText(largeCard.txtBottom, "text:;depth:8")
						showEndOfLockDialog = 1
					else
						OryUIUpdateText(largeCard.txtTop, "text:You've Found;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
						if (locks[lockSelected].cardInfoHidden = 0)
							OryUIUpdateText(largeCard.txtCenter, "text:" + str(locks[lockSelected].greensPickedSinceReset) + " of " + str(locks[lockSelected].greenCards + locks[lockSelected].greensPickedSinceReset) + " Greens;size:5.5;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
						else
							OryUIUpdateText(largeCard.txtCenter, "text:" + str(locks[lockSelected].greensPickedSinceReset) + " of ?? Greens;size:5.5;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
						endif
					endif
				endif
			elseif (deck[shuffledDeck[cardChosen]].value$ = "Red")
				inc locks[lockSelected].pickedCount
				inc locks[lockSelected].pickedCountIncludingYellows
				inc locks[lockSelected].pickedCountSinceReset
				dec locks[lockSelected].redCards
				dec noOfCards
				dec noOfChances
				if (locks[lockSelected].cumulative = 1)
					if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 60
					if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 900
					if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 1800
					if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 3600
					if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 10800
					if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 21600
					if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 43200
					if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 86400
				else
					locks[lockSelected].timestampLastPicked = timestampNow
				endif
				locks[lockSelected].timestampRealLastPicked = timestampNow
				locks[lockSelected].dateLastPicked$ = dateFromServer$
				if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLastPicked + 60) - timestampNow
				if (locks[lockSelected].regularity# = 0.25) then secondsLeft = (locks[lockSelected].timestampLastPicked + 900) - timestampNow
				if (locks[lockSelected].regularity# = 0.5) then secondsLeft = (locks[lockSelected].timestampLastPicked + 1800) - timestampNow
				if (locks[lockSelected].regularity# = 1) then secondsLeft = (locks[lockSelected].timestampLastPicked + 3600) - timestampNow
				if (locks[lockSelected].regularity# = 3) then secondsLeft = (locks[lockSelected].timestampLastPicked + 10800) - timestampNow
				if (locks[lockSelected].regularity# = 6) then secondsLeft = (locks[lockSelected].timestampLastPicked + 21600) - timestampNow
				if (locks[lockSelected].regularity# = 12) then secondsLeft = (locks[lockSelected].timestampLastPicked + 43200) - timestampNow
				if (locks[lockSelected].regularity# = 24) then secondsLeft = (locks[lockSelected].timestampLastPicked + 86400) - timestampNow
				AddToDiscardPile("Red", 1)
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:RedCard", 0)
				if (noOfChances = 0)
					FlipCard(cardSpritesIndex)
					ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
					OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
					ShowLargeCard("Red", "Next Chance", "", "Tap to continue...")
				else
					cardsScrimVisible = 0
					OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
					FlipCard(cardSpritesIndex)
					MoveCardTo(cardSpritesIndex, GetViewOffsetX() + 50, 89)
					ResizeCard(cardSpritesIndex, cardWidth# / GetDisplayAspect(), cardHeight#)
				endif
				cardSelected = 0
				cardChosen = 0
				if (noOfChances > 0) then ShuffleDeck(25)			
			elseif (deck[shuffledDeck[cardChosen]].value$ = "Reset")
				inc locks[lockSelected].pickedCount
				inc locks[lockSelected].pickedCountIncludingYellows
				locks[lockSelected].pickedCountSinceReset = 0
				inc locks[lockSelected].resetCardsPicked
				dec locks[lockSelected].resetCards
				inc locks[lockSelected].noOfTimesCardReset
				inc locks[lockSelected].noOfTimesReset
				locks[lockSelected].greenCards = locks[lockSelected].initialGreenCards
				locks[lockSelected].greensPickedSinceReset = 0
				locks[lockSelected].redCards = locks[lockSelected].initialRedCards
				locks[lockSelected].noOfAdd1Cards = locks[lockSelected].initialYellowAdd1Cards
				locks[lockSelected].noOfAdd2Cards = locks[lockSelected].initialYellowAdd2Cards
				locks[lockSelected].noOfAdd3Cards = locks[lockSelected].initialYellowAdd3Cards
				locks[lockSelected].noOfMinus1Cards = locks[lockSelected].initialYellowMinus1Cards
				locks[lockSelected].noOfMinus2Cards = locks[lockSelected].initialYellowMinus2Cards
				locks[lockSelected].yellowCards = locks[lockSelected].noOfAdd1Cards + locks[lockSelected].noOfAdd2Cards + locks[lockSelected].noOfAdd3Cards + locks[lockSelected].noOfMinus1Cards + locks[lockSelected].noOfMinus2Cards
				locks[lockSelected].goAgainCards = 0
				if (locks[lockSelected].cardInfoHidden = 1) then locks[lockSelected].goAgainCards = floor((GetNoOfCards(lockSelected) / 100.0) * locks[lockSelected].goAgainCardsPercentage#)
				if (locks[lockSelected].goAgainCards > cappedGoAgainCards) then locks[lockSelected].goAgainCards = cappedGoAgainCards
				noOfCards = GetNoOfCards(lockSelected)
				if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampLastPicked = timestampNow - 60
				if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampLastPicked = timestampNow - 900
				if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampLastPicked = timestampNow - 1800
				if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampLastPicked = timestampNow - 3600
				if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampLastPicked = timestampNow - 10800
				if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampLastPicked = timestampNow - 21600
				if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampLastPicked = timestampNow - 43200
				if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampLastPicked = timestampNow - 86400
				locks[lockSelected].timestampLastCardReset = timestampNow
				locks[lockSelected].timestampLastReset = timestampNow
				locks[lockSelected].timestampRealLastPicked = timestampNow
				AddToDiscardPile("Reset", 1)
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:ResetCard", 0)
				noOfChances = 1
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				ShowLargeCard("Reset", "", "", "Tap to continue...")
				DeleteSprite(cards[cardSpritesIndex].sprite)
				ClearDiscardPile(lockSelected)
				ClearGreenPile()
			elseif (deck[shuffledDeck[cardChosen]].value$ = "Sticky")
				inc locks[lockSelected].pickedCount
				inc locks[lockSelected].pickedCountIncludingYellows
				inc locks[lockSelected].pickedCountSinceReset
				dec noOfChances
				if (locks[lockSelected].cumulative = 1)
					if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 60
					if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 900
					if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 1800
					if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 3600
					if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 10800
					if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 21600
					if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 43200
					if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampLastPicked = locks[lockSelected].timestampLastPicked + 86400
				else
					locks[lockSelected].timestampLastPicked = timestampNow
				endif
				locks[lockSelected].dateLastPicked$ = dateFromServer$
				if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLastPicked + 60) - timestampNow
				if (locks[lockSelected].regularity# = 0.25) then secondsLeft = (locks[lockSelected].timestampLastPicked + 900) - timestampNow
				if (locks[lockSelected].regularity# = 0.5) then secondsLeft = (locks[lockSelected].timestampLastPicked + 1800) - timestampNow
				if (locks[lockSelected].regularity# = 1) then secondsLeft = (locks[lockSelected].timestampLastPicked + 3600) - timestampNow
				if (locks[lockSelected].regularity# = 3) then secondsLeft = (locks[lockSelected].timestampLastPicked + 10800) - timestampNow
				if (locks[lockSelected].regularity# = 6) then secondsLeft = (locks[lockSelected].timestampLastPicked + 21600) - timestampNow
				if (locks[lockSelected].regularity# = 12) then secondsLeft = (locks[lockSelected].timestampLastPicked + 43200) - timestampNow
				if (locks[lockSelected].regularity# = 24) then secondsLeft = (locks[lockSelected].timestampLastPicked + 86400) - timestampNow
				locks[lockSelected].timestampRealLastPicked = timestampNow
				AddToDiscardPile("Sticky", 1)
				UpdateLocksData(lockSelected)
				UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:StickyCard", 0)
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				if (noOfChances > 0)
					ShowLargeCard("Sticky", "", "", "Tap to continue...")
				else
					ShowLargeCard("Sticky", "Next Chance", "", "Tap to continue...")
				endif
				DeleteSprite(cards[cardSpritesIndex].sprite)
			elseif (left(deck[shuffledDeck[cardChosen]].value$, 6) = "Yellow")
				if (deck[shuffledDeck[cardChosen]].value$ = "YellowAdd1" or deck[shuffledDeck[cardChosen]].value$ = "YellowAdd2" or deck[shuffledDeck[cardChosen]].value$ = "YellowAdd3")
					redsAddedThisPick = 0
					inc locks[lockSelected].pickedCountIncludingYellows
					inc locks[lockSelected].pickedCountSinceReset
					dec locks[lockSelected].yellowCards
					if (deck[shuffledDeck[cardChosen]].value$ = "YellowAdd1")
						dec locks[lockSelected].noOfAdd1Cards
						if (locks[lockSelected].noOfAdd1Cards < 0) then locks[lockSelected].noOfAdd1Cards = 0
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						AddToDiscardPile("YellowAdd1", 1)
					elseif (deck[shuffledDeck[cardChosen]].value$ = "YellowAdd2") 
						dec locks[lockSelected].noOfAdd2Cards
						if (locks[lockSelected].noOfAdd2Cards < 0) then locks[lockSelected].noOfAdd2Cards = 0
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						AddToDiscardPile("YellowAdd2", 1)
					elseif (deck[shuffledDeck[cardChosen]].value$ = "YellowAdd3")
						dec locks[lockSelected].noOfAdd3Cards
						if (locks[lockSelected].noOfAdd3Cards < 0) then locks[lockSelected].noOfAdd3Cards = 0
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						if (locks[lockSelected].redCards < cappedRedCards)
							inc locks[lockSelected].redCards
							inc redsAddedThisPick
						endif
						AddToDiscardPile("YellowAdd3", 1)
					endif
					locks[lockSelected].timestampRealLastPicked = timestampNow
					locks[lockSelected].yellowCards = locks[lockSelected].noOfAdd1Cards + locks[lockSelected].noOfAdd2Cards + locks[lockSelected].noOfAdd3Cards + locks[lockSelected].noOfMinus1Cards + locks[lockSelected].noOfMinus2Cards
					UpdateLocksData(lockSelected)
					UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:" + deck[shuffledDeck[cardChosen]].value$ + "Card", 0)
				elseif (deck[shuffledDeck[cardChosen]].value$ = "YellowMinus1" or deck[shuffledDeck[cardChosen]].value$ = "YellowMinus2")
					inc locks[lockSelected].pickedCountIncludingYellows
					inc locks[lockSelected].pickedCountSinceReset
					dec locks[lockSelected].yellowCards
					if (deck[shuffledDeck[cardChosen]].value$ = "YellowMinus1")
						dec locks[lockSelected].noOfMinus1Cards
						if (locks[lockSelected].noOfMinus1Cards < 0) then locks[lockSelected].noOfMinus1Cards = 0
						locks[lockSelected].redCards = locks[lockSelected].redCards - 1
						if (locks[lockSelected].redCards < 0) then locks[lockSelected].redCards = 0
						AddToDiscardPile("YellowMinus1", 1)
					elseif (deck[shuffledDeck[cardChosen]].value$ = "YellowMinus2")
						dec locks[lockSelected].noOfMinus2Cards
						if (locks[lockSelected].noOfMinus2Cards < 0) then locks[lockSelected].noOfMinus2Cards = 0
						locks[lockSelected].redCards = locks[lockSelected].redCards - 2
						if (locks[lockSelected].redCards < 0) then locks[lockSelected].redCards = 0
						AddToDiscardPile("YellowMinus2", 1)
					endif
					locks[lockSelected].timestampRealLastPicked = timestampNow
					UpdateLocksData(lockSelected)
					UpdateLocksDatabase(lockSelected, "action:PickedACard;actionedBy:Lockee;result:" + deck[shuffledDeck[cardChosen]].value$ + "Card", 0)
				endif
				FlipCard(cardSpritesIndex)
				ResizeCard(cardSpritesIndex, (cardWidth# / GetDisplayAspect()) * 4, cardHeight# * 4)
				OryUIUpdateSprite(cards[cardSpritesIndex].sprite, "position:-1000,-1000")
				ShowLargeCard(deck[shuffledDeck[cardChosen]].value$, "", "", "Tap to continue...")
				DeleteSprite(cards[cardSpritesIndex].sprite)			
			endif
			cardSelected = 0
			cardChosen = 0
		endif
	endif

	// SHOW COUNTDOWN UNTIL NEXT TURN
	if ((largeCard.value$ = "Red" or largeCard.value$ = "Sticky") and noOfChances = 0)
		if (locks[lockSelected].regularity# = 0.016667) then secondsLeft = (locks[lockSelected].timestampLastPicked + 60) - timestampNow
		if (locks[lockSelected].regularity# = 0.25) then secondsLeft = (locks[lockSelected].timestampLastPicked + 900) - timestampNow
		if (locks[lockSelected].regularity# = 0.5) then secondsLeft = (locks[lockSelected].timestampLastPicked + 1800) - timestampNow
		if (locks[lockSelected].regularity# = 1) then secondsLeft = (locks[lockSelected].timestampLastPicked + 3600) - timestampNow
		if (locks[lockSelected].regularity# = 3) then secondsLeft = (locks[lockSelected].timestampLastPicked + 10800) - timestampNow
		if (locks[lockSelected].regularity# = 6) then secondsLeft = (locks[lockSelected].timestampLastPicked + 21600) - timestampNow
		if (locks[lockSelected].regularity# = 12) then secondsLeft = (locks[lockSelected].timestampLastPicked + 43200) - timestampNow
		if (locks[lockSelected].regularity# = 24) then secondsLeft = (locks[lockSelected].timestampLastPicked + 86400) - timestampNow
		if (secondsLeft <= 0)
			ClearLargeCard()
			SetScreenToView(selectedLocksTab)
		endif		
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		OryUIUpdateText(largeCard.txtCenter, "text:" + AddLeadingZeros(str(hh), 2) + "[colon]" + AddLeadingZeros(str(mm), 2) + "[colon]" + AddLeadingZeros(str(ss), 2))
	endif

	dialogButtonReleased$ as string : dialogButtonReleased$ = OryUIGetDialogButtonReleasedName(dialog)
	screenDialogButtonReleased$ as string : screenDialogButtonReleased$ = OryUIGetDialogButtonReleasedName(screen[screenNo].dialog)
	
	if (dialogButtonReleased$ = "Discard")
		dialogButtonReleased$ = ""
		ClearLargeCard()
		cardSelected = 0
		cardChosen = 0
		SetScreenToView(selectedLocksTab)
	endif
	if (dialogButtonReleased$ = "Ok")
		dialogButtonReleased$ = ""
		OryUIUpdateSprite(largeCard.sprite, "depth:" + str(largeCardDepth))
		cardsScrimVisible = 1
		OryUIUpdateSprite(sprCardsScrim, "depth:" + str(GetSpriteDepth(largeCard.sprite) + 1))
		OryUIUpdateText(largeCard.txtBottom, "depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
	endif
	
	// END OF LOCK DIALOG
	if (showEndOfLockDialog = 1)
		showEndOfLockDialog = 0
		noOfCards = GetNoOfCards(lockSelected)
		local showPutGreenBackOption as integer : showPutGreenBackOption = 0
		local showDeclineUnlockOption as integer : showDeclineUnlockOption = 0
		if (GetNoOfCards(lockSelected) > 0 and locks[lockSelected].greenCards = 0)
			showPutGreenBackOption = 1
		endif
		if (GetNoOfCards(lockSelected) > locks[lockSelected].greenCards and locks[lockSelected].greenCards > 0)
			showDeclineUnlockOption = 1
		endif
		if (locks[lockSelected].multipleGreensRequired = 0)
			if (locks[lockSelected].keyholderDecisionDisabled = 0 and ((locks[lockSelected].keyholderBuildNumberInstalled >= 115 and locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0) or locks[lockSelected].botChosen > 0))
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Congratulations, you've found the green card needed to unlock. You can now reveal the combination!" + chr(10) + chr(10) + "Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 5 + showPutGreenBackOption + showDeclineUnlockOption)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:LetKeyholderDecide;text:Let Keyholder Decide;textColorID:" + str(colorMode[colorModeSelected].textColor))
				if (showPutGreenBackOption = 1) then OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
				if (showDeclineUnlockOption = 1) then OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Decline Unlock;text:Decline Unlock;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption + 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			else
				OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Congratulations, you've found the green card needed to unlock. You can now reveal the combination!" + chr(10) + chr(10) + "Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
				OryUISetDialogButtonCount(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption)
				OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
				if (showPutGreenBackOption = 1) then OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
				if (showDeclineUnlockOption = 1) then OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption + showDeclineUnlockOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeclineUnlock;text:Decline Unlock;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption + showDeclineUnlockOption + 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIShowDialog(dialog)
			endif
		else
			if (locks[lockSelected].greenCards = 0)
				if (locks[lockSelected].keyholderDecisionDisabled = 0 and ((locks[lockSelected].keyholderBuildNumberInstalled >= 115 and locks[lockSelected].keyholderUsername$ <> "" and locks[lockSelected].hiddenFromOwner = 0 and locks[lockSelected].removedByKeyholder = 0) or locks[lockSelected].botChosen > 0))
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Congratulations, you've found all of the green cards needed to unlock. You can now reveal the combination!" + chr(10) + chr(10) + "Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 5 + showPutGreenBackOption + showDeclineUnlockOption)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 4, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:LetKeyholderDecide;text:Let Keyholder Decide;textColorID:" + str(colorMode[colorModeSelected].textColor))
					if (showPutGreenBackOption = 1) then OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
					if (showDeclineUnlockOption = 1) then OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeclineUnlock;text:Decline Unlock;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption + 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				else
					OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Reveal Combination?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Congratulations, you've found all of the green cards needed to unlock. You can now reveal the combination!" + chr(10) + chr(10) + "Would you like to reveal the combination or reset the lock and start again?" + chr(10) + chr(10) + "Resetting the lock will not change the combination.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
					OryUISetDialogButtonCount(dialog, 4 + showPutGreenBackOption + showDeclineUnlockOption)
					OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:RevealCombination;text:Reveal Combination;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ResetLock;text:Reset Lock;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 3, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:SurpriseMe;text:Surprise Me;textColorID:" + str(colorMode[colorModeSelected].textColor))
					if (showPutGreenBackOption = 1) then OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:PutGreenBack;text:Put Green Back;textColorID:" + str(colorMode[colorModeSelected].textColor))
					if (showDeclineUnlockOption = 1) then OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption + showDeclineUnlockOption, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DeclineUnlock;text:Decline Unlock;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateDialogButton(dialog, 3 + showPutGreenBackOption + showDeclineUnlockOption + 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:DecideLater;text:Decide Later;textColorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIShowDialog(dialog)
				endif
			endif
		endif
	endif
	if (dialogButtonReleased$ = "DecideLater")
		dialogButtonReleased$ = ""
		ClearLargeCard()
		locks[lockSelected].readyToUnlock = 1
		UpdateLocksData(lockSelected)
		UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:DecideLater", 0)
		cardSelected = 0
		cardChosen = 0
		SetScreenToView(selectedLocksTab)
	endif
	
	// END OF LOCK ACTIONS CONFIRM DIALOGS
	if (dialogButtonReleased$ = "SurpriseMe")
		dialogButtonReleased$ = ""
		OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the app to randomly choose if the lock resets or unlocks? It will pick randomly with a 50/50 chance.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
		OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedSurpriseMe;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(screen[screenNo].dialog)
	endif
	if (dialogButtonReleased$ = "RevealCombination")
		dialogButtonReleased$ = ""
		OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the lock to end and show you the combination?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
		OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedRevealCombination;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(screen[screenNo].dialog)
	endif
	if (dialogButtonReleased$ = "ResetLock" or dialogButtonReleased$ = "RestartLock")
		dialogButtonReleased$ = ""
		OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want the lock to reset?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
		OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedResetLock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(screen[screenNo].dialog)
	endif
	if (dialogButtonReleased$ = "LetKeyholderDecide")
		dialogButtonReleased$ = ""
		OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to let the keyholder decide? You will have to wait for a few hours to give them a chance to decide. After that the decision will come back to you.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
		OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedLetKeyholderDecide;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(screen[screenNo].dialog)
	endif
	if (dialogButtonReleased$ = "PutGreenBack")
		dialogButtonReleased$ = ""
		OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to put the last green found back into the deck to be found again?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
		OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
		OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedPutGreenBack;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIShowDialog(screen[screenNo].dialog)
	endif
	if (dialogButtonReleased$ = "DeclineUnlock")
		if (locks[lockSelected].multipleGreensRequired = 0)
			dialogButtonReleased$ = ""
			OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to continue the lock to find one green?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
			OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedDeclineUnlock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(screen[screenNo].dialog)
		else
			dialogButtonReleased$ = ""
			OryUIUpdateDialog(screen[screenNo].dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Are You Sure?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Are you sure you want to continue the lock to find the remaining greens?;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(screen[screenNo].dialog, 2)
			OryUIUpdateDialogButton(screen[screenNo].dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:ConfirmedDeclineUnlock;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(screen[screenNo].dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:CancelConfirm;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(screen[screenNo].dialog)
		endif
	endif
	if (screenDialogButtonReleased$ = "CancelConfirm")
		showEndOfLockDialog = 1
	endif
	
	// END OF LOCK ACTIONS CONFIRMED
	surpriseMe = 0
	if (screenDialogButtonReleased$ = "ConfirmedSurpriseMe")
		surpriseMe = random(1, 100)
		if (surpriseMe >= 1 and surpriseMe <= 50)
			screenDialogButtonReleased$ = "ConfirmedRevealCombination"
		else
			screenDialogButtonReleased$ = "ConfirmedResetLock"
		endif
	endif
	if (screenDialogButtonReleased$ = "ConfirmedRevealCombination")
		screenDialogButtonReleased$ = ""
		ClearLargeCard()
		OryUIUpdateSprite(largeCard.sprite, "depth:" + str(largeCardDepth))
		cardsScrimVisible = 1
		OryUIUpdateSprite(sprCardsScrim, "depth:" + str(GetSpriteDepth(largeCard.sprite) + 1))
		OryUIUpdateText(largeCard.txtTop, "text:Your Combination;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
		OryUIUpdateText(largeCard.txtCenter, "text:" + locks[lockSelected].combination$ + ";size:8;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
		OryUIUpdateText(largeCard.txtBottom, "depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
		OryUIPinTextToCentreOfSprite(largeCard.txtTop, largeCard.sprite, 0, -(GetTextTotalHeight(largeCard.txtCenter) / 2) - 1)
		OryUIPinTextToCentreOfSprite(largeCard.txtCenter, largeCard.sprite, 0, 0)			
		OryUIPinTextToCentreOfSprite(largeCard.txtBottom, largeCard.sprite, 0, (GetSpriteHeight(largeCard.sprite) / 2) - 6)
		locks[lockSelected].timestampLastPicked = timestampNow
		locks[lockSelected].dateLastPicked$ = dateFromServer$
		if (surpriseMe = 0 or surpriseMe >= 51)
			UnlockLock(lockSelected, "Lockee", "Naturally")
		else
			UnlockLock(lockSelected, "Lockee", "NaturallyWithSurpriseMe")
		endif	
		inc noOfLocksNaturallyUnlocked
		SaveLocalVariable("noOfLocksNaturallyUnlocked", str(noOfLocksNaturallyUnlocked))
		noOfChances = 0
		cardSelected = 0
		cardChosen = 0
	endif
	if (screenDialogButtonReleased$ = "ConfirmedResetLock" or screenDialogButtonReleased$ = "ConfirmedRestartLock")
		screenDialogButtonReleased$ = ""
		ClearLargeCard()
		ClearDiscardPile(lockSelected)
		ClearGreenPile()
		inc locks[lockSelected].noOfTimesFullReset
		inc locks[lockSelected].noOfTimesReset
		locks[lockSelected].lockFrozenByCard = 0
		locks[lockSelected].lockFrozenByKeyholder = 0	
		//locks[lockSelected].lockFrozenByLockee = 0	
		locks[lockSelected].readyToUnlock = 0
		locks[lockSelected].pickedCountSinceReset = 0
		locks[lockSelected].greenCards = locks[lockSelected].initialGreenCards
		locks[lockSelected].greensPickedSinceReset = 0
		locks[lockSelected].hideGreensUntilPickCount = 0
		locks[lockSelected].redCards = locks[lockSelected].initialRedCards
		locks[lockSelected].yellowCards = locks[lockSelected].initialYellowCards
		locks[lockSelected].noOfAdd1Cards = locks[lockSelected].initialYellowAdd1Cards
		locks[lockSelected].noOfAdd2Cards = locks[lockSelected].initialYellowAdd2Cards
		locks[lockSelected].noOfAdd3Cards = locks[lockSelected].initialYellowAdd3Cards
		locks[lockSelected].noOfMinus1Cards = locks[lockSelected].initialYellowMinus1Cards
		locks[lockSelected].noOfMinus2Cards = locks[lockSelected].initialYellowMinus2Cards
		locks[lockSelected].yellowCards = locks[lockSelected].noOfAdd1Cards + locks[lockSelected].noOfAdd2Cards + locks[lockSelected].noOfAdd3Cards + locks[lockSelected].noOfMinus1Cards + locks[lockSelected].noOfMinus2Cards
		locks[lockSelected].stickyCards = locks[lockSelected].initialStickyCards
		locks[lockSelected].freezeCards = locks[lockSelected].initialFreezeCards
		locks[lockSelected].doubleUpCards = locks[lockSelected].initialDoubleUpCards
		locks[lockSelected].resetCards = locks[lockSelected].initialResetCards
		locks[lockSelected].goAgainCards = 0
		if (locks[lockSelected].cardInfoHidden = 1) then locks[lockSelected].goAgainCards = floor((GetNoOfCards(lockSelected) / 100.0) * locks[lockSelected].goAgainCardsPercentage#)
		if (locks[lockSelected].goAgainCards > cappedGoAgainCards) then locks[lockSelected].goAgainCards = cappedGoAgainCards
		noOfCards = GetNoOfCards(lockSelected)
		if (locks[lockSelected].regularity# = 0.016667) then locks[lockSelected].timestampLastPicked = timestampNow - 60
		if (locks[lockSelected].regularity# = 0.25) then locks[lockSelected].timestampLastPicked = timestampNow - 900
		if (locks[lockSelected].regularity# = 0.5) then locks[lockSelected].timestampLastPicked = timestampNow - 1800
		if (locks[lockSelected].regularity# = 1) then locks[lockSelected].timestampLastPicked = timestampNow - 3600
		if (locks[lockSelected].regularity# = 3) then locks[lockSelected].timestampLastPicked = timestampNow - 10800
		if (locks[lockSelected].regularity# = 6) then locks[lockSelected].timestampLastPicked = timestampNow - 21600
		if (locks[lockSelected].regularity# = 12) then locks[lockSelected].timestampLastPicked = timestampNow - 43200
		if (locks[lockSelected].regularity# = 24) then locks[lockSelected].timestampLastPicked = timestampNow - 86400
		locks[lockSelected].timestampLastFullReset = timestampNow
		locks[lockSelected].timestampLastReset = timestampNow
		locks[lockSelected].autoResetsPaused = 0
		locks[lockSelected].noOfTimesAutoReset = 0
		UpdateLocksData(lockSelected)
		if (surpriseMe <= 50)
			UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:ResetLock", 0)
		else
			UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:ResetLockWithSurpriseMe", 0)
		endif	
		noOfChances = 1
		cardSelected = 0
		cardChosen = 0
		ShuffleDeck(25)
	endif
	if (screenDialogButtonReleased$ = "ConfirmedLetKeyholderDecide")
		screenDialogButtonReleased$ = ""
		ClearLargeCard()
		locks[lockSelected].readyToUnlock = 1
		locks[lockSelected].timestampRequestedKeyholdersDecision = timestampNow
		UpdateLocksData(lockSelected)
		UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:LetKeyholderDecide", 0)
		SendNotificationToKeyholder(locks[lockSelected].sharedID$, "RequestKeyholdersDecision", locks[lockSelected].test, 0)
		cardSelected = 0
		cardChosen = 0
		SetScreenToView(selectedLocksTab)
	endif
	if (screenDialogButtonReleased$ = "ConfirmedPutGreenBack")
		screenDialogButtonReleased$ = ""
		tweenSprite = CreateTweenSprite(0.2)
		SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
		SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
		SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
		SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 50, TweenLinear())
		PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
		while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
			UpdateAllTweens(GetFrameTime())
			Sync()
		endwhile
		ClearLargeCard()
		inc locks[lockSelected].greenCards
		dec locks[lockSelected].greensPickedSinceReset
		locks[lockSelected].readyToUnlock = 0
		UpdateLocksData(lockSelected)
		UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:PutGreenBack", 0)
		cardSelected = 0
		cardChosen = 0
		ShuffleDeck(25)
	endif
	if (screenDialogButtonReleased$ = "ConfirmedDeclineUnlock")
		screenDialogButtonReleased$ = ""
		tweenSprite = CreateTweenSprite(0.2)
		SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
		SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
		SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
		SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 50, TweenLinear())
		PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
		while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
			UpdateAllTweens(GetFrameTime())
			Sync()
		endwhile
		ClearLargeCard()
		dec locks[lockSelected].greensPickedSinceReset
		locks[lockSelected].readyToUnlock = 0
		UpdateLocksData(lockSelected)
		UpdateLocksDatabase(lockSelected, "action:Decision;actionedBy:Lockee;result:DeclinedUnlock", 0)
		cardSelected = 0
		cardChosen = 0
		ShuffleDeck(25)
	endif

	cardReleased = OryUIGetSpriteReleased()
	if (cardReleased > 0) then cardReleasedGroup = GetSpriteGroup(cardReleased)
	if (cardReleased = largeCard.sprite)
		OryUIUpdateText(largeCard.txtTop, "position:-1000,-1000")
		OryUIUpdateText(largeCard.txtCenter, "position:-1000,-1000")
		OryUIUpdateText(largeCard.txtBottom, "position:-1000,-1000")
		if (largeCard.value$ = "DoubleUp")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "Freeze")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			SetScreenToView(selectedLocksTab)
		elseif (largeCard.value$ = "GoAgain")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "Green")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			if (locks[lockSelected].greenCards = 0 or locks[lockSelected].multipleGreensRequired = 0)
				cardSelected = 0
				cardChosen = 0
				ClearLargeCard()
			endif
			if (locks[lockSelected].greenCards > 0 and locks[lockSelected].multipleGreensRequired = 1)
				tweenSprite = CreateTweenSprite(0.2)
				SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
				SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
				SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 75, TweenLinear())
				SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
				PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
				while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
					UpdateAllTweens(GetFrameTime())
					Sync()
				endwhile
				AddToGreenPile()
				cardSelected = 0
				cardChosen = 0
				ClearLargeCard()
				ShuffleDeck(25)
			endif
		elseif (largeCard.value$ = "Red")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			SetScreenToView(selectedLocksTab)
		elseif (largeCard.value$ = "Reset")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "Sticky")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			if (noOfChances > 0)
				tweenSprite = CreateTweenSprite(0.2)
				SetSpriteImage(largeCard.sprite, imgCardBack)
				SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
				SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
				SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
				SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 50, TweenLinear())
				PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
				while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
					UpdateAllTweens(GetFrameTime())
					Sync()
				endwhile
			endif
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			if (noOfChances = 0)
				SetScreenToView(selectedLocksTab)
			else
				ShuffleDeck(25)
			endif			
		elseif (largeCard.value$ = "YellowAdd1")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			//if (locks[lockSelected].redCards < cappedRedCards)
				for i = 1 to redsAddedThisPick
					dec lastCardDepth
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardRed100) + ";angle:0;depth:1")
					colX# as float : colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5) + ((i - 1) * 25)
					if (colX# < GetViewOffsetX()) then colX# = colX# + 25
					MoveCardTo(noOfCardSprites + i, colX#, (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
					FlipCard(noOfCardSprites + i)
					ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
					Sleep(100)
				next
			//endif
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "YellowAdd2")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			//if (locks[lockSelected].redCards < cappedRedCards - 1)
				for i = 1 to redsAddedThisPick
					dec lastCardDepth
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardRed100) + ";angle:0;depth:1")
					colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5) + ((i - 1) * 25)
					if (colX# < GetViewOffsetX()) then colX# = colX# + 25
					MoveCardTo(noOfCardSprites + i, colX#, (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
					FlipCard(noOfCardSprites + i)
					ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
					Sleep(100)
				next
			//endif
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "YellowAdd3")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			//if (locks[lockSelected].redCards < cappedRedCards - 2)
				for i = 1 to redsAddedThisPick
					dec lastCardDepth
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardRed100) + ";angle:0;depth:1")
					colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5) + ((i - 1) * 25)
					if (colX# < GetViewOffsetX()) then colX# = colX# + 25
					MoveCardTo(noOfCardSprites + i, colX#, (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
					FlipCard(noOfCardSprites + i)
					ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
					OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
					Sleep(100)
				next
			//endif
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "YellowMinus1")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			for a = 1 to 1
				randomI as integer : randomI = random(1, noOfCardSprites)
				for i = 1 to noOfCardSprites
					inc randomI
					if (randomI > noOfCards) then randomI = i
					if (GetSpriteExists(cards[randomI].sprite))
						if (deck[shuffledDeck[cards[randomI].id]].value$ = "Red")
							SlideOutCard(randomI, false)
							FlipCard(randomI)
							MoveCardTo(randomI, GetViewOffsetX() + 50, 89)
							ResizeCard(randomI, cardWidth# / GetDisplayAspect(), cardHeight#)
							AddToDiscardPile("Red", 2)
							Sleep(100)
							exit
						endif
					endif
				next
			next
			UpdateLocksData(lockSelected)
			UpdateLocksDatabase(lockSelected, "", 0)
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			ShuffleDeck(25)
		elseif (largeCard.value$ = "YellowMinus2")
			cardsScrimVisible = 0
			OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
			tweenSprite = CreateTweenSprite(0.2)
			SetTweenSpriteSizeX(tweenSprite, GetSpriteWidth(largeCard.sprite), cardWidth# / GetDisplayAspect(), TweenLinear())
			SetTweenSpriteSizeY(tweenSprite, GetSpriteHeight(largeCard.sprite), cardHeight#, TweenLinear())
			SetTweenSpriteXByOffset(tweenSprite, GetSpriteXByOffset(largeCard.sprite), GetViewOffsetX() + 50, TweenLinear())
			SetTweenSpriteYByOffset(tweenSprite, GetSpriteYByOffset(largeCard.sprite), GetViewOffsetY() + screenBoundsTop# + 89, TweenLinear())
			PlayTweenSprite(tweenSprite, largeCard.sprite, 0)
			while (GetTweenSpritePlaying(tweenSprite, largeCard.sprite))
				UpdateAllTweens(GetFrameTime())
				Sync()
			endwhile
			for a = 1 to 2
				randomI = random(1, noOfCardSprites)
				for i = 1 to noOfCardSprites
					inc randomI
					if (randomI > noOfCards) then randomI = i
					if (GetSpriteExists(cards[randomI].sprite))
						if (deck[shuffledDeck[cards[randomI].id]].value$ = "Red")
							SlideOutCard(randomI, false)
							FlipCard(randomI)
							MoveCardTo(randomI, GetViewOffsetX() + 50, 89)
							ResizeCard(randomI, cardWidth# / GetDisplayAspect(), cardHeight#)
							AddToDiscardPile("Red", 2)
							deck[shuffledDeck[cards[randomI].id]].value$ = ""
							Sleep(100)
							exit
						endif
					endif
				next
			next
			UpdateLocksData(lockSelected)
			UpdateLocksDatabase(lockSelected, "", 0)
			cardSelected = 0
			cardChosen = 0
			ClearLargeCard()
			ShuffleDeck(25)
		endif
	else
		if (cardReleasedGroup >= 1001 and cardReleasedGroup < cappedTotalCards + 2001 and noOfChances > 0 and cardReleased > 0 and largeCardVisible = 0)
			if (OryUIGetSwipingHorizontally() = 0)
				OryUIDisableScreenScrolling()		
				cardHit as integer : cardHit = GetSpriteGroup(cardReleased) - 1000
				if (cardSelected = 0 and cardChosen = 0)
					cardSelected = cardHit
					for i = 1 to noOfCardSprites
						if (cards[i].id = cardSelected)
							cardSpritesIndex = i
							exit
						endif
					next
					MoveToCard(cardSpritesIndex)
					cardIndexToSlideOutAfterMovedTo = cardSpritesIndex			
				endif
			endif
		endif
	endif
	
	// ADVERTS
	SetAdvertVisible(0)
	
	if (redrawScreen = 1) then screen[screenNo].endScreenDrawTime# = timer()

	// SCROLL LIMITS
	if (cardSelected > 0 or cardChosen > 0 or largeCardVisible = 1)
		OryUIDisableScreenScrolling()
	else
		OryUIEnableScreenScrolling()
	endif
	OryUIUpdateSprite(screen[screenNo].sprPage, "height:" + str(elementY# - GetSpriteY(screen[screenNo].sprPage)))
	maxScrollY# = ((GetSpriteY(screen[screenNo].sprPage) + GetSpriteHeight(screen[screenNo].sprPage)) - 100) + 50
	if (maxScrollY# < 0) then maxScrollY# = 0
	OryUISetScreenScrollLimits(screenNo * 100, (screenNo + noOfCardScreens# - 1) * 100, 0, maxScrollY#)
endif
