
OryUIHideFloatingActionButton(fabUpdateUser)
if (screenToView = constUsersLockUpdateScreen)
	local fakeUpdate : fakeUpdate = 1
	
	screenNo = constUsersLockUpdateScreen
	SetLastScreenViewed(screenNo)
	
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
		if (sharedLocks[sharedLockSelected, 0].lockName$ <> "")
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:" + sharedLocks[sharedLockSelected, 0].lockName$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		else
			OryUIUpdateTopBar(screen[screenNo].topBar, "text:ID " + sharedLocks[sharedLockSelected, 0].shareID$ + ";position:" + str(screenNo * 100) + ",0;colorID:" + str(colorMode[colorModeSelected].topBar))
		endif
	endif
	OryUIInsertTopBarListener(screen[screenNo].topBar)
	if (lower(OryUIGetTopBarNavigationReleasedName(screen[screenNo].topBar)) = "back" or (GetRawKeyPressed(27) and OryUITextfieldIDFocused = -1 and OryUIInputSpinnerIDFocused = -1))
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		previousBreadcrumb = GetPreviousBreadcrumb()
		RemoveLastBreadcrumb()
		SetScreenToView(previousBreadcrumb)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// TABS
	if (redrawScreen = 1)
		OryUIUpdateTabs(screen[screenNo].tabs, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";minPosition:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].tabs) + ";activeColor:255,255,255;inactiveColor:255,255,255")
	endif
	updateTabVisible as integer : updateTabVisible = 0
	infoTabVisible as integer : infoTabVisible = 1
	logTabVisible as integer : logTabVisible = 0
	tabCounter as integer : tabCounter = 0
	allowModification as integer : allowModification = 0
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] > 0 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTrustKeyholder[userSelected] = 0)
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.25)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 300) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.5)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 900) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 1800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 3)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 6)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 10800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 12)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 21600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 24)
			if (timestampNow - sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] >= 43200) then allowModification = 1
		endif
	else
		allowModification = 1
	endif
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReadyToUnlock[userSelected] = 1) then allowModification = 0
	if (selectedManageUsersTab = 1 and sharedLocks[sharedLockSelected, selectedManageUsersTab].usersReadyToUnlock[userSelected] = 0 and allowModification = 1) then updateTabVisible = 1
	if (sharedLocks[sharedLockSelected, selectedManageUsersTab].usersBuildNumberInstalled[userSelected] >= 134) then logTabVisible = 1
	noOfTabs as integer : noOfTabs = updateTabVisible + infoTabVisible + logTabVisible
	OryUISetTabsButtonCount(screen[screenNo].tabs, noOfTabs)
	OryUISetTabsButtonSelectedByName(screen[screenNo].tabs, "Update")
	if (updateTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Update;text:Update")
	endif
	if (infoTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Info;text:Info")
	endif
	if (logTabVisible = 1)
		inc tabCounter
		OryUIUpdateTabsButton(screen[screenNo].tabs, tabCounter, "name:Log;text:Log")
	endif
	OryUIInsertTabsListener(screen[screenNo].tabs)
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Info")
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		SetScreenToView(constUsersLockInformationScreen)
	endif
	if (OryUIGetTabsButtonReleasedName(screen[screenNo].tabs) = "Log")
		ResetModifiedByCounts(sharedLockSelected, selectedManageUsersTab, userSelected)
		GetUserLog(sharedLockSelected, userSelected, selectedManageUsersTab, 1)
		SetScreenToView(constUsersLockLogScreen)
	endif
	elementY# = elementY# + OryUIGetTabsHeight(screen[screenNo].tabs)
	
	startScrollBarY# = elementY# + 1
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	endif
	elementY# = elementY# + 2

	if (redrawScreen = 1)
		DestroyItemsOnUpdateUserScreen()
		CreateItemsOnUpdateUserScreen()
	endif
	
	// USERNAME
	fakeLockText$ as string : fakeLockText$ = ""
	if (sharedLocks[sharedLockSelected, 1].usersFakeLock[userSelected] = 1) then fakeLockText$ = " (Fake Lock)"
	SetUsernameColorArray(sharedLocks[sharedLockSelected, 1].usersMainRole[userSelected], sharedLocks[sharedLockSelected, 1].usersMainRoleLevel[userSelected])
	OryUIUpdateText(updateUser.txtUsername, "text:" + sharedLocks[sharedLockSelected, 1].usersUsername$[userSelected] + fakeLockText$ + ";alignment:center;position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:" + str(usernameColor[0]) + "," + str(usernameColor[1]) + "," + str(usernameColor[2]) + "," + str(usernameColor[3]))
	OryUIUpdateSprite(updateUser.sprUsernameButton, "size:" + str(GetTextTotalWidth(updateUser.txtUsername)) + "," + str(GetTextTotalHeight(updateUser.txtUsername)) + ";offset:center;position:" + str(GetTextX(updateUser.txtUsername)) + "," + str(GetTextY(updateUser.txtUsername) + (GetTextTotalHeight(updateUser.txtUsername) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
	if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 1)
		OryUIPinSpriteToSprite(updateUser.sprTrustKeyholder, screen[screenNo].sprPage, 50 - (GetTextTotalWidth(updateUser.txtUsername) / 2.0) - ((GetSpriteWidth(updateUser.sprTrustKeyholder) + 1)), 2 + (GetTextTotalHeight(updateUser.txtUsername) / 2))			
	endif
	elementY# = elementY# + GetTextTotalHeight(updateUser.txtUsername)

	// VARIABLE LOCK
	if (sharedLocks[sharedLockSelected, 0].fixed = 0)
		if (redrawScreen = 1)
			OryUIUpdateText(updateUser.txtGreensRequiredToUnlock, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:41,128,185,255")
		endif
		if (sharedLocks[sharedLockSelected, 0].multipleGreensRequired = 0)
			if (sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected] = 1)
				OryUIUpdateText(updateUser.txtGreensRequiredToUnlock, "text:User needs to find 1 green card to unlock")
			else
				OryUIUpdateText(updateUser.txtGreensRequiredToUnlock, "text:User needs to find 1 of " + str(sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected]) + " green cards to unlock")
			endif
		else
			if (sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersGreenCardsPicked[userSelected] + sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected] = 1)
				OryUIUpdateText(updateUser.txtGreensRequiredToUnlock, "text:User needs to find 1 green card to unlock")
			else
				OryUIUpdateText(updateUser.txtGreensRequiredToUnlock, "text:User needs to find all green cards to unlock")
			endif
		endif
		elementY# = elementY# + GetTextTotalHeight(updateUser.txtGreensRequiredToUnlock) + 1

		// Position cards
		if (redrawScreen = 1)
			cardXPos# as float
			cardYPos# as float
			for i = 1 to 11
				if (i = 1 or i = 4 or i = 7) then cardXPos# = 20
				if (i = 2 or i = 5 or i = 8) then cardXPos# = 50
				if (i = 3 or i = 6 or i = 9) then cardXPos# = 80
				if (i = 10) then cardXPos# = 35
				if (i = 11) then cardXPos# = 65
				if (i >= 1 and i <= 3) then cardYPos# = elementY#
				if (i >= 4 and i <= 6) then cardYPos# = elementY# + (GetSpriteHeight(updateUser.sprCard[i]) + 12)
				if (i >= 7 and i <= 9) then cardYPos# = elementY# + ((GetSpriteHeight(updateUser.sprCard[i]) + 12) * 2)
				if (i >= 10 and i <= 12) then cardYPos# = elementY# + ((GetSpriteHeight(updateUser.sprCard[i]) + 12) * 3)
				OryUIUpdateSprite(updateUser.sprCard[i], "position:" + str((screenNo * 100) + cardXPos#) + "," + str(cardYPos#) + ";offset:" + str(GetSpriteWidth(updateUser.sprCard[i]) / 2) + ",0")
				OryUIUpdateText(updateUser.txtCardModifiedBy[i], "position:" + str(GetSpriteXByOffset(updateUser.sprCard[i])) + "," + str(cardYPos# + GetSpriteHeight(updateUser.sprCard[i]) + 0.25) + ";color:192,57,43,255")
				OryUIUpdateInputSpinner(updateUser.spinCardCount[i], "position:" + str((screenNo * 100) + cardXPos# - (OryUIGetInputSpinnerWidth(updateUser.spinCardCount[i]) / 2)) + "," + str(cardYPos# + GetSpriteHeight(updateUser.sprCard[i]) + 3) + ";backgroundColorID:" + str(colorMode[colorModeSelected].pageColor) + ";activeButtonColorID:" + str(theme[themeSelected].color[3]) + ";activeIconColor:255,255,255,255;inactiveButtonColorID:" + str(theme[themeSelected].color[3]) + ";inactiveIconColor:255,255,255,64;textColorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIUpdateText(updateUser.txtCardPercentage[i], "text: ;position:" + str(GetSpriteXByOffset(updateUser.sprCard[i])) + "," + str(OryUIGetInputSpinnerY(updateUser.spinCardCount[i]) + OryUIGetInputSpinnerHeight(updateUser.spinCardCount[i]) + 0.25) + ";color:41,128,185,255")
				OryUIUpdateText(updateUser.txtCardPickedCount[i], "position:" + str(GetSpriteXByOffset(updateUser.sprCard[i])) + "," + str(GetTextY(updateUser.txtCardPercentage[i]) + GetTextTotalHeight(updateUser.txtCardPercentage[i])) + ";color:22,160,133,255")
				if (i = 1)
					defaultCardCount as integer : defaultCardCount = sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected]
					minCardCount as integer : minCardCount = 1
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 220)
						maxCardCount as integer : maxCardCount = cappedGreenCards - sharedLocks[sharedLockSelected, 1].usersGreenCardsPicked[userSelected]
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0 and sharedLocks[sharedLockSelected, 0].multipleGreensRequired = 1)
							maxCardCount = defaultCardCount + 1
							if (maxCardCount > cappedGreenCards) then maxCardCount = cappedGreenCards
						endif
					elseif (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = 30 - sharedLocks[sharedLockSelected, 1].usersGreenCardsPicked[userSelected]
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0 and sharedLocks[sharedLockSelected, 0].multipleGreensRequired = 1)
							maxCardCount = defaultCardCount + 1
							if (maxCardCount > 30) then maxCardCount = 30
						endif
					else
						maxCardCount = 20 - sharedLocks[sharedLockSelected, 1].usersGreenCardsPicked[userSelected]
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0 and sharedLocks[sharedLockSelected, 0].multipleGreensRequired = 1)
							maxCardCount = defaultCardCount + 1
							if (maxCardCount > 20) then maxCardCount = 20
						endif
					endif
				elseif (i = 2)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedRedCards
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 7
						endif
						if (maxCardCount > cappedRedCards) then maxCardCount = cappedRedCards
					else
						maxCardCount = 399
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 7
						endif
						if (maxCardCount > 399) then maxCardCount = 399
					endif
				elseif (i = 3)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersStickyCards[userSelected]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 220)
						maxCardCount = cappedStickyCards
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > cappedStickyCards) then maxCardCount = cappedStickyCards
					elseif (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 203)
						maxCardCount = 30
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > 30) then maxCardCount = 30
					else
						maxCardCount = defaultCardCount
					endif
				elseif (i = 4)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 1]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedYellowCardsEachType
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > cappedYellowCardsEachType) then maxCardCount = cappedYellowCardsEachType
					else
						maxCardCount = 199
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > 199) then maxCardCount = 199
					endif
				elseif (i = 5)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 2]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedYellowCardsEachType
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > cappedYellowCardsEachType) then maxCardCount = cappedYellowCardsEachType
					else
						maxCardCount = 199
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > 199) then maxCardCount = 199
					endif
				elseif (i = 6)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 3]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedYellowCardsEachType
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > cappedYellowCardsEachType) then maxCardCount = cappedYellowCardsEachType
					else
						maxCardCount = 199
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > 199) then maxCardCount = 199
					endif
				elseif (i = 7)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 4]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedYellowCardsEachType
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > cappedYellowCardsEachType) then maxCardCount = cappedYellowCardsEachType
					else
						maxCardCount = 199
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > 199) then maxCardCount = 199
					endif
				elseif (i = 8)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 5]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = cappedYellowCardsEachType
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > cappedYellowCardsEachType) then maxCardCount = cappedYellowCardsEachType
					else
						maxCardCount = 199
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount + 3
						endif
						if (maxCardCount > 199) then maxCardCount = 199
					endif
				elseif (i = 9)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersFreezeCards[userSelected]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 220)
						maxCardCount = cappedFreezeCards
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > cappedFreezeCards) then maxCardCount = cappedFreezeCards
					elseif (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = 30
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > 30) then maxCardCount = 30
					else
						maxCardCount = 20
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > 20) then maxCardCount = 20
					endif
				elseif (i = 10)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[userSelected]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 220)
						maxCardCount = cappedDoubleUpCards
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > cappedDoubleUpCards) then maxCardCount = cappedDoubleUpCards
					elseif (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = 30
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > 30) then maxCardCount = 30
					else
						maxCardCount = 20
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif
						if (maxCardCount > 20) then maxCardCount = 20
					endif
				elseif (i = 11)
					defaultCardCount = sharedLocks[sharedLockSelected, 1].usersResetCards[userSelected]
					minCardCount = 0
					if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 220)
						maxCardCount = cappedResetCards
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif		
						if (maxCardCount > cappedResetCards) then maxCardCount = cappedResetCards		
					elseif (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 166)
						maxCardCount = 30
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif		
						if (maxCardCount > 30) then maxCardCount = 30		
					else
						maxCardCount = 20
						if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
							maxCardCount = defaultCardCount
						endif		
						if (maxCardCount > 20) then maxCardCount = 20		
					endif
				endif
				OryUIUpdateInputSpinner(updateUser.spinCardCount[i], "defaultValue:" + str(defaultCardCount) + ";min:" + str(minCardCount) + ";max:" + str(maxCardCount))
			next
		endif
		for i = 1 to 11
			OryUIInsertInputSpinnerListener(updateUser.spinCardCount[i])
			cardCountModifiedBy as integer
			if (i = 1)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected] = cardCountModifiedBy
			elseif (i = 2)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = cardCountModifiedBy
			elseif (i = 3)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersStickyCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersStickyCardsModifiedBy[userSelected] = cardCountModifiedBy
			elseif (i = 4)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 1]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 1] = cardCountModifiedBy
			elseif (i = 5)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 2]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 2] = cardCountModifiedBy
			elseif (i = 6)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 3]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 3] = cardCountModifiedBy
			elseif (i = 7)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 4]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 4] = cardCountModifiedBy
			elseif (i = 8)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 5]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 5] = cardCountModifiedBy
			elseif (i = 9)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersFreezeCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersFreezeCardsModifiedBy[userSelected] = cardCountModifiedBy
			elseif (i = 10)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersDoubleUpCardsModifiedBy[userSelected] = cardCountModifiedBy
			elseif (i = 11)
				defaultCardCount = sharedLocks[sharedLockSelected, 1].usersResetCards[userSelected]
				cardCountModifiedBy = OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) - defaultCardCount
				sharedLocks[sharedLockSelected, 1].usersResetCardsModifiedBy[userSelected] = cardCountModifiedBy
			endif
			if (cardCountModifiedBy < 0)
				OryUIUpdateText(updateUser.txtCardModifiedBy[i], "text:Removing " + str(abs(cardCountModifiedBy), 0))
			elseif (cardCountModifiedBy > 0)
				OryUIUpdateText(updateUser.txtCardModifiedBy[i], "text:Adding " + str(cardCountModifiedBy, 0))
			else
				OryUIUpdateText(updateUser.txtCardModifiedBy[i], "text: ")
			endif
			// Calculate the chance of finding each card
			totalCards# = 0
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersGreenCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersStickyCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersStickyCardsModifiedBy[userSelected]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 1] + sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 1]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 2] + sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 2]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 3] + sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 3]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 4] + sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 4]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[userSelected, 5] + sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 5]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersFreezeCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersFreezeCardsModifiedBy[userSelected]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersDoubleUpCardsModifiedBy[userSelected]
			totalCards# = totalCards# + sharedLocks[sharedLockSelected, 1].usersResetCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersResetCardsModifiedBy[userSelected]
			cardPercentage$ as string : cardPercentage$ = str(((OryUIGetInputSpinnerInteger(updateUser.spinCardCount[i]) * 1.00) / totalCards#) * 100.0, 2)
			OryUIUpdateText(updateUser.txtCardPercentage[i], "text:" + cardPercentage$ + "%")
			if (i = 1) then OryUIUpdateText(updateUser.txtCardPickedCount[i], "text:" + str(sharedLocks[sharedLockSelected, 1].usersGreenCardsPicked[userSelected]) + " found")
		next
		elementY# = elementY# + GetSpriteY(updateUser.sprCard[10]) + GetSpriteHeight(updateUser.sprCard[i]) + 3
	
		// Check if any modifications have been made
		modifiedLock as integer : modifiedLock = 0
		if (sharedLocks[sharedLockSelected, 1].usersGreenCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersStickyCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 1] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 2] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 3] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 4] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersYellowCardsModifiedBy[userSelected, 5] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersFreezeCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersDoubleUpCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (sharedLocks[sharedLockSelected, 1].usersResetCardsModifiedBy[userSelected] <> 0) then modifiedLock = 1
		if (modifiedLock = 1)
			fakeUpdate = 0
			OryUIShowFloatingActionButton(fabUpdateUser)
		endif	
	endif
	
	circleOffset# as float
	// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].regularity# >= 0.25)
		if (redrawScreen = 1)
			OryUIUpdateText(updateUser.txtModifiedBy, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,43,255")
		endif
		elementY# = elementY# + GetTextTotalHeight(updateUser.txtModifiedBy) + 3

		if (redrawScreen = 1)
			circleOffset# = 23
			OryUIUpdateSprite(updateUser.sprCircle[1], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[1]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 0.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[2], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[2]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 1.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[3], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[3]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 2.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[4], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[3]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 3.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
		
			OryUIUpdateText(updateUser.txtCircle[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[1], updateUser.sprCircle[1], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[2], updateUser.sprCircle[2], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[3], updateUser.sprCircle[3], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[4], updateUser.sprCircle[4], 0, 0)
			
			OryUIUpdateText(updateUser.txtCircleFooter[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[1], updateUser.sprCircle[1], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[2], updateUser.sprCircle[2], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[3], updateUser.sprCircle[3], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[4], updateUser.sprCircle[4], 0, -2.5)

			if (sharedLocks[sharedLockSelected, 0].regularity# <= 24) then OryUIUpdateButton(updateUser.btnAdd[1], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[1])) + "," + str(GetSpriteY(updateUser.sprCircle[1])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 1) then OryUIUpdateButton(updateUser.btnAdd[2], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[2])) + "," + str(GetSpriteY(updateUser.sprCircle[2])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 0.25) then OryUIUpdateButton(updateUser.btnAdd[3], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[3])) + "," + str(GetSpriteY(updateUser.sprCircle[3])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
		
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 24) then OryUIUpdateButton(updateUser.btnMinus[1], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[1])) + "," + str(GetSpriteY(updateUser.sprCircle[1]) + GetSpriteHeight(updateUser.sprCircle[1])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 1) then OryUIUpdateButton(updateUser.btnMinus[2], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[2])) + "," + str(GetSpriteY(updateUser.sprCircle[2]) + GetSpriteHeight(updateUser.sprCircle[2])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 0.25) then OryUIUpdateButton(updateUser.btnMinus[3], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[3])) + "," + str(GetSpriteY(updateUser.sprCircle[3]) + GetSpriteHeight(updateUser.sprCircle[3])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
		endif
		
		if (OryUIGetButtonHeld(updateUser.btnAdd[1]) or OryUIGetButtonReleased(updateUser.btnAdd[1]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 96
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 24
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnAdd[2]) or OryUIGetButtonReleased(updateUser.btnAdd[2]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 4
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnAdd[3]) or OryUIGetButtonReleased(updateUser.btnAdd[3]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] + 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[1]) or OryUIGetButtonReleased(updateUser.btnMinus[1]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 96
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 24
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[2]) or OryUIGetButtonReleased(updateUser.btnMinus[2]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 4
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[3]) or OryUIGetButtonReleased(updateUser.btnMinus[3]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] - 1
		endif
		
		if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (900 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (3600 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (86400 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - timestampNow
		else
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (900 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[userSelected]
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (3600 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[userSelected]
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (86400 * (sharedLocks[sharedLockSelected, 1].usersRedCards[userSelected] + sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]))) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[userSelected]
		endif
		
		dd = floor(secondsLeft / 60 / 60 / 24)
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		
		// Disable/enable buttons
		OryUIEnableButton(updateUser.btnAdd[1])
		OryUIEnableButton(updateUser.btnAdd[2])
		OryUIEnableButton(updateUser.btnAdd[3])
		OryUIEnableButton(updateUser.btnMinus[1])
		OryUIEnableButton(updateUser.btnMinus[2])
		OryUIEnableButton(updateUser.btnMinus[3])
		if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25)
				OryUIDisableButton(updateUser.btnAdd[1])
				if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] >= 4) then OryUIDisableButton(updateUser.btnAdd[2])
				if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] >= 7) then OryUIDisableButton(updateUser.btnAdd[3])
			endif
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1)
				OryUIDisableButton(updateUser.btnAdd[1])
				if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] >= 7) then OryUIDisableButton(updateUser.btnAdd[2])
				OryUIDisableButton(updateUser.btnAdd[3])
			endif
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24)
				if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] >= 7) then OryUIDisableButton(updateUser.btnAdd[1])
				OryUIDisableButton(updateUser.btnAdd[2])
				OryUIDisableButton(updateUser.btnAdd[3])
			endif
		endif
		if (dd >= 399) then OryUIDisableButton(updateUser.btnAdd[1])
		if (hh >= 23 and dd >= 399) then OryUIDisableButton(updateUser.btnAdd[2])
		if (mm >= 59 and hh >= 23 and dd >= 399) then OryUIDisableButton(updateUser.btnAdd[3])
		if (dd <= 0) then OryUIDisableButton(updateUser.btnMinus[1])
		if (hh <= 0 and dd <= 0) then OryUIDisableButton(updateUser.btnMinus[2])
		if (mm <= 0 and hh <= 0 and dd <= 0) then OryUIDisableButton(updateUser.btnMinus[3])
		
		if (secondsLeft > 0 and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] > 0)
				if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Adding " + lower(ConvertMinutesToText(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] * 15, 1)))
				if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Adding " + lower(ConvertMinutesToText(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] * 60, 1)))
				if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Adding " + lower(ConvertMinutesToText(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] * 1440, 1)))
				fakeUpdate = 0
				OryUIShowFloatingActionButton(fabUpdateUser)
			elseif (sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected] < 0)
				if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Deducting " + lower(ConvertMinutesToText(abs(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]) * 15, 1)))
				if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Deducting " + lower(ConvertMinutesToText(abs(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]) * 60, 1)))
				if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then OryUIUpdateText(updateUser.txtModifiedBy, "text:Deducting " + lower(ConvertMinutesToText(abs(sharedLocks[sharedLockSelected, 1].usersRedCardsModifiedBy[userSelected]) * 1440, 1)))
				fakeUpdate = 0
				OryUIShowFloatingActionButton(fabUpdateUser)
			else
				OryUIUpdateText(updateUser.txtModifiedBy, "text: ")	
			endif
			OryUIUpdateText(updateUser.txtCircle[1], "text:" + str(dd))
			OryUIUpdateText(updateUser.txtCircle[2], "text:" + str(hh))
			OryUIUpdateText(updateUser.txtCircle[3], "text:" + str(mm))
			OryUIUpdateText(updateUser.txtCircle[4], "text:" + str(ss))	
		else
			// lock ended so can't be updated anymore
			previousBreadcrumb = GetPreviousBreadcrumb()
			RemoveLastBreadcrumb()
			SetScreenToView(constManageLockedUsersScreen)
		endif
		elementY# = elementY# + GetSpriteHeight(updateUser.sprCircle[1]) + 4		
	endif
	
	// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
		if (redrawScreen = 1)
			OryUIUpdateText(updateUser.txtModifiedBy, "position:" + str((screenNo * 100) + 50) + "," + str(elementY#) + ";color:192,57,43,255")
		endif
		elementY# = elementY# + GetTextTotalHeight(updateUser.txtModifiedBy) + 3

		if (redrawScreen = 1)
			circleOffset# = 23
			OryUIUpdateSprite(updateUser.sprCircle[1], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[1]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 0.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[2], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[2]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 1.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[3], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[3]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 2.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
			OryUIUpdateSprite(updateUser.sprCircle[4], "offset:" + str(GetSpriteWidth(updateUser.sprCircle[3]) / 2) + ",0;position:" + str((screenNo * 100) + 4 + (circleOffset# * 3.5)) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
		
			OryUIUpdateText(updateUser.txtCircle[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircle[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[1], updateUser.sprCircle[1], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[2], updateUser.sprCircle[2], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[3], updateUser.sprCircle[3], 0, 0)
			OryUIPinTextToCentreOfSprite(updateUser.txtCircle[4], updateUser.sprCircle[4], 0, 0)
			
			OryUIUpdateText(updateUser.txtCircleFooter[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateText(updateUser.txtCircleFooter[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[1], updateUser.sprCircle[1], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[2], updateUser.sprCircle[2], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[3], updateUser.sprCircle[3], 0, -2.5)
			OryUIPinTextToBottomCentreOfSprite(updateUser.txtCircleFooter[4], updateUser.sprCircle[4], 0, -2.5)
			
			OryUIUpdateButton(updateUser.btnAdd[1], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[1])) + "," + str(GetSpriteY(updateUser.sprCircle[1])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			OryUIUpdateButton(updateUser.btnAdd[2], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[2])) + "," + str(GetSpriteY(updateUser.sprCircle[2])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			OryUIUpdateButton(updateUser.btnAdd[3], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[3])) + "," + str(GetSpriteY(updateUser.sprCircle[3])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			
			OryUIUpdateButton(updateUser.btnMinus[1], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[1])) + "," + str(GetSpriteY(updateUser.sprCircle[1]) + GetSpriteHeight(updateUser.sprCircle[1])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			OryUIUpdateButton(updateUser.btnMinus[2], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[2])) + "," + str(GetSpriteY(updateUser.sprCircle[2]) + GetSpriteHeight(updateUser.sprCircle[2])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
			OryUIUpdateButton(updateUser.btnMinus[3], "position:" + str(GetSpriteXByOffset(updateUser.sprCircle[3])) + "," + str(GetSpriteY(updateUser.sprCircle[3]) + GetSpriteHeight(updateUser.sprCircle[3])) + ";colorID:" + str(theme[themeSelected].color[3]) + ";enabledIconColor:255,255,255,255;disabledIconColor:255,255,255,64")
		endif
		
		if (OryUIGetButtonHeld(updateUser.btnAdd[1]) or OryUIGetButtonReleased(updateUser.btnAdd[1]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 1440
		endif
		if (OryUIGetButtonHeld(updateUser.btnAdd[2]) or OryUIGetButtonReleased(updateUser.btnAdd[2]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 60
		endif
		if (OryUIGetButtonHeld(updateUser.btnAdd[3]) or OryUIGetButtonReleased(updateUser.btnAdd[3]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 1
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[1]) or OryUIGetButtonReleased(updateUser.btnMinus[1]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] - 1440
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[2]) or OryUIGetButtonReleased(updateUser.btnMinus[2]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] - 60
		endif
		if (OryUIGetButtonHeld(updateUser.btnMinus[3]) or OryUIGetButtonReleased(updateUser.btnMinus[3]))
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] = sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] - 1
		endif
		
		if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (60 * (sharedLocks[sharedLockSelected, 1].usersMinutes[userSelected] + sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected]))) - timestampNow
		else
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[userSelected] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[userSelected] + (60 * (sharedLocks[sharedLockSelected, 1].usersMinutes[userSelected] + sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected]))) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[userSelected]
		endif

		dd = floor(secondsLeft / 60 / 60 / 24)
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		
		// Disable/enable buttons
		OryUIEnableButton(updateUser.btnAdd[1])
		OryUIEnableButton(updateUser.btnAdd[2])
		OryUIEnableButton(updateUser.btnAdd[3])
		OryUIEnableButton(updateUser.btnMinus[1])
		OryUIEnableButton(updateUser.btnMinus[2])
		OryUIEnableButton(updateUser.btnMinus[3])
		// If not trusted set the maximum number of minutes that can be added as 10% of maximum time
		if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[userSelected] = 0)
			maxUpdateMinutes as integer : maxUpdateMinutes = ceil((sharedLocks[sharedLockSelected, 0].maxRandomMinutes / 100) * 10)
			if (maxUpdateMinutes < 7) then maxUpdateMinutes = 7
			// Cap at 7 days
			if (maxUpdateMinutes > 10080) then maxUpdateMinutes = 10080
			if (sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 1440 > maxUpdateMinutes)
				OryUIDisableButton(updateUser.btnAdd[1])
			endif
			if (sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 60 > maxUpdateMinutes)
				OryUIDisableButton(updateUser.btnAdd[2])
			endif
			if (sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] + 1 > maxUpdateMinutes)
				OryUIDisableButton(updateUser.btnAdd[3])
			endif
		endif
		if (dd >= 399) then OryUIDisableButton(updateUser.btnAdd[1])
		if (hh >= 23 and dd >= 399) then OryUIDisableButton(updateUser.btnAdd[2])
		if (mm >= 59 and hh >= 23 and dd >= 399) then OryUIDisableButton(updateUser.btnAdd[3])
		if (dd <= 0) then OryUIDisableButton(updateUser.btnMinus[1])
		if (hh <= 0 and dd <= 0) then OryUIDisableButton(updateUser.btnMinus[2])
		if (mm <= 0 and hh <= 0 and dd <= 0) then OryUIDisableButton(updateUser.btnMinus[3])
		
		if (secondsLeft > 0 and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[userSelected] = 0)
			if (sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] > 0)
				OryUIUpdateText(updateUser.txtModifiedBy, "text:Adding " + lower(ConvertMinutesToText(sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected], 1)))
				fakeUpdate = 0
				OryUIShowFloatingActionButton(fabUpdateUser)
			elseif (sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected] < 0)
				OryUIUpdateText(updateUser.txtModifiedBy, "text:Deducting " + lower(ConvertMinutesToText(abs(sharedLocks[sharedLockSelected, 1].usersMinutesModifiedBy[userSelected]), 1)))
				fakeUpdate = 0
				OryUIShowFloatingActionButton(fabUpdateUser)
			else
				OryUIUpdateText(updateUser.txtModifiedBy, "text: ")	
			endif
			OryUIUpdateText(updateUser.txtCircle[1], "text:" + str(dd))
			OryUIUpdateText(updateUser.txtCircle[2], "text:" + str(hh))
			OryUIUpdateText(updateUser.txtCircle[3], "text:" + str(mm))
			OryUIUpdateText(updateUser.txtCircle[4], "text:" + str(ss))	
		else
			// lock ended so can't be updated anymore
			previousBreadcrumb = GetPreviousBreadcrumb()
			RemoveLastBreadcrumb()
			SetScreenToView(constManageLockedUsersScreen)
		endif
		elementY# = elementY# + GetSpriteHeight(updateUser.sprCircle[1]) + 4
	endif
	
	// HIDE UPDATE
	hideUpdate as integer : hideUpdate = 0
	if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 134)
		if (sharedLocks[sharedLockSelected, 1].usersTimerHidden[userSelected] = 1 or sharedLocks[sharedLockSelected, 1].usersCardInfoHidden[userSelected] = 1)
			if (redrawScreen = 1)
				OryUIUpdateTextCard(updateUser.crdHideUpdate, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";headerTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingTextColorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			elementY# = elementY# + OryUIGetTextCardHeight(updateUser.crdHideUpdate)
			if (redrawScreen = 1)	
				OryUIUpdateButtonGroup(updateUser.grpHideUpdate, "position:" + str((screenNo * 100) + 5) + "," + str(elementY#) + ";selectedColorID:" + str(colorMode[colorModeSelected].selectedButtonColor) + ";unselectedColorID:" + str(colorMode[colorModeSelected].unselectedButtonColor))
				if (sharedLocks[sharedLockSelected, 1].usersLastUpdateHidden[userSelected] = 0) then OryUISetButtonGroupItemSelectedByIndex(updateUser.grpHideUpdate, 1)
				if (sharedLocks[sharedLockSelected, 1].usersLastUpdateHidden[userSelected] = 1) then OryUISetButtonGroupItemSelectedByIndex(updateUser.grpHideUpdate, 1)
				if (sharedLocks[sharedLockSelected, 1].usersLastUpdateHidden[userSelected] = 2) then OryUISetButtonGroupItemSelectedByIndex(updateUser.grpHideUpdate, 2)
			endif
			elementY# = elementY# + OryUIGetButtonGroupHeight(updateUser.grpHideUpdate) + 2
			OryUIInsertButtonGroupListener(updateUser.grpHideUpdate)
			if (OryUIGetButtonGroupItemSelectedName(updateUser.grpHideUpdate) = "Yes")
				hideUpdate = 1
			endif
			if (OryUIGetButtonGroupItemSelectedName(updateUser.grpHideUpdate) = "No")
				hideUpdate = -1
			endif
		else
			OryUIUpdateTextCard(updateUser.crdHideUpdate, "position:-1000,-1000")
			OryUIUpdateButtonGroup(updateUser.grpHideUpdate, "position:-1000,-1000")
		endif
	else
		if (sharedLocks[sharedLockSelected, 1].usersTimerHidden[userSelected] = 1 or sharedLocks[sharedLockSelected, 1].usersCardInfoHidden[userSelected] = 1)
			hideUpdate = 1
		endif
		OryUIUpdateTextCard(updateUser.crdHideUpdate, "position:-1000,-1000")
		OryUIUpdateButtonGroup(updateUser.grpHideUpdate, "position:-1000,-1000")
	endif
	
	// FAKE UPDATE?
	if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 300 and hideUpdate = 1 and fakeUpdate = 1 and (sharedLocks[sharedLockSelected, 0].fixed = 0 or (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)))
		OryUIShowFloatingActionButton(fabUpdateUser)
	endif

	// UPDATE USER BUTTON
	if (redrawScreen = 1)
		OryUIUpdateFloatingActionButton(fabUpdateUser, "colorID:" + str(theme[themeSelected].color[3]))
	endif
	if (OryUIGetFloatingActionButtonReleased(fabUpdateUser))
		if (sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[userSelected] >= 300 and hideUpdate = 1 and fakeUpdate = 1 and (sharedLocks[sharedLockSelected, 0].fixed = 0 or (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)))
			OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Send Fake Update?;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:Because you've not made any changes do you want to send " + sharedLocks[sharedLockSelected, selectedManageUsersTab].usersUsername$[userSelected] + " an hidden and fake update? The update will appear like any other update on their side, but they won't know that no change has been made to the lock.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
			OryUISetDialogButtonCount(dialog, 2)
			OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:YesSendFakeUpdate;text:Yes;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIUpdateDialogButton(dialog, 2, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Cancel;text:Cancel;textColorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIShowDialog(dialog)
		else
			sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] = timestampNow
			if (sharedLocks[sharedLockSelected, 0].fixed = 0)
				UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedCards", hideUpdate, fakeUpdate, 1)
			else
				if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedTime", hideUpdate, fakeUpdate, 1)
				else
					UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedTimeOldVersion", hideUpdate, fakeUpdate, 1)
				endif
			endif
		endif
	endif
	if (OryUIGetDialogButtonReleasedByName(dialog, "YesSendFakeUpdate"))
		sharedLocks[sharedLockSelected, selectedManageUsersTab].usersTimestampLastUpdated[userSelected] = timestampNow
		if (sharedLocks[sharedLockSelected, 0].fixed = 0)
			UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedCards", hideUpdate, fakeUpdate, 1)
		else
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
				UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedTime", hideUpdate, fakeUpdate, 1)
			else
				UpdateUsersLock(sharedLockSelected, selectedManageUsersTab, userSelected, "action:KeyholderUpdate;actionedBy:Keyholder;result:UpdatedTimeOldVersion", hideUpdate, fakeUpdate, 1)
			endif
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
