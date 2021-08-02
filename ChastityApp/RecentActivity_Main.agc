
if (screenToView = constRecentActivityScreen)
	if (screenNo <> constRecentActivityScreen)
		filterRecentActivityByLabel$ as string : filterRecentActivityByLabel$ = ""
		iterationOffset = 0
		lastFilterCount = -1
	endif
	screenNo = constRecentActivityScreen
	
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
	if (lower(OryUIGetTopBarActionReleasedName(screen[screenNo].topBar)) = "refresh")
		GetRecentActivity(1)
		SetScreenToView(constRecentActivityScreen)
	endif
	elementY# = elementY# + OryUIGetTopBarHeight(screen[screenNo].topBar)
	
	// FILTER BAR
	OryUIUpdateSprite(sprFilterRecentActivityBar, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY#) + ";colorID:" + str(colorMode[colorModeSelected].barColor))
	OryUIUpdateButton(btnIconFilterRecentActivity, "position:" + str((screenNo * 100) + 2) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterRecentActivityBar) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor))
	OryUIUpdateButton(btnTextFilteredRecentActivityBy, "text:" + filterRecentActivityByLabel$ + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].barColor) + ";position:" + str(OryUIGetButtonX(btnIconFilterRecentActivity) + OryUIGetButtonWidth(btnIconFilterRecentActivity)) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterRecentActivityBar) / 2)))
	OryUIUpdateButton(btnRecentActivityReadAll, "text:Mark All Read;textColorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].backgroundColor) + ";position:" + str((screenNo * 100) + 98) + "," + str(GetViewOffsetY() + elementY# + (GetSpriteHeight(sprFilterMyLocksBar) / 2)))
	OryUIUpdateSprite(sprFilterRecentActivityBarShadow, "position:" + str(screenNo * 100) + "," + str(GetViewOffsetY() + elementY# + GetSpriteHeight(sprFilterRecentActivityBar)))
	elementY# = elementY# + GetSpriteHeight(sprFilterRecentActivityBar) //+ 2
	if (OryUIGetButtonReleased(btnRecentActivityReadAll))
		for i = 0 to OryUIGetListItemCount(listRecentActivity) - 1
			recentActivity[i].readActivity = 1
		next
		UpdateRecentActivityReadFlagForAll(1)
		SetScreenToView(constRecentActivityScreen)
	endif
	
	startScrollBarY# = elementY# + 1
	
	// PULL DOWN TO REFRESH
	if (PullDownToRefresh(screenNo, elementY#, elementY# + 10, GetSpriteHeight(sprPullToRefreshCircle)))
		GetRecentActivity(1)
		SetScreenToView(constRecentActivityScreen)
	endif
	
	// FILTER MENU
	if (redrawScreen = 1)
		OryUIUpdateMenu(menuFilterRecentActivity, "colorID:" + str(colorMode[colorModeSelected].menuColor))
	endif
	if (OryUIGetButtonReleased(btnIconFilterRecentActivity) or OryUIGetButtonReleased(btnTextFilteredRecentActivityBy))
		OryUISetMenuItemCount(menuFilterRecentActivity, 4)
		OryUIUpdateMenuItem(menuFilterRecentActivity, 1, "name:FilterRecentActivityAll;text:All;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterRecentActivity, 2, "name:FilterRecentActivityAsKeyholder;text:As Keyholder;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterRecentActivity, 3, "name:FilterRecentActivityAsLockee;text:As Lockee;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		OryUIUpdateMenuItem(menuFilterRecentActivity, 4, "name:FilterRecentActivityFollows;text:Follows;rightIconID:" + str(imgBlank) + ";colorID:" + str(colorMode[colorModeSelected].menuColor) + ";textColorID:" + str(colorMode[colorModeSelected].textColor) + ";rightIconID:" + str(imgBlank) + ";rightIconColoriD:" + str(colorMode[colorModeSelected].textColor))
		if (filterRecentActivityBy$ = "FilterRecentActivityAll") then OryUIUpdateMenuItem(menuFilterRecentActivity, 1, "rightIconID:" + str(imgTickIcon))
		if (filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder") then OryUIUpdateMenuItem(menuFilterRecentActivity, 2, "rightIconID:" + str(imgTickIcon))
		if (filterRecentActivityBy$ = "FilterRecentActivityAsLockee") then OryUIUpdateMenuItem(menuFilterRecentActivity, 3, "rightIconID:" + str(imgTickIcon))
		if (filterRecentActivityBy$ = "FilterRecentActivityFollows") then OryUIUpdateMenuItem(menuFilterRecentActivity, 4, "rightIconID:" + str(imgTickIcon))
		OryUIShowMenu(menuFilterRecentActivity, OryUIGetButtonX(btnIconFilterRecentActivity), OryUIGetButtonY(btnIconFilterRecentActivity) + OryUIGetButtonHeight(btnIconFilterRecentActivity))
	endif
	OryUIInsertMenuListener(menuFilterRecentActivity)
	if (OryUIGetMenuItemReleasedName(menuFilterRecentActivity) = "FilterRecentActivityAll" or filterRecentActivityBy$ = "FilterRecentActivityAll")
		filterRecentActivityBy$ = "FilterRecentActivityAll"
		filterRecentActivityByLabel$ = "All"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterRecentActivity) = "FilterRecentActivityAsKeyholder" or filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder")
		filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder"
		filterRecentActivityByLabel$ = "As Keyholder"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterRecentActivity) = "FilterRecentActivityAsLockee" or filterRecentActivityBy$ = "FilterRecentActivityAsLockee")
		filterRecentActivityBy$ = "FilterRecentActivityAsLockee"
		filterRecentActivityByLabel$ = "As Lockee"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterRecentActivity) = "FilterRecentActivityFollows" or filterRecentActivityBy$ = "FilterRecentActivityFollows")
		filterRecentActivityBy$ = "FilterRecentActivityFollows"
		filterRecentActivityByLabel$ = "Follows"
	endif
	if (OryUIGetMenuItemReleasedName(menuFilterRecentActivity) <> "")
		SaveLocalVariable("filterRecentActivityBy", filterRecentActivityBy$)
		SetScreenToView(constRecentActivityScreen)
	endif
	
	// SORT RECENT ACTIVITY
	if (redrawScreen = 1)
		SortRecentActivity()
		contentHeightChanged = 1
	endif
	
	// PAGE
	if (redrawScreen = 1)
		OryUIUpdateSprite(screen[screenNo].sprPage, "position:" + str((screenNo * 100) + 3) + "," + str(elementY#) + ";alpha:0")
	endif
	
	// NO RECENT ACTIVITY
	if (filterCount = 0)
		OryUIUpdateButton(btnRecentActivityReadAll, "position:-1000,-1000")
		OryUIUpdateText(txtNoRecentActivity, "text:No Recent Activity (Last 7 Days);position:" + str((screenNo * 100) + 50) + "," + str(elementY# + 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	else
		OryUIUpdateText(txtNoRecentActivity, "position:-1000,-1000")
	endif
	
	// RECENT ACTIVITY LIST
	if (redrawScreen = 1)
		OryUIUpdateList(listRecentActivity, "position:" + str(screenNo * 100) + "," + str(elementY#) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		startListY# = elementY#
	endif
	listItemHeight# = 8.0
	maxListItemCount = ceil(100.0 / listItemHeight#) + 4
	if (lastFilterCount <> filterCount)
		if (filterCount >= maxListItemCount)
			OryUISetListItemCount(listRecentActivity, maxListItemCount)
		else
			OryUISetListItemCount(listRecentActivity, filterCount)
		endif
		lastFilterCount = filterCount
	endif
	iterationOffset = floor((GetViewOffsetY() - startListY#) / listItemHeight#)
	if (iterationOffset + maxListItemCount > filterCount) then iterationOffset = filterCount - maxListItemCount
	if (iterationOffset < 0) then iterationOffset = 0
	OryUIUpdateList(listRecentActivity, "y:" + str(startListY# + (iterationOffset * listItemHeight#)))
	OryUIInsertListListener(listRecentActivity)
	for i = 0 to maxListItemCount - 1

		if (i <= OryUIGetListItemCount(listRecentActivity) - 1)
			if (recentActivitySorted.length >= 0)
				sortedIteration = recentActivitySorted[i + iterationOffset].iteration
				
				activityActionedWhen$ as string
				line1$ = ""
				line2$ = ""
				noOfLeftLines = 1
				secondsSinceActivity as integer
					
				if (recentActivity[sortedIteration].shareID$ <> "") then sharedLockName$ = ReturnSharedLockName(recentActivity[sortedIteration].shareID$)
				
				if (recentActivity[sortedIteration].activityType$ = "KeyholderUnlockedLock")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " unlocked your lock"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						if (recentActivity[sortedIteration].shareID$ = "BOT01" or recentActivity[sortedIteration].shareID$ = "BOT02" or recentActivity[sortedIteration].shareID$ = "BOT03" or recentActivity[sortedIteration].shareID$ = "BOT04")
							line2$ = "Bot Lock"
						else
							line2$ = recentActivity[sortedIteration].shareID$
						endif
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif
				if (recentActivity[sortedIteration].activityType$ = "KeyholderUpdatedLock")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " updated your lock"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						if (recentActivity[sortedIteration].shareID$ = "BOT01" or recentActivity[sortedIteration].shareID$ = "BOT02" or recentActivity[sortedIteration].shareID$ = "BOT03" or recentActivity[sortedIteration].shareID$ = "BOT04")
							line2$ = "Bot Lock"
						else
							line2$ = recentActivity[sortedIteration].shareID$
						endif
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif
				if (recentActivity[sortedIteration].activityType$ = "LoadedSharedLock")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " loaded your lock"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						line2$ = recentActivity[sortedIteration].shareID$
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif
				if (recentActivity[sortedIteration].activityType$ = "LockeeAbandonedLock")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " abandoned your lock"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						line2$ = recentActivity[sortedIteration].shareID$
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif
				if (recentActivity[sortedIteration].activityType$ = "LockeeFinishedLock")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " finished your lock"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						line2$ = recentActivity[sortedIteration].shareID$
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif
				if (recentActivity[sortedIteration].activityType$ = "NewFollow")
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " followed you"
				endif
				if (recentActivity[sortedIteration].activityType$ = "NewFollowRequest")
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " wants to follow you"
				endif
				if (recentActivity[sortedIteration].activityType$ = "RequestKeyholdersDecision")
					noOfLeftLines = 2
					line1$ = recentActivity[sortedIteration].mentionedUsername$ + " wants your decision"
					if (sharedLockName$ <> "")
						line2$ = sharedLockName$
					else
						line2$ = recentActivity[sortedIteration].shareID$
					endif
					if (recentActivity[sortedIteration].testLock = 1) then line2$ = line2$ + " | TEST LOCK"
				endif

				secondsSinceActivity = timestampNow - recentActivity[sortedIteration].timestamp
				if (floor(secondsSinceActivity / 60 / 60 / 24) >= 1)
					activityActionedWhen$ = str(floor(secondsSinceActivity / 60 / 60 / 24)) + "d"
				elseif (floor(secondsSinceActivity / 60 / 60) >= 1)
					activityActionedWhen$ = str(floor(secondsSinceActivity / 60 / 60)) + "h"
				elseif (floor(secondsSinceActivity / 60) >= 1)
					activityActionedWhen$ = str(floor(secondsSinceActivity / 60)) + "m"
				else
					activityActionedWhen$ = str(secondsSinceActivity) + "s"
				endif
					
				textColor$ = str(GetColorRed(colorMode[colorModeSelected].textColor)) + "," + str(GetColorGreen(colorMode[colorModeSelected].textColor)) + "," + str(GetColorBlue(colorMode[colorModeSelected].textColor))
				textBoldParameter$ as string
				if (recentActivity[sortedIteration].readActivity = 0)
					textBoldParameter$ = "leftLine1TextBold:true;leftLine2TextBold:true"
				else
					textBoldParameter$ = "leftLine1TextBold:false;leftLine2TextBold:false"
				endif
				OryUIUpdateListItem(listRecentActivity, i, "colorID:" + str(colorMode[colorModeSelected].pageColor) + ";leftThumbnailImage:" + str(leftImageID) + ";leftLine1Text:" + line1$ + ";leftLine1TextSize:2.8;leftLine1TextColor:" + textColor$ + ",255;leftLine2Text:" + line2$ + ";leftLine2TextSize:2.6;leftLine2TextColor:" + textColor$ + ",150;" + textBoldParameter$ + ";rightLine1Text:" + activityActionedWhen$ + "      ;rightLine1TextSize:2.5;rightLine1TextColor:" + textColor$ + ",130;rightIconID:" + str(OryUIReturnIconID("keyboard_arrow_right")) + ";rightIconColor:" + textColor$ + ",130;noOfLeftLines:" + str(noOfLeftLines))
			
				if (OryUIGetSwipingVertically() = 0)
					//if (OryUIGetListItemReleased(listRecentActivity) = i)
					if (OryUIGetSpriteReleased() = OryUIListCollection[listRecentActivity].sprItemContainer[i])
						recentActivity[sortedIteration].readActivity = 1
						UpdateRecentActivityReadFlag(recentActivity[sortedIteration].id, 1)
						if (recentActivity[sortedIteration].activityType$ = "KeyholderUnlockedLock")
							searchStringFromPreviousScreen$ = recentActivity[sortedIteration].lockID$
							//previousBreadcrumb = GetPreviousBreadcrumb()
							//RemoveLastBreadcrumb()
							SetScreenToView(constMyLocksScreen)
						endif
						if (recentActivity[sortedIteration].activityType$ = "KeyholderUpdatedLock")
							searchStringFromPreviousScreen$ = recentActivity[sortedIteration].lockID$
							//previousBreadcrumb = GetPreviousBreadcrumb()
							//RemoveLastBreadcrumb()
							SetScreenToView(constMyLocksScreen)
						endif
						if (recentActivity[sortedIteration].activityType$ = "LoadedSharedLock")
							usersPageNo = 1
							sharedLockSelected = -1
							for i = 0 to sharedLocks.length
								if (sharedLocks[i, 0].shareID$ = recentActivity[sortedIteration].shareID$)
									sharedLockSelected = i
									sharedLocksSearchString$ = recentActivity[sortedIteration].mentionedUsername$
									GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
									//previousBreadcrumb = GetPreviousBreadcrumb()
									//RemoveLastBreadcrumb()
									SetScreenToView(constManageLockedUsersScreen)
									exit
								endif
							next
							if (sharedLockSelected = -1)
								OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Not Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The shared lock was not found. This might be a lock that you have since deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(dialog, 1)
								OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(dialog)
							endif
						endif
						if (recentActivity[sortedIteration].activityType$ = "LockeeAbandonedLock")
							usersPageNo = 1
							sharedLockSelected = -1
							for i = 0 to sharedLocks.length
								if (sharedLocks[i, 0].shareID$ = recentActivity[sortedIteration].shareID$)
									sharedLockSelected = i
									sharedLocksSearchString$ = recentActivity[sortedIteration].mentionedUsername$
									GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 3, 1)
									//previousBreadcrumb = GetPreviousBreadcrumb()
									//RemoveLastBreadcrumb()
									SetScreenToView(constManageDesertedUsersScreen)
									exit
								endif
							next
							if (sharedLockSelected = -1)
								OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Not Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The shared lock was not found. This might be a lock that you have since deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(dialog, 1)
								OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(dialog)
							endif
						endif
						if (recentActivity[sortedIteration].activityType$ = "LockeeFinishedLock")
							usersPageNo = 1
							sharedLockSelected = -1
							for i = 0 to sharedLocks.length
								if (sharedLocks[i, 0].shareID$ = recentActivity[sortedIteration].shareID$)
									sharedLockSelected = i
									sharedLocksSearchString$ = recentActivity[sortedIteration].mentionedUsername$
									GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 2, 1)
									//previousBreadcrumb = GetPreviousBreadcrumb()
									//RemoveLastBreadcrumb()
									SetScreenToView(constManageUnlockedUsersScreen)
									exit
								endif
							next
							if (sharedLockSelected = -1)
								OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Not Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The shared lock was not found. This might be a lock that you have since deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(dialog, 1)
								OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(dialog)
							endif
						endif
						if (recentActivity[sortedIteration].activityType$ = "NewFollow")
							GetYourRelations(1)
							searchStringFromPreviousScreen$ = recentActivity[sortedIteration].mentionedUsername$
							//previousBreadcrumb = GetPreviousBreadcrumb()
							//RemoveLastBreadcrumb()
							SetScreenToView(constYourFollowersListScreen)
						endif
						if (recentActivity[sortedIteration].activityType$ = "NewFollowRequest")
							GetYourRelations(1)
							searchStringFromPreviousScreen$ = recentActivity[sortedIteration].mentionedUsername$
							//previousBreadcrumb = GetPreviousBreadcrumb()
							//RemoveLastBreadcrumb()
							SetScreenToView(constYourFollowRequestsListScreen)
						endif
						if (recentActivity[sortedIteration].activityType$ = "RequestKeyholdersDecision")
							usersPageNo = 1
							sharedLockSelected = -1
							for i = 0 to sharedLocks.length
								if (sharedLocks[i, 0].shareID$ = recentActivity[sortedIteration].shareID$)
									sharedLockSelected = i
									sharedLocksSearchString$ = recentActivity[sortedIteration].mentionedUsername$
									GetSharedLockUsersData(sharedLocks[sharedLockSelected, 0].shareID$, 1, 1)
									//previousBreadcrumb = GetPreviousBreadcrumb()
									//RemoveLastBreadcrumb()
									SetScreenToView(constManageLockedUsersScreen)
									exit
								endif
							next
							if (sharedLockSelected = -1)
								OryUIUpdateDialog(dialog, "colorID:" + str(colorMode[colorModeSelected].dialogBackgroundColor)  + ";titleText:Lock Not Found;titleTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";supportingText:The shared lock was not found. This might be a lock that you have since deleted.;supportingTextColorID:" + str(colorMode[colorModeSelected].textColor) + ";showCheckbox:false;stackButtons:true;flexButtons:true;decisionRequired:true")
								OryUISetDialogButtonCount(dialog, 1)
								OryUIUpdateDialogButton(dialog, 1, "colorID:" + str(colorMode[colorModeSelected].dialogButtonColor) + ";name:Ok;text:Ok;textColorID:" + str(colorMode[colorModeSelected].textColor))
								OryUIShowDialog(dialog)
							endif
						endif
					endif
				endif
			endif
		endif
	next
	sharedLockName$ = ""
	elementY# = startListY# + (filterCount * listItemHeight#)

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
	if (contentHeightChanged = 1)
		OryUISetScrollBarContentSize(scrollBar, 100, maxScrollY# + 100 - trackHeightReduction#)
		contentHeightChanged = 0
	endif
endif
