
function AcceptFollowRequest(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:AcceptFollowRequest=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].AcceptFollowRequest + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function AddBreadcrumb(breadcrumb)
	local a as integer
	// SCREENS TO EXCLUDE FROM BREADCRUMBS
	if (breadcrumb = constSplashScreen) then exitfunction
	if (breadcrumb = constScanQRCodeScreen) then exitfunction
	if (breadcrumb = constLoginScreen) then exitfunction
	if (breadcrumb = constRegisterScreen) then exitfunction
	
	// REMOVE SCREENS SCREEN AND MATCHING SCREENS FROM BREADCRUMBS
	for a = breadcrumbs.length to 0 step -1
		if (breadcrumbs[a] = breadcrumb)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constMyLocksScreen and breadcrumbs[a] = constSharedLocksScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constSharedLocksScreen and breadcrumbs[a] = constMyLocksScreen)
			breadcrumbs.remove(a)	
		elseif (breadcrumb = constYourFollowersListScreen and (breadcrumbs[a] = constYourFollowingListScreen or breadcrumbs[a] = constYourBlockedUsersListScreen or breadcrumbs[a] = constYourFollowRequestsListScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constYourFollowingListScreen and (breadcrumbs[a] = constYourBlockedUsersListScreen or breadcrumbs[a] = constYourFollowRequestsListScreen or breadcrumbs[a] = constYourFollowersListScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constYourBlockedUsersListScreen and (breadcrumbs[a] = constYourFollowRequestsListScreen or breadcrumbs[a] = constYourFollowersListScreen or breadcrumbs[a] = constYourFollowingListScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constYourFollowRequestsListScreen and (breadcrumbs[a] = constYourFollowersListScreen or breadcrumbs[a] = constYourFollowingListScreen or breadcrumbs[a] = constYourBlockedUsersListScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constOthersFollowersListScreen and breadcrumbs[a] = constOthersFollowingListScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constOthersFollowingListScreen and breadcrumbs[a] = constOthersFollowersListScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constLockInformationScreen and breadcrumbs[a] = constLockLogScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constLockLogScreen and breadcrumbs[a] = constLockInformationScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constManageLockedUsersScreen and (breadcrumbs[a] = constManageUnlockedUsersScreen or breadcrumbs[a] = constManageDesertedUsersScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constManageUnlockedUsersScreen and (breadcrumbs[a] = constManageDesertedUsersScreen or breadcrumbs[a] = constManageLockedUsersScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constManageDesertedUsersScreen and (breadcrumbs[a] = constManageLockedUsersScreen or breadcrumbs[a] = constManageUnlockedUsersScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constUsersLockUpdateScreen and (breadcrumbs[a] = constUsersLockInformationScreen or breadcrumbs[a] = constUsersLockLogScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constUsersLockInformationScreen and (breadcrumbs[a] = constUsersLockLogScreen or breadcrumbs[a] = constUsersLockUpdateScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constUsersLockLogScreen and (breadcrumbs[a] = constUsersLockUpdateScreen or breadcrumbs[a] = constUsersLockInformationScreen))
			breadcrumbs.remove(a)
		elseif (breadcrumb = constEditProfileScreen and breadcrumbs[a] = constViewProfileScreen)
			breadcrumbs.remove(a)
		elseif (breadcrumb = constViewProfileScreen and breadcrumbs[a] = constEditProfileScreen)
			breadcrumbs.remove(a)
		endif
	next

	// ADD SCREEN TO BREADCRUMBS
	breadcrumbs.insert(breadcrumb)
endfunction
		
function AddCardToSimulationDeck(cardName$ as string)
	if (cardName$ = "DoubleUp")
		inc simulationNoOfDoubleUps
	elseif (cardName$ = "Freeze")
		inc simulationNoOfFreezes
	elseif (cardName$ = "Green")
		inc simulationNoOfGreens
	elseif (cardName$ = "Red")
		inc simulationNoOfReds
	elseif (cardName$ = "Reset")
		inc simulationNoOfResets
	elseif (cardName$ = "Sticky")
		inc simulationNoOfStickies
	elseif (cardName$ = "YellowAdd1")
		inc simulationNoOfYellows
		inc simulationNoOfYellowsAdd1
	elseif (cardName$ = "YellowAdd2")
		inc simulationNoOfYellows
		inc simulationNoOfYellowsAdd2
	elseif (cardName$ = "YellowAdd3")
		inc simulationNoOfYellows
		inc simulationNoOfYellowsAdd3
	elseif (cardName$ = "YellowMinus1")
		inc simulationNoOfYellows
		inc simulationNoOfYellowsMinus1
	elseif (cardName$ = "YellowMinus2")
		inc simulationNoOfYellows
		inc simulationNoOfYellowsMinus2
	endif
	simulationDeck$.insert(cardName$)
	simulationDeck$.sort()
endfunction

function AddDoubleUpCards(lockNo, cardsToAdd)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].doubleUpCardsAdded
		inc locks[lockNo].doubleUpCards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardDoubleUp100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*DoubleUpCard", 0)
	ShuffleDeck(25)
endfunction

function AddFreezeCards(lockNo, cardsToAdd)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].freezeCardsAdded
		inc locks[lockNo].freezeCards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardFreeze100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*FreezeCard", 0)
	ShuffleDeck(25)
endfunction

function AddGreenCards(lockNo, cardsToAdd)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].greenCards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardGreen100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*GreenCard", 0)
	ShuffleDeck(25)
endfunction

function AddNewAPIProject(addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&bot=" + str(newAPIProject.bot)
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&desktopApp=" + str(newAPIProject.desktopApp)
	postData$ = postData$ + "&dontKnow=" + str(newAPIProject.dontKnow)
	postData$ = postData$ + "&lockBox=" + str(newAPIProject.lockBox)
	postData$ = postData$ + "&mobileApp=" + str(newAPIProject.mobileApp)
	postData$ = postData$ + "&name=" + newAPIProject.name$
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&somethingElse=" + str(newAPIProject.somethingElse)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	postData$ = postData$ + "&website=" + str(newAPIProject.website)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:AddNewAPIProject;script:" + URLs[0].URLPath + "/" + URLs[0].AddNewAPIProject + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction
	
function AddNewUserID(addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:AddNewUserID=" + userID$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].AddNewUserID + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function AddRandomYellowCards(lockNo, cardsToAdd)
	local cardValue$ as string
	local colX# as float
	local i as integer
	local randomCard as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].randomCardsAdded
		randomCard = random(1, 7)
		if (randomCard = 1 or randomCard = 2)
			cardValue$ = "YellowAdd1"
			inc locks[lockNo].noOfAdd1Cards
		endif
		if (randomCard = 3 or randomCard = 4)
			cardValue$ = "YellowAdd2"
			inc locks[lockNo].noOfAdd2Cards
		endif
		if (randomCard = 5)
			cardValue$ = "YellowAdd3"
			inc locks[lockNo].noOfAdd3Cards
		endif
		if (randomCard = 6)
			cardValue$ = "YellowMinus1"
			inc locks[lockNo].noOfMinus1Cards
		endif
		if (randomCard = 7)
			cardValue$ = "YellowMinus2"
			inc locks[lockNo].noOfMinus2Cards
		endif
		locks[lockNo].yellowCards = locks[lockNo].noOfAdd1Cards + locks[lockNo].noOfAdd2Cards + locks[lockNo].noOfAdd3Cards + locks[lockNo].noOfMinus1Cards + locks[lockNo].noOfMinus2Cards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			if (cardValue$ = "YellowAdd1") then OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardYellowAdd1) + ";angle:0;depth:1")
			if (cardValue$ = "YellowAdd2") then OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardYellowAdd2) + ";angle:0;depth:1")
			if (cardValue$ = "YellowAdd3") then OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardYellowAdd3) + ";angle:0;depth:1")
			if (cardValue$ = "YellowMinus1") then OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardYellowMinus1) + ";angle:0;depth:1")
			if (cardValue$ = "YellowMinus2") then OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardYellowMinus2) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*RandomYellowCard", 0)
	ShuffleDeck(25)
endfunction

function AddRedCards(lockNo, cardsToAdd, yellowCardToRemove)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	if (yellowCardToRemove > 0) then dec locks[lockNo].yellowCards
	for i = 1 to cardsToAdd
		inc locks[lockNo].redCards
		if (yellowCardToRemove = 0) then inc locks[lockNo].redCardsAdded
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardRed100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*RedCard", 0)
	ShuffleDeck(25)
endfunction

function AddResetCards(lockNo, cardsToAdd)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].resetCardsAdded
		inc locks[lockNo].resetCards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardReset100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + statusBarHeight# + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:" + str(cardsToAdd) + "*ResetCard", 0)
	ShuffleDeck(25)
endfunction

function AddSpacesBetweenEachCharacter(originalString$)
	local i as integer
	local newString$ as string : newString$ = ""
	
	for i = 1 to len(originalString$)
		newString$ = newString$ + mid(originalString$, i, 1) + " "
	next
endfunction newString$

function AddStickyCards(lockNo, cardsToAdd)
	local colX# as float
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	for i = 1 to cardsToAdd
		inc locks[lockNo].stickyCards
		if (screenNo = constCardsScreen)
			dec lastCardDepth
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 1.5) + "," + str(cardHeight# * 1.5) + ";position:" + str(GetViewOffsetX() + 50) + "," + str(100 + cardHeight#) + ";image:" + str(imgCardSticky100) + ";angle:0;depth:1")
			colX# = ((floor(GetViewOffsetX() / 25) * 25) + 12.5)
			if (colX# < GetViewOffsetX()) then colX# = colX# + 25
			MoveCardTo(noOfCardSprites + i, colX# + ((i - 1) * 25), (28 + (noOfCardRows * cardSpacing#) + 4) - (cardSpacing# / 2.0))
			FlipCard(noOfCardSprites + i)
			ResizeCard(noOfCardSprites + i, cardWidth# / GetDisplayAspect(), cardHeight#)
			OryUIUpdateSprite(cards[noOfCardSprites + i].sprite, "angle:" + str(random(355, 365)) + ";depth:" + str(lastCardDepth))
			Sleep(100)
		endif
	next
	cardSelected = 0
	cardChosen = 0
	UpdateLocksData(lockNo)
	UpdateLocksDatabase(lockNo, "action:AddedCards;actionedBy:Lockee;result:1*StickyCard", 0)
	ShuffleDeck(25)
endfunction

function AddToDiscardPile(value$ as string, picked as integer)
	local i as integer
	
	locks[lockSelected].discardPile$ = ""
	for i = noOfDiscardPileSprites to 1 step -1
		discardPile[i].angle# = discardPile[i - 1].angle#
		OryUIUpdateSprite(discardPile[i].sprite, "image:" + str(GetSpriteImageID(discardPile[i - 1].sprite)))
		discardPile[i].value$ = discardPile[i - 1].value$
		locks[lockSelected].discardPile$ = discardPile[i].value$ + "," + locks[lockSelected].discardPile$
	next
	discardPile[0].angle# = random(355, 365)
	if (value$ = "DoubleUp") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardDoubleUp100) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "Freeze") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardFreeze100) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "GoAgain") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardGoAgain) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "Green") then OryUIUpdateSprite(discardPile[0].sprite, "angle:" + str(discardPile[0].angle#) + ";alpha:0")
	if (value$ = "Red") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardRed100) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "Reset") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardReset100) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "Sticky") then OryUIUpdateSprite(discardPile[0].sprite, "angle:" + str(discardPile[0].angle#) + ";alpha:0")
	if (value$ = "YellowAdd1") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardYellowAdd1) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "YellowAdd2") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardYellowAdd2) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "YellowAdd3") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardYellowAdd3) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "YellowMinus1") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardYellowMinus1) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	if (value$ = "YellowMinus2") then OryUIUpdateSprite(discardPile[0].sprite, "image:" + str(imgCardYellowMinus2) + ";angle:" + str(discardPile[0].angle#) + ";alpha:255")
	discardPile[0].value$ = value$
	locks[lockSelected].discardPile$ = value$ + "," + locks[lockSelected].discardPile$
	ClearLargeCard()
endfunction

function AddToGreenPile()
	local i as integer
	
	for i = noOfGreenPileSprites to 1 step -1
		greenPile[i].angle# = greenPile[i - 1].angle#
		OryUIUpdateSprite(greenPile[i].sprite, "image:" + str(GetSpriteImageID(greenPile[i - 1].sprite)))
		greenPile[i].value$ = greenPile[i - 1].value$
	next
	greenPile[0].angle# = random(355, 365)
	OryUIUpdateSprite(greenPile[0].sprite, "image:" + str(imgCardGreen025) + ";angle:" + str(greenPile[0].angle#) + ";alpha:255")
	greenPile[0].value$ = "Green"
	ClearLargeCard()
endfunction

function AddUserFlag(flagNo, id)
	ClearUserFlag(id)
	if (flagNo = 1 and usersFlag1.find(id) = -1) then usersFlag1.insert(id)
	if (flagNo = 2 and usersFlag2.find(id) = -1) then usersFlag2.insert(id)
	if (flagNo = 3 and usersFlag3.find(id) = -1) then usersFlag3.insert(id)
	if (flagNo = 4 and usersFlag4.find(id) = -1) then usersFlag4.insert(id)
	if (flagNo = 5 and usersFlag5.find(id) = -1) then usersFlag5.insert(id)
	if (flagNo = 6 and usersFlag6.find(id) = -1) then usersFlag6.insert(id)
	if (flagNo = 7 and usersFlag7.find(id) = -1) then usersFlag7.insert(id)
	SaveUserFlags()
endfunction

function BlockUser(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:BlockUser=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].BlockUser + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function BuildSharedLockSettingsString()
	local lockSettings$ as string
	if (loadingSharedLock = 1)
		if (keyholderDisabledKey = 0) then keyDisabled = 0
		if (keyholderDisabledKey = 1) then keyDisabled = 1
		maxCopies = absoluteMaxCopies
		minCopies = absoluteMinCopies
	endif
	if (screenNo = constShareLockScreen or screenNo = constSharedLockInformationScreen)
		blockTestLocks = sharedLocks[sharedLockSelected, 0].blockTestLocks
		blockUsersAlreadyLocked = sharedLocks[sharedLockSelected, 0].blockUsersAlreadyLocked
		blockUsersWithStatsHidden = sharedLocks[sharedLockSelected, 0].blockUsersWithStatsHidden
		cardInfoHidden = sharedLocks[sharedLockSelected, 0].cardInfoHidden
		checkInFrequencyInSeconds = sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds
		cumulative = sharedLocks[sharedLockSelected, 0].cumulative
		fixed = sharedLocks[sharedLockSelected, 0].fixed
		forceTrust = sharedLocks[sharedLockSelected, 0].forceTrust
		keyDisabled = sharedLocks[sharedLockSelected, 0].keyDisabled
		keyholderDecisionDisabled = sharedLocks[sharedLockSelected, 0].keyholderDecisionDisabled
		lateCheckInWindowInSeconds = sharedLocks[sharedLockSelected, 0].lateCheckInWindowInSeconds
		maxAutoResets = sharedLocks[sharedLockSelected, 0].maxAutoResets
		maxCopies = sharedLocks[sharedLockSelected, 0].maxRandomCopies
		maxDoubleUps = sharedLocks[sharedLockSelected, 0].maxRandomDoubleUps
		maxFreezes = sharedLocks[sharedLockSelected, 0].maxRandomFreezes
		maxGreens = sharedLocks[sharedLockSelected, 0].maxRandomGreens
		maxMinutes = sharedLocks[sharedLockSelected, 0].maxRandomMinutes
		maxReds = sharedLocks[sharedLockSelected, 0].maxRandomReds
		maxResets = sharedLocks[sharedLockSelected, 0].maxRandomResets
		maxStickies = sharedLocks[sharedLockSelected, 0].maxRandomStickies
		maxUsers = sharedLocks[sharedLockSelected, 0].maxUsers
		maxYellowsAdd = sharedLocks[sharedLockSelected, 0].maxRandomYellowsAdd
		maxYellowsMinus = sharedLocks[sharedLockSelected, 0].maxRandomYellowsMinus
		maxYellowsRandom = sharedLocks[sharedLockSelected, 0].maxRandomYellows
		minCopies = sharedLocks[sharedLockSelected, 0].minRandomCopies
		minDoubleUps = sharedLocks[sharedLockSelected, 0].minRandomDoubleUps
		minFreezes = sharedLocks[sharedLockSelected, 0].minRandomFreezes
		minGreens = sharedLocks[sharedLockSelected, 0].minRandomGreens
		minMinutes = sharedLocks[sharedLockSelected, 0].minRandomMinutes
		minRatingRequired = sharedLocks[sharedLockSelected, 0].minRatingRequired
		minReds = sharedLocks[sharedLockSelected, 0].minRandomReds
		minResets = sharedLocks[sharedLockSelected, 0].minRandomResets
		minStickies = sharedLocks[sharedLockSelected, 0].minRandomStickies
		minYellowsAdd = sharedLocks[sharedLockSelected, 0].minRandomYellowsAdd
		minYellowsMinus = sharedLocks[sharedLockSelected, 0].minRandomYellowsMinus
		minYellowsRandom = sharedLocks[sharedLockSelected, 0].minRandomYellows
		multipleGreensRequired = sharedLocks[sharedLockSelected, 0].multipleGreensRequired
		regularity# = sharedLocks[sharedLockSelected, 0].regularity#
		requireDM = sharedLocks[sharedLockSelected, 0].requireDM
		resetFrequencyInSeconds = sharedLocks[sharedLockSelected, 0].resetFrequencyInSeconds
		startLockFrozen = sharedLocks[sharedLockSelected, 0].startLockFrozen
		temporarilyDisabled = sharedLocks[sharedLockSelected, 0].temporarilyDisabled
		timerHidden = sharedLocks[sharedLockSelected, 0].timerHidden
	endif
	lockSettings$ = ""
	if (loadingSharedLock = 1 and keyholderUsername$ <> username$)
		if (hiddenFromOwner = 0)
			startLockSettingsManagedByBlackFont = 0
			startLockSettingsManagedByRedFont = 0
			lockSettings$ = lockSettings$ + sharedLockName$ + chr(10) + "Managed by " + keyholderUsername$ + chr(10)
			// ONLY SHOW LAST ONLINE IF THEY HAVE BEEN INACTIVE FOR 7 DAYS OR MORE
			if (timestampNow - keyholderLastActive > (86400 * 7) and keyholderStatus <> 4)
				lockSettings$ = lockSettings$ + "Last online " + lower(ConvertMinutesToText((timestampNow - keyholderLastActive) / 60, 0)) + " ago" + chr(10)
			endif
			lockSettings$ = lockSettings$ + chr(10)
			endLockSettingsManagedByBlackFont = len(lockSettings$)
			endLockSettingsManagedByRedFont = 0
		else
			startLockSettingsManagedByBlackFont = 0
			startLockSettingsManagedByRedFont = len(sharedLockName$) + 1
			lockSettings$ = lockSettings$ + sharedLockName$ + chr(10) + "No longer managed by keyholder" + chr(10) + chr(10)
			endLockSettingsManagedByBlackFont = 0
			endLockSettingsManagedByRedFont = startLockSettingsManagedByRedFont + 30
		endif		
	endif
	startLockSettingsTestLockRedFont = -1
	endLockSettingsTestLockRedFont = -1
	if (loadingSharedLock = 1 and fixed = 0 and regularity# = 0.016667)
		startLockSettingsTestLockRedFont = len(lockSettings$)
		lockSettings$ = lockSettings$ + "TEST LOCK" + chr(10) + chr(10)
		endLockSettingsTestLockRedFont = startLockSettingsTestLockRedFont + 9
	endif
	if (loadingSharedLock = 1 and blockTestLocks = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
		startLockSettingsTestLockRedFont = len(lockSettings$)
		lockSettings$ = lockSettings$ + "NO TEST LOCKS" + chr(10) + chr(10)
		endLockSettingsTestLockRedFont = startLockSettingsTestLockRedFont + 13
	endif
	startLockSettingsBlueFont = len(lockSettings$)
	if (requireDM = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
		lockSettings$ = lockSettings$ + "Message Keyholder Before Loading" + chr(10)
	endif
	endLockSettingsBlueFont = len(lockSettings$)	
	if (fixed = 0)
		lockSettings$ = lockSettings$ + "Variable Lock" + chr(10)
		if (cumulative = 0)
			if (regularity# = 0.016667) then lockSettings$ = lockSettings$ + "Chance Every 1 Minute (Non-Cumulative)" + chr(10)
			if (regularity# = 0.25) then lockSettings$ = lockSettings$ + "Chance Every 15 Minutes (Non-Cumulative)" + chr(10)
			if (regularity# = 0.50) then lockSettings$ = lockSettings$ + "Chance Every 30 Minutes (Non-Cumulative)" + chr(10)
			if (regularity# = 1) then lockSettings$ = lockSettings$ + "Chance Every Hour (Non-Cumulative)" + chr(10)
			if (regularity# = 3) then lockSettings$ = lockSettings$ + "Chance Every 3 Hours (Non-Cumulative)" + chr(10)
			if (regularity# = 6) then lockSettings$ = lockSettings$ + "Chance Every 6 Hours (Non-Cumulative)" + chr(10)
			if (regularity# = 12) then lockSettings$ = lockSettings$ + "Chance Every 12 Hours (Non-Cumulative)" + chr(10)
			if (regularity# = 24) then lockSettings$ = lockSettings$ + "Chance Every Day (Non-Cumulative)" + chr(10)
		endif
		if (cumulative = 1)
			if (regularity# = 0.016667) then lockSettings$ = lockSettings$ + "Chance Every 1 Minute (Cumulative)" + chr(10)
			if (regularity# = 0.25) then lockSettings$ = lockSettings$ + "Chance Every 15 Minutes (Cumulative)" + chr(10)
			if (regularity# = 0.5) then lockSettings$ = lockSettings$ + "Chance Every 30 Minutes (Cumulative)" + chr(10)
			if (regularity# = 1) then lockSettings$ = lockSettings$ + "Chance Every Hour (Cumulative)" + chr(10)
			if (regularity# = 3) then lockSettings$ = lockSettings$ + "Chance Every 3 Hours (Cumulative)" + chr(10)
			if (regularity# = 6) then lockSettings$ = lockSettings$ + "Chance Every 6 Hours (Cumulative)" + chr(10)
			if (regularity# = 12) then lockSettings$ = lockSettings$ + "Chance Every 12 Hours (Cumulative)" + chr(10)
			if (regularity# = 24) then lockSettings$ = lockSettings$ + "Chance Every Day (Cumulative)" + chr(10)
		endif
		if (cardInfoHidden = 0 or screenNo = constSharedLockInformationScreen)
			if (minGreens = maxGreens)
				if (maxGreens = 1)
					lockSettings$ = lockSettings$ + "1 Green Card"
				else
					lockSettings$ = lockSettings$ + str(maxGreens) + " Green Cards"
				endif
			else
				lockSettings$ = lockSettings$ + str(minGreens) + "-" + str(maxGreens) + " Green Cards"
			endif
			if (multipleGreensRequired = 0) then lockSettings$ = lockSettings$ + " (1 Required to Unlock)" + chr(10)
			if (multipleGreensRequired = 1) then lockSettings$ = lockSettings$ + " (All Required to Unlock)" + chr(10)
			if (maxReds > 0)
				if (minReds = maxReds)
					if (minReds = 1)
						lockSettings$ = lockSettings$ + "1 Red Card" + chr(10)
					else
						lockSettings$ = lockSettings$ + str(maxReds) + " Red Cards" + chr(10)
					endif
				else
					if (minReds <= 1)
						lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards" + chr(10)
					else
						if (regularity# = 0.016667) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 1, 0) + ")" + chr(10)
						if (regularity# = 0.25) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 15, 0) + ")" + chr(10)
						if (regularity# = 0.5) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 30, 0) + ")" + chr(10)
						if (regularity# = 1) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 60, 0) + ")" + chr(10)
						if (regularity# = 3) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 180, 0) + ")" + chr(10)
						if (regularity# = 6) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 360, 0) + ")" + chr(10)
						if (regularity# = 12) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 720, 0) + ")" + chr(10)
						if (regularity# = 24) then lockSettings$ = lockSettings$ + str(minReds) + "-" + str(maxReds) + " Red Cards (Min. " + ConvertMinutesToText(minReds * 1440, 0) + ")" + chr(10)
					endif
				endif
			endif
			if (maxStickies > 0)
				if (minStickies = maxStickies)
					if (minStickies = 1)
						lockSettings$ = lockSettings$ + "1 Sticky Card" + chr(10)
					else
						lockSettings$ = lockSettings$ + str(minStickies) + " Sticky Cards" + chr(10)
					endif
				else
					lockSettings$ = lockSettings$ + str(minStickies) + "-" + str(maxStickies) + " Sticky Cards" + chr(10)
				endif
			endif
			if (screenNo <> constShareLockScreen and loadingSharedLock = 0)
				if (maxYellowsRandom > 0)
					if (minYellowsRandom = maxYellowsRandom)
						if (minYellowsRandom = 1)
							lockSettings$ = lockSettings$ + "1 Random Yellow Card" + chr(10)
						else
							lockSettings$ = lockSettings$ + str(maxYellowsRandom) + " Random Yellow Cards" + chr(10)
						endif
					else
						lockSettings$ = lockSettings$ + str(minYellowsRandom) + "-" + str(maxYellowsRandom) + " Random Yellow Cards" + chr(10)
					endif
				endif
				if (maxYellowsMinus > 0)
					if (minYellowsMinus = maxYellowsMinus)
						if (minYellowsMinus = 1)
							lockSettings$ = lockSettings$ + "1 'Remove Red(s)' Yellow Card" + chr(10)
						else
							lockSettings$ = lockSettings$ + str(maxYellowsMinus) + " 'Remove Red(s)' Yellow Cards" + chr(10)
						endif
					else
						lockSettings$ = lockSettings$ + str(minYellowsMinus) + "-" + str(maxYellowsMinus) + " 'Remove Red(s)' Yellow Cards" + chr(10)
					endif
				endif
				if (maxYellowsAdd > 0)
					if (minYellowsAdd = maxYellowsAdd)
						if (minYellowsAdd = 1)
							lockSettings$ = lockSettings$ + "1 'Add Red(s)' Yellow Card" + chr(10)
						else
							lockSettings$ = lockSettings$ + str(maxYellowsAdd) + " 'Add Red(s)' Yellow Cards" + chr(10)
						endif
					else
						lockSettings$ = lockSettings$ + str(minYellowsAdd) + "-" + str(maxYellowsAdd) + " 'Add Red(s)' Yellow Cards" + chr(10)
					endif
				endif
			else
				if (maxYellowsAdd + maxYellowsMinus + maxYellowsRandom > 0)
					if (minYellowsAdd + minYellowsMinus + minYellowsRandom = maxYellowsAdd + maxYellowsMinus + maxYellowsRandom)
						if (minYellowsAdd + minYellowsMinus + minYellowsRandom = 1)
							lockSettings$ = lockSettings$ + "1 Yellow Card" + chr(10)
						else
							lockSettings$ = lockSettings$ + str(maxYellowsAdd + maxYellowsMinus + maxYellowsRandom) + " Yellow Cards" + chr(10)
						endif
					else
						lockSettings$ = lockSettings$ + str(minYellowsAdd + minYellowsMinus + minYellowsRandom) + "-" + str(maxYellowsAdd + maxYellowsMinus + maxYellowsRandom) + " Yellow Cards" + chr(10)
					endif
				endif
			endif
			if (maxFreezes > 0)
				if (minFreezes = maxFreezes)
					if (minFreezes = 1)
						lockSettings$ = lockSettings$ + "1 Freeze Card" + chr(10)
					else
						lockSettings$ = lockSettings$ + str(minFreezes) + " Freeze Cards" + chr(10)
					endif
				else
					lockSettings$ = lockSettings$ + str(minFreezes) + "-" + str(maxFreezes) + " Freeze Cards" + chr(10)
				endif
			endif
			if (maxDoubleUps > 0)
				if (minDoubleUps = maxDoubleUps)
					if (minDoubleUps = 1)
						lockSettings$ = lockSettings$ + "1 Double Up Card" + chr(10)
					else
						lockSettings$ = lockSettings$ + str(minDoubleUps) + " Double Up Cards" + chr(10)
					endif
				else
					lockSettings$ = lockSettings$ + str(minDoubleUps) + "-" + str(maxDoubleUps) + " Double Up Cards" + chr(10)
				endif
			endif
			if (maxResets > 0)
				if (minResets = maxResets)
					if (minResets = 1)
						lockSettings$ = lockSettings$ + "1 Reset Lock Card" + chr(10)
					else
						lockSettings$ = lockSettings$ + str(minResets) + " Reset Lock Cards" + chr(10)
					endif
				else
					lockSettings$ = lockSettings$ + str(minResets) + "-" + str(maxResets) + " Reset Lock Cards" + chr(10)
				endif
			endif
		endif
		if (maxAutoResets > 0)
			if (cardInfoHidden = 0)
				lockSettings$ = lockSettings$ + "Resets Every " + ConvertSecondsToText(resetFrequencyInSeconds, 1) + chr(10) + "Maximum Of " + str(maxAutoResets) + " Auto Resets" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Maximum Of " + str(maxAutoResets) + " Auto Resets" + chr(10)
			endif
		endif
		if (cardInfoHidden = 1)
			lockSettings$ = lockSettings$ + "Card Information Hidden" + chr(10)
		endif
		if (minCopies > 0)
			if (minCopies = maxCopies)
				lockSettings$ = lockSettings$ + str(maxCopies) + " Fake Copies Required" + chr(10)
			else
				lockSettings$ = lockSettings$ + str(minCopies) + "-" + str(maxCopies) + " Fake Copies Required" + chr(10)
			endif
		elseif (maxCopies > 0)
			lockSettings$ = lockSettings$ + "Fake Copies Allowed (Max. " + str(maxCopies) + ")" + chr(10)
		else
			lockSettings$ = lockSettings$ + "No Fake Copies" + chr(10)
		endif
		if (((screenNo <> constShareLockScreen and creatingSharedLock = 1) or (screenNo = constShareLockScreen)) and maxUsers > 0 and keyholderUsername$ <> username$)
			if (maxUsers = 1)
				lockSettings$ = lockSettings$ + "Maximum of " + str(maxUsers) + " User at Any One Time" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Maximum of " + str(maxUsers) + " Users at Any One Time" + chr(10)
			endif
		endif
		if (((screenNo <> constShareLockScreen and creatingSharedLock = 1) or (screenNo = constShareLockScreen)) and minRatingRequired > 0 and keyholderUsername$ <> username$)
			if (minRatingRequired < 5)
				lockSettings$ = lockSettings$ + "Requires a rating of " + str(minRatingRequired) + "+ to load" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Requires a rating of " + str(minRatingRequired) + " to load" + chr(10)
			endif
		endif
		if (screenNo <> constShareLockScreen and creatingSharedLock = 1 and keyholderUsername$ <> username$)
			if (blockUsersAlreadyLocked = 1) then lockSettings$ = lockSettings$ + "Block users already locked" + chr(10)
		endif
		if (screenNo <> constShareLockScreen and screenNo <> constScanQRCodeScreen and creatingSharedLock = 1 and keyholderUsername$ <> username$)
			if (blockUsersWithStatsHidden = 1) then lockSettings$ = lockSettings$ + "Block users with stats hidden" + chr(10)
		endif
		if (checkInFrequencyInSeconds > 0)
			lockSettings$ = lockSettings$ + "Check-Ins Required Every " + ConvertSecondsToText(checkInFrequencyInSeconds, 1) + chr(10)
			if (lateCheckInWindowInSeconds = 0)
				lockSettings$ = lockSettings$ + "Check-Ins Late After " + ConvertSecondsToText(regularity# * 3600, 1) + chr(10)
			else
				lockSettings$ = lockSettings$ + "Check-Ins Late After " + ConvertSecondsToText(lateCheckInWindowInSeconds, 1) + chr(10)
			endif
		endif
		startLockSettingsRedFont = len(lockSettings$)
		if (keyDisabled = 1)
			lockSettings$ = lockSettings$ + "Emergency Keys Disabled" + chr(10)
		endif
		if (forceTrust = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "Keyholder Limitations Removed" + chr(10)
		endif
		if (startLockFrozen = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "Lock Starts Frozen" + chr(10)
		endif
		endLockSettingsRedFont = len(lockSettings$)
		if (screenNo <> constShareLockScreen and loadingSharedLock = 1 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "----------" + chr(10)
			if (maxUsers > 0)
				lockSettings$ = lockSettings$ + "Users Locked[colon] " + str(lockedUsers) + " out of " + str(maxUsers) + chr(10)
			else
				lockSettings$ = lockSettings$ + "Users Locked[colon] " + str(lockedUsers) + chr(10)
			endif
			if (noOfLockRatings >= 5)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] " + ReplaceString(str(lockRating#, 1), ".0", "", -1) + " out of 5 stars (" + str(noOfLockRatings) + " Ratings)" + chr(10)
			elseif (noOfLockRatings = 0)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] No ratings yet" + chr(10)
			elseif (noOfLockRatings = 1)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] Not enough ratings (1 Rating)" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Lock Rating[colon] Not enough ratings (" + str(noOfLockRatings) + " Ratings)" + chr(10)
			endif
			if (hiddenFromOwner = 0)
				if (noOfKeyholderRatings >= 5)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] " + ReplaceString(str(keyholderRating#, 1), ".0", "", -1) + " out of 5 stars (" + str(noOfKeyholderRatings) + " Ratings)" + chr(10)
				elseif (noOfKeyholderRatings = 0)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] No ratings yet" + chr(10)
				elseif (noOfKeyholderRatings = 1)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] Not enough ratings (1 Rating)" + chr(10)
				else
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] Not enough ratings (" + str(noOfKeyholderRatings) + " Ratings)" + chr(10)
				endif
			endif
		endif
	else
		lockSettings$ = lockSettings$ + "Fixed Lock" + chr(10)
		if (timerHidden = 0 or screenNo = constSharedLockInformationScreen)
			if (maxMinutes > 0)
				if (minMinutes = maxMinutes)
					lockSettings$ = lockSettings$ + ConvertMinutesToText(maxMinutes, 0) + chr(10)
				else
					lockSettings$ = lockSettings$ + ConvertMinutesRangeToText(minMinutes, maxMinutes) + chr(10)
				endif
			elseif (maxReds > 0)
				if (minReds = maxReds)
					if (minReds = 1)
						if (regularity# = 0.25) then lockSettings$ = lockSettings$ + "15 Minutes" + chr(10)
						if (regularity# = 1) then lockSettings$ = lockSettings$ + "1 Hour" + chr(10)
						if (regularity# = 24) then lockSettings$ = lockSettings$ + "1 Day" + chr(10)
					else
						if (regularity# = 0.25) then lockSettings$ = lockSettings$ + ConvertMinutesToText(maxReds * 15, 0) + chr(10)
						if (regularity# = 1) then lockSettings$ = lockSettings$ + ConvertMinutesToText(maxReds * 60, 0) + chr(10)
						if (regularity# = 24) then lockSettings$ = lockSettings$ + ConvertMinutesToText(maxReds * 1440, 0) + chr(10)
					endif
				else
					if (regularity# = 0.25) then lockSettings$ = lockSettings$ + ConvertMinutesRangeToText(minReds * 15, maxReds * 15) + chr(10)
					if (regularity# = 1) then lockSettings$ = lockSettings$ + ConvertMinutesRangeToText(minReds * 60, maxReds * 60) + chr(10)
					if (regularity# = 24) then lockSettings$ = lockSettings$ + ConvertMinutesRangeToText(minReds * 1440, maxReds * 1440) + chr(10)
				endif
			endif
		endif
		if (timerHidden = 1)
			lockSettings$ = lockSettings$ + "Timer Hidden" + chr(10)
		else
			lockSettings$ = lockSettings$ + "Timer Visible" + chr(10)
		endif
		if (minCopies > 0)
			if (minCopies = maxCopies)
				lockSettings$ = lockSettings$ + str(maxCopies) + " Fake Copies Required" + chr(10)
			else
				lockSettings$ = lockSettings$ + str(minCopies) + "-" + str(maxCopies) + " Fake Copies Required" + chr(10)
			endif
		elseif (maxCopies > 0)
			lockSettings$ = lockSettings$ + "Fake Copies Allowed (Max. " + str(maxCopies) + ")" + chr(10)
		else
			lockSettings$ = lockSettings$ + "No Fake Copies" + chr(10)
		endif
		if (((screenNo <> constShareLockScreen and creatingSharedLock = 1) or (screenNo = constShareLockScreen)) and maxUsers > 0 and keyholderUsername$ <> username$)
			if (maxUsers = 1)
				lockSettings$ = lockSettings$ + "Maximum of " + str(maxUsers) + " User at Any One Time" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Maximum of " + str(maxUsers) + " Users at Any One Time" + chr(10)
			endif
		endif
		if (((screenNo <> constShareLockScreen and creatingSharedLock = 1) or (screenNo = constShareLockScreen)) and minRatingRequired > 0 and keyholderUsername$ <> username$)
			if (minRatingRequired < 5)
				lockSettings$ = lockSettings$ + "Requires a rating of " + str(minRatingRequired) + "+ to load" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Requires a rating of " + str(minRatingRequired) + " to load" + chr(10)
			endif	
		endif
		if (checkInFrequencyInSeconds > 0)
			lockSettings$ = lockSettings$ + "Check-Ins Required Every " + ConvertSecondsToText(checkInFrequencyInSeconds, 1) + chr(10)
			if (lateCheckInWindowInSeconds = 0)
				lockSettings$ = lockSettings$ + "Check-Ins Late After " + ConvertSecondsToText(MinInt(locks[lockSelected].checkInFrequencyInSeconds / 2, 86400), 1) + chr(10)
			else
				lockSettings$ = lockSettings$ + "Check-Ins Late After " + ConvertSecondsToText(lateCheckInWindowInSeconds, 1) + chr(10)
			endif
		endif
		startLockSettingsRedFont = len(lockSettings$)
		if (keyDisabled = 1)
			lockSettings$ = lockSettings$ + "Emergency Keys Disabled" + chr(10)
		endif
		if (forceTrust = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "Keyholder Limitations Removed" + chr(10)
		endif
		if (startLockFrozen = 1 and hiddenFromOwner = 0 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "Lock Starts Frozen" + chr(10)
		endif
		endLockSettingsRedFont = len(lockSettings$)
		if (screenNo <> constShareLockScreen and loadingSharedLock = 1 and keyholderUsername$ <> username$)
			lockSettings$ = lockSettings$ + "----------" + chr(10)
			if (maxUsers > 0)
				lockSettings$ = lockSettings$ + "Users Locked[colon] " + str(lockedUsers) + " out of " + str(maxUsers) + chr(10)
			else
				lockSettings$ = lockSettings$ + "Users Locked[colon] " + str(lockedUsers) + chr(10)
			endif
			if (noOfLockRatings >= 5)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] " + ReplaceString(str(lockRating#, 1), ".0", "", -1) + " out of 5 stars (" + str(noOfLockRatings) + " Ratings)" + chr(10)
			elseif (noOfLockRatings = 0)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] No ratings yet" + chr(10)
			elseif (noOfLockRatings = 1)
				lockSettings$ = lockSettings$ + "Lock Rating[colon] Not enough ratings (1 Rating)" + chr(10)
			else
				lockSettings$ = lockSettings$ + "Lock Rating[colon] Not enough ratings (" + str(noOfLockRatings) + " Ratings)" + chr(10)
			endif
			if (hiddenFromOwner = 0)
				if (noOfKeyholderRatings >= 5)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] " + ReplaceString(str(keyholderRating#, 1), ".0", "", -1) + " out of 5 stars (" + str(noOfKeyholderRatings) + " Ratings)" + chr(10)
				elseif (noOfKeyholderRatings = 0)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] No ratings yet" + chr(10)
				elseif (noOfKeyholderRatings = 1)
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] Not enough ratings (1 Rating)" + chr(10)
				else
					lockSettings$ = lockSettings$ + "Keyholder Rating[colon] Not enough ratings (" + str(noOfKeyholderRatings) + " Ratings)" + chr(10)
				endif
			endif
		endif
	endif
endfunction lockSettings$

function CheckNewShareID(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&shareID=" + shareID$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:CheckNewShareID=" + sharedID$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].CheckNewShareID + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function CheckNewUserID(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:CheckNewUserID=" + userID$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].CheckNewUserID + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function CheckNewUsername(newUsername$, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&username=" + newUsername$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:CheckNewUsername=" + newUsername$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].CheckNewUsername + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function CheckRestoreUserID(restoreUserID$, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&restoreUserID1=" + restoreUserID$
	postData$ = postData$ + "&restoreUserID2=" + restoreUserID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:CheckRestoreUserID=" + restoreUserID$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].CheckRestoreID + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function ClearBreadcrumbs()
	breadcrumbs.length = -1
endfunction

function ClearDiscardPile(lockNo)
	local i as integer
	
	locks[lockNo].discardPile$ = ""
	for i = noOfDiscardPileSprites to 0 step -1
		discardPile[i].angle# = 0
		OryUIUpdateSprite(discardPile[i].sprite, "alpha:0")
		discardPile[i].value$ = ""
	next
endfunction

function ClearGreenPile()
	local i as integer
	
	for i = noOfGreenPileSprites to 0 step -1
		greenPile[i].angle# = 0
		OryUIUpdateSprite(greenPile[i].sprite, "alpha:0")
		greenPile[i].value$ = ""
	next
endfunction

function ClearLargeCard()
	largeCard.value$ = ""
	cardsScrimVisible = 0
	OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
	OryUIUpdateSprite(largeCard.sprite, "position:-1000,-1000")
	OryUIUpdateText(largeCard.txtBottom, "position:-1000,-1000")
	OryUIUpdateText(largeCard.txtCenter, "position:-1000,-1000")
	OryUIUpdateText(largeCard.txtTop, "position:-1000,-1000")
	largeCardVisible = 0
endfunction

function ClearUserFlag(id)
	if (usersFlag1.find(id) > -1) then usersFlag1.remove(usersFlag1.find(id))
	if (usersFlag2.find(id) > -1) then usersFlag2.remove(usersFlag2.find(id))
	if (usersFlag3.find(id) > -1) then usersFlag3.remove(usersFlag3.find(id))
	if (usersFlag4.find(id) > -1) then usersFlag4.remove(usersFlag4.find(id))
	if (usersFlag5.find(id) > -1) then usersFlag5.remove(usersFlag5.find(id))
	if (usersFlag6.find(id) > -1) then usersFlag6.remove(usersFlag6.find(id))
	if (usersFlag7.find(id) > -1) then usersFlag7.remove(usersFlag7.find(id))
	SaveUserFlags()
endfunction

function ConvertMinutesToText(minutes, full)
	local dd as integer
	local hh as integer
	local mm as integer
	local timeText$ as string
	local timeUnitCounter as integer
	
	// Convert minutes to days, hours, and minutes
	dd = floor(minutes / 60 / 24)
	hh = mod(minutes / 60, 24)
	mm = mod(minutes, 60)
	// Build time string showing the maximum unit
	if (full = 0)
		if (dd > 0)
			if (dd = 1)
				timeText$ = "1 Day"
			else
				timeText$ = str(dd) + " Days"
			endif
		elseif (hh > 0)
			if (hh = 1)
				timeText$ = "1 Hour"
			else
				timeText$ = str(hh) + " Hours"
			endif
		else
			if (mm = 1)
				timeText$ = "1 Minute"
			else
				timeText$ = str(mm) + " Minutes"
			endif
		endif
	endif
	// Build full time string
	if (full = 1)
		timeUnit$ as string[4]
		timeUnitCounter = 0
		if (dd > 0)
			inc timeUnitCounter
			if (dd = 1)
				timeUnit$[timeUnitCounter] = "1 Day"
			else
				timeUnit$[timeUnitCounter] = str(dd) + " Days"
			endif
		endif
		if (hh > 0)
			inc timeUnitCounter
			if (hh = 1)
				timeUnit$[timeUnitCounter] = "1 Hour"
			else
				timeUnit$[timeUnitCounter] = str(hh) + " Hours"
			endif
		endif
		if (mm > 0)
			inc timeUnitCounter
			if (mm = 1)
				timeUnit$[timeUnitCounter] = "1 Minute"
			else
				timeUnit$[timeUnitCounter] = str(mm) + " Minutes"
			endif
		endif
		if (timeUnitCounter = 1) then timeText$ = timeUnit$[1]
		if (timeUnitCounter = 2) then timeText$ = timeUnit$[1] + ", and " + timeUnit$[2]
		if (timeUnitCounter = 3) then timeText$ = timeUnit$[1] + ", " + timeUnit$[2] + ", and " + timeUnit$[3]
	endif
endfunction timeText$

function ConvertMinutesRangeToText(minMinutes, maxMinutes)
	local firstTimeNumber as integer
	local firstTimeUnit$ as string
	local maxDD as integer
	local maxHH as integer
	local maxMM as integer
	local minDD as integer
	local minHH as integer
	local minMM as integer
	local secondTimeNumber as integer
	local secondTimeUnit$ as string
	local timeText$ as string
	
	// Convert min and max minutes to days, hours, and minutes
	minDD = floor(minMinutes / 60 / 24)
	minHH = mod(minMinutes / 60, 24)
	minMM = mod(minMinutes, 60)
	maxDD = floor(maxMinutes / 60 / 24)
	maxHH = mod(maxMinutes / 60, 24)
	maxMM = mod(maxMinutes, 60)
	// Work out the unit of time for the min and max part of the time, i.e. days, hours, or minutes
	firstTimeNumber = 0
	firstTimeUnit$ = ""
	secondTimeNumber = 0
	secondTimeUnit$ = ""
	if (minDD > 0)
		firstTimeNumber = minDD
		if (firstTimeNumber = 1)
			firstTimeUnit$ = " Day"
		else
			firstTimeUnit$ = " Days"
		endif
	elseif (minHH > 0)
		firstTimeNumber = minHH
		if (firstTimeNumber = 1)
			firstTimeUnit$ = " Hour"
		else
			firstTimeUnit$ = " Hours"
		endif
	else
		firstTimeNumber = minMM
		if (firstTimeNumber = 1)
			firstTimeUnit$ = " Minute"
		else
			firstTimeUnit$ = " Minutes"
		endif
	endif
	if (maxDD > 0)
		secondTimeNumber = maxDD
		if (secondTimeNumber = 1)
			secondTimeUnit$ = " Day"
		else
			secondTimeUnit$ = " Days"
		endif
	elseif (maxHH > 0)
		secondTimeNumber = maxHH
		if (secondTimeNumber = 1)
			secondTimeUnit$ = " Hour"
		else
			secondTimeUnit$ = " Hours"
		endif
	else
		secondTimeNumber = maxMM
		if (secondTimeNumber = 1)
			secondTimeUnit$ = " Minute"
		else
			secondTimeUnit$ = " Minutes"
		endif
	endif
	if (firstTimeNumber = secondTimeNumber)
		if (left(firstTimeUnit$, 2) = left(secondTimeUnit$, 2))
			timeText$ = str(firstTimeNumber) + firstTimeUnit$
		else
			if (firstTimeNumber = 0)
				timeText$ = str(firstTimeNumber) + " - " + str(secondTimeNumber) + secondTimeUnit$
			else
				timeText$ = str(firstTimeNumber) + firstTimeUnit$ + " - " + str(secondTimeNumber) + secondTimeUnit$
			endif
		endif
	else
		if (left(firstTimeUnit$, 2) = left(secondTimeUnit$, 2))
			timeText$ = str(firstTimeNumber) + " - " + str(secondTimeNumber) + secondTimeUnit$
		else
			if (firstTimeNumber = 0)
				timeText$ = str(firstTimeNumber) + " - " + str(secondTimeNumber) + secondTimeUnit$
			else
				timeText$ = str(firstTimeNumber) + firstTimeUnit$ + " - " + str(secondTimeNumber) + secondTimeUnit$
			endif
		endif
	endif
endfunction timeText$

function ConvertSecondsToText(seconds, full)
	local dd as integer
	local hh as integer
	local mm as integer
	local ss as integer
	local timeText$ as string
	local timeUnitCounter as integer
	
	// Convert seconds to days, hours, and minutes
	dd = floor(seconds / 60 / 60 / 24)
	hh = mod(seconds / 60 / 60, 24)
	mm = mod(seconds / 60, 60)
	// Build time string showing the maximum unit
	if (full = 0)
		if (dd > 0)
			if (dd = 1)
				timeText$ = "1 Day"
			else
				timeText$ = str(dd) + " Days"
			endif
		elseif (hh > 0)
			if (hh = 1)
				timeText$ = "1 Hour"
			else
				timeText$ = str(hh) + " Hours"
			endif
		else
			if (mm = 1)
				timeText$ = "1 Minute"
			else
				timeText$ = str(mm) + " Minutes"
			endif
		endif
	endif
	// Build full time string
	if (full = 1)
		timeUnit$ as string[4]
		timeUnitCounter = 0
		if (dd > 0)
			inc timeUnitCounter
			if (dd = 1)
				timeUnit$[timeUnitCounter] = "1 Day"
			else
				timeUnit$[timeUnitCounter] = str(dd) + " Days"
			endif
		endif
		if (hh > 0)
			inc timeUnitCounter
			if (hh = 1)
				timeUnit$[timeUnitCounter] = "1 Hour"
			else
				timeUnit$[timeUnitCounter] = str(hh) + " Hours"
			endif
		endif
		if (mm > 0)
			inc timeUnitCounter
			if (mm = 1)
				timeUnit$[timeUnitCounter] = "1 Minute"
			else
				timeUnit$[timeUnitCounter] = str(mm) + " Minutes"
			endif
		endif
		if (timeUnitCounter = 1) then timeText$ = timeUnit$[1]
		if (timeUnitCounter = 2) then timeText$ = timeUnit$[1] + ", and " + timeUnit$[2]
		if (timeUnitCounter = 3) then timeText$ = timeUnit$[1] + ", " + timeUnit$[2] + ", and " + timeUnit$[3]
		if (seconds < 60) then timeText$ = str(seconds, 0) + " Seconds"
	endif
endfunction timeText$

function CreateDeck(lockNo)
	local cardNo as integer
	local i as integer
	
	noOfCards = GetNoOfCards(lockNo)
	cardNo = 0
	for i = 1 to locks[lockNo].doubleUpCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "DoubleUp"
	next
	for i = 1 to locks[lockNo].freezeCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "Freeze"
	next
	for i = 1 to locks[lockNo].goAgainCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "GoAgain"
	next
	for i = 1 to locks[lockNo].greenCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "Green"
	next
	for i = 1 to locks[lockNo].redCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "Red"
	next
	for i = 1 to locks[lockNo].resetCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "Reset"
	next
	for i = 1 to locks[lockNo].stickyCards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "Sticky"
	next
	for i = 1 to locks[lockNo].noOfAdd1Cards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "YellowAdd1"
	next
	for i = 1 to locks[lockNo].noOfAdd2Cards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "YellowAdd2"
	next
	for i = 1 to locks[lockNo].noOfAdd3Cards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "YellowAdd3"
	next
	for i = 1 to locks[lockNo].noOfMinus1Cards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "YellowMinus1"
	next
	for i = 1 to locks[lockNo].noOfMinus2Cards
		inc cardNo
		deck[cardNo].angle# = random(355, 365)
		deck[cardNo].id = cardNo
		deck[cardNo].value$ = "YellowMinus2"
	next
	for i = 1 to noOfCardSprites + 4
		if (i <= noOfCards)
			cards[i].id = i
		else
			cards[i].id = mod(i, noOfCards)
			if (cards[i].id = 0) then cards[i].id = noOfCards
		endif
		if (GetSpriteExists(cards[i].sprite) = 0) then cards[i].sprite = OryUICreateSprite("")
		if (GetTextExists(cards[i].txtTop) = 0) then cards[i].txtTop = OryUICreateText("")
		if (GetTextExists(cards[i].txtCenter) = 0) then cards[i].txtCenter = OryUICreateText("")
		if (GetTextExists(cards[i].txtBottom) = 0) then cards[i].txtBottom = OryUICreateText("")
		OryUIUpdateSprite(cards[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardBack) + ";color:255,255,255,255")
		OryUIUpdateText(cards[i].txtTop, "text: ;size:4;bold:true;position:-1000,-1000;alpha:255")
		OryUIUpdateText(cards[i].txtCenter, "text: ;size:8;bold:true;position:-1000,-1000;alpha:255")
		OryUIUpdateText(cards[i].txtBottom, "text: ;size:4;bold:true;position:-1000,-1000;alpha:255")
	next
	if (GetSpriteExists(largeCard.sprite) = 0) then largeCard.sprite = OryUICreateSprite("")
	if (GetTextExists(largeCard.txtTop) = 0) then largeCard.txtTop = OryUICreateText("")
	if (GetTextExists(largeCard.txtCenter) = 0) then largeCard.txtCenter = OryUICreateText("")
	if (GetTextExists(largeCard.txtBottom) = 0) then largeCard.txtBottom = OryUICreateText("")
	OryUIUpdateSprite(largeCard.sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 4) + "," + str(cardHeight# * 4) + ";offset:center;position:-1000,-1000;depth:2")
	OryUIUpdateText(largeCard.txtTop, "text: ;size:4;bold:true;position:-1000,-1000;alpha:255")
	OryUIUpdateText(largeCard.txtCenter, "text: ;size:8;bold:true;position:-1000,-1000;alpha:255")
	OryUIUpdateText(largeCard.txtBottom, "text: ;size:4;bold:true;position:-1000,-1000;alpha:255;")
	for i = 0 to noOfDiscardPileSprites
		if (GetSpriteExists(discardPile[i].sprite) = 0) then discardPile[i].sprite = OryUICreateSprite("")
		if (discardPile[i].angle# = 0) then discardPile[i].angle# = random(355, 365)
		if (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "DoubleUp")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardDoubleUp100) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "DoubleUp"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "Freeze")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardFreeze100) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "Freeze"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "GoAgain")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardGoAgain) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "GoAgain"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "Green")
			discardPile[i].value$ = "Green"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "Red")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardRed100) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "Red"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "Reset")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardReset100) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "Reset"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "Sticky")
			discardPile[i].value$ = "Sticky"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "YellowAdd1")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd1) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "YellowAdd1"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "YellowAdd2")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd2) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "YellowAdd2"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "YellowAdd3")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowAdd3) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "YellowAdd3"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "YellowMinus1")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowMinus1) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "YellowMinus1"
		elseif (GetStringToken(locks[lockSelected].discardPile$, ",", i + 1) = "YellowMinus2")
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;image:" + str(imgCardYellowMinus2) + ";angle:" + str(discardPile[i].angle#) + ";alpha:255;depth:" + str(3000 + i))
			discardPile[i].value$ = "YellowMinus2"
		else
			discardPile[i].angle# = random(355, 365)
			OryUIUpdateSprite(discardPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 50) + ",89;alpha:0;depth:" + str(3000 + i))
			discardPile[i].value$ = ""
		endif
	next
	for i = 0 to noOfGreenPileSprites
		if (GetSpriteExists(greenPile[i].sprite) = 0) then greenPile[i].sprite = OryUICreateSprite("")
		if (i >= 1 and locks[lockSelected].greensPickedSinceReset >= i)
			if (greenPile[i].angle# = 0) then greenPile[i].angle# = random(355, 365)
			OryUIUpdateSprite(greenPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 75) + ",89;image:" + str(imgCardGreen025) + ";alpha:255;angle:" + str(greenPile[i].angle#) + ";depth:" + str(3000 + i))
			greenPile[i].value$ = "Green"
		else
			greenPile[i].angle# = random(355, 365)
			OryUIUpdateSprite(greenPile[i].sprite, "size:" + str(cardWidth# / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;position:" + str(GetViewOffsetX() + 75) + ",89;alpha:0;depth:" + str(3000 + i))
			greenPile[i].value$	= ""
		endif
	next
endfunction

function CreateItemsInAPIProjectCard(cardNo as integer)
	if (GetSpriteExists(apiProjectCard[cardNo].sprBackground) = 0)
		apiProjectCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		apiProjectCard[cardNo].sprBackground = OryUICreateSprite("size:100,12;position:-1000,-1000;depth:19")
		apiProjectCard[cardNo].txtClientID = OryUICreateText("text:;size:2.4;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtBanned = OryUICreateText("text:BANNED;size:10;bold:true;position:-1000,-1000;depth:16")
		apiProjectCard[cardNo].txtName = OryUICreateText("text:;size:4.1;bold:true;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtLastCalled = OryUICreateText("text:;size:2.4;bold:true;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtResetsIn = OryUICreateText("text:;size:2.4;bold:true;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtTokens = OryUICreateText("text:;size:2.4;bold:true;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtTokensPerMinute = OryUICreateText("text:;size:2.4;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].txtTotalRequestsMade = OryUICreateText("text:;size:2.4;position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:19")
		apiProjectCard[cardNo].sprLeftEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		apiProjectCard[cardNo].sprEditButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		apiProjectCard[cardNo].sprEditIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgEditUsersLockIcon) + ";position:-1000,-1000;depth:17")
		apiProjectCard[cardNo].sprRightEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
	endif 
endfunction

function CreateItemsInDesertedUsersCard(cardNo as integer)
	local a as integer
	
	if (GetSpriteExists(userCard[cardNo].sprBackground) = 0)
		userCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		userCard[cardNo].sprBackground = OryUICreateSprite("size:100,8;position:-1000,-1000;depth:29")
		userCard[cardNo].sprOverlay = OryUICreateSprite("size:100,8;color:0,0,0,60;position:-1000,-1000;depth:26")
		userCard[cardNo].sprUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:28")
		userCard[cardNo].txtUsername = OryUICreateText("text: ;size:2.8;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].sprTestLock = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgTestLock) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprStatus = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgStatusOfflineIcon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprRatingRibbon = OryUICreateSprite("size:-1,4;image:" + str(imgUserRatingRibbon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].txtRatingRibbon = OryUICreateText("text: ;size:2.4;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].txtTicker = OryUICreateText("text: ;size:2.2;alignment:center;position:-1000,-1000;depth:29")
		userCard[cardNo].txtRateUser = OryUICreateText("text:Rate User[colon];size:2;position:-1000,-1000;depth:27")
		for a = 1 to 5
			userCard[cardNo].sprRatingStar[a] = OryUICreateSprite("size:-1,3;offset:center;image:" + str(imgStarOff) + ";position:-1000,-1000;depth:27")
		next
		userCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:29")
		userCard[cardNo].sprLeftEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFavouriteButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFavouriteIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFavouriteOff) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprFlagButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		userCard[cardNo].sprFlagIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFlags[0]) + ";position:-1000,-1000;depth:17")
		userCard[cardNo].sprMoreButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprMoreIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgMoreIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprScrim = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";color:0,0,0,66;position:-1000,-1000;depth:6")
		userCard[cardNo].flagButtonGroup = OryUICreateButtonGroup("size:75,6;iconSize:" + str(4.6 / GetDisplayAspect()) + ",-1;position:-1000,-1000;depth:5")
		OryUISetButtonGroupItemCount(userCard[cardNo].flagButtonGroup, 8)
	endif
endfunction

function CreateItemsInGeneratedLocksCard(cardNo as integer)
	if (GetSpriteExists(generatedLocksCard[cardNo].sprBackground) = 0)
		generatedLocksCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		generatedLocksCard[cardNo].sprBackground = OryUICreateSprite("size:100,20;position:-1000,-1000;depth:19")
		generatedLocksCard[cardNo].txtID = OryUICreateText("text:XXXXX;size:2;alignment:right;position:-1000,-1000;depth:18")
		generatedLocksCard[cardNo].sprCols[1] = OryUICreateSprite("size:20,6;offset:10,0;position:-1000,-1000;depth:18")
		generatedLocksCard[cardNo].sprCols[2] = OryUICreateSprite("size:20,6;offset:10,0;position:-1000,-1000;depth:18")
		generatedLocksCard[cardNo].sprCols[3] = OryUICreateSprite("size:20,6;offset:10,0;position:-1000,-1000;depth:18")
		generatedLocksCard[cardNo].txtColHeaders[1] = OryUICreateText("text:XXX;size:2;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtColHeaders[2] = OryUICreateText("text:XXX;size:2;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtColHeaders[3] = OryUICreateText("text:XXX;size:2;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtColValues[1] = OryUICreateText("text:XXX;size:4;bold:true;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtColValues[2] = OryUICreateText("text:XXX;size:4;bold:true;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtColValues[3] = OryUICreateText("text:XXX;size:4;bold:true;alignment:center;depth:17")
		generatedLocksCard[cardNo].txtConfig = OryUICreateText("text:XXX | XXX;size:2.4;alignment:center;depth:18")
		generatedLocksCard[cardNo].rightButton = OryUICreateButton("text:;size:-1,5;position:-1000,-1000;depth:18")
	endif
endfunction

function CreateItemsInLockedUsersCard(cardNo as integer)
	local newCardWidth# as float
	local newCardAspect# as float
	
	if (GetSpriteExists(userCard[cardNo].sprBackground) = 0)
		userCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		userCard[cardNo].sprBackground = OryUICreateSprite("size:100,15;position:-1000,-1000;depth:29")
		userCard[cardNo].sprOverlay = OryUICreateSprite("size:100,15;color:0,0,0,60;position:-1000,-1000;depth:26")
		userCard[cardNo].sprModifyLockInBackground = OryUICreateSprite("size:100,15;offset:center;color:0,0,0,60;position:-1000,-1000;depth:26")
		userCard[cardNo].txtModifyLockIn = OryUICreateText("text:Modify Lock In 00[colon]00;size:4.1;position:-1000,-1000;bold:true;alignment:center;depth:25")
		userCard[cardNo].txtModifyLockInFooter = OryUICreateText("text: ;size:2.2;position:-1000,-1000;alignment:center;depth:25")
		userCard[cardNo].txtUpdateVersion = OryUICreateText("text:Unable to modify lock" + chr(10) + "User needs to update " + constAppName$ + ";size:4.1;bold:true;alignment:center;position:-1000,-1000;depth:28")		
		userCard[cardNo].sprMultipleKeyholders = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgMultipleKeyholders) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprTrustKeyholder = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgTrustKeyholder) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:28")
		userCard[cardNo].txtUsername = OryUICreateText("text: ;size:2.8;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].sprStatus = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgStatusOfflineIcon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprKeysDisabled = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgKeyDisabled) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprFreeUnlock = OryUICreateSprite("size:-1,4;offset:center;image:" + str(imgUnlockIcon) + ";color:#009051;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFakeLock = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgFakeLock) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprTestLock = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgTestLock) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprEmojiIcon = OryUICreateSprite("size:-1,4.5;offset:center;image:" + str(imgEmojiIcon) + ";position:-1000,-1000;depth:27")	
		userCard[cardNo].sprRatingRibbon = OryUICreateSprite("size:-1,4;image:" + str(imgUserRatingRibbon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].txtRatingRibbon = OryUICreateText("text: ;size:2.4;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].txtTicker = OryUICreateText("text: ;size:2.2;alignment:center;position:-1000,-1000;depth:29")
		newCardWidth# = (100 - 9) / 8
		newCardAspect# = cardWidth# / cardHeight#
		userCard[cardNo].sprFreezeLockButton = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;alpha:0;position:-1000,-1000;depth:28")
		userCard[cardNo].txtFreezeLockHeader = OryUICreateText("text:LOCK;size:1.3;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].sprFreezeLockIcon = OryUICreateSprite("size:-1,5;offset:centre;position:-1000,-1000;image:" + str(imgFreezeIconOff) + ";depth:27")
		userCard[cardNo].txtFreezeLockFooter = OryUICreateText("text:RUNNING;size:1.3;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].sprGreenCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardGreenDark) + ";depth:28")
		userCard[cardNo].txtGreenHeader = OryUICreateText("text:GREEN;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtGreenCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtGreenFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprRedCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardRedDark) + ";depth:28")
		userCard[cardNo].txtRedHeader = OryUICreateText("text:RED;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtRedCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtRedFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprYellowCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardYellowRandomDark) + ";depth:28")
		userCard[cardNo].txtYellowHeader = OryUICreateText("text:YELLOW;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtYellowCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtYellowFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprStickyCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardStickyDark) + ";depth:28")
		userCard[cardNo].txtStickyHeader = OryUICreateText("text:STICKY;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtStickyCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtStickyFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprFreezeCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardFreezeDark) + ";depth:28")
		userCard[cardNo].txtFreezeHeader = OryUICreateText("text:FREEZE;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtFreezeCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtFreezeFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprDoubleUpCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardDoubleUpDark) + ";depth:28")
		userCard[cardNo].txtDoubleUpHeader = OryUICreateText("text:DOUBLE;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtDoubleUpCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtDoubleUpFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprResetCard = OryUICreateSprite("size:" + str(newCardWidth#) + "," + str(newCardWidth# * newCardAspect#) + ";offset:center;position:-1000,-1000;image:" + str(imgCardResetDark) + ";depth:28")
		userCard[cardNo].txtResetHeader = OryUICreateText("text:RESET;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtResetCount = OryUICreateText("text: ;size:3.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].txtResetFooter = OryUICreateText("text:CARDS;size:1.3;position:-1000,-1000;bold:true;color:255,255,255,255;depth:27")
		userCard[cardNo].sprFixedCircle[1] = OryUICreateSprite("size:-1,8;offset:centre;position:-1000,-1000;image:" + str(imgCircle) + ";depth:28")
		userCard[cardNo].txtFixedCount[1] = OryUICreateText("text: ;size:3.5;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].txtFixedCircleFooter[1] = OryUICreateText("text:DAYS;size:1.3;position:-1000,-1000;depth:27")
		userCard[cardNo].sprFixedCircle[2] = OryUICreateSprite("size:-1,8;offset:centre;position:-1000,-1000;image:" + str(imgCircle) + ";depth:28")
		userCard[cardNo].txtFixedCount[2] = OryUICreateText("text: ;size:3.5;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].txtFixedCircleFooter[2] = OryUICreateText("text:HOURS;size:1.3;position:-1000,-1000;depth:27")
		userCard[cardNo].sprFixedCircle[3] = OryUICreateSprite("size:-1,8;offset:centre;position:-1000,-1000;image:" + str(imgCircle) + ";depth:28")
		userCard[cardNo].txtFixedCount[3] = OryUICreateText("text: ;size:3.5;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].txtFixedCircleFooter[3] = OryUICreateText("text:MINUTES;size:1.3;position:-1000,-1000;depth:27")
		userCard[cardNo].sprFixedCircle[4] = OryUICreateSprite("size:-1,8;offset:centre;position:-1000,-1000;image:" + str(imgCircle) + ";depth:28")
		userCard[cardNo].txtFixedCount[4] = OryUICreateText("text: ;size:3.5;position:-1000,-1000;bold:true;depth:27")
		userCard[cardNo].txtFixedCircleFooter[4] = OryUICreateText("text:SECONDS;size:1.3;position:-1000,-1000;depth:27")
		userCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:29")
		userCard[cardNo].sprUnlockButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprUnlockIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgUnlockIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprResetButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprResetIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgResetLockIcon) + "position:-1000,-1000;depth:27")

		userCard[cardNo].sprFixedHideTimerButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFixedHideTimerIcon = OryUICreateSprite("size:" + str(3.6 / GetDisplayAspect()) + ",-1;offset:centre;image:" + str(imgTimerHidden) + ";position:-1000,-1000;depth:27")
		
		userCard[cardNo].sprHideCardInfoButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprHideCardInfoIcon = OryUICreateSprite("size:" + str(3.6 / GetDisplayAspect()) + ",-1;offset:centre;image:" + str(imgCardInfoVisible) + ";position:-1000,-1000;depth:27")
		
		userCard[cardNo].sprCheckInButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].shaderCooldown = LoadSpriteShader("CooldownMask.ps")
		userCard[cardNo].sprCheckInCooldown = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgArc) + ";spriteShader:" + str(userCard[cardNo].shaderCooldown) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprCheckInIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgCheckInIcon) + ";position:-1000,-1000;depth:26")
		
		userCard[cardNo].sprLeftEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprEditButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprEditIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgEditUsersLockIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprRightEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprMoodButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprMoodIcon = OryUICreateSprite("size:" + str(5.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgEmojiIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprFavouriteButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFavouriteIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFavouriteOff) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprFlagButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		userCard[cardNo].sprFlagIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFlags[0]) + ";position:-1000,-1000;depth:17")
		userCard[cardNo].sprMoreButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprMoreIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgMoreIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprScrim = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";color:0,0,0,66;position:-1000,-1000;depth:6")
		userCard[cardNo].flagButtonGroup = OryUICreateButtonGroup("size:75,6;iconSize:" + str(4.6 / GetDisplayAspect()) + ",-1;position:-1000,-1000;depth:5")
		OryUISetButtonGroupItemCount(userCard[cardNo].flagButtonGroup, 8)
	endif
endfunction

function CreateItemsInMyLockCard(cardNo as integer)
	local a as integer
	local b as integer
	
	if (GetSpriteExists(lockCard[cardNo].sprBackground) = 0)
		lockCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		lockCard[cardNo].sprBackground = OryUICreateSprite("size:100,16;position:-1000,-1000;depth:19")
		lockCard[cardNo].sprOverlay = OryUICreateSprite("size:100,10;position:-1000,-1000;depth:15")
		lockCard[cardNo].sprDeletingBackground = OryUICreateSprite("size:100,15;offset:center;color:0,0,0,60;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtDeleting = OryUICreateText("text:Deleting;size:4.1;position:-1000,-1000;bold:true;alignment:center;depth:17")
		lockCard[cardNo].txtGroupID = OryUICreateText("text:ID;size:2;alignment:right;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprSyncStatus = OryUICreateSprite("size:-1,2;image:" + str(imgNotSynced) + ";position:-1000,-1000;depth:18")
		lockCard[cardNo].sprRibbon = OryUICreateSprite("size:-1,15;position:-1000,-1000;depth:17")
		lockCard[cardNo].txtNextChanceInHeader = OryUICreateText("text:Next Chance In;size:3.5;bold:true;position:-1000,-1000;depth:16")
		lockCard[cardNo].txtUnlocksInHeader = OryUICreateText("text:Unlocks In;size:3.5;bold:true;position:-1000,-1000;depth:16")
		lockCard[cardNo].txtCombinationHeader = OryUICreateText("text:Combination;size:4.1;bold:true;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTapToUnlock = OryUICreateText("text:Tap To Try & Unlock;size:3.8;bold:true;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTapToUnlockFooter = OryUICreateText("text:1 Chance;size:2;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTimerHidden = OryUICreateText("text:Timer Hidden;size:3.8;bold:true;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTimerHiddenFooter = OryUICreateText("text:Check back later;size:2;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtCombination = OryUICreateText("text:XXXXXXXX;size:8.3;bold:true;position:-1000,-1000;depth:18")		
		for a = 1 to 4
			lockCard[cardNo].sprCircle[a] = OryUICreateSprite("size:-1,8.4;image:" + str(imgCircle) + ";position:-1000,-1000;depth:18")
			lockCard[cardNo].txtCircleHeader[a] = OryUICreateText("text:99;size:1.3;position:-1000,-1000;depth:17")
			lockCard[cardNo].txtCircle[a] = OryUICreateText("text:99;size:4.5;bold:true;position:-1000,-1000;depth:17")
			lockCard[cardNo].txtCircleFooter[a] = OryUICreateText("text:XXXX;size:1.3;position:-1000,-1000;depth:17")														
			lockCard[cardNo].txtCirclePercentage[a] = OryUICreateText("text:99.9%;size:2.8;bold:true;position:-1000,-1000;depth:17")
			lockCard[cardNo].shaderArc[a] = LoadSpriteShader("ArcMask.ps")
			lockCard[cardNo].sprArc[a] = OryUICreateSprite("size:-1,9;image:" + str(imgArc) + ";spriteShader:" + str(lockCard[cardNo].shaderArc[a]) + ";position:-1000,-1000;depth:17")
			if (a = 4)
				for b = 1 to 7
					lockCard[cardNo].shaderChanceArc[b] = LoadSpriteShader("ArcMask.ps")
					lockCard[cardNo].sprChanceArc[b] = OryUICreateSprite("size:-1,9;offset:center;image:" + str(imgArc) + ";spriteShader:" + str(lockCard[cardNo].shaderChanceArc[b]) + ";position:-1000,-1000;depth:17")
				next
				if (lockCard[cardNo].stickerAngle = 0) then lockCard[cardNo].stickerAngle = random(350, 370)
				lockCard[cardNo].sprCircleSecretSticker[a] = OryUICreateSprite("size:-1,10.4;offset:center;image:" + str(imgRoundSecretSticker) + ";angle:" + str(lockCard[cardNo].stickerAngle) + ";position:-1000,-1000;depth:16")																								
			endif
			lockCard[cardNo].sprIceCapArch[a] = OryUICreateSprite("size:-1,10.4;offset:center;image:" + str(imgIceCapArch) + ";position:-1000,-1000;depth:16")
			SetSpriteFlip(lockCard[cardNo].sprIceCapArch[a], random(0, 1), 0)
		next
		lockCard[cardNo].txtTimeLockedHeader = OryUICreateText("text:Locked;size:3.3;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTimeLocked = OryUICreateText("text:99;size:7.3;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtTimeLockedFooter = OryUICreateText("text:Days;size:3.3;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtGreaterThanSign = OryUICreateText("text:>;size:3.3;position:-1000,-1000;depth:18")
		lockCard[cardNo].txtFooter = OryUICreateText("text:Locked;size:3;color:position:-1000,-1000;depth:18")
		lockCard[cardNo].sprUsernameButton = OryUICreateSprite("size:5,5;color:0,0,0,0;position:-1000,-1000;depth:17")
		lockCard[cardNo].sprKeyholderEmojiIcon = OryUICreateSprite("size:-1,4.5;offset:center;image:" + str(imgEmojiIcon) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].txtRateKeyholder = OryUICreateText("text:Rate Keyholder[colon];size:2;position:-1000,-1000;depth:17")
		for a = 1 to 5
			lockCard[cardNo].sprRatingStar[a] = OryUICreateSprite("size:-1,3;offset:center;image:" + str(imgStarOff) + ";position:-1000,-1000;depth:17")
		next									
		lockCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:19")
		lockCard[cardNo].sprDeleteButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprDeleteIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgDeleteIcon) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].sprUnlockButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprUnlockIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgUnlockIcon) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].sprRestartButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprRestartIcon = OryUICreateSprite("size:" + str(3.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(OryUIReturnIconID("replay")) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].sprEmptyLeftButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprCheckInButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].shaderCooldown = LoadSpriteShader("CooldownMask.ps")
		lockCard[cardNo].sprCheckInCooldown = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgArc) + ";spriteShader:" + str(lockCard[cardNo].shaderCooldown) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].sprCheckInIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgCheckInIcon) + ";position:-1000,-1000;depth:16")
		lockCard[cardNo].sprCleanButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprCleanIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;position:-1000,-1000;depth:17")
		lockCard[cardNo].sprCleanIconOverlay = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;position:-1000,-1000;depth:16")
		lockCard[cardNo].sprEmptyRightButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprMoodButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprMoodIcon = OryUICreateSprite("size:" + str(5.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgEmojiIcon) + ";position:-1000,-1000;depth:16")
		lockCard[cardNo].sprFlagButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprFlagIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFlags[0]) + ";position:-1000,-1000;depth:17")		
		lockCard[cardNo].sprMoreButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		lockCard[cardNo].sprMoreIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgMoreIcon) + ";position:-1000,-1000;depth:17")
		lockCard[cardNo].sprScrim = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";color:0,0,0,66;position:-1000,-1000;depth:6")
		lockCard[cardNo].flagButtonGroup = OryUICreateButtonGroup("size:75,6;iconSize:" + str(4.6 / GetDisplayAspect()) + ",-1;position:-1000,-1000;depth:5")
		OryUISetButtonGroupItemCount(lockCard[cardNo].flagButtonGroup, 8)
	endif
endfunction

function CreateItemsInMyLockDeletedCard(cardNo as integer)
	if (GetSpriteExists(lockDeletedCard[cardNo].sprBackground) = 0)
		lockDeletedCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		lockDeletedCard[cardNo].sprBackground = OryUICreateSprite("size:100,13;position:-1000,-1000;depth:19")
		lockDeletedCard[cardNo].rightButton = OryUICreateButton("text:;size:-1,5;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtHeader = OryUICreateText("text:;size:2;alignment:center;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtDeletedWhen = OryUICreateText("text:;size:2;alignment:right;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtLockInformation = OryUICreateText("text:;size:2.4;alignment:center;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtLockedByHidden = OryUICreateText("text:;size:2.4;position:-1000,-1000;depth:17")
		lockDeletedCard[cardNo].txtUsernameHidden = OryUICreateText("text:;size:2.4;bold:true;position:-1000,-1000;depth:17")
		lockDeletedCard[cardNo].sprUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:17")
		lockDeletedCard[cardNo].txtFooter = OryUICreateText("text:;size:2;alignment:center;position:-1000,-1000;depth:18")
	endif
endfunction

function CreateItemsInSharedLockCard(cardNo as integer)
	if (GetSpriteExists(sharedLockCard[cardNo].sprBackground) = 0)
		sharedLockCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		sharedLockCard[cardNo].sprBackground = OryUICreateSprite("size:100,21;position:-100,-100;depth:19")
		sharedLockCard[cardNo].sprOverlay = OryUICreateSprite("size:100,16;position:-1000,-1000;depth:15")
		sharedLockCard[cardNo].sprDeletingBackground = OryUICreateSprite("size:100,15;offset:center;color:0,0,0,60;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].txtDeleting = OryUICreateText("text:Deleting;size:4.1;position:-1000,-1000;bold:true;alignment:center;depth:17")
		sharedLockCard[cardNo].txtLockName = OryUICreateText("text: ;size:2;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].txtShareID = OryUICreateText("text:XXXXXXXXXXXXXXX;size:2;alignment:right;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].txtOptions = OryUICreateText("text:XXX | XXX | XXX;size:3;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].txtCards = OryUICreateText("text:XXX | XXX | XXX;size:2.4;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].txtAutoResets = OryUICreateText("text:XXX | XXX | XXX;size:2.4;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].txtCheckIns = OryUICreateText("text:XXX | XXX | XXX;size:2.4;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].txtUsers = OryUICreateText("text:XXX | XXX | XXX;size:2;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].txtRating = OryUICreateText("text:XXX | XXX | XXX;size:2.2;bold:true;alignment:center;depth:18")
		sharedLockCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:19")
		sharedLockCard[cardNo].sprDeleteButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprDeleteIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgDeleteIcon) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprCloneButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprCloneIcon = OryUICreateSprite("size:" + str(3.2 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(OryUIReturnIconID("content_copy")) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprLeftEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprManageButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprManageIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgManageUsersIcon) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprRightEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprShareButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprShareIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgShareIcon) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprShowMatchingUsersButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprShowMatchingUsersIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgShowMatchingUsersIcon) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprMoreButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:18")
		sharedLockCard[cardNo].sprMoreIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgMoreIcon) + ";position:-1000,-1000;depth:17")
		sharedLockCard[cardNo].sprVisibleButton = OryUICreateSprite("size:-1,3;color:0,0,0,255;depth:19")
		sharedLockCard[cardNo].menuShare = OryUICreateMenu("width:60;showRightIcon:false;depth:5")
		sharedLockCard[cardNo].menuShowMatchingUsers = OryUICreateMenu("width:60;showRightIcon:false;depth:5")
	endif
endfunction

function CreateItemsInSharedLockDeletedCard(cardNo as integer)
	if (GetSpriteExists(lockDeletedCard[cardNo].sprBackground) = 0)
		lockDeletedCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		lockDeletedCard[cardNo].sprBackground = OryUICreateSprite("size:100,15;position:-1000,-1000;depth:19")
		lockDeletedCard[cardNo].rightButton = OryUICreateButton("text:;size:-1,5;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtHeader = OryUICreateText("text:;size:2;alignment:center;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtDeletedWhen = OryUICreateText("text:;size:2;alignment:right;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtLockInformation = OryUICreateText("text:;size:2.4;alignment:center;position:-1000,-1000;depth:18")
		lockDeletedCard[cardNo].txtFooter = OryUICreateText("text:;size:2;alignment:center;position:-1000,-1000;depth:18")
	endif
endfunction

function CreateItemsInUnLockedUsersCard(cardNo as integer)
	local a as integer
	
	if (GetSpriteExists(userCard[cardNo].sprBackground) = 0)
		userCard[cardNo].dialog = OryUICreateDialog("autoHeight:true")
		userCard[cardNo].sprBackground = OryUICreateSprite("size:100,8;position:-1000,-1000;depth:29")
		userCard[cardNo].sprOverlay = OryUICreateSprite("size:100,8;color:0,0,0,60;position:-1000,-1000;depth:26")
		userCard[cardNo].sprUsedKey = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgUsedKey) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:28")
		userCard[cardNo].txtUsername = OryUICreateText("text: ;size:2.8;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].sprStatus = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgStatusOfflineIcon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].sprRatingRibbon = OryUICreateSprite("size:-1,4;image:" + str(imgUserRatingRibbon) + ";position:-1000,-1000;depth:28")
		userCard[cardNo].txtRatingRibbon = OryUICreateText("text: ;size:2.4;bold:true;alignment:center;position:-1000,-1000;depth:27")
		userCard[cardNo].txtTicker = OryUICreateText("text: ;size:2.2;alignment:center;position:-1000,-1000;depth:29")
		userCard[cardNo].txtRateUser = OryUICreateText("text:Rate User[colon];size:2;position:-1000,-1000;depth:27")
		for a = 1 to 5
			userCard[cardNo].sprRatingStar[a] = OryUICreateSprite("size:-1,3;offset:center;image:" + str(imgStarOff) + ";position:-1000,-1000;depth:27")
		next
		userCard[cardNo].sprButtonBar = OryUICreateSprite("size:100,5.2;position:-1000,-1000;depth:29")
		userCard[cardNo].sprLeftEmptyButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFavouriteButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFavouriteIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFavouriteOff) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprFlagButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprFlagIcon = OryUICreateSprite("size:" + str(4.6 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgFlags[0]) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprMoreButton = OryUICreateSprite("size:10,5;position:-1000,-1000;depth:28")
		userCard[cardNo].sprMoreIcon = OryUICreateSprite("size:" + str(4.8 / GetDisplayAspect()) + ",-1;offset:center;image:" + str(imgMoreIcon) + ";position:-1000,-1000;depth:27")
		userCard[cardNo].sprScrim = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";color:0,0,0,66;position:-1000,-1000;depth:6")
		userCard[cardNo].flagButtonGroup = OryUICreateButtonGroup("size:75,6;iconSize:" + str(4.6 / GetDisplayAspect()) + ",-1;position:-1000,-1000;depth:5")
		OryUISetButtonGroupItemCount(userCard[cardNo].flagButtonGroup, 8)
	endif
endfunction

function CreateItemsOnUpdateUserScreen()
	local cardImage as integer
	local i as integer
	local unit$ as string
	
	updateUser.sprUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:28")
	updateUser.txtUsername = OryUICreateText("text: ;size:4;bold:true;alignment:center;position:-1000,-1000;depth:27")
	updateUser.sprTrustKeyholder = OryUICreateSprite("size:-1,2.8;offset:center;image:" + str(imgTrustKeyholder) + ";position:-1000,-1000;depth:27")		
	updateUser.txtGreensRequiredToUnlock = OryUICreateText("text:User needs to find 1 of x green cards to unlock;size:2.6;bold:true;alignment:center;depth:27")
	updateUser.txtModifiedBy = OryUICreateText("text: ;size:3;bold:true;alignment:center;position:-1000,-1000;depth:27")
	for i = 1 to 4
		if (i = 1) then unit$ = "DAYS"
		if (i = 2) then unit$ = "HOURS"
		if (i = 3) then unit$ = "MINUTES"
		if (i = 4) then unit$ = "SECONDS"
		updateUser.btnAdd[i] = OryUICreateButton("text:;size:-1,4;offset:center;position:-1000,-1000;image:" + str(imgCircle) + ";iconID:" + str(oryUIIconAddImage) + ";depth:28")
		updateUser.sprCircle[i] = OryUICreateSprite("size:-1,12;offset:center;position:-1000,-1000;image:" + str(imgCircle) + ";depth:29")
		updateUser.txtCircle[i] = OryUICreateText("text: ;size:5;alignment:center;position:-1000,-1000;depth:28")
		updateUser.txtCircleFooter[i] = OryUICreateText("text:" + unit$ + ";size:1.8;position:-1000,-1000;depth:27")
		updateUser.btnMinus[i] = OryUICreateButton("text:;size:-1,4;offset:center;position:-1000,-1000;image:" + str(imgCircle) + ";iconID:" + str(oryUIIconSubtractImage) + ";depth:28")
	next
	for i = 1 to 11
		if (i = 1) then cardImage = imgCardGreen100
		if (i = 2) then cardImage = imgCardRed100
		if (i = 3) then cardImage = imgCardSticky100
		if (i = 4) then cardImage = imgCardYellowMinus2
		if (i = 5) then cardImage = imgCardYellowMinus1
		if (i = 6) then cardImage = imgCardYellowAdd1
		if (i = 7) then cardImage = imgCardYellowAdd2
		if (i = 8) then cardImage = imgCardYellowAdd3
		if (i = 9) then cardImage = imgCardFreeze100
		if (i = 10) then cardImage = imgCardDoubleUp100
		if (i = 11) then cardImage = imgCardReset100
		updateUser.sprCard[i] = OryUICreateSprite("size:" + str((cardWidth#) / GetDisplayAspect()) + "," + str(cardHeight#) + ";offset:center;image:" + str(cardImage) + ";depth:28")
		updateUser.txtCardModifiedBy[i] = OryUICreateText("text: ;size:2.4;bold:true;alignment:center;depth:28")
		updateUser.spinCardCount[i] = OryUICreateInputSpinner("size:" + str(((cardWidth#) + (oryUIDefaults.inputSpinnerButtonWidth# / 2)) / GetDisplayAspect()) + ",4;addIconSize:-1,2.7;subtractIconSize:-1,2.7;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:28")
		updateUser.txtCardPercentage[i] = OryUICreateText("text: ;size:2.4;bold:true;alignment:center;depth:28")
		updateUser.txtCardPickedCount[i] = OryUICreateText("text: ;size:2.2;bold:true;alignment:center;depth:28")
	next
	updateUser.crdHideUpdate = OryUICreateTextCard("width:94;headerText:Do you want to hide this update?;supportingText:Hiding it will show as 'Update hidden' on the lockee side.;position:-1000,-1000;autoHeight:true;depth:19")
	updateUser.grpHideUpdate = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
	OryUIInsertButtonGroupItem(updateUser.grpHideUpdate, -1, "name:Yes;text:Yes")
	OryUIInsertButtonGroupItem(updateUser.grpHideUpdate, -1, "name:No;text:No")
endfunction

function CreateNewLock(combination$, fake, id, noOfLocksInGroup)
	local a as integer
	local fileID as integer
	local i as integer
	local lockNo as integer
	local noOfDoubleUps as integer
	local noOfFreezes as integer
	local noOfGreens as integer
	local noOfMinutes as integer
	local noOfReds as integer
	local noOfResets as integer
	local noOfStickies as integer
	local noOfYellowsRandom as integer
	local noOfYellowsAdd as integer
	local noOfYellowsAdd1 as integer
	local noOfYellowsAdd2 as integer
	local noOfYellowsAdd3 as integer
	local noOfYellowsMinus as integer
	local noOfYellowsMinus1 as integer
	local noOfYellowsMinus2 as integer
	local randomYellow as integer
	local totalRequiredCards as integer
	
	GetLocksData()
	inc noOfLocks
	SaveLocalVariable("noOfLocks", str(noOfLocks))
	lockNo = noOfLocks
	
	if (lockGroupID > 1500000000) then timestampNow = lockGroupID
	
	// Bot settings
	if (botControlled = 1)
		if (botChosen = 1) then sharedID$ = "BOT01"
		if (botChosen = 2) then sharedID$ = "BOT02"
		if (botChosen = 3) then sharedID$ = "BOT03"
		if (botChosen = 4) then sharedID$ = "BOT04"
		if (botChosen = 1 or botChosen = 2)
			if (fixed = 0)
				if (cumulative = 3)
					if (random(1, 100) <= 50)
						cumulative = 1
					else
						cumulative = 0
					endif
				endif
				if (yellowCards = 3)
					if (random(1, 100) <= 70)
						maxYellowsRandom = random(0, floor(maxReds / 2.0))
						minYellowsRandom = random(0, maxYellowsRandom)
					else
						maxYellowsRandom = 0
						minYellowsRandom = 0
					endif
				endif
				if (freezeCards = 3)
					if (random(1, 100) <= 20)
						maxFreezes = random(0, 3)
						minFreezes = random(0, maxFreezes)
					else
						maxFreezes = 0
						minFreezes = 0
					endif
				endif
				if (doubleUpCards = 3)
					if (random(1, 100) <= 15)
						maxDoubleUps = random(1, 2)
						minDoubleUps = random(1, maxDoubleUps)
					else
						maxDoubleUps = 0
						minDoubleUps = 0
					endif
				endif
				if (resetCards = 3)
					if (random(1, 100) <= 15)
						maxResets = random(1, 2)
						minResets = random(1, maxResets)
					else
						maxResets = 0
						minResets = 0
					endif
				endif
				if (stickyCards = 3)
					if (random(1, 100) <= 15)
						maxStickies = random(1, 2)
						minStickies = random(1, maxStickies)
					else
						maxStickies = 0
						minStickies = 0
					endif
				endif
				if (multipleGreensRequired = 3)
					if (random(1, 100) <= 35)
						multipleGreensRequired = 1
						maxGreens = random(2, 4)
						minGreens = random(2, maxGreens)
					else
						multipleGreensRequired = 0
						maxGreens = 1
						minGreens = 1
					endif
				endif
				if (cardInfoHidden = 3)
					if (random(1, 100) <= 20)
						cardInfoHidden = 1
					else
						cardInfoHidden = 0
					endif
				endif
			endif
			if (fixed = 1)
				if (timerHidden = 3)
					if (random(1, 100) <= 25)
						timerHidden = 0
					else
						timerHidden = 1
					endif
				endif
			endif
		endif
		if (botChosen = 3 or botChosen = 4)
			if (fixed = 0)
				if (cumulative = 3)
					if (random(1, 100) <= 25)
						cumulative = 1
					else
						cumulative = 0
					endif
				endif
				if (yellowCards = 3)
					if (random(1, 100) <= 50)
						maxYellowsRandom = random(0, floor(maxReds / 1.5))
						minYellowsRandom = random(0, maxYellowsRandom)
					else
						maxYellowsRandom = 0
						minYellowsRandom = 0
					endif
				endif
				if (freezeCards = 3)
					if (random(1, 100) <= 35)
						maxFreezes = random(1, 5)
						minFreezes = random(1, maxFreezes)
					else
						maxFreezes = 0
						minFreezes = 0
					endif
				endif
				if (doubleUpCards = 3)
					if (random(1, 100) <= 30)
						maxDoubleUps = random(1, 4)
						minDoubleUps = random(1, maxDoubleUps)
					else
						maxDoubleUps = 0
						minDoubleUps = 0
					endif
				endif
				if (resetCards = 3)
					if (random(1, 100) <= 30)
						maxResets = random(1, 4)
						minResets = random(1, maxResets)
					else
						maxResets = 0
						minResets = 0
					endif
				endif
				if (stickyCards = 3)
					if (random(1, 100) <= 25)
						maxStickies = random(1, 4)
						minStickies = random(1, maxStickies)
					else
						maxStickies = 0
						minStickies = 0
					endif
				endif
				if (multipleGreensRequired = 3)
					if (random(1, 100) <= 65)
						multipleGreensRequired = 1
						maxGreens = random(2, 8)
						minGreens = random(2, maxGreens)
					else
						multipleGreensRequired = 0
						maxGreens = 1
						minGreens = 1
					endif
				endif
				if (cardInfoHidden = 3)
					if (random(1, 100) <= 35)
						cardInfoHidden = 1
					else
						cardInfoHidden = 0
					endif
				endif
			endif
			if (fixed = 1)
				if (timerHidden = 3)
					if (random(1, 100) <= 50)
						timerHidden = 0
					else
						timerHidden = 1
					endif
				endif
			endif
		endif
	else
		botChosen = 0
	endif
	
	// Repeat until deck has at least one of the required cards
	if (fixed = 0)
		repeat
			totalRequiredCards = 0
			noOfDoubleUps = random(minDoubleUps, maxDoubleUps)
			noOfFreezes = random(minFreezes, maxFreezes)
			noOfGreens = random(minGreens, maxGreens)
			noOfReds = random(minReds, maxReds)
			noOfResets = random(minResets, maxResets)
			noOfStickies = random(minStickies, maxStickies)
			noOfYellowsRandom = random(minYellowsRandom, maxYellowsRandom)
			noOfYellowsAdd1 = 0
			noOfYellowsAdd2 = 0
			noOfYellowsAdd3 = 0
			noOfYellowsMinus1 = 0
			noOfYellowsMinus2 = 0
			for i = 1 to noOfYellowsRandom
				randomYellow = random(1, 5)
				if (randomYellow = 1) then inc noOfYellowsAdd1
				if (randomYellow = 2) then inc noOfYellowsAdd2
				if (randomYellow = 3) then inc noOfYellowsAdd3
				if (randomYellow = 4) then inc noOfYellowsMinus1
				if (randomYellow = 5) then inc noOfYellowsMinus2
			next
			noOfYellowsMinus = random(minYellowsMinus, maxYellowsMinus)
			for i = 1 to noOfYellowsMinus
				randomYellow = random(1, 2)
				if (randomYellow = 1) then inc noOfYellowsMinus1
				if (randomYellow = 2) then inc noOfYellowsMinus2
			next
			noOfYellowsAdd = random(minYellowsAdd, maxYellowsAdd)
			for i = 1 to noOfYellowsAdd
				randomYellow = random(1, 3)
				if (randomYellow = 1) then inc noOfYellowsAdd1
				if (randomYellow = 2) then inc noOfYellowsAdd2
				if (randomYellow = 3) then inc noOfYellowsAdd3
			next
			totalRequiredCards = noOfFreezes + noOfReds + noOfStickies + noOfYellowsAdd1 + noOfYellowsAdd2 + noOfYellowsAdd3
		until (totalRequiredCards >= 1)
	endif
	if (fixed = 1)
		if (regularity# = 0.016667)
			repeat
				noOfMinutes = random2(minMinutes, maxMinutes)
			until (noOfMinutes >= 1)
		else
			repeat
				noOfReds = random(minReds, maxReds)
			until (noOfReds >= 1)
		endif
	endif
	
	// Set and save lock data
	locks[lockNo].sortKey$ = ""
	locks[lockNo].autoResetsPaused = 0
	locks[lockNo].blockBotFromUnlocking = 0
	locks[lockNo].blockUsersAlreadyLocked = blockUsersAlreadyLocked
	locks[lockNo].botChosen = botChosen
	locks[lockNo].build = constBuildNumber
	locks[lockNo].cardInfoHidden = cardInfoHidden
	locks[lockNo].chancesAccumulatedBeforeFreeze = 0
	locks[lockNo].checkInFrequencyInSeconds = checkInFrequencyInSeconds
	locks[lockNo].combination$ = combination$
	locks[lockNo].cumulative = cumulative
	locks[lockNo].dateLastPicked$ = ""
	locks[lockNo].dateLocked$ = dateFromServer$
	locks[lockNo].dateUnlocked$ = ""
	locks[lockNo].deleting = 0
	locks[lockNo].discardPile$ = ""
	locks[lockNo].displayInStats = 1
	locks[lockNo].doubleUpCards = noOfDoubleUps
	locks[lockNo].doubleUpCardsAdded = 0
	locks[lockNo].doubleUpCardsPicked = 0
	locks[lockNo].emojiChosen = 0
	locks[lockNo].emojiColourSelected = 1
	locks[lockNo].fake = fake
	locks[lockNo].filterIn = 0
	locks[lockNo].fixed = fixed
	locks[lockNo].flagChosen = 0
	locks[lockNo].freezeCards = noOfFreezes
	locks[lockNo].freezeCardsAdded = 0
	locks[lockNo].goAgainCards = 0
	if (fixed = 0)
		locks[lockNo].goAgainCardsPercentage# = random(minGoAgainPercentage# * 100.0, maxGoAgainPercentage# * 100.0) / 100.0
	else
		locks[lockNo].goAgainCardsPercentage# = 0
	endif
	locks[lockNo].greenCards = noOfGreens
	locks[lockNo].greensPickedSinceReset = 0
	locks[lockNo].groupID = lockGroupID
	locks[lockNo].hiddenFromOwner = 0
	locks[lockNo].hiddenFromOwnerAlertHidden = 0
	locks[lockNo].hideGreensUntilPickCount = 0
	locks[lockNo].id = lockGroupID + id	
	locks[lockNo].initialDoubleUpCards = noOfDoubleUps
	locks[lockNo].initialFreezeCards = noOfFreezes
	locks[lockNo].initialGreenCards = noOfGreens
//~	locks[lockNo].initialMaximumDoubleUpCards = maxDoubleUps
//~	locks[lockNo].initialMaximumFreezeCards = maxFreezes
//~	locks[lockNo].initialMaximumGreenCards = maxGreens
//~	locks[lockNo].initialMaximumMinutes = maxMinutes
//~	locks[lockNo].initialMaximumRedCards = maxReds
//~	locks[lockNo].initialMaximumResetCards = maxResets
//~	locks[lockNo].initialMaximumStickyCards = maxStickies
//~	locks[lockNo].initialMaximumYellowAddCards = maxYellowsAdd
//~	locks[lockNo].initialMaximumYellowMinusCards = maxYellowsMinus
//~	locks[lockNo].initialMaximumYellowRandomCards = maxYellowsRandom
//~	locks[lockNo].initialMinimumDoubleUpCards = minDoubleUps
//~	locks[lockNo].initialMinimumFreezeCards = minFreezes
//~	locks[lockNo].initialMinimumGreenCards = minGreens
//~	locks[lockNo].initialMinimumMinutes = minMinutes
//~	locks[lockNo].initialMinimumRedCards = minReds
//~	locks[lockNo].initialMinimumResetCards = minResets
//~	locks[lockNo].initialMinimumStickyCards = minStickies
//~	locks[lockNo].initialMinimumYellowAddCards = minYellowsAdd
//~	locks[lockNo].initialMinimumYellowMinusCards = minYellowsMinus
//~	locks[lockNo].initialMinimumYellowRandomCards = minYellowsRandom
	locks[lockNo].initialMinutes = noOfMinutes
	locks[lockNo].initialRedCards = noOfReds
	locks[lockNo].initialResetCards = noOfResets
	locks[lockNo].initialStickyCards = noOfStickies
	locks[lockNo].initialYellowAdd1Cards = noOfYellowsAdd1
	locks[lockNo].initialYellowAdd2Cards = noOfYellowsAdd2
	locks[lockNo].initialYellowAdd3Cards = noOfYellowsAdd3
	locks[lockNo].initialYellowCards = noOfYellowsAdd1 + noOfYellowsAdd2 + noOfYellowsAdd3 + noOfYellowsMinus1 + noOfYellowsMinus2
	locks[lockNo].initialYellowMinus1Cards = noOfYellowsMinus1
	locks[lockNo].initialYellowMinus2Cards = noOfYellowsMinus2
	locks[lockNo].iteration = lockNo
	locks[lockNo].keyDisabled = keyDisabled
	locks[lockNo].keyholderAllowsFreeUnlock = 0
	locks[lockNo].keyholderBuildNumberInstalled = 0
	locks[lockNo].keyholderDecisionDisabled = keyholderDecisionDisabled
	locks[lockNo].keyholderDisabledKey = keyholderDisabledKey
	locks[lockNo].keyholderEmojiChosen = 0
	locks[lockNo].keyholderEmojiColourSelected = 1
	locks[lockNo].keyholderID = 0
	locks[lockNo].keyholderLastActive = 0
	locks[lockNo].keyholderMainRole = 0
	locks[lockNo].keyholderMainRoleLevel = 0
	locks[lockNo].keyholderStatus = 0
	locks[lockNo].keyholderUsername$ = ""
	locks[lockNo].keyUsed = 0
	locks[lockNo].lastUpdateIDSeen = 0
	locks[lockNo].lateCheckInWindowInSeconds = lateCheckInWindowInSeconds
	locks[lockNo].lockFrozenByCard = 0
	locks[lockNo].lockFrozenByKeyholder = startLockFrozen
	//locks[lockNo].lockFrozenByLockee = 0
	locks[lockNo].lockLog.length = -1
	locks[lockNo].lockName$ = sharedLockName$
	locks[lockNo].maximumAutoResets = maxAutoResets
	if (fixed = 0)
		if (maxReds = 0)
			locks[lockNo].minimumRedCards = 1
		elseif (minReds <> maxReds)
			locks[lockNo].minimumRedCards = minReds
		else
			locks[lockNo].minimumRedCards = 1
		endif
		locks[lockNo].maximumRedCards = maxReds
	else
		if (fixed = 1 and regularity# >= 0.25)
			locks[lockNo].minimumRedCards = minReds
			locks[lockNo].maximumRedCards = maxReds
		else
			locks[lockNo].minimumMinutes = minMinutes
			locks[lockNo].maximumMinutes = maxMinutes
		endif
	endif
	locks[lockNo].minutes = noOfMinutes
	locks[lockNo].minutesAdded = 0
	if (multipleGreensRequired = 2) then multipleGreensRequired = 0
	locks[lockNo].multipleGreensRequired = multipleGreensRequired
	locks[lockNo].noOfAdd1Cards = noOfYellowsAdd1
	locks[lockNo].noOfAdd2Cards = noOfYellowsAdd2
	locks[lockNo].noOfAdd3Cards = noOfYellowsAdd3
	locks[lockNo].noOfKeysRequired = noOfKeysRequired
	locks[lockNo].noOfMinus1Cards = noOfYellowsMinus1
	locks[lockNo].noOfMinus2Cards = noOfYellowsMinus2
	locks[lockNo].noOfTimesAutoReset = 0
	locks[lockNo].noOfTimesCardReset = 0
	locks[lockNo].noOfTimesFullReset = 0
	locks[lockNo].noOfTimesGreenCardRevealed = 0
	locks[lockNo].noOfTimesReset = 0
	locks[lockNo].notificationID = 0
	locks[lockNo].notificationTimestamp = 0
	locks[lockNo].percentageTimer = 0
	locks[lockNo].permanent = permanent
	locks[lockNo].pickedCount = 0
	locks[lockNo].pickedCountIncludingYellows = 0
	locks[lockNo].pickedCountSinceReset = 0
	locks[lockNo].randomCardsAdded = 0
	locks[lockNo].rating = 0
	locks[lockNo].readyToUnlock = 0
	locks[lockNo].redCards = noOfReds
	locks[lockNo].redCardsAdded = 0
	locks[lockNo].regularity# = regularity#
	locks[lockNo].removedByKeyholder = 0
	locks[lockNo].removedByKeyholderAlertHidden = 0
	locks[lockNo].resetCards = noOfResets
	locks[lockNo].resetCardsAdded = 0
	locks[lockNo].resetCardsPicked = 0
	locks[lockNo].resetFrequencyInSeconds = resetFrequencyInSeconds
	locks[lockNo].ribbonType$ = ""
	locks[lockNo].rowInDB = 0
	locks[lockNo].sharedID$ = sharedID$
	locks[lockNo].simulationAverageMinutesLocked = ceil(simulationAverageMinutesLocked / 100)
	locks[lockNo].simulationBestCaseMinutesLocked = simulationBestCaseMinutesLocked
	locks[lockNo].simulationWorstCaseMinutesLocked = simulationWorstCaseMinutesLocked
	locks[lockNo].stickyCards = noOfStickies
	locks[lockNo].test = testLock
	locks[lockNo].timeLeftUntilNextChanceBeforeFreeze = 0
	locks[lockNo].timerHidden = timerHidden
	locks[lockNo].timestampCleanTimeRequestBlockedUntil = 0
	locks[lockNo].timestampDeniedCleanTime = 0
	locks[lockNo].timestampEndedCleanTime = 0
	locks[lockNo].timestampFrozenByCard = 0
	if (startLockFrozen = 0)
		locks[lockNo].timestampFrozenByKeyholder = 0
	else
		locks[lockNo].timestampFrozenByKeyholder = timestampNow
	endif
	//locks[lockNo].timestampFrozenByLockee = 0
	locks[lockNo].timestampHiddenFromOwner = 0
	locks[lockNo].timestampKeyholderRated = 0
	locks[lockNo].timestampLastAutoReset = 0
	locks[lockNo].timestampLastCardReset = 0
	locks[lockNo].timestampLastCheckedIn = 0
	locks[lockNo].timestampLastCheckedUpdates = 0
	locks[lockNo].timestampLastFullReset = 0
	if (regularity# = 0.016667)
		locks[lockNo].timestampLastPicked = timestampNow - 60
	elseif (regularity# = 0.25)
		locks[lockNo].timestampLastPicked = timestampNow - 900
	elseif (regularity# = 0.50)
		locks[lockNo].timestampLastPicked = timestampNow - 1800
	elseif (regularity# = 1)
		locks[lockNo].timestampLastPicked = timestampNow - 3600
	elseif (regularity# = 3)
		locks[lockNo].timestampLastPicked = timestampNow - 10800
	elseif (regularity# = 6)
		locks[lockNo].timestampLastPicked = timestampNow - 21600
	elseif (regularity# = 12)
		locks[lockNo].timestampLastPicked = timestampNow - 43200
	elseif (regularity# = 24)
		locks[lockNo].timestampLastPicked = timestampNow - 86400
	endif
	locks[lockNo].timestampLastReset = 0
	locks[lockNo].timestampLastSynced = 0
	locks[lockNo].timestampLastUpdated = 0
	locks[lockNo].timestampLocked = timestampNow
	locks[lockNo].timestampRated = 0
	locks[lockNo].timestampRealLastPicked = 0
	locks[lockNo].timestampRemovedByKeyholder = 0
	locks[lockNo].timestampRequestedCleanTime = 0
	locks[lockNo].timestampRequestedKeyholdersDecision = 0
	locks[lockNo].timestampRibbonAdded = 0
	locks[lockNo].timestampStartedCleanTime = 0
	locks[lockNo].timestampUnfreezes = 0
	locks[lockNo].timestampUnfrozen = 0
	locks[lockNo].timestampUnlocked = 0
	locks[lockNo].totalTimeCleaning = 0
	locks[lockNo].totalTimeFrozen = 0
	locks[lockNo].trustKeyholder = trustKeyholder
	locks[lockNo].unlocked = 0
	locks[lockNo].version$ = constVersionNumber$
	locks[lockNo].yellowCards = noOfYellowsAdd1 + noOfYellowsAdd2 + noOfYellowsAdd3 + noOfYellowsMinus1 + noOfYellowsMinus2
	
	if (testLock = 1) then locks[lockNo].displayInStats = 0
	if (locks[lockNo].cardInfoHidden = 1) then locks[lockNo].goAgainCards = floor((GetNoOfCards(lockNo) / 100.0) * locks[lockNo].goAgainCardsPercentage#)
	if (keyholderUsername$ <> "") then locks[lockNo].keyholderUsername$ = keyholderUsername$
	if (botChosen = 1) then locks[lockNo].keyholderUsername$ = "Hailey"
	if (botChosen = 2) then locks[lockNo].keyholderUsername$ = "Blaine"
	if (botChosen = 3) then locks[lockNo].keyholderUsername$ = "Zoe"
	if (botChosen = 4) then locks[lockNo].keyholderUsername$ = "Chase"

	UpdateLocksData(lockNo)
	fileID = OpenToWrite("locksV2.txt", 0)
	for a = 1 to 20
		WriteInteger(fileID, locks[a].id)
	next
	CloseFile(fileID)
	ResetAllNotifications()
	UpdateLocksDatabase(lockNo, "action:StartedLock;actionedBy:Lockee", 1)
endfunction

function CreateNewSharedLock(addToFront)
	if (maintenance = 1) then exitfunction
	
	local minVersionRequired$ as string
	local postData$ as string
	
	// Decide the minimum version required to load the lock
	minVersionRequired$ = "2.3.0"
	if (minGreens > 1 or maxGreens > 1) then minVersionRequired$ = "2.3.4.beta.1"
	if (minDoubleUps > 0 or maxDoubleUps > 0) then minVersionRequired$ = "2.3.4.beta.1"
	if (multipleGreensRequired = 1) then minVersionRequired$ = "2.3.4.beta.1"
	if (cardInfoHidden = 1) then minVersionRequired$ = "2.4.0.beta.1"
	if (maxYellowsAdd > 0 or maxYellowsMinus > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (minFreezes > 0 or maxFreezes > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (maxUsers > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (regularity# = 0.5 or (regularity# > 1 and regularity# < 24)) then minVersionRequired$ = "2.4.0.beta.1"
	if (blockUsersAlreadyLocked = 1) then minVersionRequired$ = "2.4.0.beta.1"
	if (blockUsersWithStatsHidden = 1) then minVersionRequired$ = "2.5.0.alpha.8"
	if (fixed = 1) then minVersionRequired$ = "2.5.0.alpha.1"
	if (minCopies > 0) then minVersionRequired$ = "2.5.0.alpha.1"
	if (requireDM > 0) then minVersionRequired$ = "2.5.0.alpha.1"
	if (autoResetLock = 1) then minVersionRequired$ = "2.5.2.alpha.1"
	if (keyholderDecisionDisabled = 1) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minDoubleUps > 20 or maxDoubleUps > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minFreezes > 20 or maxFreezes > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minGreens > 20 or maxGreens > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minRatingRequired = 1) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minReds > 399 or maxReds > 399) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minResets > 20 or maxResets > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minYellowsAdd > 200 or maxYellowsAdd > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minYellowsMinus > 200 or maxYellowsMinus > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minYellowsRandom > 200 or maxYellowsRandom > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (fixed = 0 and regularity# = 0.016667) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minStickies > 0 or maxStickies > 0) then minVersionRequired$ = "2.5.3.alpha.2"
	if (minDoubleUps > 30 or maxDoubleUps > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (minFreezes > 30 or maxFreezes > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (minGreens > 30 or maxGreens > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (minResets > 30 or maxResets > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (minStickies > 30 or maxStickies > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (startLockFrozen = 1) then minVersionRequired$ = "2.6.2.alpha.1"
	if (checkInFrequencyInSeconds > 0) then minVersionRequired$ = "2.6.3.alpha.1"
	if (lateCheckInWindowInSeconds > 0) then minVersionRequired$ = "2.6.8.alpha.1"
	if (blockTestLocks = 1) then minVersionRequired$ = "2.7.2.alpha.1"
	
	postData$ = ""
	postData$ = postData$ + "&blockTestLocks=" + str(blockTestLocks)
	postData$ = postData$ + "&blockUsersAlreadyLocked=" + str(blockUsersAlreadyLocked)
	postData$ = postData$ + "&blockUsersWithStatsHidden=" + str(blockUsersWithStatsHidden)
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&cardInfoHidden=" + str(cardInfoHidden)
	postData$ = postData$ + "&checkInFrequencyInSeconds=" + str(checkInFrequencyInSeconds)
	postData$ = postData$ + "&cumulative=" + str(cumulative)
	postData$ = postData$ + "&fixed=" + str(fixed)
	postData$ = postData$ + "&forceTrust=" + str(forceTrust)
	postData$ = postData$ + "&keyDisabled=" + str(keyDisabled)
	postData$ = postData$ + "&keyholderDecisionDisabled=" + str(keyholderDecisionDisabled)
	postData$ = postData$ + "&lateCheckInWindowInSeconds=" + str(lateCheckInWindowInSeconds)
	postData$ = postData$ + "&maxAutoResets=" + str(maxAutoResets)
	postData$ = postData$ + "&maxCopies=" + str(maxCopies)
	postData$ = postData$ + "&maxDoubleUps=" + str(maxDoubleUps)
	postData$ = postData$ + "&maxFreezes=" + str(maxFreezes)
	postData$ = postData$ + "&maxGreens=" + str(maxGreens)
	postData$ = postData$ + "&maxMinutes=" + str(maxMinutes)
	postData$ = postData$ + "&maxReds=" + str(maxReds)
	postData$ = postData$ + "&maxResets=" + str(maxResets)
	postData$ = postData$ + "&maxStickies=" + str(maxStickies)
	postData$ = postData$ + "&maxUsers=" + str(maxUsers)
	postData$ = postData$ + "&maxYellowsAdd=" + str(maxYellowsAdd)
	postData$ = postData$ + "&maxYellowsMinus=" + str(maxYellowsMinus)
	postData$ = postData$ + "&maxYellowsRandom=" + str(maxYellowsRandom)
	postData$ = postData$ + "&minCopies=" + str(minCopies)
	postData$ = postData$ + "&minDoubleUps=" + str(minDoubleUps)
	postData$ = postData$ + "&minFreezes=" + str(minFreezes)
	postData$ = postData$ + "&minGreens=" + str(minGreens)
	postData$ = postData$ + "&minMinutes=" + str(minMinutes)
	postData$ = postData$ + "&minRatingRequired=" + str(minRatingRequired)
	postData$ = postData$ + "&minReds=" + str(minReds)
	postData$ = postData$ + "&minResets=" + str(minResets)
	postData$ = postData$ + "&minStickies=" + str(minStickies)
	postData$ = postData$ + "&minVersionRequired=" + ReplaceString(minVersionRequired$, " ", ".", -1)
	postData$ = postData$ + "&minYellowsAdd=" + str(minYellowsAdd)
	postData$ = postData$ + "&minYellowsMinus=" + str(minYellowsMinus)
	postData$ = postData$ + "&minYellowsRandom=" + str(minYellowsRandom)
	postData$ = postData$ + "&multipleGreensRequired=" + str(multipleGreensRequired)
	postData$ = postData$ + "&regularity=" + str(regularity#)
	postData$ = postData$ + "&requireDM=" + str(requireDM)
	postData$ = postData$ + "&resetFrequencyInSeconds=" + str(resetFrequencyInSeconds)
	postData$ = postData$ + "&shareID=" + shareID$
	postData$ = postData$ + "&simulationAverageMinutesLocked=" + str(ceil(simulationAverageMinutesLocked / 100))
	postData$ = postData$ + "&simulationBestCaseMinutesLocked=" + str(simulationBestCaseMinutesLocked)
	postData$ = postData$ + "&simulationWorstCaseMinutesLocked=" + str(simulationWorstCaseMinutesLocked)
	postData$ = postData$ + "&startLockFrozen=" + str(startLockFrozen)
	postData$ = postData$ + "&timerHidden=" + str(timerHidden)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:CreateNewSharedLock;script:" + URLs[0].URLPath + "/" + URLs[0].CreateNewSharedLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function CreateSimulationDeck(newLock as integer)
	local i as integer
	local randomYellow as integer
	
	simulationDeck$.length = -1
	simulationNoOfDoubleUps = 0
	simulationNoOfFreezes = 0
	simulationNoOfGreens = 0
	simulationNoOfReds = 0
	simulationNoOfResets = 0
	simulationNoOfStickies = 0
	simulationNoOfYellows = 0
	simulationNoOfYellowsAdd1 = 0
	simulationNoOfYellowsAdd2 = 0
	simulationNoOfYellowsAdd3 = 0
	simulationNoOfYellowsMinus1 = 0
	simulationNoOfYellowsMinus2 = 0

	if (botChosen = 1 or botChosen = 2)
		if (fixed = 0)
			if (yellowCards = 3)
				if (random(1, 100) <= 70)
					maxYellowsRandom = random(0, floor(maxReds / 2.0))
					minYellowsRandom = random(0, maxYellowsRandom)
				else
					maxYellowsRandom = 0
					minYellowsRandom = 0
				endif
			endif
			if (freezeCards = 3)
				if (random(1, 100) <= 20)
					maxFreezes = random(0, 3)
					minFreezes = random(0, maxFreezes)
				else
					maxFreezes = 0
					minFreezes = 0
				endif
			endif
			if (doubleUpCards = 3)
				if (random(1, 100) <= 15)
					maxDoubleUps = random(1, 2)
					minDoubleUps = random(1, maxDoubleUps)
				else
					maxDoubleUps = 0
					minDoubleUps = 0
				endif
			endif
			if (resetCards = 3)
				if (random(1, 100) <= 15)
					maxResets = random(1, 2)
					minResets = random(1, maxResets)
				else
					maxResets = 0
					minResets = 0
				endif
			endif
			if (stickyCards = 3)
				if (random(1, 100) <= 15)
					maxStickies = random(1, 2)
					minStickies = random(1, maxStickies)
				else
					maxStickies = 0
					minStickies = 0
				endif
			endif
			if (multipleGreensRequired = 3)
				if (random(1, 100) <= 35)
					multipleGreensRequired = 1
					maxGreens = random(2, 4)
					minGreens = random(2, maxGreens)
				else
					multipleGreensRequired = 0
					maxGreens = 1
					minGreens = 1
				endif
			endif
		endif
	endif
	if (botChosen = 3 or botChosen = 4)
		if (fixed = 0)
			if (yellowCards = 3)
				if (random(1, 100) <= 50)
					maxYellowsRandom = random(0, floor(maxReds / 1.5))
					minYellowsRandom = random(0, maxYellowsRandom)
				else
					maxYellowsRandom = 0
					minYellowsRandom = 0
				endif
			endif
			if (freezeCards = 3)
				if (random(1, 100) <= 35)
					maxFreezes = random(1, 5)
					minFreezes = random(1, maxFreezes)
				else
					maxFreezes = 0
					minFreezes = 0
				endif
			endif
			if (doubleUpCards = 3)
				if (random(1, 100) <= 30)
					maxDoubleUps = random(1, 4)
					minDoubleUps = random(1, maxDoubleUps)
				else
					maxDoubleUps = 0
					minDoubleUps = 0
				endif
			endif
			if (resetCards = 3)
				if (random(1, 100) <= 30)
					maxResets = random(1, 4)
					minResets = random(1, maxResets)
				else
					maxResets = 0
					minResets = 0
				endif
			endif
			if (stickyCards = 3)
				if (random(1, 100) <= 25)
					maxStickies = random(1, 4)
					minStickies = random(1, maxStickies)
				else
					maxStickies = 0
					minStickies = 0
				endif
			endif
			if (multipleGreensRequired = 3)
				if (random(1, 100) <= 65)
					multipleGreensRequired = 1
					maxGreens = random(2, 8)
					minGreens = random(2, maxGreens)
				else
					multipleGreensRequired = 0
					maxGreens = 1
					minGreens = 1
				endif
			endif
		endif
	endif

	for i = 1 to random(minDoubleUps, maxDoubleUps)
		AddCardToSimulationDeck("DoubleUp")
	next
	for i = 1 to random(minFreezes, maxFreezes)
		AddCardToSimulationDeck("Freeze")
	next
	for i = 1 to random(minGreens, maxGreens)
		AddCardToSimulationDeck("Green")
	next
	for i = 1 to random(minReds, maxReds)
		AddCardToSimulationDeck("Red")
	next
	for i = 1 to random(minResets, maxResets)
		AddCardToSimulationDeck("Reset")
	next
	for i = 1 to random(minStickies, maxStickies)
		AddCardToSimulationDeck("Sticky")
	next
	for i = 1 to random(minYellowsRandom, maxYellowsRandom)
		randomYellow = random(1, 5)
		if (randomYellow = 1) then AddCardToSimulationDeck("YellowAdd1")
		if (randomYellow = 2) then AddCardToSimulationDeck("YellowAdd2")
		if (randomYellow = 3) then AddCardToSimulationDeck("YellowAdd3")
		if (randomYellow = 4) then AddCardToSimulationDeck("YellowMinus1")
		if (randomYellow = 5) then AddCardToSimulationDeck("YellowMinus2")
	next
	for i = 1 to random(minYellowsAdd, maxYellowsAdd)
		randomYellow = random(1, 3)
		if (randomYellow = 1) then AddCardToSimulationDeck("YellowAdd1")
		if (randomYellow = 2) then AddCardToSimulationDeck("YellowAdd2")
		if (randomYellow = 3) then AddCardToSimulationDeck("YellowAdd3")
	next
	for i = 1 to random(minYellowsMinus, maxYellowsMinus)
		randomYellow = random(1, 2)
		if (randomYellow = 1) then AddCardToSimulationDeck("YellowMinus1")
		if (randomYellow = 2) then AddCardToSimulationDeck("YellowMinus2")
	next
	for i = 1 to random(minYellowsAdd1, maxYellowsAdd1)
		AddCardToSimulationDeck("YellowAdd1")
	next
	for i = 1 to random(minYellowsAdd2, maxYellowsAdd2)
		AddCardToSimulationDeck("YellowAdd2")
	next
	for i = 1 to random(minYellowsAdd3, maxYellowsAdd3)
		AddCardToSimulationDeck("YellowAdd3")
	next
	for i = 1 to random(minYellowsMinus1, maxYellowsMinus1)
		AddCardToSimulationDeck("YellowMinus1")
	next
	for i = 1 to random(minYellowsMinus2, maxYellowsMinus2)
		AddCardToSimulationDeck("YellowMinus2")
	next

	if (newLock = 1)
		simulationInitialDoubleUps = simulationNoOfDoubleUps
		simulationInitialFreezes = simulationNoOfFreezes
		simulationInitialGreens = simulationNoOfGreens
		simulationInitialReds = simulationNoOfReds
		simulationInitialResets = simulationNoOfResets
		simulationInitialStickies = simulationNoOfStickies
		simulationInitialYellowsAdd1 = simulationNoOfYellowsAdd1
		simulationInitialYellowsAdd2 = simulationNoOfYellowsAdd2
		simulationInitialYellowsAdd3 = simulationNoOfYellowsAdd3
		simulationInitialYellowsMinus1 = simulationNoOfYellowsMinus1
		simulationInitialYellowsMinus2 = simulationNoOfYellowsMinus2
	endif
endfunction

function DealDeck()
	local i as integer
	local j as integer
	local x as integer
	local xPos# as float
	local y as integer
	local yPos# as float
	
	noOfCards = GetNoOfCards(lockSelected)
	noOfCardScreens# = ceil(noOfCards / (noOfCardColsPerScreen# * maxNoOfCardRows#))
	noOfCardRows = ceil(noOfCards / (noOfCardScreens# * noOfCardColsPerScreen#))
	noOfCardCols = ceil(noOfCardScreens# * noOfCardColsPerScreen#)

	if (noOfCardCols > 5) then noOfCardCols = 5
	cardSpacing# = 40.0 / (noOfCardRows * 1.0)
	i = 0
	j = 0
	for x = 1 to noOfCardCols
		xPos# = ((constCardsScreen * 100) - 12.5) + (x * 25)
		cardColX#[x] = xPos#
		for y = 1 to noOfCardRows
			inc i
			inc j
			if (i > noOfCards) then continue
			yPos# = (28 + (y * cardSpacing#)) - (cardSpacing# / 2)
			cards[j].originalDepth = noOfCards + 10 - j
			OryUIUpdateSprite(cards[j].sprite, "position:" + str(random(xPos# - 1, xPos# + 1)) + "," + str(yPos#) + ";image:" + str(imgCardBack) + ";angle:" + str(deck[shuffledDeck[i]].angle#) + ";depth:" + str(cards[j].originalDepth) + ";group:" + str(1000 + cards[j].id))
			lastCardDepth = cards[j].originalDepth
		next
	next
endfunction

function DeclineFollowRequest(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:DeclineFollowRequest=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].DeclineFollowRequest + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function DeleteAPIProject(index as integer, addToFront as integer)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&deleteAPIProject=1"
	postData$ = postData$ + "&clientID=" + apiProjects[index].clientID$
	postData$ = postData$ + "&clientSecret=" + apiProjects[index].clientSecret$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:DeleteAPIProject=" + str(index) + ";script:" + URLs[0].URLPath + "/" + URLs[0].DeleteAPIProject + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function DeleteLock(lockNo as integer, addToFront as integer)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	local abandonedLock as integer : abandonedLock = 0
	
	if (locks[lockNo].fake = 0 and locks[lockNo].unlocked = 0) then abandonedLock = 1
	locks[lockNo].deleting = 1
	
	postData$ = ""
	postData$ = postData$ + "&abandonedLock=" + str(abandonedLock)
	postData$ = postData$ + "&dateDeleted=" + dateFromServer$
	postData$ = postData$ + "&deleteLock=1"
	postData$ = postData$ + "&lockID=" + str(locks[lockNo].id)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&sharedID=" + locks[lockNo].sharedID$
	postData$ = postData$ + "&test=" + str(locks[lockNo].test)
	postData$ = postData$ + "&timestampDeleted=" + str(timestampNow)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:DeleteMyLock=" + str(locks[lockNo].id) + ";script:" + URLs[0].URLPath + "/" + URLs[0].DeleteLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function DeleteSharedLock(sharedLockNo, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	sharedLocks[sharedLockNo, 0].deleting = 1
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&shareID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:DeleteSharedLock=" + str(sharedLockNo) + ";script:" + URLs[0].URLPath + "/" + URLs[0].DeleteSharedLock  + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function DestroyItemsInAPIProjectCard(cardNo as integer)
	OryUIDeleteDialog(apiProjectCard[cardNo].dialog)
	DeleteSprite(apiProjectCard[cardNo].sprBackground)
	DeleteText(apiProjectCard[cardNo].txtClientID)
	DeleteText(apiProjectCard[cardNo].txtLastCalled)
	DeleteText(apiProjectCard[cardNo].txtResetsIn)
	DeleteText(apiProjectCard[cardNo].txtTokens)
	DeleteText(apiProjectCard[cardNo].txtTokensPerMinute)
	DeleteText(apiProjectCard[cardNo].txtTotalRequestsMade)
	DeleteText(apiProjectCard[cardNo].txtBanned)
	DeleteText(apiProjectCard[cardNo].txtName)
	DeleteSprite(apiProjectCard[cardNo].sprButtonBar)
	DeleteSprite(apiProjectCard[cardNo].sprLeftEmptyButton)
	DeleteSprite(apiProjectCard[cardNo].sprEditButton)
	DeleteSprite(apiProjectCard[cardNo].sprEditIcon)
	DeleteSprite(apiProjectCard[cardNo].sprRightEmptyButton)
endfunction

function DestroyItemsInDesertedUsersCard(cardNo as integer)
	local a as integer
	
	OryUIDeleteDialog(userCard[cardNo].dialog)
	DeleteSprite(userCard[cardNo].sprBackground)
	DeleteSprite(userCard[cardNo].sprOverlay)
	DeleteSprite(userCard[cardNo].sprUsernameButton)
	DeleteText(userCard[cardNo].txtUsername)
	DeleteSprite(userCard[cardNo].sprStatus)
	DeleteSprite(userCard[cardNo].sprTestLock)
	DeleteSprite(userCard[cardNo].sprRatingRibbon)
	DeleteText(userCard[cardNo].txtRatingRibbon)
	DeleteText(userCard[cardNo].txtTicker)
	DeleteText(userCard[cardNo].txtRateUser)
	for a = 1 to 5
		DeleteSprite(userCard[CardNo].sprRatingStar[a])
	next
	DeleteSprite(userCard[cardNo].sprButtonBar)
	DeleteSprite(userCard[cardNo].sprLeftEmptyButton)
	DeleteSprite(userCard[cardNo].sprFavouriteButton)
	DeleteSprite(userCard[cardNo].sprFavouriteIcon)
	DeleteSprite(userCard[cardNo].sprFlagButton)
	DeleteSprite(userCard[cardNo].sprFlagIcon)
	DeleteSprite(userCard[cardNo].sprMoreButton)
	DeleteSprite(userCard[cardNo].sprMoreIcon)
	DeleteSprite(userCard[cardNo].sprScrim)
	OryUIDeleteButtonGroup(userCard[cardNo].flagButtonGroup)
endfunction

function DestroyItemsInGeneratedLocksCard(cardNo as integer)
	OryUIDeleteDialog(generatedLocksCard[cardNo].dialog)
	DeleteSprite(generatedLocksCard[cardNo].sprBackground)
	DeleteText(generatedLocksCard[cardNo].txtID)
	DeleteText(generatedLocksCard[cardNo].txtConfig)
	DeleteSprite(generatedLocksCard[cardNo].sprCols[1])
	DeleteSprite(generatedLocksCard[cardNo].sprCols[2])
	DeleteSprite(generatedLocksCard[cardNo].sprCols[3])
	DeleteText(generatedLocksCard[cardNo].txtColHeaders[1])
	DeleteText(generatedLocksCard[cardNo].txtColHeaders[2])
	DeleteText(generatedLocksCard[cardNo].txtColHeaders[3])
	DeleteText(generatedLocksCard[cardNo].txtColValues[1])
	DeleteText(generatedLocksCard[cardNo].txtColValues[2])
	DeleteText(generatedLocksCard[cardNo].txtColValues[3])
	OryUIDeleteButton(generatedLocksCard[cardNo].rightButton)
endfunction

function DestroyItemsInLockedUsersCard(cardNo as integer)	
	OryUIDeleteDialog(userCard[cardNo].dialog)
	DeleteSprite(userCard[cardNo].sprBackground)
	DeleteSprite(userCard[cardNo].sprMultipleKeyholders)
	DeleteSprite(userCard[cardNo].sprTrustKeyholder)
	DeleteSprite(userCard[cardNo].sprUsernameButton)
	DeleteText(userCard[cardNo].txtUsername)
	DeleteSprite(userCard[cardNo].sprStatus)
	DeleteSprite(userCard[cardNo].sprKeysDisabled)
	DeleteSprite(userCard[cardNo].sprFreeUnlock)
	DeleteSprite(userCard[cardNo].sprFakeLock)
	DeleteSprite(userCard[cardNo].sprTestLock)
	DeleteSprite(userCard[cardNo].sprEmojiIcon)
	DeleteSprite(userCard[cardNo].sprRatingRibbon)
	DeleteText(userCard[cardNo].txtRatingRibbon)
	DeleteText(userCard[cardNo].txtTicker)
	DeleteSprite(userCard[cardNo].sprModifyLockInBackground)
	DeleteText(userCard[cardNo].txtModifyLockIn)
	DeleteText(userCard[cardNo].txtModifyLockInFooter)
	DeleteText(userCard[cardNo].txtUpdateVersion)
	DeleteSprite(userCard[cardNo].sprFreezeLockButton)
	DeleteText(userCard[cardNo].txtFreezeLockHeader)
	DeleteSprite(userCard[cardNo].sprFreezeLockIcon)
	DeleteText(userCard[cardNo].txtFreezeLockFooter)
	DeleteSprite(userCard[cardNo].sprGreenCard)
	DeleteText(userCard[cardNo].txtGreenHeader)
	DeleteText(userCard[cardNo].txtGreenCount)
	DeleteText(userCard[cardNo].txtGreenFooter)
	DeleteSprite(userCard[cardNo].sprRedCard)
	DeleteText(userCard[cardNo].txtRedHeader)
	DeleteText(userCard[cardNo].txtRedCount)
	DeleteText(userCard[cardNo].txtRedFooter)
	DeleteSprite(userCard[cardNo].sprYellowCard)
	DeleteText(userCard[cardNo].txtYellowHeader)
	DeleteText(userCard[cardNo].txtYellowCount)
	DeleteText(userCard[cardNo].txtYellowFooter)
	DeleteSprite(userCard[cardNo].sprStickyCard)
	DeleteText(userCard[cardNo].txtStickyHeader)
	DeleteText(userCard[cardNo].txtStickyCount)
	DeleteText(userCard[cardNo].txtStickyFooter)
	DeleteSprite(userCard[cardNo].sprFreezeCard)
	DeleteText(userCard[cardNo].txtFreezeHeader)
	DeleteText(userCard[cardNo].txtFreezeCount)
	DeleteText(userCard[cardNo].txtFreezeFooter)
	DeleteSprite(userCard[cardNo].sprDoubleUpCard)
	DeleteText(userCard[cardNo].txtDoubleUpHeader)
	DeleteText(userCard[cardNo].txtDoubleUpCount)
	DeleteText(userCard[cardNo].txtDoubleUpFooter)
	DeleteSprite(userCard[cardNo].sprResetCard)
	DeleteText(userCard[cardNo].txtResetHeader)
	DeleteText(userCard[cardNo].txtResetCount)
	DeleteText(userCard[cardNo].txtResetFooter)
	DeleteSprite(userCard[cardNo].sprFixedCircle[1])
	DeleteText(userCard[cardNo].txtFixedCount[1])
	DeleteText(userCard[cardNo].txtFixedCircleFooter[1])
	DeleteSprite(userCard[cardNo].sprFixedCircle[2])
	DeleteText(userCard[cardNo].txtFixedCount[2])
	DeleteText(userCard[cardNo].txtFixedCircleFooter[2])
	DeleteSprite(userCard[cardNo].sprFixedCircle[3])
	DeleteText(userCard[cardNo].txtFixedCount[3])
	DeleteText(userCard[cardNo].txtFixedCircleFooter[3])
	DeleteSprite(userCard[cardNo].sprFixedCircle[4])
	DeleteText(userCard[cardNo].txtFixedCount[4])
	DeleteText(userCard[cardNo].txtFixedCircleFooter[4])
	DeleteSprite(userCard[cardNo].sprFixedHideTimerButton)
	DeleteSprite(userCard[cardNo].sprFixedHideTimerIcon)
	DeleteSprite(userCard[cardNo].sprHideCardInfoButton)
	DeleteSprite(userCard[cardNo].sprHideCardInfoIcon)
	DeleteSprite(userCard[cardNo].sprButtonBar)
	DeleteSprite(userCard[cardNo].sprUnlockButton)
	DeleteSprite(userCard[cardNo].sprUnlockIcon)
	DeleteSprite(userCard[cardNo].sprResetButton)
	DeleteSprite(userCard[cardNo].sprResetIcon)
	DeleteSprite(userCard[cardNo].sprCheckInButton)
	DeleteSprite(userCard[cardNo].sprCheckInIcon)
	DeleteShader(userCard[cardNo].shaderCooldown)
	DeleteSprite(userCard[cardNo].sprCheckInCooldown)
	DeleteSprite(userCard[cardNo].sprLeftEmptyButton)
	DeleteSprite(userCard[cardNo].sprEditButton)
	DeleteSprite(userCard[cardNo].sprEditIcon)
	DeleteSprite(userCard[cardNo].sprRightEmptyButton)
	DeleteSprite(userCard[cardNo].sprMoodBackground)
	DeleteSprite(userCard[cardNo].sprMoodButton)
	DeleteSprite(userCard[cardNo].sprMoodIcon)
	DeleteSprite(userCard[cardNo].sprFavouriteButton)
	DeleteSprite(userCard[cardNo].sprFavouriteIcon)
	DeleteSprite(userCard[cardNo].sprFlagButton)
	DeleteSprite(userCard[cardNo].sprFlagIcon)
	DeleteSprite(userCard[cardNo].sprMoreButton)
	DeleteSprite(userCard[cardNo].sprMoreIcon)
	DeleteSprite(userCard[cardNo].sprScrim)
	OryUIDeleteButtonGroup(userCard[cardNo].flagButtonGroup)
endfunction

function DestroyItemsInMyLockCard(cardNo as integer)
	local a as integer
	local b as integer
	
	OryUIDeleteDialog(lockCard[cardNo].dialog)
	OryUIDeleteButtonGroup(lockCard[cardNo].flagButtonGroup)
	DeleteSprite(lockCard[cardNo].sprBackground)
	DeleteSprite(lockCard[cardNo].sprOverlay)
	DeleteSprite(lockCard[cardNo].sprDeletingBackground)
	DeleteText(lockCard[cardNo].txtDeleting)
	DeleteText(lockCard[cardNo].txtGroupID)
	DeleteSprite(lockCard[cardNo].sprSyncStatus)
	DeleteSprite(lockCard[cardNo].sprRibbon)
	DeleteText(lockCard[cardNo].txtNextChanceInHeader)
	DeleteText(lockCard[cardNo].txtUnlocksInHeader)
	DeleteText(lockCard[cardNo].txtCombinationHeader)
	DeleteText(lockCard[cardNo].txtTapToUnlock)
	DeleteText(lockCard[cardNo].txtTapToUnlockFooter)
	DeleteText(lockCard[cardNo].txtTimerHidden)
	DeleteText(lockCard[cardNo].txtTimerHiddenFooter)
	DeleteText(lockCard[cardNo].txtCombination)		
	for a = 1 to 4
		DeleteSprite(lockCard[cardNo].sprCircle[a])
		DeleteText(lockCard[cardNo].txtCircleHeader[a])
		DeleteText(lockCard[cardNo].txtCircle[a])
		DeleteText(lockCard[cardNo].txtCircleFooter[a])														
		DeleteText(lockCard[cardNo].txtCirclePercentage[a])
		DeleteShader(lockCard[cardNo].shaderArc[a])
		DeleteSprite(lockCard[cardNo].sprArc[a])
		if (a = 4)
			for b = 1 to 7
				DeleteShader(lockCard[cardNo].shaderChanceArc[b])
				DeleteSprite(lockCard[cardNo].sprChanceArc[b])
			next
			DeleteSprite(lockCard[cardNo].sprCircleSecretSticker[a])																								
		endif
		DeleteSprite(lockCard[cardNo].sprIceCapArch[a])
	next
	DeleteText(lockCard[cardNo].txtTimeLockedHeader)
	DeleteText(lockCard[cardNo].txtTimeLocked)
	DeleteText(lockCard[cardNo].txtTimeLockedFooter)
	DeleteText(lockCard[cardNo].txtGreaterThanSign)
	DeleteText(lockCard[cardNo].txtFooter)
	DeleteSprite(lockCard[cardNo].sprUsernameButton)
	DeleteSprite(lockCard[cardNo].sprKeyholderEmojiIcon)
	DeleteText(lockCard[cardNo].txtRateKeyholder)
	for a = 1 to 5
		DeleteSprite(lockCard[cardNo].sprRatingStar[a])
	next									
	DeleteSprite(lockCard[cardNo].sprButtonBar)
	DeleteSprite(lockCard[cardNo].sprDeleteButton)
	DeleteSprite(lockCard[cardNo].sprDeleteIcon)
	DeleteSprite(lockCard[cardNo].sprUnlockButton)
	DeleteSprite(lockCard[cardNo].sprUnlockIcon)
	DeleteSprite(lockCard[cardNo].sprRestartButton)
	DeleteSprite(lockCard[cardNo].sprRestartIcon)
	DeleteSprite(lockCard[cardNo].sprEmptyLeftButton)
	DeleteSprite(lockCard[cardNo].sprCheckInButton)
	DeleteSprite(lockCard[cardNo].sprCheckInIcon)
	DeleteShader(lockCard[cardNo].shaderCooldown)
	DeleteSprite(lockCard[cardNo].sprCheckInCooldown)
	DeleteSprite(lockCard[cardNo].sprCleanButton)
	DeleteSprite(lockCard[cardNo].sprCleanIcon)
	DeleteSprite(lockCard[cardNo].sprCleanIconOverlay)
	DeleteSprite(lockCard[cardNo].sprEmptyRightButton)
	DeleteSprite(lockCard[cardNo].sprMoodButton)
	DeleteSprite(lockCard[cardNo].sprMoodBackground)
	DeleteSprite(lockCard[cardNo].sprMoodIcon)
	DeleteSprite(lockCard[cardNo].sprFlagButton)
	DeleteSprite(lockCard[cardNo].sprFlagIcon)		
	DeleteSprite(lockCard[cardNo].sprMoreButton)
	DeleteSprite(lockCard[cardNo].sprMoreIcon)
	DeleteSprite(lockCard[cardNo].sprScrim)
endfunction

function DestroyItemsInMyLockDeletedCard(cardNo as integer)
	OryUIDeleteDialog(lockDeletedCard[cardNo].dialog)
	DeleteSprite(lockDeletedCard[cardNo].sprBackground)
	OryUIDeleteButton(lockDeletedCard[cardNo].rightButton)
	DeleteText(lockDeletedCard[cardNo].txtHeader)
	DeleteText(lockDeletedCard[cardNo].txtDeletedWhen)
	DeleteText(lockDeletedCard[cardNo].txtLockInformation)
	DeleteText(lockDeletedCard[cardNo].txtLockedByHidden)
	DeleteText(lockDeletedCard[cardNo].txtUsernameHidden)
	DeleteSprite(lockDeletedCard[cardNo].sprUsernameButton)
	DeleteText(lockDeletedCard[cardNo].txtFooter)
endfunction

function DestroyItemsInSharedLockCard(cardNo as integer)
	OryUIDeleteDialog(sharedLockCard[cardNo].dialog)
	DeleteSprite(sharedLockCard[cardNo].sprBackground)
	DeleteSprite(sharedLockCard[cardNo].sprOverlay)
	DeleteSprite(sharedLockCard[cardNo].sprDeletingBackground)
	DeleteText(sharedLockCard[cardNo].txtDeleting)
	DeleteText(sharedLockCard[cardNo].txtLockName)
	DeleteText(sharedLockCard[cardNo].txtShareID)
	DeleteText(sharedLockCard[cardNo].txtOptions)
	DeleteText(sharedLockCard[cardNo].txtCards)
	DeleteText(sharedLockCard[cardNo].txtAutoResets)
	DeleteText(sharedLockCard[cardNo].txtCheckIns)
	DeleteText(sharedLockCard[cardNo].txtUsers)
	DeleteText(sharedLockCard[cardNo].txtRating)
	DeleteSprite(sharedLockCard[cardNo].sprButtonBar)
	DeleteSprite(sharedLockCard[cardNo].sprDeleteButton)
	DeleteSprite(sharedLockCard[cardNo].sprDeleteIcon)
	DeleteSprite(sharedLockCard[cardNo].sprCloneButton)
	DeleteSprite(sharedLockCard[cardNo].sprCloneIcon)
	DeleteSprite(sharedLockCard[cardNo].sprLeftEmptyButton)
	DeleteSprite(sharedLockCard[cardNo].sprManageButton)
	DeleteSprite(sharedLockCard[cardNo].sprManageIcon)
	DeleteSprite(sharedLockCard[cardNo].sprRightEmptyButton)
	DeleteSprite(sharedLockCard[cardNo].sprShareButton)
	DeleteSprite(sharedLockCard[cardNo].sprShareIcon)
	DeleteSprite(sharedLockCard[cardNo].sprShowMatchingUsersButton)
	DeleteSprite(sharedLockCard[cardNo].sprShowMatchingUsersIcon)
	DeleteSprite(sharedLockCard[cardNo].sprMoreButton)
	DeleteSprite(sharedLockCard[cardNo].sprMoreIcon)
	DeleteSprite(sharedLockCard[cardNo].sprVisibleButton)
	OryUIDeleteMenu(sharedLockCard[cardNo].menuShare)
	OryUIDeleteMenu(sharedLockCard[cardNo].menuShowMatchingUsers)
endfunction

function DestroyItemsInSharedLockDeletedCard(cardNo as integer)
	OryUIDeleteDialog(lockDeletedCard[cardNo].dialog)
	DeleteSprite(lockDeletedCard[cardNo].sprBackground)
	OryUIDeleteButton(lockDeletedCard[cardNo].rightButton)
	DeleteText(lockDeletedCard[cardNo].txtHeader)
	DeleteText(lockDeletedCard[cardNo].txtDeletedWhen)
	DeleteText(lockDeletedCard[cardNo].txtLockInformation)
	DeleteText(lockDeletedCard[cardNo].txtLockedByHidden)
	DeleteText(lockDeletedCard[cardNo].txtUsernameHidden)
	DeleteSprite(lockDeletedCard[cardNo].sprUsernameButton)
	DeleteText(lockDeletedCard[cardNo].txtFooter)
endfunction

function DestroyItemsInUnlockedUsersCard(cardNo as integer)
	local a as integer
	
	OryUIDeleteDialog(userCard[cardNo].dialog)
	DeleteSprite(userCard[cardNo].sprBackground)
	DeleteSprite(userCard[cardNo].sprOverlay)
	DeleteSprite(userCard[cardNo].sprUsedKey)
	DeleteSprite(userCard[cardNo].sprUsernameButton)
	DeleteText(userCard[cardNo].txtUsername)
	DeleteSprite(userCard[cardNo].sprStatus)
	DeleteSprite(userCard[cardNo].sprTestLock)
	DeleteSprite(userCard[cardNo].sprRatingRibbon)
	DeleteText(userCard[cardNo].txtRatingRibbon)
	DeleteText(userCard[cardNo].txtTicker)
	DeleteText(userCard[cardNo].txtRateUser)
	for a = 1 to 5
		DeleteSprite(userCard[CardNo].sprRatingStar[a])
	next
	DeleteSprite(userCard[cardNo].sprButtonBar)
	DeleteSprite(userCard[cardNo].sprLeftEmptyButton)
	DeleteSprite(userCard[cardNo].sprFavouriteButton)
	DeleteSprite(userCard[cardNo].sprFavouriteIcon)
	DeleteSprite(userCard[cardNo].sprFlagButton)
	DeleteSprite(userCard[cardNo].sprFlagIcon)
	DeleteSprite(userCard[cardNo].sprMoreButton)
	DeleteSprite(userCard[cardNo].sprMoreIcon)
	DeleteSprite(userCard[cardNo].sprScrim)
	OryUIDeleteButtonGroup(userCard[cardNo].flagButtonGroup)
endfunction

function DestroyItemsOnUpdateUserScreen()
	local i as integer
	
	DeleteSprite(updateUser.sprUsernameButton)
	DeleteText(updateUser.txtUsername)
	DeleteSprite(updateUser.sprTrustKeyholder)
	DeleteText(updateUser.txtGreensRequiredToUnlock)
	DeleteText(updateUser.txtModifiedBy)
	for i = 1 to 4
		OryUIDeleteButton(updateUser.btnAdd[i])
		DeleteSprite(updateUser.sprCircle[i])
		DeleteText(updateUser.txtCircle[i])
		DeleteText(updateUser.txtCircleFooter[i])
		OryUIDeleteButton(updateUser.btnMinus[i])
	next
	for i = 1 to 11
		DeleteSprite(updateUser.sprCard[i])
		DeleteText(updateUser.txtCardModifiedBy[i])
		OryUIDeleteInputSpinner(updateUser.spinCardCount[i])
		DeleteText(updateUser.txtCardPercentage[i])
		DeleteText(updateUser.txtCardPickedCount[i])
	next
	OryUIDeleteTextCard(updateUser.crdHideUpdate)
	OryUIDeleteButtonGroup(updateUser.grpHideUpdate)
endfunction

function DisconnectDiscord(addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	if (URLs[0].DisconnectDiscord = "disconnectdiscord.php")
		OryUIAddItemToHTTPSQueue(httpsQueue, "name:DisconnectDiscord;script:oauth2/discord/disconnect.php;postData:" + postData$ + ";addToFront:" + str(addToFront))
	else
		OryUIAddItemToHTTPSQueue(httpsQueue, "name:DisconnectDiscord;script:" + URLs[0].URLPath + "/" + URLs[0].DisconnectDiscord + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
	endif
endfunction

function DisconnectTwitter(addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	if (URLs[0].DisconnectTwitter = "disconnecttwitter.php")
		OryUIAddItemToHTTPSQueue(httpsQueue, "name:DisconnectTwitter;script:oauth2/twitter/disconnect.php;postData:" + postData$ + ";addToFront:" + str(addToFront))
	else
		OryUIAddItemToHTTPSQueue(httpsQueue, "name:DisconnectTwitter;script:" + URLs[0].URLPath + "/" + URLs[0].DisconnectTwitter + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
	endif
endfunction

function FindRelation(relationType$ as string, id as integer)
	local found as integer
	
	if (lower(relationType$) = "blockedbyothers")
		if (FindString(yourFriends.blockedByOthersDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	elseif (lower(relationType$) = "blockedbyyou")
		if (FindString(yourFriends.blockedByYouDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	elseif (lower(relationType$) = "followers")
		if (FindString(yourFriends.followersDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	elseif (lower(relationType$) = "following")
		if (FindString(yourFriends.followingDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	elseif (lower(relationType$) = "pendingbyothers")
		if (FindString(yourFriends.pendingByOthersDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	elseif (lower(relationType$) = "pendingbyyou")
		if (FindString(yourFriends.pendingByYouDelimitedIDs$, "|" + str(id) + "|") >= 1) then found = 1
	endif
endfunction found

function FlipCard(id)
	cards[id].originalWidth# = GetSpriteWidth(cards[id].sprite)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.1)
	SetTweenSpriteSizeX(cards[id].tweenSprite[1], cards[id].originalWidth#, 0, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
	if (GetSpriteImageID(cards[id].sprite) = imgCardBack)
		if (deck[shuffledDeck[cards[id].id]].value$ = "DoubleUp") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardDoubleUp100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "Freeze") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardFreeze100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "GoAgain") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardGoAgain))
		if (deck[shuffledDeck[cards[id].id]].value$ = "Green") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardGreen100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "Red") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardRed100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "Reset") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardReset100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "Sticky") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardSticky100))
		if (deck[shuffledDeck[cards[id].id]].value$ = "YellowAdd1") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardYellowAdd1))
		if (deck[shuffledDeck[cards[id].id]].value$ = "YellowAdd2") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardYellowAdd2))
		if (deck[shuffledDeck[cards[id].id]].value$ = "YellowAdd3") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardYellowAdd3))
		if (deck[shuffledDeck[cards[id].id]].value$ = "YellowMinus1") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardYellowMinus1))
		if (deck[shuffledDeck[cards[id].id]].value$ = "YellowMinus2") then OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardYellowMinus2))
	else
		OryUIUpdateSprite(cards[id].sprite, "image:" + str(imgCardBack))
	endif
	cards[id].tweenSprite[1] = CreateTweenSprite(0.1)
	SetTweenSpriteSizeX(cards[id].tweenSprite[1], 0, cards[id].originalWidth#, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
endfunction

function FollowUser(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:FollowUser=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].FollowUser + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GenerateCombination(combinationLength as integer, final as integer)
	local chars$ as string
	local charsArray as string[]
	local combination$ as string
	local i as integer
	local randomIndex as integer
	
	if (combinationType = 1) then charsArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
	if (combinationType = 2) then charsArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
	if (combinationType = 3) then charsArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
	for i = 1 to combinationLength
		randomIndex = random(0, charsArray.length)
		combination$ = combination$ + charsArray[randomIndex]
		if (allowDuplicatesInCombination = 2) then charsArray.remove(randomIndex)
	next
	if (final = 1) then generatedCombination$ = combination$
endfunction combination$

function GetAccountData(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetAccountData;script:" + URLs[0].URLPath + "/" + URLs[0].GetAccountData + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetAPIProjects(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetAPIProjects;script:" + URLs[0].URLPath + "/" + URLs[0].GetAPIProjects + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetFlagChosen(id)
	local flagChosen as integer
	
	if (usersFlag1.find(id) > -1) then flagChosen = 1
	if (usersFlag2.find(id) > -1) then flagChosen = 2
	if (usersFlag3.find(id) > -1) then flagChosen = 3
	if (usersFlag4.find(id) > -1) then flagChosen = 4
	if (usersFlag5.find(id) > -1) then flagChosen = 5
	if (usersFlag6.find(id) > -1) then flagChosen = 6
	if (usersFlag7.find(id) > -1) then flagChosen = 7
endfunction flagChosen

function GetGeneratedLocks(min, max, regularity#, addToFront)
	local postData$ as string
	
	generatedLocks.length = -1
	
	postData$ = ""
	postData$ = postData$ + "&max=" + str(max)
	postData$ = postData$ + "&min=" + str(min)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&regularity=" + str(regularity#)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetGeneratedLocks;script:" + URLs[0].URLPath + "/" + URLs[0].GetLockTemplates + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetKeyholdersData(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetKeyholdersData;script:" + URLs[0].URLPath + "/" + URLs[0].GetKeyholdersData + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetLocksData()
	local a as integer
	local fileID as integer
	local i as integer
	local j as integer
	local lineRead$ as string
	local lockCount as integer
	local tmpCombination$ as string
	local total as integer
	local value$ as string
	local variable$ as string
	
	noOfLocks = 0
	noOfLocksControlledByKeyholder = 0
	if (GetFileExists("locksV2.txt"))
		fileID = OpenToRead("locksV2.txt")
		for a = 1 to 20
			locks[a].id = ReadInteger(fileID)
		next
		CloseFile(fileID)
	endif
	lockCount = 0
	for i = 1 to 20
		if (GetFileExists("ID" + str(locks[i].id) + "V2.txt") and locks[i].id > 0)
			inc noOfLocks
			inc lockCount
			fileID = OpenToRead("ID" + str(locks[i].id) + "V2.txt")
			while (FileEOF(fileID) = 0)
				lineRead$ = ReadString(fileID)
				variable$ = GetStringToken(lineRead$, ":", 1)
				value$ = GetStringToken(lineRead$, ":", 2)
				if (variable$ = "sortKey") then locks[i].sortKey$ = value$
				if (variable$ = "autoResetsPaused") then locks[i].autoResetsPaused = val(value$)
				if (variable$ = "blockBotFromUnlocking") then locks[i].blockBotFromUnlocking = val(value$)
				if (variable$ = "blockUsersAlreadyLocked") then locks[i].blockUsersAlreadyLocked = val(value$)
				if (variable$ = "botChosen") then locks[i].botChosen = val(value$)
				if (variable$ = "build") then locks[i].build = val(value$)
				if (variable$ = "cardInfoHidden") then locks[i].cardInfoHidden = val(value$)
				if (variable$ = "chancesAccumulatedBeforeFreeze") then locks[i].chancesAccumulatedBeforeFreeze = val(value$)
				if (variable$ = "checkInFrequencyInSeconds") then locks[i].checkInFrequencyInSeconds = val(value$)
				if (variable$ = "combination") then locks[i].combination$ = value$
				if (variable$ = "cumulative") then locks[i].cumulative = val(value$)
				if (variable$ = "dateLastPicked") then locks[i].dateLastPicked$ = value$
				if (variable$ = "dateLocked") then locks[i].dateLocked$ = value$
				if (variable$ = "dateUnlocked") then locks[i].dateUnlocked$ = value$
				if (variable$ = "discardPile") then locks[i].discardPile$ = value$
				if (variable$ = "displayInStats") then locks[i].displayInStats = val(value$)
				if (variable$ = "doubleUpCards") then locks[i].doubleUpCards = val(value$)
				if (variable$ = "doubleUpCardsAdded") then locks[i].doubleUpCardsAdded = val(value$)
				if (variable$ = "doubleUpCardsPicked") then locks[i].doubleUpCardsPicked = val(value$)
				if (variable$ = "emojiChosen") then locks[i].emojiChosen = val(value$)
				if (variable$ = "emojiColourSelected") then locks[i].emojiColourSelected = val(value$)
				if (variable$ = "fake") then locks[i].fake = val(value$)
				if (variable$ = "fixed") then locks[i].fixed = val(value$)
				if (variable$ = "flagChosen") then locks[i].flagChosen = val(value$)
				if (variable$ = "freezeCards") then locks[i].freezeCards = val(value$)
				if (variable$ = "freezeCardsAdded") then locks[i].freezeCardsAdded = val(value$)
				if (variable$ = "goAgainCards") then locks[i].goAgainCards = val(value$)
				if (variable$ = "goAgainCardsPercentage") then locks[i].goAgainCardsPercentage# = valFloat(value$)
				if (variable$ = "greenCards") then locks[i].greenCards = val(value$)
				if (variable$ = "greensPickedSinceReset") then locks[i].greensPickedSinceReset = val(value$)
				if (variable$ = "groupID") then locks[i].groupID = val(value$)
				if (variable$ = "hiddenFromOwner") then locks[i].hiddenFromOwner = val(value$)
				if (variable$ = "hiddenFromOwnerAlertHidden") then locks[i].hiddenFromOwnerAlertHidden = val(value$)
				if (variable$ = "hideGreensUntilPickCount") then locks[i].hideGreensUntilPickCount = val(value$)
				if (variable$ = "id") then locks[i].id = val(value$)
				if (variable$ = "initialDoubleUpCards") then locks[i].initialDoubleUpCards = val(value$)
				if (variable$ = "initialFreezeCards") then locks[i].initialFreezeCards = val(value$)
				if (variable$ = "initialGreenCards") then locks[i].initialGreenCards = val(value$)
//~				if (variable$ = "initialMaximumDoubleUpCards") then locks[i].initialMaximumDoubleUpCards = val(value$)
//~				if (variable$ = "initialMaximumFreezeCards") then locks[i].initialMaximumFreezeCards = val(value$)
//~				if (variable$ = "initialMaximumGreenCards") then locks[i].initialMaximumGreenCards = val(value$)
//~				if (variable$ = "initialMaximumMinutes") then locks[i].initialMaximumMinutes = val(value$)
//~				if (variable$ = "initialMaximumRedCards") then locks[i].initialMaximumRedCards = val(value$)
//~				if (variable$ = "initialMaximumResetCards") then locks[i].initialMaximumResetCards = val(value$)
//~				if (variable$ = "initialMaximumStickyCards") then locks[i].initialMaximumStickyCards = val(value$)
//~				if (variable$ = "initialMaximumYellowAddCards") then locks[i].initialMaximumYellowAddCards = val(value$)
//~				if (variable$ = "initialMaximumYellowMinusCards") then locks[i].initialMaximumYellowMinusCards = val(value$)
//~				if (variable$ = "initialMaximumYellowRandomCards") then locks[i].initialMaximumYellowRandomCards = val(value$)
//~				if (variable$ = "initialMinimumDoubleUpCards") then locks[i].initialMinimumDoubleUpCards = val(value$)
//~				if (variable$ = "initialMinimumFreezeCards") then locks[i].initialMinimumFreezeCards = val(value$)
//~				if (variable$ = "initialMinimumGreenCards") then locks[i].initialMinimumGreenCards = val(value$)
//~				if (variable$ = "initialMinimumMinutes") then locks[i].initialMinimumMinutes = val(value$)
//~				if (variable$ = "initialMinimumRedCards") then locks[i].initialMinimumRedCards = val(value$)
//~				if (variable$ = "initialMinimumResetCards") then locks[i].initialMinimumResetCards = val(value$)
//~				if (variable$ = "initialMinimumStickyCards") then locks[i].initialMinimumStickyCards = val(value$)
//~				if (variable$ = "initialMinimumYellowAddCards") then locks[i].initialMinimumYellowAddCards = val(value$)
//~				if (variable$ = "initialMinimumYellowMinusCards") then locks[i].initialMinimumYellowMinusCards = val(value$)
//~				if (variable$ = "initialMinimumYellowRandomCards") then locks[i].initialMinimumYellowRandomCards = val(value$)
				if (variable$ = "initialMinutes") then locks[i].initialMinutes = val(value$)
				if (variable$ = "initialRedCards") then locks[i].initialRedCards = val(value$)
				if (variable$ = "initialResetCards") then locks[i].initialResetCards = val(value$)
				if (variable$ = "initialStickyCards") then locks[i].initialStickyCards = val(value$)
				if (variable$ = "initialYellowAdd1Cards") then locks[i].initialYellowAdd1Cards = val(value$)
				if (variable$ = "initialYellowAdd2Cards") then locks[i].initialYellowAdd2Cards = val(value$)
				if (variable$ = "initialYellowAdd3Cards") then locks[i].initialYellowAdd3Cards = val(value$)
				if (variable$ = "initialYellowCards") then locks[i].initialYellowCards = val(value$)
				if (variable$ = "initialYellowMinus1Cards") then locks[i].initialYellowMinus1Cards = val(value$)
				if (variable$ = "initialYellowMinus2Cards") then locks[i].initialYellowMinus2Cards = val(value$)
				if (variable$ = "iteration") then locks[i].iteration = val(value$)
				if (variable$ = "keyDisabled") then locks[i].keyDisabled = val(value$)
				if (variable$ = "keyholderAllowsFreeUnlock") then locks[i].keyholderAllowsFreeUnlock = val(value$)
				if (variable$ = "keyholderBuildNumberInstalled") then locks[i].keyholderBuildNumberInstalled = val(value$)
				if (variable$ = "keyholderDecisionDisabled") then locks[i].keyholderDecisionDisabled = val(value$)
				if (variable$ = "keyholderDisabledKey") then locks[i].keyholderDisabledKey = val(value$)
				if (variable$ = "keyholderEmojiChosen") then locks[i].keyholderEmojiChosen = val(value$)
				if (variable$ = "keyholderEmojiColourSelected") then locks[i].keyholderEmojiColourSelected = val(value$)
				if (variable$ = "keyholderID") then locks[i].keyholderID = val(value$)
				if (variable$ = "keyholderUsername") then locks[i].keyholderUsername$ = value$
				if (variable$ = "keyUsed") then locks[i].keyUsed = val(value$)
				for a = 0 to 4
					if (variable$ = "lastXUpdates[" + str(a) + "].timestampUpdated") then locks[i].lastXUpdates[a].timestampUpdated = val(value$)
					if (variable$ = "lastXUpdates[" + str(a) + "].update") then locks[i].lastXUpdates[a].update$ = value$
				next
				if (variable$ = "lastUpdateIDSeen") then locks[i].lastUpdateIDSeen = val(value$)
				if (variable$ = "lateCheckInWindowInSeconds") then locks[i].lateCheckInWindowInSeconds = val(value$)
				if (variable$ = "lockFrozenByCard") then locks[i].lockFrozenByCard = val(value$)
				if (variable$ = "lockFrozenByKeyholder") then locks[i].lockFrozenByKeyholder = val(value$)
				//if (variable$ = "lockFrozenByLockee") then locks[i].lockFrozenByLockee = val(value$)
				if (variable$ = "lockName") then locks[i].lockName$ = value$
				if (variable$ = "maximumAutoResets") then locks[i].maximumAutoResets = val(value$)
				if (variable$ = "maximumMinutes") then locks[i].maximumMinutes = val(value$)
				if (variable$ = "maximumRedCards") then locks[i].maximumRedCards = val(value$)
				if (variable$ = "minimumMinutes") then locks[i].minimumMinutes = val(value$)
				if (variable$ = "minimumRedCards") then locks[i].minimumRedCards = val(value$)
				if (variable$ = "minutes") then locks[i].minutes = val(value$)
				if (variable$ = "minutesAdded") then locks[i].minutesAdded = val(value$)
				if (variable$ = "multipleGreensRequired") then locks[i].multipleGreensRequired = val(value$)
				if (variable$ = "noOfAdd1Cards") then locks[i].noOfAdd1Cards = val(value$)
				if (variable$ = "noOfAdd2Cards") then locks[i].noOfAdd2Cards = val(value$)
				if (variable$ = "noOfAdd3Cards") then locks[i].noOfAdd3Cards = val(value$)
				if (variable$ = "noOfKeysRequired") then locks[i].noOfKeysRequired = val(value$)
				if (variable$ = "noOfMinus1Cards") then locks[i].noOfMinus1Cards = val(value$)
				if (variable$ = "noOfMinus2Cards") then locks[i].noOfMinus2Cards = val(value$)
				if (variable$ = "noOfTimesAutoReset") then locks[i].noOfTimesAutoReset = val(value$)
				if (variable$ = "noOfTimesCardReset") then locks[i].noOfTimesCardReset = val(value$)
				if (variable$ = "noOfTimesFullReset") then locks[i].noOfTimesFullReset = val(value$)
				if (variable$ = "noOfTimesGreenCardRevealed") then locks[i].noOfTimesGreenCardRevealed = val(value$)
				if (variable$ = "noOfTimesReset") then locks[i].noOfTimesReset = val(value$)
				if (variable$ = "permanent") then locks[i].permanent = val(value$)
				if (variable$ = "pickedCount") then locks[i].pickedCount = val(value$)
				if (variable$ = "pickedCountIncludingYellows") then locks[i].pickedCountIncludingYellows = val(value$)
				if (variable$ = "pickedCountSinceReset") then locks[i].pickedCountSinceReset = val(value$)
				if (variable$ = "randomCardsAdded") then locks[i].randomCardsAdded = val(value$)
				if (variable$ = "rating") then locks[i].rating = val(value$)
				if (variable$ = "readyToUnlock") then locks[i].readyToUnlock = val(value$)
				if (variable$ = "redCards") then locks[i].redCards = val(value$)
				if (variable$ = "redCardsAdded") then locks[i].redCardsAdded = val(value$)
				if (variable$ = "regularity") then locks[i].regularity# = valFloat(value$)
				if (variable$ = "removedByKeyholder") then locks[i].removedByKeyholder = val(value$)
				if (variable$ = "removedByKeyholderAlertHidden") then locks[i].removedByKeyholderAlertHidden = val(value$)
				if (variable$ = "resetCards") then locks[i].resetCards = val(value$)
				if (variable$ = "resetCardsAdded") then locks[i].resetCardsAdded = val(value$)
				if (variable$ = "resetCardsPicked") then locks[i].resetCardsPicked = val(value$)
				if (variable$ = "resetFrequencyInSeconds") then locks[i].resetFrequencyInSeconds = val(value$)
				if (variable$ = "ribbonType") then locks[i].ribbonType$ = value$
				if (variable$ = "rowInDB") then locks[i].rowInDB = val(value$)
				if (variable$ = "sharedID") then locks[i].sharedID$ = value$
				if (variable$ = "simulationAverageMinutesLocked") then locks[i].simulationAverageMinutesLocked = val(value$)
				if (variable$ = "simulationBestCaseMinutesLocked") then locks[i].simulationBestCaseMinutesLocked = val(value$)
				if (variable$ = "simulationWorstCaseMinutesLocked") then locks[i].simulationWorstCaseMinutesLocked = val(value$)
				if (variable$ = "stickyCards") then locks[i].stickyCards = val(value$)
				if (variable$ = "test") then locks[i].test = val(value$)
				if (variable$ = "timeLeftUntilNextChanceBeforeFreeze") then locks[i].timeLeftUntilNextChanceBeforeFreeze = val(value$)
				if (variable$ = "timerHidden") then locks[i].timerHidden = val(value$)
				if (variable$ = "timestampCleanTimeRequestBlockedUntil") then locks[i].timestampCleanTimeRequestBlockedUntil = val(value$)
				if (variable$ = "timestampDeniedCleanTime") then locks[i].timestampDeniedCleanTime = val(value$)
				if (variable$ = "timestampEndedCleanTime") then locks[i].timestampEndedCleanTime = val(value$)
				if (variable$ = "timestampFrozenByCard") then locks[i].timestampFrozenByCard = val(value$)
				if (variable$ = "timestampFrozenByKeyholder") then locks[i].timestampFrozenByKeyholder = val(value$)
				//if (variable$ = "timestampFrozenByLockee") then locks[i].timestampFrozenByLockee = val(value$)
				if (variable$ = "timestampHiddenFromOwner") then locks[i].timestampHiddenFromOwner = val(value$)
				if (variable$ = "timestampLastAutoReset") then locks[i].timestampLastAutoReset = val(value$)
				if (variable$ = "timestampLastCardReset") then locks[i].timestampLastCardReset = val(value$)
				if (variable$ = "timestampLastCheckedIn") then locks[i].timestampLastCheckedIn = val(value$)
				if (variable$ = "timestampLastCheckedUpdates") then locks[i].timestampLastCheckedUpdates = val(value$)
				if (variable$ = "timestampLastFullReset") then locks[i].timestampLastFullReset = val(value$)
				if (variable$ = "timestampLastPicked") then locks[i].timestampLastPicked = val(value$)
				if (variable$ = "timestampLastReset") then locks[i].timestampLastReset = val(value$)
				if (variable$ = "timestampLastSynced") then locks[i].timestampLastSynced = val(value$)
				if (variable$ = "timestampLastUpdated") then locks[i].timestampLastUpdated = val(value$)
				if (variable$ = "timestampLocked") then locks[i].timestampLocked = val(value$)
				if (variable$ = "timestampRated") then locks[i].timestampRated = val(value$)
				if (variable$ = "timestampRealLastPicked") then locks[i].timestampRealLastPicked = val(value$)
				if (variable$ = "timestampRemovedByKeyholder") then locks[i].timestampRemovedByKeyholder = val(value$)
				if (variable$ = "timestampRequestedCleanTime") then locks[i].timestampRequestedCleanTime = val(value$)
				if (variable$ = "timestampRequestedKeyholdersDecision") then locks[i].timestampRequestedKeyholdersDecision = val(value$)
				if (variable$ = "timestampRibbonAdded") then locks[i].timestampRibbonAdded = val(value$)
				if (variable$ = "timestampStartedCleanTime") then locks[i].timestampStartedCleanTime = val(value$)
				if (variable$ = "timestampUnfreezes") then locks[i].timestampUnfreezes = val(value$)
				if (variable$ = "timestampUnfrozen") then locks[i].timestampUnfrozen = val(value$)
				if (variable$ = "timestampUnlocked") then locks[i].timestampUnlocked = val(value$)
				if (variable$ = "totalTimeCleaning") then locks[i].totalTimeCleaning = val(value$)
				if (variable$ = "totalTimeFrozen") then locks[i].totalTimeFrozen = val(value$)
				if (variable$ = "trustKeyholder") then locks[i].trustKeyholder = val(value$)
				if (variable$ = "unlocked") then locks[i].unlocked = val(value$)
				if (variable$ = "version") then locks[i].version$ = value$
				if (variable$ = "yellowCards") then locks[i].yellowCards = val(value$)
			endwhile
			// CARD FIXES
			if (locks[i].doubleUpCards < 0) then locks[i].doubleUpCards = 0
			if (locks[i].doubleUpCards > cappedDoubleUpCards) then locks[i].doubleUpCards = cappedDoubleUpCards
			if (locks[i].freezeCards < 0) then locks[i].freezeCards = 0
			if (locks[i].freezeCards > cappedFreezeCards) then locks[i].freezeCards = cappedFreezeCards
			if (locks[i].greenCards < 0) then locks[i].greenCards = 1
			if (locks[i].fixed = 0 and locks[i].greenCards = 0 and locks[i].unlocked = 0 and locks[i].readyToUnlock = 0)
				locks[i].greenCards = 1
			endif
			if (locks[i].greenCards > cappedGreenCards) then locks[i].greenCards = cappedGreenCards
			if (locks[i].greensPickedSinceReset < 0) then locks[i].greensPickedSinceReset = 0
			if (locks[i].multipleGreensRequired = 2) then locks[i].multipleGreensRequired = 0
			if (locks[i].noOfAdd1Cards < 0) then locks[i].noOfAdd1Cards = 0
			if (locks[i].noOfAdd1Cards > cappedYellowCardsEachType) then locks[i].noOfAdd1Cards = cappedYellowCardsEachType
			if (locks[i].noOfAdd2Cards < 0) then locks[i].noOfAdd2Cards = 0
			if (locks[i].noOfAdd2Cards > cappedYellowCardsEachType) then locks[i].noOfAdd2Cards = cappedYellowCardsEachType
			if (locks[i].noOfAdd3Cards < 0) then locks[i].noOfAdd3Cards = 0
			if (locks[i].noOfAdd3Cards > cappedYellowCardsEachType) then locks[i].noOfAdd3Cards = cappedYellowCardsEachType
			if (locks[i].noOfMinus1Cards < 0) then locks[i].noOfMinus1Cards = 0
			if (locks[i].noOfMinus1Cards > cappedYellowCardsEachType) then locks[i].noOfMinus1Cards = cappedYellowCardsEachType
			if (locks[i].noOfMinus2Cards < 0) then locks[i].noOfMinus2Cards = 0
			if (locks[i].noOfMinus2Cards > cappedYellowCardsEachType) then locks[i].noOfMinus2Cards = cappedYellowCardsEachType
			if (locks[i].pickedCountIncludingYellows < locks[i].pickedCount) then locks[i].pickedCountIncludingYellows = locks[i].pickedCount
			if (locks[i].redCards < 0) then locks[i].redCards = 0
			if (locks[i].redCards > cappedRedCards and locks[i].fixed = 0) then locks[i].redCards = cappedRedCards
			if (locks[i].resetCards < 0) then locks[i].resetCards = 0
			if (locks[i].stickyCards < 0) then locks[i].stickyCards = 0
			if (locks[i].resetCards > cappedResetCards) then locks[i].resetCards = cappedResetCards
			if (locks[i].yellowCards < 0) then locks[i].yellowCards = 0
			if (locks[i].yellowCards > cappedYellowCardsTotal) then locks[i].yellowCards = cappedYellowCardsTotal
		
			if (locks[i].emojiColourSelected = 0) then locks[i].emojiColourSelected = 1
			if (fixed = 0 and locks[i].goAgainCardsPercentage# = 0) then locks[i].goAgainCardsPercentage# = random(minGoAgainPercentage# * 100.0, maxGoAgainPercentage# * 100.0) / 100.0
			if (locks[i].keyholderEmojiColourSelected = 0) then locks[i].keyholderEmojiColourSelected = 1
			if (locks[i].botChosen = 1) then locks[i].keyholderUsername$ = "Hailey"
			if (locks[i].botChosen = 2) then locks[i].keyholderUsername$ = "Blaine"
			if (locks[i].botChosen = 3) then locks[i].keyholderUsername$ = "Zoe"
			if (locks[i].botChosen = 4) then locks[i].keyholderUsername$ = "Chase"
			if (locks[i].sharedID$ <> "") then inc noOfLocksControlledByKeyholder
			if (banned = 1 and locks[i].unlocked = 0 and locks[i].keyholderUsername$ <> "" and locks[i].botChosen = 0)
				UnlockLock(i, "App", "Banned")
			endif
			CloseFile(fileID)
			total = GetNoOfCards(i)
			if (total > largestDeckSize) then largestDeckSize = total
			if (GetFileExists("ID" + str(locks[i].id) + "V2.log")) then locks[i].lockLog.load("ID" + str(locks[i].id) + "V2.log")
			
			// LOCK FIXES
			if (locks[i].timestampLocked <= 1500000000 and locks[i].groupID > 1500000000) then locks[i].timestampLocked = locks[i].groupID
			if (locks[i].timestampLastPicked <= 1500000000 and locks[i].fixed = 1)
				if (locks[i].regularity# = 0.016667)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 60
				elseif (locks[i].regularity# = 0.25)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 900
				elseif (locks[i].regularity# = 0.50)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 1800
				elseif (locks[i].regularity# = 1)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 3600
				elseif (locks[i].regularity# = 3)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 10800
				elseif (locks[i].regularity# = 6)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 21600
				elseif (locks[i].regularity# = 12)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 43200
				elseif (locks[i].regularity# = 24)
					locks[i].timestampLastPicked = locks[i].timestampLocked - 86400
				endif
			endif
//~			if (locks[i].timestampLastPicked <= 1500000000 and locks[i].fixed = 0)
//~				if (locks[i].regularity# = 0.016667)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 60
//~				elseif (locks[i].regularity# = 0.25)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 900
//~				elseif (locks[i].regularity# = 0.50)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 1800
//~				elseif (locks[i].regularity# = 1)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 3600
//~				elseif (locks[i].regularity# = 3)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 10800
//~				elseif (locks[i].regularity# = 6)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 21600
//~				elseif (locks[i].regularity# = 12)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 43200
//~				elseif (locks[i].regularity# = 24)
//~					locks[i].timestampLastPicked = locks[i].timestampLocked - 86400
//~				endif
//~				for j = 0 to locks[i].lockLog.length
//~					if (locks[i].lockLog[j].action$ = "PickedACard")
//~						if (locks[i].lockLog[j].timestamp > locks[i].timestampLastPicked)
//~							if (locks[lockSelected].lockLog[sortedIteration].result$ = "FreezeCard")
//~								locks[i].timestampLastPicked = locks[i].lockLog[j].timestamp
//~							endif
//~							if (locks[lockSelected].lockLog[sortedIteration].result$ = "RedCard")
//~								locks[i].timestampLastPicked = locks[i].lockLog[j].timestamp
//~							endif
//~							if (locks[lockSelected].lockLog[sortedIteration].result$ = "ResetCard")
//~								locks[i].timestampLastPicked = locks[i].lockLog[j].timestamp
//~							endif
//~							if (locks[lockSelected].lockLog[sortedIteration].result$ = "StickyCard")
//~								locks[i].timestampLastPicked = locks[i].lockLog[j].timestamp
//~							endif
//~						endif
//~					endif
//~				next
//~			endif
		endif
	next
	ResetAllNotifications()
endfunction

function GetLockLog(lockNo, addToFront)
	local lastLogID as integer
	local postData$ as string
	
	if (locks[lockNo].lockLog.length >= 0)
		lastLogID = locks[lockNo].lockLog[locks[lockNo].lockLog.length].id
	else
		lastLogID = 0
	endif
	postData$ = ""
	postData$ = postData$ + "&build=" + str(locks[lockNo].build)
	postData$ = postData$ + "&lastLogID=" + str(lastLogID)
	postData$ = postData$ + "&lockID=" + str(locks[lockNo].id)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetLockLog=" + str(locks[lockNo].id) + ";script:" + URLs[0].URLPath + "/" + URLs[0].GetLockLog + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetLockUpdates(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetLockUpdates;script:" + URLs[0].URLPath + "/" + URLs[0].GetLockUpdates + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetMyLocksDeleted(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetMyLocksDeleted;script:" + URLs[0].URLPath + "/" + URLs[0].GetMyLocksDeleted + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetNoOfCards(lockNo as integer)
	local totalCards as integer
	
	totalCards = locks[lockNo].doubleUpCards + locks[lockNo].freezeCards + locks[lockNo].goAgainCards + locks[lockNo].greenCards + locks[lockNo].redCards + locks[lockNo].resetCards + locks[lockNo].stickyCards + locks[lockNo].yellowCards
endfunction totalCards

function GetOthersRelations(profileID as integer, addToFront)
	local postData$ as string
	
	othersFriends.blockedByOthers.length = -1
	othersFriends.blockedByOthersDelimitedIDs$ = ""
	othersFriends.blockedByYou.length = -1
	othersFriends.blockedByYouDelimitedIDs$ = ""
	othersFriends.followers.length = -1
	othersFriends.followersDelimitedIDs$ = ""
	othersFriends.following.length = -1
	othersFriends.followingDelimitedIDs$ = ""
	othersFriends.pendingByOthers.length = -1
	othersFriends.pendingByOthersDelimitedIDs$ = ""
	othersFriends.pendingByYou.length = -1	
	othersFriends.pendingByYouDelimitedIDs$ = ""
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetOthersRelations;script:" + URLs[0].URLPath + "/" + URLs[0].GetOthersRelations + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetPreviousBreadcrumb()
	local previousBreadcrumb as integer
	
	if (breadcrumbs.length - 1 >= 0)
		previousBreadcrumb = breadcrumbs[breadcrumbs.length - 1]
	else
		if (screenNo = constMyLocksScreen or screenNo = constSharedLocksScreen)
			MinimizeApp()
		else
			screenNo = selectedLocksTab
		endif
	endif
endfunction previousBreadcrumb

function GetProfileData(profileID as integer, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetProfileData=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].GetProfileData + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetRecentActivity(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GettRecentActivity;script:" + URLs[0].URLPath + "/" + URLs[0].GetRecentActivity + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetServerVariables(addToFront)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetServerVariables;script:" + URLs[0].URLPath + "/" + URLs[0].GetServerVariables + ";postData:;addToFront:" + str(addToFront))
endfunction

function GetSharedLockInformation(id$, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&sharedID=" + id$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetSharedLockInformation=" + id$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].GetSharedLockInformation + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetSharedLocksData(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetSharedLocks;script:" + URLs[0].URLPath + "/" + URLs[0].GetSharedLocksData + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetSharedLocksDeleted(addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetSharedLocksDeleted;script:" + URLs[0].URLPath + "/" + URLs[0].GetSharedLocksDeleted + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetSharedLockUsersData(id$, usersTab, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&seed=" + str(databaseRandomSeed)
	postData$ = postData$ + "&sharedID=" + id$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&usersTab=" + str(usersTab)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetSharedLockUsersData=" + id$ + "," + str(usersTab) + ";script:" + URLs[0].URLPath + "/" + URLs[0].GetSharedLockUsersData + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function GetUserLog(sharedLockNo, userNo, usersTab, addToFront)
	local lastLogID as integer
	local postData$ as string
	
	lastLogID = 0
	postData$ = ""
	postData$ = postData$ + "&build=" + str(sharedLocks[sharedLockNo, usersTab].usersLockBuildNumber[userNo])
	postData$ = postData$ + "&lastLogID=" + str(lastLogID)
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, usersTab].usersLockID[userNo])
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&usersID=" + str(sharedLocks[sharedLockNo, usersTab].usersID[userNo])
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetUserLog=" + str(sharedLockNo) + "," + str(userNo) + "," + str(usersTab) + ";script:" + URLs[0].URLPath + "/" + URLs[0].GetUserLog + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

//~function GetUsersList(addToFront)
//~	local postData$ as string
//~	
//~	postData$ = ""
//~	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
//~	postData$ = postData$ + "&userID1=" + userID$
//~	postData$ = postData$ + "&userID2=" + userID$
//~	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetUsersList;script:" + URLs[0].URLPath + "/" + URLs[0].GetUsersList + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
//~endfunction

function GetYourRelations(addToFront)
	local postData$ as string
	
	yourFriends.blockedByOthers.length = -1
	yourFriends.blockedByOthersDelimitedIDs$ = ""
	yourFriends.blockedByYou.length = -1
	yourFriends.blockedByYouDelimitedIDs$ = ""
	yourFriends.followers.length = -1
	yourFriends.followersDelimitedIDs$ = ""
	yourFriends.following.length = -1
	yourFriends.followingDelimitedIDs$ = ""
	yourFriends.pendingByOthers.length = -1
	yourFriends.pendingByOthersDelimitedIDs$ = ""
	yourFriends.pendingByYou.length = -1	
	yourFriends.pendingByYouDelimitedIDs$ = ""
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:GetYourRelations;script:" + URLs[0].URLPath + "/" + URLs[0].GetYourRelations + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function InsertLastUpdate(lockNo, update$, timestampUpdated)
	local i as integer
	local insertUpdate as integer
	
	insertUpdate = 0 
	for i = 4 to 1 step -1
		locks[lockNo].lastXUpdates[i].timestampUpdated = locks[lockNo].lastXUpdates[i - 1].timestampUpdated
		locks[lockNo].lastXUpdates[i].update$ = locks[lockNo].lastXUpdates[i - 1].update$
	next
	locks[lockNo].lastXUpdates[0].timestampUpdated = timestampUpdated
	locks[lockNo].lastXUpdates[0].update$ = update$
endfunction

function LogOut()
	ResetLockData()
	defaultUsername$ = ""
	banned = 0
	SaveLocalVariable("banned", str(banned))
	defaultUsername$ = ""
	discordDiscriminator = 0
	SaveLocalVariable("discordDiscriminator", str(discordDiscriminator))
	discordID$ = ""
	SaveLocalVariable("discordID", discordID$)
	discordUsername$ = ""
	SaveLocalVariable("discordUsername", discordUsername$)
	keyholderLevel = 1
	SaveLocalVariable("keyholderLevel", str(keyholderLevel))
	lockeeLevel = 1
	SaveLocalVariable("lockeeLevel", str(lockeeLevel))
	mainRoleSelected = 2
	SaveLocalVariable("mainRoleSelected", str(mainRoleSelected))
	noOfKeys = 0
	SaveLocalVariable("noOfKeys", str(noOfKeys))
	noOfKeysPurchased = 0
	SaveLocalVariable("noOfKeysPurchased", str(noOfKeysPurchased))
	noOfLocksNaturallyUnlocked = 0
	SaveLocalVariable("noOfLocksNaturallyUnlocked", str(noOfLocksNaturallyUnlocked))
	notificationsOn = 1
	SaveLocalVariable("notificationsOn", str(notificationsOn))
	privateProfile = 0
	SaveLocalVariable("privateProfile", str(privateProfile))
	reasonBanned$ = ""
	showCombinationsToKeyholders = 0
	SaveLocalVariable("showCombinationsToKeyholders", str(showCombinationsToKeyholders))
	statusSelected = 1
	SaveLocalVariable("statusSelected", str(statusSelected))
	timesReviewBoxShown = 0
	SaveLocalVariable("timesReviewBoxShown", str(timesReviewBoxShown))
	twitterHandle$ = ""
	SaveLocalVariable("twitterHandle", twitterHandle$)
	userDBRow = 0
	SaveLocalVariable("userDBRow", str(userDBRow))
	userID$ = ""
	SaveLocalVariable("userID", userID$)
	username$ = ""
	SaveLocalVariable("username", username$)
	visibleInPublicStats = 0
	SaveLocalVariable("visibleInPublicStats", str(visibleInPublicStats))
	OryUIUpdateTextfield(editBoxLoginUserID, "inputText:;")
	SetScreenToView(constLoginScreen)
endfunction

function MoveCardTo(id, x#, y#)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.25)
	SetTweenSpriteXByOffset(cards[id].tweenSprite[1], GetSpriteXByOffset(cards[id].sprite), x#, TweenLinear())
	SetTweenSpriteYByOffset(cards[id].tweenSprite[1], GetSpriteYByOffset(cards[id].sprite), y#, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while(GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
endfunction

function MoveToCard(id)
	newViewX# = GetSpriteXByOffset(cardReleased) - 50
	if (newViewX# < (constCardsScreen * 100)) then newViewX# = (constCardsScreen * 100)
	if (newViewX# > (constCardsScreen * 100) + ((noOfCardScreens# - 1) * 100)) then newViewX# = (constCardsScreen * 100) + ((noOfCardScreens# - 1) * 100)
	if (GetViewOffsetX() <> newViewX#)
		tweenScrollCardsScreen = CreateTweenCustom(0.25)
		SetTweenCustomFloat1(tweenScrollCardsScreen, GetViewOffsetX(), newViewX#, TweenLinear())
		PlayTweenCustom(tweenScrollCardsScreen, 0)
	endif
endfunction

function PullDownToRefresh(screenNo, startY#, endY#, imageHeight#)
	local distanceSwiped# as float
	local maxDistance# as float
	local refresh as integer
	local smallestDistance# as float
	
	refresh = 0
	maxDistance# = (endY# - startY#) + imageHeight#
	smallestDistance# = MinFloat(OryUIGetSwipingDistanceY(), maxDistance#)

	SetSpriteScissor(sprPullToRefreshCircle, screenNo * 100, startY#, (screenNo * 100) + 100, startY# + maxDistance#)
	SetSpriteScissor(sprPullToRefreshIcon, screenNo * 100, startY#, (screenNo * 100) + 100, startY# + maxDistance#)
	
	if (GetPointerPressed())
	
	else
		if (GetPointerState())
			if (GetViewOffsetY() = 0 and OryUIGetTouchStartY() > startY# and GetPointerY() > OryUIGetTouchStartY())
				SetSpritePositionByOffset(sprPullToRefreshCircle, (screenNo * 100) + 50, (startY# - (imageHeight# / 2)) + ((smallestDistance# / maxDistance#) * maxDistance#))
				SetSpritePositionByOffset(sprPullToRefreshIcon, (screenNo * 100) + 50, (startY# - (imageHeight# / 2)) + ((smallestDistance# / maxDistance#) * maxDistance#))
	
				SetSpriteAngle(sprPullToRefreshIcon, (MinFloat(OryUIGetSwipingDistanceY(), maxDistance#) / maxDistance#) * 360)
		
				SetSpriteColor(sprPullToRefreshCircle, GetColorRed(theme[themeSelected].color[3]), GetColorGreen(theme[themeSelected].color[3]), GetColorBlue(theme[themeSelected].color[3]), 255)
				SetSpriteColor(sprPullToRefreshIcon, 255, 255, 255, (MinFloat(OryUIGetSwipingDistanceY(), maxDistance# / 1.5) / (maxDistance# / 1.5)) * 255)

				distanceSwiped# = OryUIGetSwipingDistanceY()
			endif
		endif
		if (GetPointerReleased())
			if (GetSpriteYByOffset(sprPullToRefreshCircle) > startY# + (maxDistance# / 2) - (imageHeight# / 2))
				refresh = 1
			endif
			SetSpritePosition(sprPullToRefreshCircle, -1000, -1000)
			SetSpritePosition(sprPullToRefreshIcon, -1000, -1000)
			SetSpriteAngle(sprPullToRefreshIcon, 0)
		endif
	endif
	if (GetViewOffsetY() > 0)
		SetSpritePosition(sprPullToRefreshCircle, -1000, -1000)
		SetSpritePosition(sprPullToRefreshIcon, -1000, -1000)
		SetSpriteAngle(sprPullToRefreshIcon, 0)
	endif
endfunction refresh

function RandomChar()
	local randomChar$ as string
	
	randomChar$ = ""
	if (random2(0, 1) = 0)
		randomChar$ = chr(random2(50, 57))
	else
		repeat
			randomChar$ = chr(random2(65, 90))
		until (randomChar$ <> "I" and randomChar$ <> "O")
	endif
endfunction randomChar$

function RandomShareID()
	local i as integer
	
	repeat
		shareID$ = ""
		for i = 1 to 15
			shareID$ = shareID$ + RandomChar()
		next
	until (len(shareID$) = 15)
endfunction shareID$

function RandomUserID()
	local i as integer
	
	userID$ = ""
	SaveLocalVariable("userID", userID$)
	username$ = ""
	SaveLocalVariable("username", username$)
	userDBRow = 0
	SaveLocalVariable("userDBRow", str(userDBRow))
	repeat
		userID$ = ""
		for i = 1 to 23
			if (i = 6 or i = 12 or i = 18)
				userID$ = userID$ + "-"
			else
				userID$ = userID$ + RandomChar()
			endif
		next
	until (len(userID$) = 23)
endfunction userID$

function ReceivedAccountData()
	jsonData.length = -1
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	if (val(GetJSONDataVariableValue("id")) > 0)
		userDBRow = val(GetJSONDataVariableValue("id"))
		SaveLocalVariable("userDBRow", str(userDBRow))
		
		averageRating# = valFloat(GetJSONDataVariableValue("averageRating"))
		
		banned = val(GetJSONDataVariableValue("banned"))
		SaveLocalVariable("banned", str(banned))
		if (banned = 1) then selectedLocksTab = 1
		
		discordDiscriminator = val(GetJSONDataVariableValue("discordDiscriminator"))
		SaveLocalVariable("discordDiscriminator", str(discordDiscriminator))
		discordID$ = GetJSONDataVariableValue("discordID")
		SaveLocalVariable("discordID", discordID$)
		discordUsername$ = GetJSONDataVariableValue("discordUsername")
		SaveLocalVariable("discordUsername", discordUsername$)
		
		freeAdsRemovalAvailable = val(GetJSONDataVariableValue("freeAdsRemovalAvailable"))
		freeKeysAvailable = val(GetJSONDataVariableValue("freeKeysAvailable"))
		
		keyholderLevel = val(GetJSONDataVariableValue("keyholderLevel"))
		if (keyholderLevel = 0) then keyholderLevel = 1
		
		lastRecentActivityIDSeen = val(GetJSONDataVariableValue("lastRecentActivityIDSeen"))
		SaveLocalVariable("lastRecentActivityIDSeen", str(lastRecentActivityIDSeen))
		
		lockeeLevel = val(GetJSONDataVariableValue("lockeeLevel"))
		if (lockeeLevel = 0) then lockeeLevel = 1
		
		mainRoleSelected = val(GetJSONDataVariableValue("mainRoleSelected"))
		if (mainRoleSelected = 0) then mainRoleSelected = 2
		SaveLocalVariable("mainRoleSelected", str(mainRoleSelected))
		
		noOfRatings = val(GetJSONDataVariableValue("noOfRatings"))
		
		privateProfile = val(GetJSONDataVariableValue("privateProfile"))
		
		reasonBanned$ = GetJSONDataVariableValue("reasonBanned")
		
		showCombinationsToKeyholders = val(GetJSONDataVariableValue("showCombinationsToKeyholders"))
		if (showCombinationsToKeyholders = 2) then showCombinationsToKeyholders = 0
		
		showKeyholderStatsOnProfile = val(GetJSONDataVariableValue("showKeyholderStatsOnProfile"))
		SaveLocalVariable("showKeyholderStatsOnProfile", str(showKeyholderStatsOnProfile))
		showLockeeStatsOnProfile = val(GetJSONDataVariableValue("showLockeeStatsOnProfile"))
		SaveLocalVariable("showLockeeStatsOnProfile", str(showLockeeStatsOnProfile))
		
		statusSelected = val(GetJSONDataVariableValue("statusSelected"))
		if (statusSelected = 0) then statusSelected = 1
		SaveLocalVariable("statusSelected", str(statusSelected))
		
		timesReviewBoxShown = val(GetJSONDataVariableValue("timesReviewBoxShown"))
		SaveLocalVariable("timesReviewBoxShown", str(timesReviewBoxShown))
		
		twitterHandle$ = GetJSONDataVariableValue("twitterHandle")
		SaveLocalVariable("twitterHandle", twitterHandle$)
		
		defaultUsername$ = "CKU" + GetJSONDataVariableValue("id")
		username$ = GetJSONDataVariableValue("username")
		if (username$ = "") then username$ = defaultUsername$
		SaveLocalVariable("username", username$)

		visibleInPublicStats = val(GetJSONDataVariableValue("visibleInPublicStats"))
		if (visibleInPublicStats = 2) then visibleInPublicStats = 0
		SaveLocalVariable("visibleInPublicStats", str(visibleInPublicStats))
	
		accountDataReceived = 1
	endif
endfunction

function ReceivedAPIProjects()
	local i as integer
	
	jsonData as typeAPIProject[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	apiProjects.length = jsonData.length
	for i = 0 to jsonData.length
		apiProjects[i].name$ = jsonData[i].name$
		apiProjects[i].clientID$ = jsonData[i].clientID$
		apiProjects[i].clientSecret$ = jsonData[i].clientSecret$
		apiProjects[i].banned = jsonData[i].banned
		apiProjects[i].bot = jsonData[i].bot
		apiProjects[i].desktopApp = jsonData[i].desktopApp
		apiProjects[i].dontKnow = jsonData[i].dontKnow
		apiProjects[i].lastCalled = jsonData[i].lastCalled
		apiProjects[i].lockBox = jsonData[i].lockBox
		apiProjects[i].mobileApp = jsonData[i].mobileApp
		apiProjects[i].resetsIn = jsonData[i].resetsIn
		apiProjects[i].somethingElse = jsonData[i].somethingElse
		apiProjects[i].tokens = jsonData[i].tokens
		apiProjects[i].tokensPerMinute = jsonData[i].tokensPerMinute
		apiProjects[i].totalRequestsMade = jsonData[i].totalRequestsMade
		apiProjects[i].website = jsonData[i].website
	next
	apiProjects.save("apiProjects.json")
endfunction
	
function ReceivedDeleteLockResponse(lockNo)
	local a as integer
	local fileID as integer
	
	if (lockNo > -1)
		DeleteFile("ID" + str(locks[lockNo].id) + "V2.txt")
		DeleteFile("ID" + str(locks[lockNo].id) + "V2.log")
		locks.remove(lockNo)
		locks.insert(blankLock)
		fileID = OpenToWrite("locksV2.txt", 0)
		for a = 1 to 20
			WriteInteger(fileID, locks[a].id)
		next
		CloseFile(fileID)
		noOfLocks = noOfLocks - 1
		SaveLocalVariable("noOfLocks", str(noOfLocks))
		ResetAllNotifications()
	endif
endfunction

function ReceivedGeneratedLocks()
	local i as integer
	
	jsonData as typeGeneratedLocks[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	generatedLocks.length = jsonData.length
	for i = 0 to jsonData.length
		generatedLocks[i].id = jsonData[i].id
		generatedLocks[i].build = jsonData[i].build
		generatedLocks[i].level = jsonData[i].level
		generatedLocks[i].maxRandomDoubleUps = jsonData[i].maxRandomDoubleUps
		generatedLocks[i].maxRandomFreezes = jsonData[i].maxRandomFreezes
		generatedLocks[i].maxRandomGreens = jsonData[i].maxRandomGreens
		generatedLocks[i].maxRandomReds = jsonData[i].maxRandomReds
		generatedLocks[i].maxRandomResets = jsonData[i].maxRandomResets
		generatedLocks[i].maxRandomStickies = jsonData[i].maxRandomStickies
		generatedLocks[i].maxRandomYellows = jsonData[i].maxRandomYellows
		generatedLocks[i].maxRandomYellowsAdd = jsonData[i].maxRandomYellowsAdd
		generatedLocks[i].maxRandomYellowsMinus = jsonData[i].maxRandomYellowsMinus
		generatedLocks[i].minRandomDoubleUps = jsonData[i].minRandomDoubleUps
		generatedLocks[i].minRandomFreezes = jsonData[i].minRandomFreezes
		generatedLocks[i].minRandomGreens = jsonData[i].minRandomGreens
		generatedLocks[i].minRandomReds = jsonData[i].minRandomReds
		generatedLocks[i].minRandomResets = jsonData[i].minRandomResets
		generatedLocks[i].minRandomStickies = jsonData[i].minRandomStickies
		generatedLocks[i].minRandomYellows = jsonData[i].minRandomYellows
		generatedLocks[i].minRandomYellowsAdd = jsonData[i].minRandomYellowsAdd
		generatedLocks[i].minRandomYellowsMinus = jsonData[i].minRandomYellowsMinus
		generatedLocks[i].multipleGreensRequired = jsonData[i].multipleGreensRequired
		generatedLocks[i].noOfMatches = jsonData[i].noOfMatches
		generatedLocks[i].regularity# = jsonData[i].regularity#
		generatedLocks[i].simulationAverageMinutesLocked = jsonData[i].simulationAverageMinutesLocked
		generatedLocks[i].simulationBestCaseMinutesLocked = jsonData[i].simulationBestCaseMinutesLocked
		generatedLocks[i].simulationWorstCaseMinutesLocked = jsonData[i].simulationWorstCaseMinutesLocked
		generatedLocks[i].version$ = jsonData[i].version$
	next
endfunction

function ReceivedKeyholdersData()
	local a as integer
	local b as integer
	
	jsonData as typeLock[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for a = 1 to jsonData.length + 1
		for b = 1 to 20
			if (locks[b].id = jsonData[a - 1].id)
				locks[b].keyholderBuildNumberInstalled = jsonData[a - 1].keyholderBuildNumberInstalled
				locks[b].keyholderEmojiChosen = jsonData[a - 1].keyholderEmojiChosen
				locks[b].keyholderEmojiColourSelected = jsonData[a - 1].keyholderEmojiColourSelected
				if (locks[b].keyholderEmojiColourSelected = 0) then locks[b].keyholderEmojiColourSelected = 1
				// RECODE OLD VERSION EMOJIS (BEST I CAN)
				if (locks[b].keyholderBuildNumberInstalled < 134 and jsonData[a - 1].keyholderEmojiChosen > 0 and jsonData[a - 1].keyholderEmojiColourSelected = 0)
					if (jsonData[a - 1].keyholderEmojiChosen = 1)
						locks[b].keyholderEmojiChosen = 1
					elseif (jsonData[a - 1].keyholderEmojiChosen = 2)
						locks[b].keyholderEmojiChosen = 2
					elseif (jsonData[a - 1].keyholderEmojiChosen = 3)
						locks[b].keyholderEmojiChosen = 3
					elseif (jsonData[a - 1].keyholderEmojiChosen = 4)
						locks[b].keyholderEmojiChosen = 18
					elseif (jsonData[a - 1].keyholderEmojiChosen = 5)
						locks[b].keyholderEmojiChosen = 17
					elseif (jsonData[a - 1].keyholderEmojiChosen = 6)
						locks[b].keyholderEmojiChosen = 9
					elseif (jsonData[a - 1].keyholderEmojiChosen = 7)
						locks[b].keyholderEmojiChosen = 24
					elseif (jsonData[a - 1].keyholderEmojiChosen = 8)
						locks[b].keyholderEmojiChosen = 8
					elseif (jsonData[a - 1].keyholderEmojiChosen = 9)
						locks[b].keyholderEmojiChosen = 19
					elseif (jsonData[a - 1].keyholderEmojiChosen = 10)
						locks[b].keyholderEmojiChosen = 65
					elseif (jsonData[a - 1].keyholderEmojiChosen = 11)
						locks[b].keyholderEmojiChosen = 62
					elseif (jsonData[a - 1].keyholderEmojiChosen = 12)
						locks[b].keyholderEmojiChosen = 43
					elseif (jsonData[a - 1].keyholderEmojiChosen = 13)
						locks[b].keyholderEmojiChosen = 44
					elseif (jsonData[a - 1].keyholderEmojiChosen = 14)
						locks[b].keyholderEmojiChosen = 53
					elseif (jsonData[a - 1].keyholderEmojiChosen = 15)
						locks[b].keyholderEmojiChosen = 46
					elseif (jsonData[a - 1].keyholderEmojiChosen = 16)
						locks[b].keyholderEmojiChosen = 51
					elseif (jsonData[a - 1].keyholderEmojiChosen = 17)
						locks[b].keyholderEmojiChosen = 52
					elseif (jsonData[a - 1].keyholderEmojiChosen = 18)
						locks[b].keyholderEmojiChosen = 66
					elseif (jsonData[a - 1].keyholderEmojiChosen = 19)
						locks[b].keyholderEmojiChosen = 34
					elseif (jsonData[a - 1].keyholderEmojiChosen = 20)
						locks[b].keyholderEmojiChosen = 72
					elseif (jsonData[a - 1].keyholderEmojiChosen = 21)
						locks[b].keyholderEmojiChosen = 63
					elseif (jsonData[a - 1].keyholderEmojiChosen = 22)
						locks[b].keyholderEmojiChosen = 59
					elseif (jsonData[a - 1].keyholderEmojiChosen = 23)
						locks[b].keyholderEmojiChosen = 34
					elseif (jsonData[a - 1].keyholderEmojiChosen = 24)
						locks[b].keyholderEmojiChosen = 36
					elseif (jsonData[a - 1].keyholderEmojiChosen = 25)
						locks[b].keyholderEmojiChosen = 58
					endif
				endif	
				locks[b].keyholderID = jsonData[a - 1].keyholderID
				locks[b].keyholderLastActive = jsonData[a - 1].keyholderLastActive
				locks[b].keyholderMainRole = jsonData[a - 1].keyholderMainRole
				if (locks[b].botChosen > 0) then locks[b].keyholderMainRole = 1
				locks[b].keyholderMainRoleLevel = jsonData[a - 1].keyholderMainRoleLevel
				locks[b].keyholderStatus = jsonData[a - 1].keyholderStatus
				locks[b].keyholderUsername$ = jsonData[a - 1].keyholderUsername$
				if (locks[b].botChosen = 1)
					locks[b].keyholderID = 3948
					locks[b].keyholderUsername$ = "Hailey"
				endif
				if (locks[b].botChosen = 2)
					locks[b].keyholderID = 3949
					locks[b].keyholderUsername$ = "Blaine"
				endif
				if (locks[b].botChosen = 3)
					locks[b].keyholderID = 3950
					locks[b].keyholderUsername$ = "Zoe"
				endif
				if (locks[b].botChosen = 4)
					locks[b].keyholderID = 3951
					locks[b].keyholderUsername$ = "Chase"
				endif
				if (locks[b].rowInDB = 0) then locks[b].rowInDB = jsonData[a - 1].rowInDB
				if (jsonData[a - 1].hiddenFromOwner = 1 and locks[b].hiddenFromOwner = 0)
					locks[b].hiddenFromOwner = 1
					locks[b].hiddenFromOwnerAlertHidden = 0
					if (locks[b].lockFrozenByKeyholder = 1)
						if (locks[b].fixed = 0)
							if (locks[b].chancesAccumulatedBeforeFreeze > 0)
								if (locks[b].regularity# = 0.016667)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (60 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 0.25)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (900 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 0.5)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (1800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 1)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (3600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 3)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (10800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 6)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (21600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 12)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (43200 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 24)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampHiddenFromOwner - (86400 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								endif
							else
								if (locks[b].regularity# = 0.016667)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (60 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 0.25)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (900 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 0.5)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (1800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 1)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (3600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 3)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (10800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 6)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (21600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 12)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (43200 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 24)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampHiddenFromOwner - (86400 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								endif
							endif
						endif
						locks[b].timestampUnfrozen = jsonData[a - 1].timestampHiddenFromOwner
						if (locks[b].fixed = 0 and locks[b].lockFrozenByCard = 1 and locks[b].timestampFrozenByCard > 0 and locks[b].timestampUnfrozen > 0)
							locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByCard)
						endif
						if (locks[b].lockFrozenByKeyholder = 1 and locks[b].timestampFrozenByKeyholder > 0 and locks[b].timestampUnfrozen > 0)
							locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByKeyholder)
						endif
						locks[b].chancesAccumulatedBeforeFreeze = 0
						locks[b].lockFrozenByCard = 0
						locks[b].lockFrozenByKeyholder = 0
						locks[b].timeLeftUntilNextChanceBeforeFreeze = 0
						locks[b].timestampUnfreezes = 0
						locks[b].timestampUnfrozen = locks[b].timestampLastPicked
					endif
					locks[b].keyDisabled = 0
					locks[b].timestampHiddenFromOwner = jsonData[a - 1].timestampHiddenFromOwner
				elseif (jsonData[a - 1].hiddenFromOwner = 0 and locks[b].hiddenFromOwner = 1)
					locks[b].hiddenFromOwner = 0
					locks[b].hiddenFromOwnerAlertHidden = 0
					if (locks[b].keyholderDisabledKey = 1) then locks[b].keyDisabled = 1
					locks[b].timestampHiddenFromOwner = 0
				endif
				if (jsonData[a - 1].removedByKeyholder = 1 and locks[b].removedByKeyholder = 0)
					locks[b].removedByKeyholder = 1
					locks[b].removedByKeyholderAlertHidden = 0
					if (locks[b].lockFrozenByKeyholder = 1)
						if (locks[b].fixed = 0)
							if (locks[b].chancesAccumulatedBeforeFreeze > 0)
								if (locks[b].regularity# = 0.016667)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (60 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 0.25)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (900 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 0.5)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (1800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 1)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (3600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 3)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (10800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 6)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (21600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 12)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (43200 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								elseif (locks[b].regularity# = 24)
									locks[b].timestampLastPicked = (jsonData[a - 1].timestampRemovedByKeyholder - (86400 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
								endif
							else
								if (locks[b].regularity# = 0.016667)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (60 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 0.25)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (900 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 0.5)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (1800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 1)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (3600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 3)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (10800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 6)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (21600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 12)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (43200 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								elseif (locks[b].regularity# = 24)
									locks[b].timestampLastPicked = jsonData[a - 1].timestampRemovedByKeyholder - (86400 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
								endif
							endif
						endif
						locks[b].timestampUnfrozen = jsonData[a - 1].timestampRemovedByKeyholder
						if (locks[b].fixed = 0 and locks[b].lockFrozenByCard = 1 and locks[b].timestampFrozenByCard > 0 and locks[b].timestampUnfrozen > 0)
							locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByCard)
						endif
						if (locks[b].lockFrozenByKeyholder = 1 and locks[b].timestampFrozenByKeyholder > 0 and locks[b].timestampUnfrozen > 0)
							locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByKeyholder)
						endif
						locks[b].chancesAccumulatedBeforeFreeze = 0
						locks[b].lockFrozenByCard = 0
						locks[b].lockFrozenByKeyholder = 0
						locks[b].timeLeftUntilNextChanceBeforeFreeze = 0
						locks[b].timestampUnfreezes = 0
						locks[b].timestampUnfrozen = locks[b].timestampLastPicked
					endif
					locks[b].keyDisabled = 0
					locks[b].timestampRemovedByKeyholder = jsonData[a - 1].timestampRemovedByKeyholder
				endif
				if (locks[b].keyholderUsername$ = username$ or locks[b].hiddenFromOwner = 1 or locks[b].removedByKeyholder = 1)
					locks[b].keyholderBuildNumberInstalled = 0
					locks[b].keyholderEmojiChosen = 0
					locks[b].keyholderEmojiColourSelected = 1
					locks[b].keyholderID = 0
					locks[b].keyholderMainRole = 0
					locks[b].keyholderMainRoleLevel = 0
					locks[b].keyholderStatus = 0
					locks[b].keyholderUsername$ = ""
				endif
				if (locks[b].keyholderUsername$ <> "" and locks[b].botChosen = 0) then locks[b].lockName$ = jsonData[a - 1].lockName$
				if (locks[b].botChosen > 0 and jsonData[a - 1].lockName$ <> "") then locks[b].lockName$ = jsonData[a - 1].lockName$
				UpdateLocksData(b)
			endif
		next
	next
endfunction

function ReceivedLockLog(lockNo)
	local a as integer
	local lastLogID as integer
	local lastLogRow as integer
	local logRow as integer
	
	if (locks[lockNo].lockLog.length >= 0)
		lastLogID = locks[lockNo].lockLog[locks[lockNo].lockLog.length].id
	else
		lastLogID = 0
	endif
	jsonData as typeLog[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for a = 1 to jsonData.length + 1
		if (jsonData[a - 1].id > lastLogID)
			lastLogRow = locks[lockNo].lockLog.length
			// SKIP ITEM IF HIDDEN AND PART OF THE SAME GROUP AS THE LAST ITEM
			if (lastLogRow > -1)
				if (jsonData[a - 1].hidden = 1 and locks[lockNo].lockLog[lastLogRow].hidden = 1 and jsonData[a - 1].timestamp = locks[lockNo].lockLog[lastLogRow].timestamp)
					continue
				endif
			endif
			// SKIP IF STARTED LOCK IN THE LOG TWICE
			if (lastLogRow > -1)
				if (jsonData[a - 1].action$ = "StartedLock" and locks[lockNo].lockLog[lastLogRow].action$ = "StartedLock")
					continue
				endif
			endif
			locks[lockNo].lockLog.length = locks[lockNo].lockLog.length + 1
			logRow = locks[lockNo].lockLog.length
			locks[lockNo].lockLog[logRow].action$ = jsonData[a - 1].action$
			locks[lockNo].lockLog[logRow].actionedBy$ = jsonData[a - 1].actionedBy$
			locks[lockNo].lockLog[logRow].hidden = jsonData[a - 1].hidden
			locks[lockNo].lockLog[logRow].id = jsonData[a - 1].id
			locks[lockNo].lockLog[logRow].lockID = jsonData[a - 1].lockID
			locks[lockNo].lockLog[logRow].private = jsonData[a - 1].private
			locks[lockNo].lockLog[logRow].result$ = jsonData[a - 1].result$
			locks[lockNo].lockLog[logRow].timestamp = jsonData[a - 1].timestamp
			locks[lockNo].lockLog[logRow].totalActionTime = jsonData[a - 1].totalActionTime
		endif
	next
endfunction

function ReceivedLockUpdates()
	local a as integer
	local b as integer
	local cardInfoHiddenString$ as string
	local doubleUpCardString$ as string
	local freezeCardString$ as string
	local greenCardString$ as string
	local lockFrozenByKeyholderString$ as string
	local message$ as string
	local minutesString$ as string
	local redCardString$ as string
	local resetCardString$ as string
	local singleUpdate$ as string
	local stickyCardString$ as string
	local timerHiddenString$ as string
	local unlockedString$ as string
	local yellowCardString$ as string
	
	noOfLockUpdatesAvailable = 0
	jsonData as typeLockUpdates[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	message$ = ""
	for a = 1 to jsonData.length + 1
		cardInfoHiddenString$ = ""
		doubleUpCardString$ = ""
		freezeCardString$ = ""
		greenCardString$ = ""
		lockFrozenByKeyholderString$ = ""
		minutesString$ = ""
		redCardString$ = ""
		resetCardString$ = ""
		stickyCardString$ = ""
		timerHiddenString$ = ""
		unlockedString$ = ""
		yellowCardString$ = ""	
		for b = 1 to 20
			if (locks[b].id = jsonData[a - 1].lockID)
				singleUpdate$ = ""
				if (jsonData[a - 1].id > locks[b].lastUpdateIDSeen)
					inc noOfLockUpdatesAvailable
					locks[b].lastUpdateIDSeen = jsonData[a - 1].id
					locks[b].timestampRibbonAdded = timestampNow
					locks[b].ribbonType$ = "Keyholder Update"
					
					// CARD INFO HIDDEN/SHOWN
					if (jsonData[a - 1].cardInfoHiddenModifiedBy = -1)
						locks[b].cardInfoHidden = 0
						locks[b].goAgainCards = 0
						cardInfoHiddenString$ = " revealing the card information"
					elseif (jsonData[a - 1].cardInfoHiddenModifiedBy = 1)
						locks[b].cardInfoHidden = 1
						cardInfoHiddenString$ = " hiding the card information"	
					endif
					
					// DOUBLE UP CARDS
					if (jsonData[a - 1].doubleUpCardsModifiedBy <> 0)
						locks[b].doubleUpCards = locks[b].doubleUpCards + jsonData[a - 1].doubleUpCardsModifiedBy
						if (locks[b].doubleUpCards < 0) then locks[b].doubleUpCards = 0
						if (locks[b].doubleUpCards > cappedDoubleUpCards) then locks[b].doubleUpCards = cappedDoubleUpCards
						if (jsonData[a - 1].doubleUpCardsModifiedBy < 0)
							if (jsonData[a - 1].doubleUpCardsModifiedBy = -1)
								doubleUpCardString$ = " removing " + str(abs(jsonData[a - 1].doubleUpCardsModifiedBy), 0) + " double up card"	
							else
								doubleUpCardString$ = " removing " + str(abs(jsonData[a - 1].doubleUpCardsModifiedBy), 0) + " double up cards"	
							endif
						endif
						if (jsonData[a - 1].doubleUpCardsModifiedBy > 0)
							if (jsonData[a - 1].doubleUpCardsModifiedBy = 1)
								doubleUpCardString$ = " adding " + str(jsonData[a - 1].doubleUpCardsModifiedBy, 0) + " double up card"
							else
								doubleUpCardString$ = " adding " + str(jsonData[a - 1].doubleUpCardsModifiedBy, 0) + " double up cards"
							endif
						endif
					endif
					
					// FREEZE CARDS
					if (jsonData[a - 1].freezeCardsModifiedBy <> 0)
						locks[b].freezeCards = locks[b].freezeCards + jsonData[a - 1].freezeCardsModifiedBy
						if (locks[b].freezeCards < 0) then locks[b].freezeCards = 0
						if (locks[b].freezeCards > cappedFreezeCards) then locks[b].freezeCards = cappedFreezeCards
						if (jsonData[a - 1].freezeCardsModifiedBy < 0)
							if (jsonData[a - 1].freezeCardsModifiedBy = -1)
								freezeCardString$ = " removing " + str(abs(jsonData[a - 1].freezeCardsModifiedBy), 0) + " freeze card"	
							else
								freezeCardString$ = " removing " + str(abs(jsonData[a - 1].freezeCardsModifiedBy), 0) + " freeze cards"	
							endif
						endif
						if (jsonData[a - 1].freezeCardsModifiedBy > 0)
							if (jsonData[a - 1].freezeCardsModifiedBy = 1)
								freezeCardString$ = " adding " + str(jsonData[a - 1].freezeCardsModifiedBy, 0) + " freeze card"
							else
								freezeCardString$ = " adding " + str(jsonData[a - 1].freezeCardsModifiedBy, 0) + " freeze cards"
							endif
						endif
					endif
					
					// FREEZE LOCK
					if (jsonData[a - 1].lockFrozenByKeyholderModifiedBy = -1)
						if (jsonData[a - 1].reset = 1)
							locks[b].chancesAccumulatedBeforeFreeze = 0
							locks[b].timeLeftUntilNextChanceBeforeFreeze = 0
						endif
						if (locks[b].lockFrozenByCard = 1 or locks[b].lockFrozenByKeyholder = 1)
							if (locks[b].fixed = 0)
								if (locks[b].chancesAccumulatedBeforeFreeze > 0)
									if (locks[b].regularity# = 0.016667)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (60 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 0.25)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (900 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 0.5)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (1800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 1)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (3600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 3)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (10800 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 6)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (21600 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 12)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (43200 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									elseif (locks[b].regularity# = 24)
										locks[b].timestampLastPicked = (jsonData[a - 1].timestampModified - (86400 * locks[b].chancesAccumulatedBeforeFreeze)) + locks[b].timeLeftUntilNextChanceBeforeFreeze
									endif
								else
									if (locks[b].regularity# = 0.016667)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (60 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 0.25)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (900 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 0.5)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (1800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 1)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (3600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 3)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (10800 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 6)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (21600 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 12)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (43200 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									elseif (locks[b].regularity# = 24)
										locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (86400 - locks[b].timeLeftUntilNextChanceBeforeFreeze)
									endif
								endif
							endif
							locks[b].timestampUnfrozen = jsonData[a - 1].timestampModified
							if (locks[b].fixed = 0 and locks[b].lockFrozenByCard = 1 and locks[b].timestampFrozenByCard > 0 and locks[b].timestampUnfrozen > 0)
								locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByCard)
							endif
							if (locks[b].lockFrozenByKeyholder = 1 and locks[b].timestampFrozenByKeyholder > 0 and locks[b].timestampUnfrozen > 0)
								locks[b].totalTimeFrozen = locks[b].totalTimeFrozen + (locks[b].timestampUnfrozen - locks[b].timestampFrozenByKeyholder)
							endif
							locks[b].chancesAccumulatedBeforeFreeze = 0
							locks[b].lockFrozenByCard = 0
							locks[b].lockFrozenByKeyholder = 0
							locks[b].timeLeftUntilNextChanceBeforeFreeze = 0
							locks[b].timestampUnfreezes = 0
							locks[b].timestampUnfrozen = locks[b].timestampLastPicked
							lockFrozenByKeyholderString$ = " unfreezing it"	
						endif
					elseif (jsonData[a - 1].lockFrozenByKeyholderModifiedBy = 1)
						if (locks[b].lockFrozenByKeyholder = 0)
							if (locks[b].fixed = 0)
								if (locks[b].lockFrozenByCard = 1)
									noOfChances = locks[b].chancesAccumulatedBeforeFreeze
								else
									noOfChances = 0
									if (locks[b].regularity# = 0.016667)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60)
									elseif (locks[b].regularity# = 0.25)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 15)
									elseif (locks[b].regularity# = 0.5)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 30)
									elseif (locks[b].regularity# = 1)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 60)
									elseif (locks[b].regularity# = 3)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 60 / 3)
									elseif (locks[b].regularity# = 6)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 60 / 6)
									elseif (locks[b].regularity# = 12)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 60 / 12)
									elseif (locks[b].regularity# = 24)
										noOfChances = floor((timestampNow - locks[b].timestampLastPicked) / 60 / 60 / 24)
									endif
								endif
								if (locks[b].cumulative = 0 and noOfChances > 1) then noOfChances = 1
								if (noOfChances = 0)
									if (locks[b].regularity# = 0.016667) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 60) - timestampNow
									if (locks[b].regularity# = 0.25) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 900) - timestampNow
									if (locks[b].regularity# = 0.5) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 1800) - timestampNow
									if (locks[b].regularity# = 1) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 3600) - timestampNow
									if (locks[b].regularity# = 3) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 10800) - timestampNow
									if (locks[b].regularity# = 6) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 21600) - timestampNow
									if (locks[b].regularity# = 12) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 43200) - timestampNow
									if (locks[b].regularity# = 24) then locks[b].timeLeftUntilNextChanceBeforeFreeze = (locks[b].timestampLastPicked + 86400) - timestampNow
								else
									locks[b].timeLeftUntilNextChanceBeforeFreeze = 0
								endif
								locks[b].chancesAccumulatedBeforeFreeze = noOfChances
							endif
							locks[b].lockFrozenByCard = 0
							locks[b].lockFrozenByKeyholder = 1
							locks[b].timestampUnfreezes = 0
							locks[b].timestampFrozenByCard = 0
							locks[b].timestampFrozenByKeyholder = jsonData[a - 1].timestampModified
							lockFrozenByKeyholderString$ = " freezing it"
						endif
					endif
					
					// GREEN CARDS
					if (jsonData[a - 1].greenCardsModifiedBy <> 0)
						locks[b].greenCards = locks[b].greenCards + jsonData[a - 1].greenCardsModifiedBy
						if (locks[b].greenCards < 0) then locks[b].greenCards = 0
						if (locks[b].greenCards > cappedGreenCards) then locks[b].greenCards = cappedGreenCards
						if (jsonData[a - 1].greenCardsModifiedBy < 0)
							if (jsonData[a - 1].greenCardsModifiedBy = -1)
								greenCardString$ = " removing " + str(abs(jsonData[a - 1].greenCardsModifiedBy), 0) + " green card"
							else
								greenCardString$ = " removing " + str(abs(jsonData[a - 1].greenCardsModifiedBy), 0) + " green cards"
							endif	
						endif
						if (jsonData[a - 1].greenCardsModifiedBy > 0)
							if (jsonData[a - 1].greenCardsModifiedBy = 1)
								greenCardString$ = " adding " + str(jsonData[a - 1].greenCardsModifiedBy, 0) + " green card"
							else
								greenCardString$ = " adding " + str(jsonData[a - 1].greenCardsModifiedBy, 0) + " green cards"
							endif	
						endif
					endif
					
					// MINUTES
					if (jsonData[a - 1].minutesModifiedBy <> 0)
						locks[b].minutes = locks[b].minutes + jsonData[a - 1].minutesModifiedBy
						if (locks[b].minutes < 0) then locks[b].minutes = 0
						if (jsonData[a - 1].minutesModifiedBy < 0)
							minutesString$ = " removing " + ConvertMinutesToText(abs(jsonData[a - 1].minutesModifiedBy), 1)
						endif
						if (jsonData[a - 1].minutesModifiedBy > 0)
							minutesString$ = " adding " + ConvertMinutesToText(jsonData[a - 1].minutesModifiedBy, 1)	
						endif
					endif
					
					// RED CARDS
					if (jsonData[a - 1].redCardsModifiedBy <> 0)
						locks[b].redCards = locks[b].redCards + jsonData[a - 1].redCardsModifiedBy
						if (locks[b].redCards < 0) then locks[b].redCards = 0
						if (locks[b].redCards > cappedRedCards and locks[b].fixed = 0) then locks[b].redCards = cappedRedCards
						if (jsonData[a - 1].redCardsModifiedBy < 0)
							if (locks[b].fixed = 0)
								if (jsonData[a - 1].redCardsModifiedBy = -1)
									redCardString$ = " removing " + str(abs(jsonData[a - 1].redCardsModifiedBy), 0) + " red card"
								else
									redCardString$ = " removing " + str(abs(jsonData[a - 1].redCardsModifiedBy), 0) + " red cards"
								endif
							endif
							if (locks[b].fixed = 1)
								redCardString$ = " removing " + ConvertMinutesToText(abs(jsonData[a - 1].redCardsModifiedBy) * (locks[b].regularity# * 60), 1)
							endif
						endif
						if (jsonData[a - 1].redCardsModifiedBy > 0)
							if (locks[b].fixed = 0)
								if (jsonData[a - 1].redCardsModifiedBy = 1)
									redCardString$ = " adding " + str(jsonData[a - 1].redCardsModifiedBy, 0) + " red card"
								else
									redCardString$ = " adding " + str(jsonData[a - 1].redCardsModifiedBy, 0) + " red cards"
								endif
							endif
							if (locks[b].fixed = 1)
								redCardString$ = " adding " + ConvertMinutesToText(jsonData[a - 1].redCardsModifiedBy * (locks[b].regularity# * 60), 1)
							endif
						endif
					endif
					
					// RESET CARDS
					if (jsonData[a - 1].resetCardsModifiedBy <> 0)
						locks[b].resetCards = locks[b].resetCards + jsonData[a - 1].resetCardsModifiedBy
						if (locks[b].resetCards < 0) then locks[b].resetCards = 0
						if (locks[b].resetCards > cappedResetCards) then locks[b].resetCards = cappedResetCards
						if (jsonData[a - 1].resetCardsModifiedBy < 0)
							if (jsonData[a - 1].resetCardsModifiedBy = -1)
								resetCardString$ = " removing " + str(abs(jsonData[a - 1].resetCardsModifiedBy), 0) + " reset card"	
							else
								resetCardString$ = " removing " + str(abs(jsonData[a - 1].resetCardsModifiedBy), 0) + " reset cards"	
							endif
						endif
						if (jsonData[a - 1].resetCardsModifiedBy > 0)
							if (jsonData[a - 1].resetCardsModifiedBy = 1)
								resetCardString$ = " adding " + str(jsonData[a - 1].resetCardsModifiedBy, 0) + " reset card"
							else
								resetCardString$ = " adding " + str(jsonData[a - 1].resetCardsModifiedBy, 0) + " reset cards"
							endif
						endif
					endif
					
					// STICKY CARDS
					if (jsonData[a - 1].stickyCardsModifiedBy <> 0)
						locks[b].stickyCards = locks[b].stickyCards + jsonData[a - 1].stickyCardsModifiedBy
						if (locks[b].stickyCards < 0) then locks[b].stickyCards = 0
						if (locks[b].stickyCards > cappedStickyCards) then locks[b].stickyCards = cappedStickyCards
						if (jsonData[a - 1].stickyCardsModifiedBy < 0)
							if (jsonData[a - 1].stickyCardsModifiedBy = -1)
								stickyCardString$ = " removing " + str(abs(jsonData[a - 1].stickyCardsModifiedBy), 0) + " sticky card"	
							else
								stickyCardString$ = " removing " + str(abs(jsonData[a - 1].stickyCardsModifiedBy), 0) + " sticky cards"	
							endif
						endif
						if (jsonData[a - 1].stickyCardsModifiedBy > 0)
							if (jsonData[a - 1].stickyCardsModifiedBy = 1)
								stickyCardString$ = " adding " + str(jsonData[a - 1].stickyCardsModifiedBy, 0) + " sticky card"
							else
								stickyCardString$ = " adding " + str(jsonData[a - 1].stickyCardsModifiedBy, 0) + " sticky cards"
							endif
						endif
					endif
					
					// TIMER HIDDEN/SHOWN
					if (jsonData[a - 1].timerHiddenModifiedBy = -1)
						locks[b].timerHidden = 0
						timerHiddenString$ = " revealing the timer"
					elseif (jsonData[a - 1].timerHiddenModifiedBy = 1)
						locks[b].timerHidden = 1
						timerHiddenString$ = " hiding the timer"
					endif
					
					// YELLOW CARDS
					if (jsonData[a - 1].noOfAdd1CardsModifiedBy <> 0 or jsonData[a - 1].noOfAdd2CardsModifiedBy <> 0 or jsonData[a - 1].noOfAdd3CardsModifiedBy <> 0 or jsonData[a - 1].noOfMinus1CardsModifiedBy <> 0 or jsonData[a - 1].noOfMinus2CardsModifiedBy <> 0)
						locks[b].yellowCards = locks[b].yellowCards + jsonData[a - 1].yellowCardsModifiedBy
						if (locks[b].yellowCards < 0) then locks[b].yellowCards = 0
						if (locks[b].yellowCards > cappedYellowCardsTotal) then locks[b].yellowCards = cappedYellowCardsTotal
						if (jsonData[a - 1].yellowCardsModifiedBy < 0)
							if (jsonData[a - 1].yellowCardsModifiedBy = -1)
								yellowCardString$ = " removing " + str(abs(jsonData[a - 1].yellowCardsModifiedBy), 0) + " yellow card"
							else
								yellowCardString$ = " removing " + str(abs(jsonData[a - 1].yellowCardsModifiedBy), 0) + " yellow cards"
							endif	
						endif
						if (jsonData[a - 1].yellowCardsModifiedBy > 0)
							if (jsonData[a - 1].yellowCardsModifiedBy = 1)
								yellowCardString$ = " adding " + str(jsonData[a - 1].yellowCardsModifiedBy, 0) + " yellow card"
							else
								yellowCardString$ = " adding " + str(jsonData[a - 1].yellowCardsModifiedBy, 0) + " yellow cards"
							endif	
						endif
						if (jsonData[a - 1].yellowCardsModifiedBy = 0)
							yellowCardString$ = " swapping around yellow cards"
						endif
					endif
					if (jsonData[a - 1].noOfAdd1CardsModifiedBy <> 0)
						locks[b].noOfAdd1Cards = locks[b].noOfAdd1Cards + jsonData[a - 1].noOfAdd1CardsModifiedBy
						if (locks[b].noOfAdd1Cards < 0) then locks[b].noOfAdd1Cards = 0
						if (locks[b].noOfAdd1Cards > cappedYellowCardsEachType) then locks[b].noOfAdd1Cards = cappedYellowCardsEachType
					endif
					if (jsonData[a - 1].noOfAdd2CardsModifiedBy <> 0)
						locks[b].noOfAdd2Cards = locks[b].noOfAdd2Cards + jsonData[a - 1].noOfAdd2CardsModifiedBy
						if (locks[b].noOfAdd2Cards < 0) then locks[b].noOfAdd2Cards = 0
						if (locks[b].noOfAdd2Cards > cappedYellowCardsEachType) then locks[b].noOfAdd2Cards = cappedYellowCardsEachType
					endif
					if (jsonData[a - 1].noOfAdd3CardsModifiedBy <> 0)
						locks[b].noOfAdd3Cards = locks[b].noOfAdd3Cards + jsonData[a - 1].noOfAdd3CardsModifiedBy
						if (locks[b].noOfAdd3Cards < 0) then locks[b].noOfAdd3Cards = 0
						if (locks[b].noOfAdd3Cards > cappedYellowCardsEachType) then locks[b].noOfAdd3Cards = cappedYellowCardsEachType
					endif
					if (jsonData[a - 1].noOfMinus1CardsModifiedBy <> 0)
						locks[b].noOfMinus1Cards = locks[b].noOfMinus1Cards + jsonData[a - 1].noOfMinus1CardsModifiedBy
						if (locks[b].noOfMinus1Cards < 0) then locks[b].noOfMinus1Cards = 0
						if (locks[b].noOfMinus1Cards > cappedYellowCardsEachType) then locks[b].noOfMinus1Cards = cappedYellowCardsEachType
					endif
					if (jsonData[a - 1].noOfMinus2CardsModifiedBy <> 0)
						locks[b].noOfMinus2Cards = locks[b].noOfMinus2Cards + jsonData[a - 1].noOfMinus2CardsModifiedBy
						if (locks[b].noOfMinus2Cards < 0) then locks[b].noOfMinus2Cards = 0
						if (locks[b].noOfMinus2Cards > cappedYellowCardsEachType) then locks[b].noOfMinus2Cards = cappedYellowCardsEachType
					endif
					locks[b].yellowCards = locks[b].noOfAdd1Cards + locks[b].noOfAdd2Cards + locks[b].noOfAdd3Cards + locks[b].noOfMinus1Cards + locks[b].noOfMinus2Cards
					
					if (jsonData[a - 1].reset = 0 and jsonData[a - 1].allowFreeUnlockModifiedBy = 0 and jsonData[a - 1].autoResetsPausedModifiedBy = 0 and jsonData[a - 1].cumulativeModifiedBy = 0 and jsonData[a - 1].unlocked = 0 and jsonData[a - 1].readyToUnlock = 0)
						if (noOfLockUpdatesAvailable < 7)
							cardString$ as string[9]
							count as integer : count = 0
							if (locks[b].fixed = 0)
								if (cardInfoHiddenString$ <> "")
									inc count
									cardString$[count] = cardInfoHiddenString$
								endif
								if (doubleUpCardString$ <> "")
									inc count
									cardString$[count] = doubleUpCardString$
								endif
								if (freezeCardString$ <> "")
									inc count
									cardString$[count] = freezeCardString$
								endif
								if (greenCardString$ <> "")
									inc count
									cardString$[count] = greenCardString$
								endif
								if (redCardString$ <> "")
									inc count
									cardString$[count] = redCardString$
								endif
								if (resetCardString$ <> "")
									inc count
									cardString$[count] = resetCardString$
								endif
								if (stickyCardString$ <> "")
									inc count
									cardString$[count] = stickyCardString$
								endif
								if (yellowCardString$ <> "")
									inc count
									cardString$[count] = yellowCardString$
								endif
								if (lockFrozenByKeyholderString$ <> "")
									inc count
									cardString$[count] = lockFrozenByKeyholderString$
								endif
								if (locks[b].cardInfoHidden = 0 or jsonData[a - 1].cardInfoHiddenModifiedBy <> 0 or jsonData[a - 1].hidden = -1 or jsonData[a - 1].lockFrozenByKeyholderModifiedBy <> 0 or jsonData[a - 1].autoResetsPausedModifiedBy <> 0)
									if (count = 1) then singleUpdate$ = cardString$[1] + "."
									if (count = 2) then singleUpdate$ = cardString$[1] + ", and" + cardString$[2] + "."
									if (count = 3) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", and" + cardString$[3] + "."
									if (count = 4) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", and " + cardString$[4] + "."
									if (count = 5) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", " + cardString$[4] + ", and " + cardString$[5] + "."
									if (count = 6) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", " + cardString$[4] + ", " + cardString$[5] + ", and " + cardString$[6] + "."
									if (count = 7) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", " + cardString$[4] + ", " + cardString$[5] + ", " + cardString$[6] + ", and " + cardString$[7] + "."
									if (count = 8) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", " + cardString$[4] + ", " + cardString$[5] + ", " + cardString$[6] + ", " + cardString$[7] + ", and " + cardString$[8] + "."
									if (count = 9) then singleUpdate$ = cardString$[1] + "," + cardString$[2] + ", " + cardString$[3] + ", " + cardString$[4] + ", " + cardString$[5] + ", " + cardString$[6] + ", " + cardString$[7] + ", " + cardString$[8] + ", and " + cardString$[9] + "."
									if (jsonData[a - 1].hidden = -1) 
										message$ = message$ + "• (Unhidden) " + locks[b].keyholderUsername$ + " has updated your lock by" + singleUpdate$ + chr(10)
										singleUpdate$ = "(Unhidden) " + singleUpdate$
									else
										message$ = message$ + "• " + locks[b].keyholderUsername$ + " has updated your lock by" + singleUpdate$ + chr(10)
									endif	
								else
									singleUpdate$ = "Update hidden."
									message$ = message$ + "• " + locks[b].keyholderUsername$ + " has updated your lock." + chr(10)
								endif
							endif
							if (locks[b].fixed = 1)
								if (minutesString$ <> "")
									inc count
									cardString$[count] = minutesString$
								endif
								if (redCardString$ <> "")
									inc count
									cardString$[count] = redCardString$
								endif
								if (timerHiddenString$ <> "")
									inc count
									cardString$[count] = timerHiddenString$
								endif
								if (lockFrozenByKeyholderString$ <> "")
									inc count
									cardString$[count] = lockFrozenByKeyholderString$
								endif
								if (locks[b].timerHidden = 0 or jsonData[a - 1].timerHiddenModifiedBy <> 0 or jsonData[a - 1].hidden = -1 or jsonData[a - 1].lockFrozenByKeyholderModifiedBy <> 0)
									if (count = 1) then singleUpdate$ = cardString$[1] + "."
									if (count = 2) then singleUpdate$ = cardString$[1] + ", and" + cardString$[2] + "."
									if (count = 3) then singleUpdate$ = cardString$[1] + ", " + cardString$[2] + ", and" + cardString$[3] + "."
									if (count = 4) then singleUpdate$ = cardString$[1] + ", " + cardString$[2] + ", " + cardString$[3] + ", and" + cardString$[4] + "."
									if (jsonData[a - 1].hidden = -1)
										message$ = message$ + "• (Unhidden) " + locks[b].keyholderUsername$ + " has updated your lock by" + singleUpdate$ + chr(10)
										singleUpdate$ = "(Unhidden) " + singleUpdate$
									else
										message$ = message$ + "• " + locks[b].keyholderUsername$ + " has updated your lock by" + singleUpdate$ + chr(10)
									endif	
								else
									singleUpdate$ = "Update hidden."
									message$ = message$ + "• " + locks[b].keyholderUsername$ + " has updated your lock." + chr(10)
								endif
							endif
						endif
					endif
					
					// ADD GO AGAIN CARDS IF UPDATE HIDDEN
					if (locks[b].fixed = 0 and locks[b].cardInfoHidden = 1)
						if (jsonData[a - 1].doubleUpCardsModifiedBy <> 0 or jsonData[a - 1].freezeCardsModifiedBy <> 0 or jsonData[a - 1].greenCardsModifiedBy <> 0 or jsonData[a - 1].redCardsModifiedBy <> 0 or jsonData[a - 1].resetCardsModifiedBy <> 0 or jsonData[a - 1].stickyCardsModifiedBy <> 0 or jsonData[a - 1].yellowCardsModifiedBy <> 0)
							locks[b].goAgainCards = 0
							locks[b].goAgainCards = floor((GetNoOfCards(b) / 100.0) * locks[b].goAgainCardsPercentage#)
							if (locks[b].goAgainCards > cappedGoAgainCards) then locks[b].goAgainCards = cappedGoAgainCards
						endif
					endif
					
					// KEYHOLDER ALLOWS FREE UNLOCK
					if (jsonData[a - 1].allowFreeUnlockModifiedBy = -1)
						locks[b].keyholderAllowsFreeUnlock = 0
						singleUpdate$ = "Disabled free unlock"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has disabled a free unlock." + chr(10)
					elseif (jsonData[a - 1].allowFreeUnlockModifiedBy = 1)
						locks[b].keyholderAllowsFreeUnlock = 1
						singleUpdate$ = "Enabled free unlock"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has enabled a free unlock." + chr(10)
					endif
					
					// UNPAUSED AUTO RESETS
					if (locks[b].fixed = 0 and jsonData[a - 1].autoResetsPausedModifiedBy = -1)
						locks[b].autoResetsPaused = 0
						singleUpdate$ = "Unpaused auto resets"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has unpaused auto resets." + chr(10)
					endif
					// PAUSED AUTO RESETS
					if (locks[b].fixed = 0 and jsonData[a - 1].autoResetsPausedModifiedBy = 1)
						locks[b].autoResetsPaused = 1
						singleUpdate$ = "Paused auto resets"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has paused auto resets." + chr(10)
					endif
					
					// SWITCHED TO NON-CUMULATIVE
					if (locks[b].fixed = 0 and jsonData[a - 1].cumulativeModifiedBy = -1)
						locks[b].cumulative = 0
						if (locks[b].timestampLastPicked < jsonData[a - 1].timestampModified - (locks[b].regularity# * 3600))
							locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (locks[b].regularity# * 3600)
						endif
						singleUpdate$ = "Switched lock to non-cumulative"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has switched the lock to non-cumulative." + chr(10)
					endif
					// SWITCHED TO CUMULATIVE
					if (locks[b].fixed = 0 and jsonData[a - 1].cumulativeModifiedBy = 1)
						locks[b].cumulative = 1
						singleUpdate$ = "Switched lock to cumulative"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has switched the lock to cumulative." + chr(10)
					endif
					
					// READY TO UNLOCK
					if (jsonData[a - 1].readyToUnlock = 1)
						locks[b].readyToUnlock = 1
						singleUpdate$ = "Unlocked lock"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has unlocked your lock." + chr(10)
					endif
					
					// RESET LOCK
					if (jsonData[a - 1].reset = 1)
						locks[b].readyToUnlock = 0
						if (locks[b].fixed = 0)
							if (locks[b].regularity# = 0.016667)
								locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - 60
							else
								locks[b].timestampLastPicked = jsonData[a - 1].timestampModified - (locks[b].regularity# * 3600)
							endif
						endif
						locks[b].timestampLastFullReset = jsonData[a - 1].timestampModified
						locks[b].timestampLastReset = jsonData[a - 1].timestampModified
						locks[b].timestampRequestedKeyholdersDecision = 0
						locks[b].pickedCountSinceReset = 0
						locks[b].greensPickedSinceReset = 0
						locks[b].hideGreensUntilPickCount = 0
						
						if (locks[b].fixed = 0)
							locks[b].doubleUpCards = locks[b].initialDoubleUpCards
							locks[b].freezeCards = locks[b].initialFreezeCards
							locks[b].greenCards = locks[b].initialGreenCards
							locks[b].noOfAdd1Cards = locks[b].initialYellowAdd1Cards
							locks[b].noOfAdd2Cards = locks[b].initialYellowAdd2Cards
							locks[b].noOfAdd3Cards = locks[b].initialYellowAdd3Cards
							locks[b].noOfMinus1Cards = locks[b].initialYellowMinus1Cards
							locks[b].noOfMinus2Cards = locks[b].initialYellowMinus2Cards
							locks[b].redCards = locks[b].initialRedCards
							locks[b].resetCards = locks[b].initialResetCards
							locks[b].stickyCards = locks[b].initialStickyCards
							locks[b].yellowCards = locks[b].initialYellowCards
						else
							remstart
							if (locks[b].regularity# = 0.016667)
								locks[b].minutes = locks[b].initialMinutes
							else
								locks[b].redCards = locks[b].initialRedCards
							endif
							remend
						endif
						
						locks[b].autoResetsPaused = 0
						locks[b].noOfTimesAutoReset = 0
						
						inc locks[b].noOfTimesFullReset
						inc locks[b].noOfTimesReset
						singleUpdate$ = "Reset lock"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has reset your lock." + chr(10)
					endif
					
					// UNLOCK LOCK
					if (jsonData[a - 1].unlocked = 1)
						locks[b].timestampUnlocked = jsonData[a - 1].timestampModified
						locks[b].timestampRequestedKeyholdersDecision = 0
						UnlockLock(b, "", "")
						inc noOfLocksNaturallyUnlocked
						SaveLocalVariable("noOfLocksNaturallyUnlocked", str(noOfLocksNaturallyUnlocked))
						timestampLastUnlocked = timestampNow
						singleUpdate$ = "Unlocked lock"
						if (noOfLockUpdatesAvailable < 7) then message$ = message$ + "• " + locks[b].keyholderUsername$ + " has unlocked your lock." + chr(10)
					endif

					InsertLastUpdate(b, singleUpdate$, jsonData[a - 1].timestampModified)		
					UpdateLocksData(b)
					UpdateLocksDatabase(b, "", 0)
					
					if (noOfLockUpdatesAvailable < 7 and message$ <> "") then message$ = message$ + chr(10)
				endif
				exit
			endif
		next
	next
	if (noOfLockUpdatesAvailable > 7 and message$ <> "") then message$ = message$ + chr(10) + "More updates were made that aren't listed."
	for a = 1 to 20
		if (locks[a].sharedID$ <> "" and locks[a].hiddenFromOwner = 0)
			locks[a].timestampLastCheckedUpdates = timestampNow
			UpdateLocksData(a)
		endif
	next
endfunction message$

function ReceivedMissingUserID()
	jsonData.length = -1
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	userID$ = GetJSONDataVariableValue("userID")
	SaveLocalVariable("userID", userID$)
endfunction

function ReceivedMyLocksDeleted()
	local i as integer
	
	jsonData as typeLock[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	locksDeleted.myLocks.length = jsonData.length
	for i = 0 to jsonData.length
		locksDeleted.myLocks[i].autoResetsPaused = jsonData[i].autoResetsPaused
		locksDeleted.myLocks[i].blockBotFromUnlocking = jsonData[i].blockBotFromUnlocking
		locksDeleted.myLocks[i].blockUsersAlreadyLocked = jsonData[i].blockUsersAlreadyLocked
		locksDeleted.myLocks[i].botChosen = jsonData[i].botChosen
		locksDeleted.myLocks[i].build = jsonData[i].build
		locksDeleted.myLocks[i].cardInfoHidden = jsonData[i].cardInfoHidden
		locksDeleted.myLocks[i].chancesAccumulatedBeforeFreeze = jsonData[i].chancesAccumulatedBeforeFreeze
		locksDeleted.myLocks[i].checkInFrequencyInSeconds = jsonData[i].checkInFrequencyInSeconds
		locksDeleted.myLocks[i].combination$ = jsonData[i].combination$
		locksDeleted.myLocks[i].cumulative = jsonData[i].cumulative
		locksDeleted.myLocks[i].dateDeleted$ = jsonData[i].dateDeleted$
		locksDeleted.myLocks[i].dateLastPicked$ = jsonData[i].dateLastPicked$
		locksDeleted.myLocks[i].dateLocked$ = jsonData[i].dateLocked$
		locksDeleted.myLocks[i].dateUnlocked$ = jsonData[i].dateUnlocked$
		locksDeleted.myLocks[i].deleted = jsonData[i].deleted
		locksDeleted.myLocks[i].deleting = 0
		locksDeleted.myLocks[i].discardPile$ = jsonData[i].discardPile$
		locksDeleted.myLocks[i].displayInStats = jsonData[i].displayInStats
		locksDeleted.myLocks[i].doubleUpCards = jsonData[i].doubleUpCards
		locksDeleted.myLocks[i].doubleUpCardsAdded = jsonData[i].doubleUpCardsAdded
		locksDeleted.myLocks[i].doubleUpCardsPicked = jsonData[i].doubleUpCardsPicked
		locksDeleted.myLocks[i].emojiChosen = jsonData[i].emojiChosen
		locksDeleted.myLocks[i].emojiColourSelected = jsonData[i].emojiColourSelected
		if (locksDeleted.myLocks[i].emojiColourSelected = 0) then locksDeleted.myLocks[i].emojiColourSelected = 1
		locksDeleted.myLocks[i].fake = jsonData[i].fake
		locksDeleted.myLocks[i].filterIn = 0
		locksDeleted.myLocks[i].fixed = jsonData[i].fixed
		locksDeleted.myLocks[i].flagChosen = jsonData[i].flagChosen
		locksDeleted.myLocks[i].freezeCards = jsonData[i].freezeCards
		locksDeleted.myLocks[i].freezeCardsAdded = jsonData[i].freezeCardsAdded
		locksDeleted.myLocks[i].goAgainCards = jsonData[i].goAgainCards
		locksDeleted.myLocks[i].goAgainCardsPercentage# = jsonData[i].goAgainCardsPercentage#
		locksDeleted.myLocks[i].greenCards = jsonData[i].greenCards
		locksDeleted.myLocks[i].greensPickedSinceReset = jsonData[i].greensPickedSinceReset
		locksDeleted.myLocks[i].groupID = jsonData[i].groupID
		locksDeleted.myLocks[i].hiddenFromOwner = jsonData[i].hiddenFromOwner
		locksDeleted.myLocks[i].hiddenFromOwnerAlertHidden = 0
		locksDeleted.myLocks[i].hideGreensUntilPickCount = jsonData[i].hideGreensUntilPickCount
		locksDeleted.myLocks[i].id = jsonData[i].id
		locksDeleted.myLocks[i].initialDoubleUpCards = jsonData[i].initialDoubleUpCards
		locksDeleted.myLocks[i].initialFreezeCards = jsonData[i].initialFreezeCards
		locksDeleted.myLocks[i].initialGreenCards = jsonData[i].initialGreenCards
//~		locksDeleted.myLocks[i].initialMaximumDoubleUpCards = jsonData[i].initialMaximumDoubleUpCards
//~		locksDeleted.myLocks[i].initialMaximumFreezeCards = jsonData[i].initialMaximumFreezeCards
//~		locksDeleted.myLocks[i].initialMaximumGreenCards = jsonData[i].initialMaximumGreenCards
//~		locksDeleted.myLocks[i].initialMaximumMinutes = jsonData[i].initialMaximumMinutes
//~		locksDeleted.myLocks[i].initialMaximumRedCards = jsonData[i].initialMaximumRedCards
//~		locksDeleted.myLocks[i].initialMaximumResetCards = jsonData[i].initialMaximumResetCards
//~		locksDeleted.myLocks[i].initialMaximumStickyCards = jsonData[i].initialMaximumStickyCards
//~		locksDeleted.myLocks[i].initialMaximumYellowAddCards = jsonData[i].initialMaximumYellowAddCards
//~		locksDeleted.myLocks[i].initialMaximumYellowMinusCards = jsonData[i].initialMaximumYellowMinusCards
//~		locksDeleted.myLocks[i].initialMaximumYellowRandomCards = jsonData[i].initialMaximumYellowRandomCards
//~		locksDeleted.myLocks[i].initialMinimumDoubleUpCards = jsonData[i].initialMinimumDoubleUpCards
//~		locksDeleted.myLocks[i].initialMinimumFreezeCards = jsonData[i].initialMinimumFreezeCards
//~		locksDeleted.myLocks[i].initialMinimumGreenCards = jsonData[i].initialMinimumGreenCards
//~		locksDeleted.myLocks[i].initialMinimumMinutes = jsonData[i].initialMinimumMinutes
//~		locksDeleted.myLocks[i].initialMinimumRedCards = jsonData[i].initialMinimumRedCards
//~		locksDeleted.myLocks[i].initialMinimumResetCards = jsonData[i].initialMinimumResetCards
//~		locksDeleted.myLocks[i].initialMinimumStickyCards = jsonData[i].initialMinimumStickyCards
//~		locksDeleted.myLocks[i].initialMinimumYellowAddCards = jsonData[i].initialMinimumYellowAddCards
//~		locksDeleted.myLocks[i].initialMinimumYellowMinusCards = jsonData[i].initialMinimumYellowMinusCards
//~		locksDeleted.myLocks[i].initialMinimumYellowRandomCards = jsonData[i].initialMinimumYellowRandomCards
		locksDeleted.myLocks[i].initialMinutes = jsonData[i].initialMinutes
		locksDeleted.myLocks[i].initialRedCards = jsonData[i].initialRedCards
		locksDeleted.myLocks[i].initialResetCards = jsonData[i].initialResetCards
		locksDeleted.myLocks[i].initialStickyCards = jsonData[i].initialStickyCards
		locksDeleted.myLocks[i].initialYellowAdd1Cards = jsonData[i].initialYellowAdd1Cards
		locksDeleted.myLocks[i].initialYellowAdd2Cards = jsonData[i].initialYellowAdd2Cards
		locksDeleted.myLocks[i].initialYellowAdd3Cards = jsonData[i].initialYellowAdd3Cards
		locksDeleted.myLocks[i].initialYellowCards = jsonData[i].initialYellowCards
		locksDeleted.myLocks[i].initialYellowMinus1Cards = jsonData[i].initialYellowMinus1Cards
		locksDeleted.myLocks[i].initialYellowMinus2Cards = jsonData[i].initialYellowMinus2Cards
		locksDeleted.myLocks[i].iteration = i
		locksDeleted.myLocks[i].keyDisabled = jsonData[i].keyDisabled
		locksDeleted.myLocks[i].keyholderAllowsFreeUnlock = jsonData[i].keyholderAllowsFreeUnlock
		locksDeleted.myLocks[i].keyholderBuildNumberInstalled = jsonData[i].keyholderBuildNumberInstalled
		locksDeleted.myLocks[i].keyholderDecisionDisabled = jsonData[i].keyholderDecisionDisabled
		locksDeleted.myLocks[i].keyholderDisabledKey = jsonData[i].keyholderDisabledKey
		locksDeleted.myLocks[i].keyholderEmojiChosen = jsonData[i].keyholderEmojiChosen
		locksDeleted.myLocks[i].keyholderEmojiColourSelected = jsonData[i].keyholderEmojiColourSelected
		if (locksDeleted.myLocks[i].keyholderEmojiColourSelected = 0) then locksDeleted.myLocks[i].keyholderEmojiColourSelected = 1
		locksDeleted.myLocks[i].keyholderID = jsonData[i].keyholderID
		locksDeleted.myLocks[i].keyholderLastActive = jsonData[i].keyholderLastActive
		locksDeleted.myLocks[i].keyholderMainRole = jsonData[i].keyholderMainRole
		locksDeleted.myLocks[i].keyholderMainRoleLevel = jsonData[i].keyholderMainRoleLevel
		locksDeleted.myLocks[i].keyholderStatus = jsonData[i].keyholderStatus
		locksDeleted.myLocks[i].keyholderUsername$ = jsonData[i].keyholderUsername$
		locksDeleted.myLocks[i].keyUsed = jsonData[i].keyUsed
		locksDeleted.myLocks[i].lastUpdateIDSeen = jsonData[i].lastUpdateIDSeen
		locksDeleted.myLocks[i].lateCheckInWindowInSeconds = jsonData[i].lateCheckInWindowInSeconds
		locksDeleted.myLocks[i].lockFrozenByCard = jsonData[i].lockFrozenByCard
		locksDeleted.myLocks[i].lockFrozenByKeyholder = jsonData[i].lockFrozenByKeyholder
		locksDeleted.myLocks[i].lockLog.length = -1
		locksDeleted.myLocks[i].lockName$ = jsonData[i].lockName$
		locksDeleted.myLocks[i].maximumAutoResets = jsonData[i].maximumAutoResets
		locksDeleted.myLocks[i].maximumMinutes = jsonData[i].maximumMinutes
		locksDeleted.myLocks[i].maximumRedCards = jsonData[i].maximumRedCards
		locksDeleted.myLocks[i].minimumMinutes = jsonData[i].minimumMinutes
		locksDeleted.myLocks[i].minimumRedCards = jsonData[i].minimumRedCards
		if (locksDeleted.myLocks[i].minimumRedCards = 0 and locksDeleted.myLocks[i].fixed = 0) then locksDeleted.myLocks[i].minimumRedCards = 1
		locksDeleted.myLocks[i].minutes = jsonData[i].minutes
		locksDeleted.myLocks[i].minutesAdded = jsonData[i].minutesAdded
		locksDeleted.myLocks[i].multipleGreensRequired = jsonData[i].multipleGreensRequired
		locksDeleted.myLocks[i].noOfAdd1Cards = jsonData[i].noOfAdd1Cards
		locksDeleted.myLocks[i].noOfAdd2Cards = jsonData[i].noOfAdd2Cards
		locksDeleted.myLocks[i].noOfAdd3Cards = jsonData[i].noOfAdd3Cards
		locksDeleted.myLocks[i].noOfKeysRequired = jsonData[i].noOfKeysRequired
		locksDeleted.myLocks[i].noOfMinus1Cards = jsonData[i].noOfMinus1Cards
		locksDeleted.myLocks[i].noOfMinus2Cards = jsonData[i].noOfMinus2Cards
		locksDeleted.myLocks[i].noOfTimesAutoReset = jsonData[i].noOfTimesAutoReset
		locksDeleted.myLocks[i].noOfTimesCardReset = jsonData[i].noOfTimesCardReset
		locksDeleted.myLocks[i].noOfTimesFullReset = jsonData[i].noOfTimesFullReset
		locksDeleted.myLocks[i].noOfTimesGreenCardRevealed = jsonData[i].noOfTimesGreenCardRevealed
		locksDeleted.myLocks[i].noOfTimesReset = jsonData[i].noOfTimesReset
		locksDeleted.myLocks[i].permanent = jsonData[i].permanent
		locksDeleted.myLocks[i].pickedCount = jsonData[i].pickedCount
		locksDeleted.myLocks[i].pickedCountIncludingYellows = jsonData[i].pickedCountIncludingYellows
		locksDeleted.myLocks[i].pickedCountSinceReset = jsonData[i].pickedCountSinceReset
		locksDeleted.myLocks[i].randomCardsAdded = jsonData[i].randomCardsAdded
		locksDeleted.myLocks[i].rating = jsonData[i].rating
		locksDeleted.myLocks[i].readyToUnlock = jsonData[i].readyToUnlock
		locksDeleted.myLocks[i].redCards = jsonData[i].redCards
		locksDeleted.myLocks[i].redCardsAdded = jsonData[i].redCardsAdded
		locksDeleted.myLocks[i].regularity# = jsonData[i].regularity#
		locksDeleted.myLocks[i].removedByKeyholder = jsonData[i].removedByKeyholder
		locksDeleted.myLocks[i].removedByKeyholderAlertHidden = 0
		locksDeleted.myLocks[i].resetCards = jsonData[i].resetCards
		locksDeleted.myLocks[i].resetCardsAdded = jsonData[i].resetCardsAdded
		locksDeleted.myLocks[i].resetCardsPicked = jsonData[i].resetCardsPicked
		locksDeleted.myLocks[i].resetFrequencyInSeconds = jsonData[i].resetFrequencyInSeconds
		locksDeleted.myLocks[i].rowInDB = jsonData[i].rowInDB
		locksDeleted.myLocks[i].sharedID$ = jsonData[i].sharedID$
		locksDeleted.myLocks[i].simulationAverageMinutesLocked = jsonData[i].simulationAverageMinutesLocked
		locksDeleted.myLocks[i].simulationBestCaseMinutesLocked = jsonData[i].simulationBestCaseMinutesLocked
		locksDeleted.myLocks[i].simulationWorstCaseMinutesLocked = jsonData[i].simulationWorstCaseMinutesLocked
		locksDeleted.myLocks[i].stickyCards = jsonData[i].stickyCards
		locksDeleted.myLocks[i].test = jsonData[i].test
		locksDeleted.myLocks[i].timeLeftUntilNextChanceBeforeFreeze = jsonData[i].timeLeftUntilNextChanceBeforeFreeze
		locksDeleted.myLocks[i].timerHidden = jsonData[i].timerHidden
		locksDeleted.myLocks[i].timestampCleanTimeRequestBlockedUntil = jsonData[i].timestampCleanTimeRequestBlockedUntil
		locksDeleted.myLocks[i].timestampDeleted = jsonData[i].timestampDeleted
		locksDeleted.myLocks[i].timestampDeniedCleanTime = jsonData[i].timestampDeniedCleanTime
		locksDeleted.myLocks[i].timestampEndedCleanTime = jsonData[i].timestampEndedCleanTime
		locksDeleted.myLocks[i].timestampFrozenByCard = jsonData[i].timestampFrozenByCard
		locksDeleted.myLocks[i].timestampFrozenByKeyholder = jsonData[i].timestampFrozenByKeyholder
		locksDeleted.myLocks[i].timestampHiddenFromOwner = jsonData[i].timestampHiddenFromOwner
		locksDeleted.myLocks[i].timestampLastAutoReset = jsonData[i].timestampLastAutoReset
		locksDeleted.myLocks[i].timestampLastCardReset = jsonData[i].timestampLastCardReset
		locksDeleted.myLocks[i].timestampLastCheckedIn = jsonData[i].timestampLastCheckedIn
		locksDeleted.myLocks[i].timestampLastCheckedUpdates = 0
		locksDeleted.myLocks[i].timestampLastFullReset = jsonData[i].timestampLastFullReset
		locksDeleted.myLocks[i].timestampLastPicked = jsonData[i].timestampLastPicked
		locksDeleted.myLocks[i].timestampLastReset = jsonData[i].timestampLastReset
		locksDeleted.myLocks[i].timestampLastSynced = jsonData[i].timestampLastSynced
		locksDeleted.myLocks[i].timestampLastUpdated = jsonData[i].timestampLastUpdated
		locksDeleted.myLocks[i].timestampLocked = jsonData[i].timestampLocked
		locksDeleted.myLocks[i].timestampRated = jsonData[i].timestampRated
		locksDeleted.myLocks[i].timestampRealLastPicked = jsonData[i].timestampRealLastPicked
		locksDeleted.myLocks[i].timestampRemovedByKeyholder = jsonData[i].timestampRemovedByKeyholder
		locksDeleted.myLocks[i].timestampRequestedCleanTime = jsonData[i].timestampRequestedCleanTime
		locksDeleted.myLocks[i].timestampRequestedKeyholdersDecision = jsonData[i].timestampRequestedKeyholdersDecision
		locksDeleted.myLocks[i].timestampStartedCleanTime = jsonData[i].timestampStartedCleanTime
		locksDeleted.myLocks[i].timestampUnfreezes = jsonData[i].timestampUnfreezes
		locksDeleted.myLocks[i].timestampUnfrozen = jsonData[i].timestampUnfrozen
		locksDeleted.myLocks[i].timestampUnlocked = jsonData[i].timestampUnlocked
		locksDeleted.myLocks[i].totalTimeCleaning = jsonData[i].totalTimeCleaning
		locksDeleted.myLocks[i].totalTimeFrozen = jsonData[i].totalTimeFrozen
		locksDeleted.myLocks[i].trustKeyholder = jsonData[i].trustKeyholder
		locksDeleted.myLocks[i].unlocked = jsonData[i].unlocked
		locksDeleted.myLocks[i].version$ = jsonData[i].version$
		locksDeleted.myLocks[i].yellowCards = locksDeleted.myLocks[i].noOfAdd1Cards + locksDeleted.myLocks[i].noOfAdd2Cards + locksDeleted.myLocks[i].noOfAdd3Cards + locksDeleted.myLocks[i].noOfMinus1Cards + locksDeleted.myLocks[i].noOfMinus2Cards			
		if (locksDeleted.myLocks[i].botChosen = 1)
			locksDeleted.myLocks[i].keyholderID = 3948
			locksDeleted.myLocks[i].keyholderMainRole = 1
			locksDeleted.myLocks[i].keyholderMainRoleLevel = 5
			locksDeleted.myLocks[i].keyholderUsername$ = "Hailey"
		endif
		if (locksDeleted.myLocks[i].botChosen = 2)
			locksDeleted.myLocks[i].keyholderID = 3949
			locksDeleted.myLocks[i].keyholderMainRole = 1
			locksDeleted.myLocks[i].keyholderMainRoleLevel = 5
			locksDeleted.myLocks[i].keyholderUsername$ = "Blaine"
		endif
		if (locksDeleted.myLocks[i].botChosen = 3)
			locksDeleted.myLocks[i].keyholderID = 3950
			locksDeleted.myLocks[i].keyholderMainRole = 1
			locksDeleted.myLocks[i].keyholderMainRoleLevel = 5
			locksDeleted.myLocks[i].keyholderUsername$ = "Zoe"
		endif
		if (locksDeleted.myLocks[i].botChosen = 4)
			locksDeleted.myLocks[i].keyholderID = 3951
			locksDeleted.myLocks[i].keyholderMainRole = 1
			locksDeleted.myLocks[i].keyholderMainRoleLevel = 5
			locksDeleted.myLocks[i].keyholderUsername$ = "Chase"
		endif
	next
endfunction

function ReceivedNewAPIClientSecret(index)
	jsonData as typeAPIProject[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	if (apiProjects[index].clientID$ = jsonData[0].clientID$)
		apiProjects[index].clientSecret$ = jsonData[0].clientSecret$
	endif
	apiProjects.save("apiProjects.json")
endfunction

function ReceivedNewAPIProject()
	local index as integer
	
	jsonData as typeAPIProject[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	apiProjects.length = apiProjects.length + 1	
	index = apiProjects.length
	apiProjects[index].name$ = jsonData[0].name$
	apiProjects[index].clientID$ = jsonData[0].clientID$
	apiProjects[index].clientSecret$ = jsonData[0].clientSecret$
	apiProjects[index].banned = 0
	apiProjects[index].bot = jsonData[0].bot
	apiProjects[index].desktopApp = jsonData[0].desktopApp
	apiProjects[index].dontKnow = jsonData[0].dontKnow
	apiProjects[index].lockBox = jsonData[0].lockBox
	apiProjects[index].mobileApp = jsonData[0].mobileApp
	apiProjects[index].somethingElse = jsonData[0].somethingElse
	apiProjects[index].website = jsonData[0].website
	apiProjects.save("apiProjects.json")
endfunction

function ReceivedOthersRelations()
	local followersID as integer
	local followingID as integer
	local i as integer
	
	jsonData as typeFriend[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for i = 1 to jsonData.length + 1
		if (jsonData[i - 1].jsonNo = 5)
			othersFriends.followers.length = othersFriends.followers.length + 1
			followersID = othersFriends.followers.length
			othersFriends.followers[followersID].id = jsonData[i - 1].id
			othersFriends.followersDelimitedIDs$ = othersFriends.followersDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			othersFriends.followers[followersID].iteration = followersID
			othersFriends.followers[followersID].discordID$ = jsonData[i - 1].discordID$
			othersFriends.followers[followersID].keyholderLevel = jsonData[i - 1].keyholderLevel
			othersFriends.followers[followersID].lockeeLevel = jsonData[i - 1].lockeeLevel
			othersFriends.followers[followersID].mainRole = jsonData[i - 1].mainRole
			othersFriends.followers[followersID].onlineStatus = jsonData[i - 1].onlineStatus
			othersFriends.followers[followersID].relationStatus = jsonData[i - 1].relationStatus
			othersFriends.followers[followersID].timestampLastActive = jsonData[i - 1].timestampLastActive
			othersFriends.followers[followersID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			othersFriends.followers[followersID].username$ = jsonData[i - 1].username$
		elseif (jsonData[i - 1].jsonNo = 6)
			othersFriends.following.length = othersFriends.following.length + 1
			followingID = othersFriends.following.length
			othersFriends.following[followingID].id = jsonData[i - 1].id
			othersFriends.followingDelimitedIDs$ = othersFriends.followingDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			othersFriends.following[followingID].iteration = followingID
			othersFriends.following[followingID].discordID$ = jsonData[i - 1].discordID$
			othersFriends.following[followingID].keyholderLevel = jsonData[i - 1].keyholderLevel
			othersFriends.following[followingID].lockeeLevel = jsonData[i - 1].lockeeLevel
			othersFriends.following[followingID].mainRole = jsonData[i - 1].mainRole
			othersFriends.following[followingID].onlineStatus = jsonData[i - 1].onlineStatus
			othersFriends.following[followingID].relationStatus = jsonData[i - 1].relationStatus
			othersFriends.following[followingID].timestampLastActive = jsonData[i - 1].timestampLastActive
			othersFriends.following[followingID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			othersFriends.following[followingID].username$ = jsonData[i - 1].username$
		endif
	next
endfunction

function ReceivedProfileData()
	jsonData as typeProfileData[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	if (jsonData.length > -1)
		profileData.id = jsonData[0].id
		profileData.avatarApproved = jsonData[0].avatarApproved
		profileData.avatarName$ = jsonData[0].avatarName$
		profileData.averageRating# = jsonData[0].averageRating#
		profileData.averageSecondsLocked = jsonData[0].averageSecondsLocked
		profileData.banned = jsonData[0].banned
		profileData.cumulativeSecondsLocked = jsonData[0].cumulativeSecondsLocked
		profileData.discordDiscriminator = jsonData[0].discordDiscriminator
		profileData.discordID$ = jsonData[0].discordID$
		profileData.discordUsername$ = jsonData[0].discordUsername$
		profileData.followers = jsonData[0].followers
		profileData.following = jsonData[0].following
		profileData.keyholderLevel = jsonData[0].keyholderLevel
		if (profileData.keyholderLevel = 0) then profileData.keyholderLevel = 1
		profileData.lockeeLevel = jsonData[0].lockeeLevel
		if (profileData.lockeeLevel = 0) then profileData.lockeeLevel = 1
		profileData.longestSecondsLocked = jsonData[0].longestSecondsLocked
		profileData.mainRoleSelected = jsonData[0].mainRoleSelected
		profileData.noOfLocks = jsonData[0].noOfLocks
		profileData.noOfLocksCompleted = jsonData[0].noOfLocksCompleted
		profileData.noOfLocksManaged = jsonData[0].noOfLocksManaged
		profileData.noOfLocksManagingNow = jsonData[0].noOfLocksManagingNow
		profileData.noOfRatings = jsonData[0].noOfRatings
		profileData.privateProfile = jsonData[0].privateProfile
		profileData.secondsLockedInCurrentLock = jsonData[0].secondsLockedInCurrentLock
		profileData.showKeyholderStatsOnProfile = jsonData[0].showKeyholderStatsOnProfile
		profileData.showLockeeStatsOnProfile = jsonData[0].showLockeeStatsOnProfile
		profileData.statusSelected = jsonData[0].statusSelected
		profileData.timestampJoined = jsonData[0].timestampJoined
		profileData.timestampLastActive = jsonData[0].timestampLastActive
		profileData.twitterHandle$ = jsonData[0].twitterHandle$
		profileData.username$ = jsonData[0].username$
		profileData.visibleInPublicStats = jsonData[0].visibleInPublicStats
		if (profileData.visibleInPublicStats = 2) then profileData.visibleInPublicStats = 0
		profileData.mainRoleLevel$ = ""
		if (profileData.mainRoleSelected = 1)
			if (profileData.keyholderLevel = 1) then profileData.mainRoleLevel$ = "Novice Keyholder"
			if (profileData.keyholderLevel = 2) then profileData.mainRoleLevel$ = "Keyholder"
			if (profileData.keyholderLevel = 3) then profileData.mainRoleLevel$ = "Established Keyholder"
			if (profileData.keyholderLevel = 4) then profileData.mainRoleLevel$ = "Distinguished Keyholder"
			if (profileData.keyholderLevel = 5) then profileData.mainRoleLevel$ = "Renowned Keyholder"
			profileData.mainRoleColour = roleColours.keyholder[profileData.keyholderLevel]
		endif
		if (profileData.mainRoleSelected = 2)
			if (profileData.lockeeLevel = 1) then profileData.mainRoleLevel$ = "Novice Lockee"
			if (profileData.lockeeLevel = 2) then profileData.mainRoleLevel$ = "Intermediate Lockee"
			if (profileData.lockeeLevel = 3) then profileData.mainRoleLevel$ = "Experienced Lockee"
			if (profileData.lockeeLevel = 4) then profileData.mainRoleLevel$ = "Devoted Lockee"
			if (profileData.lockeeLevel = 5) then profileData.mainRoleLevel$ = "Fanatical Lockee"
			profileData.mainRoleColour = roleColours.lockee[profileData.lockeeLevel]
		endif
		if (profileData.username$ = "Hailey")
			profileData.averageRating# = botsData[1].rating#
			profileData.noOfRatings = botsData[1].noOfRatings
			profileData.keyholderLevel = 5
			profileData.mainRoleLevel$ = "Renowned Keyholder"
		endif
		if (profileData.username$ = "Blaine")
			profileData.averageRating# = botsData[2].rating#
			profileData.noOfRatings = botsData[2].noOfRatings
			profileData.keyholderLevel = 5
			profileData.mainRoleLevel$ = "Renowned Keyholder"
		endif
		if (profileData.username$ = "Zoe")
			profileData.averageRating# = botsData[3].rating#
			profileData.noOfRatings = botsData[3].noOfRatings
			profileData.keyholderLevel = 5
			profileData.mainRoleLevel$ = "Renowned Keyholder"
		endif
		if (profileData.username$ = "Chase")
			profileData.averageRating# = botsData[4].rating#
			profileData.noOfRatings = botsData[4].noOfRatings
			profileData.keyholderLevel = 5
			profileData.mainRoleLevel$ = "Renowned Keyholder"
		endif
	endif
endfunction

function ReceivedRecentActivity()
	local i as integer
	
	jsonData as typeRecentActivity[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	recentActivity.length = jsonData.length
	for i = 0 to jsonData.length
		recentActivity[i].id = jsonData[i].id
		recentActivity[i].activityType$ = jsonData[i].activityType$
		recentActivity[i].iteration = i
		recentActivity[i].lockID$ = jsonData[i].lockID$
		recentActivity[i].mentionedUserID = jsonData[i].mentionedUserID
		recentActivity[i].mentionedUsername$ = jsonData[i].mentionedUsername$
		recentActivity[i].readActivity = jsonData[i].readActivity
		recentActivity[i].shareID$ = jsonData[i].shareID$
		recentActivity[i].testLock = jsonData[i].testLock
		recentActivity[i].timestamp = jsonData[i].timestamp
	next
endfunction

function ReceivedRestoreAccount()
	local a as integer
	local fileID as integer
	local i as integer
	
	jsonData as typeLock[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for i = 1 to jsonData.length + 1
		noOfLocks = noOfLocks + 1
		locks[i].autoResetsPaused = jsonData[i - 1].autoResetsPaused
		locks[i].blockBotFromUnlocking = jsonData[i - 1].blockBotFromUnlocking
		locks[i].blockUsersAlreadyLocked = jsonData[i - 1].blockUsersAlreadyLocked
		locks[i].botChosen = jsonData[i - 1].botChosen
		locks[i].build = jsonData[i - 1].build
		locks[i].cardInfoHidden = jsonData[i - 1].cardInfoHidden
		locks[i].chancesAccumulatedBeforeFreeze = jsonData[i - 1].chancesAccumulatedBeforeFreeze
		locks[i].checkInFrequencyInSeconds = jsonData[i - 1].checkInFrequencyInSeconds
		locks[i].combination$ = jsonData[i - 1].combination$
		locks[i].cumulative = jsonData[i - 1].cumulative
		locks[i].dateLastPicked$ = jsonData[i - 1].dateLastPicked$
		locks[i].dateLocked$ = jsonData[i - 1].dateLocked$
		locks[i].dateUnlocked$ = jsonData[i - 1].dateUnlocked$
		locks[i].deleting = 0
		locks[i].discardPile$ = jsonData[i - 1].discardPile$
		locks[i].displayInStats = jsonData[i - 1].displayInStats
		locks[i].doubleUpCards = jsonData[i - 1].doubleUpCards
		locks[i].doubleUpCardsAdded = jsonData[i - 1].doubleUpCardsAdded
		locks[i].doubleUpCardsPicked = jsonData[i - 1].doubleUpCardsPicked
		locks[i].emojiChosen = jsonData[i - 1].emojiChosen
		locks[i].emojiColourSelected = jsonData[i - 1].emojiColourSelected
		if (locks[i].emojiColourSelected = 0) then locks[i].emojiColourSelected = 1
		locks[i].fake = jsonData[i - 1].fake
		locks[i].filterIn = 0
		locks[i].fixed = jsonData[i - 1].fixed
		locks[i].flagChosen = jsonData[i - 1].flagChosen
		locks[i].freezeCards = jsonData[i - 1].freezeCards
		locks[i].freezeCardsAdded = jsonData[i - 1].freezeCardsAdded
		locks[i].goAgainCards = jsonData[i - 1].goAgainCards
		locks[i].goAgainCardsPercentage# = jsonData[i - 1].goAgainCardsPercentage#
		locks[i].greenCards = jsonData[i - 1].greenCards
		locks[i].greensPickedSinceReset = jsonData[i - 1].greensPickedSinceReset
		locks[i].groupID = jsonData[i - 1].groupID
		locks[i].hiddenFromOwner = jsonData[i - 1].hiddenFromOwner
		locks[i].hiddenFromOwnerAlertHidden = 0
		locks[i].hideGreensUntilPickCount = jsonData[i - 1].hideGreensUntilPickCount
		locks[i].id = jsonData[i - 1].id
		locks[i].initialDoubleUpCards = jsonData[i - 1].initialDoubleUpCards
		locks[i].initialFreezeCards = jsonData[i - 1].initialFreezeCards
		locks[i].initialGreenCards = jsonData[i - 1].initialGreenCards
//~		locks[i].initialMaximumDoubleUpCards = jsonData[i - 1].initialMaximumDoubleUpCards
//~		locks[i].initialMaximumFreezeCards = jsonData[i - 1].initialMaximumFreezeCards
//~		locks[i].initialMaximumGreenCards = jsonData[i - 1].initialMaximumGreenCards
//~		locks[i].initialMaximumMinutes = jsonData[i - 1].initialMaximumMinutes
//~		locks[i].initialMaximumRedCards = jsonData[i - 1].initialMaximumRedCards
//~		locks[i].initialMaximumResetCards = jsonData[i - 1].initialMaximumResetCards
//~		locks[i].initialMaximumStickyCards = jsonData[i - 1].initialMaximumStickyCards
//~		locks[i].initialMaximumYellowAddCards = jsonData[i - 1].initialMaximumYellowAddCards
//~		locks[i].initialMaximumYellowMinusCards = jsonData[i - 1].initialMaximumYellowMinusCards
//~		locks[i].initialMaximumYellowRandomCards = jsonData[i - 1].initialMaximumYellowRandomCards
//~		locks[i].initialMinimumDoubleUpCards = jsonData[i - 1].initialMinimumDoubleUpCards
//~		locks[i].initialMinimumFreezeCards = jsonData[i - 1].initialMinimumFreezeCards
//~		locks[i].initialMinimumGreenCards = jsonData[i - 1].initialMinimumGreenCards
//~		locks[i].initialMinimumMinutes = jsonData[i - 1].initialMinimumMinutes
//~		locks[i].initialMinimumRedCards = jsonData[i - 1].initialMinimumRedCards
//~		locks[i].initialMinimumResetCards = jsonData[i - 1].initialMinimumResetCards
//~		locks[i].initialMinimumStickyCards = jsonData[i - 1].initialMinimumStickyCards
//~		locks[i].initialMinimumYellowAddCards = jsonData[i - 1].initialMinimumYellowAddCards
//~		locks[i].initialMinimumYellowMinusCards = jsonData[i - 1].initialMinimumYellowMinusCards
//~		locks[i].initialMinimumYellowRandomCards = jsonData[i - 1].initialMinimumYellowRandomCards
		locks[i].initialMinutes = jsonData[i - 1].initialMinutes
		locks[i].initialRedCards = jsonData[i - 1].initialRedCards
		locks[i].initialResetCards = jsonData[i - 1].initialResetCards
		locks[i].initialStickyCards = jsonData[i - 1].initialStickyCards
		locks[i].initialYellowAdd1Cards = jsonData[i - 1].initialYellowAdd1Cards
		locks[i].initialYellowAdd2Cards = jsonData[i - 1].initialYellowAdd2Cards
		locks[i].initialYellowAdd3Cards = jsonData[i - 1].initialYellowAdd3Cards
		locks[i].initialYellowCards = jsonData[i - 1].initialYellowCards
		locks[i].initialYellowMinus1Cards = jsonData[i - 1].initialYellowMinus1Cards
		locks[i].initialYellowMinus2Cards = jsonData[i - 1].initialYellowMinus2Cards
		locks[i].iteration = i
		locks[i].keyDisabled = jsonData[i - 1].keyDisabled
		locks[i].keyholderAllowsFreeUnlock = jsonData[i - 1].keyholderAllowsFreeUnlock
		locks[i].keyholderBuildNumberInstalled = jsonData[i - 1].keyholderBuildNumberInstalled
		locks[i].keyholderDecisionDisabled = jsonData[i - 1].keyholderDecisionDisabled
		locks[i].keyholderDisabledKey = jsonData[i - 1].keyholderDisabledKey
		locks[i].keyholderEmojiChosen = jsonData[i - 1].keyholderEmojiChosen
		locks[i].keyholderEmojiColourSelected = jsonData[i - 1].keyholderEmojiColourSelected
		if (locks[i].keyholderEmojiColourSelected = 0) then locks[i].keyholderEmojiColourSelected = 1
		locks[i].keyholderID = jsonData[i - 1].keyholderID
		locks[i].keyholderLastActive = jsonData[i - 1].keyholderLastActive
		locks[i].keyholderMainRole = jsonData[i - 1].keyholderMainRole
		locks[i].keyholderMainRoleLevel = jsonData[i - 1].keyholderMainRoleLevel
		locks[i].keyholderStatus = jsonData[i - 1].keyholderStatus
		locks[i].keyholderUsername$ = jsonData[i - 1].keyholderUsername$
		locks[i].keyUsed = jsonData[i - 1].keyUsed
		locks[i].lastUpdateIDSeen = jsonData[i - 1].lastUpdateIDSeen
		locks[i].lateCheckInWindowInSeconds = jsonData[i - 1].lateCheckInWindowInSeconds
		locks[i].lockFrozenByCard = jsonData[i - 1].lockFrozenByCard
		locks[i].lockFrozenByKeyholder = jsonData[i - 1].lockFrozenByKeyholder
		locks[i].lockLog.length = -1
		locks[i].lockName$ = jsonData[i - 1].lockName$
		locks[i].maximumAutoResets = jsonData[i - 1].maximumAutoResets
		locks[i].maximumMinutes = jsonData[i - 1].maximumMinutes
		locks[i].maximumRedCards = jsonData[i - 1].maximumRedCards
		locks[i].minimumMinutes = jsonData[i - 1].minimumMinutes
		locks[i].minimumRedCards = jsonData[i - 1].minimumRedCards
		if (locks[i].minimumRedCards = 0 and locks[i].fixed = 0) then locks[i].minimumRedCards = 1
		locks[i].minutes = jsonData[i - 1].minutes
		locks[i].minutesAdded = jsonData[i - 1].minutesAdded
		locks[i].multipleGreensRequired = jsonData[i - 1].multipleGreensRequired
		locks[i].noOfAdd1Cards = jsonData[i - 1].noOfAdd1Cards
		locks[i].noOfAdd2Cards = jsonData[i - 1].noOfAdd2Cards
		locks[i].noOfAdd3Cards = jsonData[i - 1].noOfAdd3Cards
		locks[i].noOfKeysRequired = jsonData[i - 1].noOfKeysRequired
		locks[i].noOfMinus1Cards = jsonData[i - 1].noOfMinus1Cards
		locks[i].noOfMinus2Cards = jsonData[i - 1].noOfMinus2Cards
		locks[i].noOfTimesAutoReset = jsonData[i - 1].noOfTimesAutoReset
		locks[i].noOfTimesCardReset = jsonData[i - 1].noOfTimesCardReset
		locks[i].noOfTimesFullReset = jsonData[i - 1].noOfTimesFullReset
		locks[i].noOfTimesGreenCardRevealed = jsonData[i - 1].noOfTimesGreenCardRevealed
		locks[i].noOfTimesReset = jsonData[i - 1].noOfTimesReset
		locks[i].permanent = jsonData[i - 1].permanent
		locks[i].pickedCount = jsonData[i - 1].pickedCount
		locks[i].pickedCountIncludingYellows = jsonData[i - 1].pickedCountIncludingYellows
		locks[i].pickedCountSinceReset = jsonData[i - 1].pickedCountSinceReset
		locks[i].randomCardsAdded = jsonData[i - 1].randomCardsAdded
		locks[i].rating = jsonData[i - 1].rating
		locks[i].readyToUnlock = jsonData[i - 1].readyToUnlock
		locks[i].redCards = jsonData[i - 1].redCards
		locks[i].redCardsAdded = jsonData[i - 1].redCardsAdded
		locks[i].regularity# = jsonData[i - 1].regularity#
		locks[i].removedByKeyholder = jsonData[i - 1].removedByKeyholder
		locks[i].removedByKeyholderAlertHidden = 0
		locks[i].resetCards = jsonData[i - 1].resetCards
		locks[i].resetCardsAdded = jsonData[i - 1].resetCardsAdded
		locks[i].resetCardsPicked = jsonData[i - 1].resetCardsPicked
		locks[i].resetFrequencyInSeconds = jsonData[i - 1].resetFrequencyInSeconds
		locks[i].rowInDB = jsonData[i - 1].rowInDB
		locks[i].sharedID$ = jsonData[i - 1].sharedID$
		locks[i].simulationAverageMinutesLocked = jsonData[i - 1].simulationAverageMinutesLocked
		locks[i].simulationBestCaseMinutesLocked = jsonData[i - 1].simulationBestCaseMinutesLocked
		locks[i].simulationWorstCaseMinutesLocked = jsonData[i - 1].simulationWorstCaseMinutesLocked
		locks[i].stickyCards = jsonData[i - 1].stickyCards
		locks[i].test = jsonData[i - 1].test
		locks[i].timeLeftUntilNextChanceBeforeFreeze = jsonData[i - 1].timeLeftUntilNextChanceBeforeFreeze
		locks[i].timerHidden = jsonData[i - 1].timerHidden
		locks[i].timestampCleanTimeRequestBlockedUntil = jsonData[i - 1].timestampCleanTimeRequestBlockedUntil
		locks[i].timestampDeniedCleanTime = jsonData[i - 1].timestampDeniedCleanTime
		locks[i].timestampEndedCleanTime = jsonData[i - 1].timestampEndedCleanTime
		locks[i].timestampFrozenByCard = jsonData[i - 1].timestampFrozenByCard
		locks[i].timestampFrozenByKeyholder = jsonData[i - 1].timestampFrozenByKeyholder
		locks[i].timestampHiddenFromOwner = jsonData[i - 1].timestampHiddenFromOwner
		locks[i].timestampLastAutoReset = jsonData[i - 1].timestampLastAutoReset
		locks[i].timestampLastCardReset = jsonData[i - 1].timestampLastCardReset
		locks[i].timestampLastCheckedIn = jsonData[i - 1].timestampLastCheckedIn
		locks[i].timestampLastCheckedUpdates = 0
		locks[i].timestampLastFullReset = jsonData[i - 1].timestampLastFullReset
		locks[i].timestampLastPicked = jsonData[i - 1].timestampLastPicked
		locks[i].timestampLastReset = jsonData[i - 1].timestampLastReset
		locks[i].timestampLastSynced = jsonData[i - 1].timestampLastSynced
		locks[i].timestampLastUpdated = jsonData[i - 1].timestampLastUpdated
		locks[i].timestampLocked = jsonData[i - 1].timestampLocked
		locks[i].timestampRated = jsonData[i - 1].timestampRated
		locks[i].timestampRealLastPicked = jsonData[i - 1].timestampRealLastPicked
		locks[i].timestampRemovedByKeyholder = jsonData[i - 1].timestampRemovedByKeyholder
		locks[i].timestampRequestedCleanTime = jsonData[i - 1].timestampRequestedCleanTime
		locks[i].timestampRequestedKeyholdersDecision = jsonData[i - 1].timestampRequestedKeyholdersDecision
		locks[i].timestampStartedCleanTime = jsonData[i - 1].timestampStartedCleanTime
		locks[i].timestampUnfreezes = jsonData[i - 1].timestampUnfreezes
		locks[i].timestampUnfrozen = jsonData[i - 1].timestampUnfrozen
		locks[i].timestampUnlocked = jsonData[i - 1].timestampUnlocked
		locks[i].totalTimeCleaning = jsonData[i - 1].totalTimeCleaning
		locks[i].totalTimeFrozen = jsonData[i - 1].totalTimeFrozen
		locks[i].trustKeyholder = jsonData[i - 1].trustKeyholder
		locks[i].unlocked = jsonData[i - 1].unlocked
		locks[i].version$ = jsonData[i - 1].version$
		locks[i].yellowCards = locks[i].noOfAdd1Cards + locks[i].noOfAdd2Cards + locks[i].noOfAdd3Cards + locks[i].noOfMinus1Cards + locks[i].noOfMinus2Cards			
		UpdateLocksData(i)
	next
	SaveLocalVariable("noOfLocks", str(noOfLocks))
	fileID = OpenToWrite("locksV2.txt", 0)
	for a = 1 to 20
		WriteInteger(fileID, locks[a].id)
	next
	CloseFile(fileID)
endfunction

function ReceivedServerVariables()
	local i as integer
	local tmpVersionNumber$ as string
	
	jsonData.length = -1
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	dateFromServer$ = AddLeadingZeros(str(val(GetJSONDataVariableValue("dateDay"))), 2) + "/" + AddLeadingZeros(str(val(GetJSONDataVariableValue("dateMonth"))), 2) + "/" + AddLeadingZeros(str(val(GetJSONDataVariableValue("dateYear"))), 4)
	timestampFromServer = val(GetJSONDataVariableValue("timestamp"))
	timestampFromDevice = GetUnixTime()
	deviceTimestampOffset = timestampFromDevice - timestampFromServer
	SaveLocalVariable("deviceTimestampOffset", str(deviceTimestampOffset))
	tmpVersionNumber$ = ReplaceString(constVersionNumber$, " ", "_", -1)
	tmpVersionNumber$ = ReplaceString(tmpVersionNumber$, ".", "_", -1)
	dateDeactivatingVersion$ = GetJSONDataVariableValue("date_deactivating_v" + tmpVersionNumber$)
	disableCreationOfNewLocks = val(GetJSONDataVariableValue("disable_creation_of_new_locks"))
	noOfGeneratedLocks = val(GetJSONDataVariableValue("noOfGeneratedLocks"))
	for i = 1 to 8
		botsData[i].keyholderLevel = val(GetJSONDataVariableValue("keyholderLevelBOT" + AddLeadingZeros(str(i), 2)))
		botsData[i].lockedCount = val(GetJSONDataVariableValue("lockedCountBOT" + AddLeadingZeros(str(i), 2)))
		botsData[i].phrase$ = GetJSONDataVariableValue("phraseBOT" + AddLeadingZeros(str(i), 2))
		botsData[i].rating# = valFloat(GetJSONDataVariableValue("ratingBOT" + AddLeadingZeros(str(i), 2)))
		botsData[i].noOfRatings = val(GetJSONDataVariableValue("noOfRatingsBOT" + AddLeadingZeros(str(i), 2)))
		botsData[i].totalManaged = val(GetJSONDataVariableValue("totalManagedBOT" + AddLeadingZeros(str(i), 2)))
	next
	if (val(GetJSONDataVariableValue("maintenance_mode")) = 1)
		SetMaintenanceValue(1)
	else
		SetMaintenanceValue(0)
		SetOfflineValue(0)
	endif
	ResetTimer()
	secondsRunning = GetSeconds()
	timestampNow = timestampFromServer + secondsRunning
endfunction

function ReceivedSharedLockInformation()
	local i as integer
	local multipleLocksDenied as integer
	local noOfActiveLocks as integer
	
	jsonData as typeSharedLocks[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	noOfCopies = 0
	noOfActiveLocks = 0
	multipleLocksDenied = 0
	GetLocksData()
	for i = 1 to noOfLocks
		if (locks[i].id > 0 and locks[i].unlocked = 0 and locks[i].keyholderID <> jsonData[0].keyholderID)
			inc noOfActiveLocks
			if (locks[i].build >= 163 and locks[i].blockUsersAlreadyLocked = 1 and locks[i].keyholderID > 0 and jsonData[0].keyholderID > 0)
				multipleLocksDenied = 1
			endif
		endif
	next
	if (sharedLockError$ <> "")
		sharedID$ = ""
		sharedLockName$ = ""
	elseif (jsonData[0].temporarilyDisabled = 1)
		sharedID$ = ""
		sharedLockName$ = ""
		if (jsonData[0].hiddenFromOwner = 0)
			sharedLockError$ = "The keyholder has temporarily disabled this lock." + chr(10) + chr(10) + "Please contact them, or try again later."
		else
			sharedLockError$ = "The keyholder has disabled and no longer manages this lock."
		endif
	elseif (noOfLocks >= 20)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "You have too many locks." + chr(10) + chr(10) + "Please delete some of your completed locks before trying again."
	elseif (VersionCompare(constVersionNumber$, jsonData[0].minVersionRequired$) = -1)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "Requires a newer version of " + constAppName$ + "." + chr(10) + chr(10) + "Please update the app and try again."
	elseif (jsonData[0].maxUsers > 0 and jsonData[0].lockedUsers >= jsonData[0].maxUsers)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "Lock has the maximum number of users the keyholder allows." + chr(10) + chr(10) + "Please try again at a later date."
	elseif (jsonData[0].minRatingRequired > 0 and (noOfRatings < 5 or (noOfRatings >= 5 and jsonData[0].minRatingRequired > averageRating#)) and username$ <> jsonData[0].keyholderUsername$)
		sharedID$ = ""
		sharedLockName$ = ""
		if (noOfRatings < 5)
			sharedLockError$ = "Lock requires a minumum rating of " + str(jsonData[0].minRatingRequired) + " to load." + chr(10) + chr(10) + "You do not have enough ratings yet."
		else
			sharedLockError$ = "Lock requires a minumum rating of " + str(jsonData[0].minRatingRequired) + " to load." + chr(10) + chr(10) + "Your current rating is " + str(averageRating#, 1) + "."
		endif
	elseif (jsonData[0].blockUsersAlreadyLocked = 1 and noOfActiveLocks > 0 and username$ <> jsonData[0].keyholderUsername$)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "The keyholder has chosen to not allow users to load this lock if they have existing locks running." + chr(10) + chr(10) + "Please complete or abandon your existing locks before trying again."
	elseif (multipleLocksDenied = 1 and noOfActiveLocks > 0 and username$ <> jsonData[0].keyholderUsername$)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "You are not allowed to lock with other keyholders while you are locked with your current keyholder." + chr(10) + chr(10) + "Please complete or abandon your existing locks before trying again."
	elseif (jsonData[0].blockUsersWithStatsHidden = 1 and visibleInPublicStats <> 1 and username$ <> jsonData[0].keyholderUsername$)
		sharedID$ = ""
		sharedLockName$ = ""
		sharedLockError$ = "The keyholder has chosen to not allow users if they have their stats and lock history set as private." + chr(10) + chr(10) + "You will need to make them public from within the app settings page to be able to load this lock."
	else
		sharedID$ = jsonData[0].shareID$
		sharedLockName$ = jsonData[0].lockName$
		sharedLockError$ = ""
		absoluteMaxCopies = jsonData[0].maxRandomCopies
		absoluteMinCopies = jsonData[0].minRandomCopies
		blockTestLocks = jsonData[0].blockTestLocks
		blockUsersAlreadyLocked = jsonData[0].blockUsersAlreadyLocked
		blockUsersWithStatsHidden = jsonData[0].blockUsersWithStatsHidden
		build = jsonData[0].build
		cardInfoHidden = jsonData[0].cardInfoHidden
		checkInFrequencyInSeconds = jsonData[0].checkInFrequencyInSeconds
		cumulative = jsonData[0].cumulative
		fixed = jsonData[0].fixed
		forceTrust = jsonData[0].forceTrust
		hiddenFromOwner = jsonData[0].hiddenFromOwner
		keyholderDisabledKey = jsonData[0].keyDisabled
		keyholderDecisionDisabled = jsonData[0].keyholderDecisionDisabled
		keyholderID = jsonData[0].keyholderID
		keyholderLastActive = jsonData[0].keyholderLastActive
		keyholderRating# = jsonData[0].keyholderRating#
		keyholderStatus = jsonData[0].keyholderStatus
		keyholderUsername$ = jsonData[0].keyholderUsername$
		lateCheckInWindowInSeconds = jsonData[0].lateCheckInWindowInSeconds
		lockedUsers = jsonData[0].lockedUsers
		lockRating# = jsonData[0].lockRating#
		maxAutoResets = jsonData[0].maxAutoResets
		if (maxAutoResets > 0) then autoResetLock = 1
		maxDoubleUps = jsonData[0].maxRandomDoubleUps
		maxFreezes = jsonData[0].maxRandomFreezes
		maxGreens = jsonData[0].maxRandomGreens
		maxMinutes = jsonData[0].maxRandomMinutes
		maxReds = jsonData[0].maxRandomReds
		maxResets = jsonData[0].maxRandomResets
		maxStickies = jsonData[0].maxRandomStickies
		maxUsers = jsonData[0].maxUsers
		maxYellowsAdd = jsonData[0].maxRandomYellowsAdd
		maxYellowsMinus = jsonData[0].maxRandomYellowsMinus
		maxYellowsRandom = jsonData[0].maxRandomYellows
		minDoubleUps = jsonData[0].minRandomDoubleUps
		minFreezes = jsonData[0].minRandomFreezes
		minGreens = jsonData[0].minRandomGreens
		minMinutes = jsonData[0].minRandomMinutes
		minRatingRequired = jsonData[0].minRatingRequired
		minReds = jsonData[0].minRandomReds
		minResets = jsonData[0].minRandomResets
		minStickies = jsonData[0].minRandomStickies
		minVersionRequired$ = jsonData[0].minVersionRequired$
		minYellowsAdd = jsonData[0].minRandomYellowsAdd
		minYellowsMinus = jsonData[0].minRandomYellowsMinus
		minYellowsRandom = jsonData[0].minRandomYellows
		multipleGreensRequired = jsonData[0].multipleGreensRequired
		noOfKeyholderRatings = jsonData[0].noOfKeyholderRatings
		noOfLockRatings = jsonData[0].noOfLockRatings
		regularity# = jsonData[0].regularity#
		requireDM = jsonData[0].requireDM
		resetFrequencyInSeconds = jsonData[0].resetFrequencyInSeconds
		simulationAverageMinutesLocked = jsonData[0].simulationAverageMinutesLocked
		simulationBestCaseMinutesLocked = jsonData[0].simulationBestCaseMinutesLocked
		simulationWorstCaseMinutesLocked = jsonData[0].simulationWorstCaseMinutesLocked
		startLockFrozen = jsonData[0].startLockFrozen
		temporarilyDisabled = jsonData[0].temporarilyDisabled
		timerHidden = jsonData[0].timerHidden
		version$ = jsonData[0].version$
		
		if (keyholderUsername$ = username$)
			requireDM = 0
			startLockFrozen = 0
		endif
		
		sharedLockInfo$ = BuildSharedLockSettingsString()
	endif
endfunction

function ReceivedSharedLocksData()
	local i as integer
	
	jsonData as typeSharedLocks[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	noOfSharedLocks = jsonData.length + 1
	//noOfSharedLocksLastSession = noOfSharedLocks
	//SaveLocalVariable("noOfSharedLocksLastSession", str(noOfSharedLocks))
	for i = 1 to noOfSharedLocks
		sharedLocks[i, 0].awaitingDecision = jsonData[i - 1].awaitingDecision
		sharedLocks[i, 0].blockTestLocks = jsonData[i - 1].blockTestLocks
		sharedLocks[i, 0].blockUsersAlreadyLocked = jsonData[i - 1].blockUsersAlreadyLocked
		sharedLocks[i, 0].blockUsersWithStatsHidden = jsonData[i - 1].blockUsersWithStatsHidden
		sharedLocks[i, 0].build = jsonData[i - 1].build
		sharedLocks[i, 0].cardInfoHidden = jsonData[i - 1].cardInfoHidden
		sharedLocks[i, 0].checkInFrequencyInSeconds = jsonData[i - 1].checkInFrequencyInSeconds
		sharedLocks[i, 0].cumulative = jsonData[i - 1].cumulative
		sharedLocks[i, 0].deleting = 0
		sharedLocks[i, 0].desertedUsers = jsonData[i - 1].desertedUsers
		sharedLocks[i, 0].desertedUsersAwaitingRating = jsonData[i - 1].desertedUsersAwaitingRating
		sharedLocks[i, 0].desertedUsersDelimited$ = jsonData[i - 1].desertedUsersDelimited$
		sharedLocks[i, 0].fakeLockedUsers = jsonData[i - 1].fakeLockedUsers
		sharedLocks[i, 0].filterIn = 0
		sharedLocks[i, 0].fixed = jsonData[i - 1].fixed
		sharedLocks[i, 0].forceTrust = jsonData[i - 1].forceTrust
		sharedLocks[i, 0].id = jsonData[i - 1].id
		sharedLocks[i, 0].jsonCount = 0
		sharedLocks[i, 0].keyDisabled = jsonData[i - 1].keyDisabled
		sharedLocks[i, 0].keyholderDecisionDisabled = jsonData[i - 1].keyholderDecisionDisabled
		sharedLocks[i, 0].lateCheckInWindowInSeconds = jsonData[i - 1].lateCheckInWindowInSeconds
		sharedLocks[i, 0].lockedUsers = jsonData[i - 1].lockedUsers
		sharedLocks[i, 0].lockedUsersDelimited$ = jsonData[i - 1].lockedUsersDelimited$
		sharedLocks[i, 0].lockedUsersExcludingTest = jsonData[i - 1].lockedUsersExcludingTest
		sharedLocks[i, 0].lockedUsersIncludingTest = jsonData[i - 1].lockedUsersIncludingTest
		sharedLocks[i, 0].lockName$ = jsonData[i - 1].lockName$
		sharedLocks[i, 0].lockRating# = jsonData[i - 1].lockRating#
		sharedLocks[i, 0].maxAutoResets = jsonData[i - 1].maxAutoResets
		sharedLocks[i, 0].maxRandomCopies = jsonData[i - 1].maxRandomCopies
		sharedLocks[i, 0].maxRandomDoubleUps = jsonData[i - 1].maxRandomDoubleUps
		sharedLocks[i, 0].maxRandomFreezes = jsonData[i - 1].maxRandomFreezes
		sharedLocks[i, 0].maxRandomGreens = jsonData[i - 1].maxRandomGreens
		sharedLocks[i, 0].maxRandomMinutes = jsonData[i - 1].maxRandomMinutes
		sharedLocks[i, 0].maxRandomReds = jsonData[i - 1].maxRandomReds
		sharedLocks[i, 0].maxRandomResets = jsonData[i - 1].maxRandomResets
		sharedLocks[i, 0].maxRandomStickies = jsonData[i - 1].maxRandomStickies
		sharedLocks[i, 0].maxRandomYellows = jsonData[i - 1].maxRandomYellows
		sharedLocks[i, 0].maxRandomYellowsAdd = jsonData[i - 1].maxRandomYellowsAdd
		sharedLocks[i, 0].maxRandomYellowsMinus = jsonData[i - 1].maxRandomYellowsMinus
		sharedLocks[i, 0].maxUsers = jsonData[i - 1].maxUsers
		sharedLocks[i, 0].minRandomCopies = jsonData[i - 1].minRandomCopies
		sharedLocks[i, 0].minRandomDoubleUps = jsonData[i - 1].minRandomDoubleUps
		sharedLocks[i, 0].minRandomFreezes = jsonData[i - 1].minRandomFreezes
		sharedLocks[i, 0].minRandomGreens = jsonData[i - 1].minRandomGreens
		sharedLocks[i, 0].minRandomMinutes = jsonData[i - 1].minRandomMinutes
		sharedLocks[i, 0].minRandomReds = jsonData[i - 1].minRandomReds
		sharedLocks[i, 0].minRandomResets = jsonData[i - 1].minRandomResets
		sharedLocks[i, 0].minRandomStickies = jsonData[i - 1].minRandomStickies
		sharedLocks[i, 0].minRandomYellows = jsonData[i - 1].minRandomYellows
		sharedLocks[i, 0].minRandomYellowsAdd = jsonData[i - 1].minRandomYellowsAdd
		sharedLocks[i, 0].minRandomYellowsMinus = jsonData[i - 1].minRandomYellowsMinus
		sharedLocks[i, 0].minRatingRequired = jsonData[i - 1].minRatingRequired
		sharedLocks[i, 0].minVersionRequired$ = jsonData[i - 1].minVersionRequired$
		sharedLocks[i, 0].multipleGreensRequired = jsonData[i - 1].multipleGreensRequired
		sharedLocks[i, 0].noOfLockRatings = jsonData[i - 1].noOfLockRatings
		sharedLocks[i, 0].regularity# = jsonData[i - 1].regularity#
		sharedLocks[i, 0].requireDM = jsonData[i - 1].requireDM
		sharedLocks[i, 0].resetFrequencyInSeconds = jsonData[i - 1].resetFrequencyInSeconds
		sharedLocks[i, 0].shareID$ = jsonData[i - 1].shareID$
		sharedLocks[i, 0].shareInAPI = jsonData[i - 1].shareInAPI
		sharedLocks[i, 0].simulationAverageMinutesLocked = jsonData[i - 1].simulationAverageMinutesLocked
		sharedLocks[i, 0].simulationBestCaseMinutesLocked = jsonData[i - 1].simulationBestCaseMinutesLocked
		sharedLocks[i, 0].simulationWorstCaseMinutesLocked = jsonData[i - 1].simulationWorstCaseMinutesLocked
		sharedLocks[i, 0].startLockFrozen = jsonData[i - 1].startLockFrozen
		sharedLocks[i, 0].temporarilyDisabled = jsonData[i - 1].temporarilyDisabled
		sharedLocks[i, 0].timerHidden = jsonData[i - 1].timerHidden
		sharedLocks[i, 0].timestampLastSync = timestampNow
		sharedLocks[i, 0].unlockedUsers = jsonData[i - 1].unlockedUsers
		sharedLocks[i, 0].unlockedUsersAwaitingRating = jsonData[i - 1].unlockedUsersAwaitingRating
		sharedLocks[i, 0].unlockedUsersDelimited$ = jsonData[i - 1].unlockedUsersDelimited$
		sharedLocks[i, 0].version$ = jsonData[i - 1].version$
		sharedLocks[i, 0].minVersionRequired$ = "2.3.0"
		//2.3.0
		if (sharedLocks[i, 0].minRandomResets > 0 or sharedLocks[i, 0].maxRandomResets > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.3.0"
		//2.3.4
		if (sharedLocks[i, 0].minRandomGreens > 1 or sharedLocks[i, 0].maxRandomGreens > 1) then sharedLocks[i, 0].minVersionRequired$ = "2.3.4"
		if (sharedLocks[i, 0].minRandomDoubleUps > 0 or sharedLocks[i, 0].maxRandomDoubleUps > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.3.4"
		if (sharedLocks[i, 0].multipleGreensRequired = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.3.4"
		//2.4.0
		if (sharedLocks[i, 0].cardInfoHidden = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].maxRandomYellowsAdd > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].maxRandomYellowsMinus > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].minRandomFreezes > 0 or sharedLocks[i, 0].maxRandomFreezes > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].maxUsers > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].regularity# = 0.5 or (sharedLocks[i, 0].regularity# > 1 and sharedLocks[i, 0].regularity# < 24)) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		if (sharedLocks[i, 0].blockUsersAlreadyLocked = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.4.0"
		//2.5.0
		if (sharedLocks[i, 0].fixed = 1 and sharedLocks[i, 0].build >= 134) then sharedLocks[i, 0].minVersionRequired$ = "2.5.0"
		if (sharedLocks[i, 0].minRandomCopies > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.5.0"
		if (sharedLocks[i, 0].requireDM = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.5.0"
		if (sharedLocks[i, 0].blockUsersWithStatsHidden = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.5.0"
		//2.5.2
		if (sharedLocks[i, 0].keyholderDecisionDisabled = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].maxAutoResets > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomDoubleUps > 20 or sharedLocks[i, 0].maxRandomDoubleUps > 20) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomFreezes > 20 or sharedLocks[i, 0].maxRandomFreezes > 20) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomGreens > 20 or sharedLocks[i, 0].maxRandomGreens > 20) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomReds > 399 or sharedLocks[i, 0].maxRandomReds > 399) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomResets > 20 or sharedLocks[i, 0].maxRandomResets > 399) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomYellows > 200 or sharedLocks[i, 0].maxRandomYellows > 200) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomYellowsAdd > 200 or sharedLocks[i, 0].maxRandomYellowsAdd > 200) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRandomYellowsMinus > 200 or sharedLocks[i, 0].maxRandomYellowsMinus > 200) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].minRatingRequired = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		if (sharedLocks[i, 0].fixed = 0 and sharedLocks[i, 0].regularity# = 0.016667) then sharedLocks[i, 0].minVersionRequired$ = "2.5.2"
		//2.5.3
		if (sharedLocks[i, 0].minRandomStickies > 0 or sharedLocks[i, 0].maxRandomStickies > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.5.3"
		//2.5.4
		if (sharedLocks[i, 0].minRandomStickies > 30 or sharedLocks[i, 0].maxRandomStickies > 30) then sharedLocks[i, 0].minVersionRequired$ = "2.5.4"
		if (sharedLocks[i, 0].minRandomDoubleUps > 30 or sharedLocks[i, 0].maxRandomDoubleUps > 30) then sharedLocks[i, 0].minVersionRequired$ = "2.5.4"
		if (sharedLocks[i, 0].minRandomFreezes > 30 or sharedLocks[i, 0].maxRandomFreezes > 30) then sharedLocks[i, 0].minVersionRequired$ = "2.5.4"
		if (sharedLocks[i, 0].minRandomGreens > 30 or sharedLocks[i, 0].maxRandomGreens > 30) then sharedLocks[i, 0].minVersionRequired$ = "2.5.4"
		if (sharedLocks[i, 0].minRandomResets > 30 or sharedLocks[i, 0].maxRandomResets > 30) then sharedLocks[i, 0].minVersionRequired$ = "2.5.4"
		//2.6.2
		if (sharedLocks[i, 0].startLockFrozen = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.6.2"
		//2.6.3
		if (sharedLocks[i, 0].checkInFrequencyInSeconds > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.6.3"
		//2.6.5
		if (sharedLocks[i, 0].temporarilyDisabled = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.6.5"
		//2.6.8
		if (sharedLocks[i, 0].lateCheckInWindowInSeconds > 0) then sharedLocks[i, 0].minVersionRequired$ = "2.6.8"
		//2.7.2
		if (sharedLocks[i, 0].blockTestLocks = 1) then sharedLocks[i, 0].minVersionRequired$ = "2.7.2"
	next
endfunction

function ReceivedSharedLocksDeleted()
	local i as integer
	
	jsonData as typeSharedLocks[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	locksDeleted.sharedLocks.length = jsonData.length
	for i = 0 to jsonData.length
		locksDeleted.sharedLocks[i].blockTestLocks = jsonData[i].blockTestLocks
		locksDeleted.sharedLocks[i].blockUsersAlreadyLocked = jsonData[i].blockUsersAlreadyLocked
		locksDeleted.sharedLocks[i].blockUsersWithStatsHidden = jsonData[i].blockUsersWithStatsHidden
		locksDeleted.sharedLocks[i].build = jsonData[i].build
		locksDeleted.sharedLocks[i].cardInfoHidden = jsonData[i].cardInfoHidden
		locksDeleted.sharedLocks[i].checkInFrequencyInSeconds = jsonData[i].checkInFrequencyInSeconds
		locksDeleted.sharedLocks[i].cumulative = jsonData[i].cumulative
		locksDeleted.sharedLocks[i].deleting = 0
		locksDeleted.sharedLocks[i].desertedUsers = jsonData[i].desertedUsers
		locksDeleted.sharedLocks[i].fakeLockedUsers = jsonData[i].fakeLockedUsers
		locksDeleted.sharedLocks[i].filterIn = 0
		locksDeleted.sharedLocks[i].fixed = jsonData[i].fixed
		locksDeleted.sharedLocks[i].forceTrust = jsonData[i].forceTrust
		locksDeleted.sharedLocks[i].id = jsonData[i].id
		locksDeleted.sharedLocks[i].jsonCount = 0
		locksDeleted.sharedLocks[i].keyDisabled = jsonData[i].keyDisabled
		locksDeleted.sharedLocks[i].keyholderDecisionDisabled = jsonData[i].keyholderDecisionDisabled
		locksDeleted.sharedLocks[i].lateCheckInWindowInSeconds = jsonData[i].lateCheckInWindowInSeconds
		locksDeleted.sharedLocks[i].lockedUsers = jsonData[i].lockedUsers
		locksDeleted.sharedLocks[i].lockName$ = jsonData[i].lockName$
		locksDeleted.sharedLocks[i].lockRating# = jsonData[i].lockRating#
		locksDeleted.sharedLocks[i].maxAutoResets = jsonData[i].maxAutoResets
		locksDeleted.sharedLocks[i].maxRandomCopies = jsonData[i].maxRandomCopies
		locksDeleted.sharedLocks[i].maxRandomDoubleUps = jsonData[i].maxRandomDoubleUps
		locksDeleted.sharedLocks[i].maxRandomFreezes = jsonData[i].maxRandomFreezes
		locksDeleted.sharedLocks[i].maxRandomGreens = jsonData[i].maxRandomGreens
		locksDeleted.sharedLocks[i].maxRandomMinutes = jsonData[i].maxRandomMinutes
		locksDeleted.sharedLocks[i].maxRandomReds = jsonData[i].maxRandomReds
		locksDeleted.sharedLocks[i].maxRandomResets = jsonData[i].maxRandomResets
		locksDeleted.sharedLocks[i].maxRandomStickies = jsonData[i].maxRandomStickies
		locksDeleted.sharedLocks[i].maxRandomYellows = jsonData[i].maxRandomYellows
		locksDeleted.sharedLocks[i].maxRandomYellowsAdd = jsonData[i].maxRandomYellowsAdd
		locksDeleted.sharedLocks[i].maxRandomYellowsMinus = jsonData[i].maxRandomYellowsMinus
		locksDeleted.sharedLocks[i].maxUsers = jsonData[i].maxUsers
		locksDeleted.sharedLocks[i].minRandomCopies = jsonData[i].minRandomCopies
		locksDeleted.sharedLocks[i].minRandomDoubleUps = jsonData[i].minRandomDoubleUps
		locksDeleted.sharedLocks[i].minRandomFreezes = jsonData[i].minRandomFreezes
		locksDeleted.sharedLocks[i].minRandomGreens = jsonData[i].minRandomGreens
		locksDeleted.sharedLocks[i].minRandomMinutes = jsonData[i].minRandomMinutes
		locksDeleted.sharedLocks[i].minRandomReds = jsonData[i].minRandomReds
		locksDeleted.sharedLocks[i].minRandomResets = jsonData[i].minRandomResets
		locksDeleted.sharedLocks[i].minRandomStickies = jsonData[i].minRandomStickies
		locksDeleted.sharedLocks[i].minRandomYellows = jsonData[i].minRandomYellows
		locksDeleted.sharedLocks[i].minRandomYellowsAdd = jsonData[i].minRandomYellowsAdd
		locksDeleted.sharedLocks[i].minRandomYellowsMinus = jsonData[i].minRandomYellowsMinus
		locksDeleted.sharedLocks[i].minRatingRequired = jsonData[i].minRatingRequired
		locksDeleted.sharedLocks[i].minVersionRequired$ = jsonData[i].minVersionRequired$
		locksDeleted.sharedLocks[i].multipleGreensRequired = jsonData[i].multipleGreensRequired
		locksDeleted.sharedLocks[i].noOfLockRatings = jsonData[i].noOfLockRatings
		locksDeleted.sharedLocks[i].regularity# = jsonData[i].regularity#
		locksDeleted.sharedLocks[i].requireDM = jsonData[i].requireDM
		locksDeleted.sharedLocks[i].resetFrequencyInSeconds = jsonData[i].resetFrequencyInSeconds
		locksDeleted.sharedLocks[i].shareID$ = jsonData[i].shareID$
		locksDeleted.sharedLocks[i].shareInAPI = jsonData[i].shareInAPI
		locksDeleted.sharedLocks[i].simulationAverageMinutesLocked = jsonData[i].simulationAverageMinutesLocked
		locksDeleted.sharedLocks[i].simulationBestCaseMinutesLocked = jsonData[i].simulationBestCaseMinutesLocked
		locksDeleted.sharedLocks[i].simulationWorstCaseMinutesLocked = jsonData[i].simulationWorstCaseMinutesLocked
		locksDeleted.sharedLocks[i].startLockFrozen = jsonData[i].startLockFrozen
		locksDeleted.sharedLocks[i].temporarilyDisabled = jsonData[i].temporarilyDisabled
		locksDeleted.sharedLocks[i].timerHidden = jsonData[i].timerHidden
		locksDeleted.sharedLocks[i].timestampHidden = jsonData[i].timestampHidden
		locksDeleted.sharedLocks[i].timestampLastSync = timestampNow
		locksDeleted.sharedLocks[i].unlockedUsers = jsonData[i].unlockedUsers
		locksDeleted.sharedLocks[i].version$ = jsonData[i].version$
	next
endfunction

function ReceivedSharedLockUserData(sharedLockNo, usersTab)
	local fakeLockedUsers as integer
	local i as integer

	jsonData as typeSharedLockUsers[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	sharedLocks[sharedLockNo, 1].noOfUsers = 0
	sharedLocks[sharedLockNo, 2].noOfUsers = 0
	sharedLocks[sharedLockNo, 3].noOfUsers = 0
	fakeLockedUsers = 0
	sharedLocks[sharedLockNo, 0].jsonCount = jsonData.length + 1

	for i = 1 to jsonData.length + 1
		if (jsonData[i - 1].jsonNo = 1)
			inc sharedLocks[sharedLockNo, 1].noOfUsers
			lockedUserCount = sharedLocks[sharedLockNo, 1].noOfUsers
			sharedLocks[sharedLockNo, 1].timestampLastSync = timestampNow
			sharedLocks[sharedLockNo, 1].usersAutoResetsPaused[lockedUserCount] = jsonData[i - 1].usersAutoResetsPaused
			sharedLocks[sharedLockNo, 1].usersAverageRatingFromKeyholders#[lockedUserCount] = jsonData[i - 1].usersAverageRatingFromKeyholders#
			sharedLocks[sharedLockNo, 1].usersBuildNumberInstalled[lockedUserCount] = jsonData[i - 1].usersBuildNumberInstalled
			sharedLocks[sharedLockNo, 1].usersCardInfoHidden[lockedUserCount] = jsonData[i - 1].usersCardInfoHidden
			sharedLocks[sharedLockNo, 1].usersChancesAccumulatedBeforeFreeze[lockedUserCount] = jsonData[i - 1].usersChancesAccumulatedBeforeFreeze
			sharedLocks[sharedLockNo, 1].usersCheckInFrequencyInSeconds[lockedUserCount] = jsonData[i - 1].usersCheckInFrequencyInSeconds
			sharedLocks[sharedLockNo, 1].usersCombination$[lockedUserCount] = jsonData[i - 1].usersCombination$
			sharedLocks[sharedLockNo, 1].usersCumulative[lockedUserCount] = jsonData[i - 1].usersCumulative
			sharedLocks[sharedLockNo, 1].usersDateLocked$[lockedUserCount] = jsonData[i - 1].usersDateLocked$
			sharedLocks[sharedLockNo, 1].usersDiscardPile$[lockedUserCount] = jsonData[i - 1].usersDiscardPile$
			sharedLocks[sharedLockNo, 1].usersDoubleUpCards[lockedUserCount] = jsonData[i - 1].usersDoubleUpCards
			if (sharedLocks[sharedLockNo, 1].usersDoubleUpCards[lockedUserCount] < 0) then sharedLocks[sharedLockNo, 1].usersDoubleUpCards[lockedUserCount] = 0
			if (sharedLocks[sharedLockNo, 1].usersDoubleUpCards[lockedUserCount] > cappedDoubleUpCards) then sharedLocks[sharedLockNo, 1].usersDoubleUpCards[lockedUserCount] = cappedDoubleUpCards
			sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = jsonData[i - 1].usersEmojiChosen
			sharedLocks[sharedLockNo, 1].usersEmojiColourSelected[lockedUserCount] = jsonData[i - 1].usersEmojiColourSelected
			if (sharedLocks[sharedLockNo, 1].usersEmojiColourSelected[lockedUserCount] = 0) then sharedLocks[sharedLockNo, 1].usersEmojiColourSelected[lockedUserCount] = 1
			// RECODE OLD VERSION EMOJIS (BEST I CAN)
			if (jsonData[i - 1].usersBuildNumberInstalled < 134 and jsonData[i - 1].usersEmojiChosen > 0 and jsonData[i - 1].usersEmojiColourSelected = 0)
				if (jsonData[i - 1].usersEmojiChosen = 1)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 1
				elseif (jsonData[i - 1].usersEmojiChosen = 2)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 2
				elseif (jsonData[i - 1].usersEmojiChosen = 3)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 3
				elseif (jsonData[i - 1].usersEmojiChosen = 4)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 18
				elseif (jsonData[i - 1].usersEmojiChosen = 5)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 17
				elseif (jsonData[i - 1].usersEmojiChosen = 6)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 9
				elseif (jsonData[i - 1].usersEmojiChosen = 7)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 24
				elseif (jsonData[i - 1].usersEmojiChosen = 8)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 8
				elseif (jsonData[i - 1].usersEmojiChosen = 9)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 19
				elseif (jsonData[i - 1].usersEmojiChosen = 10)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 65
				elseif (jsonData[i - 1].usersEmojiChosen = 11)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 62
				elseif (jsonData[i - 1].usersEmojiChosen = 12)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 43
				elseif (jsonData[i - 1].usersEmojiChosen = 13)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 44
				elseif (jsonData[i - 1].usersEmojiChosen = 14)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 53
				elseif (jsonData[i - 1].usersEmojiChosen = 15)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 46
				elseif (jsonData[i - 1].usersEmojiChosen = 16)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 51
				elseif (jsonData[i - 1].usersEmojiChosen = 17)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 52
				elseif (jsonData[i - 1].usersEmojiChosen = 18)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 66
				elseif (jsonData[i - 1].usersEmojiChosen = 19)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 34
				elseif (jsonData[i - 1].usersEmojiChosen = 20)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 72
				elseif (jsonData[i - 1].usersEmojiChosen = 21)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 63
				elseif (jsonData[i - 1].usersEmojiChosen = 22)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 59
				elseif (jsonData[i - 1].usersEmojiChosen = 23)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 34
				elseif (jsonData[i - 1].usersEmojiChosen = 24)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 36
				elseif (jsonData[i - 1].usersEmojiChosen = 25)
					sharedLocks[sharedLockNo, 1].usersEmojiChosen[lockedUserCount] = 58
				endif
			endif	
			sharedLocks[sharedLockNo, 1].usersFakeLock[lockedUserCount] = jsonData[i - 1].usersFakeLock
			if (sharedLocks[sharedLockNo, 1].usersFakeLock[lockedUserCount] = 1) then inc fakeLockedUsers
			sharedLocks[sharedLockNo, 1].usersFreezeCards[lockedUserCount] = jsonData[i - 1].usersFreezeCards
			if (sharedLocks[sharedLockNo, 1].usersFreezeCards[lockedUserCount] < 0) then sharedLocks[sharedLockNo, 1].usersFreezeCards[lockedUserCount] = 0
			if (sharedLocks[sharedLockNo, 1].usersFreezeCards[lockedUserCount] > cappedFreezeCards) then sharedLocks[sharedLockNo, 1].usersFreezeCards[lockedUserCount] = cappedFreezeCards
			sharedLocks[sharedLockNo, 1].usersGreenCards[lockedUserCount] = jsonData[i - 1].usersGreenCards
			if (sharedLocks[sharedLockNo, 1].usersGreenCards[lockedUserCount] < 0) then sharedLocks[sharedLockNo, 1].usersGreenCards[lockedUserCount] = 0
			if (sharedLocks[sharedLockNo, 1].usersGreenCards[lockedUserCount] > cappedGreenCards) then sharedLocks[sharedLockNo, 1].usersGreenCards[lockedUserCount] = cappedGreenCards
			sharedLocks[sharedLockNo, 1].usersGreenCardsPicked[lockedUserCount] = jsonData[i - 1].usersGreenCardsPicked
			sharedLocks[sharedLockNo, 1].usersHideGreensUntilPickedCount[lockedUserCount] = jsonData[i - 1].usersHideGreensUntilPickedCount
			sharedLocks[sharedLockNo, 1].usersID[lockedUserCount] = jsonData[i - 1].usersID
			sharedLocks[sharedLockNo, 1].usersInitialDoubleUpCards[lockedUserCount] = jsonData[i - 1].usersInitialDoubleUpCards
			sharedLocks[sharedLockNo, 1].usersInitialFreezeCards[lockedUserCount] = jsonData[i - 1].usersInitialFreezeCards
			sharedLocks[sharedLockNo, 1].usersInitialGreenCards[lockedUserCount] = jsonData[i - 1].usersInitialGreenCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumDoubleUpCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumDoubleUpCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumFreezeCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumFreezeCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumGreenCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumGreenCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumMinutes[lockedUserCount] = jsonData[i - 1].usersInitialMaximumMinutes
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumRedCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumRedCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumResetCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumResetCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumStickyCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumStickyCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumYellowAddCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumYellowAddCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumYellowMinusCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumYellowMinusCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMaximumYellowRandomCards[lockedUserCount] = jsonData[i - 1].usersInitialMaximumYellowRandomCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumDoubleUpCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumDoubleUpCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumFreezeCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumFreezeCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumGreenCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumGreenCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumMinutes[lockedUserCount] = jsonData[i - 1].usersInitialMinimumMinutes
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumRedCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumRedCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumResetCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumResetCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumStickyCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumStickyCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumYellowAddCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumYellowAddCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumYellowMinusCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumYellowMinusCards
//~			sharedLocks[sharedLockNo, 1].usersInitialMinimumYellowRandomCards[lockedUserCount] = jsonData[i - 1].usersInitialMinimumYellowRandomCards
			sharedLocks[sharedLockNo, 1].usersInitialMinutes[lockedUserCount] = jsonData[i - 1].usersInitialMinutes
			sharedLocks[sharedLockNo, 1].usersInitialRedCards[lockedUserCount] = jsonData[i - 1].usersInitialRedCards
			sharedLocks[sharedLockNo, 1].usersInitialResetCards[lockedUserCount] = jsonData[i - 1].usersInitialResetCards
			sharedLocks[sharedLockNo, 1].usersInitialStickyCards[lockedUserCount] = jsonData[i - 1].usersInitialStickyCards
			sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 1] = jsonData[i - 1].usersInitialYellowCards[1]
			if (sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 1] < 0) then sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 1] = 0
			sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 2] = jsonData[i - 1].usersInitialYellowCards[2]
			if (sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 2] < 0) then sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 2] = 0
			sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 3] = jsonData[i - 1].usersInitialYellowCards[3]
			if (sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 3] < 0) then sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 3] = 0
			sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 4] = jsonData[i - 1].usersInitialYellowCards[4]
			if (sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 4] < 0) then sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 4] = 0
			sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 5] = jsonData[i - 1].usersInitialYellowCards[5]
			if (sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 5] < 0) then sharedLocks[sharedLockNo, 1].usersInitialYellowCards[lockedUserCount, 5] = 0
			sharedLocks[sharedLockNo, 1].usersKeyholderAllowsFreeUnlock[lockedUserCount] = jsonData[i - 1].usersKeyholderAllowsFreeUnlock
			sharedLocks[sharedLockNo, 1].usersKeyholderEmojiChosen[lockedUserCount] = jsonData[i - 1].usersKeyholderEmojiChosen
			sharedLocks[sharedLockNo, 1].usersKeyholderEmojiColourSelected[lockedUserCount] = jsonData[i - 1].usersKeyholderEmojiColourSelected
			if (sharedLocks[sharedLockNo, 1].usersKeyholderEmojiColourSelected[lockedUserCount] = 0) then sharedLocks[sharedLockNo, 1].usersKeyholderEmojiColourSelected[lockedUserCount] = 1
			sharedLocks[sharedLockNo, 1].usersKeysDisabled[lockedUserCount] = jsonData[i - 1].usersKeysDisabled
			sharedLocks[sharedLockNo, 1].usersLastActive[lockedUserCount] = jsonData[i - 1].usersLastActive
			sharedLocks[sharedLockNo, 1].usersLastUpdateIDSeen[lockedUserCount] = jsonData[i - 1].usersLastUpdateIDSeen
			sharedLocks[sharedLockNo, 1].usersLateCheckInWindowInSeconds[lockedUserCount] = jsonData[i - 1].usersLateCheckInWindowInSeconds
			sharedLocks[sharedLockNo, 1].usersLockBuildNumber[lockedUserCount] = jsonData[i - 1].usersLockBuildNumber
			sharedLocks[sharedLockNo, 1].usersLockFrozenByCard[lockedUserCount] = jsonData[i - 1].usersLockFrozenByCard
			sharedLocks[sharedLockNo, 1].usersLockFrozenByKeyholder[lockedUserCount] = jsonData[i - 1].usersLockFrozenByKeyholder
			sharedLocks[sharedLockNo, 1].usersLockID[lockedUserCount] = jsonData[i - 1].usersLockID
			sharedLocks[sharedLockNo, 1].usersMainRole[lockedUserCount] = jsonData[i - 1].usersMainRole
			if (sharedLocks[sharedLockNo, 1].usersMainRole[lockedUserCount] = 0) then sharedLocks[sharedLockNo, 1].usersMainRole[lockedUserCount] = 2
			sharedLocks[sharedLockNo, 1].usersMainRoleLevel[lockedUserCount] = jsonData[i - 1].usersMainRoleLevel
			if (sharedLocks[sharedLockNo, 1].usersMainRoleLevel[lockedUserCount] = 0) then sharedLocks[sharedLockNo, 1].usersMainRoleLevel[lockedUserCount] = 1
			sharedLocks[sharedLockNo, 1].usersMaxAutoResets[lockedUserCount] = jsonData[i - 1].usersMaxAutoResets
			sharedLocks[sharedLockNo, 1].usersMinutes[lockedUserCount] = jsonData[i - 1].usersMinutes
			sharedLocks[sharedLockNo, 1].usersNoOfKeyholders[lockedUserCount] = jsonData[i - 1].usersNoOfKeyholders
			sharedLocks[sharedLockNo, 1].usersNoOfRatingsFromKeyholders[lockedUserCount] = jsonData[i - 1].usersNoOfRatingsFromKeyholders
			sharedLocks[sharedLockNo, 1].usersNoOfTimesAutoReset[lockedUserCount] = jsonData[i - 1].usersNoOfTimesAutoReset
			sharedLocks[sharedLockNo, 1].usersNoOfTimesCardReset[lockedUserCount] = jsonData[i - 1].usersNoOfTimesCardReset
			sharedLocks[sharedLockNo, 1].usersNoOfTimesFullReset[lockedUserCount] = jsonData[i - 1].usersNoOfTimesFullReset
			sharedLocks[sharedLockNo, 1].usersNoOfTimesGreenCardRevealed[lockedUserCount] = jsonData[i - 1].usersNoOfTimesGreenCardRevealed
			sharedLocks[sharedLockNo, 1].usersNoOfTimesReset[lockedUserCount] = jsonData[i - 1].usersNoOfTimesReset
			sharedLocks[sharedLockNo, 1].usersPickedCount[lockedUserCount] = jsonData[i - 1].usersPickedCount
			sharedLocks[sharedLockNo, 1].usersPickedCountSinceReset[lockedUserCount] = jsonData[i - 1].usersPickedCountSinceReset
			sharedLocks[sharedLockNo, 1].usersOtherKeyholders$[lockedUserCount] = jsonData[i - 1].usersOtherKeyholders$
			sharedLocks[sharedLockNo, 1].usersReadyToUnlock[lockedUserCount] = jsonData[i - 1].usersReadyToUnlock
			sharedLocks[sharedLockNo, 1].usersRedCards[lockedUserCount] = jsonData[i - 1].usersRedCards
			if (sharedLocks[sharedLockNo, 1].usersRedCards[lockedUserCount] < 0) then sharedLocks[sharedLockNo, 1].usersRedCards[lockedUserCount] = 0
			if (sharedLocks[sharedLockNo, 1].usersRedCards[lockedUserCount] > cappedRedCards and sharedLocks[sharedLockNo, 0].fixed = 0) then sharedLocks[sharedLockNo, 1].usersRedCards[lockedUserCount] = cappedRedCards
			sharedLocks[sharedLockNo, 1].usersResetCards[lockedUserCount] = jsonData[i - 1].usersResetCards
			if (sharedLocks[sharedLockNo, 1].usersResetCards[lockedUserCount] < 0) then sharedLocks[sharedLockNo, 1].usersResetCards[lockedUserCount] = 0
			if (sharedLocks[sharedLockNo, 1].usersResetCards[lockedUserCount] > cappedResetCards) then sharedLocks[sharedLockNo, 1].usersResetCards[lockedUserCount] = cappedResetCards
			sharedLocks[sharedLockNo, 1].usersResetFrequencyInSeconds[lockedUserCount] = jsonData[i - 1].usersResetFrequencyInSeconds
			sharedLocks[sharedLockNo, 1].usersStatus[lockedUserCount] = jsonData[i - 1].usersStatus
			sharedLocks[sharedLockNo, 1].usersStickyCards[lockedUserCount] = jsonData[i - 1].usersStickyCards
			sharedLocks[sharedLockNo, 1].usersTestLock[lockedUserCount] = jsonData[i - 1].usersTestLock
			sharedLocks[sharedLockNo, 1].usersTimerHidden[lockedUserCount] = jsonData[i - 1].usersTimerHidden
			sharedLocks[sharedLockNo, 1].usersTimestampFrozenByCard[lockedUserCount] = jsonData[i - 1].usersTimestampFrozenByCard
			sharedLocks[sharedLockNo, 1].usersTimestampFrozenByKeyholder[lockedUserCount] = jsonData[i - 1].usersTimestampFrozenByKeyholder
			sharedLocks[sharedLockNo, 1].usersTimestampLastAutoReset[lockedUserCount] = jsonData[i - 1].usersTimestampLastAutoReset
			sharedLocks[sharedLockNo, 1].usersTimestampLastCardReset[lockedUserCount] = jsonData[i - 1].usersTimestampLastCardReset
			sharedLocks[sharedLockNo, 1].usersTimestampLastCheckedIn[lockedUserCount] = jsonData[i - 1].usersTimestampLastCheckedIn
			sharedLocks[sharedLockNo, 1].usersTimestampLastCheckedIn[lockedUserCount] = jsonData[i - 1].usersTimestampLastCheckedIn
			sharedLocks[sharedLockNo, 1].usersTimestampLastFullReset[lockedUserCount] = jsonData[i - 1].usersTimestampLastFullReset
			sharedLocks[sharedLockNo, 1].usersTimestampLastPicked[lockedUserCount] = jsonData[i - 1].usersTimestampLastPicked
			sharedLocks[sharedLockNo, 1].usersTimestampLastReset[lockedUserCount] = jsonData[i - 1].usersTimestampLastReset
			sharedLocks[sharedLockNo, 1].usersTimestampLastSynced[lockedUserCount] = jsonData[i - 1].usersTimestampLastSynced
			sharedLocks[sharedLockNo, 1].usersTimestampLastUpdated[lockedUserCount] = jsonData[i - 1].usersTimestampLastUpdated
			sharedLocks[sharedLockNo, 1].usersTimestampLocked[lockedUserCount] = jsonData[i - 1].usersTimestampLocked
			sharedLocks[sharedLockNo, 1].usersTimestampRealLastPicked[lockedUserCount] = jsonData[i - 1].usersTimestampRealLastPicked
			sharedLocks[sharedLockNo, 1].usersTimestampRequestedKeyholdersDecision[lockedUserCount] = jsonData[i - 1].usersTimestampRequestedKeyholdersDecision
			sharedLocks[sharedLockNo, 1].usersTimestampUnfreezes[lockedUserCount] = jsonData[i - 1].usersTimestampUnfreezes
			sharedLocks[sharedLockNo, 1].usersTimestampUnfrozen[lockedUserCount] = jsonData[i - 1].usersTimestampUnfrozen
			sharedLocks[sharedLockNo, 1].usersTotalTimeFrozen[lockedUserCount] = jsonData[i - 1].usersTotalTimeFrozen
			sharedLocks[sharedLockNo, 1].usersTrustKeyholder[lockedUserCount] = jsonData[i - 1].usersTrustKeyholder
			sharedLocks[sharedLockNo, 1].usersUnlocked[lockedUserCount] = jsonData[i - 1].usersUnlocked
			sharedLocks[sharedLockNo, 1].usersUsername$[lockedUserCount] = jsonData[i - 1].usersUsername$
			sharedLocks[sharedLockNo, 1].usersVersion$[lockedUserCount] = jsonData[i - 1].usersVersion$
			sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 1] = jsonData[i - 1].usersYellowCards[1]
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 1] < 0) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 1] = 0
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 1] > cappedYellowCardsEachType) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 1] = cappedYellowCardsEachType
			sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 2] = jsonData[i - 1].usersYellowCards[2]
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 2] < 0) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 2] = 0
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 2] > cappedYellowCardsEachType) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 2] = cappedYellowCardsEachType
			sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 3] = jsonData[i - 1].usersYellowCards[3]
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 3] < 0) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 3] = 0
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 3] > cappedYellowCardsEachType) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 3] = cappedYellowCardsEachType
			sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 4] = jsonData[i - 1].usersYellowCards[4]
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 4] < 0) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 4] = 0
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 4] > cappedYellowCardsEachType) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 4] = cappedYellowCardsEachType
			sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 5] = jsonData[i - 1].usersYellowCards[5]
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 5] < 0) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 5] = 0
			if (sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 5] > cappedYellowCardsEachType) then sharedLocks[sharedLockNo, 1].usersYellowCards[lockedUserCount, 5] = cappedYellowCardsEachType
		elseif (jsonData[i - 1].jsonNo = 2)
			inc sharedLocks[sharedLockNo, 2].noOfUsers
			unlockedUserCount = sharedLocks[sharedLockNo, 2].noOfUsers
			sharedLocks[sharedLockNo, 2].timestampLastSync = timestampNow
			sharedLocks[sharedLockNo, 2].usersAverageRatingFromKeyholders#[unlockedUserCount] = jsonData[i - 1].usersAverageRatingFromKeyholders#
			sharedLocks[sharedLockNo, 2].usersBuildNumberInstalled[unlockedUserCount] = jsonData[i - 1].usersBuildNumberInstalled
			sharedLocks[sharedLockNo, 2].usersCheckInFrequencyInSeconds[unlockedUserCount] = jsonData[i - 1].usersCheckInFrequencyInSeconds
			sharedLocks[sharedLockNo, 2].usersCombination$[unlockedUserCount] = jsonData[i - 1].usersCombination$
			sharedLocks[sharedLockNo, 2].usersDateLocked$[unlockedUserCount] = jsonData[i - 1].usersDateLocked$
			sharedLocks[sharedLockNo, 2].usersDateUnlocked$[unlockedUserCount] = jsonData[i - 1].usersDateUnlocked$
			sharedLocks[sharedLockNo, 2].usersID[unlockedUserCount] = jsonData[i - 1].usersID
			sharedLocks[sharedLockNo, 2].usersLastActive[unlockedUserCount] = jsonData[i - 1].usersLastActive
			sharedLocks[sharedLockNo, 2].usersLateCheckInWindowInSeconds[unlockedUserCount] = jsonData[i - 1].usersLateCheckInWindowInSeconds
			sharedLocks[sharedLockNo, 2].usersLockBuildNumber[unlockedUserCount] = jsonData[i - 1].usersLockBuildNumber
			sharedLocks[sharedLockNo, 2].usersLockID[unlockedUserCount] = jsonData[i - 1].usersLockID
			sharedLocks[sharedLockNo, 2].usersMainRole[unlockedUserCount] = jsonData[i - 1].usersMainRole
			if (sharedLocks[sharedLockNo, 2].usersMainRole[unlockedUserCount] = 0) then sharedLocks[sharedLockNo, 2].usersMainRole[unlockedUserCount] = 2
			sharedLocks[sharedLockNo, 2].usersMainRoleLevel[unlockedUserCount] = jsonData[i - 1].usersMainRoleLevel
			if (sharedLocks[sharedLockNo, 2].usersMainRoleLevel[unlockedUserCount] = 0) then sharedLocks[sharedLockNo, 2].usersMainRoleLevel[unlockedUserCount] = 1
			sharedLocks[sharedLockNo, 2].usersNoOfRatingsFromKeyholders[unlockedUserCount] = jsonData[i - 1].usersNoOfRatingsFromKeyholders
			sharedLocks[sharedLockNo, 2].usersRatingFromKeyholder[unlockedUserCount] = jsonData[i - 1].usersRatingFromKeyholder
			sharedLocks[sharedLockNo, 2].usersResetFrequencyInSeconds[unlockedUserCount] = jsonData[i - 1].usersResetFrequencyInSeconds
			sharedLocks[sharedLockNo, 2].usersStatus[unlockedUserCount] = jsonData[i - 1].usersStatus
			sharedLocks[sharedLockNo, 2].usersTestLock[unlockedUserCount] = jsonData[i - 1].usersTestLock
			sharedLocks[sharedLockNo, 2].usersTimestampKeyholderRated[unlockedUserCount] = jsonData[i - 1].usersTimestampKeyholderRated
			sharedLocks[sharedLockNo, 2].usersTimestampLastUpdated[unlockedUserCount] = jsonData[i - 1].usersTimestampLastUpdated
			sharedLocks[sharedLockNo, 2].usersTimestampLocked[unlockedUserCount] = jsonData[i - 1].usersTimestampLocked
			sharedLocks[sharedLockNo, 2].usersTimestampUnlocked[unlockedUserCount] = jsonData[i - 1].usersTimestampUnlocked
			sharedLocks[sharedLockNo, 2].usersUsedKey[unlockedUserCount] = jsonData[i - 1].usersUsedKey
			sharedLocks[sharedLockNo, 2].usersUsername$[unlockedUserCount] = jsonData[i - 1].usersUsername$
		elseif (jsonData[i - 1].jsonNo = 3)
			inc sharedLocks[sharedLockNo, 3].noOfUsers
			desertedUserCount = sharedLocks[sharedLockNo, 3].noOfUsers
			sharedLocks[sharedLockNo, 3].timestampLastSync = timestampNow
			sharedLocks[sharedLockNo, 3].usersAverageRatingFromKeyholders#[desertedUserCount] = jsonData[i - 1].usersAverageRatingFromKeyholders#
			sharedLocks[sharedLockNo, 3].usersBuildNumberInstalled[desertedUserCount] = jsonData[i - 1].usersBuildNumberInstalled
			sharedLocks[sharedLockNo, 3].usersCheckInFrequencyInSeconds[desertedUserCount] = jsonData[i - 1].usersCheckInFrequencyInSeconds
			sharedLocks[sharedLockNo, 3].usersCombination$[desertedUserCount] = jsonData[i - 1].usersCombination$
			sharedLocks[sharedLockNo, 3].usersDateDeleted$[desertedUserCount] = jsonData[i - 1].usersDateDeleted$
			sharedLocks[sharedLockNo, 3].usersDateLocked$[desertedUserCount] = jsonData[i - 1].usersDateLocked$
			sharedLocks[sharedLockNo, 3].usersID[desertedUserCount] = jsonData[i - 1].usersID
			sharedLocks[sharedLockNo, 3].usersLastActive[desertedUserCount] = jsonData[i - 1].usersLastActive
			sharedLocks[sharedLockNo, 3].usersLateCheckInWindowInSeconds[desertedUserCount] = jsonData[i - 1].usersLateCheckInWindowInSeconds
			sharedLocks[sharedLockNo, 3].usersLockBuildNumber[desertedUserCount] = jsonData[i - 1].usersLockBuildNumber
			sharedLocks[sharedLockNo, 3].usersLockID[desertedUserCount] = jsonData[i - 1].usersLockID
			sharedLocks[sharedLockNo, 3].usersMainRole[desertedUserCount] = jsonData[i - 1].usersMainRole
			if (sharedLocks[sharedLockNo, 3].usersMainRole[desertedUserCount] = 0) then sharedLocks[sharedLockNo, 3].usersMainRole[desertedUserCount] = 2
			sharedLocks[sharedLockNo, 3].usersMainRoleLevel[desertedUserCount] = jsonData[i - 1].usersMainRoleLevel
			if (sharedLocks[sharedLockNo, 3].usersMainRoleLevel[desertedUserCount] = 0) then sharedLocks[sharedLockNo, 3].usersMainRoleLevel[desertedUserCount] = 1
			sharedLocks[sharedLockNo, 3].usersNoOfRatingsFromKeyholders[desertedUserCount] = jsonData[i - 1].usersNoOfRatingsFromKeyholders
			sharedLocks[sharedLockNo, 3].usersRatingFromKeyholder[desertedUserCount] = jsonData[i - 1].usersRatingFromKeyholder
			sharedLocks[sharedLockNo, 3].usersResetFrequencyInSeconds[desertedUserCount] = jsonData[i - 1].usersResetFrequencyInSeconds
			sharedLocks[sharedLockNo, 3].usersStatus[desertedUserCount] = jsonData[i - 1].usersStatus
			sharedLocks[sharedLockNo, 3].usersTestLock[desertedUserCount] = jsonData[i - 1].usersTestLock
			sharedLocks[sharedLockNo, 3].usersTimestampDeleted[desertedUserCount] = jsonData[i - 1].usersTimestampDeleted
			sharedLocks[sharedLockNo, 3].usersTimestampKeyholderRated[desertedUserCount] = jsonData[i - 1].usersTimestampKeyholderRated
			sharedLocks[sharedLockNo, 3].usersTimestampLastUpdated[desertedUserCount] = jsonData[i - 1].usersTimestampLastUpdated
			sharedLocks[sharedLockNo, 3].usersTimestampLocked[desertedUserCount] = jsonData[i - 1].usersTimestampLocked
			sharedLocks[sharedLockNo, 3].usersUsername$[desertedUserCount] = jsonData[i - 1].usersUsername$
		endif
	next
	if (usersTab = 1)
		sharedLocks[sharedLockNo, 0].fakeLockedUsers = fakeLockedUsers
		sharedLocks[sharedLockNo, 0].lockedUsers = sharedLocks[sharedLockNo, 1].noOfUsers
	endif
	if (usersTab = 2) then sharedLocks[sharedLockNo, 0].unlockedUsers = sharedLocks[sharedLockNo, 2].noOfUsers
	if (usersTab = 3) then sharedLocks[sharedLockNo, 0].desertedUsers = sharedLocks[sharedLockNo, 3].noOfUsers
	UpdateAccount(0)
endfunction

function ReceivedUpdateLocksDatabaseResponse(lockNo)
	jsonData.length = -1
	if (OryUIGetHTTPSQueueRequestResponse(httpsQueue) <> "")
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	if (val(GetJSONDataVariableValue("lastInsertID")) > 0 or locks[lockNo].rowInDB > 0)
		if (val(GetJSONDataVariableValue("lastInsertID")) > 0) then locks[lockNo].rowInDB = val(GetJSONDataVariableValue("lastInsertID"))
		if (val(GetJSONDataVariableValue("timestampLastSynced")) > 0)
			locks[lockNo].timestampLastSynced = val(GetJSONDataVariableValue("timestampLastSynced"))
			UpdateLocksData(lockNo)
		else
			UpdateLocksData(lockNo)
			UpdateLocksDatabase(lockNo, "", 0)
		endif
	endif
	endif
endfunction
	
function ReceivedUpdateUsersLock(sharedLockNo, usersTab, userNo)
	sharedLocks[sharedLockNo, usersTab].usersCumulative[userNo] = sharedLocks[sharedLockNo, usersTab].usersCumulative[userNo] + sharedLocks[sharedLockNo, usersTab].usersCumulativeModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersDoubleUpCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersDoubleUpCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersDoubleUpCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersFreezeCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersFreezeCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersFreezeCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersGreenCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersGreenCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersGreenCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersMinutes[userNo] = sharedLocks[sharedLockNo, usersTab].usersMinutes[userNo] + sharedLocks[sharedLockNo, usersTab].usersMinutesModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersRedCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersRedCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersRedCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersResetCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersResetCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersResetCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersStickyCards[userNo] = sharedLocks[sharedLockNo, usersTab].usersStickyCards[userNo] + sharedLocks[sharedLockNo, usersTab].usersStickyCardsModifiedBy[userNo]
	sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 1] = sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 1] + sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 1]
	sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 2] = sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 2] + sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 2]
	sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 3] = sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 3] + sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 3]
	sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 4] = sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 4] + sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 4]
	sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 5] = sharedLocks[sharedLockNo, usersTab].usersYellowCards[userNo, 5] + sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 5]
	ResetModifiedByCounts(sharedLockNo, usersTab, userNo)
endfunction

function ReceivedUserLogData(sharedLockNo, userNo, usersTab)
	local a as integer
	local lastLogID as integer
	local logRow as integer
	
	sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length = -1
	lastLogID = 0

	jsonData as typeLog[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for a = 1 to jsonData.length + 1
		if (jsonData[a - 1].id > lastLogID or lastLogID = 0)
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length = sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length + 1
			logRow = sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].action$ = jsonData[a - 1].action$
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].actionedBy$ = jsonData[a - 1].actionedBy$
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].hidden = jsonData[a - 1].hidden
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].id = jsonData[a - 1].id
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].lockID = jsonData[a - 1].lockID
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].private = jsonData[a - 1].private
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].result$ = jsonData[a - 1].result$
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].timestamp = jsonData[a - 1].timestamp
			sharedLocks[sharedLockNo, usersTab].usersLog[userNo, logRow].totalActionTime = jsonData[a - 1].totalActionTime
		endif
	next
endfunction

function ReceivedYourRelations()
	local blockedByOthersID as integer
	local blockedByYouID as integer
	local followersID as integer
	local followingID as integer
	local i as integer
	local pendingByOthersID as integer
	local pendingByYouID as integer
	
	jsonData as typeFriend[]
	jsonData.fromJSON(OryUIGetHTTPSQueueRequestResponse(httpsQueue))
	for i = 1 to jsonData.length + 1
		if (jsonData[i - 1].jsonNo = 1)
			yourFriends.blockedByOthers.length = yourFriends.blockedByOthers.length + 1
			blockedByOthersID = yourFriends.blockedByOthers.length
			yourFriends.blockedByOthers[blockedByOthersID].id = jsonData[i - 1].id
			yourFriends.blockedByOthersDelimitedIDs$ = yourFriends.blockedByOthersDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			yourFriends.blockedByOthers[blockedByOthersID].iteration = blockedByOthersID
			yourFriends.blockedByOthers[blockedByOthersID].discordID$ = jsonData[i - 1].discordID$
			yourFriends.blockedByOthers[blockedByOthersID].keyholderLevel = jsonData[i - 1].keyholderLevel
			yourFriends.blockedByOthers[blockedByOthersID].lockeeLevel = jsonData[i - 1].lockeeLevel
			yourFriends.blockedByOthers[blockedByOthersID].mainRole = jsonData[i - 1].mainRole
			yourFriends.blockedByOthers[blockedByOthersID].onlineStatus = jsonData[i - 1].onlineStatus
			yourFriends.blockedByOthers[blockedByOthersID].relationStatus = jsonData[i - 1].relationStatus
			yourFriends.blockedByOthers[blockedByOthersID].timestampLastActive = jsonData[i - 1].timestampLastActive
			yourFriends.blockedByOthers[blockedByOthersID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			yourFriends.blockedByOthers[blockedByOthersID].username$ = jsonData[i - 1].username$
		elseif (jsonData[i - 1].jsonNo = 2)
			yourFriends.blockedByYou.length = yourFriends.blockedByYou.length + 1
			blockedByYouID = yourFriends.blockedByYou.length
			yourFriends.blockedByYou[blockedByYouID].id = jsonData[i - 1].id
			yourFriends.blockedByYouDelimitedIDs$ = yourFriends.blockedByYouDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			yourFriends.blockedByYou[blockedByYouID].iteration = blockedByYouID
			yourFriends.blockedByYou[blockedByYouID].discordID$ = jsonData[i - 1].discordID$
			yourFriends.blockedByYou[blockedByYouID].keyholderLevel = jsonData[i - 1].keyholderLevel
			yourFriends.blockedByYou[blockedByYouID].lockeeLevel = jsonData[i - 1].lockeeLevel
			yourFriends.blockedByYou[blockedByYouID].mainRole = jsonData[i - 1].mainRole
			yourFriends.blockedByYou[blockedByYouID].onlineStatus = jsonData[i - 1].onlineStatus
			yourFriends.blockedByYou[blockedByYouID].relationStatus = jsonData[i - 1].relationStatus
			yourFriends.blockedByYou[blockedByYouID].timestampLastActive = jsonData[i - 1].timestampLastActive
			yourFriends.blockedByYou[blockedByYouID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			yourFriends.blockedByYou[blockedByYouID].username$ = jsonData[i - 1].username$
		elseif (jsonData[i - 1].jsonNo = 3)
			yourFriends.pendingByOthers.length = yourFriends.pendingByOthers.length + 1
			pendingByOthersID = yourFriends.pendingByOthers.length
			yourFriends.pendingByOthers[pendingByOthersID].id = jsonData[i - 1].id
			yourFriends.pendingByOthersDelimitedIDs$ = yourFriends.pendingByOthersDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			yourFriends.pendingByOthers[pendingByOthersID].iteration = pendingByOthersID
			yourFriends.pendingByOthers[pendingByOthersID].discordID$ = jsonData[i - 1].discordID$
			yourFriends.pendingByOthers[pendingByOthersID].keyholderLevel = jsonData[i - 1].keyholderLevel
			yourFriends.pendingByOthers[pendingByOthersID].lockeeLevel = jsonData[i - 1].lockeeLevel
			yourFriends.pendingByOthers[pendingByOthersID].mainRole = jsonData[i - 1].mainRole
			yourFriends.pendingByOthers[pendingByOthersID].onlineStatus = jsonData[i - 1].onlineStatus
			yourFriends.pendingByOthers[pendingByOthersID].relationStatus = jsonData[i - 1].relationStatus
			yourFriends.pendingByOthers[pendingByOthersID].timestampLastActive = jsonData[i - 1].timestampLastActive
			yourFriends.pendingByOthers[pendingByOthersID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			yourFriends.pendingByOthers[pendingByOthersID].username$ = jsonData[i - 1].username$
		elseif (jsonData[i - 1].jsonNo = 4)
			if (FindRelation("blockedByYou", jsonData[i - 1].id) = 0)
				yourFriends.pendingByYou.length = yourFriends.pendingByYou.length + 1
				pendingByYouID = yourFriends.pendingByYou.length
				yourFriends.pendingByYou[pendingByYouID].id = jsonData[i - 1].id
				yourFriends.pendingByYouDelimitedIDs$ = yourFriends.pendingByYouDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
				yourFriends.pendingByYou[pendingByYouID].iteration = pendingByYouID
				yourFriends.pendingByYou[pendingByYouID].discordID$ = jsonData[i - 1].discordID$
				yourFriends.pendingByYou[pendingByYouID].keyholderLevel = jsonData[i - 1].keyholderLevel
				yourFriends.pendingByYou[pendingByYouID].lockeeLevel = jsonData[i - 1].lockeeLevel
				yourFriends.pendingByYou[pendingByYouID].mainRole = jsonData[i - 1].mainRole
				yourFriends.pendingByYou[pendingByYouID].onlineStatus = jsonData[i - 1].onlineStatus
				yourFriends.pendingByYou[pendingByYouID].relationStatus = jsonData[i - 1].relationStatus
				yourFriends.pendingByYou[pendingByYouID].timestampLastActive = jsonData[i - 1].timestampLastActive
				yourFriends.pendingByYou[pendingByYouID].twitterHandle$ = jsonData[i - 1].twitterHandle$
				yourFriends.pendingByYou[pendingByYouID].username$ = jsonData[i - 1].username$
			endif
		elseif (jsonData[i - 1].jsonNo = 5)
			yourFriends.followers.length = yourFriends.followers.length + 1
			followersID = yourFriends.followers.length
			yourFriends.followers[followersID].id = jsonData[i - 1].id
			yourFriends.followersDelimitedIDs$ = yourFriends.followersDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			yourFriends.followers[followersID].iteration = followersID
			yourFriends.followers[followersID].discordID$ = jsonData[i - 1].discordID$
			yourFriends.followers[followersID].keyholderLevel = jsonData[i - 1].keyholderLevel
			yourFriends.followers[followersID].lockeeLevel = jsonData[i - 1].lockeeLevel
			yourFriends.followers[followersID].mainRole = jsonData[i - 1].mainRole
			yourFriends.followers[followersID].onlineStatus = jsonData[i - 1].onlineStatus
			yourFriends.followers[followersID].relationStatus = jsonData[i - 1].relationStatus
			yourFriends.followers[followersID].timestampLastActive = jsonData[i - 1].timestampLastActive
			yourFriends.followers[followersID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			yourFriends.followers[followersID].username$ = jsonData[i - 1].username$
		elseif (jsonData[i - 1].jsonNo = 6)
			yourFriends.following.length = yourFriends.following.length + 1
			followingID = yourFriends.following.length
			yourFriends.following[followingID].id = jsonData[i - 1].id
			yourFriends.followingDelimitedIDs$ = yourFriends.followingDelimitedIDs$ + "|" + str(jsonData[i - 1].id) + "|"
			yourFriends.following[followingID].iteration = followingID
			yourFriends.following[followingID].discordID$ = jsonData[i - 1].discordID$
			yourFriends.following[followingID].keyholderLevel = jsonData[i - 1].keyholderLevel
			yourFriends.following[followingID].lockeeLevel = jsonData[i - 1].lockeeLevel
			yourFriends.following[followingID].mainRole = jsonData[i - 1].mainRole
			yourFriends.following[followingID].onlineStatus = jsonData[i - 1].onlineStatus
			yourFriends.following[followingID].relationStatus = jsonData[i - 1].relationStatus
			yourFriends.following[followingID].timestampLastActive = jsonData[i - 1].timestampLastActive
			yourFriends.following[followingID].twitterHandle$ = jsonData[i - 1].twitterHandle$
			yourFriends.following[followingID].username$ = jsonData[i - 1].username$
		endif
	next
endfunction

function ReformatDateString(inputDate$, inputFormat$, outputFormat$)
	local inputDD$ as string
	local inputMM$ as string
	local inputYY$ as string
	local outputD$ as string
	local outputM$ as string
	local outputDate$ as string
	
	outputDate$ = inputDate$
	if (inputFormat$ = "DD/MM/YYYY")
		inputDD$ = Mid(inputDate$, 1, 2)
		inputMM$ = Mid(inputDate$, 4, 2)
		inputYY$ = Mid(inputDate$, 7, 4)
	endif
	if (inputFormat$ = "MM/DD/YYYY")
		inputDD$ = Mid(inputDate$, 4, 2)
		inputMM$ = Mid(inputDate$, 1, 2)
		inputYY$ = Mid(inputDate$, 7, 4)
	endif
	if (outputFormat$ = "DD/MM/YYYY") then outputDate$ = inputDD$ + "/" + inputMM$ + "/" + inputYY$
	if (outputFormat$ = "MM/DD/YYYY") then outputDate$ = inputMM$ + "/" + inputDD$ + "/" + inputYY$
	if (outputFormat$ = "D M YYYY")
		outputD$ = AddOrdinalSuffix(val(inputDD$))
		if (inputMM$ = "01") then outputM$ = "January"
		if (inputMM$ = "02") then outputM$ = "February"
		if (inputMM$ = "03") then outputM$ = "March"
		if (inputMM$ = "04") then outputM$ = "April"
		if (inputMM$ = "05") then outputM$ = "May"
		if (inputMM$ = "06") then outputM$ = "June"
		if (inputMM$ = "07") then outputM$ = "July"
		if (inputMM$ = "08") then outputM$ = "August"
		if (inputMM$ = "09") then outputM$ = "September"
		if (inputMM$ = "10") then outputM$ = "October"
		if (inputMM$ = "11") then outputM$ = "November"
		if (inputMM$ = "12") then outputM$ = "December"
		outputDate$ = outputD$ + " " + outputM$ + " " + inputYY$
	endif
endfunction outputDate$

function RemoveCardFromSimulationDeck(index)
	if (index > -1)
		if (simulationDeck$[index] = "DoubleUp")
			dec simulationNoOfDoubleUps
		elseif (simulationDeck$[index] = "Freeze")
			dec simulationNoOfFreezes
		elseif (simulationDeck$[index] = "Green")
			dec simulationNoOfGreens
		elseif (simulationDeck$[index] = "Red")
			dec simulationNoOfReds
		elseif (simulationDeck$[index] = "Reset")
			dec simulationNoOfResets
		elseif (simulationDeck$[index] = "Sticky")
			dec simulationNoOfStickies
		elseif (simulationDeck$[index] = "YellowAdd1")
			dec simulationNoOfYellows
			dec simulationNoOfYellowsAdd1
		elseif (simulationDeck$[index] = "YellowAdd2")
			dec simulationNoOfYellows
			dec simulationNoOfYellowsAdd2
		elseif (simulationDeck$[index] = "YellowAdd3")
			dec simulationNoOfYellows
			dec simulationNoOfYellowsAdd3
		elseif (simulationDeck$[index] = "YellowMinus1")
			dec simulationNoOfYellows
			dec simulationNoOfYellowsMinus1
		elseif (simulationDeck$[index] = "YellowMinus2")
			dec simulationNoOfYellows
			dec simulationNoOfYellowsMinus2
		endif
		simulationDeck$.remove(index)
	endif
endfunction

function RemoveLastBreadcrumb()
	if (breadcrumbs.length >= 0) then breadcrumbs.remove()
endfunction

function RemoveUserFromLock(sharedLockNo, usersTab, userNo, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	postData$ = ""
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, usersTab].usersLockID[userNo])
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&removeUserFromLock=1"
	postData$ = postData$ + "&sharedID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&sharedUserID=" + str(sharedLocks[sharedLockNo, usersTab].usersID[userNo])
	postData$ = postData$ + "&timestampModified=" + str(timestampNow)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:RemoveUserFromLock=" + str(sharedLockNo) + "," + str(userNo) + "," + str(usersTab) + ";script:" + URLs[0].URLPath + "/" + URLs[0].RemoveUserFromLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))					
endfunction

function RequestPushNotificationToken()
	if (pushNotificationToken$ = "" and notificationsOn <> 2)
		if (secondsRunning >= timeUntilNextPushRequest)
			pushNotificationResult = PushNotificationSetup()
			if (pushNotificationResult = 1)
				pushNotificationToken$ = GetPushNotificationToken()
				if (pushNotificationToken$ <> "") then UpdateAccount(0)
			endif
			timeUntilNextPushRequest = secondsRunning + random(3, 8)
		endif
	endif
endfunction

function ResetAllNotifications()
	local a as integer
	local b as integer
	local lastTimestamp as integer
	local noOfAutoResetsLeft as integer
	local noOfAutoResetsPassedSinceLast as integer
	local secondsLeft as integer
	local secondsSinceLastReset as integer
	local secondsLeftUntilAutoReset as integer
	
	for a = 1 to 40
		CancelLocalNotification(a)
	next
	timestampNow = timestampFromServer + GetSeconds()
	for a = 1 to 20
		if (locks[a].id = 0) then continue
		if (locks[a].unlocked = 1) then continue
		if (locks[a].readyToUnlock = 1) then continue
		if (notificationsOn = 2) then continue
		if (statusSelected = 3) then continue
		
		// AUTO RESET
		if (locks[a].fixed = 0)
			secondsLeftUntilAutoReset = 0
			if (locks[a].timestampLastAutoReset > 0 or locks[a].timestampLastFullReset > 0)
				secondsSinceLastReset = timestampNow - MaxInt(locks[a].timestampLastAutoReset, locks[a].timestampLastFullReset)
			else
				secondsSinceLastReset = timestampNow - locks[a].timestampLocked
			endif
			if (locks[a].resetFrequencyInSeconds > 0)
				noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / locks[a].resetFrequencyInSeconds)		
				noOfAutoResetsLeft = locks[a].maximumAutoResets - locks[a].noOfTimesAutoReset - noOfAutoResetsPassedSinceLast
				if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
				secondsLeftUntilAutoReset = locks[a].resetFrequencyInSeconds - secondsSinceLastReset
				if (noOfAutoResetsLeft <= 0) then secondsLeftUntilAutoReset = 0
			endif
			if (secondsLeftUntilAutoReset > 0 and locks[a].autoResetsPaused = 0)
				if (noOfLocks = 1)
					SetLocalNotification(a + 20, GetUnixTime() + secondsLeftUntilAutoReset, "Your lock has auto reset.")
				else
					SetLocalNotification(a + 20, GetUnixTime() + secondsLeftUntilAutoReset, "One of your locks has auto reset.")
				endif
			endif
		endif
		
		if (locks[a].lockFrozenByCard = 1) then continue
		if (locks[a].lockFrozenByKeyholder = 1) then continue
		
		if (locks[a].fixed = 0)
			// LAST PICKED
			secondsLeft = 0
			if (locks[a].timestampUnfrozen >= locks[a].timestampLastPicked)
				secondsLeft = 0
			else
				lastTimestamp = locks[a].timestampLastPicked
				if (locks[a].regularity# = 0.016667) then secondsLeft = (lastTimestamp + 60) - timestampNow
				if (locks[a].regularity# = 0.25) then secondsLeft = (lastTimestamp + 900) - timestampNow
				if (locks[a].regularity# = 0.5) then secondsLeft = (lastTimestamp + 1800) - timestampNow
				if (locks[a].regularity# = 1) then secondsLeft = (lastTimestamp + 3600) - timestampNow
				if (locks[a].regularity# = 3) then secondsLeft = (lastTimestamp + 10800) - timestampNow
				if (locks[a].regularity# = 6) then secondsLeft = (lastTimestamp + 21600) - timestampNow
				if (locks[a].regularity# = 12) then secondsLeft = (lastTimestamp + 43200) - timestampNow
				if (locks[a].regularity# = 24) then secondsLeft = (lastTimestamp + 86400) - timestampNow
			endif
			if (locks[a].pickedCount = 0) then secondsLeft = 0
			if (secondsLeft > 0)
				if (noOfLocks = 1)
					SetLocalNotification(a, GetUnixTime() + secondsLeft, "Your lock is ready for you to try again.")
				else
					SetLocalNotification(a, GetUnixTime() + secondsLeft, "One of your locks is ready to try again.")
				endif
			endif
		endif
		if (locks[a].fixed = 1)
			if (locks[a].lockFrozenByKeyholder = 1)
				secondsLeft = 0
			else
				// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
				if (locks[a].regularity# = 0.016667) then secondsLeft = (locks[a].timestampLocked + locks[a].totalTimeFrozen + (60 * locks[a].minutes)) - timestampNow
				// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
				if (locks[a].regularity# = 0.25) then secondsLeft = (locks[a].timestampLocked + locks[a].totalTimeFrozen + (900 * locks[a].redCards)) - timestampNow
				if (locks[a].regularity# = 1) then secondsLeft = (locks[a].timestampLocked + locks[a].totalTimeFrozen + (3600 * locks[a].redCards)) - timestampNow
				if (locks[a].regularity# = 24) then secondsLeft = (locks[a].timestampLocked + locks[a].totalTimeFrozen + (86400 * locks[a].redCards)) - timestampNow
			endif
			if (secondsLeft > 0)
				if (noOfLocks = 1)
					SetLocalNotification(a, GetUnixTime() + secondsLeft, "Your lock is due to unlock. Open to view it's status.")
				else
					SetLocalNotification(a, GetUnixTime() + secondsLeft, "One of your locks is due to unlock. Open to view it's status.")
				endif
			endif
		endif
	next
	for a = 1 to 40
		if (GetLocalNotificationTime(a) > 0)
			for b = 1 to 40
				if (GetLocalNotificationTime(b) = GetLocalNotificationTime(a) and b <> a)
					CancelLocalNotification(b)
				endif
			next
		endif
	next
endfunction

function ResetAPIClientSecret(index, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&clientID=" + apiProjects[index].clientID$
	postData$ = postData$ + "&clientSecret=" + apiProjects[index].clientSecret$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:ResetAPIClientSecret=" + str(index) + ";script:" + URLs[0].URLPath + "/" + URLs[0].ResetAPIClientSecret + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function ResetData()
	ResetLockData()
	ResetHiddenAlerts()
	adsRemoved = 0
	SaveLocalVariable("adsRemoved", str(adsRemoved))
	banned = 0
	SaveLocalVariable("banned", str(banned))
	cardAnimationsOn = 1
	SaveLocalVariable("cardAnimationsOn", str(cardAnimationsOn))
	defaultUsername$ = ""
	discordDiscriminator = 0
	SaveLocalVariable("discordDiscriminator", str(discordDiscriminator))
	discordID$ = ""
	SaveLocalVariable("discordID", discordID$)
	discordUsername$ = ""
	SaveLocalVariable("discordUsername", discordUsername$)
	keyholderLevel = 1
	SaveLocalVariable("keyholderLevel", str(keyholderLevel))
	lockeeLevel = 1
	SaveLocalVariable("lockeeLevel", str(lockeeLevel))
	mainRoleSelected = 2
	SaveLocalVariable("mainRoleSelected", str(mainRoleSelected))
	noOfKeys = 0
	SaveLocalVariable("noOfKeys", str(noOfKeys))
	noOfKeysPurchased = 0
	SaveLocalVariable("noOfKeysPurchased", str(noOfKeysPurchased))
	noOfLocksNaturallyUnlocked = 0
	SaveLocalVariable("noOfLocksNaturallyUnlocked", str(noOfLocksNaturallyUnlocked))
	//noOfSharedLocks = 0
	//SaveLocalVariable("noOfSharedLocksLastSession", str(noOfSharedLocks))
	notificationsOn = 1
	SaveLocalVariable("notificationsOn", str(notificationsOn))
	privateProfile = 0
	SaveLocalVariable("privateProfile", str(privateProfile))
	reasonBanned$ = ""
	showCombinationsToKeyholders = 0
	SaveLocalVariable("showCombinationsToKeyholders", str(showCombinationsToKeyholders))
	statusSelected = 1
	SaveLocalVariable("statusSelected", str(statusSelected))
	themeSelected = 2
	SaveLocalVariable("themeSelected", str(themeSelected))
	timesReviewBoxShown = 0
	SaveLocalVariable("timesReviewBoxShown", str(timesReviewBoxShown))
	twitterHandle$ = ""
	SaveLocalVariable("twitterHandle", twitterHandle$)
	userDBRow = 0
	SaveLocalVariable("userDBRow", str(userDBRow))
	userID$ = ""
	SaveLocalVariable("userID", userID$)
	username$ = ""
	SaveLocalVariable("username", username$)
	visibleInPublicStats = 0
	SaveLocalVariable("visibleInPublicStats", str(visibleInPublicStats))
endfunction

function ResetHiddenAlerts()
	local tmpVersionNumber$ as string
	
	accept20200516TermsAlertHidden = 0
	SaveLocalVariable("accept20200516TermsAlertHidden", str(accept20200516TermsAlertHidden))
	add1DoubleUpCardAlertHidden = 0
	SaveLocalVariable("add1DoubleUpCardAlertHidden", str(add1DoubleUpCardAlertHidden))
	add1FreezeCardAlertHidden = 0
	SaveLocalVariable("add1FreezeCardAlertHidden", str(add1FreezeCardAlertHidden))
	add1RandomYellowCardAlertHidden = 0
	SaveLocalVariable("add1RandomYellowCardAlertHidden", str(add1RandomYellowCardAlertHidden))
	add1RedCardAlertHidden = 0
	SaveLocalVariable("add1RedCardAlertHidden", str(add1RedCardAlertHidden))
	add1ResetCardAlertHidden = 0
	SaveLocalVariable("add1ResetCardAlertHidden", str(add1ResetCardAlertHidden))
	add1StickyCardAlertHidden = 0
	SaveLocalVariable("add1StickyCardAlertHidden", str(add1StickyCardAlertHidden))
	add1To4RedCardsAlertHidden = 0
	SaveLocalVariable("add1To4RedCardsAlertHidden", str(add1To4RedCardsAlertHidden))
	add2RedCardsAlertHidden = 0
	SaveLocalVariable("add2RedCardsAlertHidden", str(add2RedCardsAlertHidden))
	add3RedCardsAlertHidden = 0
	SaveLocalVariable("add3RedCardsAlertHidden", str(add3RedCardsAlertHidden))
	bannedAlertHidden = 0
	SaveLocalVariable("bannedAlertHidden", str(bannedAlertHidden))
	tmpVersionNumber$ = ReplaceString(constVersionNumber$, " ", "_", -1)
	tmpVersionNumber$ = ReplaceString(tmpVersionNumber$, ".", "_", -1)		
	SaveLocalVariable("deactivatingVersionAlertHidden_v" + tmpVersionNumber$, "0")
	durationMayChangeAlertHidden = 0
	SaveLocalVariable("durationMayChangeAlertHidden", str(durationMayChangeAlertHidden))
	freezeLockAlertHidden = 0
	SaveLocalVariable("freezeLockAlertHidden", str(freezeLockAlertHidden))
	hideCardInfoAlertHidden = 0
	SaveLocalVariable("hideCardInfoAlertHidden", str(hideCardInfoAlertHidden))
	hideTimerAlertHidden = 0
	SaveLocalVariable("hideTimerAlertHidden", str(hideTimerAlertHidden))
	logoutAlertHidden = 0
	SaveLocalVariable("logoutAlertHidden", str(logoutAlertHidden))
	newFixedLockAlertHidden = 0
	SaveLocalVariable("newFixedLockAlertHidden", str(newFixedLockAlertHidden))
	newVariableLockAlertHidden = 0
	SaveLocalVariable("newVariableLockAlertHidden", str(newVariableLockAlertHidden))
	saveYourUserIDAlertHidden = 0
	SaveLocalVariable("saveYourUserIDAlertHidden", str(saveYourUserIDAlertHidden))
endfunction

function ResetLockData()
	local a as integer
	local fileID as integer
	
	if (GetFileExists("locksV2.txt"))
		fileID = OpenToRead("locksV2.txt")
		for a = 1 to 20
			DeleteFile("ID" + str(ReadInteger(fileID)) + "V2.txt")
			locks[a].id = 0
		next
		CloseFile(fileID)
	endif
	DeleteFile("locksV2.txt")
	lastLockID = 0
	noOfLocks = 0
	SaveLocalVariable("noOfLocks", str(noOfLocks))
	noOfSharedLocks = 0
	SaveLocalVariable("noOfSharedLocks", str(noOfSharedLocks))
endfunction

function ResetModifiedByCounts(sharedLockNo, usersTab, userNo)
	sharedLocks[sharedLockNo, usersTab].usersAutoResetsPausedModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersCardInfoHiddenModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersCumulativeModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersDoubleUpCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersFreezeCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersGreenCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersLockFrozenByKeyholderModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersMinutesModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersRedCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersReset[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersResetCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersStickyCardsModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersTimerHiddenModifiedBy[userNo] = 0
	sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 1] = 0
	sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 2] = 0
	sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 3] = 0
	sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 4] = 0
	sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 5] = 0
endfunction

function ResetNewLockOptions()
	OryUIUpdateInputSpinner(spinMinNumberOfDays, "inputText:0")
	OryUIUpdateInputSpinner(spinMinNumberOfHours, "inputText:1")
	OryUIUpdateInputSpinner(spinMinNumberOfMinutes, "inputText:0")
	OryUIUpdateInputSpinner(spinMaxNumberOfDays, "inputText:0")
	OryUIUpdateInputSpinner(spinMaxNumberOfHours, "inputText:1")
	OryUIUpdateInputSpinner(spinMaxNumberOfMinutes, "inputText:0")
	OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)
endfunction

function ResizeCard(id, width#, height#)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.1)
	SetTweenSpriteSizeX(cards[id].tweenSprite[1], GetSpriteWidth(cards[id].sprite), width#, TweenLinear())
	SetTweenSpriteSizeY(cards[id].tweenSprite[1], GetSpriteHeight(cards[id].sprite), height#, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while(GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite) = 1)
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
endfunction

function RestoreAccount(restoreUserID$, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&restoreUserID1=" + restoreUserID$
	postData$ = postData$ + "&restoreUserID2=" + restoreUserID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:RestoreAccount=" + restoreUserID$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].RestoreAccount + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function RestoreDeletedMyLock(deletedLockNo)
	local a as integer
	local fileID as integer
	local lockNo as integer
	local minutesDeleted as integer
	local secondsBetweenLastPickedAndDeleted as integer
	
	GetLocksData()
	inc noOfLocks
	SaveLocalVariable("noOfLocks", str(noOfLocks))
	lockNo = noOfLocks
	
	locks[lockNo].autoResetsPaused = locksDeleted.myLocks[deletedLockNo].autoResetsPaused
	locks[lockNo].blockBotFromUnlocking = locksDeleted.myLocks[deletedLockNo].blockBotFromUnlocking
	locks[lockNo].blockUsersAlreadyLocked = locksDeleted.myLocks[deletedLockNo].blockUsersAlreadyLocked
	locks[lockNo].botChosen = locksDeleted.myLocks[deletedLockNo].botChosen
	locks[lockNo].build = locksDeleted.myLocks[deletedLockNo].build
	locks[lockNo].cardInfoHidden = locksDeleted.myLocks[deletedLockNo].cardInfoHidden
	locks[lockNo].chancesAccumulatedBeforeFreeze = locksDeleted.myLocks[deletedLockNo].chancesAccumulatedBeforeFreeze
	locks[lockNo].checkInFrequencyInSeconds = locksDeleted.myLocks[deletedLockNo].checkInFrequencyInSeconds
	locks[lockNo].combination$ = locksDeleted.myLocks[deletedLockNo].combination$
	locks[lockNo].cumulative = locksDeleted.myLocks[deletedLockNo].cumulative
	locks[lockNo].dateDeleted$ = ""
	locks[lockNo].dateLastPicked$ = locksDeleted.myLocks[deletedLockNo].dateLastPicked$
	locks[lockNo].dateLocked$ = locksDeleted.myLocks[deletedLockNo].dateLocked$
	locks[lockNo].dateUnlocked$ = locksDeleted.myLocks[deletedLockNo].dateUnlocked$
	locks[lockNo].deleting = 0
	locks[lockNo].deleted = 0
	locks[lockNo].discardPile$ = locksDeleted.myLocks[deletedLockNo].discardPile$
	locks[lockNo].displayInStats = locksDeleted.myLocks[deletedLockNo].displayInStats
	locks[lockNo].doubleUpCards = locksDeleted.myLocks[deletedLockNo].doubleUpCards
	locks[lockNo].doubleUpCardsAdded = locksDeleted.myLocks[deletedLockNo].doubleUpCardsAdded
	locks[lockNo].doubleUpCardsPicked = locksDeleted.myLocks[deletedLockNo].doubleUpCardsPicked
	locks[lockNo].emojiChosen = locksDeleted.myLocks[deletedLockNo].emojiChosen
	locks[lockNo].emojiColourSelected = locksDeleted.myLocks[deletedLockNo].emojiColourSelected
	if (locks[lockNo].emojiColourSelected = 0) then locks[lockNo].emojiColourSelected = 1
	locks[lockNo].fake = locksDeleted.myLocks[deletedLockNo].fake
	locks[lockNo].filterIn = 0
	locks[lockNo].fixed = locksDeleted.myLocks[deletedLockNo].fixed
	locks[lockNo].flagChosen = locksDeleted.myLocks[deletedLockNo].flagChosen
	locks[lockNo].freezeCards = locksDeleted.myLocks[deletedLockNo].freezeCards
	locks[lockNo].freezeCardsAdded = locksDeleted.myLocks[deletedLockNo].freezeCardsAdded
	locks[lockNo].goAgainCards = locksDeleted.myLocks[deletedLockNo].goAgainCards
	locks[lockNo].goAgainCardsPercentage# = locksDeleted.myLocks[deletedLockNo].goAgainCardsPercentage#
	locks[lockNo].greenCards = locksDeleted.myLocks[deletedLockNo].greenCards
	locks[lockNo].greensPickedSinceReset = locksDeleted.myLocks[deletedLockNo].greensPickedSinceReset
	locks[lockNo].groupID = locksDeleted.myLocks[deletedLockNo].groupID
	locks[lockNo].hiddenFromOwner = locksDeleted.myLocks[deletedLockNo].hiddenFromOwner
	locks[lockNo].hideGreensUntilPickCount = locksDeleted.myLocks[deletedLockNo].hideGreensUntilPickCount
	locks[lockNo].id = locksDeleted.myLocks[deletedLockNo].id
	locks[lockNo].initialDoubleUpCards = locksDeleted.myLocks[deletedLockNo].initialDoubleUpCards
	locks[lockNo].initialFreezeCards = locksDeleted.myLocks[deletedLockNo].initialFreezeCards
	locks[lockNo].initialGreenCards = locksDeleted.myLocks[deletedLockNo].initialGreenCards
//~	locks[lockNo].initialMaximumDoubleUpCards = locksDeleted.myLocks[deletedLockNo].initialMaximumDoubleUpCards
//~	locks[lockNo].initialMaximumFreezeCards = locksDeleted.myLocks[deletedLockNo].initialMaximumFreezeCards
//~	locks[lockNo].initialMaximumGreenCards = locksDeleted.myLocks[deletedLockNo].initialMaximumGreenCards
//~	locks[lockNo].initialMaximumMinutes = locksDeleted.myLocks[deletedLockNo].initialMaximumMinutes
//~	locks[lockNo].initialMaximumRedCards = locksDeleted.myLocks[deletedLockNo].initialMaximumRedCards
//~	locks[lockNo].initialMaximumResetCards = locksDeleted.myLocks[deletedLockNo].initialMaximumResetCards
//~	locks[lockNo].initialMaximumStickyCards = locksDeleted.myLocks[deletedLockNo].initialMaximumStickyCards
//~	locks[lockNo].initialMaximumYellowAddCards = locksDeleted.myLocks[deletedLockNo].initialMaximumYellowAddCards
//~	locks[lockNo].initialMaximumYellowMinusCards = locksDeleted.myLocks[deletedLockNo].initialMaximumYellowMinusCards
//~	locks[lockNo].initialMaximumYellowRandomCards = locksDeleted.myLocks[deletedLockNo].initialMaximumYellowRandomCards
//~	locks[lockNo].initialMinimumDoubleUpCards = locksDeleted.myLocks[deletedLockNo].initialMinimumDoubleUpCards
//~	locks[lockNo].initialMinimumFreezeCards = locksDeleted.myLocks[deletedLockNo].initialMinimumFreezeCards
//~	locks[lockNo].initialMinimumGreenCards = locksDeleted.myLocks[deletedLockNo].initialMinimumGreenCards
//~	locks[lockNo].initialMinimumMinutes = locksDeleted.myLocks[deletedLockNo].initialMinimumMinutes
//~	locks[lockNo].initialMinimumRedCards = locksDeleted.myLocks[deletedLockNo].initialMinimumRedCards
//~	locks[lockNo].initialMinimumResetCards = locksDeleted.myLocks[deletedLockNo].initialMinimumResetCards
//~	locks[lockNo].initialMinimumStickyCards = locksDeleted.myLocks[deletedLockNo].initialMinimumStickyCards
//~	locks[lockNo].initialMinimumYellowAddCards = locksDeleted.myLocks[deletedLockNo].initialMinimumYellowAddCards
//~	locks[lockNo].initialMinimumYellowMinusCards = locksDeleted.myLocks[deletedLockNo].initialMinimumYellowMinusCards
//~	locks[lockNo].initialMinimumYellowRandomCards = locksDeleted.myLocks[deletedLockNo].initialMinimumYellowRandomCards
	locks[lockNo].initialMinutes = locksDeleted.myLocks[deletedLockNo].initialMinutes
	locks[lockNo].initialRedCards = locksDeleted.myLocks[deletedLockNo].initialRedCards
	locks[lockNo].initialResetCards = locksDeleted.myLocks[deletedLockNo].initialResetCards
	locks[lockNo].initialStickyCards = locksDeleted.myLocks[deletedLockNo].initialStickyCards
	locks[lockNo].initialYellowAdd1Cards = locksDeleted.myLocks[deletedLockNo].initialYellowAdd1Cards
	locks[lockNo].initialYellowAdd2Cards = locksDeleted.myLocks[deletedLockNo].initialYellowAdd2Cards
	locks[lockNo].initialYellowAdd3Cards = locksDeleted.myLocks[deletedLockNo].initialYellowAdd3Cards
	locks[lockNo].initialYellowCards = locksDeleted.myLocks[deletedLockNo].initialYellowCards
	locks[lockNo].initialYellowMinus1Cards = locksDeleted.myLocks[deletedLockNo].initialYellowMinus1Cards
	locks[lockNo].initialYellowMinus2Cards = locksDeleted.myLocks[deletedLockNo].initialYellowMinus2Cards
	locks[lockNo].iteration = lockNo
	locks[lockNo].keyDisabled = locksDeleted.myLocks[deletedLockNo].keyDisabled
	locks[lockNo].keyholderAllowsFreeUnlock = locksDeleted.myLocks[deletedLockNo].keyholderAllowsFreeUnlock
	locks[lockNo].keyholderBuildNumberInstalled = locksDeleted.myLocks[deletedLockNo].keyholderBuildNumberInstalled
	locks[lockNo].keyholderDecisionDisabled = locksDeleted.myLocks[deletedLockNo].keyholderDecisionDisabled
	locks[lockNo].keyholderDisabledKey = locksDeleted.myLocks[deletedLockNo].keyholderDisabledKey
	locks[lockNo].keyholderEmojiChosen = locksDeleted.myLocks[deletedLockNo].keyholderEmojiChosen
	locks[lockNo].keyholderEmojiColourSelected = locksDeleted.myLocks[deletedLockNo].keyholderEmojiColourSelected
	if (locks[lockNo].keyholderEmojiColourSelected = 0) then locks[lockNo].keyholderEmojiColourSelected = 1
	locks[lockNo].keyholderID = locksDeleted.myLocks[deletedLockNo].keyholderID
	locks[lockNo].keyholderLastActive = locksDeleted.myLocks[deletedLockNo].keyholderLastActive
	locks[lockNo].keyholderMainRole = locksDeleted.myLocks[deletedLockNo].keyholderMainRole
	locks[lockNo].keyholderMainRoleLevel = locksDeleted.myLocks[deletedLockNo].keyholderMainRoleLevel
	locks[lockNo].keyholderStatus = locksDeleted.myLocks[deletedLockNo].keyholderStatus
	locks[lockNo].keyholderUsername$ = locksDeleted.myLocks[deletedLockNo].keyholderUsername$
	locks[lockNo].keyUsed = locksDeleted.myLocks[deletedLockNo].keyUsed
	locks[lockNo].lastUpdateIDSeen = locksDeleted.myLocks[deletedLockNo].lastUpdateIDSeen
	locks[lockNo].lateCheckInWindowInSeconds = locksDeleted.myLocks[deletedLockNo].lateCheckInWindowInSeconds
	locks[lockNo].lockFrozenByCard = locksDeleted.myLocks[deletedLockNo].lockFrozenByCard
	locks[lockNo].lockFrozenByKeyholder = locksDeleted.myLocks[deletedLockNo].lockFrozenByKeyholder
	locks[lockNo].lockLog.length = -1
	locks[lockNo].lockName$ = locksDeleted.myLocks[deletedLockNo].lockName$
	locks[lockNo].maximumAutoResets = locksDeleted.myLocks[deletedLockNo].maximumAutoResets
	locks[lockNo].maximumMinutes = locksDeleted.myLocks[deletedLockNo].maximumMinutes
	locks[lockNo].maximumRedCards = locksDeleted.myLocks[deletedLockNo].maximumRedCards
	locks[lockNo].minimumMinutes = locksDeleted.myLocks[deletedLockNo].minimumMinutes
	locks[lockNo].minimumRedCards = locksDeleted.myLocks[deletedLockNo].minimumRedCards
	locks[lockNo].minutes = locksDeleted.myLocks[deletedLockNo].minutes
	locks[lockNo].minutesAdded = locksDeleted.myLocks[deletedLockNo].minutesAdded
	locks[lockNo].multipleGreensRequired = locksDeleted.myLocks[deletedLockNo].multipleGreensRequired
	locks[lockNo].noOfAdd1Cards = locksDeleted.myLocks[deletedLockNo].noOfAdd1Cards
	locks[lockNo].noOfAdd2Cards = locksDeleted.myLocks[deletedLockNo].noOfAdd2Cards
	locks[lockNo].noOfAdd3Cards = locksDeleted.myLocks[deletedLockNo].noOfAdd3Cards
	locks[lockNo].noOfKeysRequired = locksDeleted.myLocks[deletedLockNo].noOfKeysRequired
	locks[lockNo].noOfMinus1Cards = locksDeleted.myLocks[deletedLockNo].noOfMinus1Cards
	locks[lockNo].noOfMinus2Cards = locksDeleted.myLocks[deletedLockNo].noOfMinus2Cards
	locks[lockNo].noOfTimesAutoReset = locksDeleted.myLocks[deletedLockNo].noOfTimesAutoReset
	locks[lockNo].noOfTimesCardReset = locksDeleted.myLocks[deletedLockNo].noOfTimesCardReset
	locks[lockNo].noOfTimesFullReset = locksDeleted.myLocks[deletedLockNo].noOfTimesFullReset
	locks[lockNo].noOfTimesGreenCardRevealed = locksDeleted.myLocks[deletedLockNo].noOfTimesGreenCardRevealed
	locks[lockNo].noOfTimesReset = locksDeleted.myLocks[deletedLockNo].noOfTimesReset
	locks[lockNo].notificationID = 0
	locks[lockNo].notificationTimestamp = 0
	locks[lockNo].percentageTimer = 0
	locks[lockNo].permanent = locksDeleted.myLocks[deletedLockNo].permanent
	locks[lockNo].pickedCount = locksDeleted.myLocks[deletedLockNo].pickedCount
	locks[lockNo].pickedCountIncludingYellows = locksDeleted.myLocks[deletedLockNo].pickedCountIncludingYellows
	locks[lockNo].pickedCountSinceReset = locksDeleted.myLocks[deletedLockNo].pickedCountSinceReset
	locks[lockNo].randomCardsAdded = locksDeleted.myLocks[deletedLockNo].randomCardsAdded
	locks[lockNo].rating = locksDeleted.myLocks[deletedLockNo].rating
	locks[lockNo].readyToPick = 0
	locks[lockNo].readyToUnlock = locksDeleted.myLocks[deletedLockNo].readyToUnlock
	locks[lockNo].redCards = locksDeleted.myLocks[deletedLockNo].redCards
	locks[lockNo].redCardsAdded = locksDeleted.myLocks[deletedLockNo].redCardsAdded
	locks[lockNo].regularity# = locksDeleted.myLocks[deletedLockNo].regularity#
	locks[lockNo].removedByKeyholder = locksDeleted.myLocks[deletedLockNo].removedByKeyholder
	locks[lockNo].resetCards = locksDeleted.myLocks[deletedLockNo].resetCards
	locks[lockNo].resetCardsAdded = locksDeleted.myLocks[deletedLockNo].resetCardsAdded
	locks[lockNo].resetCardsPicked = locksDeleted.myLocks[deletedLockNo].resetCardsPicked
	locks[lockNo].resetFrequencyInSeconds = locksDeleted.myLocks[deletedLockNo].resetFrequencyInSeconds
	locks[lockNo].ribbonType$ = ""
	locks[lockNo].rowInDB = locksDeleted.myLocks[deletedLockNo].rowInDB
	locks[lockNo].sharedID$ = locksDeleted.myLocks[deletedLockNo].sharedID$
	locks[lockNo].simulationAverageMinutesLocked = locksDeleted.myLocks[deletedLockNo].simulationAverageMinutesLocked
	locks[lockNo].simulationBestCaseMinutesLocked = locksDeleted.myLocks[deletedLockNo].simulationBestCaseMinutesLocked
	locks[lockNo].simulationWorstCaseMinutesLocked = locksDeleted.myLocks[deletedLockNo].simulationWorstCaseMinutesLocked
	locks[lockNo].stickyCards = locksDeleted.myLocks[deletedLockNo].stickyCards
	locks[lockNo].test = locksDeleted.myLocks[deletedLockNo].test
	locks[lockNo].timeLeftUntilNextChanceBeforeFreeze = locksDeleted.myLocks[deletedLockNo].timeLeftUntilNextChanceBeforeFreeze
	locks[lockNo].timerHidden = locksDeleted.myLocks[deletedLockNo].timerHidden
	locks[lockNo].timestampCleanTimeRequestBlockedUntil = locksDeleted.myLocks[deletedLockNo].timestampCleanTimeRequestBlockedUntil
	locks[lockNo].timestampDeleted = 0
	locks[lockNo].timestampDeniedCleanTime = locksDeleted.myLocks[deletedLockNo].timestampDeniedCleanTime
	locks[lockNo].timestampEndedCleanTime = locksDeleted.myLocks[deletedLockNo].timestampEndedCleanTime
	locks[lockNo].timestampFrozenByCard = locksDeleted.myLocks[deletedLockNo].timestampFrozenByCard
	locks[lockNo].timestampFrozenByKeyholder = locksDeleted.myLocks[deletedLockNo].timestampFrozenByKeyholder
	locks[lockNo].timestampHiddenFromOwner = locksDeleted.myLocks[deletedLockNo].timestampHiddenFromOwner
	locks[lockNo].timestampLastAutoReset = locksDeleted.myLocks[deletedLockNo].timestampLastAutoReset
	locks[lockNo].timestampLastCardReset = locksDeleted.myLocks[deletedLockNo].timestampLastCardReset
	locks[lockNo].timestampLastCheckedIn = locksDeleted.myLocks[deletedLockNo].timestampLastCheckedIn
	locks[lockNo].timestampLastCheckedUpdates = 0
	locks[lockNo].timestampLastFullReset = locksDeleted.myLocks[deletedLockNo].timestampLastFullReset
	locks[lockNo].timestampLastPicked = locksDeleted.myLocks[deletedLockNo].timestampLastPicked
	locks[lockNo].timestampLastReset = locksDeleted.myLocks[deletedLockNo].timestampLastReset
	locks[lockNo].timestampLastSynced = locksDeleted.myLocks[deletedLockNo].timestampLastSynced
	locks[lockNo].timestampLastUpdated = locksDeleted.myLocks[deletedLockNo].timestampLastUpdated
	locks[lockNo].timestampLocked = locksDeleted.myLocks[deletedLockNo].timestampLocked
	locks[lockNo].timestampRated = locksDeleted.myLocks[deletedLockNo].timestampRated
	locks[lockNo].timestampRealLastPicked = locksDeleted.myLocks[deletedLockNo].timestampRealLastPicked
	locks[lockNo].timestampRemovedByKeyholder = locksDeleted.myLocks[deletedLockNo].timestampRemovedByKeyholder
	locks[lockNo].timestampRequestedCleanTime = locksDeleted.myLocks[deletedLockNo].timestampRequestedCleanTime
	locks[lockNo].timestampRequestedKeyholdersDecision = locksDeleted.myLocks[deletedLockNo].timestampRequestedKeyholdersDecision
	locks[lockNo].timestampRibbonAdded = locksDeleted.myLocks[deletedLockNo].timestampRibbonAdded
	locks[lockNo].timestampStartedCleanTime = locksDeleted.myLocks[deletedLockNo].timestampStartedCleanTime
	locks[lockNo].timestampUnfreezes = locksDeleted.myLocks[deletedLockNo].timestampUnfreezes
	locks[lockNo].timestampUnfrozen = locksDeleted.myLocks[deletedLockNo].timestampUnfrozen
	locks[lockNo].timestampUnlocked = locksDeleted.myLocks[deletedLockNo].timestampUnlocked
	locks[lockNo].totalTimeCleaning = locksDeleted.myLocks[deletedLockNo].totalTimeCleaning
	locks[lockNo].totalTimeFrozen = locksDeleted.myLocks[deletedLockNo].totalTimeFrozen
	locks[lockNo].trustKeyholder = locksDeleted.myLocks[deletedLockNo].trustKeyholder
	locks[lockNo].unlocked = locksDeleted.myLocks[deletedLockNo].unlocked
	locks[lockNo].version$ = locksDeleted.myLocks[deletedLockNo].version$
	locks[lockNo].yellowCards = locksDeleted.myLocks[deletedLockNo].yellowCards
	// RESET CHANCES TO 1 TO STOP CHEATING ON A KEYHOLDER OR BOT CONTROLLED LOCK
	if (locks[lockNo].fixed = 0)
		if (locks[lockNo].sharedID$ <> "" and (locks[lockNo].botChosen > 0 or locks[lockNo].hiddenFromOwner = 0))
			secondsBetweenLastPickedAndDeleted = locksDeleted.myLocks[deletedLockNo].timestampDeleted - locksDeleted.myLocks[deletedLockNo].timestampLastPicked
			locks[lockNo].timestampLastPicked = timestampNow - secondsBetweenLastPickedAndDeleted
		endif
	endif
	// ADD THE TOTAL TIME IT WAS DELETED FOR TO A FIXED LOCK IF KEYHOLDER OR BOT CONTROLLED LOCK
	if (locks[lockNo].fixed = 1 and locks[lockNo].regularity# = 0.016667)
		if (locks[lockNo].sharedID$ <> "" and (locks[lockNo].botChosen > 0 or locks[lockNo].hiddenFromOwner = 0))
			minutesDeleted = (timestampNow - locksDeleted.myLocks[deletedLockNo].timestampDeleted) / 60
			locks[lockNo].minutes = locks[lockNo].minutes + minutesDeleted
		endif
	endif
	UpdateLocksData(lockNo)
	fileID = OpenToWrite("locksV2.txt", 0)
	for a = 1 to 20
		WriteInteger(fileID, locks[a].id)
	next
	CloseFile(fileID)
	ResetAllNotifications()
	UpdateLocksDatabase(lockNo, "action:RestoredLock;actionedBy:Lockee", 1)
	GetMyLocksDeleted(0)
	deletedMyLockJustRestored = 1
endfunction

function RestoreDeletedSharedLock(deletedSharedLockNo, addToFront)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&shareID=" + locksDeleted.sharedLocks[deletedSharedLockNo].shareID$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:RestoreDeletedSharedLock;script:" + URLs[0].URLPath + "/" + URLs[0].RestoreDeletedSharedLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function ReturnSharedLockName(shareID$ as string)
	local i as integer
	local sharedLockName$ as string : sharedLockName$ = ""
	
	for i = 0 to sharedLocks.length
		if (sharedLocks[i, 0].shareID$ = shareID$)
			sharedLockName$ = sharedLocks[i, 0].lockName$
			exit
		endif
	next
	
	if (sharedLockName$ = "")
		for i = 1 to noOfLocks
			if (locks[i].sharedID$ = shareID$)
				sharedLockName$ = locks[i].lockName$
				exit
			endif
		next
	endif
endfunction sharedLockName$

function RunSimulation(newLock as integer)
	local i as integer
	local minutesFrozen as integer
	local originalNoOfGreens as integer
	local originalNoOfReds as integer
	local originalNoOfStickies as integer
	local originalNoOfYellowsAdd1 as integer
	local originalNoOfYellowsAdd2 as integer
	local originalNoOfYellowsAdd3 as integer
	local originalNoOfYellowsMinus1 as integer
	local originalNoOfYellowsMinus2 as integer
	local picked as integer

	if (debugMode = 1 and simulationCount = 0)
		simulationDataFileID = OpenToWrite("ChastiKeySimulationData.txt", 0)	
	endif
	if (simulationCount < simulationsToTry)
		inc simulationCount
		simulationLastAutoReset = 0
		simulationMinutesLocked = 0
		simulationMinutesLocked = simulationMinutesLocked + floor(simulationSecondsUntilUnfreezes / 60)
		simulationNoOfTurns = 0
		simulationNoOfCardsDrawn = 0
		simulationNoOfLockResets = 0
		simulationNoOfLockAutoResets = 0
		simulationSecondsLocked = 0
		simulationSecondsLocked = simulationSecondsLocked + simulationSecondsUntilUnfreezes
		if (simulationCount = 1)
			simulationAverageMinutesLocked = 0
			simulationAverageNoOfTurns = 0
			simulationAverageNoOfCardsDrawn = 0
			simulationAverageNoOfLockResets = 0
			simulationBestCaseMinutesLocked = 9999999999
			simulationBestCaseNoOfTurns = 9999999999
			simulationBestCaseNoOfCardsDrawn = 9999999999
			simulationBestCaseNoOfLockResets = 9999999999
			simulationWorstCaseMinutesLocked = 0
			simulationWorstCaseNoOfTurns = 0
			simulationWorstCaseNoOfCardsDrawn = 0
			simulationWorstCaseNoOfLockResets = 0
		endif
		simulationAverageMinutesLocked = simulationAverageMinutesLocked + floor(simulationSecondsUntilUnfreezes / 60)
		CreateSimulationDeck(newLock)
		ShuffleSimulationDeck()

		if (debugMode = 1) then WriteString(simulationDataFileID, "### SIMULATION " + str(simulationCount) + chr(13))
		
		while (simulationDeck$.length >= 0)
			if (debugMode = 1) then WriteString(simulationDataFileID, "## CARDS: " + str(simulationNoOfGreens) + " greens | " + str(simulationNoOfReds) + " reds | " + str(simulationNoOfStickies) + " stickies | " + str(simulationNoOfYellows) + " yellows | " + str(simulationNoOfFreezes) + " freezes | " + str(simulationNoOfDoubleUps) + " double ups | " + str(simulationNoOfResets) + " resets" + chr(13))
			
			picked = random(0, simulationDeck$.length)
			
			if (debugMode = 1) then WriteString(simulationDataFileID, "# PICKED: " + simulationDeck$[picked] + chr(13))
			
			if (simulationDeck$[picked] = "Green" and simulationNoOfTurns < simulationMinimumRedCards and (simulationNoOfDoubleUps > 0 or simulationNoOfFreezes > 0 or simulationNoOfReds > 0 or simulationNoOfResets > 0 or simulationNoOfYellows > 0))
				continue
			endif
			
			if (simulationDeck$[picked] = "DoubleUp")
				RemoveCardFromSimulationDeck(picked)
				originalNoOfReds = simulationNoOfReds
				for i = 1 to originalNoOfReds
					if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				next
				originalNoOfYellowsAdd1 = simulationNoOfYellowsAdd1
				for i = 1 to originalNoOfYellowsAdd1
					if (simulationNoOfYellowsAdd1 < cappedYellowCardsEachType) then AddCardToSimulationDeck("YellowAdd1")
				next
				originalNoOfYellowsAdd2 = simulationNoOfYellowsAdd2
				for i = 1 to originalNoOfYellowsAdd2
					if (simulationNoOfYellowsAdd2 < cappedYellowCardsEachType) then AddCardToSimulationDeck("YellowAdd2")
				next
				originalNoOfYellowsAdd3 = simulationNoOfYellowsAdd3
				for i = 1 to originalNoOfYellowsAdd3
					if (simulationNoOfYellowsAdd3 < cappedYellowCardsEachType) then AddCardToSimulationDeck("YellowAdd3")
				next
				originalNoOfYellowsMinus1 = simulationNoOfYellowsMinus1
				for i = 1 to originalNoOfYellowsMinus1
					if (simulationNoOfYellowsMinus1 < cappedYellowCardsEachType) then AddCardToSimulationDeck("YellowMinus1")
				next
				originalNoOfYellowsMinus2 = simulationNoOfYellowsMinus2
				for i = 1 to originalNoOfYellowsMinus2
					if (simulationNoOfYellowsMinus2 < cappedYellowCardsEachType) then AddCardToSimulationDeck("YellowMinus2")
				next
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "Freeze")
				RemoveCardFromSimulationDeck(picked)
				minutesFrozen = random((60 * regularity#) * 2, (60 * regularity#) * 4)
				simulationAverageMinutesLocked = simulationAverageMinutesLocked + minutesFrozen
				simulationMinutesLocked = simulationMinutesLocked + minutesFrozen
				simulationSecondsLocked = simulationSecondsLocked + (minutesFrozen * 60)
				inc simulationAverageNoOfTurns
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfTurns
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "Green")
				RemoveCardFromSimulationDeck(picked)
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
				if (multipleGreensRequired = 0)
					simulationDeck$.length = -1
					exit
				elseif (multipleGreensRequired = 1 and simulationNoOfGreens = 0)
					simulationDeck$.length = -1
					exit
				endif
			elseif (simulationDeck$[picked] = "Red")
				RemoveCardFromSimulationDeck(picked)
				simulationAverageMinutesLocked = simulationAverageMinutesLocked + (60 * regularity#)
				simulationMinutesLocked = simulationMinutesLocked + (60 * regularity#)
				simulationSecondsLocked = simulationSecondsLocked + ((60 * regularity#) * 60)
				inc simulationAverageNoOfTurns
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfTurns
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "Reset")
				RemoveCardFromSimulationDeck(picked)
				originalNoOfGreens = simulationNoOfGreens
				if (originalNoOfGreens > simulationInitialGreens)
					for i = originalNoOfGreens to simulationInitialGreens + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("Green"))
					next
				elseif (originalNoOfGreens < simulationInitialGreens)
					for i = originalNoOfGreens + 1 to simulationInitialGreens
						AddCardToSimulationDeck("Green")
					next
				endif
				originalNoOfReds = simulationNoOfReds
				if (originalNoOfReds > simulationInitialReds)
					for i = originalNoOfReds to simulationInitialReds + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("Red"))
					next
				elseif (originalNoOfReds < simulationInitialReds)
					for i = originalNoOfReds + 1 to simulationInitialReds
						AddCardToSimulationDeck("Red")
					next
				endif
				originalNoOfYellowsAdd1 = simulationNoOfYellowsAdd1
				if (originalNoOfYellowsAdd1 > simulationInitialYellowsAdd1)
					for i = originalNoOfYellowsAdd1 to simulationInitialYellowsAdd1 + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("YellowAdd1"))
					next
				elseif (originalNoOfYellowsAdd1 < simulationInitialYellowsAdd1)
					for i = originalNoOfYellowsAdd1 + 1 to simulationInitialYellowsAdd1
						AddCardToSimulationDeck("YellowAdd1")
					next
				endif
				originalNoOfYellowsAdd2 = simulationNoOfYellowsAdd2
				if (originalNoOfYellowsAdd2 > simulationInitialYellowsAdd2)
					for i = originalNoOfYellowsAdd2 to simulationInitialYellowsAdd2 + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("YellowAdd2"))
					next
				elseif (originalNoOfYellowsAdd2 < simulationInitialYellowsAdd2)
					for i = originalNoOfYellowsAdd2 + 1 to simulationInitialYellowsAdd2
						AddCardToSimulationDeck("YellowAdd2")
					next
				endif
				originalNoOfYellowsAdd3 = simulationNoOfYellowsAdd3
				if (originalNoOfYellowsAdd3 > simulationInitialYellowsAdd3)
					for i = originalNoOfYellowsAdd3 to simulationInitialYellowsAdd3 + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("YellowAdd3"))
					next
				elseif (originalNoOfYellowsAdd3 < simulationInitialYellowsAdd3)
					for i = originalNoOfYellowsAdd3 + 1 to simulationInitialYellowsAdd3
						AddCardToSimulationDeck("YellowAdd3")
					next
				endif
				originalNoOfYellowsMinus1 = simulationNoOfYellowsMinus1
				if (originalNoOfYellowsMinus1 > simulationInitialYellowsMinus1)
					for i = originalNoOfYellowsMinus1 to simulationInitialYellowsMinus1 + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("YellowMinus1"))
					next
				elseif (originalNoOfYellowsMinus1 < simulationInitialYellowsMinus1)
					for i = originalNoOfYellowsMinus1 + 1 to simulationInitialYellowsMinus1
						AddCardToSimulationDeck("YellowMinus1")
					next
				endif
				originalNoOfYellowsMinus2 = simulationNoOfYellowsMinus2
				if (originalNoOfYellowsMinus2 > simulationInitialYellowsMinus2)
					for i = originalNoOfYellowsMinus2 to simulationInitialYellowsMinus2 + 1 step -1
						RemoveCardFromSimulationDeck(simulationDeck$.find("YellowMinus2"))
					next
				elseif (originalNoOfYellowsMinus2 < simulationInitialYellowsMinus2)
					for i = originalNoOfYellowsMinus2 + 1 to simulationInitialYellowsMinus2
						AddCardToSimulationDeck("YellowMinus2")
					next
				endif
				inc simulationAverageNoOfTurns
				inc simulationAverageNoOfCardsDrawn
				inc simulationAverageNoOfLockResets
				inc simulationNoOfTurns
				inc simulationNoOfCardsDrawn
				inc simulationNoOfLockResets
			elseif (simulationDeck$[picked] = "Sticky")
				simulationAverageMinutesLocked = simulationAverageMinutesLocked + (60 * regularity#)
				simulationMinutesLocked = simulationMinutesLocked + (60 * regularity#)
				simulationSecondsLocked = simulationSecondsLocked + ((60 * regularity#) * 60)
				inc simulationAverageNoOfTurns
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfTurns
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "YellowAdd1")
				RemoveCardFromSimulationDeck(picked)
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "YellowAdd2")
				RemoveCardFromSimulationDeck(picked)
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "YellowAdd3")
				RemoveCardFromSimulationDeck(picked)
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				if (simulationNoOfReds < cappedRedCards) then AddCardToSimulationDeck("Red")
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "YellowMinus1")
				RemoveCardFromSimulationDeck(picked)
				RemoveCardFromSimulationDeck(simulationDeck$.find("Red"))
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			elseif (simulationDeck$[picked] = "YellowMinus2")
				RemoveCardFromSimulationDeck(picked)
				RemoveCardFromSimulationDeck(simulationDeck$.find("Red"))
				RemoveCardFromSimulationDeck(simulationDeck$.find("Red"))
				inc simulationAverageNoOfCardsDrawn
				inc simulationNoOfCardsDrawn
			endif

			// AUTO RESET
			if (resetFrequencyInSeconds > 0)
				if (simulationSecondsLocked > simulationLastAutoReset + resetFrequencyInSeconds and simulationNoOfLockAutoResets < maxAutoResets)
				//if (mod(simulationSecondsLocked, resetFrequencyInSeconds) = 0 and simulationNoOfLockAutoResets < maxAutoResets)
					simulationLastAutoReset = simulationSecondsLocked
					inc simulationSecondsLocked
					inc simulationAverageNoOfLockResets
					inc simulationNoOfLockResets
					inc simulationNoOfLockAutoResets
					CreateSimulationDeck(newLock)
					ShuffleSimulationDeck()
				endif
			endif
		endwhile

	endif
	
	if (debugMode = 1 and simulationCount = 100)
		CloseFile(simulationDataFileID)
	endif
endfunction

function SavePurchasedKeys(keys as integer)
	noOfKeys = noOfKeys + keys
	noOfKeysPurchased = noOfKeysPurchased + keys						
	SaveLocalVariable("noOfKeys", str(noOfKeys))
	SaveLocalVariable("noOfKeysPurchased", str(noOfKeysPurchased))
endfunction

function SaveUserFlags()
	usersFlag1.sort()
	usersFlag1.save("usersFlag1.json")
	usersFlag2.sort()
	usersFlag2.save("usersFlag2.json")
	usersFlag3.sort()
	usersFlag3.save("usersFlag3.json")
	usersFlag4.sort()
	usersFlag4.save("usersFlag4.json")
	usersFlag5.sort()
	usersFlag5.save("usersFlag5.json")
	usersFlag6.sort()
	usersFlag6.save("usersFlag6.json")
	usersFlag7.sort()
	usersFlag7.save("usersFlag7.json")
endfunction

function SendNotificationToKeyholder(sharedID$, messageType$, testLock, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&messageType=" + messageType$
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&sharedID=" + sharedID$
	postData$ = postData$ + "&test=" + str(testLock)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:SendNotificationToKeyholder;script:" + URLs[0].URLPath + "/agksendnotification.php;postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function SetMaintenanceValue(value as integer)
	if (value <> maintenance)
		maintenance = value
		if (maintenance = 1) then SetOfflineValue(1)
	endif
endfunction

function SetOfflineValue(value as integer)
	if (value <> offline)
		offline = value
		if (GetInternetState() = 0)
			noInternet = 1
		else
			noInternet = 0
		endif
		if (GetInternetState() = 0 or offline = 1)
			timestampFromServer = 0
			offlineModeStartTime = GetSeconds()
		endif
	endif
endfunction

function SetUsernameColorArray(mainRole as integer, mainRoleLevel as integer)
	usernameColor[0] = 0
	usernameColor[1] = 0
	usernameColor[2] = 0
	usernameColor[3] = 150
	if (mainRole = 1)
		usernameColor[0] = GetColorRed(roleColours.keyholder[1])
		usernameColor[1] = GetColorGreen(roleColours.keyholder[1])
		usernameColor[2] = GetColorBlue(roleColours.keyholder[1])
		usernameColor[3] = 255
	endif
	if (mainRole = 2)
		usernameColor[0] = GetColorRed(roleColours.lockee[1])
		usernameColor[1] = GetColorGreen(roleColours.lockee[1])
		usernameColor[2] = GetColorBlue(roleColours.lockee[1])
		usernameColor[3] = 255
	endif
endfunction

function ShowLargeCard(cardValue$ as string, topText$ as string, middleText$ as string, bottomText$ as string)
	local cardImageID as integer
	
	largeCardVisible = 1
	largeCard.value$ = cardValue$
	if (cardValue$ = "DoubleUp") then cardImageID = imgCardDoubleUp100
	if (cardValue$ = "Freeze") then cardImageID = imgCardFreeze100
	if (cardValue$ = "GoAgain") then cardImageID = imgCardGoAgain
	if (cardValue$ = "Green") then cardImageID = imgCardGreen025
	if (cardValue$ = "Red") then cardImageID = imgCardRed025
	if (cardValue$ = "Reset") then cardImageID = imgCardReset100
	if (noOfChances > 0 and cardValue$ = "Sticky") then cardImageID = imgCardSticky100
	if (noOfChances = 0 and cardValue$ = "Sticky") then cardImageID = imgCardSticky025
	if (cardValue$ = "YellowAdd1") then cardImageID = imgCardYellowAdd1
	if (cardValue$ = "YellowAdd2") then cardImageID = imgCardYellowAdd2
	if (cardValue$ = "YellowAdd3") then cardImageID = imgCardYellowAdd3
	if (cardValue$ = "YellowMinus1") then cardImageID = imgCardYellowMinus1
	if (cardValue$ = "YellowMinus2") then cardImageID = imgCardYellowMinus2
	if (topText$ = "") then topText$ = " "
	if (middleText$ = "") then middleText$ = " "
	if (bottomText$ = "") then bottomText$ = " "
	OryUIUpdateSprite(largeCard.sprite, "size:" + str((cardWidth# / GetDisplayAspect()) * 4) + "," + str(cardHeight# * 4) + ";position:" + str(GetViewOffsetX() + 50) + ",50;image:" + str(cardImageID) + ";depth:" + str(GetSpriteDepth(cards[cardSpritesIndex].sprite)))
	OryUIUpdateText(largeCard.txtTop, "text:" + topText$ + ";depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
	OryUIUpdateText(largeCard.txtCenter, "text:" + middleText$ + ";depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
	OryUIUpdateText(largeCard.txtBottom, "text:" + bottomText$ + ";color:255,255,255,255;depth:" + str(GetSpriteDepth(largeCard.sprite) - 1))
	OryUIPinTextToCentreOfSprite(largeCard.txtTop, largeCard.sprite, 0, -(GetTextTotalHeight(largeCard.txtCenter) / 2) - 1)
	OryUIPinTextToCentreOfSprite(largeCard.txtCenter, largeCard.sprite, 0, 0)			
	OryUIPinTextToCentreOfSprite(largeCard.txtBottom, largeCard.sprite, 0, (GetSpriteHeight(largeCard.sprite) / 2) - 6)
endfunction

function ShowTooltipAfterScreenRefresh(text$ as string)
	tooltipTextForAfterScreenRefresh$ = text$
endfunction

function ShuffleDeck(iterations)
	local a as integer
	local b as integer
	local i as integer
	local j as integer
	
	noOfCards = GetNoOfCards(lockSelected) 
	for i = 1 to noOfCards
		shuffledDeck[i] = i
	next
	for j = 1 to random(5, 10)
		for i = 1 to noOfCards
			a = random(1, noOfCards)
			b = random(1, noOfCards)
			shuffledDeck.swap(a, b)
		next
	next
	if (screenNo = constCardsScreen)
		if (iterations > 0)
			if (cardAnimationsOn = 1)
				for a = 1 to iterations
					for b = 1 to noOfCardSprites + 4
						if (GetSpriteExists(cards[b].sprite)) then OryUIUpdateSprite(cards[b].sprite, "position:" + str(GetViewOffsetX() + random(40, 60)) + "," + str(random(40, 60)) + ";image:" + str(imgCardBack) + ";angle:" + str(random(355, 365)))
					next
					Sync()
				next
			endif
			for a = 1 to noOfCardSprites + 4
				if (GetSpriteExists(cards[a].sprite)) then DeleteSprite(cards[a].sprite)
			next
			SetScreenToView(constCardsScreen)
		endif
	endif
endfunction

function ShuffleSimulationDeck()
	local a as integer
	local b as integer
	local i as integer
	
	for i = 0 to simulationDeck$.length
		a = random(0, simulationDeck$.length)
		b = random(0, simulationDeck$.length)
		simulationDeck$.swap(a, b)
	next
endfunction

function SlideInCard(id)
	cardsScrimVisible = 0
	OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
	OryUIUpdateButton(btnViewCard, "position:-1000,-1000")
	OryUIUpdateButton(btnCancelCard, "position:-1000,-1000")
	cards[id].tweenSprite[1] = CreateTweenSprite(0.2)
	SetTweenSpriteYByOffset(cards[id].tweenSprite[1], GetSpriteYByOffset(cards[id].sprite), cards[id].originalY# - (cardHeight# * 1.2), TweenLinear())
	SetTweenSpriteSizeX(cards[id].tweenSprite[1], GetSpriteWidth(cards[id].sprite), cards[id].originalWidth#, TweenLinear())
	SetTweenSpriteSizeY(cards[id].tweenSprite[1], GetSpriteHeight(cards[id].sprite), cards[id].originalHeight#, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
	SetSpriteDepth(cards[id].sprite, cards[id].originalDepth)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.2)
	SetTweenSpriteXByOffset(cards[id].tweenSprite[1], GetSpriteXByOffset(cards[id].sprite), cards[id].originalX#, TweenLinear())
	SetTweenSpriteYByOffset(cards[id].tweenSprite[1], GetSpriteYByOffset(cards[id].sprite), cards[id].originalY#, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
	SetSpriteAngle(cards[id].sprite, random(355, 365))
endfunction

function SlideOutCard(id, addScrim)
	cards[id].originalX# = GetSpriteXByOffset(cards[id].sprite)
	cards[id].originalY# = GetSpriteYByOffset(cards[id].sprite)
	cards[id].originalWidth# = GetSpriteWidth(cards[id].sprite)
	cards[id].originalHeight# = GetSpriteHeight(cards[id].sprite)
	cards[id].originalDepth = GetSpriteDepth(cards[id].sprite)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.2)
	SetTweenSpriteYByOffset(cards[id].tweenSprite[1], GetSpriteYByOffset(cards[id].sprite), GetSpriteYByOffset(cards[id].sprite) - (cardHeight# * 1.2), TweenLinear())
	SetSpriteAngle(cards[id].sprite, 0)
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
	SetSpriteDepth(cards[id].sprite, 2)
	cards[id].tweenSprite[1] = CreateTweenSprite(0.2)
	SetTweenSpriteXByOffset(cards[id].tweenSprite[1], GetSpriteXByOffset(cards[id].sprite), GetViewOffsetX() + 50, TweenLinear())
	SetTweenSpriteYByOffset(cards[id].tweenSprite[1], GetSpriteYByOffset(cards[id].sprite), 50, TweenLinear())
	SetTweenSpriteSizeX(cards[id].tweenSprite[1], GetSpriteWidth(cards[id].sprite), GetSpriteWidth(cards[id].sprite) * 2, TweenLinear())
	SetTweenSpriteSizeY(cards[id].tweenSprite[1], GetSpriteHeight(cards[id].sprite), GetSpriteHeight(cards[id].sprite) * 2, TweenLinear())
	PlayTweenSprite(cards[id].tweenSprite[1], cards[id].sprite, 0)
	while (GetTweenSpritePlaying(cards[id].tweenSprite[1], cards[id].sprite))
		UpdateAllTweens(GetFrameTime())
		Sync()
	endwhile
	if (addScrim = 1)
		cardsScrimVisible = 1
		OryUIUpdateSprite(sprCardsScrim, "position:" + str(GetViewOffsetX()) + "," + str(GetScreenBoundsTop() + OryUIGetTopBarHeight(screen[screenNo].topBar)) + ";alpha:0;depth:3")
		tweenBlackOverlay = CreateTweenSprite(0.2)
		SetTweenSpriteAlpha(tweenBlackOverlay, 0, 200, TweenLinear())
		PlayTweenSprite(tweenBlackOverlay, sprCardsScrim, 0)
	else
		cardsScrimVisible = 0
		OryUIUpdateSprite(sprCardsScrim, "position:-1000,-1000")
	endif
endfunction

function SortDesertedUsers(searchString$ as string)
	local a as integer
	local cappedDesertedUsers as integer
	local char$ as string
	local filterInFlag as integer
	local filterInType as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	sharedLockUsersSorted.length = sharedLocks[sharedLockSelected, 0].desertedUsers
	filterCount = 0
	if (sharedLocks[sharedLockSelected, 0].desertedUsers > 199)
		cappedDesertedUsers = 199
	else
		cappedDesertedUsers = sharedLocks[sharedLockSelected, 0].desertedUsers
	endif
	for i = 1 to cappedDesertedUsers
		negativeNumber = 0
		filterInFlag = 0
		filterInType = 0
		if (sharedLocks[sharedLockSelected, 3].usersID[i] > 0)
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagAll" or filterUnlockedUsersByFlag$ = "") then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlack" and usersFlag1.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagBlue" and usersFlag2.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagGreen" and usersFlag3.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagOrange" and usersFlag4.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagPurple"  and usersFlag5.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagRed"  and usersFlag6.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagYellow"  and usersFlag7.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInFlag = 1
			if (filterDesertedUsersBy$ = "FilterDesertedUsersAll" or filterUnlockedUsersBy$ = "") then filterInType = 1
			if (filterDesertedUsersBy$ = "FilterDesertedUsersAwaitingRating" and sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[i] = 0 and timestampNow - sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[i] <= 604800) then filterInType = 1
			if (filterDesertedUsersBy$ = "FilterDesertedUsersFavourites" and favouriteUsers.find(sharedLocks[sharedLockSelected, 3].usersID[i]) <> -1) then filterInType = 1
			if (filterDesertedUsersBy$ = "FilterDesertedUsersTestLocks" and sharedLocks[sharedLockSelected, 3].usersTestLock[i] = 1) then filterInType = 1
			if (filterDesertedUsersExcludeTestLocks = 1 and sharedLocks[sharedLockSelected, 3].usersTestLock[i] = 1) then filterInType = 0
			if (filterInFlag = 1 and filterInType = 1 and searchString$ <> "")
				filterInFlag = 0
				filterInType = 0
				if (FindString(sharedLocks[sharedLockSelected, 3].usersUsername$[i], searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
			endif
			if (filterInFlag = 1 and filterInType = 1)
				sortValue$ = "0"
				if (sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[i])
				endif
				if (sortDesertedUsersBy$ = "SortDesertedUsersByDurationLocked")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[i] - sharedLocks[sharedLockSelected, 3].usersTimestampLocked[i])
				endif
				if (sortDesertedUsersBy$ = "SortDesertedUsersByRandom")
					sortKeyType$ = "integer"
					sortValue$ = str(i)
				endif
				if (sortDesertedUsersBy$ = "SortDesertedUsersByUserRating")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[i], 3)
				endif
				if (sortDesertedUsersBy$ = "SortDesertedUsersByUsername")
					sortKeyType$ = "string"
					sortValue$ = lower(sharedLocks[sharedLockSelected, 3].usersUsername$[i])
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				sharedLockUsersSorted[filterCount].sortKey$ = sortValue$
				sharedLockUsersSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		sharedLockUsersSorted.length = filterCount - 1
		if (sortDesertedUsersBy$ <> "SortDesertedUsersByRandom")
			sharedLockUsersSorted.sort()
			if (sortDesertedUsersOrder$ = "DESC") then sharedLockUsersSorted.reverse()
		endif
		sharedLockUsersSorted.length = 200
	endif
endfunction

//~function SortFindUsers(searchString$ as string)
//~	local filterIn as integer
//~	local i as integer
//~	local sortKeyType$ as string
//~	local sortValue$ as string
//~	
//~	findUsersDelimitedIDs$ = ""
//~	findUsersSorted.length = findUsers.length
//~	filterCount = 0
//~	for i = 0 to findUsers.length
//~		filterIn = 0
//~		if (findUsers[i].id > 0)
//~			if (searchString$ = "")
//~				filterIn = 1
//~			else
//~				if (FindString(findUsers[i].username$, searchString$) > 0) then filterIn = 1
//~			endif
//~			if (filterIn = 1)
//~				sortKeyType$ = "string"
//~				sortValue$ = lower(findUsers[i].username$)
//~				findUsersSorted[filterCount].sortKey$ = sortValue$
//~				findUsersSorted[filterCount].iteration = findUsers[i].iteration
//~				findUsersDelimitedIDs$ = findUsersDelimitedIDs$ + "|" + str(findUsers[i].id) + "|"
//~				inc filterCount
//~			endif
//~		endif
//~	next
//~	if (filterCount > 0)
//~		findUsersSorted.length = filterCount - 1
//~		findUsersSorted.sort()
//~	endif
//~endfunction

function SortLockedUsers(searchString$ as string)
	local a as integer
	local cappedLockedUsers as integer
	local char$ as string
	local doubleUpCards# as float
	local filterInFlag as integer
	local filterInType as integer
	local freezeCards# as float
	local greenCards# as float
	local greenPercentage# as float
	local i as integer
	local j as integer
	local negativeNumber as integer
	local newValue$ as string
	local redCards# as float
	local resetCards# as float
	local secondsSinceLastCheckIn as integer
	local sortKeyType$ as string
	local sortValue$ as string
	local totalCards# as float
	local yellowCards# as float
	
	sharedLockUsersSorted.length = sharedLocks[sharedLockSelected, 0].lockedUsers
	filterCount = 0
	if (sharedLocks[sharedLockSelected, 0].lockedUsers > 199)
		cappedLockedUsers = 199
	else
		cappedLockedUsers = sharedLocks[sharedLockSelected, 0].lockedUsers
	endif
	for i = 1 to cappedLockedUsers
		negativeNumber = 0
		filterInFlag = 0
		filterInType = 0
		if (sharedLocks[sharedLockSelected, 1].usersID[i] > 0)
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagAll" or filterLockedUsersByFlag$ = "") then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlack" and usersFlag1.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagBlue" and usersFlag2.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagGreen" and usersFlag3.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagOrange" and usersFlag4.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagPurple"  and usersFlag5.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagRed"  and usersFlag6.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersByFlag$ = "FilterLockedUsersFlagYellow"  and usersFlag7.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInFlag = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersAll" or filterLockedUsersBy$ = "") then filterInType = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersAwaitingDecision" and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[i] = 1) then filterInType = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersFavourites" and favouriteUsers.find(sharedLocks[sharedLockSelected, 1].usersID[i]) <> -1) then filterInType = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersFrozen" and (sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[i] or sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[i])) then filterInType = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersLateCheckIns")
				if (sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[i] = 0)
					secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[i]
				else
					secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[i]
				endif
				if (sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[i] = 0)
					if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[i] > sharedLocks[sharedLockSelected, 0].regularity# * 3600) then filterInType = 1
				else
					if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[i] > sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[i]) then filterInType = 1
				endif
			endif
			if (filterLockedUsersBy$ = "FilterLockedUsersMultipleKeyholders" and sharedLocks[sharedLockSelected, 1].usersNoOfKeyholders[i] > 1) then filterInType = 1
			if (filterLockedUsersBy$ = "FilterLockedUsersTestLocks" and sharedLocks[sharedLockSelected, 1].usersTestLock[i] = 1) then filterInType = 1
			if (filterLockedUsersExcludeTestLocks = 1 and sharedLocks[sharedLockSelected, 1].usersTestLock[i] = 1) then filterInType = 0
			if (filterInFlag = 1 and filterInType = 1 and searchString$ <> "")
				filterInFlag = 0
				filterInType = 0
				if (FindString(sharedLocks[sharedLockSelected, 1].usersUsername$[i], searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
			endif
			if (filterInFlag = 1 and filterInType = 1)
				sortValue$ = "0"
				if (sortLockedUsersBy$ = "SortLockedUsersByChanceOfGreen")
					sortKeyType$ = "integer"
					greenCards# = sharedLocks[sharedLockSelected, 1].usersGreenCards[i]
					redCards# = sharedLocks[sharedLockSelected, 1].usersRedCards[i]
					yellowCards# = 0
					for j = 1 to 5
						yellowCards# = yellowCards# + sharedLocks[sharedLockSelected, 1].usersYellowCards[i, j]
					next
					freezeCards# = sharedLocks[sharedLockSelected, 1].usersFreezeCards[i]
					doubleUpCards# = sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[i]
					resetCards# = sharedLocks[sharedLockSelected, 1].usersResetCards[i]
					totalCards# = greenCards# + redCards# + yellowCards# + freezeCards# + doubleUpCards# + resetCards#
					greenPercentage# = (greenCards# / totalCards#) * 100
					sortValue$ = str(greenPercentage#, 3)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByDurationLocked")
					sortKeyType$ = "integer"
					sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[i])
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByLastOnline")
					sortKeyType$ = "integer"
					sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[i])
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByLastPicked")
					sortKeyType$ = "integer"
					if (sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[i] = 0)
						sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[i])
					else
						sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[i])
					endif
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByLastUpdated")
					sortKeyType$ = "integer"
					if (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[i] = 0)
						sortValue$ = "9999999999"
					else
						sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[i])
					endif
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByLateCheckIns")
					sortKeyType$ = "integer"
					sortValue$ = "9999999999"
					if (sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[i] = 0)
						sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[i])
					else
						sortValue$ = str(timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[i])
					endif
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByRandom")
					sortKeyType$ = "integer"
					sortValue$ = str(i)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUserRating")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[i], 3)
				endif
				if (sortLockedUsersBy$ = "SortLockedUsersByUsername")
					sortKeyType$ = "string"
					sortValue$ = lower(sharedLocks[sharedLockSelected, 1].usersUsername$[i])
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				sharedLockUsersSorted[filterCount].sortKey$ = sortValue$
				sharedLockUsersSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		sharedLockUsersSorted.length = filterCount - 1
		if (sortLockedUsersBy$ <> "SortLockedUsersByRandom")
			sharedLockUsersSorted.sort()
			if (sortLockedUsersOrder$ = "DESC") then sharedLockUsersSorted.reverse()
		endif
		sharedLockUsersSorted.length = 200
	endif
endfunction

function SortLog()
	local a as integer
	local char$ as string
	local filterIn as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	lockLogSorted.length = locks[lockSelected].lockLog.length
	filterCount = 0
	for i = 0 to locks[lockSelected].lockLog.length
		negativeNumber = 0
		filterIn = 0
		if (locks[lockSelected].lockLog[i].id > 0)
			if (filterLogBy$ = "FilterLogAll" or filterLogBy$ = "") then filterIn = 1
			if (filterLogBy$ = "FilterLogCardsAdded" and locks[lockSelected].lockLog[i].action$ = "AddedCards" and locks[lockSelected].lockLog[i].hidden = 0) then filterIn = 1
			if (filterLogBy$ = "FilterLogCardsPicked" and locks[lockSelected].lockLog[i].action$ = "PickedACard") then filterIn = 1
			if (filterLogBy$ = "FilterLogCardsRemoved" and locks[lockSelected].lockLog[i].action$ = "RemovedCards" and locks[lockSelected].lockLog[i].hidden = 0) then filterIn = 1
			if (filterLogBy$ = "FilterLogCheckIns" and locks[lockSelected].lockLog[i].action$ = "CheckedIn") then filterIn = 1
			if (filterLogBy$ = "FilterLogDecisions" and locks[lockSelected].lockLog[i].action$ = "Decision") then filterIn = 1
			if (filterLogBy$ = "FilterLogFreezeUnfreeze" and locks[lockSelected].lockLog[i].action$ = "CardFreezeStarted") then filterIn = 1
			if (filterLogBy$ = "FilterLogFreezeUnfreeze" and locks[lockSelected].lockLog[i].action$ = "CardFreezeEnded") then filterIn = 1
			if (filterLogBy$ = "FilterLogFreezeUnfreeze" and locks[lockSelected].lockLog[i].action$ = "KeyholderFreezeStarted") then filterIn = 1
			if (filterLogBy$ = "FilterLogFreezeUnfreeze" and locks[lockSelected].lockLog[i].action$ = "KeyholderFreezeEnded") then filterIn = 1
			if (filterLogBy$ = "FilterLogKeyholderUpdates" and locks[lockSelected].lockLog[i].actionedBY$ = "Keyholder") then filterIn = 1
			if (filterLogBy$ = "FilterLogLockResets" and locks[lockSelected].lockLog[i].action$ = "AutoResetLock") then filterIn = 1
			if (filterLogBy$ = "FilterLogLockResets" and locks[lockSelected].lockLog[i].action$ = "Decision" and locks[lockSelected].lockLog[i].result$ = "ResetLock") then filterIn = 1
			if (filterLogBy$ = "FilterLogLockResets" and locks[lockSelected].lockLog[i].action$ = "Decision" and locks[lockSelected].lockLog[i].result$ = "ResetLockWithSurpriseMe") then filterIn = 1
			if (filterLogBy$ = "FilterLogLockResets" and locks[lockSelected].lockLog[i].action$ = "KeyholderUpdate" and locks[lockSelected].lockLog[i].result$ = "ResetLock") then filterIn = 1
			if (filterLogBy$ = "FilterLogLockResets" and locks[lockSelected].lockLog[i].action$ = "PickedACard" and locks[lockSelected].lockLog[i].result$ = "ResetCard") then filterIn = 1
			if (filterLogBy$ = "FilterLogMoodEmojis" and locks[lockSelected].lockLog[i].action$ = "SetMoodEmoji") then filterIn = 1
			if (filterLogBy$ = "FilterLogReadyToUnlock" and locks[lockSelected].lockLog[i].action$ = "Decision" and locks[lockSelected].lockLog[i].result$ = "DecideLater") then filterIn = 1
			if (filterLogBy$ = "FilterLogReadyToUnlock" and locks[lockSelected].lockLog[i].action$ = "ReadyToUnlock" and locks[lockSelected].lockLog[i].result$ = "DecideLater") then filterIn = 1
			if (filterLogBy$ = "FilterLogStartEnd" and locks[lockSelected].lockLog[i].action$ = "StartedLock") then filterIn = 1
			if (filterLogBy$ = "FilterLogStartEnd" and locks[lockSelected].lockLog[i].action$ = "UnlockedLock") then filterIn = 1
			if (filterLogBy$ = "FilterLogTimeAdded" and locks[lockSelected].lockLog[i].action$ = "AddedTime" and locks[lockSelected].lockLog[i].hidden = 0) then filterIn = 1
			if (filterLogBy$ = "FilterLogTimeRemoved" and locks[lockSelected].lockLog[i].action$ = "RemovedTime" and locks[lockSelected].lockLog[i].hidden = 0) then filterIn = 1
			if (filterIn = 1)
				sortValue$ = "0"
				if (sortLogBy$ = "SortLogByTime")
					sortKeyType$ = "integer"
					sortValue$ = str(locks[lockSelected].lockLog[i].timestamp)
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				lockLogSorted[filterCount].sortKey$ = sortValue$
				lockLogSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		lockLogSorted.length = filterCount - 1
		lockLogSorted.sort()
		if (sortLogOrder$ = "ASC") then lockLogSorted.reverse()
	endif
endfunction
					
function SortMyLocks(searchString$ as string)
	local a as integer
	local char$ as string
	local filterInFlag as integer
	local filterInType as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	locksSorted.length = noOfLocks
	filterCount = 0
	for i = 1 to noOfLocks
		negativeNumber = 0
		filterInFlag = 0
		filterInType = 0
		if (locks[i].id > 0)
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagAll" or filterMyLocksByFlag$ = "") then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlack" and locks[i].flagChosen = 1) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagBlue" and locks[i].flagChosen = 2) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagGreen" and locks[i].flagChosen = 3) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagOrange" and locks[i].flagChosen = 4) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagPurple" and locks[i].flagChosen = 5) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagRed" and locks[i].flagChosen = 6) then filterInFlag = 1
			if (filterMyLocksByFlag$ = "FilterMyLocksFlagYellow" and locks[i].flagChosen = 7) then filterInFlag = 1
			if (filterMyLocksBy$ = "FilterMyLocksAll" or filterMyLocksBy$ = "") then filterInType = 1
			if (filterMyLocksBy$ = "FilterMyLocksFixed" and locks[i].fixed = 1 and locks[i].unlocked = 0) then filterInType = 1
			if (filterMyLocksBy$ = "FilterMyLocksVariable" and locks[i].fixed = 0 and locks[i].unlocked = 0) then filterInType = 1
			if (filterMyLocksBy$ = "FilterMyLocksActive" and locks[i].unlocked = 0) then filterInType = 1
			if (filterMyLocksBy$ = "FilterMyLocksReadyToPick" and locks[i].fixed = 0 and locks[i].unlocked = 0 and locks[i].lockFrozenByCard = 0 and locks[i].lockFrozenByKeyholder = 0)
				if (locks[i].regularity# = 0.016667 and (locks[i].timestampLastPicked + 60) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 0.25 and (locks[i].timestampLastPicked + 900) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 0.50 and (locks[i].timestampLastPicked + 1800) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 1 and (locks[i].timestampLastPicked + 3600) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 3 and (locks[i].timestampLastPicked + 10800) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 6 and (locks[i].timestampLastPicked + 21600) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 12 and (locks[i].timestampLastPicked + 43200) - timestampNow <= 0) then filterInType = 1
				if (locks[i].regularity# = 24 and (locks[i].timestampLastPicked + 86400) - timestampNow <= 0) then filterInType = 1		
			endif		
			if (filterMyLocksBy$ = "FilterMyLocksReadyToUnlock" and locks[i].readyToUnlock = 1 and locks[i].unlocked = 0) then filterInType = 1
			if (filterMyLocksBy$ = "FilterMyLocksUnlocked" and locks[i].unlocked = 1) then filterInType = 1
			if (filterInFlag = 1 and filterInType = 1 and searchString$ <> "")
				filterInFlag = 0
				filterInType = 0
				if (FindString(locks[i].keyholderUsername$, searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
				if (FindString(locks[i].lockName$, searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
				lockID$ as string
				if (locks[i].build < 195)
					// LOCKS CREATED BEFORE 2.5.2.ALPHA.4
					lockID$ = str(locks[i].groupID)
				else
					// NEW LOCKS CREATED IN OR AFTER 2.5.2.ALPHA.4
					lockID$ = str(locks[i].groupID) + AddLeadingZeros(str(locks[i].id - locks[i].groupID), 2)
				endif
				if (FindString(lockID$, searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
				if (FindString(str(locks[i].groupID), searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
			endif
			if (filterInFlag = 1 and filterInType = 1)
				sortValue$ = "0"
				if (sortMyLocksBy$ = "SortMyLocksByCreated")
					sortKeyType$ = "integer"
					sortValue$ = str(locks[i].groupID)
				endif
				if (sortMyLocksBy$ = "SortMyLocksByDuration")
					sortKeyType$ = "integer"
					if (locks[i].unlocked = 0)
						sortValue$ = str(timestampNow - locks[i].timestampLocked)
					else
						sortValue$ = str(locks[i].timestampUnlocked - locks[i].timestampLocked)
					endif
				endif
				if (sortMyLocksBy$ = "SortMyLocksByTimeLeft")
					sortKeyType$ = "integer"
					if (locks[i].unlocked = 0)
						if (locks[i].fixed = 0)
							if (locks[i].regularity# = 0.016667) then sortValue$ = str((locks[i].timestampLastPicked + 60) - timestampNow)
							if (locks[i].regularity# = 0.25) then sortValue$ = str((locks[i].timestampLastPicked + 900) - timestampNow)
							if (locks[i].regularity# = 0.50) then sortValue$ = str((locks[i].timestampLastPicked + 1800) - timestampNow)
							if (locks[i].regularity# = 1) then sortValue$ = str((locks[i].timestampLastPicked + 3600) - timestampNow)
							if (locks[i].regularity# = 3) then sortValue$ = str((locks[i].timestampLastPicked + 10800) - timestampNow)
							if (locks[i].regularity# = 6) then sortValue$ = str((locks[i].timestampLastPicked + 21600) - timestampNow)
							if (locks[i].regularity# = 12) then sortValue$ = str((locks[i].timestampLastPicked + 43200) - timestampNow)
							if (locks[i].regularity# = 24) then sortValue$ = str((locks[i].timestampLastPicked + 86400) - timestampNow)
						else
							if (locks[i].regularity# = 0.016667) then sortValue$ = str((locks[i].timestampLocked + (60 * locks[i].minutes)) - timestampNow)
							if (locks[i].regularity# = 0.25) then sortValue$ = str((locks[i].timestampLocked + (900 * locks[i].redCards)) - timestampNow)
							if (locks[i].regularity# = 1) then sortValue$ = str((locks[i].timestampLocked + (3600 * locks[i].redCards)) - timestampNow)
							if (locks[i].regularity# = 24) then sortValue$ = str((locks[i].timestampLocked + (86400 * locks[i].redCards)) - timestampNow)
							if (locks[i].timerHidden = 1) then sortValue$ = "1999999998"
						endif
					else
						sortValue$ = "-" + str(locks[i].timestampUnlocked)
					endif
					if (locks[i].readyToUnlock = 1) then sortValue$ = str(locks[i].id)
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 1 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				locksSorted[filterCount].sortKey$ = sortValue$
				locksSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		locksSorted.length = filterCount - 1
		locksSorted.sort()
		if (sortMyLocksOrder$ = "DESC") then locksSorted.reverse()
		locksSorted.length = 20
	endif
endfunction

function SortOthersFollowing(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	othersFriends.followingDelimitedIDs$ = ""
	othersFriends.followingSorted.length = othersFriends.following.length
	filterCount = 0
	for i = 0 to othersFriends.following.length
		filterIn = 0
		if (othersFriends.following[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(othersFriends.following[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(othersFriends.following[i].username$)
				othersFriends.followingSorted[filterCount].sortKey$ = sortValue$
				othersFriends.followingSorted[filterCount].iteration = othersFriends.following[i].iteration
				othersFriends.followingDelimitedIDs$ = othersFriends.followingDelimitedIDs$ + "|" + str(othersFriends.following[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		othersFriends.followingSorted.length = filterCount - 1
		othersFriends.followingSorted.sort()
	endif
endfunction

function SortOthersFollowers(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	othersFriends.followersDelimitedIDs$ = ""
	othersFriends.followersSorted.length = othersFriends.followers.length
	filterCount = 0
	for i = 0 to othersFriends.followers.length
		filterIn = 0
		if (othersFriends.followers[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(othersFriends.followers[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(othersFriends.followers[i].username$)
				othersFriends.followersSorted[filterCount].sortKey$ = sortValue$
				othersFriends.followersSorted[filterCount].iteration = othersFriends.followers[i].iteration
				othersFriends.followersDelimitedIDs$ = othersFriends.followersDelimitedIDs$ + "|" + str(othersFriends.followers[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		othersFriends.followersSorted.length = filterCount - 1
		othersFriends.followersSorted.sort()
	endif
endfunction

function SortRecentActivity()
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	recentActivitySorted.length = recentActivity.length
	filterCount = 0
	for i = 0 to recentActivity.length
		filterIn = 0
		if (recentActivity[i].id > 0)
			if (filterRecentActivityBy$ = "FilterRecentActivityAll" or filterRecentActivityBy$ = "") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder" and recentActivity[i].activityType$ = "LoadedSharedLock") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder" and recentActivity[i].activityType$ = "LockeeAbandonedLock") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder" and recentActivity[i].activityType$ = "LockeeFinishedLock") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsKeyholder" and recentActivity[i].activityType$ = "RequestKeyholdersDecision") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsLockee" and recentActivity[i].activityType$ = "KeyholderUnlockedLock") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityAsLockee" and recentActivity[i].activityType$ = "KeyholderUpdatedLock") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityFollows" and recentActivity[i].activityType$ = "NewFollow") then filterIn = 1
			if (filterRecentActivityBy$ = "FilterRecentActivityFollows" and recentActivity[i].activityType$ = "NewFollowRequest") then filterIn = 1
			if (FindRelation("blockedByYou", recentActivity[i].mentionedUserID) = 1) then filterIn = 0
			if (filterIn = 1)
				sortKeyType$ = "integer"
				sortValue$ = str(recentActivity[i].timestamp)
				recentActivitySorted[filterCount].sortKey$ = sortValue$
				recentActivitySorted[filterCount].iteration = recentActivity[i].iteration
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		recentActivitySorted.length = filterCount - 1
		recentActivitySorted.sort()
		recentActivitySorted.reverse()
	endif
endfunction

function SortSharedLocks(searchString$ as string)
	local a as integer
	local char$ as string
	local filterIn as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	sharedLocksSorted.length = noOfSharedLocks
	filterCount = 0
	for i = 1 to noOfSharedLocks
		negativeNumber = 0
		filterIn = 0
		if (sharedLocks[i, 0].shareID$ <> "")
			if (filterSharedLocksBy$ = "FilterSharedLocksAll" or filterSharedLocksBy$ = "") then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksFixed" and sharedLocks[i, 0].fixed = 1) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksVariable" and sharedLocks[i, 0].fixed = 0) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedExcludingTest" and sharedLocks[i, 0].lockedUsersExcludingTest > 0) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest" and sharedLocks[i, 0].lockedUsers > 0) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingDecision" and sharedLocks[i, 0].awaitingDecision > 0) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksAwaitingRating" and (sharedLocks[i, 0].desertedUsersAwaitingRating > 0 or sharedLocks[i, 0].unlockedUsersAwaitingRating > 0)) then filterIn = 1
			if (filterSharedLocksBy$ = "FilterSharedLocksTemporarilyDisabled" and sharedLocks[i, 0].temporarilyDisabled = 1) then filterIn = 1
			if (filterIn = 1 and searchString$ <> "")
				filterIn = 0
				if (FindString(sharedLocks[i, 0].lockName$, searchString$) > 0) then filterIn = 1
				if (FindString(sharedLocks[i, 0].shareID$, searchString$) > 0) then filterIn = 1
				if (FindString(sharedLocks[i, 0].desertedUsersDelimited$, searchString$) > 0) then filterIn = 1
				if (FindString(sharedLocks[i, 0].lockedUsersDelimited$, searchString$) > 0) then filterIn = 1
				if (FindString(sharedLocks[i, 0].unlockedUsersDelimited$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortValue$ = "0"
				if (sortSharedLocksBy$ = "SortSharedLocksByCreated")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[i, 0].id)
				endif
				if (sortSharedLocksBy$ = "SortSharedLocksByName")
					sortKeyType$ = "string"
					sortValue$ = lower(sharedLocks[i, 0].lockName$)
				endif
				if (sortSharedLocksBy$ = "SortSharedLocksByRating")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[i, 0].lockRating#, 3)
				endif
				if (sortSharedLocksBy$ = "SortSharedLocksByUserCount")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[i, 0].lockedUsers - sharedLocks[i, 0].fakeLockedUsers)
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				sharedLocksSorted[filterCount].sortKey$ = sortValue$
				sharedLocksSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		sharedLocksSorted.length = filterCount - 1
		sharedLocksSorted.sort()
		if (sortSharedLocksOrder$ = "DESC") then sharedLocksSorted.reverse()
		sharedLocksSorted.length = 200
	endif
endfunction
			
function SortUnlockedUsers(searchString$ as string)
	local a as integer
	local cappedUnlockedUsers as integer
	local char$ as string
	local filterInFlag as integer
	local filterInType as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	sharedLockUsersSorted.length = sharedLocks[sharedLockSelected, 0].unlockedUsers
	filterCount = 0
	if (sharedLocks[sharedLockSelected, 0].unlockedUsers > 199)
		cappedUnlockedUsers = 199
	else
		cappedUnlockedUsers = sharedLocks[sharedLockSelected, 0].unlockedUsers
	endif
	for i = 1 to cappedUnlockedUsers
		negativeNumber = 0
		filterInFlag = 0
		filterInType = 0
		if (sharedLocks[sharedLockSelected, 2].usersID[i] > 0)
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagAll" or filterUnlockedUsersByFlag$ = "") then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlack" and usersFlag1.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagBlue" and usersFlag2.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagGreen" and usersFlag3.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagOrange" and usersFlag4.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagPurple"  and usersFlag5.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagRed"  and usersFlag6.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagYellow"  and usersFlag7.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInFlag = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersAll" or filterUnlockedUsersBy$ = "") then filterInType = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersAwaitingRating" and sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[i] = 0 and timestampNow - sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[i] <= 604800) then filterInType = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersFavourites" and favouriteUsers.find(sharedLocks[sharedLockSelected, 2].usersID[i]) <> -1) then filterInType = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersUsedKey" and sharedLocks[sharedLockSelected, 2].usersUsedKey[i] = 1) then filterInType = 1
			if (filterUnlockedUsersBy$ = "FilterUnlockedUsersTestLocks" and sharedLocks[sharedLockSelected, 2].usersTestLock[i] = 1) then filterInType = 1
			if (filterUnlockedUsersExcludeTestLocks = 1 and sharedLocks[sharedLockSelected, 2].usersTestLock[i] = 1) then filterInType = 0
			if (filterInFlag = 1 and filterInType = 1 and searchString$ <> "")
				filterInFlag = 0
				filterInType = 0
				if (FindString(sharedLocks[sharedLockSelected, 2].usersUsername$[i], searchString$) > 0)
					filterInFlag = 1
					filterInType = 1
				endif
			endif
			if (filterInFlag = 1 and filterInType = 1)
				sortValue$ = "0"
				if (sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[i])
				endif
				if (sortUnlockedUsersBy$ = "SortUnlockedUsersByDurationLocked")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[i] - sharedLocks[sharedLockSelected, 2].usersTimestampLocked[i])
				endif
				if (sortUnlockedUsersBy$ = "SortUnlockedUsersByRandom")
					sortKeyType$ = "integer"
					sortValue$ = str(i)
				endif
				if (sortUnlockedUsersBy$ = "SortUnlockedUsersByUserRating")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[i], 3)
				endif
				if (sortUnlockedUsersBy$ = "SortUnlockedUsersByUsername")
					sortKeyType$ = "string"
					sortValue$ = lower(sharedLocks[sharedLockSelected, 2].usersUsername$[i])
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				sharedLockUsersSorted[filterCount].sortKey$ = sortValue$
				sharedLockUsersSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		sharedLockUsersSorted.length = filterCount - 1
		if (sortUnlockedUsersBy$ <> "SortUnlockedUsersByRandom")
			sharedLockUsersSorted.sort()
			if (sortUnlockedUsersOrder$ = "DESC") then sharedLockUsersSorted.reverse()
		endif
		sharedLockUsersSorted.length = 200
	endif
endfunction

function SortUsersLog(sharedLockNo, usersTab, userNo)
	local a as integer
	local char$ as string
	local filterIn as integer
	local i as integer
	local negativeNumber as integer
	local newValue$ as string
	local sortKeyType$ as string
	local sortValue$ as string
	
	usersLogSorted.length = sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length
	filterCount = 0
	for i = 0 to sharedLocks[sharedLockNo, usersTab].usersLog[userNo].length
		negativeNumber = 0
		filterIn = 0
		if (sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].id > 0)
			if (filterUsersLogBy$ = "FilterUsersLogAll" or filterUsersLogBy$ = "") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogCardsAdded" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "AddedCards") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogCardsPicked" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "PickedACard") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogCardsRemoved" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "RemovedCards") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogCheckIns" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "CheckedIn") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogDecisions" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "Decision") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "CardFreezeStarted") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "CardFreezeEnded") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "KeyholderFreezeStarted") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogFreezeUnfreeze" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "KeyholderFreezeEnded") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogKeyholderUpdates" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].actionedBY$ = "Keyholder") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogLockResets" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "AutoResetLock") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogLockResets" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "Decision" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "ResetLock") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogLockResets" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "Decision" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "ResetLockWithSurpriseMe") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogLockResets" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "KeyholderUpdate" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "ResetLock") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogLockResets" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "PickedACard" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "ResetCard") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogMoodEmojis" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "SetMoodEmoji") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogReadyToUnlock" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "Decision" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "DecideLater") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogReadyToUnlock" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "ReadyToUnlock" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].result$ = "DecideLater") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogStartEnd" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "StartedLock") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogStartEnd" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "UnlockedLock") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogTimeAdded" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "AddedTime") then filterIn = 1
			if (filterUsersLogBy$ = "FilterUsersLogTimeRemoved" and sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].action$ = "RemovedTime") then filterIn = 1			
			if (filterIn = 1)
				sortValue$ = "0"
				if (sortUsersLogBy$ = "SortUsersLogByTime")
					sortKeyType$ = "integer"
					sortValue$ = str(sharedLocks[sharedLockNo, usersTab].usersLog[userNo, i].timestamp)
				endif
				if (sortKeyType$ = "integer")
					if (val(sortValue$) < 0)
						negativeNumber = 1
						newValue$ = ""
						for a = 0 to len(sortValue$)
							char$ = mid(sortValue$, a, 1)
							if (char$ = "9")
								char$ = "1"
							elseif (char$ = "8")
								char$ = "2"
							elseif (char$ = "7")
								char$ = "3"
							elseif (char$ = "6")
								char$ = "4"
							elseif (char$ = "4")
								char$ = "6"
							elseif (char$ = "3")
								char$ = "7"
							elseif (char$ = "2")
								char$ = "8"
							elseif (char$ = "1")
								char$ = "9"
							endif
							newValue$ = newValue$ + char$
						next
						sortValue$ = newValue$
					endif
					if (negativeNumber = 1)
						sortValue$ = "-" + AddLeadingZeros(ReplaceString(sortValue$, "-", "", -1), 10)
					else
						sortValue$ = AddLeadingZeros(sortValue$, 10)
					endif
				endif
				usersLogSorted[filterCount].sortKey$ = sortValue$
				usersLogSorted[filterCount].iteration = i
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		usersLogSorted.length = filterCount - 1
		usersLogSorted.sort()
		if (sortUsersLogOrder$ = "ASC") then usersLogSorted.reverse()
	endif
endfunction

function SortYourBlockedUsers(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	yourFriends.blockedByYouDelimitedIDs$ = ""
	yourFriends.blockedByYouSorted.length = yourFriends.blockedByYou.length
	filterCount = 0
	for i = 0 to yourFriends.blockedByYou.length
		filterIn = 0
		if (yourFriends.blockedByYou[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(yourFriends.blockedByYou[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(yourFriends.blockedByYou[i].username$)
				yourFriends.blockedByYouSorted[filterCount].sortKey$ = sortValue$
				yourFriends.blockedByYouSorted[filterCount].iteration = yourFriends.blockedByYou[i].iteration
				yourFriends.blockedByYouDelimitedIDs$ = yourFriends.blockedByYouDelimitedIDs$ + "|" + str(yourFriends.blockedByYou[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		yourFriends.blockedByYouSorted.length = filterCount - 1
		yourFriends.blockedByYouSorted.sort()
	endif
endfunction

function SortYourFollowers(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	yourFriends.followersDelimitedIDs$ = ""
	yourFriends.followersSorted.length = yourFriends.followers.length
	filterCount = 0
	for i = 0 to yourFriends.followers.length
		filterIn = 0
		if (yourFriends.followers[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(yourFriends.followers[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(yourFriends.followers[i].username$)
				yourFriends.followersSorted[filterCount].sortKey$ = sortValue$
				yourFriends.followersSorted[filterCount].iteration = yourFriends.followers[i].iteration
				yourFriends.followersDelimitedIDs$ = yourFriends.followersDelimitedIDs$ + "|" + str(yourFriends.followers[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		yourFriends.followersSorted.length = filterCount - 1
		yourFriends.followersSorted.sort()
	endif
endfunction

function SortYourFollowing(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	yourFriends.followingDelimitedIDs$ = ""
	yourFriends.followingSorted.length = yourFriends.following.length
	filterCount = 0
	for i = 0 to yourFriends.following.length
		filterIn = 0
		if (yourFriends.following[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(yourFriends.following[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(yourFriends.following[i].username$)
				yourFriends.followingSorted[filterCount].sortKey$ = sortValue$
				yourFriends.followingSorted[filterCount].iteration = yourFriends.following[i].iteration
				yourFriends.followingDelimitedIDs$ = yourFriends.followingDelimitedIDs$ + "|" + str(yourFriends.following[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		yourFriends.followingSorted.length = filterCount - 1
		yourFriends.followingSorted.sort()
	endif
endfunction

function SortYourFollowRequests(searchString$ as string)
	local filterIn as integer
	local i as integer
	local sortKeyType$ as string
	local sortValue$ as string
	
	yourFriends.pendingByYouDelimitedIDs$ = ""
	yourFriends.pendingByYouSorted.length = yourFriends.pendingByYou.length
	filterCount = 0
	for i = 0 to yourFriends.pendingByYou.length
		filterIn = 0
		if (yourFriends.pendingByYou[i].id > 0)
			if (searchString$ = "")
				filterIn = 1
			else
				if (FindString(yourFriends.pendingByYou[i].username$, searchString$) > 0) then filterIn = 1
			endif
			if (filterIn = 1)
				sortKeyType$ = "string"
				sortValue$ = lower(yourFriends.pendingByYou[i].username$)
				yourFriends.pendingByYouSorted[filterCount].sortKey$ = sortValue$
				yourFriends.pendingByYouSorted[filterCount].iteration = yourFriends.pendingByYou[i].iteration
				yourFriends.pendingByYouDelimitedIDs$ = yourFriends.pendingByYouDelimitedIDs$ + "|" + str(yourFriends.pendingByYou[i].id) + "|"
				inc filterCount
			endif
		endif
	next
	if (filterCount > 0)
		yourFriends.pendingByYouSorted.length = filterCount - 1
		yourFriends.pendingByYouSorted.sort()
	endif
endfunction

function SplitSingleLogRow(logRow$)
	local a as integer
	local parameter$ as string
	local value$ as string
	local variable$ as string
	
	singleLogRow.action$ = ""
	singleLogRow.actionedBy$ = ""
	singleLogRow.private = 0
	singleLogRow.result$ = ""
	singleLogRow.totalActionTime = 0
	for a = 1 to CountStringTokens(logRow$, ";")
		parameter$ = GetStringToken(logRow$, ";", a)
		variable$ = lower(TrimString(GetStringToken(parameter$, ":", 1), " "))
		value$ = GetStringToken(parameter$, ":", 2)
		if (variable$ = "action")
			singleLogRow.action$ = value$
		elseif (variable$ = "actionedby")
			singleLogRow.actionedBy$ = value$
		elseif (variable$ = "private")
			singleLogRow.private = val(value$)
		elseif (variable$ = "result")
			singleLogRow.result$ = value$
		elseif (variable$ = "totalactiontime")
			singleLogRow.totalActionTime = val(value$)
		endif
	next
endfunction

function UnblockUser(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UnblockUser=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UnblockUser + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UnfollowUser(profileID as integer, addToFront as integer)
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&profileID=" + str(profileID)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UnfollowUser=" + str(profileID) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UnfollowUser + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UnlockLock(lockNo, unlockedBy$, unlockedHow$)
	locks[lockNo].cardInfoHidden = 0
	locks[lockNo].timerHidden = 0
	locks[lockNo].greenCards = 0
	locks[lockNo].justUnlocked = 1
	locks[lockNo].lockFrozenByCard = 0
	locks[lockNo].lockFrozenByKeyholder = 0
	locks[lockNo].unlocked = 1
	locks[lockNo].readyToUnlock = 0
	locks[lockNo].timestampUnlocked = timestampNow
	locks[lockNo].dateUnlocked$ = dateFromServer$
	timestampLastUnlocked = timestampNow
	ResetAllNotifications()
	UpdateLocksData(lockNo)
	if (unlockedBy$ <> "" and unlockedHow$ <> "")
		UpdateLocksDatabase(lockNo, "action:UnlockedLock;actionedBy:" + unlockedBy$ + ";result:" + unlockedHow$, 0)
		SetScreenToView(selectedLocksTab)
	else
		UpdateLocksDatabase(lockNo, "", 0)
	endif	
endfunction

function UnlockUsersLock(sharedLockNo, userNo, logData$, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	SplitSingleLogRow(logData$)
	postData$ = ""
	postData$ = postData$ + "&lockFrozenByKeyholderModifiedBy=" + str(sharedLocks[sharedLockNo, 1].usersLockFrozenByKeyholderModifiedBy[userNo])
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, 1].usersLockID[userNo])
	postData$ = postData$ + "&logAction=" + singleLogRow.action$
	postData$ = postData$ + "&logActionedBy=" + singleLogRow.actionedBy$
	postData$ = postData$ + "&logPrivate=" + str(singleLogRow.private)
	postData$ = postData$ + "&logResult=" + singleLogRow.result$
	postData$ = postData$ + "&logTotalActionTime=" + str(singleLogRow.totalActionTime)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&sharedID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&sharedUserID=" + str(sharedLocks[sharedLockNo, 1].usersID[userNo])
	postData$ = postData$ + "&timestampModified=" + str(timestampNow)
	postData$ = postData$ + "&unlocked=1"
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UnlockUsersLock=" + str(sharedLockNo) + "," + str(userNo) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UnlockUsersLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateAccount(addToFront)
	if (maintenance = 1) then exitfunction
	
	local notificationsDisabled as integer
	local postData$ as string
	
	if (notificationsOn = 1) then notificationsDisabled = 0
	if (notificationsOn = 2) then notificationsDisabled = 1
	postData$ = ""
	postData$ = postData$ + "&adsRemoved=" + str(adsRemoved)
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&deviceID=" + deviceID$
	postData$ = postData$ + "&mainRole=" + str(mainRoleSelected)
	postData$ = postData$ + "&noOfKeys=" + str(noOfKeys)
	postData$ = postData$ + "&noOfKeysPurchased=" + str(noOfKeysPurchased)
	postData$ = postData$ + "&noOfTimesReviewBoxShown=" + str(timesReviewBoxShown)
	postData$ = postData$ + "&notificationsDisabled=" + str(notificationsDisabled)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&pushNotificationToken=" + ReplaceString(pushNotificationToken$, ":", "[colon]", -1)
	postData$ = postData$ + "&privateProfile=" + str(privateProfile)
	postData$ = postData$ + "&showCombinationsToKeyholders=" + str(showCombinationsToKeyholders)
	postData$ = postData$ + "&showKeyholderStatsOnProfile=" + str(showKeyholderStatsOnProfile)
	postData$ = postData$ + "&showLockeeStatsOnProfile=" + str(showLockeeStatsOnProfile)
	postData$ = postData$ + "&status=" + str(statusSelected)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	postData$ = postData$ + "&visibleInPublicStats=" + str(visibleInPublicStats)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateAccount;script:" + URLs[0].URLPath + "/" + URLs[0].UpdateAccount + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateAPIProject(index, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&bot=" + str(apiProjects[index].bot)
	postData$ = postData$ + "&build=" + str(constBuildNumber)
	postData$ = postData$ + "&clientID=" + apiProjects[index].clientID$
	postData$ = postData$ + "&clientSecret=" + apiProjects[index].clientSecret$
	postData$ = postData$ + "&desktopApp=" + str(apiProjects[index].desktopApp)
	postData$ = postData$ + "&dontKnow=" + str(apiProjects[index].dontKnow)
	postData$ = postData$ + "&lockBox=" + str(apiProjects[index].lockBox)
	postData$ = postData$ + "&mobileApp=" + str(apiProjects[index].mobileApp)
	postData$ = postData$ + "&name=" + apiProjects[index].name$
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&somethingElse=" + str(apiProjects[index].somethingElse)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&version=" + ReplaceString(constVersionNumber$, " ", ".", -1)
	postData$ = postData$ + "&website=" + str(apiProjects[index].website)
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateAPIProject=" + str(index) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateAPIProject + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateItemsInAPIProjectCard(cardNo as integer, sortedIteration as integer, reposition as integer)
	local buttonsPlaced as integer
	local buttonX# as float
	local editButtonVisible as integer
	local leftEmptyButtonVisible as integer
	local leftWidth# as float
	local rightEmptyButtonVisible as integer
	local rightWidth# as float
	
	if (reposition = 1)
		OryUIUpdateText(apiProjectCard[cardNo].txtName, "text:" + apiProjects[sortedIteration].name$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopLeftOfSprite(apiProjectCard[cardNo].txtName, apiProjectCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 0.1)

		OryUIUpdateText(apiProjectCard[cardNo].txtClientID, "text:CLIENT ID" + chr(10) + apiProjects[sortedIteration].clientID$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToBottomLeftOfSprite(apiProjectCard[cardNo].txtClientID, apiProjectCard[cardNo].sprBackground, 2 / GetDisplayAspect(), -0.5)					
		if (apiProjects[sortedIteration].banned = 1)
			OryUIUpdateText(apiProjectCard[cardNo].txtBanned, "text:BANNED;angle:" + str(random(-5, 5)) + ";color:192,57,42,255")
			OryUIPinTextToCentreOfSprite(apiProjectCard[cardNo].txtBanned, apiProjectCard[cardNo].sprBackground, 0, 0)					
		else
			OryUIUpdateText(apiProjectCard[cardNo].txtBanned, "position:-1000,-1000")
		endif	
		leftEmptyButtonVisible = 1
		editButtonVisible = 0
		rightEmptyButtonVisible = 1
		buttonX# = 0
		buttonsPlaced = 0
		if (apiProjects[sortedIteration].banned = 0) then editButtonVisible = 1
		if (leftEmptyButtonVisible = 1)
			if (editButtonVisible = 0)
				leftWidth# = 100
			else
				leftWidth# = 45
			endif
			OryUIUpdateSprite(apiProjectCard[cardNo].sprLeftEmptyButton, "size:" + str(leftWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(apiProjectCard[cardNo].sprLeftEmptyButton, apiProjectCard[cardNo].sprButtonBar, buttonX#, 0.2)
			buttonX# = buttonX# + leftWidth#
		endif
		if (editButtonVisible = 1)
			OryUIUpdateSprite(apiProjectCard[cardNo].sprEditButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateSprite(apiProjectCard[cardNo].sprEditIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			OryUIPinSpriteToSprite(apiProjectCard[cardNo].sprEditButton, apiProjectCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(apiProjectCard[cardNo].sprEditIcon, apiProjectCard[cardNo].sprEditButton, 0, 0)
			buttonX# = buttonX# + 10
		endif
		if (rightEmptyButtonVisible = 1 and editButtonVisible = 1)
			rightWidth# = 45
			OryUIUpdateSprite(apiProjectCard[cardNo].sprRightEmptyButton, "size:" + str(rightWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(apiProjectCard[cardNo].sprRightEmptyButton, apiProjectCard[cardNo].sprButtonBar, buttonX#, 0.2)
			buttonX# = buttonX# + rightWidth#
		endif
	endif
endfunction

function UpdateItemsInDesertedUsersCard(cardNo as integer, sortedIteration as integer, reposition as integer)
	local a as integer
	local buttonsPlaced as integer
	local buttonX# as float
	local days$ as string
	local dd as integer
	local favouriteButtonVisible as integer
	local flagButtonVisible as integer
	local flagChosen as integer
	local hh as integer
	local hours$ as string
	local leftEmptyButtonVisible as integer
	local leftIconCount as integer
	local leftWidth# as float
	local minutes$ as string
	local moreButtonVisible as integer
	local mm as integer
	local noOfLeftButtons as integer
	local noOfRightButtons as integer
	local rightIconCount as integer
	local seconds$ as string
	local ss as integer

	if (reposition = 1)
		SetUsernameColorArray(sharedLocks[sharedLockSelected, 3].usersMainRole[sortedIteration], sharedLocks[sharedLockSelected, 3].usersMainRoleLevel[sortedIteration])
		OryUIUpdateText(userCard[cardNo].txtUsername, "text:" + sharedLocks[sharedLockSelected, 3].usersUsername$[sortedIteration] + ";color:" + str(usernameColor[0]) + "," + str(usernameColor[1]) + "," + str(usernameColor[2]) + "," + str(usernameColor[3]))
		OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtUsername, userCard[cardNo].sprBackground, 0, 0.2)
		OryUIUpdateSprite(userCard[cardNo].sprUsernameButton, "size:" + str(GetTextTotalWidth(userCard[cardNo].txtUsername)) + "," + str(GetTextTotalHeight(userCard[cardNo].txtUsername)) + ";offset:center;position:" + str(GetTextX(userCard[cardNo].txtUsername)) + "," + str(GetTextY(userCard[cardNo].txtUsername) + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		leftIconCount = 0
		if (sharedLocks[sharedLockSelected, 3].usersTestLock[sortedIteration] = 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprTestLock, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprTestLock) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		rightIconCount = 1
		if (sharedLocks[sharedLockSelected, 3].usersStatus[sortedIteration] = 0 or sharedLocks[sharedLockSelected, 3].usersStatus[sortedIteration] = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, 3].usersLastActive[sortedIteration] <= 900)
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusAvailableIcon) + ";alpha:255")
			else
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
			endif
		elseif (sharedLocks[sharedLockSelected, 3].usersStatus[sortedIteration] = 2)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusBusyIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 3].usersStatus[sortedIteration] = 3)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusSleepingIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 3].usersStatus[sortedIteration] = 4)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprStatus, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprStatus) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))

		if (sharedLocks[sharedLockSelected, 3].usersNoOfRatingsFromKeyholders[sortedIteration] >= 5)
			if (sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration] < 1.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 224, 36, 43, 255)
			elseif (sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration] < 2.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 243, 115, 37, 255)
			elseif (sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration] < 3.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 247, 204, 26, 255)
			elseif (sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration] < 4.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 115, 177, 67, 255)
			elseif (sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration] < 5.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 0, 128, 78, 255)
			endif
			OryUIUpdateSprite(userCard[cardNo].sprRatingRibbon, "alpha:255")
			OryUIUpdateText(userCard[cardNo].txtRatingRibbon, "text:" + str(sharedLocks[sharedLockSelected, 3].usersAverageRatingFromKeyholders#[sortedIteration], 1) + ";alpha:255")
			OryUIPinSpriteToTopRightOfSprite(userCard[cardNo].sprRatingRibbon, userCard[cardNo].sprBackground, 0.5, -0.2)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtRatingRibbon, userCard[cardNo].sprRatingRibbon, 0, -0.1)
		endif
	endif
	
	// TICKER
	dd = 0
	hh = 0
	mm = 0
	ss = 0
	
	dd = floor((sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[sortedIteration] - sharedLocks[sharedLockSelected, 3].usersTimestampLocked[sortedIteration]) / 60 / 60 / 24)
	hh = mod((sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[sortedIteration] - sharedLocks[sharedLockSelected, 3].usersTimestampLocked[sortedIteration]) / 60 / 60, 24)
	mm = mod((sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[sortedIteration] - sharedLocks[sharedLockSelected, 3].usersTimestampLocked[sortedIteration]) / 60, 60)
	ss = mod((sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[sortedIteration] - sharedLocks[sharedLockSelected, 3].usersTimestampLocked[sortedIteration]), 60)

	if (dd = 1)
		days$ = "1 day"
	else
		days$ = str(dd) + " days"
	endif	
	if (hh = 1)
		hours$ = "1 hour"
	else
		hours$ = str(hh) + " hours"
	endif
	if (mm = 1)
		minutes$ = "1 minute"
	else
		minutes$ = str(mm) + " minutes"
	endif
	if (ss = 1)
		seconds$ = "1 second"
	else
		seconds$ = str(ss) + " seconds"
	endif
	
	if (dd > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + days$ + ", " + hours$ + ", and " + minutes$ + chr(10) + "Deleted " + ReformatDateString(sharedLocks[sharedLockSelected, 3].usersDateDeleted$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (hh > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + hours$ + ", and " + minutes$ + chr(10) + "Deleted " + ReformatDateString(sharedLocks[sharedLockSelected, 3].usersDateDeleted$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (mm > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + minutes$ + chr(10) + "Deleted " + ReformatDateString(sharedLocks[sharedLockSelected, 3].usersDateDeleted$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (ss > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + seconds$ + chr(10) + "Deleted " + ReformatDateString(sharedLocks[sharedLockSelected, 3].usersDateDeleted$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	
	if (reposition = 1)
		OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtTicker, userCard[cardNo].sprBackground, 0, 3)
	endif

	// BUTTON BAR
	if (reposition = 1)
		leftEmptyButtonVisible = 1
		favouriteButtonVisible = 1
		flagButtonVisible = 1
		moreButtonVisible = 1
		buttonX# = 0
		buttonsPlaced = 0
		
		noOfLeftButtons = 0
		noOfRightButtons = favouriteButtonVisible + flagButtonVisible + moreButtonVisible
		if (leftEmptyButtonVisible = 1)
			leftWidth# = 100 - ((noOfLeftButtons + noOfRightButtons) * 10)
			OryUIUpdateSprite(userCard[cardNo].sprLeftEmptyButton, "size:" + str(leftWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(userCard[cardNo].sprLeftEmptyButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			buttonX# = buttonX# + leftWidth#
		endif
		if (favouriteButtonVisible = 1)
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			OryUIPinSpriteToSprite(userCard[cardNo].sprFavouriteButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFavouriteIcon, userCard[cardNo].sprFavouriteButton, 0, 0)
			buttonX# = buttonX# + 10
			if (favouriteUsers.find(sharedLocks[sharedLockSelected, 3].usersID[sortedIteration]) = -1)
				OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOff) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			else
				OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOn) + ";color:255,255,255,255")
			endif
		endif
		if (flagButtonVisible = 1)
			OryUIUpdateSprite(userCard[cardNo].sprFlagButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(userCard[cardNo].sprFlagButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFlagIcon, userCard[cardNo].sprFlagButton, 0, 0)
			buttonX# = buttonX# + 10
			flagChosen = GetFlagChosen(sharedLocks[sharedLockSelected, 3].usersID[sortedIteration])
			if (flagChosen = 0)
				OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			else
				OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[flagChosen]) + ";color:255,255,255,255")
			endif
		endif
		if (moreButtonVisible = 1)
			OryUIUpdateSprite(userCard[cardNo].sprMoreButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateSprite(userCard[cardNo].sprMoreIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			OryUIPinSpriteToSprite(userCard[cardNo].sprMoreButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprMoreIcon, userCard[cardNo].sprMoreButton, 0, 0)
		endif
	endif
	
	// RATING
	// If not rated and user unlocked less than 7 days ago, or if rated and was last updated 1 day ago then let keyholder rate lockee
	if (sharedLocks[sharedLockSelected, 3].usersTestLock[sortedIteration] = 0 and ((timestampNow - sharedLocks[sharedLockSelected, 3].usersTimestampDeleted[sortedIteration] <= 604800 and sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration] = 0) or (timestampNow - sharedLocks[sharedLockSelected, 3].usersTimestampKeyholderRated[sortedIteration] <= 86400 and sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration])))
		OryUIUpdateText(userCard[cardNo].txtRateUser, "text:Rate " + sharedLocks[sharedLockSelected, 3].usersUsername$[sortedIteration] + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, -1.5)
		for a = 1 to 5
			if (a <= sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration])
				OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOn))
			else
				OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOff))
			endif
			if (a = 1) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, -(2 * (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
			if (a = 2) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, -(GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
			if (a = 3) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, 0, 0.8)	
			if (a = 4) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
			if (a = 5) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, (2 * (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
		next
	else
		for a = 1 to 5
			OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "position:-1000,-1000")
		next
		if (sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration] = 0)
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text: ;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		elseif (sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration] = 1)
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text:You rated this 1 star;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		else
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text:You rated this " + str(sharedLocks[sharedLockSelected, 3].usersRatingFromKeyholder[sortedIteration]) + " stars;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		endif	
	endif
endfunction	

function UpdateItemsInGeneratedLocksCard(cardNo as integer, sortedIteration, reposition as integer)
	local average$ as string
	local averageDD as integer
	local averageHH as integer
	local best$ as string
	local bestDD as integer
	local bestHH as integer
	local worst$ as string
	local worstDD as integer
	local worstHH as integer
	local config$ as string
	local greensRequired$ as string
	local options$ as string
	
	if (reposition = 1)
		OryUIUpdateText(generatedLocksCard[cardNo].txtID, "text:ID " + str(generatedLocks[sortedIteration].id) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToTopRightOfSprite(generatedLocksCard[cardNo].txtID, generatedLocksCard[cardNo].sprBackground, -2.5, 0.5)
		
		config$ = ""
		if (generatedLocks[sortedIteration].regularity# = 0.25) then config$ = "Chance Every 15 Minutes"
		if (generatedLocks[sortedIteration].regularity# = 0.5) then config$ = "Chance Every 30 Minutes"
		if (generatedLocks[sortedIteration].regularity# = 1) then config$ = "Chance Every Hour"
		if (generatedLocks[sortedIteration].regularity# = 3) then config$ = "Chance Every 3 Hours"
		if (generatedLocks[sortedIteration].regularity# = 6) then config$ = "Chance Every 6 Hours"
		if (generatedLocks[sortedIteration].regularity# = 12) then config$ = "Chance Every 12 Hours"
		if (generatedLocks[sortedIteration].regularity# = 24) then config$ = "Chance Every Day"
		
		config$ = config$ + chr(10)
		if (generatedLocks[sortedIteration].multipleGreensRequired = 0) then greensRequired$ = "1 Required"
		if (generatedLocks[sortedIteration].multipleGreensRequired = 1) then greensRequired$ = "All Required"
		if (generatedLocks[sortedIteration].minRandomGreens = generatedLocks[sortedIteration].maxRandomGreens)
			if (generatedLocks[sortedIteration].maxRandomGreens = 1) then config$ = config$ + "1 Green (" + greensRequired$ + ") | "
			if (generatedLocks[sortedIteration].maxRandomGreens > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomGreens) + " Greens (" + greensRequired$ + ") | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomGreens) + "-" + str(generatedLocks[sortedIteration].maxRandomGreens) + " Greens (" + greensRequired$ + ") | "
		endif
		if (generatedLocks[sortedIteration].minRandomReds = generatedLocks[sortedIteration].maxRandomReds)
			if (generatedLocks[sortedIteration].maxRandomReds = 1) then config$ = config$ + "1 Red | "
			if (generatedLocks[sortedIteration].maxRandomReds > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomReds) + " Reds | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomReds) + "-" + str(generatedLocks[sortedIteration].maxRandomReds) + " Reds | "
		endif
		if (right(config$, 3) = " | ") then config$ = mid(config$, 1, len(config$) - 3)
		
		if (generatedLocks[sortedIteration].maxRandomYellows + generatedLocks[sortedIteration].maxRandomYellowsAdd + generatedLocks[sortedIteration].maxRandomYellowsMinus > 0)
			config$ = config$ + chr(10)
			config$ = config$ + "Yellows "
		endif
		if (generatedLocks[sortedIteration].minRandomYellows = generatedLocks[sortedIteration].maxRandomYellows)
			if (generatedLocks[sortedIteration].maxRandomYellows = 1) then config$ = config$ + "1 Random, "
			if (generatedLocks[sortedIteration].maxRandomYellows > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomYellows) + " Random, "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomYellows) + "-" + str(generatedLocks[sortedIteration].maxRandomYellows) + " Random, "
		endif
		if (generatedLocks[sortedIteration].minRandomYellowsAdd = generatedLocks[sortedIteration].maxRandomYellowsAdd)
			if (generatedLocks[sortedIteration].maxRandomYellowsAdd = 1) then config$ = config$ + "1 Add, "
			if (generatedLocks[sortedIteration].maxRandomYellowsAdd > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomYellowsAdd) + " Add, "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomYellowsAdd) + "-" + str(generatedLocks[sortedIteration].maxRandomYellowsAdd) + " Add, "
		endif
		if (generatedLocks[sortedIteration].minRandomYellowsMinus = generatedLocks[sortedIteration].maxRandomYellowsMinus)
			if (generatedLocks[sortedIteration].maxRandomYellowsMinus = 1) then config$ = config$ + "1 Minus, "
			if (generatedLocks[sortedIteration].maxRandomYellowsMinus > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomYellowsMinus) + " Minus, "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomYellowsMinus) + "-" + str(generatedLocks[sortedIteration].maxRandomYellowsMinus) + " Minus, "
		endif
		if (right(config$, 2) = ", ") then config$ = mid(config$, 1, len(config$) - 2)
		
		if (generatedLocks[sortedIteration].maxRandomStickies > 0 or generatedLocks[sortedIteration].maxRandomFreezes > 0)
			config$ = config$ + chr(10)
		endif
		if (generatedLocks[sortedIteration].minRandomStickies = generatedLocks[sortedIteration].maxRandomStickies)
			if (generatedLocks[sortedIteration].maxRandomStickies = 1) then config$ = config$ + "1 Sticky | "
			if (generatedLocks[sortedIteration].maxRandomStickies > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomStickies) + " Stickies | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomStickies) + "-" + str(generatedLocks[sortedIteration].maxRandomStickies) + " Stickies | "
		endif
		if (generatedLocks[sortedIteration].minRandomFreezes = generatedLocks[sortedIteration].maxRandomFreezes)
			if (generatedLocks[sortedIteration].maxRandomFreezes = 1) then config$ = config$ + "1 Freeze | "
			if (generatedLocks[sortedIteration].maxRandomFreezes > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomFreezes) + " Freezes | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomFreezes) + "-" + str(generatedLocks[sortedIteration].maxRandomFreezes) + " Freezes | "
		endif
		if (right(config$, 3) = " | ") then config$ = mid(config$, 1, len(config$) - 3)
		
		if (generatedLocks[sortedIteration].maxRandomDoubleUps > 0 or generatedLocks[sortedIteration].maxRandomResets > 0)
			config$ = config$ + chr(10)
		endif
		if (generatedLocks[sortedIteration].minRandomDoubleUps = generatedLocks[sortedIteration].maxRandomDoubleUps)
			if (generatedLocks[sortedIteration].maxRandomDoubleUps = 1) then config$ = config$ + "1 Double Up | "
			if (generatedLocks[sortedIteration].maxRandomDoubleUps > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomDoubleUps) + " Double Ups | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomDoubleUps) + "-" + str(generatedLocks[sortedIteration].maxRandomDoubleUps) + " Double Ups | "
		endif
		if (generatedLocks[sortedIteration].minRandomResets = generatedLocks[sortedIteration].maxRandomResets)
			if (generatedLocks[sortedIteration].maxRandomResets = 1) then config$ = config$ + "1 Reset | "
			if (generatedLocks[sortedIteration].maxRandomResets > 1) then config$ = config$ + str(generatedLocks[sortedIteration].maxRandomResets) + " Resets | "
		else
			config$ = config$ + str(generatedLocks[sortedIteration].minRandomResets) + "-" + str(generatedLocks[sortedIteration].maxRandomResets) + " Resets | "
		endif
		if (right(config$, 3) = " | ") then config$ = mid(config$, 1, len(config$) - 3)
		
		OryUIUpdateText(generatedLocksCard[cardNo].txtConfig, "text:" + config$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopCentreOfSprite(generatedLocksCard[cardNo].txtConfig, generatedLocksCard[cardNo].sprBackground, 0, 0.5)
		
		//OryUIUpdateButton(generatedLocksCard[cardNo].rightButton, "position:" + str(GetSpriteX(generatedLocksCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(generatedLocksCard[cardNo].rightButton)) + "," +  str(GetSpriteY(generatedLocksCard[cardNo].sprBackground) + (GetSpriteHeight(generatedLocksCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(generatedLocksCard[cardNo].rightButton) / 2)) + ";iconID:" + str(imgNewLockIcon) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		OryUIUpdateButton(generatedLocksCard[cardNo].rightButton, "position:" + str(GetSpriteX(generatedLocksCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(generatedLocksCard[cardNo].rightButton)) + "," +  str(GetSpriteY(generatedLocksCard[cardNo].sprBackground) + (GetSpriteHeight(generatedLocksCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(generatedLocksCard[cardNo].rightButton) / 2)) + ";icon:content_copy;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		
		OryUIUpdateSprite(generatedLocksCard[cardNo].sprCols[1], "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToTopCentreOfSprite(generatedLocksCard[cardNo].sprCols[1], generatedLocksCard[cardNo].sprBackground, -25, 13.5)
		OryUIUpdateText(generatedLocksCard[cardNo].txtColHeaders[1], "text:BEST;colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopCentreOfSprite(generatedLocksCard[cardNo].txtColHeaders[1], generatedLocksCard[cardNo].sprCols[1], 0, 0)
		bestHH = generatedLocks[sortedIteration].simulationBestCaseMinutesLocked / 60
		bestDD = generatedLocks[sortedIteration].simulationBestCaseMinutesLocked / 60 / 24
		if (generatedLocks[sortedIteration].simulationBestCaseMinutesLocked < 60)
			best$ = str(generatedLocks[sortedIteration].simulationBestCaseMinutesLocked) + "M"
		elseif (bestHH < 24)
			best$ = str(bestHH) + "H"
		elseif (bestDD > 0)
			best$ = str(bestDD) + "D"
		endif
		OryUIUpdateText(generatedLocksCard[cardNo].txtColValues[1], "text:" + best$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToBottomCentreOfSprite(generatedLocksCard[cardNo].txtColValues[1], generatedLocksCard[cardNo].sprCols[1], 0, 0)
		
		OryUIUpdateSprite(generatedLocksCard[cardNo].sprCols[2], "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToTopCentreOfSprite(generatedLocksCard[cardNo].sprCols[2], generatedLocksCard[cardNo].sprBackground, 0, 13.5)
		OryUIUpdateText(generatedLocksCard[cardNo].txtColHeaders[2], "text:AVERAGE;colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopCentreOfSprite(generatedLocksCard[cardNo].txtColHeaders[2], generatedLocksCard[cardNo].sprCols[2], 0, 0)
		averageHH = generatedLocks[sortedIteration].simulationAverageMinutesLocked / 60
		averageDD = generatedLocks[sortedIteration].simulationAverageMinutesLocked / 60 / 24
		if (generatedLocks[sortedIteration].simulationAverageMinutesLocked < 60)
			average$ = str(generatedLocks[sortedIteration].simulationAverageMinutesLocked) + "M"
		elseif (averageHH < 24)
			average$ = str(averageHH) + "H"
		elseif (averageDD > 0)
			average$ = str(averageDD) + "D"
		endif
		OryUIUpdateText(generatedLocksCard[cardNo].txtColValues[2], "text:" + average$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToBottomCentreOfSprite(generatedLocksCard[cardNo].txtColValues[2], generatedLocksCard[cardNo].sprCols[2], 0, 0)
		
		OryUIUpdateSprite(generatedLocksCard[cardNo].sprCols[3], "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToTopCentreOfSprite(generatedLocksCard[cardNo].sprCols[3], generatedLocksCard[cardNo].sprBackground, 25, 13.5)
		OryUIUpdateText(generatedLocksCard[cardNo].txtColHeaders[3], "text:WORST;colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopCentreOfSprite(generatedLocksCard[cardNo].txtColHeaders[3], generatedLocksCard[cardNo].sprCols[3], 0, 0)
		worstHH = generatedLocks[sortedIteration].simulationWorstCaseMinutesLocked / 60
		worstDD = generatedLocks[sortedIteration].simulationWorstCaseMinutesLocked / 60 / 24
		if (generatedLocks[sortedIteration].simulationWorstCaseMinutesLocked < 60)
			worst$ = str(generatedLocks[sortedIteration].simulationWorstCaseMinutesLocked) + "M"
		elseif (worstHH < 24)
			worst$ = str(worstHH) + "H"
		elseif (worstDD > 0)
			worst$ = str(worstDD) + "D"
		endif
		OryUIUpdateText(generatedLocksCard[cardNo].txtColValues[3], "text:" + worst$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToBottomCentreOfSprite(generatedLocksCard[cardNo].txtColValues[3], generatedLocksCard[cardNo].sprCols[3], 0, 0)
	endif
endfunction

function UpdateItemsInLockedUsersCard(cardNo as integer, sortedIteration as integer, reposition as integer)
	local allowModification as integer
	local awaitingDecision as integer
	local autoResetPending as integer
	local buttonsPlaced as integer
	local buttonX# as float
	local cardInfoHiddenButtonVisible as integer
	local checkInButtonVisible as integer
	local cooldownPercentage# as float
	local days$ as string
	local dd as integer
	local editButtonVisible as integer
	local fakeLockText$ as string
	local favouriteButtonVisible as integer
	local flagButtonVisible as integer
	local flagChosen as integer
	local greenPercentage# as float
	local hh as integer
	local hours$ as string
	local lateCheckIn as integer
	local leftEmptyButtonVisible as integer
	local leftIconCount as integer
	local leftWidth# as float
	local maxWaitTime as integer
	local minutes$ as string
	local mm as integer
	local mod16 as integer
	local mod24 as integer
	local moreButtonVisible as integer
	local moodButtonVisible as integer
	local noOfAutoResetsLeft as integer
	local noOfAutoResetsPassedSinceLast as integer
	local noOfLeftButtons as integer
	local noOfRightButtons as integer
	local prefixLabel$ as string
	local repositionItemsInCard as integer
	local resetButtonVisible as integer
	local rightEmptyButtonVisible as integer
	local rightIconCount as integer
	local rightWidth# as float
	local seconds$ as string
	local secondsLeft as integer
	local secondsLeftUntilAutoReset as integer
	local secondsSinceLastCheckIn as integer
	local secondsSinceLastReset as integer
	local secondsSinceUsersLastCheckIn as integer
	local secondsUnfreezes as integer
	local secondsUntilNextCheckIn as integer
	local ss as integer
	local suffixLabel$ as string
	local timerHiddenButtonVisible as integer
	local totalCards# as float
	local totalDoubleUpCards# as float
	local totalFreezeCards# as float
	local totalGreenCards# as float
	local totalRedCards# as float
	local totalResetCards# as float
	local totalStickyCards# as float
	local totalTextHeight# as float
	local totalYellowCards# as float
	local unlockButtonVisible as integer

	if (reposition = 1)
		fakeLockText$ = ""
		SetUsernameColorArray(sharedLocks[sharedLockSelected, 1].usersMainRole[sortedIteration], sharedLocks[sharedLockSelected, 1].usersMainRoleLevel[sortedIteration])
		OryUIUpdateText(userCard[cardNo].txtUsername, "text:" + sharedLocks[sharedLockSelected, 1].usersUsername$[sortedIteration] + fakeLockText$ + ";color:" + str(usernameColor[0]) + "," + str(usernameColor[1]) + "," + str(usernameColor[2]) + "," + str(usernameColor[3]))
		OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtUsername, userCard[cardNo].sprBackground, 0, 0.2)
		OryUIUpdateSprite(userCard[cardNo].sprUsernameButton, "size:" + str(GetTextTotalWidth(userCard[cardNo].txtUsername)) + "," + str(GetTextTotalHeight(userCard[cardNo].txtUsername)) + ";offset:center;position:" + str(GetTextX(userCard[cardNo].txtUsername)) + "," + str(GetTextY(userCard[cardNo].txtUsername) + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		
		leftIconCount = 0
		if (sharedLocks[sharedLockSelected, 1].usersTestLock[sortedIteration] = 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprTestLock, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprTestLock) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		if (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprTrustKeyholder, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprTrustKeyholder) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		if (sharedLocks[sharedLockSelected, 1].usersNoOfKeyholders[sortedIteration] > 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprMultipleKeyholders, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprMultipleKeyholders) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		rightIconCount = 1
		if (sharedLocks[sharedLockSelected, 1].usersStatus[sortedIteration] = 0 or sharedLocks[sharedLockSelected, 1].usersStatus[sortedIteration] = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration] <= 900)
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusAvailableIcon) + ";alpha:255")
			else
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
			endif
		elseif (sharedLocks[sharedLockSelected, 1].usersStatus[sortedIteration] = 2)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusBusyIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 1].usersStatus[sortedIteration] = 3)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusSleepingIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 1].usersStatus[sortedIteration] = 4)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprStatus, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprStatus) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))
		if (sharedLocks[sharedLockSelected, 1].usersEmojiChosen[sortedIteration] > 0)
			inc rightIconCount
			OryUIUpdateSprite(userCard[cardNo].sprEmojiIcon, "image:" + str(imgEmojis[sharedLocks[sharedLockSelected, 1].usersEmojiColourSelected[sortedIteration], sharedLocks[sharedLockSelected, 1].usersEmojiChosen[sortedIteration]]) + ";color:255,255,255,255")
			OryUIPinSpriteToSprite(userCard[cardNo].sprEmojiIcon, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprStatus) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))
		endif
		if (sharedLocks[sharedLockSelected, 1].usersKeysDisabled[sortedIteration] = 1)
			inc rightIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprKeysDisabled, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprKeysDisabled) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))
		endif
		if (sharedLocks[sharedLockSelected, 1].usersKeyholderAllowsFreeUnlock[sortedIteration] = 1)
			inc rightIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprFreeUnlock, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprKeysDisabled) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))
		endif
		if (sharedLocks[sharedLockSelected, 1].usersFakeLock[sortedIteration] = 1)
			inc rightIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprFakeLock, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprFakeLock) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))
		endif

		if (sharedLocks[sharedLockSelected, 1].usersNoOfRatingsFromKeyholders[sortedIteration] >= 5 and rightIconCount <= 3)
			if (sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration] < 1.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 224, 36, 43, 255)
			elseif (sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration] < 2.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 243, 115, 37, 255)
			elseif (sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration] < 3.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 247, 204, 26, 255)
			elseif (sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration] < 4.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 115, 177, 67, 255)
			elseif (sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration] < 5.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 0, 128, 78, 255)
			endif
			OryUIUpdateSprite(userCard[cardNo].sprRatingRibbon, "alpha:255")
			OryUIUpdateText(userCard[cardNo].txtRatingRibbon, "text:" + str(sharedLocks[sharedLockSelected, 1].usersAverageRatingFromKeyholders#[sortedIteration], 1) + ";alpha:255")
			OryUIPinSpriteToTopRightOfSprite(userCard[cardNo].sprRatingRibbon, userCard[cardNo].sprBackground, 0.5, -0.2)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtRatingRibbon, userCard[cardNo].sprRatingRibbon, 0, -0.1)
		endif
	endif
	
	allowModification = 0
	if (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] > 0 and sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 0)
		if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.25)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 300) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 0.5)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 900) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 1800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 3)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 3600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 6)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 10800) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 12)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 21600) then allowModification = 1
		elseif (sharedLocks[sharedLockSelected, 0].regularity# = 24)
			if (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] >= 43200) then allowModification = 1
		endif
	else
		allowModification = 1
	endif
	
	if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1) then allowModification = 0
	if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = -1) then allowModification = 0
	
	// AUTO RESET PENDING?
	autoResetPending = 0
	if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 1].usersUnlocked[sortedIteration] = 0 and sharedLocks[sharedLockSelected, 1].usersAutoResetsPaused[sortedIteration] = 0 and sharedLocks[sharedLockSelected, 1].usersMaxAutoResets[sortedIteration] > 0 and sharedLocks[sharedLockSelected, 1].usersResetFrequencyInSeconds[sortedIteration] > 0 and timestampFromServer > 0)
		secondsSinceLastReset = 0
		if (sharedLocks[sharedLockSelected, 1].usersTimestampLastAutoReset[sortedIteration] > 0 or sharedLocks[sharedLockSelected, 1].usersTimestampLastFullReset[sortedIteration] > 0)
			secondsSinceLastReset = timestampNow - MaxInt(sharedLocks[sharedLockSelected, 1].usersTimestampLastAutoReset[sortedIteration], sharedLocks[sharedLockSelected, 1].usersTimestampLastFullReset[sortedIteration])
		else
			secondsSinceLastReset = timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]
		endif
		noOfAutoResetsPassedSinceLast = floor(secondsSinceLastReset / sharedLocks[sharedLockSelected, 1].usersResetFrequencyInSeconds[sortedIteration])
		if (sharedLocks[sharedLockSelected, 1].usersAutoResetsPaused[sortedIteration] = 0)
			noOfAutoResetsLeft = sharedLocks[sharedLockSelected, 1].usersMaxAutoResets[sortedIteration] - sharedLocks[sharedLockSelected, 1].usersNoOfTimesAutoReset[sortedIteration] - noOfAutoResetsPassedSinceLast
			if (noOfAutoResetsPassedSinceLast > noOfAutoResetsLeft) then noOfAutoResetsPassedSinceLast = noOfAutoResetsLeft
		else
			noOfAutoResetsLeft = sharedLocks[sharedLockSelected, 1].usersMaxAutoResets[sortedIteration] - sharedLocks[sharedLockSelected, 1].usersNoOfTimesAutoReset[sortedIteration]
		endif
		secondsLeftUntilAutoReset = sharedLocks[sharedLockSelected, 1].usersResetFrequencyInSeconds[sortedIteration] - secondsSinceLastReset
		if (noOfAutoResetsLeft > 0)
			if (secondsLeftUntilAutoReset <= 0)
				allowModification = 0
				autoResetPending = 1
			endif
		endif
	endif	

	awaitingDecision = 0
	if (allowModification = 0)
		if (autoResetPending = 0)
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 3600) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 300) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.5) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 900) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 1800) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 3) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 3600) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 6) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 10800) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 12) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 21600) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] + 43200) - timestampNow
			hh = floor(mod(secondsLeft / 60 / 60, 24))
			mm = floor(mod(secondsLeft / 60, 60))
			ss = floor(mod(secondsLeft, 60))
		else
			secondsLeft = secondsLeftUntilAutoReset
		endif
		
		if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] <> 0)
			maxWaitTime = 0
			if (sharedLocks[sharedLockSelected, 0].regularity# <= 3) then maxWaitTime = 3600 * 3
			if (sharedLocks[sharedLockSelected, 0].regularity# >= 6) then maxWaitTime = 3600 * 6
			if (maxWaitTime - (timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRequestedKeyholdersDecision[sortedIteration]) > 0)
				awaitingDecision = 1
				OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;colorID:" +  str(roleColours.keyholder[1]) + ";alpha:200")	
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprModifyLockInBackground, userCard[cardNo].sprBackground, 0, 2.5)
				OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "text:Waiting For Your Decision;size:4.1")
				OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "text:User wants you to decide if to unlock or reset their lock")
			else
				if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1)
					OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;colorID:" + str(roleColours.lockee[1]) + ";alpha:200")
					OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprModifyLockInBackground, userCard[cardNo].sprBackground, 0, 2.5)
					OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "text:Waiting For Users Decision;size:4.1")
					OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "text:Waiting for user to decide if to unlock or reset their lock")
				endif
				if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = -1)
					OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;colorID:" + str(roleColours.lockee[1]) + ";alpha:200")
					OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprModifyLockInBackground, userCard[cardNo].sprBackground, 0, 2.5)
					OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "text:Waiting For User To Login;size:4.1")
					OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "text:Timer has reached 0. Waiting for user to open app")
				endif
			endif
			if (reposition = 1)
				totalTextHeight# = GetTextTotalHeight(userCard[cardNo].txtModifyLockIn) + GetTextTotalHeight(userCard[cardNo].txtModifyLockInFooter)
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockIn, userCard[cardNo].sprModifyLockInBackground, 0, -((totalTextHeight#) / 4))
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockInFooter, userCard[cardNo].sprModifyLockInBackground, 0, ((totalTextHeight#) / 4))
			endif
		elseif (secondsLeft <= 0 and autoResetPending = 1)
			OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;colorID:" + str(roleColours.lockee[1]) + ";alpha:200")
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprModifyLockInBackground, userCard[cardNo].sprBackground, 0, 2.5)
			OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "text:Auto Reset Pending;size:4.1")
			OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "text:Waiting for user to open app")
			if (reposition = 1)
				totalTextHeight# = GetTextTotalHeight(userCard[cardNo].txtModifyLockIn) + GetTextTotalHeight(userCard[cardNo].txtModifyLockInFooter)
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockIn, userCard[cardNo].sprModifyLockInBackground, 0, -((totalTextHeight#) / 4))
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockInFooter, userCard[cardNo].sprModifyLockInBackground, 0, ((totalTextHeight#) / 4))
			endif			
		elseif (secondsLeft > 0)
			OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;color:0,0,0,200")
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprModifyLockInBackground, userCard[cardNo].sprBackground, 0, 2.5)
			OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "text:Modify Lock In " + AddLeadingZeros(str(hh), 2) + "[colon]" + AddLeadingZeros(str(mm), 2) + "[colon]" + AddLeadingZeros(str(ss), 2) + ";size:4.1;")
			OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "text:You are limited to how often you can update this users lock")
			if (reposition = 1)
				totalTextHeight# = GetTextTotalHeight(userCard[cardNo].txtModifyLockIn) + GetTextTotalHeight(userCard[cardNo].txtModifyLockInFooter)
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockIn, userCard[cardNo].sprModifyLockInBackground, 0, -((totalTextHeight#) / 4))
				OryUIPinTextToCentreOfSprite(userCard[cardNo].txtModifyLockInFooter, userCard[cardNo].sprModifyLockInBackground, 0, ((totalTextHeight#) / 4))
			endif
		else
			OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "position:-1000,-1000")
			OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "position:-1000,-1000")
			OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "position:-1000,-1000")
		endif
	else
		OryUIUpdateSprite(userCard[cardNo].sprModifyLockInBackground, "position:-1000,-1000")
		OryUIUpdateText(userCard[cardNo].txtModifyLockIn, "position:-1000,-1000")
		OryUIUpdateText(userCard[cardNo].txtModifyLockInFooter, "position:-1000,-1000")
	endif
	
	// VARIABLE LOCK TICKER
	if (sharedLocks[sharedLockSelected, 0].fixed = 0)
		totalCards# = 0
		totalGreenCards# = sharedLocks[sharedLockSelected, 1].usersGreenCards[sortedIteration]
		totalRedCards# = sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration]
		totalYellowCards# = sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 1] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 2] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 3] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 4] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 5]
		totalStickyCards# = sharedLocks[sharedLockSelected, 1].usersStickyCards[sortedIteration]
		totalDoubleUpCards# = sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[sortedIteration]
		totalFreezeCards# = sharedLocks[sharedLockSelected, 1].usersFreezeCards[sortedIteration]
		totalResetCards# = sharedLocks[sharedLockSelected, 1].usersResetCards[sortedIteration]
		totalCards# = totalGreenCards# + totalRedCards# + totalYellowCards# + totalStickyCards# + totalFreezeCards# + totalDoubleUpCards# + totalResetCards#

		dd = 0
		hh = 0
		mm = 0
		ss = 0
		prefixLabel$ = ""
		suffixLabel$ = ""
		
		mod24 = mod(secondsRunning, 24)
		if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1) then mod24 = mod(secondsRunning, 24)
		if (mod24 >= 1 and mod24 <= 4)
			dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60 / 60 / 24)
			hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60 / 60, 24)
			mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60, 60)
			ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]), 60)
			prefixLabel$ = "Locked for "
		endif
		if (mod24 >= 5 and mod24 <= 8)
			if (sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration])
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]), 60)
				prefixLabel$ = "Last online "
				suffixLabel$ = " ago"
			endif
		endif
		if (mod24 >= 9 and mod24 <= 12)
			if (sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration])
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampRealLastPicked[sortedIteration]), 60)
				prefixLabel$ = "Last picked "
				suffixLabel$ = " ago"
			endif
		endif
		if (mod24 >= 13 and mod24 <= 16)
			if (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] > 0)
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]), 60)
				prefixLabel$ = "You updated "
				suffixLabel$ = " ago"
			endif
		endif
		if (mod24 >= 17 and mod24 <= 20)
			if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[sortedIteration] = 1 and sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByCard[sortedIteration] > 0)
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByCard[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByCard[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByCard[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByCard[sortedIteration]), 60)
				prefixLabel$ = "Frozen by card "
				suffixLabel$ = " ago"
			endif
			if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1 and sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration] > 0)
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]), 60)
				prefixLabel$ = "Frozen by you "
				suffixLabel$ = " ago"
			endif
		endif
		if (mod24 >= 21 or mod24 = 0)
			greenPercentage# = (totalGreenCards# / totalCards#) * 100.0
		endif
		
		if (dd = 1)
			days$ = "1 day"
		else
			days$ = str(dd) + " days"
		endif	
		if (hh = 1)
			hours$ = "1 hour"
		else
			hours$ = str(hh) + " hours"
		endif
		if (mm = 1)
			minutes$ = "1 minute"
		else
			minutes$ = str(mm) + " minutes"
		endif
		if (ss = 1)
			seconds$ = "1 second"
		else
			seconds$ = str(ss) + " seconds"
		endif
		
		if (dd > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + days$ + ", " + hours$ + ", and " + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (hh > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + hours$ + ", and " + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (mm > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (ss > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + seconds$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			elseif (mod24 >= 1 and mod24 <= 12)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			elseif (mod24 >= 13 and mod24 <= 16)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:You've not yet modified this lock")
			elseif (mod24 >= 17 and mod24 <= 20)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			elseif (mod24 >= 21 or mod24 <= 0)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + str(greenPercentage#, 2) + "% chance of finding a green card;colorID:" + str(colorMode[colorModeSelected].textColor))
			endif
		endif
		
		if (reposition = 1)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtTicker, userCard[cardNo].sprBackground, 0, 3)
		endif
	endif
	
	// FIXED LOCK TICKER
	if (sharedLocks[sharedLockSelected, 0].fixed = 1)
		dd = 0
		hh = 0
		mm = 0
		ss = 0
		prefixLabel$ = ""
		suffixLabel$ = ""
				
		mod16 = mod(secondsRunning, 16)
		if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1) then mod16 = mod(secondsRunning, 16)
		if (mod16 >= 1 and mod16 <= 4)
			dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60 / 60 / 24)
			hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60 / 60, 24)
			mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]) / 60, 60)
			ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]), 60)
			prefixLabel$ = "Locked for "
		endif
		if (mod16 >= 5 and mod16 <= 8)
			if (sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration])
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersLastActive[sortedIteration]), 60)
			endif
			prefixLabel$ = "Last online "
			suffixLabel$ = " ago"
		endif
		if (mod16 >= 9 and mod16 <= 12)
			if (sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration] > 0)
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastUpdated[sortedIteration]), 60)
			endif
			prefixLabel$ = "You modified "
			suffixLabel$ = " ago"
		endif
		if (mod16 >= 13 or mod16 = 0)
			if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1 and sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration] > 0)
				dd = floor((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60 / 60 / 24)
				hh = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60 / 60, 24)
				mm = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]) / 60, 60)
				ss = mod((timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]), 60)
				prefixLabel$ = "Frozen by you "
			endif
			suffixLabel$ = " ago"
		endif
					
		if (dd = 1)
			days$ = "1 day"
		else
			days$ = str(dd) + " days"
		endif
		if (hh = 1)
			hours$ = "1 hour"
		else
			hours$ = str(hh) + " hours"
		endif
		if (mm = 1)
			minutes$ = "1 minute"
		else
			minutes$ = str(mm) + " minutes"
		endif
		if (ss = 1)
			seconds$ = "1 minute"
		else
			seconds$ = str(ss) + " seconds"
		endif
		
		if (dd > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + days$ + ", " + hours$ + ", and " + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (hh > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + hours$ + ", and " + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (mm > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + minutes$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		elseif (ss > 0)
			OryUIUpdateText(userCard[cardNo].txtTicker, "text:" + prefixLabel$ + seconds$ + suffixLabel$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		else
			if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 1)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			elseif (mod16 >= 1 and mod16 <= 8)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			elseif (mod16 >= 9 and mod16 <= 12)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:You've not yet modified this lock")
			elseif (mod16 >= 13 or mod16 = 0)
				OryUIUpdateText(userCard[cardNo].txtTicker, "text:")
			endif
		endif

		if (reposition = 1)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtTicker, userCard[cardNo].sprBackground, 0, 3)
		endif
	endif

	// VARIABLE LOCK CARD COUNTS AND QUICK UPDATE BUTTONS
	if (sharedLocks[sharedLockSelected, 0].fixed = 0)
		if (reposition = 1)
			if (sharedLocks[sharedLockSelected, 1].usersLockBuildNumber[sortedIteration] >= 115 and (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 1 or sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[sortedIteration] = 1 or sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1) and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0)	
				if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[sortedIteration] = 1)
					OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "text:FROZEN;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "image:" + str(imgFreezeIconOn) + ";alpha:255")
					OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "text:BY CARD;colorID:" + str(colorMode[colorModeSelected].textColor))	
				elseif (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1)
					OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "text:FROZEN;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "image:" + str(imgFreezeIconOn) + ";alpha:255")
					OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "text:BY YOU;colorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "text:LOCK;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "image:" + str(imgFreezeIconOff) + ";alpha:200")
					OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "text:RUNNING;colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFreezeLockButton, userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprFreezeLockButton) + 1) * 3.5), 2.5)
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFreezeLockIcon, userCard[cardNo].sprFreezeLockButton, 0, 0)
				OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtFreezeLockHeader, userCard[cardNo].sprFreezeLockButton, 0, 0)
				OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFreezeLockFooter, userCard[cardNo].sprFreezeLockButton, 0, 0)	
			else
				OryUIUpdateSprite(userCard[cardNo].sprFreezeLockButton, "position:-1000,-1000")
				OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "position:-1000,-1000")
				OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "position:-1000,-1000")
				OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "position:-1000,-1000")
			endif
			
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprGreenCard, userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprGreenCard) + 1) * 2.5), 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtGreenHeader, userCard[cardNo].sprGreenCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtGreenCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersGreenCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtGreenCount, userCard[cardNo].sprGreenCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtGreenFooter, userCard[cardNo].sprGreenCard, 0, -1.25)
		
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRedCard, userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprRedCard) + 1) * 1.5), 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtRedHeader, userCard[cardNo].sprRedCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtRedCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRedCount, userCard[cardNo].sprRedCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtRedFooter, userCard[cardNo].sprRedCard, 0, -1.25)					
			
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprStickyCard, userCard[cardNo].sprBackground, -(GetSpriteWidth(userCard[cardNo].sprStickyCard) + 1) * 0.5, 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtStickyHeader, userCard[cardNo].sprStickyCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtStickyCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersStickyCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtStickyCount, userCard[cardNo].sprStickyCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtStickyFooter, userCard[cardNo].sprStickyCard, 0, -1.25)					
			
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprYellowCard, userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprYellowCard) + 1) * 0.5, 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtYellowHeader, userCard[cardNo].sprYellowCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtYellowCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 1] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 2] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 3] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 4] + sharedLocks[sharedLockSelected, 1].usersYellowCards[sortedIteration, 5]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtYellowCount, userCard[cardNo].sprYellowCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtYellowFooter, userCard[cardNo].sprYellowCard, 0, -1.25)					
			
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFreezeCard, userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprFreezeCard) + 1) * 1.5, 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtFreezeHeader, userCard[cardNo].sprFreezeCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtFreezeCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersFreezeCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtFreezeCount, userCard[cardNo].sprFreezeCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFreezeFooter, userCard[cardNo].sprFreezeCard, 0, -1.25)					
			
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprDoubleUpCard, userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprDoubleUpCard) + 1) * 2.5, 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtDoubleUpHeader, userCard[cardNo].sprDoubleUpCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtDoubleUpCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersDoubleUpCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtDoubleUpCount, userCard[cardNo].sprDoubleUpCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtDoubleUpFooter, userCard[cardNo].sprDoubleUpCard, 0, -1.25)
					
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprResetCard, userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprResetCard) + 1) * 3.5, 2.5)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtResetHeader, userCard[cardNo].sprResetCard, 0, 1.25)
			OryUIUpdateText(userCard[cardNo].txtResetCount, "text:" + str(sharedLocks[sharedLockSelected, 1].usersResetCards[sortedIteration]))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtResetCount, userCard[cardNo].sprResetCard, 0, 0)
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtResetFooter, userCard[cardNo].sprResetCard, 0, -1.25)	
		endif
		
		if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[sortedIteration] = 1)
			secondsUnfreezes = sharedLocks[sharedLockSelected, 1].usersTimestampUnfreezes[sortedIteration] - timestampNow
			if (secondsUnfreezes < 0)
				sharedLocks[sharedLockSelected, 1].usersLockFrozenByCard[sortedIteration] = 0
				repositionItemsInCard = 1
				UpdateItemsInLockedUsersCard(cardNo, sortedIteration, repositionItemsInCard)
			endif
		endif
	endif
	
	// FIXED LOCK TIMER AND QUICK UPDATE BUTTONS
	if (sharedLocks[sharedLockSelected, 0].fixed = 1)
		if (reposition = 1)
			if (sharedLocks[sharedLockSelected, 1].usersLockBuildNumber[sortedIteration] >= 115 and (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 1 or sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1) and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0)	
				if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 1)
					OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "text:FROZEN;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "image:" + str(imgFreezeIconOn) + ";alpha:255")
					OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "text:BY YOU;colorID:" + str(colorMode[colorModeSelected].textColor))
				else
					OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "text:LOCK;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "image:" + str(imgFreezeIconOff) + ";alpha:200")
					OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "text:RUNNING;colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFreezeLockButton, userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprFreezeLockButton) + 1) * 3.5), 2.5)
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFreezeLockIcon, userCard[cardNo].sprFreezeLockButton, 0, 0)
				OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtFreezeLockHeader, userCard[cardNo].sprFreezeLockButton, 0, 0)
				OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFreezeLockFooter, userCard[cardNo].sprFreezeLockButton, 0, 0)	
			else
				OryUIUpdateSprite(userCard[cardNo].sprFreezeLockButton, "position:-1000,-1000")
				OryUIUpdateText(userCard[cardNo].txtFreezeLockHeader, "position:-1000,-1000")
				OryUIUpdateSprite(userCard[cardNo].sprFreezeLockIcon, "position:-1000,-1000")
				OryUIUpdateText(userCard[cardNo].txtFreezeLockFooter, "position:-1000,-1000")
			endif
			
			OryUIUpdateSprite(userCard[cardNo].sprFixedCircle[1], "colorID:" + str(colorMode[colorModeSelected].barColor))									
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFixedCircle[1], userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprFixedCircle[1]) + 1) * 1.5), 2.5)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCount[1], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCount[1], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCount[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtFixedCount[1], userCard[cardNo].sprFixedCircle[1], 0, 0)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[1], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[1], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[1], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFixedCircleFooter[1], userCard[cardNo].sprFixedCircle[1], 0, -1.25)
						
			OryUIUpdateSprite(userCard[cardNo].sprFixedCircle[2], "colorID:" + str(colorMode[colorModeSelected].barColor))									
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFixedCircle[2], userCard[cardNo].sprBackground, -((GetSpriteWidth(userCard[cardNo].sprFixedCircle[2]) + 1) * 0.5), 2.5)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCount[2], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCount[2], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCount[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtFixedCount[2], userCard[cardNo].sprFixedCircle[2], 0, 0)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[2], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[2], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[2], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFixedCircleFooter[2], userCard[cardNo].sprFixedCircle[2], 0, -1.25)
						
			OryUIUpdateSprite(userCard[cardNo].sprFixedCircle[3], "colorID:" + str(colorMode[colorModeSelected].barColor))									
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFixedCircle[3], userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprFixedCircle[3]) + 1) * 0.5, 2.5)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCount[3], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCount[3], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCount[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtFixedCount[3], userCard[cardNo].sprFixedCircle[3], 0, 0)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[3], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[3], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[3], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFixedCircleFooter[3], userCard[cardNo].sprFixedCircle[3], 0, -1.25)
						
			OryUIUpdateSprite(userCard[cardNo].sprFixedCircle[4], "colorID:" + str(colorMode[colorModeSelected].barColor))									
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFixedCircle[4], userCard[cardNo].sprBackground, (GetSpriteWidth(userCard[cardNo].sprFixedCircle[4]) + 1) * 1.5, 2.5)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCount[4], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCount[4], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCount[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtFixedCount[4], userCard[cardNo].sprFixedCircle[4], 0, 0)
			if (colorModeSelected <> 2)
				OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[4], "colorID:" + str(theme[themeSelected].color[3]))
			else
				if (themeSelected <> 10)
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[4], "colorID:" + str(theme[themeSelected].color[1]))
				else
					OryUIUpdateText(userCard[cardNo].txtFixedCircleFooter[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
				endif
			endif
			OryUIPinTextToBottomCentreOfSprite(userCard[cardNo].txtFixedCircleFooter[4], userCard[cardNo].sprFixedCircle[4], 0, -1.25)		
		endif
		
		if (sharedLocks[sharedLockSelected, 1].usersLockFrozenByKeyholder[sortedIteration] = 0)
			// Version 2.5.0+
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (60 * sharedLocks[sharedLockSelected, 1].usersMinutes[sortedIteration])) - timestampNow
			// Before version 2.5.0
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (900 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (3600 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - timestampNow
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (86400 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - timestampNow
		else
			// Version 2.5.0+
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.016667) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (60 * sharedLocks[sharedLockSelected, 1].usersMinutes[sortedIteration])) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]
			// Before version 2.5.0
			if (sharedLocks[sharedLockSelected, 0].regularity# = 0.25) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (900 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]
			if (sharedLocks[sharedLockSelected, 0].regularity# = 1) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (3600 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]
			if (sharedLocks[sharedLockSelected, 0].regularity# = 24) then secondsLeft = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersTotalTimeFrozen[sortedIteration] + (86400 * sharedLocks[sharedLockSelected, 1].usersRedCards[sortedIteration])) - sharedLocks[sharedLockSelected, 1].usersTimestampFrozenByKeyholder[sortedIteration]
		endif

		dd = floor(secondsLeft / 60 / 60 / 24)
		hh = floor(mod(secondsLeft / 60 / 60, 24))
		mm = floor(mod(secondsLeft / 60, 60))
		ss = floor(mod(secondsLeft, 60))
		
		if (secondsLeft > 0 and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0)
			OryUIUpdateText(userCard[cardNo].txtFixedCount[1], "text:" + str(dd))
			OryUIUpdateText(userCard[cardNo].txtFixedCount[2], "text:" + str(hh))
			OryUIUpdateText(userCard[cardNo].txtFixedCount[3], "text:" + str(mm))
			OryUIUpdateText(userCard[cardNo].txtFixedCount[4], "text:" + str(ss))			
		else
			if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0)
				sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = -1
				repositionItemsInCard = 1
				UpdateItemsInLockedUsersCard(cardNo, sortedIteration, repositionItemsInCard)
			endif
		endif
	endif

	// BUTTON BAR
	unlockButtonVisible = 1
	resetButtonVisible = 0
	cardInfoHiddenButtonVisible = 0
	checkInButtonVisible = 0
	timerHiddenButtonVisible = 0
	leftEmptyButtonVisible = 1
	editButtonVisible = 0
	rightEmptyButtonVisible = 0
	moodButtonVisible = 1
	favouriteButtonVisible = 1
	flagButtonVisible = 1
	moreButtonVisible = 1
	buttonX# = 0
	buttonsPlaced = 0
	if (sharedLocks[sharedLockSelected, 0].fixed = 0 and (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 1 or awaitingDecision = 1)) then resetButtonVisible = 1
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 1].usersBuildNumberInstalled[sortedIteration] >= 134 and (sharedLocks[sharedLockSelected, 1].usersTrustKeyholder[sortedIteration] = 1 or awaitingDecision = 1)) then resetButtonVisible = 1

	if (sharedLocks[sharedLockSelected, 0].fixed = 0 and sharedLocks[sharedLockSelected, 1].usersLockBuildNumber[sortedIteration] >= 99 and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0) then cardInfoHiddenButtonVisible = 1
	if (sharedLocks[sharedLockSelected, 0].fixed = 1 and sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0) then timerHiddenButtonVisible = 1
	
	if (sharedLocks[sharedLockSelected, 0].checkInFrequencyInSeconds > 0) then checkInButtonVisible = 1
	
	if (sharedLocks[sharedLockSelected, 1].usersReadyToUnlock[sortedIteration] = 0 and allowModification = 1)
		editButtonVisible = 1
		rightEmptyButtonVisible = 1
	endif
	noOfLeftButtons = unlockButtonVisible + resetButtonVisible + cardInfoHiddenButtonVisible + timerHiddenButtonVisible + checkInButtonVisible
	noOfRightButtons = moodButtonVisible + favouriteButtonVisible + flagButtonVisible + moreButtonVisible
	if (unlockButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprUnlockButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprUnlockIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIPinSpriteToSprite(userCard[cardNo].sprUnlockButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprUnlockIcon, userCard[cardNo].sprUnlockButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (resetButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprResetButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprResetIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIPinSpriteToSprite(userCard[cardNo].sprResetButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprResetIcon, userCard[cardNo].sprResetButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (cardInfoHiddenButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprHideCardInfoButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		if (sharedLocks[sharedLockSelected, 1].usersCardInfoHidden[sortedIteration] = 1)
			OryUIUpdateSprite(userCard[cardNo].sprHideCardInfoIcon, "image:" + str(imgCardInfoHidden) + ";color:255,255,255,255")
		else
			if (colorModeSelected <> 2)
				OryUIUpdateSprite(userCard[cardNo].sprHideCardInfoIcon, "image:" + str(imgCardInfoVisible) + ";color:255,255,255,180")
			else
				OryUIUpdateSprite(userCard[cardNo].sprHideCardInfoIcon, "image:" + str(imgCardInfoVisible) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprHideCardInfoButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprHideCardInfoIcon, userCard[cardNo].sprHideCardInfoButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (timerHiddenButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprFixedHideTimerButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		if (sharedLocks[sharedLockSelected, 1].usersTimerHidden[sortedIteration] = 1)
			OryUIUpdateSprite(userCard[cardNo].sprFixedHideTimerIcon, "image:" + str(imgTimerHidden) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		else
			OryUIUpdateSprite(userCard[cardNo].sprFixedHideTimerIcon, "image:" + str(imgTimerVisible) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprFixedHideTimerButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFixedHideTimerIcon, userCard[cardNo].sprFixedHideTimerButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (checkInButtonVisible = 1)
		OryUIPinSpriteToSprite(userCard[cardNo].sprCheckInButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprCheckInIcon, userCard[cardNo].sprCheckInButton, 0, 0)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprCheckInCooldown, userCard[cardNo].sprCheckInButton, 0, 0)
		OryUIUpdateSprite(userCard[cardNo].sprCheckInButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprCheckInIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIUpdateSprite(userCard[cardNo].sprCheckInCooldown, "colorID:" + str(theme[themeSelected].color[3]))
		if (sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[sortedIteration] = 0)
			secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration]
			secondsUntilNextCheckIn = (sharedLocks[sharedLockSelected, 1].usersTimestampLocked[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration]) - timestampNow
			if (secondsUntilNextCheckIn > 0)
				cooldownPercentage# = (100.0 / sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration]) * secondsUntilNextCheckIn
			else
				cooldownPercentage# = 0
				lateCheckIn = 0
				if (sharedLocks[sharedLockSelected, 0].fixed = 0)
					if (sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
							lateCheckIn = 1
						endif
					else
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration])
							lateCheckIn = 1
						endif
					endif
				else
					if (sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > (MinInt(sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400)))
							lateCheckIn = 1
						endif
					else
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration])
							lateCheckIn = 1
						endif
					endif
				endif
				if (lateCheckIn = 1)
					SetSpriteColor(userCard[cardNo].sprCheckInIcon, 192, 57, 42, 255)
				else
					SetSpriteColor(userCard[cardNo].sprCheckInIcon, 22, 160, 133, 130)	
				endif
			endif
		else
			secondsSinceLastCheckIn = timestampNow - sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[sortedIteration]
			secondsUntilNextCheckIn = (sharedLocks[sharedLockSelected, 1].usersTimestampLastCheckedIn[sortedIteration] + sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration]) - timestampNow
			if (secondsUntilNextCheckIn > 0)
				cooldownPercentage# = (100.0 / sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration]) * secondsUntilNextCheckIn
			else
				cooldownPercentage# = 0
				lateCheckIn = 0
				if (sharedLocks[sharedLockSelected, 0].fixed = 0)
					if (sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 0].regularity# * 3600)
							lateCheckIn = 1
						endif
					else
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration])
							lateCheckIn = 1
						endif
					endif
				else
					if (sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration] = 0)
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > (MinInt(sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] / 2, 86400)))
							lateCheckIn = 1
						endif
					else
						if (secondsSinceLastCheckIn - sharedLocks[sharedLockSelected, 1].usersCheckInFrequencyInSeconds[sortedIteration] > sharedLocks[sharedLockSelected, 1].usersLateCheckInWindowInSeconds[sortedIteration])
							lateCheckIn = 1
						endif
					endif
				endif
				if (lateCheckIn = 1)
					SetSpriteColor(userCard[cardNo].sprCheckInIcon, 192, 57, 42, 255)
				else
					SetSpriteColor(userCard[cardNo].sprCheckInIcon, 22, 160, 133, 130)	
				endif
			endif
		endif
		SetShaderConstantByName(userCard[cardNo].shaderCooldown, "Percentage", cooldownPercentage#, 0, 0, 0)
		DrawSprite(userCard[cardNo].sprCheckInCooldown)
		buttonX# = buttonX# + 10
	endif
	if (leftEmptyButtonVisible = 1)
		if (editButtonVisible = 0)
			leftWidth# = 100 - ((noOfLeftButtons + noOfRightButtons) * 10)
		else
			leftWidth# = 45 - (noOfLeftButtons * 10)
		endif
		OryUIUpdateSprite(userCard[cardNo].sprLeftEmptyButton, "size:" + str(leftWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToSprite(userCard[cardNo].sprLeftEmptyButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		buttonX# = buttonX# + leftWidth#
	endif
	if (editButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprEditButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprEditIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIPinSpriteToSprite(userCard[cardNo].sprEditButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprEditIcon, userCard[cardNo].sprEditButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (rightEmptyButtonVisible = 1 and editButtonVisible = 1)
		rightWidth# = 45 - (noOfRightButtons * 10)
		OryUIUpdateSprite(userCard[cardNo].sprRightEmptyButton, "size:" + str(rightWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToSprite(userCard[cardNo].sprRightEmptyButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		buttonX# = buttonX# + rightWidth#
	endif
	if (moodButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprMoodButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		if (sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiChosen[sortedIteration] = 0)
			OryUIUpdateSprite(userCard[cardNo].sprMoodIcon, "image:" + str(imgEmojiIcon) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		else
			OryUIUpdateSprite(userCard[cardNo].sprMoodIcon, "image:" + str(imgEmojis[sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiColourSelected[sortedIteration], sharedLocks[sharedLockSelected, 1].usersKeyholderEmojiChosen[sortedIteration]]) + ";color:255,255,255,255")
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprMoodButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprMoodIcon, userCard[cardNo].sprMoodButton, 0, 0)
		buttonX# = buttonX# + 10
	endif
	if (favouriteButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprFavouriteButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIPinSpriteToSprite(userCard[cardNo].sprFavouriteButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFavouriteIcon, userCard[cardNo].sprFavouriteButton, 0, 0)
		buttonX# = buttonX# + 10
		if (favouriteUsers.find(sharedLocks[sharedLockSelected, 1].usersID[sortedIteration]) = -1)
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOff) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		else
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOn) + ";color:255,255,255,255")
		endif
	endif
	if (flagButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprFlagButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIPinSpriteToSprite(userCard[cardNo].sprFlagButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFlagIcon, userCard[cardNo].sprFlagButton, 0, 0)
		buttonX# = buttonX# + 10
		flagChosen = GetFlagChosen(sharedLocks[sharedLockSelected, 1].usersID[sortedIteration])
		if (flagChosen = 0)
			OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		else
			OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[flagChosen]) + ";color:255,255,255,255")
		endif
	endif
	if (moreButtonVisible = 1)
		OryUIUpdateSprite(userCard[cardNo].sprMoreButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		OryUIUpdateSprite(userCard[cardNo].sprMoreIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
		OryUIPinSpriteToSprite(userCard[cardNo].sprMoreButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
		OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprMoreIcon, userCard[cardNo].sprMoreButton, 0, 0)
	endif
endfunction

function UpdateItemsInMyLockCard(cardNo as integer, sortedIteration, reposition as integer)
	local a as integer
	local b as integer
	local angle# as float
	local buttonsPlaced as integer
	local buttonX# as float
	local checkInButtonVisible as integer
	local cleanButtonVisible as integer
	local cooldownPercentage# as float
	local daysLocked as integer
	local dd as integer
	local deleteButtonVisible as integer
	local emptyLeftButtonVisible as integer
	local emptyRightButtonVisible as integer
	local flagButtonVisible as integer
	local footer$ as string
	local frozenTime$ as string
	local hh as integer
	local hoursLocked as integer
	local lateCheckIn as integer
	local lockName$ as string
	local maxWaitTime as integer
	local minutesLocked as integer
	local mm as integer
	local mod8 as integer
	local mod12 as integer
	local moodButtonVisible as integer
	local moreButtonVisible as integer
	local noOfCenterButtons as integer
	local noOfLeftButtons as integer
	local noOfRightButtons as integer
	local restartButtonVisible as integer
	local secondsLeft as integer
	local secondsSinceLastCheckIn as integer
	local secondsUntilNextCheckIn as integer
	local ss as integer
	local timestampExpectedUnlock as integer
	local totalCards# as float
	local unlockButtonVisible as integer
	local value as integer
	local valuePercentage# as float

	if (locks[sortedIteration].checkingForUpdates = 1 and OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetLockUpdates) = 0)
		locks[sortedIteration].checkingForUpdates = 0
		SetScreenToView(constMyLocksScreen)
	endif
	
	if (reposition = 1)
		if (timestampFromServer >= 1000000000 and timestampNow <= locks[sortedIteration].timestampRibbonAdded + 120)
			if (locks[sortedIteration].ribbonType$ = "Auto Reset Lock")
				if (imgAutoResetRibbon = 0) then imgAutoResetRibbon = LoadImage("AutoResetRibbon.png")
				OryUIUpdateSprite(lockCard[cardNo].sprRibbon, "image:" + str(imgAutoResetRibbon) + ";alpha:255")
				OryUIPinSpriteToTopRightOfSprite(lockCard[cardNo].sprRibbon, lockCard[cardNo].sprBackground, 0, -1)
			endif
			if (locks[sortedIteration].ribbonType$ = "Keyholder Update")
				if (imgKeyholderUpdatedRibbon = 0) then imgKeyholderUpdatedRibbon = LoadImage("KeyholderUpdatedRibbon.png")
				OryUIUpdateSprite(lockCard[cardNo].sprRibbon, "image:" + str(imgKeyholderUpdatedRibbon) + ";alpha:255")
				OryUIPinSpriteToTopRightOfSprite(lockCard[cardNo].sprRibbon, lockCard[cardNo].sprBackground, 0, -1)
			endif
		endif
		lockName$ = ""
		if (locks[sortedIteration].lockName$ <> "") then lockName$ = locks[sortedIteration].lockName$
		if (locks[sortedIteration].test = 1)
			if (lockName$ <> "") then lockName$ = lockName$ + " | "
			lockName$ = lockName$ + "TEST"
		endif
		OryUIUpdateText(lockCard[cardNo].txtGroupID, "text:" + lockName$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtGroupID, lockCard[cardNo].sprBackground, -6.5, 0.5)
		OryUIPinSpriteToTopRightOfSprite(lockCard[cardNo].sprSyncStatus, lockCard[cardNo].sprBackground, 1.5, 0.6)
	endif

	if (locks[sortedIteration].deleting = 0)
		// SYNC STATUS
		if (locks[sortedIteration].timestampLastSynced = 0 or locks[sortedIteration].timestampLastPicked > locks[sortedIteration].timestampLastSynced or locks[sortedIteration].timestampRequestedKeyholdersDecision > locks[sortedIteration].timestampLastSynced)
			if (GetSpriteImageID(lockCard[cardNo].sprSyncStatus) <> imgNotSynced) then OryUIUpdateSprite(lockCard[cardNo].sprSyncStatus, "image:" + str(imgNotSynced) + ";alpha:255")
			if (OryUIIsNameInHTTPSQueue(httpsQueue, "UpdateMyLock=" + str(locks[sortedIteration].id)) = 0) then UpdateLocksDatabase(sortedIteration, "", 0)
		endif
		if (GetSpriteImageID(lockCard[cardNo].sprSyncStatus) <> imgSyncing)
			if (offline = 0)
				if (OryUIIsNameInHTTPSQueue(httpsQueue, "UpdateMyLock=" + str(locks[sortedIteration].id))) then OryUIUpdateSprite(lockCard[cardNo].sprSyncStatus, "image:" + str(imgSyncing) + ";alpha:255")
			else
				if (OryUIIsNameInHTTPSQueue(httpsQueue, "UpdateMyLock=" + str(locks[sortedIteration].id))) then OryUIUpdateSprite(lockCard[cardNo].sprSyncStatus, "image:" + str(imgNotSynced) + ";alpha:255")
			endif
		endif
		if (locks[sortedIteration].timestampLastSynced > locks[sortedIteration].timestampLastPicked and GetSpriteImageID(lockCard[cardNo].sprSyncStatus) <> imgSynced) then OryUIUpdateSprite(lockCard[cardNo].sprSyncStatus, "image:" + str(imgSynced) + ";alpha:255")

		// LOCKED
		if (locks[sortedIteration].unlocked = 0)
			if (timestampFromServer < 1000000000)
				if (reposition = 1)
					OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
					OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
					OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtTimeLockedHeader, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 2.8)
					OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
					OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
					OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Requires Server Time;color:192,57,42,255")
					OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Connect to the internet to continue this lock.;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
					OryUIUpdateText(lockCard[cardNo].txtTimeLockedHeader, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:N/A;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					if (locks[sortedIteration].regularity# = 24)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Days;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					elseif (locks[sortedIteration].regularity# > 0.5)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hours;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minutes;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				endif
			else
				if (locks[sortedIteration].readyToUnlock = 0)
					if (locks[sortedIteration].fixed = 0)
						locks[sortedIteration].checkingForUpdates = 0
						//if (timestampNow - locks[sortedIteration].timestampLastCheckedUpdates >= 60 and locks[sortedIteration].timestampLastCheckedUpdates >= locks[sortedIteration].timestampLocked and locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].hiddenFromOwner = 0)
							//if (OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].GetLockUpdates) = 0) then GetLockUpdates(1)
						//	locks[sortedIteration].checkingForUpdates = 1
						//endif
						if (locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].keyholderID <> 0 and OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetLockUpdates) = 1) then locks[sortedIteration].checkingForUpdates = 1
						if (locks[sortedIteration].checkingForUpdates = 1)
							if (reposition = 1)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Checking For Updates;color:192,57,42,255")
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Checking for keyholder updates. Please wait;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
							endif
						elseif (locks[sortedIteration].lockFrozenByKeyholder = 1)
							if (reposition = 1)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Frozen By Keyholder;color:192,57,42,255")
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Waiting for keyholder to unfreeze lock;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
							endif
						elseif (locks[sortedIteration].lockFrozenByCard = 1)
							if (reposition = 1)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
								OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Frozen By Card;color:192,57,42,255")
								if (locks[sortedIteration].regularity# = 0.016667) then frozenTime$ = "2-4 minutes"
								if (locks[sortedIteration].regularity# = 0.25) then frozenTime$ = "30-60 minutes"
								if (locks[sortedIteration].regularity# = 0.5) then frozenTime$ = "1-2 hours"
								if (locks[sortedIteration].regularity# = 1) then frozenTime$ = "2-4 hours"
								if (locks[sortedIteration].regularity# = 3) then frozenTime$ = "6-12 hours"
								if (locks[sortedIteration].regularity# = 6) then frozenTime$ = "12-24 hours"
								if (locks[sortedIteration].regularity# = 12) then frozenTime$ = "24-48 hours"
								if (locks[sortedIteration].regularity# = 24) then frozenTime$ = "2-4 days"
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Lock frozen for " + frozenTime$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
							endif
							if (timestampNow > locks[sortedIteration].timestampUnfreezes)
								locks[sortedIteration].lockFrozenByCard = 0
								locks[sortedIteration].timestampUnfrozen = locks[sortedIteration].timestampUnfreezes
								if (locks[sortedIteration].regularity# = 0.016667) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (60 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 0.25) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (900 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 0.5) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (1800 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 1) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (3600 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 3) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (10800 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 6) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (21600 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 12) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (43200 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								if (locks[sortedIteration].regularity# = 24) then locks[sortedIteration].timestampLastPicked = locks[sortedIteration].timestampUnfrozen - (86400 * locks[sortedIteration].chancesAccumulatedBeforeFreeze)
								locks[sortedIteration].timestampUnfreezes = 0
								locks[sortedIteration].chancesAccumulatedBeforeFreeze = 0
								if (locks[sortedIteration].timestampFrozenByCard > 0)
									locks[sortedIteration].totalTimeFrozen = locks[sortedIteration].totalTimeFrozen + (locks[sortedIteration].timestampUnfrozen - locks[sortedIteration].timestampFrozenByCard)
								endif
								UpdateLocksData(sortedIteration)
								UpdateLocksDatabase(sortedIteration, "action:CardFreezeEnded;actionedBy:App;totalActionTime:" + str(locks[sortedIteration].timestampUnfrozen - locks[sortedIteration].timestampFrozenByCard), 0)
								screen[screenNo].lastViewY# = GetViewOffsetY()
								SetScreenToView(constMyLocksScreen)
							endif
						else
							if (locks[sortedIteration].regularity# = 0.016667) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 60) - timestampNow
							if (locks[sortedIteration].regularity# = 0.25) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 900) - timestampNow
							if (locks[sortedIteration].regularity# = 0.5) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 1800) - timestampNow
							if (locks[sortedIteration].regularity# = 1) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 3600) - timestampNow
							if (locks[sortedIteration].regularity# = 3) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 10800) - timestampNow
							if (locks[sortedIteration].regularity# = 6) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 21600) - timestampNow
							if (locks[sortedIteration].regularity# = 12) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 43200) - timestampNow
							if (locks[sortedIteration].regularity# = 24) then secondsLeft = (locks[sortedIteration].timestampLastPicked + 86400) - timestampNow
							dd = floor(secondsLeft / 60 / 60 / 24)
							hh = floor(mod(secondsLeft / 60 / 60, 24))
							mm = floor(mod(secondsLeft / 60, 60))
							ss = floor(mod(secondsLeft, 60))
							if (secondsLeft > 0)
								locks[sortedIteration].readyToPick = 0
								if (reposition = 1)
									OrYUIPinTextToTopLeftOfSprite(lockCard[cardNo].txtNextChanceInHeader, lockCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 0.1)
									for a = 1 to 4
										OryUIPinSpriteToSprite(lockCard[cardNo].sprCircle[a], lockCard[cardNo].sprBackground, (2 / GetDisplayAspect()) + ((a - 1) * (9.0 / GetDisplayAspect())), (GetSpriteHeight(lockCard[cardNo].sprBackground) / 2.0) - (GetSpriteHeight(lockCard[cardNo].sprCircle[a]) / 2.0))	
										if (a = 4) then OryUIPinTextToTopCentreOfSprite(lockCard[cardNo].txtCircleHeader[a], lockCard[cardNo].sprCircle[a], 0, 1.4)
										if (a <= 3) then OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtCircle[a], lockCard[cardNo].sprCircle[a], 0, 0)
										if (a = 4) then OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtCirclePercentage[a], lockCard[cardNo].sprCircle[a], 0, 0)
										OryUIPinTextToBottomCentreOfSprite(lockCard[cardNo].txtCircleFooter[a], lockCard[cardNo].sprCircle[a], 0, -1.4)
										OryUIPinSpriteToSprite(lockCard[cardNo].sprArc[a], lockCard[cardNo].sprCircle[a], -0.3 / GetDisplayAspect(), -0.3)									
									next
								endif
								SetTextColor(lockCard[cardNo].txtNextChanceInHeader, GetColorRed(colorMode[colorModeSelected].textColor), GetColorGreen(colorMode[colorModeSelected].textColor), GetColorBlue(colorMode[colorModeSelected].textColor), 200)
								for a = 1 to 4
									SetSpriteColor(lockCard[cardNo].sprCircle[a], GetColorRed(colorMode[colorModeSelected].barColor), GetColorGreen(colorMode[colorModeSelected].barColor), GetColorBlue(colorMode[colorModeSelected].barColor), 255)
									if (a <= 3)
										if (a = 1)
											value = hh
											valuePercentage# = (100.0 / 24.0) * hh
											footer$ = "HOUR"
											if (value <> 1) then footer$ = "HOURS"
										endif
										if (a = 2)
											value = mm
											valuePercentage# = (100.0 / 60.0) * mm
											footer$ = "MIN"
											if (value <> 1) then footer$ = "MINS"
										endif
										if (a = 3)
											value = ss
											valuePercentage# = (100.0 / 60.0) * ss
											footer$ = "SEC"
											if (value <> 1) then footer$ = "SECS"
										endif
										if (valuePercentage# < 0) then valuePercentage# = 0
										SetTextString(lockCard[cardNo].txtCircle[a], str(value))
										if (colorModeSelected <> 2)
											OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(theme[themeSelected].color[3]))
											OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(theme[themeSelected].color[3]))
											OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(theme[themeSelected].color[3]))
										else
											if (themeSelected <> 10)
												OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(theme[themeSelected].color[1]))
												OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(theme[themeSelected].color[1]))
												OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(theme[themeSelected].color[1]))
											else
												OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
												OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
												OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
											endif
										endif
										SetTextString(lockCard[cardNo].txtCircleFooter[a], footer$)
										SetShaderConstantByName(lockCard[cardNo].shaderArc[a], "Percentage", valuePercentage#, 0, 0, 0)
										DrawSprite(lockCard[cardNo].sprArc[a])
									endif
									if (a = 4)
										if (locks[sortedIteration].cardInfoHidden = 0)
											totalCards# = GetNoOfCards(sortedIteration)
											for b = 1 to 7
												if (lockCard[cardNo].sprChanceArc[b] > 0)
													OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprChanceArc[b], lockCard[cardNo].sprCircle[a], 0, 0)
													if (b = 1)
														valuePercentage# = ((locks[sortedIteration].greenCards * 1.0) / totalCards#) * 100.0
														angle# = -((360.0 / 100.0) * (valuePercentage# / 2))
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 22, 160, 133, 55)
													endif
													if (b = 2)
														valuePercentage# = ((locks[sortedIteration].redCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 192, 57, 42, 55)
													endif
													if (b = 3)
														valuePercentage# = ((locks[sortedIteration].stickyCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 235, 136, 0, 55)
													endif
													if (b = 4)
														valuePercentage# = ((locks[sortedIteration].yellowCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 241, 196, 15, 55)
													endif
													if (b = 5)
														valuePercentage# = ((locks[sortedIteration].freezeCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 170, 195, 195, 55)
													endif
													if (b = 6)
														valuePercentage# = ((locks[sortedIteration].doubleUpCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 142, 68, 173, 55)
													endif
													if (b = 7)
														valuePercentage# = ((locks[sortedIteration].resetCards * 1.0) / totalCards#) * 100.0
														angle# = angle# - ((360.0 / 100.0) * valuePercentage#)
														SetSpriteColor(lockCard[cardNo].sprChanceArc[b], 41, 128, 185, 55)
													endif
													if (valuePercentage# < 0) then valuePercentage# = 0
													SetShaderConstantByName(lockCard[cardNo].shaderChanceArc[b], "Percentage", valuePercentage#, 0, 0, 0)
													SetSpriteAngle(lockCard[cardNo].sprChanceArc[b], angle#)
													DrawSprite(lockCard[cardNo].sprChanceArc[b])
												endif
											next
										endif
									endif
								next
								if (locks[sortedIteration].cardInfoHidden = 0)
									SetTextString(lockCard[cardNo].txtCircleFooter[4], "CHANCE")
									mod12 = mod(secondsRunning, 14)
									if (mod12 = 1 or mod12 = 2)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[1], 22, 160, 133, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "GREEN")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].greenCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 3 or mod12 = 4)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[2], 192, 57, 42, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "RED")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].redCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 5 or mod12 = 6)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[3], 235, 136, 0, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "STICKY")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].stickyCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 7 or mod12 = 8)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[4], 241, 196, 15, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "YELLOW")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].yellowCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 9 or mod12 = 10)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[5], 170, 195, 195, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "FREEZE")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].freezeCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 11 or mod12 = 12)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[6], 142, 68, 173, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "DOUBLE UP")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].doubleUpCards * 1.0) / totalCards#) * 100, 1) + "%")
									elseif (mod12 = 13 or mod12 = 0)
										SetSpriteColor(lockCard[cardNo].sprChanceArc[7], 41, 128, 185, 255)
										SetTextString(lockCard[cardNo].txtCircleHeader[4], "RESET")
										SetTextString(lockCard[cardNo].txtCirclePercentage[4], str(((locks[sortedIteration].resetCards * 1.0) / totalCards#) * 100, 1) + "%")
									endif
									if (colorModeSelected <> 2)
										OryUIUpdateText(lockCard[cardNo].txtCircleHeader[4], "colorID:" + str(theme[themeSelected].color[3]))
										OryUIUpdateText(lockCard[cardNo].txtCirclePercentage[4], "colorID:" + str(theme[themeSelected].color[3]))
										OryUIUpdateText(lockCard[cardNo].txtCircleFooter[4], "colorID:" + str(theme[themeSelected].color[3]))
									else
										if (themeSelected <> 10)
											OryUIUpdateText(lockCard[cardNo].txtCircleHeader[4], "colorID:" + str(theme[themeSelected].color[1]))
											OryUIUpdateText(lockCard[cardNo].txtCirclePercentage[4], "colorID:" + str(theme[themeSelected].color[1]))
											OryUIUpdateText(lockCard[cardNo].txtCircleFooter[4], "colorID:" + str(theme[themeSelected].color[1]))
										else
											OryUIUpdateText(lockCard[cardNo].txtCircleHeader[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIUpdateText(lockCard[cardNo].txtCirclePercentage[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
											OryUIUpdateText(lockCard[cardNo].txtCircleFooter[4], "colorID:" + str(colorMode[colorModeSelected].textColor))
										endif
									endif
								else
									if (reposition = 1)
										OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprCircleSecretSticker[4], lockCard[cardNo].sprCircle[4], 0, 0)
									endif
									SetSpriteColorAlpha(lockCard[cardNo].sprCircleSecretSticker[4], 255)
								endif
							endif
							if (secondsLeft <= 0)
								if (locks[sortedIteration].readyToPick = 0 and GetSpriteInScreen(lockCard[cardNo].sprBackground))
									locks[sortedIteration].readyToPick = 1
									screen[screenNo].lastViewY# = GetViewOffsetY()
									SetScreenToView(constMyLocksScreen)
								endif
								if (reposition = 1)
									OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
									OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
									OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtGreaterThanSign, lockCard[cardNo].sprBackground, -(0.5 / GetDisplayAspect()), 0)
									OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Tap To Try & Unlock;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									OryUIUpdateText(lockCard[cardNo].txtGreaterThanSign, "colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
								endif
								noOfChances = 0
								if (locks[sortedIteration].regularity# = 0.016667)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60)
								elseif (locks[sortedIteration].regularity# = 0.25)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 15)
								elseif (locks[sortedIteration].regularity# = 0.5)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 30)
								elseif (locks[sortedIteration].regularity# = 1)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 60)
								elseif (locks[sortedIteration].regularity# = 3)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 60 / 3)
								elseif (locks[sortedIteration].regularity# = 6)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 60 / 6)
								elseif (locks[sortedIteration].regularity# = 12)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 60 / 12)
								elseif (locks[sortedIteration].regularity# = 24)
									noOfChances = floor((timestampNow - locks[sortedIteration].timestampLastPicked) / 60 / 60 / 24)
								endif
								if (locks[sortedIteration].cumulative = 0 and noOfChances > 1) then noOfChances = 1
								if (noOfChances <> 1)
									OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:" + str(noOfChances) + " Chances;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
								else
									OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:1 Chance;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
								endif
							endif
						endif
					endif
					if (locks[sortedIteration].fixed = 1)
						if (locks[sortedIteration].lockFrozenByKeyholder = 1)
							// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
							if (locks[sortedIteration].regularity# = 0.016667) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (60 * locks[sortedIteration].minutes)) - locks[sortedIteration].timestampFrozenByKeyholder
							// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
							if (locks[sortedIteration].regularity# = 0.25) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (900 * locks[sortedIteration].redCards)) - locks[sortedIteration].timestampFrozenByKeyholder
							if (locks[sortedIteration].regularity# = 1) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (3600 * locks[sortedIteration].redCards)) - locks[sortedIteration].timestampFrozenByKeyholder
							if (locks[sortedIteration].regularity# = 24) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (86400 * locks[sortedIteration].redCards)) - locks[sortedIteration].timestampFrozenByKeyholder
						else
							// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
							if (locks[sortedIteration].regularity# = 0.016667) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (60 * locks[sortedIteration].minutes)) - timestampNow
							// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
							if (locks[sortedIteration].regularity# = 0.25) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (900 * locks[sortedIteration].redCards)) - timestampNow
							if (locks[sortedIteration].regularity# = 1) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (3600 * locks[sortedIteration].redCards)) - timestampNow
							if (locks[sortedIteration].regularity# = 24) then secondsLeft = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (86400 * locks[sortedIteration].redCards)) - timestampNow
						endif
						dd = floor(secondsLeft / 60 / 60 / 24)
						hh = floor(mod(secondsLeft / 60 / 60, 24))
						mm = floor(mod(secondsLeft / 60, 60))
						ss = floor(mod(secondsLeft, 60))
						
						if (secondsLeft > 0)
							if (locks[sortedIteration].timerHidden = 1)
								locks[sortedIteration].checkingForUpdates = 0
								//if (timestampNow - locks[sortedIteration].timestampLastCheckedUpdates >= 60 and locks[sortedIteration].timestampLastCheckedUpdates >= locks[sortedIteration].timestampLocked and locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].hiddenFromOwner = 0)
									//if (OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].GetLockUpdates) = 0) then GetLockUpdates(1)
									//locks[sortedIteration].checkingForUpdates = 1
								//endif
								if (locks[sortedIteration].sharedID$ <> "" and OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetLockUpdates) = 1) then locks[sortedIteration].checkingForUpdates = 1
								if (locks[sortedIteration].checkingForUpdates = 1)
									if (reposition = 1)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Checking For Updates;color:192,57,42,255")
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Checking for keyholder updates. Please wait;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									endif
								elseif (locks[sortedIteration].lockFrozenByKeyholder = 1)
									if (reposition = 1)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Frozen By Keyholder;color:192,57,42,255")
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Waiting for keyholder to unfreeze lock;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									endif
								else
									if (reposition = 1)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Timer Hidden;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Check back later;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									endif
								endif
							else
								locks[sortedIteration].checkingForUpdates = 0
								//if (timestampNow - locks[sortedIteration].timestampLastCheckedUpdates >= 60 and locks[sortedIteration].timestampLastCheckedUpdates >= locks[sortedIteration].timestampLocked and locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].hiddenFromOwner = 0)
									//if (OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].GetLockUpdates) = 0) then GetLockUpdates(1)
									//locks[sortedIteration].checkingForUpdates = 1
								//endif
								if (locks[sortedIteration].sharedID$ <> "" and OryUIIsScriptInHTTPSQueue(httpsQueue, URLs[0].URLPath + "/" + URLs[0].GetLockUpdates) = 1) then locks[sortedIteration].checkingForUpdates = 1
								if (locks[sortedIteration].checkingForUpdates = 1)
									if (reposition = 1)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Checking For Updates;color:192,57,42,255")
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Checking for keyholder updates. Please wait;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									endif
								elseif (locks[sortedIteration].lockFrozenByKeyholder = 1)
									OryUIUpdateText(lockCard[cardNo].txtUnlocksInHeader, "text:Frozen By Keyholder;color:192,57,42,200")
								else
									OryUIUpdateText(lockCard[cardNo].txtUnlocksInHeader, "text:Unlocks In;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
								endif
								if (locks[sortedIteration].checkingForUpdates = 0)
									if (reposition = 1)
										OrYUIPinTextToTopLeftOfSprite(lockCard[cardNo].txtUnlocksInHeader, lockCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 0.1)
										for a = 1 to 4
											OryUIUpdateSprite(lockCard[cardNo].sprCircle[a], "colorID:" + str(colorMode[colorModeSelected].barColor) + ";alpha:255")
											OryUIPinSpriteToSprite(lockCard[cardNo].sprCircle[a], lockCard[cardNo].sprBackground, (2 / GetDisplayAspect()) + ((a - 1) * (9.0 / GetDisplayAspect())), (GetSpriteHeight(lockCard[cardNo].sprBackground) / 2.0) - (GetSpriteHeight(lockCard[cardNo].sprCircle[a]) / 2.0))	
											if (colorModeSelected <> 2)
												OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(theme[themeSelected].color[3]))
											else
												if (themeSelected <> 10)
													OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(theme[themeSelected].color[1]))
												else
													OryUIUpdateText(lockCard[cardNo].txtCircle[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
												endif
											endif
											OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtCircle[a], lockCard[cardNo].sprCircle[a], 0, 0)
											if (colorModeSelected <> 2)
												OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(theme[themeSelected].color[3]))
											else
												if (themeSelected <> 10)
													OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(theme[themeSelected].color[1]))
												else
													OryUIUpdateText(lockCard[cardNo].txtCircleFooter[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
												endif
											endif
											OryUIPinTextToBottomCentreOfSprite(lockCard[cardNo].txtCircleFooter[a], lockCard[cardNo].sprCircle[a], 0, -1.4)
											if (locks[sortedIteration].lockFrozenByKeyholder = 1)
												OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprIceCapArch[a], lockCard[cardNo].sprCircle[a], 0, 0)
											else
												if (colorModeSelected <> 2)
													OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(theme[themeSelected].color[3]))
												else
													if (themeSelected <> 10)
														OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(theme[themeSelected].color[1]))
													else
														OryUIUpdateSprite(lockCard[cardNo].sprArc[a], "colorID:" + str(colorMode[colorModeSelected].textColor))
													endif
												endif
												OryUIPinSpriteToSprite(lockCard[cardNo].sprArc[a], lockCard[cardNo].sprCircle[a], -0.3 / GetDisplayAspect(), -0.3)
											endif
										next
									endif
								endif
									
								for a = 1 to 4
									if (a = 1)
										value = dd
										valuePercentage# = (100.0 / locks[sortedIteration].redCards) * dd
										footer$ = "DAY"
										if (value <> 1) then footer$ = "DAYS"
									endif
									if (a = 2)
										value = hh
										valuePercentage# = (100.0 / 24.0) * hh
										footer$ = "HOUR"
										if (value <> 1) then footer$ = "HOURS"
									endif
									if (a = 3)
										value = mm
										valuePercentage# = (100.0 / 60.0) * mm
										footer$ = "MIN"
										if (value <> 1) then footer$ = "MINS"
									endif
									if (a = 4)
										value = ss
										valuePercentage# = (100.0 / 60.0) * ss
										footer$ = "SEC"
										if (value <> 1) then footer$ = "SECS"
									endif
									if (valuePercentage# < 0) then valuePercentage# = 0
									SetTextString(lockCard[cardNo].txtCircle[a], str(value))
									SetTextString(lockCard[cardNo].txtCircleFooter[a], footer$)
									if (locks[sortedIteration].lockFrozenByKeyholder = 0)
										SetShaderConstantByName(lockCard[cardNo].shaderArc[a], "Percentage", valuePercentage#, 0, 0, 0)
										DrawSprite(lockCard[cardNo].sprArc[a])
									endif
								next
							endif
						else
							// FIXED LOCK VERSION 2.5.0+ (USING MINUTES)
							if (locks[sortedIteration].regularity# = 0.016667) then timestampExpectedUnlock = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (60 * locks[sortedIteration].minutes))
							// FIXED LOCK BEFORE VERSION 2.5.0 (USING RED CARDS)
							if (locks[sortedIteration].regularity# = 0.25) then timestampExpectedUnlock = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (900 * locks[sortedIteration].redCards))
							if (locks[sortedIteration].regularity# = 1) then timestampExpectedUnlock = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (3600 * locks[sortedIteration].redCards))
							if (locks[sortedIteration].regularity# = 24) then timestampExpectedUnlock = (locks[sortedIteration].timestampLocked + locks[sortedIteration].totalTimeFrozen + (86400 * locks[sortedIteration].redCards))
							if (locks[sortedIteration].readyToUnlock = 0)
								// CHECK FOR LAST MINUTE UPDATES ON A FIXED LOCK
								if (locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].hiddenFromOwner = 0 and locks[sortedIteration].removedByKeyholder = 0 and timestampLastReceivedUpdateResponse < timestampExpectedUnlock)
									if (OryUIIsNameInHTTPSQueue(httpsQueue, "GetLockUpdates") = 0)
										GetLockUpdates(1)
										SetScreenToView(constMyLocksScreen)
									endif
									if (reposition = 1)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
										OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Checking For Updates;color:192,57,42,255")
										OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Checking for last minute updates;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
									endif
								else
									locks[sortedIteration].readyToUnlock = 1
									UpdateLocksData(sortedIteration)
									UpdateLocksDatabase(sortedIteration, "action:ReadyToUnlock;actionedBy:App;result:DecideLater", 0)
									screen[screenNo].lastViewY# = GetViewOffsetY()
									SetScreenToView(constMyLocksScreen)
								endif
							endif
						endif
					endif
				else
					maxWaitTime = 0
					if (locks[sortedIteration].fixed = 0 and locks[sortedIteration].regularity# <= 3) then maxWaitTime = 3600 * 3
					if (locks[sortedIteration].fixed = 0 and locks[sortedIteration].regularity# >= 6) then maxWaitTime = 3600 * 6
					if (locks[sortedIteration].fixed = 1 and locks[sortedIteration].regularity# = 0.016667) then maxWaitTime = 3600 * 3
					if (maxWaitTime - (timestampNow - locks[sortedIteration].timestampRequestedKeyholdersDecision) > 0)
						if (reposition = 1)
							OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
							OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
							OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Keyholder To Decide;color:192,57,42,255")
						endif
						mod8 = mod(secondsRunning, 8)
						hh = mod(Round((maxWaitTime - (timestampNow - locks[sortedIteration].timestampRequestedKeyholdersDecision)) / 60.0 / 60.0), 24)
						mm = mod((maxWaitTime - (timestampNow - locks[sortedIteration].timestampRequestedKeyholdersDecision)) / 60, 60)
						ss = mod((maxWaitTime - (timestampNow - locks[sortedIteration].timestampRequestedKeyholdersDecision)), 60)
						if (mod8 >= 1 and mod8 <= 4)
							OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:Waiting for keyholder to decide the outcome;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
						endif
						if (mod8 >= 5 or mod8 = 0)
							if (hh > 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in about " + str(hh) + " hours;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							elseif (hh = 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in about 1-2 hours;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							elseif (mm > 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in " + str(mm) + " minutes;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							elseif (mm = 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in 1-2 minutes;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							elseif (ss > 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in " + str(ss) + " seconds;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							elseif (ss = 1)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text:You can decide again in 1 second;colorID:" + str(theme[themeSelected].color[3]) + ";alpha:150")
							endif
						endif
						if (hh = 0 and mm = 0 and ss = 1)
							screen[screenNo].lastViewY# = GetViewOffsetY()
							SetScreenToView(constMyLocksScreen)
						endif
					else
						if (reposition = 1)
							OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlock, lockCard[cardNo].sprBackground, 0, 0)
							OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtTapToUnlockFooter, lockCard[cardNo].sprBackground, 0, GetTextTotalHeight(lockCard[cardNo].txtTapToUnlock) / 1.5)
							if (locks[sortedIteration].fixed = 0)
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Ready To Unlock;color:41,128,185,255")
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text: ;alpha:150")
							else
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlock, "text:Tap To View Combination;color:41,128,185,255")
								OryUIUpdateText(lockCard[cardNo].txtTapToUnlockFooter, "text: ;alpha:150")
							endif
						endif
					endif
				endif
				if (locks[sortedIteration].regularity# < 24)
					if (reposition = 1)
						OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtTimeLockedHeader, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 2.8)
						OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
						OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedHeader, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
					minutesLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60)
					hoursLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60 / 60)
					daysLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60 / 60 / 24)
					if (hoursLocked < 1)
						if (minutesLocked >= 0)
							OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(minutesLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:N/A;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						endif	
						if (floor((timestampNow - locks[sortedIteration].timestampLocked) / 60) <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minutes;colorID:" + str(colorMode[colorModeSelected].textColor) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minute;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						endif
					elseif (hoursLocked < 168)
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(hoursLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						if (hoursLocked <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hours;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hour;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						endif
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(daysLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						if (daysLocked <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Days;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Day;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						endif
					endif
				elseif (locks[sortedIteration].regularity# = 24)
					if (reposition = 1)
						OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtTimeLockedHeader, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 2.8)
						OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
						OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedHeader, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
					minutesLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60)
					hoursLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60 / 60)
					daysLocked = floor((timestampNow - locks[sortedIteration].timestampLocked) / 60 / 60 / 24)
					if (hoursLocked < 1)
						if (minutesLocked >= 0)
							OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(minutesLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:N/A;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						endif	
						OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
						if (floor((timestampNow - locks[sortedIteration].timestampLocked) / 60) <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minutes;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
							OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minute;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
							OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
						endif
					elseif (hoursLocked < 24)
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(hoursLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						if (hoursLocked <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hours;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hour;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						endif
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(daysLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
						if (daysLocked <> 1)
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Days;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						else
							OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Day;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
						endif
					endif
				endif
				if (locks[sortedIteration].keyholderUsername$ = "")
					if (reposition = 1)
						OryUIPinTextToBottomCentreOfSprite(lockCard[cardNo].txtFooter, lockCard[cardNo].sprBackground, 0, 0)
						OryUIUpdateText(lockCard[cardNo].txtFooter, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
					endif
				else
					if (reposition = 1)
						OryUIPinTextToBottomCentreOfSprite(lockCard[cardNo].txtFooter, lockCard[cardNo].sprBackground, 0, 0)
					endif
					OryUIUpdateText(lockCard[cardNo].txtFooter, "text:Locked by " + locks[sortedIteration].keyholderUsername$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
					SetUsernameColorArray(locks[sortedIteration].keyholderMainRole, locks[sortedIteration].keyholderMainRoleLevel)
					for a = 10 to 10 + len(locks[sortedIteration].keyholderUsername$)
						SetTextCharBold(lockCard[cardNo].txtFooter, a, 1)
						SetTextCharColor(lockCard[cardNo].txtFooter, a, usernameColor[0], usernameColor[1], usernameColor[2], usernameColor[3])
					next
					OryUIUpdateSprite(lockCard[cardNo].sprUsernameButton, "size:" + str((GetTextCharX(lockCard[cardNo].txtFooter, len(GetTextString(lockCard[cardNo].txtFooter)) - 1) + 50) - (GetTextCharX(lockCard[cardNo].txtFooter, 8) + 50)) + "," + str(GetTextTotalHeight(lockCard[cardNo].txtFooter)) + ";position:" + str((screenNo * 100) + 50 + GetTextCharX(lockCard[cardNo].txtFooter, 10)) + "," + str(GetTextY(lockCard[cardNo].txtFooter)))
					if (locks[sortedIteration].keyholderEmojiChosen > 0)
						OryUIUpdateSprite(lockCard[cardNo].sprKeyholderEmojiIcon, "image:" + str(imgEmojis[locks[sortedIteration].keyholderEmojiColourSelected, locks[sortedIteration].keyholderEmojiChosen]) + ";color:255,255,255,255")
					else
						OryUIUpdateSprite(lockCard[cardNo].sprKeyholderEmojiIcon, "image:" + str(imgEmojiIcon) + ";alpha:0")
					endif
					OryUIPinSpriteToCentreRightOfSprite(lockCard[cardNo].sprKeyholderEmojiIcon, lockCard[cardNo].sprUsernameButton, GetSpriteWidth(lockCard[cardNo].sprKeyholderEmojiIcon) / 2, 0)
				endif
			endif
		endif
		
		// UNLOCKED
		if (locks[sortedIteration].unlocked = 1)
			if (reposition = 1)
				OryUIPinTextToTopLeftOfSprite(lockCard[cardNo].txtCombinationHeader, lockCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 1.8)
				OryUIPinTextToCentreLeftOfSprite(lockCard[cardNo].txtCombination, lockCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 0)			
				OryUIPinTextToBottomCentreOfSprite(lockCard[cardNo].txtFooter, lockCard[cardNo].sprBackground, 0, 0)
				OryUIUpdateText(lockCard[cardNo].txtCombinationHeader, "colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
				if (colorModeSelected = 2 and themeSelected = 10)
					OryUIUpdateText(lockCard[cardNo].txtCombination, "size:8.3;text:" + locks[sortedIteration].combination$ + ";colorID:" + str(theme[themeSelected].color[1]) + ";alpha:255")
				else
					OryUIUpdateText(lockCard[cardNo].txtCombination, "size:8.3;text:" + locks[sortedIteration].combination$ + ";colorID:" + str(theme[themeSelected].color[5]) + ";alpha:255")
				endif
				while (GetTextTotalWidth(lockCard[cardNo].txtCombination) > 75)
					OryUIUpdateText(lockCard[cardNo].txtCombination, "size:" + str(GetTextSize(lockCard[cardNo].txtCombination) - 0.1))
				endwhile
				OryUIUpdateText(lockCard[cardNo].txtCombination, "text:" + locks[sortedIteration].combination$)
				OryUIPinTextToCentreLeftOfSprite(lockCard[cardNo].txtCombination, lockCard[cardNo].sprBackground, 2 / GetDisplayAspect(), 0)		
				OryUIUpdateText(lockCard[cardNo].txtFooter, "text:Unlocked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
			endif
			if (locks[sortedIteration].regularity# < 24)
				if (reposition = 1)
					OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtTimeLockedHeader, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 2.8)
					OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
					OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
					OryUIUpdateText(lockCard[cardNo].txtTimeLockedHeader, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
				endif
				minutesLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60)
				hoursLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60 / 60)
				daysLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60 / 60 / 24)
				if (hoursLocked < 1)
					if (minutesLocked >= 0)
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(minutesLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:N/A;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					endif	
					if (floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60) <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minutes;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minute;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				elseif (hoursLocked < 168)
					OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(hoursLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					if (hoursLocked <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hours;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hour;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				else
					OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(daysLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					if (daysLocked <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Days;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Day;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				endif
			elseif (locks[sortedIteration].regularity# = 24)
				if (reposition = 1)
					OryUIPinTextToTopRightOfSprite(lockCard[cardNo].txtTimeLockedHeader, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 2.8)
					OryUIPinTextToCentreRightOfSprite(lockCard[cardNo].txtTimeLocked, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), 0)
					OryUIPinTextToBottomRightOfSprite(lockCard[cardNo].txtTimeLockedFooter, lockCard[cardNo].sprBackground, -(2 / GetDisplayAspect()), -2.8)
					OryUIUpdateText(lockCard[cardNo].txtTimeLockedHeader, "text:Locked;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
				endif
				minutesLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60)
				hoursLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60 / 60)
				daysLocked = floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60 / 60 / 24)
				if (hoursLocked < 1)
					if (minutesLocked >= 0)
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(minutesLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:N/A;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					endif
					if (floor((locks[sortedIteration].timestampUnlocked - locks[sortedIteration].timestampLocked) / 60) <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minutes;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Minute;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				elseif (hoursLocked < 24)
					OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(hoursLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					if (hoursLocked <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hours;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Hour;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				else
					OryUIUpdateText(lockCard[cardNo].txtTimeLocked, "text:" + str(daysLocked) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:255")
					if (daysLocked <> 1)
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Days;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					else
						OryUIUpdateText(lockCard[cardNo].txtTimeLockedFooter, "text:Day;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:200")
					endif
				endif
			endif
			
			// RATING
			if (locks[sortedIteration].sharedID$ <> "" and locks[sortedIteration].hiddenFromOwner = 0 and locks[sortedIteration].removedByKeyholder = 0)
				// If not rated and unlocked less than 7 days ago, or if rated and was last updated 1 day ago then let lockee rate keyholder
				if (locks[sortedIteration].test = 0 and ((timestampNow - locks[sortedIteration].timestampUnlocked <= 604800 and locks[sortedIteration].rating = 0) or (timestampNow - locks[sortedIteration].timestampRated <= 86400 and locks[sortedIteration].rating > 0)))
					OryUIUpdateText(lockCard[cardNo].txtRateKeyholder, "text:Rate " + locks[sortedIteration].keyholderUsername$ + " and this lock;colorID:" + str(colorMode[colorModeSelected].textColor))
					OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtRateKeyholder, lockCard[cardNo].sprButtonBar, 0, -1.5)
					for a = 1 to 5
						if (a <= locks[sortedIteration].rating)
							OryUIUpdateSprite(lockCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOn))
						else
							OryUIUpdateSprite(lockCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOff))
						endif
						if (a = 1) then OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRatingStar[a], lockCard[cardNo].sprButtonBar, -(2 * (GetSpriteWidth(lockCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
						if (a = 2) then OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRatingStar[a], lockCard[cardNo].sprButtonBar, -(GetSpriteWidth(lockCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
						if (a = 3) then OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRatingStar[a], lockCard[cardNo].sprButtonBar, 0, 0.8)	
						if (a = 4) then OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRatingStar[a], lockCard[cardNo].sprButtonBar, (GetSpriteWidth(lockCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
						if (a = 5) then OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRatingStar[a], lockCard[cardNo].sprButtonBar, (2 * (GetSpriteWidth(lockCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
					next
				else
					for a = 1 to 5
						OryUIUpdateSprite(lockCard[cardNo].sprRatingStar[a], "position:-1000,-1000")
					next
					if (locks[sortedIteration].rating = 0)
						OryUIUpdateText(lockCard[cardNo].txtRateKeyholder, "text: ;colorID:" + str(colorMode[colorModeSelected].textColor))
						OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtRateKeyholder, lockCard[cardNo].sprButtonBar, 0, 0)
					elseif (locks[sortedIteration].rating = 1)
						OryUIUpdateText(lockCard[cardNo].txtRateKeyholder, "text:You rated this 1 star;colorID:" + str(colorMode[colorModeSelected].textColor))
						OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtRateKeyholder, lockCard[cardNo].sprButtonBar, 0, 0)
					else
						OryUIUpdateText(lockCard[cardNo].txtRateKeyholder, "text:You rated this " + str(locks[sortedIteration].rating) + " stars;colorID:" + str(colorMode[colorModeSelected].textColor))
						OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtRateKeyholder, lockCard[cardNo].sprButtonBar, 0, 0)
					endif	
				endif
			endif
		endif
	
		deleteButtonVisible = 0
		unlockButtonVisible = 0
		restartButtonVisible = 0
		emptyLeftButtonVisible = 1
		checkInButtonVisible = 0
		cleanButtonVisible = 0
		emptyRightButtonVisible = 1
		moodButtonVisible = 0
		flagButtonVisible = 1
		moreButtonVisible = 1
		buttonX# = 0
		buttonsPlaced = 0
		if (maintenance = 0 and offline = 0) then deleteButtonVisible = 1
		if (locks[sortedIteration].unlocked = 0 and ((locks[sortedIteration].keyDisabled = 0 and locks[sortedIteration].keyholderDisabledKey = 0) or (locks[sortedIteration].hiddenFromOwner = 1 and locks[sortedIteration].hiddenFromOwnerAlertHidden = 0) or (locks[sortedIteration].removedByKeyholder = 1 and locks[sortedIteration].removedByKeyholderAlertHidden = 0) or locks[sortedIteration].keyholderAllowsFreeUnlock = 1)) then unlockButtonVisible = 1
		if (locks[sortedIteration].fixed = 0 and locks[sortedIteration].regularity# <= 3) then maxWaitTime = 3600 * 3
		if (locks[sortedIteration].fixed = 0 and locks[sortedIteration].regularity# >= 6) then maxWaitTime = 3600 * 6
		if (locks[sortedIteration].fixed = 1 and locks[sortedIteration].regularity# = 0.016667 and (locks[sortedIteration].botChosen > 0 or (locks[lockSelected].keyholderUsername$ <> "" and locks[sortedIteration].hiddenFromOwner = 0 and locks[sortedIteration].removedByKeyholder = 0))) then maxWaitTime = 3600 * 3
		if (locks[sortedIteration].unlocked = 0 and locks[sortedIteration].readyToUnlock = 1 and maxWaitTime - (timestampNow - locks[sortedIteration].timestampRequestedKeyholdersDecision) <= 0) then unlockButtonVisible = 1
		if (disableCreationOfNewLocks = 0 and locks[sortedIteration].unlocked = 1 and locks[sortedIteration].botChosen = 0 and locks[sortedIteration].sharedID$ <> "") then restartButtonVisible = 1
		if (locks[sortedIteration].unlocked = 0 and locks[sortedIteration].checkInFrequencyInSeconds > 0 and maintenance = 0 and offline = 0 and locks[sortedIteration].hiddenFromOwner = 0 and locks[sortedIteration].removedByKeyholder = 0) then checkInButtonVisible = 1
		if (locks[sortedIteration].unlocked = 0 and locks[sortedIteration].keyholderUsername$ <> "" and maintenance = 0 and offline = 0) then moodButtonVisible = 1
		noOfLeftButtons = deleteButtonVisible + unlockButtonVisible + restartButtonVisible
		noOfCenterButtons = checkInButtonVisible + cleanButtonVisible
		noOfRightButtons = moodButtonVisible + flagButtonVisible + moreButtonVisible
		if (deleteButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprDeleteButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprDeleteIcon, lockCard[cardNo].sprDeleteButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprDeleteButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(lockCard[cardNo].sprDeleteIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
			buttonX# = buttonX# + 10
		endif
		if (unlockButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprUnlockButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprUnlockIcon, lockCard[cardNo].sprUnlockButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprUnlockButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				if (locks[sortedIteration].keyholderAllowsFreeUnlock = 1 or (locks[sortedIteration].hiddenFromOwner = 1 and locks[sortedIteration].hiddenFromOwnerAlertHidden = 0) or (locks[sortedIteration].removedByKeyholder = 1 and locks[sortedIteration].removedByKeyholderAlertHidden = 0))
					local unlockColour# as float[4] : unlockColour# = OryUIConvertColor("#009051")
					OryUIUpdateSprite(lockCard[cardNo].sprUnlockIcon, "color:" + str(unlockColour#[1]) + "," + str(unlockColour#[2]) + "," + str(unlockColour#[3]) + "," + str(unlockColour#[4]) + ";alpha:150")
				else
					OryUIUpdateSprite(lockCard[cardNo].sprUnlockIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				endif
			endif
			buttonX# = buttonX# + 10
		endif
		if (restartButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprRestartButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprRestartIcon, lockCard[cardNo].sprRestartButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprRestartButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(lockCard[cardNo].sprRestartIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
			buttonX# = buttonX# + 10
		endif
		if (emptyLeftButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprEmptyLeftButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIUpdateSprite(lockCard[cardNo].sprEmptyLeftButton, "size:" + str(50 - ((noOfLeftButtons + (noOfCenterButtons * 0.5)) * 10)) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			endif
			buttonX# = buttonX# + 50 - ((noOfLeftButtons + (noOfCenterButtons * 0.5)) * 10)
		endif
		if (checkInButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprCheckInButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprCheckInIcon, lockCard[cardNo].sprCheckInButton, 0, 0)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprCheckInCooldown, lockCard[cardNo].sprCheckInButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprCheckInButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(lockCard[cardNo].sprCheckInIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIUpdateSprite(lockCard[cardNo].sprCheckInCooldown, "colorID:" + str(theme[themeSelected].color[3]))
			endif
			if (locks[sortedIteration].timestampLastCheckedIn = 0)
				secondsSinceLastCheckIn = timestampNow - locks[sortedIteration].timestampLocked
				secondsUntilNextCheckIn = (locks[sortedIteration].timestampLocked + locks[sortedIteration].checkInFrequencyInSeconds) - timestampNow
				if (secondsUntilNextCheckIn > 0)
					OryUIUpdateSprite(lockCard[cardNo].sprCheckInIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
					cooldownPercentage# = (100.0 / locks[sortedIteration].checkInFrequencyInSeconds) * secondsUntilNextCheckIn
				else
					cooldownPercentage# = 0
					lateCheckIn = 0
					if (locks[sortedIteration].fixed = 0)
						if (locks[sortedIteration].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].regularity# * 3600)
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					else
						if (locks[sortedIteration].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > (MinInt(locks[sortedIteration].checkInFrequencyInSeconds / 2, 86400)))
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					endif
					if (lateCheckIn = 1)
						SetSpriteColor(lockCard[cardNo].sprCheckInIcon, 192, 57, 42, 255)
					else
						SetSpriteColor(lockCard[cardNo].sprCheckInIcon, 22, 160, 133, 255)	
					endif
				endif
			else
				secondsSinceLastCheckIn = timestampNow - locks[sortedIteration].timestampLastCheckedIn
				secondsUntilNextCheckIn = (locks[sortedIteration].timestampLastCheckedIn + locks[sortedIteration].checkInFrequencyInSeconds) - timestampNow
				if (secondsUntilNextCheckIn > 0)
					OryUIUpdateSprite(lockCard[cardNo].sprCheckInIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
					cooldownPercentage# = (100.0 / locks[sortedIteration].checkInFrequencyInSeconds) * secondsUntilNextCheckIn
				else
					cooldownPercentage# = 0
					lateCheckIn = 0
					if (locks[sortedIteration].fixed = 0)
						if (locks[sortedIteration].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].regularity# * 3600)
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					else
						if (locks[sortedIteration].lateCheckInWindowInSeconds = 0)
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > (MinInt(locks[sortedIteration].checkInFrequencyInSeconds / 2, 86400)))
								lateCheckIn = 1
							endif
						else
							if (secondsSinceLastCheckIn - locks[sortedIteration].checkInFrequencyInSeconds > locks[sortedIteration].lateCheckInWindowInSeconds)
								lateCheckIn = 1
							endif
						endif
					endif
					if (lateCheckIn = 1)
						SetSpriteColor(lockCard[cardNo].sprCheckInIcon, 192, 57, 42, 255)
					else
						SetSpriteColor(lockCard[cardNo].sprCheckInIcon, 0, 160, 133, 255)	
					endif
				endif
			endif
			SetShaderConstantByName(lockCard[cardNo].shaderCooldown, "Percentage", cooldownPercentage#, 0, 0, 0)
			DrawSprite(lockCard[cardNo].sprCheckInCooldown)
			buttonX# = buttonX# + 10
		endif
		if (cleanButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprCleanButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprCleanIcon, lockCard[cardNo].sprCleanButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprCleanButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(lockCard[cardNo].sprCleanIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
			buttonX# = buttonX# + 10
		endif
		if (emptyRightButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprEmptyRightButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIUpdateSprite(lockCard[cardNo].sprEmptyRightButton, "size:" + str(50 - (((noOfCenterButtons * 0.5) + noOfRightButtons) * 10)) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			endif
			buttonX# = buttonX# + 50 - (((noOfCenterButtons * 0.5) + noOfRightButtons) * 10)
		endif
		if (moodButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprMoodButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprMoodBackground, lockCard[cardNo].sprMoodButton, 0, 0)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprMoodIcon, lockCard[cardNo].sprMoodButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprMoodButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				if (locks[sortedIteration].emojiChosen = 0)
					OryUIUpdateSprite(lockCard[cardNo].sprMoodIcon, "image:" + str(imgEmojiIcon) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				else
					OryUIUpdateSprite(lockCard[cardNo].sprMoodIcon, "image:" + str(imgEmojis[locks[sortedIteration].emojiColourSelected, locks[sortedIteration].emojiChosen]) + ";color:255,255,255,255")
				endif
			endif
			buttonX# = buttonX# + 10
		endif
		if (flagButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprFlagButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprFlagIcon, lockCard[cardNo].sprFlagButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprFlagButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			endif
			buttonX# = buttonX# + 10
			if (locks[sortedIteration].flagChosen = 0)
				OryUIUpdateSprite(lockCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			else
				OryUIUpdateSprite(lockCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[locks[sortedIteration].flagChosen]) + ";color:255,255,255,255")
			endif
		endif
		if (moreButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(lockCard[cardNo].sprMoreButton, lockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprMoreIcon, lockCard[cardNo].sprMoreButton, 0, 0)
				OryUIUpdateSprite(lockCard[cardNo].sprMoreButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(lockCard[cardNo].sprMoreIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
		endif
	else
		if (reposition = 1)
			OryUIUpdateSprite(lockCard[cardNo].sprSyncStatus, "image:" + str(imgSyncing) + ";alpha:255")
			OryUIUpdateSprite(lockCard[cardNo].sprDeletingBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;color:0,0,0,200")
			OryUIPinSpriteToCentreOfSprite(lockCard[cardNo].sprDeletingBackground, lockCard[cardNo].sprBackground, 0, 2.5)
			OryUIUpdateText(lockCard[cardNo].txtDeleting, "text:Deleting...;size:4.1;")
			OryUIPinTextToCentreOfSprite(lockCard[cardNo].txtDeleting, lockCard[cardNo].sprDeletingBackground, 0, 0)
			OryUIUpdateSprite(lockCard[cardNo].sprButtonBar, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		endif
	endif
endfunction

function UpdateItemsInMyLockDeletedCard(cardNo as integer, sortedIteration, reposition as integer)
	local a as integer
	local dd as integer
	local deletedWhen$ as string
	local endKeyholderName as integer
	local hh as integer
	local lockInformation$ as string
	local lockName$ as string
	local lockStatus$ as string
	local mm as integer
	local secondsLocked as integer
	local secondsSinceDeleted as integer
	local ss as integer
	local startKeyholderName as integer
	local testLock$ as string
	local usernameHeight# as float
	local usernameWidth# as float
	local usernameX# as float
	local usernameY# as float
	
	if (reposition = 1)
		lockName$ = ""
		if (locksDeleted.myLocks[sortedIteration].lockName$ <> "") then lockName$ = locksDeleted.myLocks[sortedIteration].lockName$ + " | " 
		if (locksDeleted.myLocks[sortedIteration].build < 195)
			// LOCKS CREATED BEFORE 2.5.2.ALPHA.4
			OryUIUpdateText(lockDeletedCard[cardNo].txtHeader, "text:" + lockName$ + "ID " + str(locksDeleted.myLocks[sortedIteration].groupID) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		else
			// NEW LOCKS CREATED IN OR AFTER 2.5.2.ALPHA.4
			OryUIUpdateText(lockDeletedCard[cardNo].txtHeader, "text:" + lockName$ + "ID " + str(locksDeleted.myLocks[sortedIteration].groupID) + AddLeadingZeros(str(locksDeleted.myLocks[sortedIteration].id - locksDeleted.myLocks[sortedIteration].groupID), 2) + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		endif
		OryUIPinTextToTopCentreOfSprite(lockDeletedCard[cardNo].txtHeader, lockDeletedCard[cardNo].sprBackground, 0, 0.5)
		
		lockInformation$ = ""
		if (locksDeleted.myLocks[sortedIteration].fixed = 0) then lockInformation$ = "Variable | "
		if (locksDeleted.myLocks[sortedIteration].fixed = 1) then lockInformation$ = "Fixed | "
		if (locksDeleted.myLocks[sortedIteration].fixed = 0)
			if (locksDeleted.myLocks[sortedIteration].regularity# = 0.016667) then lockInformation$ = lockInformation$ + "Every Minute | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 0.25) then lockInformation$ = lockInformation$ + "Every 15 Mins | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 0.5) then lockInformation$ = lockInformation$ + "Every 30 Mins | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 1) then lockInformation$ = lockInformation$ + "Hourly | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 3) then lockInformation$ = lockInformation$ + "Every 3 Hrs | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 6) then lockInformation$ = lockInformation$ + "Every 6 Hrs | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 12) then lockInformation$ = lockInformation$ + "Every 12 Hrs | "
			if (locksDeleted.myLocks[sortedIteration].regularity# = 24) then lockInformation$ = lockInformation$ + "Daily | "
			if (locksDeleted.myLocks[sortedIteration].cumulative = 1) then lockInformation$ = lockInformation$ + "Cumulative | "
			if (locksDeleted.myLocks[sortedIteration].cumulative = 0) then lockInformation$ = lockInformation$ + "Non-Cumulative | "
		endif
		if (right(lockInformation$, 3) = " | ") then lockInformation$ = mid(lockInformation$, 1, len(lockInformation$) - 3)
		
		if (locksDeleted.myLocks[sortedIteration].unlocked = 0)
			secondsLocked = locksDeleted.myLocks[sortedIteration].timestampDeleted - locksDeleted.myLocks[sortedIteration].timestampLocked
		else
			secondsLocked = locksDeleted.myLocks[sortedIteration].timestampUnlocked - locksDeleted.myLocks[sortedIteration].timestampLocked
		endif
		dd = floor(secondsLocked / 60 / 60 / 24)
		hh = floor(mod(secondsLocked / 60 / 60, 24))
		mm = floor(mod(secondsLocked / 60, 60))
		ss = floor(mod(secondsLocked, 60))
		if (dd > 0)
			lockInformation$ = lockInformation$ + chr(10) + "Locked for " + str(dd) + "d " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
		elseif (hh > 0)
			lockInformation$ = lockInformation$ + chr(10) + "Locked for " + str(hh) + "h " + str(mm) + "m " + str(ss) + "s"
		elseif (mm > 0)
			lockInformation$ = lockInformation$ + chr(10) + "Locked for " + str(mm) + "m " + str(ss) + "s"
		elseif (ss >= 0)
			lockInformation$ = lockInformation$ + chr(10) + "Locked for " + str(ss) + "s"
		endif

		if (locksDeleted.myLocks[sortedIteration].keyholderUsername$ <> "")
			startKeyholderName = len(lockInformation$) + 11
			lockInformation$ = lockInformation$ + chr(10) + "Locked by " + locksDeleted.myLocks[sortedIteration].keyholderUsername$
			endKeyholderName = len(lockInformation$)
		else
			startKeyholderName = 0
			endKeyholderName = 0
		endif
		
		OryUIUpdateText(lockDeletedCard[cardNo].txtLockInformation, "text:" + lockInformation$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		
		if (locksDeleted.myLocks[sortedIteration].keyholderUsername$ <> "")
			SetUsernameColorArray(locksDeleted.myLocks[sortedIteration].keyholderMainRole, locksDeleted.myLocks[sortedIteration].keyholderMainRoleLevel)
			for a = startKeyholderName to endKeyholderName
				SetTextCharBold(lockDeletedCard[cardNo].txtLockInformation, a, 1)
				SetTextCharColor(lockDeletedCard[cardNo].txtLockInformation, a, usernameColor[0], usernameColor[1], usernameColor[2], usernameColor[3])
			next
		endif
		
		OryUIPinTextToCentreOfSprite(lockDeletedCard[cardNo].txtLockInformation, lockDeletedCard[cardNo].sprBackground, 0, 0)

		if (locksDeleted.myLocks[sortedIteration].keyholderUsername$ <> "")
			OryUIUpdateText(lockDeletedCard[cardNo].txtLockedByHidden, "text:Locked by ;position:-1000,-10000")
			OryUIUpdateText(lockDeletedCard[cardNo].txtUsernameHidden, "text:" + locksDeleted.myLocks[sortedIteration].keyholderUsername$ + ";position:-1000,-10000")
			usernameX# = (((screenNo * 100) + 50) + ((GetTextTotalWidth(lockDeletedCard[cardNo].txtLockedByHidden) + GetTextTotalWidth(lockDeletedCard[cardNo].txtUsernameHidden)) / 2)) - GetTextTotalWidth(lockDeletedCard[cardNo].txtUsernameHidden)
			usernameY# = GetTextY(lockDeletedCard[cardNo].txtLockInformation) + GetTextTotalHeight(lockDeletedCard[cardNo].txtLockInformation) - GetTextTotalHeight(lockDeletedCard[cardNo].txtUsernameHidden)
			usernameWidth# = GetTextTotalWidth(lockDeletedCard[cardNo].txtUsernameHidden)
			usernameHeight# = GetTextTotalHeight(lockDeletedCard[cardNo].txtUsernameHidden)
			OryUIUpdateSprite(lockDeletedCard[cardNo].sprUsernameButton, "size:" + str(usernameWidth#) + "," + str(usernameHeight#) + ";position:" + str(usernameX#) + "," + str(usernameY#) + ";alpha:0")
		else
			OryUIUpdateSprite(lockDeletedCard[cardNo].sprUsernameButton, "position:-1000,-1000")
		endif
		
		if (locksDeleted.myLocks[sortedIteration].unlocked = 0 and timestampNow - locksDeleted.myLocks[sortedIteration].timestampDeleted <= 86400)
			//OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";iconID:" + str(imgUndeleteIcon) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
			OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";icon:restore_from_trash;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		elseif (disableCreationOfNewLocks = 0 and locksDeleted.myLocks[sortedIteration].unlocked = 1 and locksDeleted.myLocks[sortedIteration].botChosen = 0 and locksDeleted.myLocks[sortedIteration].sharedID$ <> "" and disableCreationOfNewLocks = 0)
			//OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";iconID:" + str(imgNewLockIcon) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
			OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";icon:replay;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		endif
			
		if (locksDeleted.myLocks[sortedIteration].unlocked = 0)
			lockStatus$ = "Abandoned"
		else
			lockStatus$ = "Completed | Combination[colon] " + locksDeleted.myLocks[sortedIteration].combination$
		endif
		testLock$ = ""
		if (locksDeleted.myLocks[sortedIteration].test = 1) then testLock$ = "Test Lock | "
		OryUIUpdateText(lockDeletedCard[cardNo].txtFooter, "text:" + testLock$ + lockStatus$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToBottomCentreOfSprite(lockDeletedCard[cardNo].txtFooter, lockDeletedCard[cardNo].sprBackground, 0, -0.5)
		
		secondsSinceDeleted = timestampNow - locksDeleted.myLocks[sortedIteration].timestampDeleted
		if (floor(secondsSinceDeleted / 60 / 60 / 24) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60 / 60 / 24)) + "d"
		elseif (floor(secondsSinceDeleted / 60 / 60) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60 / 60)) + "h"
		elseif (floor(secondsSinceDeleted / 60) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60)) + "m"
		else
			deletedWhen$ = str(secondsSinceDeleted) + "s"
		endif
		OryUIUpdateText(lockDeletedCard[cardNo].txtDeletedWhen, "text:" + deletedWhen$+ ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToBottomRightOfSprite(lockDeletedCard[cardNo].txtDeletedWhen, lockDeletedCard[cardNo].sprBackground, -1.5, -0.5)
	endif
endfunction

function UpdateItemsInSharedLockCard(cardNo as integer, sortedIteration, reposition as integer)
	local a as integer
	local buttonsPlaced as integer
	local buttonX# as float
	local cards$ as string
	local checkIns$ as string
	local cloneButtonVisible as integer
	local deleteButtonVisible as integer
	local leftEmptyButtonVisible as integer
	local manageButtonVisible as integer
	local moreButtonVisible as integer
	local noOfButtons as integer
	local options$ as string
	local resets$ as string
	local rightEmptyButtonVisible as integer
	local shareButtonVisible as integer
	local showMatchingUsersButtonVisible as integer

	if (reposition = 1)
		OryUIUpdateText(sharedLockCard[cardNo].txtLockName, "text:" + sharedLocks[sortedIteration, 0].lockName$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToTopLeftOfSprite(sharedLockCard[cardNo].txtLockName, sharedLockCard[cardNo].sprBackground, 2, 0.5)
			
		OryUIUpdateText(sharedLockCard[cardNo].txtShareID, "text:" + sharedLocks[sortedIteration, 0].shareID$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToTopRightOfSprite(sharedLockCard[cardNo].txtShareID, sharedLockCard[cardNo].sprBackground, -2, 0.5)
	
		if (sharedLocks[sortedIteration, 0].deleting = 0)
			options$ = ""
			if (sharedLocks[sortedIteration, 0].fixed = 0) then options$ = options$ + "Variable | "
			if (sharedLocks[sortedIteration, 0].fixed = 1) then options$ = options$ + "Fixed | "
			if (sharedLocks[sortedIteration, 0].fixed = 0)
				if (sharedLocks[sortedIteration, 0].regularity# = 0.016667) then options$ = options$ + "Every Minute | "
				if (sharedLocks[sortedIteration, 0].regularity# = 0.25) then options$ = options$ + "Every 15 Mins | "
				if (sharedLocks[sortedIteration, 0].regularity# = 0.5) then options$ = options$ + "Every 30 Mins | "
				if (sharedLocks[sortedIteration, 0].regularity# = 1) then options$ = options$ + "Hourly | "
				if (sharedLocks[sortedIteration, 0].regularity# = 3) then options$ = options$ + "Every 3 Hrs | "
				if (sharedLocks[sortedIteration, 0].regularity# = 6) then options$ = options$ + "Every 6 Hrs | "
				if (sharedLocks[sortedIteration, 0].regularity# = 12) then options$ = options$ + "Every 12 Hrs | "
				if (sharedLocks[sortedIteration, 0].regularity# = 24) then options$ = options$ + "Daily | "
			endif
			if (sharedLocks[sortedIteration, 0].maxRandomCopies > 0)
				if (sharedLocks[sortedIteration, 0].minRandomCopies = sharedLocks[sortedIteration, 0].maxRandomCopies)
					options$ = options$ + "Fakes (" + str(sharedLocks[sortedIteration, 0].maxRandomCopies) + ") | "
				else
					options$ = options$ + "Fakes (" + str(sharedLocks[sortedIteration, 0].minRandomCopies) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomCopies) + ") | "
				endif
			endif
			if (right(options$, 3) = " | ") then options$ = mid(options$, 1, len(options$) - 3)
			OryUIUpdateText(sharedLockCard[cardNo].txtOptions, "text:" + options$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))	
			OryUIPinTextToTopCentreOfSprite(sharedLockCard[cardNo].txtOptions, sharedLockCard[cardNo].sprBackground, 0, 3.3)
	
			cards$ = ""
			if (sharedLocks[sortedIteration, 0].minRandomGreens = sharedLocks[sortedIteration, 0].maxRandomGreens)
				if (sharedLocks[sortedIteration, 0].maxRandomGreens = 1) then cards$ = cards$ + "1 Green | "
				if (sharedLocks[sortedIteration, 0].maxRandomGreens > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomGreens) + " Greens | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomGreens) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomGreens) + " Greens | "
			endif
			
			if (sharedLocks[sortedIteration, 0].minRandomReds = sharedLocks[sortedIteration, 0].maxRandomReds)
				if (sharedLocks[sortedIteration, 0].maxRandomReds = 1) then cards$ = cards$ + "1 Red | "
				if (sharedLocks[sortedIteration, 0].maxRandomReds > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Reds | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomReds) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Reds | "
			endif
			
			if (sharedLocks[sortedIteration, 0].minRandomStickies = sharedLocks[sortedIteration, 0].maxRandomStickies)
				if (sharedLocks[sortedIteration, 0].maxRandomStickies = 1) then cards$ = cards$ + "1 Sticky | "
				if (sharedLocks[sortedIteration, 0].maxRandomStickies > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomStickies) + " Stickies | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomStickies) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomStickies) + " Stickies | "
			endif
			if (right(cards$, 3) = " | ") then cards$ = mid(cards$, 1, len(cards$) - 3)
			
			cards$ = cards$ + chr(10)
			if (sharedLocks[sortedIteration, 0].minRandomYellows + sharedLocks[sortedIteration, 0].minRandomYellowsAdd + sharedLocks[sortedIteration, 0].minRandomYellowsMinus = sharedLocks[sortedIteration, 0].maxRandomYellows + sharedLocks[sortedIteration, 0].maxRandomYellowsAdd + sharedLocks[sortedIteration, 0].maxRandomYellowsMinus)
				if (sharedLocks[sortedIteration, 0].maxRandomYellows + sharedLocks[sortedIteration, 0].maxRandomYellowsAdd + sharedLocks[sortedIteration, 0].maxRandomYellowsMinus = 1) then cards$ = cards$ + "1 Yellow | "
				if (sharedLocks[sortedIteration, 0].maxRandomYellows + sharedLocks[sortedIteration, 0].maxRandomYellowsAdd + sharedLocks[sortedIteration, 0].maxRandomYellowsMinus > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomYellows + sharedLocks[sortedIteration, 0].maxRandomYellowsAdd + sharedLocks[sortedIteration, 0].maxRandomYellowsMinus) + " Yellows | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomYellows + sharedLocks[sortedIteration, 0].minRandomYellowsAdd + sharedLocks[sortedIteration, 0].minRandomYellowsMinus) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomYellows + sharedLocks[sortedIteration, 0].maxRandomYellowsAdd + sharedLocks[sortedIteration, 0].maxRandomYellowsMinus) + " Yellows | "
			endif
			
			if (sharedLocks[sortedIteration, 0].minRandomFreezes = sharedLocks[sortedIteration, 0].maxRandomFreezes)
				if (sharedLocks[sortedIteration, 0].maxRandomFreezes = 1) then cards$ = cards$ + "1 Freeze | "
				if (sharedLocks[sortedIteration, 0].maxRandomFreezes > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomFreezes) + " Freezes | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomFreezes) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomFreezes) + " Freezes | "
			endif
			if (sharedLocks[sortedIteration, 0].minRandomDoubleUps = sharedLocks[sortedIteration, 0].maxRandomDoubleUps)
				if (sharedLocks[sortedIteration, 0].maxRandomDoubleUps = 1) then cards$ = cards$ + "1 Double Up | "
				if (sharedLocks[sortedIteration, 0].maxRandomDoubleUps > 1) then cards$ = cards$ + str(sharedLocks[sortedIteration, 0].maxRandomDoubleUps) + " Double Ups | "
			else
				cards$ = cards$ + str(sharedLocks[sortedIteration, 0].minRandomDoubleUps) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomDoubleUps) + " Double Ups | "
			endif
			if (right(cards$, 3) = " | ") then cards$ = mid(cards$, 1, len(cards$) - 3)
			
			if (sharedLocks[sortedIteration, 0].fixed = 0)
				OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + cards$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
			else
				if (sharedLocks[sortedIteration, 0].regularity# >= 0.25)
					if (sharedLocks[sortedIteration, 0].minRandomReds = sharedLocks[sortedIteration, 0].maxRandomReds)
						if (sharedLocks[sortedIteration, 0].maxRandomReds = 1)
							if (sharedLocks[sortedIteration, 0].regularity# = 0.25) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:15 Minutes;colorID:" + str(colorMode[colorModeSelected].textColor))
							if (sharedLocks[sortedIteration, 0].regularity# = 1) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:1 Hour;colorID:" + str(colorMode[colorModeSelected].textColor))
							if (sharedLocks[sortedIteration, 0].regularity# = 24) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:1 Day;colorID:" + str(colorMode[colorModeSelected].textColor))
						else
							if (sharedLocks[sortedIteration, 0].regularity# = 0.25) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].maxRandomReds * 15) + " Minutes;colorID:" + str(colorMode[colorModeSelected].textColor))
							if (sharedLocks[sortedIteration, 0].regularity# = 1) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Hours;colorID:" + str(colorMode[colorModeSelected].textColor))
							if (sharedLocks[sortedIteration, 0].regularity# = 24) then OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Days;colorID:" + str(colorMode[colorModeSelected].textColor))
						endif
					else
						if (sharedLocks[sortedIteration, 0].regularity# = 0.25)
							OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].minRandomReds * 15) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomReds * 15) + " Minutes;colorID:" + str(colorMode[colorModeSelected].textColor))
						elseif (sharedLocks[sortedIteration, 0].regularity# = 1)
							OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].minRandomReds) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Hours;colorID:" + str(colorMode[colorModeSelected].textColor))
						elseif (sharedLocks[sortedIteration, 0].regularity# = 24)
							OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + str(sharedLocks[sortedIteration, 0].minRandomReds) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomReds) + " Days;colorID:" + str(colorMode[colorModeSelected].textColor))
						endif
					endif
				else
					if (sharedLocks[sortedIteration, 0].minRandomMinutes = sharedLocks[sortedIteration, 0].maxRandomMinutes)
						OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:" + ConvertMinutesToText(sharedLocks[sortedIteration, 0].maxRandomMinutes, 1) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
					else
						OryUIUpdateText(sharedLockCard[cardNo].txtCards, "text:From[colon] " + ConvertMinutesToText(sharedLocks[sortedIteration, 0].minRandomMinutes, 1) + chr(10) + "To[colon] " + ConvertMinutesToText(sharedLocks[sortedIteration, 0].maxRandomMinutes, 1) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
					endif
				endif
			endif
			OryUIPinTextToTopCentreOfSprite(sharedLockCard[cardNo].txtCards, sharedLockCard[cardNo].sprBackground, 0, 6.5)
			
			resets$ = ""
			if (sharedLocks[sortedIteration, 0].minRandomResets = sharedLocks[sortedIteration, 0].maxRandomResets)
				if (sharedLocks[sortedIteration, 0].maxRandomResets = 1) then resets$ = resets$ + "1 Reset | "
				if (sharedLocks[sortedIteration, 0].maxRandomResets > 1) then resets$ = resets$ + str(sharedLocks[sortedIteration, 0].maxRandomResets) + " Resets | "
			else
				resets$ = resets$ + str(sharedLocks[sortedIteration, 0].minRandomResets) + "-" + str(sharedLocks[sortedIteration, 0].maxRandomResets) + " Resets | "
			endif
			if (sharedLocks[sortedIteration, 0].maxAutoResets > 0)
				resets$ = resets$ + "Auto Resets (Max. " + str(sharedLocks[sortedIteration, 0].maxAutoResets) + ")"
			endif
			if (right(resets$, 3) = " | ") then resets$ = mid(resets$, 1, len(resets$) - 3)
			if (resets$ <> "")
				OryUIUpdateText(sharedLockCard[cardNo].txtAutoResets, "text:" + resets$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIPinTextToTopCentreOfSprite(sharedLockCard[cardNo].txtAutoResets, sharedLockCard[cardNo].sprBackground, 0, 6.5 + GetTextTotalHeight(sharedLockCard[cardNo].txtCards))
			else
				OryUIUpdateText(sharedLockCard[cardNo].txtAutoResets, "text:;colorID:" + str(colorMode[colorModeSelected].textColor))
			endif
			
			checkIns$ = ""
			if (sharedLocks[sortedIteration, 0].checkInFrequencyInSeconds > 0)
				dd = floor(sharedLocks[sortedIteration, 0].checkInFrequencyInSeconds / 60 / 60 / 24)
				hh = floor(mod(sharedLocks[sortedIteration, 0].checkInFrequencyInSeconds / 60 / 60, 24))
				mm = floor(mod(sharedLocks[sortedIteration, 0].checkInFrequencyInSeconds / 60, 60))
				ss = floor(mod(sharedLocks[sortedIteration, 0].checkInFrequencyInSeconds, 60))
				checkIns$ = "Check-Ins Every"
				if (dd > 0)
					checkIns$ = checkIns$ + " " + str(dd) + "d"
				endif
				if (hh > 0)
					checkIns$ = checkIns$ + " " + str(hh) + "h"
				endif
				if (mm > 0)
					checkIns$ = checkIns$ + " " + str(mm) + "m"
				endif
			endif
			if (checkIns$ <> "")
				OryUIUpdateText(sharedLockCard[cardNo].txtCheckIns, "text:" + checkIns$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
				OryUIPinTextToTopCentreOfSprite(sharedLockCard[cardNo].txtCheckIns, sharedLockCard[cardNo].sprBackground, 0, 6.5 + GetTextTotalHeight(sharedLockCard[cardNo].txtCards) + GetTextTotalHeight(sharedLockCard[cardNo].txtAutoResets))
			endif
			
			lockedUsers = sharedLocks[sortedIteration, 0].lockedUsers - sharedLocks[sortedIteration, 0].fakeLockedUsers
			if (lockedUsers < 0) then lockedUsers = 0
			if (sharedLocks[sortedIteration, 0].maxUsers > 0)
				OryUIUpdateText(sharedLockCard[cardNo].txtUsers, "text:Total Users[colon] " + str(lockedUsers) + "/" + str(sharedLocks[sortedIteration, 0].maxUsers) + " Locked | " + str(sharedLocks[sortedIteration, 0].unlockedUsers) + " Unlocked | " + str(sharedLocks[sortedIteration, 0].desertedUsers) + " Deserted;colorID:" + str(colorMode[colorModeSelected].textColor))	
			else
				OryUIUpdateText(sharedLockCard[cardNo].txtUsers, "text:Total Users[colon] " + str(lockedUsers) + "/∞ Locked | " + str(sharedLocks[sortedIteration, 0].unlockedUsers) + " Unlocked | " + str(sharedLocks[sortedIteration, 0].desertedUsers) + " Deserted;colorID:" + str(colorMode[colorModeSelected].textColor))	
			endif
			OryUIPinTextToBottomCentreOfSprite(sharedLockCard[cardNo].txtUsers, sharedLockCard[cardNo].sprBackground, 0, -2.3)
			
			if (sharedLocks[sortedIteration, 0].noOfLockRatings >= 5)
				OryUIUpdateText(sharedLockCard[cardNo].txtRating, "text:" + str(sharedLocks[sortedIteration, 0].lockRating#, 1) + " out of 5 stars (" + str(sharedLocks[sortedIteration, 0].noOfLockRatings) + " Ratings);colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")	
				for a = 0 to 18
					if (sharedLocks[sortedIteration, 0].lockRating# < 1.5)
						SetTextCharColor(sharedLockCard[cardNo].txtRating, a, 224, 36, 43, 255)
					elseif (sharedLocks[sortedIteration, 0].lockRating# < 2.5)
						SetTextCharColor(sharedLockCard[cardNo].txtRating, a, 243, 115, 37, 255)
					elseif (sharedLocks[sortedIteration, 0].lockRating# < 3.5)
						SetTextCharColor(sharedLockCard[cardNo].txtRating, a, 247, 204, 26, 255)
					elseif (sharedLocks[sortedIteration, 0].lockRating# < 4.5)
						SetTextCharColor(sharedLockCard[cardNo].txtRating, a, 115, 177, 67, 255)
					elseif (sharedLocks[sortedIteration, 0].lockRating# < 5.5)
						SetTextCharColor(sharedLockCard[cardNo].txtRating, a, 0, 128, 78, 255)
					endif
				next
			else
				if (sharedLocks[sortedIteration, 0].noOfLockRatings = 0)
					OryUIUpdateText(sharedLockCard[cardNo].txtRating, "text:No ratings yet;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
				elseif (sharedLocks[sortedIteration, 0].noOfLockRatings = 1)
					OryUIUpdateText(sharedLockCard[cardNo].txtRating, "text:Not enough ratings (1 Rating);colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
				else
					OryUIUpdateText(sharedLockCard[cardNo].txtRating, "text:Not enough ratings (" + str(sharedLocks[sortedIteration, 0].noOfLockRatings) + " Ratings);colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
				endif
			endif
			OryUIPinTextToBottomCentreOfSprite(sharedLockCard[cardNo].txtRating, sharedLockCard[cardNo].sprBackground, 0, -0.4)

			deleteButtonVisible = 0
			cloneButtonVisible = 1
			leftEmptyButtonVisible = 1
			manageButtonVisible = 1
			showMatchingUsersButtonVisible = 0
			rightEmptyButtonVisible = 1
			shareButtonVisible = 1
			moreButtonVisible = 1
			buttonX# = 0
			buttonsPlaced = 0
			if (maintenance = 0 and offline = 0) then deleteButtonVisible = 1
			if (FindString(sharedLocks[sortedIteration, 0].lockedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch)) > 0) then showMatchingUsersButtonVisible = 1
			if (FindString(sharedLocks[sortedIteration, 0].unlockedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch)) > 0) then showMatchingUsersButtonVisible = 1
			if (FindString(sharedLocks[sortedIteration, 0].desertedUsersDelimited$, OryUIGetTextFieldString(editSharedLocksSearch)) > 0) then showMatchingUsersButtonVisible = 1
			noOfButtons = deleteButtonVisible + cloneButtonVisible + manageButtonVisible + showMatchingUsersButtonVisible + shareButtonVisible + moreButtonVisible
			if (deleteButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprDeleteButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprDeleteIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprDeleteButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprDeleteIcon, sharedLockCard[cardNo].sprDeleteButton, 0, 0)
				buttonX# = buttonX# + 10
			endif
			if (cloneButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprCloneButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprCloneIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprCloneButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprCloneIcon, sharedLockCard[cardNo].sprCloneButton, 0, 0)
				buttonX# = buttonX# + 10
			endif
			if (leftEmptyButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprLeftEmptyButton, "size:" + str(((100 - (noOfButtons * 10)) / 2) + 5) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprLeftEmptyButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				buttonX# = buttonX# + ((100 - (noOfButtons * 10)) / 2) + 5
			endif
			if (manageButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprManageButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprManageIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprManageButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprManageIcon, sharedLockCard[cardNo].sprManageButton, 0, 0)
				buttonX# = buttonX# + 10
			endif
			if (showMatchingUsersButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprShowMatchingUsersButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprShowMatchingUsersIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprShowMatchingUsersButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprShowMatchingUsersIcon, sharedLockCard[cardNo].sprShowMatchingUsersButton, 0, 0)
				buttonX# = buttonX# + 10
			endif
			if (rightEmptyButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprRightEmptyButton, "size:" + str(((100 - (noOfButtons * 10)) / 2) - 5) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprRightEmptyButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				buttonX# = buttonX# + ((100 - (noOfButtons * 10)) / 2) - 5
			endif
			if (shareButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprShareButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprShareIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprShareButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprShareIcon, sharedLockCard[cardNo].sprShareButton, 0, 0)
				buttonX# = buttonX# + 10
			endif
			if (moreButtonVisible = 1)
				OryUIUpdateSprite(sharedLockCard[cardNo].sprMoreButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(sharedLockCard[cardNo].sprMoreIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
				OryUIPinSpriteToSprite(sharedLockCard[cardNo].sprMoreButton, sharedLockCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprMoreIcon, sharedLockCard[cardNo].sprMoreButton, 0, 0)
			endif
		else
			OryUIUpdateSprite(sharedLockCard[cardNo].sprDeletingBackground, "size:100," + str(cardHeight# * 0.55) + ";offset:center;color:0,0,0,200")
			OryUIPinSpriteToCentreOfSprite(sharedLockCard[cardNo].sprDeletingBackground, sharedLockCard[cardNo].sprBackground, 0, 2.5)
			OryUIUpdateText(sharedLockCard[cardNo].txtDeleting, "text:Deleting...;size:4.1;")
			OryUIPinTextToCentreOfSprite(sharedLockCard[cardNo].txtDeleting, sharedLockCard[cardNo].sprDeletingBackground, 0, 0)
			OryUIUpdateSprite(sharedLockCard[cardNo].sprButtonBar, "colorID:" + str(colorMode[colorModeSelected].pageColor))
		endif
	endif
endfunction

function UpdateItemsInSharedLockDeletedCard(cardNo as integer, sortedIteration, reposition as integer)
	local deletedWhen$ as string
	local lockInformation$ as string
	local lockName$ as string
	local secondsSinceDeleted as integer
	
	if (reposition = 1)
		lockName$ = ""
		if (locksDeleted.sharedLocks[sortedIteration].lockName$ <> "") then lockName$ = locksDeleted.sharedLocks[sortedIteration].lockName$ + " | " 
		OryUIUpdateText(lockDeletedCard[cardNo].txtHeader, "text:" + lockName$ + "ID " + locksDeleted.sharedLocks[sortedIteration].shareID$ + ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToTopCentreOfSprite(lockDeletedCard[cardNo].txtHeader, lockDeletedCard[cardNo].sprBackground, 0, 0.5)
		
		lockInformation$ = ""
		if (locksDeleted.sharedLocks[sortedIteration].fixed = 0) then lockInformation$ = "Variable | "
		if (locksDeleted.sharedLocks[sortedIteration].fixed = 1) then lockInformation$ = "Fixed | "
		if (locksDeleted.sharedLocks[sortedIteration].fixed = 0)
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.016667) then lockInformation$ = lockInformation$ + "Every Minute | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.25) then lockInformation$ = lockInformation$ + "Every 15 Mins | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.5) then lockInformation$ = lockInformation$ + "Every 30 Mins | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 1) then lockInformation$ = lockInformation$ + "Hourly | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 3) then lockInformation$ = lockInformation$ + "Every 3 Hrs | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 6) then lockInformation$ = lockInformation$ + "Every 6 Hrs | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 12) then lockInformation$ = lockInformation$ + "Every 12 Hrs | "
			if (locksDeleted.sharedLocks[sortedIteration].regularity# = 24) then lockInformation$ = lockInformation$ + "Daily | "
		endif
		if (locksDeleted.sharedLocks[sortedIteration].maxRandomCopies > 0)
			if (locksDeleted.sharedLocks[sortedIteration].minRandomCopies = locksDeleted.sharedLocks[sortedIteration].maxRandomCopies)
				lockInformation$ = lockInformation$ + "Fakes (" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomCopies) + ") | "
			else
				lockInformation$ = lockInformation$ + "Fakes (" + str(locksDeleted.sharedLocks[sortedIteration].minRandomCopies) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomCopies) + ") | "
			endif
		endif
		if (right(lockInformation$, 3) = " | ") then lockInformation$ = mid(lockInformation$, 1, len(lockInformation$) - 3)
		
		if (locksDeleted.sharedLocks[sortedIteration].fixed = 0)
			lockInformation$ = lockInformation$ + chr(10)
			
			if (locksDeleted.sharedLocks[sortedIteration].minRandomGreens = locksDeleted.sharedLocks[sortedIteration].maxRandomGreens)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomGreens = 1) then lockInformation$ = lockInformation$ + "1 Green | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomGreens > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomGreens) + " Greens | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomGreens) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomGreens) + " Greens | "
			endif
			
			if (locksDeleted.sharedLocks[sortedIteration].minRandomReds = locksDeleted.sharedLocks[sortedIteration].maxRandomReds)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomReds = 1) then lockInformation$ = lockInformation$ + "1 Red | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomReds > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Reds | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomReds) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Reds | "
			endif
			
			if (locksDeleted.sharedLocks[sortedIteration].minRandomYellows + locksDeleted.sharedLocks[sortedIteration].minRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].minRandomYellowsMinus = locksDeleted.sharedLocks[sortedIteration].maxRandomYellows + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsMinus)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomYellows + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsMinus = 1) then lockInformation$ = lockInformation$ + "1 Yellow | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomYellows + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsMinus > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomYellows + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsMinus) + " Yellows | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomYellows + locksDeleted.sharedLocks[sortedIteration].minRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].minRandomYellowsMinus) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomYellows + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsAdd + locksDeleted.sharedLocks[sortedIteration].maxRandomYellowsMinus) + " Yellows | "
			endif
			if (right(lockInformation$, 3) = " | ") then lockInformation$ = mid(lockInformation$, 1, len(lockInformation$) - 3)
			
			lockInformation$ = lockInformation$ + chr(10)
			
			if (locksDeleted.sharedLocks[sortedIteration].minRandomStickies = locksDeleted.sharedLocks[sortedIteration].maxRandomStickies)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomStickies = 1) then lockInformation$ = lockInformation$ + "1 Sticky | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomStickies > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomStickies) + " Stickies | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomStickies) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomStickies) + " Stickies | "
			endif
			if (locksDeleted.sharedLocks[sortedIteration].minRandomFreezes = locksDeleted.sharedLocks[sortedIteration].maxRandomFreezes)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomFreezes = 1) then lockInformation$ = lockInformation$ + "1 Freeze | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomFreezes > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomFreezes) + " Freezes | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomFreezes) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomFreezes) + " Freezes | "
			endif
			if (locksDeleted.sharedLocks[sortedIteration].minRandomDoubleUps = locksDeleted.sharedLocks[sortedIteration].maxRandomDoubleUps)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomDoubleUps = 1) then lockInformation$ = lockInformation$ + "1 Double Up | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomDoubleUps > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomDoubleUps) + " Double Ups | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomDoubleUps) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomDoubleUps) + " Double Ups | "
			endif
			if (locksDeleted.sharedLocks[sortedIteration].minRandomResets = locksDeleted.sharedLocks[sortedIteration].maxRandomResets)
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomResets = 1) then lockInformation$ = lockInformation$ + "1 Reset | "
				if (locksDeleted.sharedLocks[sortedIteration].maxRandomResets > 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomResets) + " Resets | "
			else
				lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomResets) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomResets) + " Resets | "
			endif
			if (right(lockInformation$, 3) = " | ") then lockInformation$ = mid(lockInformation$, 1, len(lockInformation$) - 3)
		endif
		if (locksDeleted.sharedLocks[sortedIteration].fixed = 1)
			lockInformation$ = lockInformation$ + chr(10)
			if (locksDeleted.sharedLocks[sortedIteration].regularity# >= 0.25)
				if (locksDeleted.sharedLocks[sortedIteration].minRandomReds = locksDeleted.sharedLocks[sortedIteration].maxRandomReds)
					if (locksDeleted.sharedLocks[sortedIteration].maxRandomReds = 1)
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.25) then lockInformation$ = lockInformation$ + "15 Minutes"
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 1) then lockInformation$ = lockInformation$ + "1 Hour"
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 24) then lockInformation$ = lockInformation$ + "1 Day"
					else
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.25) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds * 15) + " Minutes"
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 1) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Hours"
						if (locksDeleted.sharedLocks[sortedIteration].regularity# = 24) then lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Days"
					endif
				else
					if (locksDeleted.sharedLocks[sortedIteration].regularity# = 0.25)
						lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomReds * 15) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds * 15) + " Minutes"
					elseif (locksDeleted.sharedLocks[sortedIteration].regularity# = 1)
						lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomReds) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Hours"
					elseif (locksDeleted.sharedLocks[sortedIteration].regularity# = 24)
						lockInformation$ = lockInformation$ + str(locksDeleted.sharedLocks[sortedIteration].minRandomReds) + "-" + str(locksDeleted.sharedLocks[sortedIteration].maxRandomReds) + " Days"
					endif
				endif
			else
				if (locksDeleted.sharedLocks[sortedIteration].minRandomMinutes = locksDeleted.sharedLocks[sortedIteration].maxRandomMinutes)
					lockInformation$ = lockInformation$ + ConvertMinutesToText(locksDeleted.sharedLocks[sortedIteration].maxRandomMinutes, 1)
				else
					lockInformation$ = lockInformation$ + "From[colon] " + ConvertMinutesToText(locksDeleted.sharedLocks[sortedIteration].minRandomMinutes, 1) + chr(10) + "To[colon] " + ConvertMinutesToText(locksDeleted.sharedLocks[sortedIteration].maxRandomMinutes, 1)
				endif
			endif
			if (right(lockInformation$, 3) = " | ") then lockInformation$ = mid(lockInformation$, 1, len(lockInformation$) - 3)
		endif

		if (locksDeleted.sharedLocks[sortedIteration].maxAutoResets > 0)
			lockInformation$ = lockInformation$ + chr(10)
			lockInformation$ = lockInformation$ + "Auto Resets (Max. " + str(locksDeleted.sharedLocks[sortedIteration].maxAutoResets) + ")"
		endif
		
		OryUIUpdateText(lockDeletedCard[cardNo].txtLockInformation, "text:" + lockInformation$ + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToCentreOfSprite(lockDeletedCard[cardNo].txtLockInformation, lockDeletedCard[cardNo].sprBackground, 0, 0)

		//OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";iconID:" + str(imgUndeleteIcon) + ";colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		OryUIUpdateButton(lockDeletedCard[cardNo].rightButton, "position:" + str(GetSpriteX(lockDeletedCard[cardNo].sprBackground) + 100 - 2 - OryUIGetButtonWidth(lockDeletedCard[cardNo].rightButton)) + "," +  str(GetSpriteY(lockDeletedCard[cardNo].sprBackground) + (GetSpriteHeight(lockDeletedCard[cardNo].sprBackground) / 2) - (OryUIGetButtonHeight(lockDeletedCard[cardNo].rightButton) / 2)) + ";icon:restore_from_trash;colorID:" + str(colorMode[colorModeSelected].pageColor) + ";iconColorID:" + str(colorMode[colorModeSelected].barIconColor))
		
		lockedUsers = locksDeleted.sharedLocks[sortedIteration].lockedUsers - locksDeleted.sharedLocks[sortedIteration].fakeLockedUsers
		if (lockedUsers < 0) then lockedUsers = 0
		if (locksDeleted.sharedLocks[sortedIteration].maxUsers > 0)
			OryUIUpdateText(lockDeletedCard[cardNo].txtFooter, "text:Total Users[colon] " + str(lockedUsers) + "/" + str(locksDeleted.sharedLocks[sortedIteration].maxUsers) + " Locked | " + str(locksDeleted.sharedLocks[sortedIteration].unlockedUsers) + " Unlocked | " + str(locksDeleted.sharedLocks[sortedIteration].desertedUsers) + " Deserted;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		else
			OryUIUpdateText(lockDeletedCard[cardNo].txtFooter, "text:Total Users[colon] " + str(lockedUsers) + "/∞ Locked | " + str(locksDeleted.sharedLocks[sortedIteration].unlockedUsers) + " Unlocked | " + str(locksDeleted.sharedLocks[sortedIteration].desertedUsers) + " Deserted;colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		endif
		OryUIPinTextToBottomCentreOfSprite(lockDeletedCard[cardNo].txtFooter, lockDeletedCard[cardNo].sprBackground, 0, -0.5)
			
		secondsSinceDeleted = timestampNow - locksDeleted.sharedLocks[sortedIteration].timestampHidden
		if (floor(secondsSinceDeleted / 60 / 60 / 24) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60 / 60 / 24)) + "d"
		elseif (floor(secondsSinceDeleted / 60 / 60) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60 / 60)) + "h"
		elseif (floor(secondsSinceDeleted / 60) >= 1)
			deletedWhen$ = str(floor(secondsSinceDeleted / 60)) + "m"
		else
			deletedWhen$ = str(secondsSinceDeleted) + "s"
		endif
		OryUIUpdateText(lockDeletedCard[cardNo].txtDeletedWhen, "text:" + deletedWhen$+ ";colorID:" + str(colorMode[colorModeSelected].textColor) + ";alpha:150")
		OryUIPinTextToBottomRightOfSprite(lockDeletedCard[cardNo].txtDeletedWhen, lockDeletedCard[cardNo].sprBackground, -1.5, -0.5)
	endif
endfunction

function UpdateItemsInUnlockedUsersCard(cardNo as integer, sortedIteration as integer, reposition as integer)
	local a as integer
	local buttonsPlaced as integer
	local buttonX# as float
	local days$ as string
	local dd as integer
	local favouriteButtonVisible as integer
	local flagButtonVisible as integer
	local flagChosen as integer
	local hh as integer
	local hours$ as string
	local leftEmptyButtonVisible as integer
	local leftIconCount as integer
	local leftWidth# as float
	local minutes$ as string
	local mm as integer
	local moreButtonVisible as integer
	local noOfLeftButtons as integer
	local noOfRightButtons as integer
	local rightIconCount as integer
	local seconds$ as string
	local ss as integer

	if (reposition = 1)
		SetUsernameColorArray(sharedLocks[sharedLockSelected, 2].usersMainRole[sortedIteration], sharedLocks[sharedLockSelected, 2].usersMainRoleLevel[sortedIteration])
		OryUIUpdateText(userCard[cardNo].txtUsername, "text:" + sharedLocks[sharedLockSelected, 2].usersUsername$[sortedIteration] + ";color:" + str(usernameColor[0]) + "," + str(usernameColor[1]) + "," + str(usernameColor[2]) + "," + str(usernameColor[3]))
		OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtUsername, userCard[cardNo].sprBackground, 0, 0.2)
		OryUIUpdateSprite(userCard[cardNo].sprUsernameButton, "size:" + str(GetTextTotalWidth(userCard[cardNo].txtUsername)) + "," + str(GetTextTotalHeight(userCard[cardNo].txtUsername)) + ";offset:center;position:" + str(GetTextX(userCard[cardNo].txtUsername)) + "," + str(GetTextY(userCard[cardNo].txtUsername) + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2)) + ";colorID:" + str(colorMode[colorModeSelected].pageColor))
		leftIconCount = 0
		if (sharedLocks[sharedLockSelected, 2].usersUsedKey[sortedIteration] = 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprUsedKey, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprUsedKey) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		if (sharedLocks[sharedLockSelected, 2].usersTestLock[sortedIteration] = 1)
			inc leftIconCount
			OryUIPinSpriteToSprite(userCard[cardNo].sprTestLock, userCard[cardNo].sprBackground, 50 - (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) - ((GetSpriteWidth(userCard[cardNo].sprTestLock) + 1) * leftIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))			
		endif
		rightIconCount = 1
		if (sharedLocks[sharedLockSelected, 2].usersStatus[sortedIteration] = 0 or sharedLocks[sharedLockSelected, 2].usersStatus[sortedIteration] = 1)
			if (timestampNow - sharedLocks[sharedLockSelected, 2].usersLastActive[sortedIteration] <= 900)
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusAvailableIcon) + ";alpha:255")
			else
				OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
			endif
		elseif (sharedLocks[sharedLockSelected, 2].usersStatus[sortedIteration] = 2)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusBusyIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 2].usersStatus[sortedIteration] = 3)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusSleepingIcon) + ";alpha:255")
		elseif (sharedLocks[sharedLockSelected, 2].usersStatus[sortedIteration] = 4)
			OryUIUpdateSprite(userCard[cardNo].sprStatus, "image:" + str(imgStatusOfflineIcon) + ";alpha:255")
		endif
		OryUIPinSpriteToSprite(userCard[cardNo].sprStatus, userCard[cardNo].sprBackground, 50 + (GetTextTotalWidth(userCard[cardNo].txtUsername) / 2.0) + ((GetSpriteWidth(userCard[cardNo].sprStatus) + 1) * rightIconCount), 0.2 + (GetTextTotalHeight(userCard[cardNo].txtUsername) / 2))

		if (sharedLocks[sharedLockSelected, 2].usersNoOfRatingsFromKeyholders[sortedIteration] >= 5)
			if (sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration] < 1.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 224, 36, 43, 255)
			elseif (sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration] < 2.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 243, 115, 37, 255)
			elseif (sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration] < 3.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 247, 204, 26, 255)
			elseif (sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration] < 4.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 115, 177, 67, 255)
			elseif (sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration] < 5.5)
				SetSpriteColor(userCard[cardNo].sprRatingRibbon, 0, 128, 78, 255)
			endif
			OryUIUpdateSprite(userCard[cardNo].sprRatingRibbon, "alpha:255")
			OryUIUpdateText(userCard[cardNo].txtRatingRibbon, "text:" + str(sharedLocks[sharedLockSelected, 2].usersAverageRatingFromKeyholders#[sortedIteration], 1) + ";alpha:255")
			OryUIPinSpriteToTopRightOfSprite(userCard[cardNo].sprRatingRibbon, userCard[cardNo].sprBackground, 0.5, -0.2)
			OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtRatingRibbon, userCard[cardNo].sprRatingRibbon, 0, -0.1)
		endif
	endif
	
	// TICKER
	dd = 0
	hh = 0
	mm = 0
	ss = 0
	
	dd = floor((sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[sortedIteration] - sharedLocks[sharedLockSelected, 2].usersTimestampLocked[sortedIteration]) / 60 / 60 / 24)
	hh = mod((sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[sortedIteration] - sharedLocks[sharedLockSelected, 2].usersTimestampLocked[sortedIteration]) / 60 / 60, 24)
	mm = mod((sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[sortedIteration] - sharedLocks[sharedLockSelected, 2].usersTimestampLocked[sortedIteration]) / 60, 60)
	ss = mod((sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[sortedIteration] - sharedLocks[sharedLockSelected, 2].usersTimestampLocked[sortedIteration]), 60)

	if (dd = 1)
		days$ = "1 day"
	else
		days$ = str(dd) + " days"
	endif	
	if (hh = 1)
		hours$ = "1 hour"
	else
		hours$ = str(hh) + " hours"
	endif
	if (mm = 1)
		minutes$ = "1 minute"
	else
		minutes$ = str(mm) + " minutes"
	endif
	if (ss = 1)
		seconds$ = "1 second"
	else
		seconds$ = str(ss) + " seconds"
	endif
	
	if (dd > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + days$ + ", " + hours$ + ", and " + minutes$ + chr(10) + "Unlocked " + ReformatDateString(sharedLocks[sharedLockSelected, 2].usersDateUnlocked$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (hh > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + hours$ + ", and " + minutes$ + chr(10) + "Unlocked " + ReformatDateString(sharedLocks[sharedLockSelected, 2].usersDateUnlocked$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (mm > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + minutes$ + chr(10) + "Unlocked " + ReformatDateString(sharedLocks[sharedLockSelected, 2].usersDateUnlocked$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	elseif (ss > 0)
		OryUIUpdateText(userCard[cardNo].txtTicker, "text:Locked for " + seconds$ + chr(10) + "Unlocked " + ReformatDateString(sharedLocks[sharedLockSelected, 2].usersDateUnlocked$[sortedIteration], "DD/MM/YYYY", dateFormat$) + ";colorID:" + str(colorMode[colorModeSelected].textColor))
	endif
	
	if (reposition = 1)
		OryUIPinTextToTopCentreOfSprite(userCard[cardNo].txtTicker, userCard[cardNo].sprBackground, 0, 3)
	endif

	// BUTTON BAR
	if (reposition = 1)
		leftEmptyButtonVisible = 1
		favouriteButtonVisible = 1
		flagButtonVisible = 1
		moreButtonVisible = 1
		buttonX# = 0
		buttonsPlaced = 0
		
		noOfLeftButtons = 0
		noOfRightButtons = favouriteButtonVisible + flagButtonVisible + moreButtonVisible
		if (leftEmptyButtonVisible = 1)
			leftWidth# = 100 - ((noOfLeftButtons + noOfRightButtons) * 10)
			OryUIUpdateSprite(userCard[cardNo].sprLeftEmptyButton, "size:" + str(leftWidth#) + ",5;colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(userCard[cardNo].sprLeftEmptyButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			buttonX# = buttonX# + leftWidth#
		endif
		if (favouriteButtonVisible = 1)
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			OryUIPinSpriteToSprite(userCard[cardNo].sprFavouriteButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFavouriteIcon, userCard[cardNo].sprFavouriteButton, 0, 0)
			buttonX# = buttonX# + 10
			if (favouriteUsers.find(sharedLocks[sharedLockSelected, 2].usersID[sortedIteration]) = -1)
				OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOff) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			else
				OryUIUpdateSprite(userCard[cardNo].sprFavouriteIcon, "image:" + str(imgFavouriteOn) + ";color:255,255,255,255")
			endif
		endif
		if (flagButtonVisible = 1)
			OryUIUpdateSprite(userCard[cardNo].sprFlagButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
			OryUIPinSpriteToSprite(userCard[cardNo].sprFlagButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
			OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprFlagIcon, userCard[cardNo].sprFlagButton, 0, 0)
			buttonX# = buttonX# + 10
			flagChosen = GetFlagChosen(sharedLocks[sharedLockSelected, 2].usersID[sortedIteration])
			if (flagChosen = 0)
				OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[0]) + ";colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			else
				OryUIUpdateSprite(userCard[cardNo].sprFlagIcon, "image:" + str(imgFlags[flagChosen]) + ";color:255,255,255,255")
			endif
		endif
		if (moreButtonVisible = 1)
			if (reposition = 1)
				OryUIPinSpriteToSprite(userCard[cardNo].sprMoreButton, userCard[cardNo].sprButtonBar, buttonX#, 0.2)
				OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprMoreIcon, userCard[cardNo].sprMoreButton, 0, 0)
				OryUIUpdateSprite(userCard[cardNo].sprMoreButton, "colorID:" + str(colorMode[colorModeSelected].pageColor))
				OryUIUpdateSprite(userCard[cardNo].sprMoreIcon, "colorID:" + str(colorMode[colorModeSelected].barIconColor) + ";alpha:130")
			endif
		endif
	endif
	
	// RATING
	// If not rated and user unlocked less than 7 days ago, or if rated and was last updated 1 day ago then let keyholder rate lockee
	if (sharedLocks[sharedLockSelected, 2].usersTestLock[sortedIteration] = 0 and ((timestampNow - sharedLocks[sharedLockSelected, 2].usersTimestampUnlocked[sortedIteration] <= 604800 and sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration] = 0) or (timestampNow - sharedLocks[sharedLockSelected, 2].usersTimestampKeyholderRated[sortedIteration] <= 86400 and sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration])))
		OryUIUpdateText(userCard[cardNo].txtRateUser, "text:Rate " + sharedLocks[sharedLockSelected, 2].usersUsername$[sortedIteration] + ";colorID:" + str(colorMode[colorModeSelected].textColor))
		OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, -1.5)
		for a = 1 to 5
			if (a <= sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration])
				OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOn))
			else
				OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "image:" + str(imgStarOff))
			endif
			if (a = 1) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, -(2 * (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
			if (a = 2) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, -(GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
			if (a = 3) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, 0, 0.8)	
			if (a = 4) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2), 0.8)	
			if (a = 5) then OryUIPinSpriteToCentreOfSprite(userCard[cardNo].sprRatingStar[a], userCard[cardNo].sprButtonBar, (2 * (GetSpriteWidth(userCard[cardNo].sprRatingStar[a]) - 0.2)), 0.8)	
		next
	else
		for a = 1 to 5
			OryUIUpdateSprite(userCard[cardNo].sprRatingStar[a], "position:-1000,-1000")
		next
		if (sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration] = 0)
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text: ;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		elseif (sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration] = 1)
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text:You rated this 1 star;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		else
			OryUIUpdateText(userCard[cardNo].txtRateUser, "text:You rated this " + str(sharedLocks[sharedLockSelected, 2].usersRatingFromKeyholder[sortedIteration]) + " stars;colorID:" + str(colorMode[colorModeSelected].textColor))
			OryUIPinTextToCentreOfSprite(userCard[cardNo].txtRateUser, userCard[cardNo].sprButtonBar, 0, 0)
		endif	
	endif
endfunction	

function UpdateKeyholdersEmoji(sharedLockNo, userNo, logData$, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	SplitSingleLogRow(logData$)
	postData$ = ""
	postData$ = postData$ + "&emojiChosen=" + str(sharedLocks[sharedLockNo, 1].usersKeyholderEmojiChosen[userNo])
	postData$ = postData$ + "&emojiColourSelected=" + str(sharedLocks[sharedLockNo, 1].usersKeyholderEmojiColourSelected[userNo])
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, 1].usersLockID[userNo])
	postData$ = postData$ + "&logAction=" + singleLogRow.action$
	postData$ = postData$ + "&logActionedBy=" + singleLogRow.actionedBy$
	postData$ = postData$ + "&logPrivate=" + str(singleLogRow.private)
	postData$ = postData$ + "&logResult=" + singleLogRow.result$
	postData$ = postData$ + "&logTotalActionTime=" + str(singleLogRow.totalActionTime)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&sharedUserID=" + str(sharedLocks[sharedLockNo, 1].usersID[userNo])
	postData$ = postData$ + "&shareID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateKeyholdersEmoji=" + str(sharedLockNo) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateKeyholdersEmoji + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateLocksData(lockNo)
	local a as integer
	local fileID as integer
	
	fileID = OpenToWrite("ID" + str(locks[lockNo].id) + "V2.txt", 0)
	WriteString(fileID, "sortKey:" + locks[lockNo].sortKey$)
	WriteString(fileID, "autoResetsPaused:" + str(locks[lockNo].autoResetsPaused))
	WriteString(fileID, "blockBotFromUnlocking:" + str(locks[lockNo].blockBotFromUnlocking))
	WriteString(fileID, "blockUsersAlreadyLocked:" + str(locks[lockNo].blockUsersAlreadyLocked))
	WriteString(fileID, "botChosen:" + str(locks[lockNo].botChosen))
	WriteString(fileID, "build:" + str(locks[lockNo].build))
	WriteString(fileID, "cardInfoHidden:" + str(locks[lockNo].cardInfoHidden))
	WriteString(fileID, "chancesAccumulatedBeforeFreeze:" + str(locks[lockNo].chancesAccumulatedBeforeFreeze))
	WriteString(fileID, "checkInFrequencyInSeconds:" + str(locks[lockNo].checkInFrequencyInSeconds))
	WriteString(fileID, "combination:" + locks[lockNo].combination$)
	WriteString(fileID, "cumulative:" + str(locks[lockNo].cumulative))
	WriteString(fileID, "dateLastPicked:" + locks[lockNo].dateLastPicked$)
	WriteString(fileID, "dateLocked:" + locks[lockNo].dateLocked$)
	WriteString(fileID, "dateUnlocked:" + locks[lockNo].dateUnlocked$)
	WriteString(fileID, "discardPile:" + locks[lockNo].discardPile$)
	WriteString(fileID, "displayInStats:" + str(locks[lockNo].displayInStats))
	WriteString(fileID, "doubleUpCards:" + str(locks[lockNo].doubleUpCards))
	WriteString(fileID, "doubleUpCardsAdded:" + str(locks[lockNo].doubleUpCardsAdded))
	WriteString(fileID, "doubleUpCardsPicked:" + str(locks[lockNo].doubleUpCardsPicked))
	WriteString(fileID, "emojiChosen:" + str(locks[lockNo].emojiChosen))
	WriteString(fileID, "emojiColourSelected:" + str(locks[lockNo].emojiColourSelected))
	WriteString(fileID, "fake:" + str(locks[lockNo].fake))
	WriteString(fileID, "fixed:" + str(locks[lockNo].fixed))
	WriteString(fileID, "flagChosen:" + str(locks[lockNo].flagChosen))
	WriteString(fileID, "freezeCards:" + str(locks[lockNo].freezeCards))
	WriteString(fileID, "freezeCardsAdded:" + str(locks[lockNo].freezeCardsAdded))
	WriteString(fileID, "goAgainCards:" + str(locks[lockNo].goAgainCards))
	WriteString(fileID, "goAgainCardsPercentage:" + str(locks[lockNo].goAgainCardsPercentage#))
	WriteString(fileID, "greenCards:" + str(locks[lockNo].greenCards))
	WriteString(fileID, "greensPickedSinceReset:" + str(locks[lockNo].greensPickedSinceReset))
	WriteString(fileID, "groupID:" + str(locks[lockNo].groupID))
	WriteString(fileID, "hiddenFromOwner:" + str(locks[lockNo].hiddenFromOwner))
	WriteString(fileID, "hiddenFromOwnerAlertHidden:" + str(locks[lockNo].hiddenFromOwnerAlertHidden))
	WriteString(fileID, "hideGreensUntilPickCount:" + str(locks[lockNo].hideGreensUntilPickCount))
	WriteString(fileID, "id:" + str(locks[lockNo].id))
	WriteString(fileID, "initialDoubleUpCards:" + str(locks[lockNo].initialDoubleUpCards))
	WriteString(fileID, "initialFreezeCards:" + str(locks[lockNo].initialFreezeCards))
	WriteString(fileID, "initialGreenCards:" + str(locks[lockNo].initialGreenCards))
//~	WriteString(fileID, "initialMaximumDoubleUpCards:" + str(locks[lockNo].initialMaximumDoubleUpCards))
//~	WriteString(fileID, "initialMaximumFreezeCards:" + str(locks[lockNo].initialMaximumFreezeCards))
//~	WriteString(fileID, "initialMaximumGreenCards:" + str(locks[lockNo].initialMaximumGreenCards))
//~	WriteString(fileID, "initialMaximumMinutes:" + str(locks[lockNo].initialMaximumMinutes))
//~	WriteString(fileID, "initialMaximumRedCards:" + str(locks[lockNo].initialMaximumRedCards))
//~	WriteString(fileID, "initialMaximumResetCards:" + str(locks[lockNo].initialMaximumResetCards))
//~	WriteString(fileID, "initialMaximumStickyCards:" + str(locks[lockNo].initialMaximumStickyCards))
//~	WriteString(fileID, "initialMaximumYellowAddCards:" + str(locks[lockNo].initialMaximumYellowAddCards))
//~	WriteString(fileID, "initialMaximumYellowMinusCards:" + str(locks[lockNo].initialMaximumYellowMinusCards))
//~	WriteString(fileID, "initialMaximumYellowRandomCards:" + str(locks[lockNo].initialMaximumYellowRandomCards))
//~	WriteString(fileID, "initialMinimumDoubleUpCards:" + str(locks[lockNo].initialMinimumDoubleUpCards))
//~	WriteString(fileID, "initialMinimumFreezeCards:" + str(locks[lockNo].initialMinimumFreezeCards))
//~	WriteString(fileID, "initialMinimumGreenCards:" + str(locks[lockNo].initialMinimumGreenCards))
//~	WriteString(fileID, "initialMinimumMinutes:" + str(locks[lockNo].initialMinimumMinutes))
//~	WriteString(fileID, "initialMinimumRedCards:" + str(locks[lockNo].initialMinimumRedCards))
//~	WriteString(fileID, "initialMinimumResetCards:" + str(locks[lockNo].initialMinimumResetCards))
//~	WriteString(fileID, "initialMinimumStickyCards:" + str(locks[lockNo].initialMinimumStickyCards))
//~	WriteString(fileID, "initialMinimumYellowAddCards:" + str(locks[lockNo].initialMinimumYellowAddCards))
//~	WriteString(fileID, "initialMinimumYellowMinusCards:" + str(locks[lockNo].initialMinimumYellowMinusCards))
//~	WriteString(fileID, "initialMinimumYellowRandomCards:" + str(locks[lockNo].initialMinimumYellowRandomCards))
	WriteString(fileID, "initialMinutes:" + str(locks[lockNo].initialMinutes))
	WriteString(fileID, "initialRedCards:" + str(locks[lockNo].initialRedCards))
	WriteString(fileID, "initialResetCards:" + str(locks[lockNo].initialResetCards))
	WriteString(fileID, "initialStickyCards:" + str(locks[lockNo].initialStickyCards))
	WriteString(fileID, "initialYellowAdd1Cards:" + str(locks[lockNo].initialYellowAdd1Cards))
	WriteString(fileID, "initialYellowAdd2Cards:" + str(locks[lockNo].initialYellowAdd2Cards))
	WriteString(fileID, "initialYellowAdd3Cards:" + str(locks[lockNo].initialYellowAdd3Cards))
	WriteString(fileID, "initialYellowCards:" + str(locks[lockNo].initialYellowCards))
	WriteString(fileID, "initialYellowMinus1Cards:" + str(locks[lockNo].initialYellowMinus1Cards))
	WriteString(fileID, "initialYellowMinus2Cards:" + str(locks[lockNo].initialYellowMinus2Cards))
	WriteString(fileID, "iteration:" + str(locks[lockNo].iteration))
	WriteString(fileID, "keyDisabled:" + str(locks[lockNo].keyDisabled))
	WriteString(fileID, "keyholderAllowsFreeUnlock:" + str(locks[lockNo].keyholderAllowsFreeUnlock))
	WriteString(fileID, "keyholderBuildNumberInstalled:" + str(locks[lockNo].keyholderBuildNumberInstalled))
	WriteString(fileID, "keyholderDisabledKey:" + str(locks[lockNo].keyholderDisabledKey))
	WriteString(fileID, "keyholderDecisionDisabled:" + str(locks[lockNo].keyholderDecisionDisabled))
	WriteString(fileID, "keyholderEmojiChosen:" + str(locks[lockNo].keyholderEmojiChosen))
	WriteString(fileID, "keyholderEmojiColourSelected:" + str(locks[lockNo].keyholderEmojiColourSelected))
	WriteString(fileID, "keyholderID:" + str(locks[lockNo].keyholderID))
	WriteString(fileID, "keyholderUsername:" + locks[lockNo].keyholderUsername$)
	WriteString(fileID, "keyUsed:" + str(locks[lockNo].keyUsed))
	for a = 0 to 4
		WriteString(fileID, "lastXUpdates[" + str(a) + "].timestampUpdated:" + str(locks[lockNo].lastXUpdates[a].timestampUpdated))
		WriteString(fileID, "lastXUpdates[" + str(a) + "].update:" + locks[lockNo].lastXUpdates[a].update$)
	next
	WriteString(fileID, "lastUpdateIDSeen:" + str(locks[lockNo].lastUpdateIDSeen))
	WriteString(fileID, "lateCheckInWindowInSeconds:" + str(locks[lockNo].lateCheckInWindowInSeconds))
	WriteString(fileID, "lockFrozenByCard:" + str(locks[lockNo].lockFrozenByCard))
	WriteString(fileID, "lockFrozenByKeyholder:" + str(locks[lockNo].lockFrozenByKeyholder))
	WriteString(fileID, "lockName:" + locks[lockNo].lockName$)
	WriteString(fileID, "maximumAutoResets:" + str(locks[lockNo].maximumAutoResets))
	WriteString(fileID, "maximumMinutes:" + str(locks[lockNo].maximumMinutes))
	WriteString(fileID, "maximumRedCards:" + str(locks[lockNo].maximumRedCards))
	WriteString(fileID, "minimumMinutes:" + str(locks[lockNo].minimumMinutes))
	WriteString(fileID, "minimumRedCards:" + str(locks[lockNo].minimumRedCards))
	WriteString(fileID, "minutes:" + str(locks[lockNo].minutes))
	WriteString(fileID, "minutesAdded:" + str(locks[lockNo].minutesAdded))
	WriteString(fileID, "multipleGreensRequired:" + str(locks[lockNo].multipleGreensRequired))
	WriteString(fileID, "noOfAdd1Cards:" + str(locks[lockNo].noOfAdd1Cards))
	WriteString(fileID, "noOfAdd2Cards:" + str(locks[lockNo].noOfAdd2Cards))
	WriteString(fileID, "noOfAdd3Cards:" + str(locks[lockNo].noOfAdd3Cards))
	WriteString(fileID, "noOfKeysRequired:" + str(locks[lockNo].noOfKeysRequired))
	WriteString(fileID, "noOfMinus1Cards:" + str(locks[lockNo].noOfMinus1Cards))
	WriteString(fileID, "noOfMinus2Cards:" + str(locks[lockNo].noOfMinus2Cards))
	WriteString(fileID, "noOfTimesAutoReset:" + str(locks[lockNo].noOfTimesAutoReset))
	WriteString(fileID, "noOfTimesCardReset:" + str(locks[lockNo].noOfTimesCardReset))
	WriteString(fileID, "noOfTimesFullReset:" + str(locks[lockNo].noOfTimesFullReset))
	WriteString(fileID, "noOfTimesGreenCardRevealed:" + str(locks[lockNo].noOfTimesGreenCardRevealed))
	WriteString(fileID, "noOfTimesReset:" + str(locks[lockNo].noOfTimesReset))
	WriteString(fileID, "permanent:" + str(locks[lockNo].permanent))
	WriteString(fileID, "pickedCount:" + str(locks[lockNo].pickedCount))
	WriteString(fileID, "pickedCountIncludingYellows:" + str(locks[lockNo].pickedCountIncludingYellows))
	WriteString(fileID, "pickedCountSinceReset:" + str(locks[lockNo].pickedCountSinceReset))
	WriteString(fileID, "randomCardsAdded:" + str(locks[lockNo].randomCardsAdded))
	WriteString(fileID, "rating:" + str(locks[lockNo].rating))
	WriteString(fileID, "readyToUnlock:" + str(locks[lockNo].readyToUnlock))
	WriteString(fileID, "redCards:" + str(locks[lockNo].redCards))
	WriteString(fileID, "redCardsAdded:" + str(locks[lockNo].redCardsAdded))
	WriteString(fileID, "regularity:" + str(locks[lockNo].regularity#))
	WriteString(fileID, "removedByKeyholder:" + str(locks[lockNo].removedByKeyholder))
	WriteString(fileID, "removedByKeyholderAlertHidden:" + str(locks[lockNo].removedByKeyholderAlertHidden))
	WriteString(fileID, "resetCards:" + str(locks[lockNo].resetCards))
	WriteString(fileID, "resetCardsAdded:" + str(locks[lockNo].resetCardsAdded))
	WriteString(fileID, "resetCardsPicked:" + str(locks[lockNo].resetCardsPicked))
	WriteString(fileID, "resetFrequencyInSeconds:" + str(locks[lockNo].resetFrequencyInSeconds))
	WriteString(fileID, "ribbonType:" + locks[lockNo].ribbonType$)
	WriteString(fileID, "rowInDB:" + str(locks[lockNo].rowInDB))
	WriteString(fileID, "sharedID:" + locks[lockNo].sharedID$)
	WriteString(fileID, "simulationAverageMinutesLocked:" + str(locks[lockNo].simulationAverageMinutesLocked))
	WriteString(fileID, "simulationBestCaseMinutesLocked:" + str(locks[lockNo].simulationBestCaseMinutesLocked))
	WriteString(fileID, "simulationWorstCaseMinutesLocked:" + str(locks[lockNo].simulationWorstCaseMinutesLocked))
	WriteString(fileID, "stickyCards:" + str(locks[lockNo].stickyCards))
	WriteString(fileID, "test:" + str(locks[lockNo].test))
	WriteString(fileID, "timeLeftUntilNextChanceBeforeFreeze:" + str(locks[lockNo].timeLeftUntilNextChanceBeforeFreeze))
	WriteString(fileID, "timerHidden:" + str(locks[lockNo].timerHidden))
	WriteString(fileID, "timestampCleanTimeRequestBlockedUntil:" + str(locks[lockNo].timestampCleanTimeRequestBlockedUntil))
	WriteString(fileID, "timestampDeniedCleanTime:" + str(locks[lockNo].timestampDeniedCleanTime))
	WriteString(fileID, "timestampEndedCleanTime:" + str(locks[lockNo].timestampEndedCleanTime))
	WriteString(fileID, "timestampFrozenByCard:" + str(locks[lockNo].timestampFrozenByCard))
	WriteString(fileID, "timestampFrozenByKeyholder:" + str(locks[lockNo].timestampFrozenByKeyholder))
	WriteString(fileID, "timestampHiddenFromOwner:" + str(locks[lockNo].timestampHiddenFromOwner))
	WriteString(fileID, "timestampLastAutoReset:" + str(locks[lockNo].timestampLastAutoReset))
	WriteString(fileID, "timestampLastCardReset:" + str(locks[lockNo].timestampLastCardReset))
	WriteString(fileID, "timestampLastCheckedIn:" + str(locks[lockNo].timestampLastCheckedIn))
	WriteString(fileID, "timestampLastCheckedUpdates:" + str(locks[lockNo].timestampLastCheckedUpdates))
	WriteString(fileID, "timestampLastFullReset:" + str(locks[lockNo].timestampLastFullReset))
	WriteString(fileID, "timestampLastPicked:" + str(locks[lockNo].timestampLastPicked))
	WriteString(fileID, "timestampLastReset:" + str(locks[lockNo].timestampLastReset))
	WriteString(fileID, "timestampLastSynced:" + str(locks[lockNo].timestampLastSynced))
	WriteString(fileID, "timestampLastUpdated:" + str(locks[lockNo].timestampLastUpdated))
	WriteString(fileID, "timestampLocked:" + str(locks[lockNo].timestampLocked))
	WriteString(fileID, "timestampRated:" + str(locks[lockNo].timestampRated))
	WriteString(fileID, "timestampRealLastPicked:" + str(locks[lockNo].timestampRealLastPicked))
	WriteString(fileID, "timestampRemovedByKeyholder:" + str(locks[lockNo].timestampRemovedByKeyholder))
	WriteString(fileID, "timestampRequestedCleanTime:" + str(locks[lockNo].timestampRequestedCleanTime))
	WriteString(fileID, "timestampRequestedKeyholdersDecision:" + str(locks[lockNo].timestampRequestedKeyholdersDecision))
	WriteString(fileID, "timestampRibbonAdded:" + str(locks[lockNo].timestampRibbonAdded))
	WriteString(fileID, "timestampStartedCleanTime:" + str(locks[lockNo].timestampStartedCleanTime))
	WriteString(fileID, "timestampUnfreezes:" + str(locks[lockNo].timestampUnfreezes))
	WriteString(fileID, "timestampUnfrozen:" + str(locks[lockNo].timestampUnfrozen))
	WriteString(fileID, "timestampUnlocked:" + str(locks[lockNo].timestampUnlocked))
	WriteString(fileID, "totalTimeCleaning:" + str(locks[lockNo].totalTimeCleaning))
	WriteString(fileID, "totalTimeFrozen:" + str(locks[lockNo].totalTimeFrozen))
	WriteString(fileID, "trustKeyholder:" + str(locks[lockNo].trustKeyholder))
	WriteString(fileID, "unlocked:" + str(locks[lockNo].unlocked))
	WriteString(fileID, "version:" + locks[lockNo].version$)
	WriteString(fileID, "yellowCards:" + str(locks[lockNo].yellowCards))
	CloseFile(fileID)
	ResetAllNotifications()
endfunction

function UpdateLocksDatabase(lockNo, logData$, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	if (locks[lockNo].id > 0)
		SplitSingleLogRow(logData$)
		postData$ = ""
		postData$ = postData$ + "&autoResetsPaused=" + str(locks[lockNo].autoResetsPaused)
		postData$ = postData$ + "&blockBotFromUnlocking=" + str(locks[lockNo].blockBotFromUnlocking)
		postData$ = postData$ + "&blockUsersAlreadyLocked=" + str(locks[lockNo].blockUsersAlreadyLocked)
		postData$ = postData$ + "&botChosen=" + str(locks[lockNo].botChosen)
		postData$ = postData$ + "&build=" + str(constBuildNumber)
		postData$ = postData$ + "&cardInfoHidden=" + str(locks[lockNo].cardInfoHidden)
		postData$ = postData$ + "&chancesAccumulatedBeforeFreeze=" + str(locks[lockNo].chancesAccumulatedBeforeFreeze)
		postData$ = postData$ + "&checkInFrequencyInSeconds=" + str(locks[lockNo].checkInFrequencyInSeconds)
		postData$ = postData$ + "&combination=" + locks[lockNo].combination$
		postData$ = postData$ + "&cumulative=" + str(locks[lockNo].cumulative)
		postData$ = postData$ + "&dateDelted=" + locks[lockNo].dateDeleted$
		postData$ = postData$ + "&dateLastPicked=" + locks[lockNo].dateLastPicked$
		postData$ = postData$ + "&dateLocked=" + locks[lockNo].dateLocked$
		postData$ = postData$ + "&dateUnlocked=" + locks[lockNo].dateUnlocked$
		postData$ = postData$ + "&deleted=" + str(locks[lockNo].deleted)
		postData$ = postData$ + "&discardPile=" + locks[lockNo].discardPile$
		postData$ = postData$ + "&displayInStats=" + str(locks[lockNo].displayInStats)
		postData$ = postData$ + "&doubleUpCards=" + str(locks[lockNo].doubleUpCards)
		postData$ = postData$ + "&doubleUpCardsAdded=" + str(locks[lockNo].doubleUpCardsAdded)
		postData$ = postData$ + "&doubleUpCardsPicked=" + str(locks[lockNo].doubleUpCardsPicked)
		postData$ = postData$ + "&emojiChosen=" + str(locks[lockNo].emojiChosen)
		postData$ = postData$ + "&emojiColourSelected=" + str(locks[lockNo].emojiColourSelected)
		postData$ = postData$ + "&fake=" + str(locks[lockNo].fake)
		postData$ = postData$ + "&fixed=" + str(locks[lockNo].fixed)
		postData$ = postData$ + "&flagChosen=" + str(locks[lockNo].flagChosen)
		postData$ = postData$ + "&freezeCards=" + str(locks[lockNo].freezeCards)
		postData$ = postData$ + "&freezeCardsAdded=" + str(locks[lockNo].freezeCardsAdded)
		postData$ = postData$ + "&goAgainCards=" + str(locks[lockNo].goAgainCards)
		postData$ = postData$ + "&goAgainCardsPercentage=" + str(locks[lockNo].goAgainCardsPercentage#)
		postData$ = postData$ + "&greenCards=" + str(locks[lockNo].greenCards)
		postData$ = postData$ + "&greensPickedSinceReset=" + str(locks[lockNo].greensPickedSinceReset)
		postData$ = postData$ + "&groupID=" + str(locks[lockNo].groupID)
		postData$ = postData$ + "&hideGreensUntilPickCount=" + str(locks[lockNo].hideGreensUntilPickCount)
		postData$ = postData$ + "&initialDoubleUpCards=" + str(locks[lockNo].initialDoubleUpCards)
		postData$ = postData$ + "&initialFreezeCards=" + str(locks[lockNo].initialFreezeCards)
		postData$ = postData$ + "&initialGreenCards=" + str(locks[lockNo].initialGreenCards)
		postData$ = postData$ + "&initialMinutes=" + str(locks[lockNo].initialMinutes)
		postData$ = postData$ + "&initialRedCards=" + str(locks[lockNo].initialRedCards)
		postData$ = postData$ + "&initialResetCards=" + str(locks[lockNo].initialResetCards)
		postData$ = postData$ + "&initialStickyCards=" + str(locks[lockNo].initialStickyCards)
		postData$ = postData$ + "&initialYellowAdd1Cards=" + str(locks[lockNo].initialYellowAdd1Cards)
		postData$ = postData$ + "&initialYellowAdd2Cards=" + str(locks[lockNo].initialYellowAdd2Cards)
		postData$ = postData$ + "&initialYellowAdd3Cards=" + str(locks[lockNo].initialYellowAdd3Cards)
		postData$ = postData$ + "&initialYellowCards=" + str(locks[lockNo].initialYellowCards)
		postData$ = postData$ + "&initialYellowMinus1Cards=" + str(locks[lockNo].initialYellowMinus1Cards)
		postData$ = postData$ + "&initialYellowMinus2Cards=" + str(locks[lockNo].initialYellowMinus2Cards)
		postData$ = postData$ + "&justUnlocked=" + str(locks[lockNo].justUnlocked)
		postData$ = postData$ + "&keyDisabled=" + str(locks[lockNo].keyDisabled)
		postData$ = postData$ + "&keyholderAllowsFreeUnlock=" + str(locks[lockNo].keyholderAllowsFreeUnlock)
		postData$ = postData$ + "&keyholderDecisionDisabled=" + str(locks[lockNo].keyholderDecisionDisabled)
		postData$ = postData$ + "&keyholderDisabledKey=" + str(locks[lockNo].keyholderDisabledKey)
		postData$ = postData$ + "&keyholderID=" + str(locks[lockNo].keyholderID)
		postData$ = postData$ + "&keyUsed=" + str(locks[lockNo].keyUsed)
		postData$ = postData$ + "&lastUpdateIDSeen=" + str(locks[lockNo].lastUpdateIDSeen)
		postData$ = postData$ + "&lateCheckInWindowInSeconds=" + str(locks[lockNo].lateCheckInWindowInSeconds)
		postData$ = postData$ + "&lockFrozenByCard=" + str(locks[lockNo].lockFrozenByCard)
		postData$ = postData$ + "&lockFrozenByKeyholder=" + str(locks[lockNo].lockFrozenByKeyholder)
		postData$ = postData$ + "&lockName=" + locks[lockNo].lockName$
		postData$ = postData$ + "&lockID=" + str(locks[lockNo].id)
		postData$ = postData$ + "&logAction=" + singleLogRow.action$
		postData$ = postData$ + "&logActionedBy=" + singleLogRow.actionedBy$
		postData$ = postData$ + "&logPrivate=" + str(singleLogRow.private)
		postData$ = postData$ + "&logResult=" + singleLogRow.result$
		postData$ = postData$ + "&logTotalActionTime=" + str(singleLogRow.totalActionTime)
		postData$ = postData$ + "&maximumAutoResets=" + str(locks[lockNo].maximumAutoResets)
		postData$ = postData$ + "&maximumMinutes=" + str(locks[lockNo].maximumMinutes)
		postData$ = postData$ + "&maximumRedCards=" + str(locks[lockNo].maximumRedCards)
		postData$ = postData$ + "&minimumMinutes=" + str(locks[lockNo].minimumMinutes)
		postData$ = postData$ + "&minimumRedCards=" + str(locks[lockNo].minimumRedCards)
		postData$ = postData$ + "&minutes=" + str(locks[lockNo].minutes)
		postData$ = postData$ + "&minutesAdded=" + str(locks[lockNo].minutesAdded)
		postData$ = postData$ + "&multipleGreensRequired=" + str(locks[lockNo].multipleGreensRequired)
		postData$ = postData$ + "&noOfAdd1Cards=" + str(locks[lockNo].noOfAdd1Cards)
		postData$ = postData$ + "&noOfAdd2Cards=" + str(locks[lockNo].noOfAdd2Cards)
		postData$ = postData$ + "&noOfAdd3Cards=" + str(locks[lockNo].noOfAdd3Cards)
		postData$ = postData$ + "&noOfKeysRequired=" + str(locks[lockNo].noOfKeysRequired)
		postData$ = postData$ + "&noOfMinus1Cards=" + str(locks[lockNo].noOfMinus1Cards)
		postData$ = postData$ + "&noOfMinus2Cards=" + str(locks[lockNo].noOfMinus2Cards)
		postData$ = postData$ + "&noOfTimesAutoReset=" + str(locks[lockNo].noOfTimesAutoReset)
		postData$ = postData$ + "&noOfTimesCardReset=" + str(locks[lockNo].noOfTimesCardReset)
		postData$ = postData$ + "&noOfTimesFullReset=" + str(locks[lockNo].noOfTimesFullReset)
		postData$ = postData$ + "&noOfTimesGreenCardRevealed=" + str(locks[lockNo].noOfTimesGreenCardRevealed)
		postData$ = postData$ + "&noOfTimesReset=" + str(locks[lockNo].noOfTimesReset)
		postData$ = postData$ + "&permanent=" + str(locks[lockNo].permanent)
		postData$ = postData$ + "&pickedCount=" + str(locks[lockNo].pickedCount)
		postData$ = postData$ + "&pickedCountIncludingYellows=" + str(locks[lockNo].pickedCountIncludingYellows)
		postData$ = postData$ + "&pickedCountSinceReset=" + str(locks[lockNo].pickedCountSinceReset)
		postData$ = postData$ + "&platform=" + GetDeviceBaseName()
		postData$ = postData$ + "&randomCardsAdded=" + str(locks[lockNo].randomCardsAdded)
		postData$ = postData$ + "&rating=" + str(locks[lockNo].rating)
		postData$ = postData$ + "&readyToUnlock=" + str(locks[lockNo].readyToUnlock)
		postData$ = postData$ + "&redCards=" + str(locks[lockNo].redCards)
		postData$ = postData$ + "&redCardsAdded=" + str(locks[lockNo].redCardsAdded)
		postData$ = postData$ + "&regularity=" + str(locks[lockNo].regularity#)
		postData$ = postData$ + "&resetCards=" + str(locks[lockNo].resetCards)
		postData$ = postData$ + "&resetCardsAdded=" + str(locks[lockNo].resetCardsAdded)
		postData$ = postData$ + "&resetCardsPicked=" + str(locks[lockNo].resetCardsPicked)
		postData$ = postData$ + "&resetFrequencyInSeconds=" + str(locks[lockNo].resetFrequencyInSeconds)
		postData$ = postData$ + "&sharedID=" + locks[lockNo].sharedID$
		postData$ = postData$ + "&simulationAverageMinutesLocked=" + str(locks[lockNo].simulationAverageMinutesLocked)
		postData$ = postData$ + "&simulationBestCaseMinutesLocked=" + str(locks[lockNo].simulationBestCaseMinutesLocked)
		postData$ = postData$ + "&simulationWorstCaseMinutesLocked=" + str(locks[lockNo].simulationWorstCaseMinutesLocked)
		postData$ = postData$ + "&stickyCards=" + str(locks[lockNo].stickyCards)
		postData$ = postData$ + "&test=" + str(locks[lockNo].test)
		postData$ = postData$ + "&timeLeftUntilNextChanceBeforeFreeze=" + str(locks[lockNo].timeLeftUntilNextChanceBeforeFreeze)
		postData$ = postData$ + "&timerHidden=" + str(locks[lockNo].timerHidden)
		postData$ = postData$ + "&timestampDeleted=" + str(locks[lockNo].timestampDeleted)
		postData$ = postData$ + "&timestampEndedCleanTime=" + str(locks[lockNo].timestampEndedCleanTime)
		postData$ = postData$ + "&timestampFrozenByCard=" + str(locks[lockNo].timestampFrozenByCard)
		postData$ = postData$ + "&timestampFrozenByKeyholder=" + str(locks[lockNo].timestampFrozenByKeyholder)
		postData$ = postData$ + "&timestampLastAutoReset=" + str(locks[lockNo].timestampLastAutoReset)
		postData$ = postData$ + "&timestampLastCardReset=" + str(locks[lockNo].timestampLastCardReset)
		postData$ = postData$ + "&timestampLastCheckedIn=" + str(locks[lockNo].timestampLastCheckedIn)
		postData$ = postData$ + "&timestampLastFullReset=" + str(locks[lockNo].timestampLastFullReset)
		postData$ = postData$ + "&timestampLastPicked=" + str(locks[lockNo].timestampLastPicked)
		postData$ = postData$ + "&timestampLastReset=" + str(locks[lockNo].timestampLastReset)
		postData$ = postData$ + "&timestampLastSynced=" + str(locks[lockNo].timestampLastSynced)
		postData$ = postData$ + "&timestampLocked=" + str(locks[lockNo].timestampLocked)
		postData$ = postData$ + "&timestampRated=" + str(locks[lockNo].timestampRated)
		postData$ = postData$ + "&timestampRealLastPicked=" + str(locks[lockNo].timestampRealLastPicked)
		postData$ = postData$ + "&timestampRequestedCleanTime=" + str(locks[lockNo].timestampRequestedCleanTime)
		postData$ = postData$ + "&timestampRequestedKeyholdersDecision=" + str(locks[lockNo].timestampRequestedKeyholdersDecision)
		postData$ = postData$ + "&timestampStartedCleanTime=" + str(locks[lockNo].timestampStartedCleanTime)
		postData$ = postData$ + "&timestampUnfreezes=" + str(locks[lockNo].timestampUnfreezes)
		postData$ = postData$ + "&timestampUnfrozen=" + str(locks[lockNo].timestampUnfrozen)
		postData$ = postData$ + "&timestampUnlocked=" + str(locks[lockNo].timestampUnlocked)
		postData$ = postData$ + "&totalTimeCleaning=" + str(locks[lockNo].totalTimeCleaning)
		postData$ = postData$ + "&totalTimeFrozen=" + str(locks[lockNo].totalTimeFrozen)
		postData$ = postData$ + "&trustKeyholder=" + str(locks[lockNo].trustKeyholder)
		postData$ = postData$ + "&unlocked=" + str(locks[lockNo].unlocked)
		postData$ = postData$ + "&userID1=" + userID$
		postData$ = postData$ + "&userID2=" + userID$
		postData$ = postData$ + "&version=" + store$ + " " + ReplaceString(constVersionNumber$, " ", ".", -1)
		postData$ = postData$ + "&yellowCards=" + str(locks[lockNo].yellowCards)
		OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateMyLock=" + str(locks[lockNo].id) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateLocksDatabase + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
		locks[lockNo].justUnlocked = 0
	endif
endfunction

function UpdateRecentActivityReadFlag(id, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&id=" + str(id)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateRecentActivityReadFlag=" + str(id) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateRecentActivityReadFlag + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateRecentActivityReadFlagForAll(addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateRecentActivityReadFlagForAll;script:" + URLs[0].URLPath + "/" + URLs[0].UpdateRecentActivityReadFlagForAll + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateSharedLock(sharedLockNo, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	minVersionRequired$ = "2.3.0"
	if (sharedLocks[sharedLockNo, 0].maxRandomGreens > 1) then minVersionRequired$ = "2.3.4.beta.1"
	if (sharedLocks[sharedLockNo, 0].maxRandomDoubleUps > 0) then minVersionRequired$ = "2.3.4.beta.1"
	if (sharedLocks[sharedLockNo, 0].multipleGreensRequired = 1) then minVersionRequired$ = "2.3.4.beta.1"
	if (cardInfoHidden = 1) then minVersionRequired$ = "2.4.0.beta.1"
	if (sharedLocks[sharedLockNo, 0].maxRandomYellowsAdd > 0 or sharedLocks[sharedLockNo, 0].maxRandomYellowsMinus > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (sharedLocks[sharedLockNo, 0].maxRandomFreezes > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (maxUsers > 0) then minVersionRequired$ = "2.4.0.beta.1"
	if (sharedLocks[sharedLockNo, 0].regularity# = 0.5 or (sharedLocks[sharedLockNo, 0].regularity# > 1 and sharedLocks[sharedLockNo, 0].regularity# < 24)) then minVersionRequired$ = "2.4.0.beta.1"
	if (blockUsersAlreadyLocked = 1) then minVersionRequired$ = "2.4.0.beta.1"
	if (sharedLocks[sharedLockNo, 0].fixed = 1 and sharedLocks[sharedLockNo, 0].build >= 134) then minVersionRequired$ = "2.5.0.alpha.1"
	if (minCopies > 0) then minVersionRequired$ = "2.5.0.alpha.1"
	if (requireDM > 0) then minVersionRequired$ = "2.5.0.alpha.1"
	if (blockUsersWithStatsHidden = 1) then minVersionRequired$ = "2.5.0.alpha.8"
	if (maxAutoResets > 0) then minVersionRequired$ = "2.5.2.alpha.1"
	if (keyholderDecisionDisabled = 1) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomDoubleUps > 20 or sharedLocks[sharedLockNo, 0].maxRandomDoubleUps > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomFreezes > 20 or sharedLocks[sharedLockNo, 0].maxRandomFreezes > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomGreens > 20 or sharedLocks[sharedLockNo, 0].maxRandomGreens > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (minRatingRequired = 1) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomReds > 399 or sharedLocks[sharedLockNo, 0].maxRandomReds > 399) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomResets > 20 or sharedLocks[sharedLockNo, 0].maxRandomResets > 20) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomYellowsAdd > 200 or sharedLocks[sharedLockNo, 0].maxRandomYellowsAdd > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomYellowsMinus > 200 or sharedLocks[sharedLockNo, 0].maxRandomYellowsMinus > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomYellows > 200 or sharedLocks[sharedLockNo, 0].maxRandomYellows > 200) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].fixed = 0 and sharedLocks[sharedLockNo, 0].regularity# = 0.016667) then minVersionRequired$ = "2.5.2.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomStickies > 0 or sharedLocks[sharedLockNo, 0].maxRandomStickies > 0) then minVersionRequired$ = "2.5.3.alpha.2"
	if (sharedLocks[sharedLockNo, 0].minRandomStickies > 30 or sharedLocks[sharedLockNo, 0].maxRandomStickies > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomDoubleUps > 30 or sharedLocks[sharedLockNo, 0].maxRandomDoubleUps > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomFreezes > 30 or sharedLocks[sharedLockNo, 0].maxRandomFreezes > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomGreens > 30 or sharedLocks[sharedLockNo, 0].maxRandomGreens > 30) then minVersionRequired$ = "2.5.4.alpha.1"
	if (sharedLocks[sharedLockNo, 0].minRandomResets > 30 or sharedLocks[sharedLockNo, 0].maxRandomResets > 30) then minVersionRequired$ = "2.5.4.alpha.1"	
	if (startLockFrozen = 1) then minVersionRequired$ = "2.6.2.alpha.1"
	if (checkInFrequencyInSeconds > 0) then minVersionRequired$ = "2.6.3.alpha.1"
	if (temporarilyDisabled = 1) then minVersionRequired$ = "2.6.5.alpha.2"
	if (lateCheckInWindowInSeconds > 0) then minVersionRequired$ = "2.6.8.alpha.1"
	if (blockTestLocks = 1) then minVersionRequired$ = "2.7.2.alpha.1"
	
	postData$ = ""
	postData$ = postData$ + "&blockTestLocks=" + str(blockTestLocks)
	postData$ = postData$ + "&blockUsersAlreadyLocked=" + str(blockUsersAlreadyLocked)
	postData$ = postData$ + "&blockUsersWithStatsHidden=" + str(blockUsersWithStatsHidden)
	postData$ = postData$ + "&cardInfoHidden=" + str(cardInfoHidden)
	postData$ = postData$ + "&checkInFrequencyInSeconds=" + str(checkInFrequencyInSeconds)
	postData$ = postData$ + "&forceTrust=" + str(forceTrust)
	postData$ = postData$ + "&keyDisabled=" + str(keyDisabled)
	postData$ = postData$ + "&keyholderDecisionDisabled=" + str(keyholderDecisionDisabled)
	postData$ = postData$ + "&lateCheckInWindowInSeconds=" + str(lateCheckInWindowInSeconds)
	postData$ = postData$ + "&maxAutoResets=" + str(maxAutoResets)
	postData$ = postData$ + "&maxCopies=" + str(maxCopies)
	postData$ = postData$ + "&maxUsers=" + str(maxUsers)
	postData$ = postData$ + "&minCopies=" + str(minCopies)
	postData$ = postData$ + "&minRatingRequired=" + str(minRatingRequired)
	postData$ = postData$ + "&minVersionRequired=" + minVersionRequired$
	if (newLockName$ <> sharedLocks[sharedLockNo, 0].lockName$)
		postData$ = postData$ + "&name=" + newLockName$
	else
		postData$ = postData$ + "&name=" + sharedLocks[sharedLockNo, 0].lockName$
	endif
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&requireDM=" + str(requireDM)
	postData$ = postData$ + "&resetFrequencyInSeconds=" + str(resetFrequencyInSeconds)
	postData$ = postData$ + "&shareID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&shareInAPI=" + str(shareInAPI)
	postData$ = postData$ + "&startLockFrozen=" + str(startLockFrozen)
	postData$ = postData$ + "&temporarilyDisabled=" + str(temporarilyDisabled)
	postData$ = postData$ + "&timerHidden=" + str(timerHidden)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateSharedLock=" + str(sharedLockNo) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateSharedLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateUsername(newUsername$, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	postData$ = ""
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&username=" + newUsername$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateUsername=" + newUsername$ + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateUsername + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UpdateUsersLock(sharedLockNo, usersTab, userNo, logData$, hideUpdate, fakeUpdate, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	SplitSingleLogRow(logData$)							
	postData$ = ""
	postData$ = postData$ + "&allowFreeUnlockModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersKeyholderAllowsFreeUnlockModifiedBy[userNo])
	postData$ = postData$ + "&autoResetsPausedModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersAutoResetsPausedModifiedBy[userNo])
	postData$ = postData$ + "&cardInfoHiddenModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersCardInfoHiddenModifiedBy[userNo])
	postData$ = postData$ + "&cumulativeModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersCumulativeModifiedBy[userNo])
	postData$ = postData$ + "&doubleUpCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersDoubleUpCardsModifiedBy[userNo])
	postData$ = postData$ + "&fakeUpdate=" + str(fakeUpdate)
	postData$ = postData$ + "&freezeCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersFreezeCardsModifiedBy[userNo])
	postData$ = postData$ + "&greenCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersGreenCardsModifiedBy[userNo])
	postData$ = postData$ + "&greenCardsPicked=" + str(sharedLocks[sharedLockNo, usersTab].usersGreenCardsPicked[userNo])
	postData$ = postData$ + "&hideUpdate=" + str(hideUpdate)
	postData$ = postData$ + "&lockFrozenByKeyholderModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersLockFrozenByKeyholderModifiedBy[userNo])
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, usersTab].usersLockID[userNo])
	postData$ = postData$ + "&logAction=" + singleLogRow.action$
	postData$ = postData$ + "&logActionedBy=" + singleLogRow.actionedBy$
	postData$ = postData$ + "&logResult=" + singleLogRow.result$
	postData$ = postData$ + "&logPrivate=" + str(singleLogRow.private)
	postData$ = postData$ + "&logTotalActionTime=" + str(singleLogRow.totalActionTime)
	postData$ = postData$ + "&minutesModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersMinutesModifiedBy[userNo])
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&redCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersRedCardsModifiedBy[userNo])
	postData$ = postData$ + "&reset=" + str(sharedLocks[sharedLockNo, usersTab].usersReset[userNo])
	postData$ = postData$ + "&resetCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersResetCardsModifiedBy[userNo])
	postData$ = postData$ + "&sharedID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&sharedUserID=" + str(sharedLocks[sharedLockNo, usersTab].usersID[userNo])
	postData$ = postData$ + "&stickyCardsModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersStickyCardsModifiedBy[userNo])
	postData$ = postData$ + "&timerHiddenModifiedBy=" + str(sharedLocks[sharedLockNo, usersTab].usersTimerHiddenModifiedBy[userNo])
	postData$ = postData$ + "&timestampModified=" + str(timestampNow)
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	postData$ = postData$ + "&yellowCardsModifiedBy1=" + str(sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 1])
	postData$ = postData$ + "&yellowCardsModifiedBy2=" + str(sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 2])
	postData$ = postData$ + "&yellowCardsModifiedBy3=" + str(sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 3])
	postData$ = postData$ + "&yellowCardsModifiedBy4=" + str(sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 4])
	postData$ = postData$ + "&yellowCardsModifiedBy5=" + str(sharedLocks[sharedLockNo, usersTab].usersYellowCardsModifiedBy[userNo, 5])
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateUsersLock=" + str(sharedLockNo) + "," + str(userNo) + "," + str(usersTab) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateUsersLock + ";postData:" + postData$ + ";addToFront:" + str(addToFront))					
endfunction

function UpdateUsersRatingFromKeyholder(sharedLockNo, usersTab, userNo, logData$, addToFront)
	if (maintenance = 1) then exitfunction
	
	local postData$ as string
	
	SplitSingleLogRow(logData$)
	postData$ = ""
	postData$ = postData$ + "&lockID=" + str(sharedLocks[sharedLockNo, usersTab].usersLockID[userNo])
	postData$ = postData$ + "&logAction=" + singleLogRow.action$
	postData$ = postData$ + "&logActionedBy=" + singleLogRow.actionedBy$
	postData$ = postData$ + "&logPrivate=" + str(singleLogRow.private)
	postData$ = postData$ + "&logResult=" + singleLogRow.result$
	postData$ = postData$ + "&logTotalActionTime=" + str(singleLogRow.totalActionTime)
	postData$ = postData$ + "&platform=" + GetDeviceBaseName()
	postData$ = postData$ + "&ratingFromKeyholder=" + str(sharedLocks[sharedLockNo, usersTab].usersRatingFromKeyholder[userNo])
	postData$ = postData$ + "&sharedID=" + sharedLocks[sharedLockNo, 0].shareID$
	postData$ = postData$ + "&sharedUserID=" + str(sharedLocks[sharedLockNo, usersTab].usersID[userNo])
	postData$ = postData$ + "&timestampKeyholderRated=" + str(sharedLocks[sharedLockSelected, usersTab].usersTimestampKeyholderRated[userNo])
	postData$ = postData$ + "&userID1=" + userID$
	postData$ = postData$ + "&userID2=" + userID$
	OryUIAddItemToHTTPSQueue(httpsQueue, "name:UpdateUsersLock=" + str(sharedLockNo) + "," + str(userNo) + "," + str(usersTab) + ";script:" + URLs[0].URLPath + "/" + URLs[0].UpdateUsersRatingFromKeyholder + ";postData:" + postData$ + ";addToFront:" + str(addToFront))
endfunction

function UseKeys(cardNo as integer, lockSelected as integer)
	if (noOfKeys >= locks[lockSelected].noOfKeysRequired)
		if (locks[lockSelected].fake = 0)
			noOfKeys = noOfKeys - locks[lockSelected].noOfKeysRequired
			SaveLocalVariable("noOfKeys", str(noOfKeys))
		else
			fakeLockUnlocked = 1						
		endif
		locks[lockSelected].keyUsed = 1
		screen[screenNo].lastViewY# = GetViewOffsetY()
		if (locks[lockSelected].noOfKeysRequired = 1) then UnlockLock(lockSelected, "Lockee", "Key")
		if (locks[lockSelected].noOfKeysRequired > 1) then UnlockLock(lockSelected, "Lockee", "Keys")
	endif
endfunction

function VersionCompare(version1$ as string, version2$ as string)
	local different as integer
	local version1AlphaBeta$ as string
	local version2AlphaBeta$ as string
	
	//Returns -1 if the first version is lower than the second
	//Returns 0 if both versions are equal
	//Returns 1 if the second version is lower than the first
	if (FindString(version1$, "alpha")) then version1AlphaBeta$ = "alpha"
	if (FindString(version1$, "beta")) then version1AlphaBeta$ = "beta"
	version1$ = ReplaceString(version1$, store$ + " ", "", -1)
	version1$ = ReplaceString(version1$, " ", "", -1)
	version1$ = ReplaceString(version1$, "alpha", ".", -1)
	version1$ = ReplaceString(version1$, "beta", ".", -1)
	if (FindString(version2$, "alpha")) then version2AlphaBeta$ = "alpha"
	if (FindString(version2$, "beta")) then version2AlphaBeta$ = "beta"
	version2$ = ReplaceString(version2$, store$ + " ", "", -1)
	version2$ = ReplaceString(version2$, " ", "", -1)
	version2$ = ReplaceString(version2$, "alpha", ".", -1)
	version2$ = ReplaceString(version2$, "beta", ".", -1)
	if (CountStringTokens(version1$, ".") = 3) then version1$ = version1$ + ".0"
	if (CountStringTokens(version2$, ".") = 3) then version2$ = version2$ + ".0"
	different = 0
	if (val(GetStringToken(version1$, ".", 1)) < val(GetStringToken(version2$, ".", 1)))
		different = -1
	elseif (val(GetStringToken(version1$, ".", 1)) > val(GetStringToken(version2$, ".", 1)))
		different = 1
	elseif (val(GetStringToken(version1$, ".", 2)) < val(GetStringToken(version2$, ".", 2)))
		different = -1
	elseif (val(GetStringToken(version1$, ".", 2)) > val(GetStringToken(version2$, ".", 2)))
		different = 1
	elseif (val(GetStringToken(version1$, ".", 3)) < val(GetStringToken(version2$, ".", 3)))
		different = -1
	elseif (val(GetStringToken(version1$, ".", 3)) > val(GetStringToken(version2$, ".", 3)))
		different = 1
	elseif (val(GetStringToken(version1$, ".", 4)) <> 0 and val(GetStringToken(version2$, ".", 4)) = 0)
		different = -1
	elseif (val(GetStringToken(version1$, ".", 4)) = 0 and val(GetStringToken(version2$, ".", 4)) <> 0)
		different = 1
	elseif (version1AlphaBeta$ = "alpha" and version2AlphaBeta$ = "beta")
		different = -1
	elseif (version1AlphaBeta$ = "beta" and version2AlphaBeta$ = "alpha")
		different = 1
	elseif (val(GetStringToken(version1$, ".", 4)) < val(GetStringToken(version2$, ".", 4)))
		different = -1
	elseif (val(GetStringToken(version1$, ".", 4)) > val(GetStringToken(version2$, ".", 4)))
		different = 1
	endif
endfunction different
