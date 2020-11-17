
#constant true 1
#constant false 0

global blankLock as typeLock
global blankVariable as typeJSONVariables
global jsonData as typeJSONVariables[]
global localVariables as typeJSONVariables[]
if (GetFileExists("localVariables.json")) then localVariables.load("localVariables.json")

local a as integer
local b as integer
local i as integer
local j as integer
local k as integer
local x as integer
local y as integer

global absoluteMaxCopies as integer
global absoluteMaximumDurationRequired as integer
global absoluteMinCopies as integer
global accept20200516TermsAlertHidden as integer : accept20200516TermsAlertHidden = val(GetLocalVariableValue("accept20200516TermsAlertHidden"))
global accountDataReceived as integer
global add1DoubleUpCardAlertHidden as integer : add1DoubleUpCardAlertHidden = val(GetLocalVariableValue("add1DoubleUpCardAlertHidden"))
global add1FreezeCardAlertHidden as integer : add1FreezeCardAlertHidden = val(GetLocalVariableValue("add1FreezeCardAlertHidden"))
global add1RandomYellowCardAlertHidden as integer : add1RandomYellowCardAlertHidden = val(GetLocalVariableValue("add1RandomYellowCardAlertHidden"))
global add1RedCardAlertHidden as integer : add1RedCardAlertHidden = val(GetLocalVariableValue("add1RedCardAlertHidden"))
global add1ResetCardAlertHidden as integer : add1ResetCardAlertHidden = val(GetLocalVariableValue("add1ResetCardAlertHidden"))
global add1StickyCardAlertHidden as integer : add1StickyCardAlertHidden = val(GetLocalVariableValue("add1StickyCardAlertHidden"))
global add1To4RedCardsAlertHidden as integer : add1To4RedCardsAlertHidden = val(GetLocalVariableValue("add1To4RedCardsAlertHidden"))
global add2RedCardsAlertHidden as integer : add2RedCardsAlertHidden = val(GetLocalVariableValue("add2RedCardsAlertHidden"))
global add3RedCardsAlertHidden as integer : add3RedCardsAlertHidden = val(GetLocalVariableValue("add3RedCardsAlertHidden"))
global adsRemoved as integer : adsRemoved = val(GetLocalVariableValue("adsRemoved"))
global alert as typeAlert
global allowCopies as integer
global allowDuplicatesInCombination as integer : allowDuplicatesInCombination = val(GetLocalVariableValue("allowDuplicatesInCombination"))
if (allowDuplicatesInCombination = 0) then allowDuplicatesInCombination = 1
global apiProjects as typeAPIProject[]
global apiProjectCard as typeAPIProjectCard[2]
if (GetFileExists("apiProjects.json")) then apiProjects.load("apiProjects.json")
global autoResetLock as integer
global avatarApproved as integer : avatarApproved = val(GetLocalVariableValue("avatarApproved"))
global avatarChosenImage as integer
global avatarJustUploadedResponse$ as string
global avatarName$ as string : avatarName$ = GetLocalVariableValue("avatarName")
global averageRating# as float
global banned as integer : banned = val(GetLocalVariableValue("banned"))
global bannedAlertHidden as integer : bannedAlertHidden = val(GetLocalVariableValue("bannedAlertHidden"))
global bannerAdsCreated as integer : bannerAdsCreated = 0
global blockUsersAlreadyLocked as integer
global blockUsersWithSpecificRating as integer
global blockUsersWithStatsHidden as integer
global breadcrumbs as integer[]
global botChosen as integer
global botControlled as integer
global botsData as typeBotsData[9]
global btnCancelCard as integer
global btnCardPages as integer[11]
global btnViewCard as integer
global build as integer
global cappedDoubleUpCards as integer : cappedDoubleUpCards = 100
global cappedFreezeCards as integer : cappedFreezeCards = 100
global cappedGoAgainCards as integer : cappedGoAgainCards = 399
global cappedGreenCards as integer : cappedGreenCards = 100
global cappedRedCards as integer : cappedRedCards = 599
global cappedResetCards as integer : cappedResetCards = 100
global cappedStickyCards as integer : cappedStickyCards = 100
global cappedTotalCards as integer : cappedTotalCards = 2594
global cappedYellowCardsEachType as integer : cappedYellowCardsEachType = 299
global cappedYellowCardsTotal as integer : cappedYellowCardsTotal = 1495
global cardAnimationsOn as integer : cardAnimationsOn = val(GetLocalVariableValue("cardAnimationsOn"))
if (cardAnimationsOn = 0) then cardAnimationsOn = 1
global cardChosen as integer
global cardColX# as float[100]
global cardHeight# as float : cardHeight# = 14.2857142857
global cardInfoHidden as integer
global cardPages as integer
global cardPageSelected as integer
global cardReleased as integer
global cardReleasedGroup as integer
global cards as typeCard[3000]
global cardSelected as integer
global cardSpacing# as float
global cardsPageNo as integer
global cardsScrimVisible as integer
global cardSpritesIndex as integer
global cardWidth# as float : cardWidth# = 10
global changingScreen as integer
global checkInFrequencyInSeconds as integer
global checkingConnectionStatus as integer
global checkInsRequired as integer
global colorMode as typeColorMode[10]
global colorModeSelected as integer : colorModeSelected = val(GetLocalVariableValue("colorModeSelected"))
if (colorModeSelected = 0) then colorModeSelected = 1
global combinationType as integer : combinationType = val(GetLocalVariableValue("combinationType"))
if (combinationType = 0) then combinationType = 1
global contactedKeyholder as integer
global contentHeight# as float
global contentHeightChanged as integer
global contentStartX# as float
global contentStartY# as float
global contentWidth# as float
global createCopies as integer
global creatingSharedLock as integer
global cumulative as integer
global daily as integer
global databaseRandomSeed as integer
global dateDeactivatingVersion$ as string
global dateFormat$ as string : dateFormat$ = "D M YYYY"
global dateFromServer$ as string
global dd as integer
global deactivatingVersionAlertHidden as integer : deactivatingVersionAlertHidden = val(GetLocalVariableValue("deactivatingVersionAlertHidden_v" + tmpVersionNumber$))
global debugMode as integer : debugMode = 0
global deck as typeDeck[3000]
global defaultUsername$ as string : defaultUsername$ = GetLocalVariableValue("defaultUsername")
global deletedLockToClone as integer
global deletedMyLockJustRestored as integer
global deletedSharedLockJustRestored as integer
global desertedUserCount as integer
global deviceTimestampOffset as integer : deviceTimestampOffset = val(GetLocalVariableValue("deviceTimestampOffset"))
global developerMode as integer : developerMode = 2
global developerShowCards as integer : developerShowCards = 2
global deviceID$ as string : deviceID$ = Sha512("Chasti" + GetDeviceID() + "Key")
global dialog as integer
global dialogShown$ as string
global disableCreationOfNewLocks as integer
global discardPile as typeDeck[20]
global discordDiscriminator as integer : discordDiscriminator = val(GetLocalVariableValue("discordDiscriminator"))
global discordUsername$ as string : discordUsername$ = GetLocalVariableValue("discordUsername")
global discordID$ as string : discordID$ = GetLocalVariableValue("discordID")
global domain$ as string : domain$ = URLs[0].Domain
global doubleUpCards as integer
global draggingHorizontally as integer
global draggingVertically as integer
global dropDownMenu as typeDropDownMenuItems[19]
global dropDownMenuVisible as integer
global durationMayChangeAlertHidden as integer : durationMayChangeAlertHidden = val(GetLocalVariableValue("durationMayChangeAlertHidden"))
global dX# as float
global dY# as float
global elementY# as float
global emojiChosen as integer
global enableLockDeletions as integer : enableLockDeletions = val(GetLocalVariableValue("enableLockDeletions"))
if (enableLockDeletions = 0) then enableLockDeletions = 2
global encryptUserIDs as integer : encryptUserIDs = 1
global endLockSettingsBlueFont as integer
global endLockSettingsManagedByBlackFont as integer
global endLockSettingsManagedByRedFont as integer
global endLockSettingsRedFont as integer
global endLockSettingsTestLockRedFont as integer
global fakeLockUnlocked as integer
global fakeNoOfCards as integer
global favouriteCount as integer
global favouriteUsers as integer[]
if (GetFileExists("favouriteUsers.json")) then favouriteUsers.load("favouriteUsers.json")
global filterCount as integer
global filterDesertedUsersBy$ as string : filterDesertedUsersBy$ = GetLocalVariableValue("filterDesertedUsersBy")
if (filterDesertedUsersBy$ = "") then filterDesertedUsersBy$ = "FilterDesertedUsersAll"
global filterDesertedUsersByFlag$ as string : filterDesertedUsersByFlag$ = GetLocalVariableValue("filterDesertedUsersByFlag")
if (filterDesertedUsersByFlag$ = "") then filterDesertedUsersByFlag$ = "FilterDesertedUsersFlagAll"
global filterDesertedUsersExcludeTestLocks as integer : filterDesertedUsersExcludeTestLocks = val(GetLocalVariableValue("filterDesertedUsersExcludeTestLocks"))
global filterLockedUsersBy$ as string : filterLockedUsersBy$ = GetLocalVariableValue("filterLockedUsersBy")
if (filterLockedUsersBy$ = "") then filterLockedUsersBy$ = "FilterLockedUsersAll"
global filterLockedUsersByFlag$ as string : filterLockedUsersByFlag$ = GetLocalVariableValue("filterLockedUsersByFlag")
if (filterLockedUsersByFlag$ = "") then filterLockedUsersByFlag$ = "FilterLockedUsersFlagAll"
global filterLockedUsersExcludeTestLocks as integer : filterLockedUsersExcludeTestLocks = val(GetLocalVariableValue("filterLockedUsersExcludeTestLocks"))
global filterLogBy$ as string
global filterMyLocksBy$ as string : filterMyLocksBy$ = GetLocalVariableValue("filterMyLocksBy")
if (filterMyLocksBy$ = "") then filterMyLocksBy$ = "FilterMyLocksAll"
global filterMyLocksByFlag$ as string : filterMyLocksByFlag$ = GetLocalVariableValue("filterMyLocksByFlag")
if (filterMyLocksByFlag$ = "") then filterMyLocksByFlag$ = "FilterMyLocksFlagAll"
global filterSharedLocksBy$ as string : filterSharedLocksBy$ = GetLocalVariableValue("filterSharedLocksBy")
if (filterSharedLocksBy$ = "") then filterSharedLocksBy$ = "FilterSharedLocksAll"
if (filterSharedLocksBy$ = "FilterSharedLocksHasUsersLocked") then filterSharedLocksBy$ = "FilterSharedLocksHasUsersLockedIncludingTest"
global filterUnlockedUsersBy$ as string : filterUnlockedUsersBy$ = GetLocalVariableValue("filterUnlockedUsersBy")
if (filterUnlockedUsersBy$ = "") then filterUnlockedUsersBy$ = "FilterUnlockedUsersAll"
global filterUnlockedUsersByFlag$ as string : filterUnlockedUsersByFlag$ = GetLocalVariableValue("filterUnlockedUsersByFlag")
if (filterUnlockedUsersByFlag$ = "") then filterUnlockedUsersByFlag$ = "FilterUnlockedUsersFlagAll"
global filterUnlockedUsersExcludeTestLocks as integer : filterUnlockedUsersExcludeTestLocks = val(GetLocalVariableValue("filterUnlockedUsersExcludeTestLocks"))
global filterUsersBy$ as string : filterUsersBy$ = "FilterAll"
global filterUsersLogBy$ as string
global fixed as integer
global flippedCardID as integer
global forceTrust as integer
global fps as integer : fps = val(GetLocalVariableValue("fps"))
if (fps = 0) then fps = 60
global freeAdsRemovalAvailable as integer
global freeKeysAvailable as integer
global freezeCards as integer
global freezeLockAlertHidden as integer : freezeLockAlertHidden = val(GetLocalVariableValue("freezeLockAlertHidden"))
global fullCardHeight# as float
global functionQueue$ as string[20, 2]
global generatedCombination$ as string
global generatedLocks as typeGeneratedLocks[]
global generatedLocksCard as typeGeneratedLocksCard[20]
global generatedLockSelected as integer
global generatedLocksSorted as typeGeneratedLocks[]
global greenPile as typeDeck[30]
global hh as integer
global hiddenFromOwner as integer
global hideCardInfoAlertHidden as integer : hideCardInfoAlertHidden = val(GetLocalVariableValue("hideCardInfoAlertHidden"))
global hideReviewBoxForever as integer : hideReviewBoxForever = val(GetLocalVariableValue("hideReviewBoxForever"))
global hideTimerAlertHidden as integer : hideTimerAlertHidden = val(GetLocalVariableValue("hideTimerAlertHidden"))
global holdingDownRangeButton as integer
global httpsQueue as integer
global httpResponse2$ as string
global inputSpinner1Min as integer
global inputSpinner1Max as integer
global inputSpinner2Min as integer
global inputSpinner2Max as integer
global itemCount as integer
global iterationOffset as integer
global keepLockGeneratorSettings as integer
global keyDisabled as integer
global keyholder as integer
global keyholderDecisionDisabled as integer
global keyholderDisabledKey as integer
global keyholderID as integer
global keyholderLastActive as integer
global keyholderLevel as integer
global keyholderRating# as float
global keyholderStatus as integer
global keyholderUsername$ as string
global kikUsername$ as string
global language$ as string : language$ = GetLocalVariableValue("language")
if (language$ = "") then language$ = "en"
global largeCard as typeCard
global largeCardDepth as integer
global largeCardVisible as integer
global largestDeckSize as integer
global lastCardDepth as integer
global lastCombinationLength as integer : lastCombinationLength = 0
global lastDeviceHeight# as float : lastDeviceHeight# = 0
global lastFilterCount as integer
global lastFrameUnixTime as integer
global lastLockID as integer
global lastLockGroupID as integer
global lastNewsIDDownloaded as integer
global lastNewsIDSeen as integer : lastNewsIDSeen = val(GetLocalVariableValue("lastNewsIDSeen"))
global lastScreenViewed as integer
global lastScreenViewY# as float
global lateCheckInWindowInSeconds as integer
global limitUsers as integer
global listConnectDiscord as integer
global listConnectTwitter as integer
global listItemHeight# as float
global loadingSharedLock as integer
global lockButtonSelected as integer
global lockCard as typeLockCard[10]
global lockDeletedCard as typeLockDeletedCard[20]
global lockedUserCount as integer
global lockedUsers as integer
global lockeeLevel as integer
global lockGroupID as integer
global lockID as integer
global lockIDSelected as integer
global lockInView as integer
global lockJustCreated as integer
global lockLogSorted as typeLog[]
global lockNo as integer
global lockNoUpdated as integer
global lockOptions as typeLockOptions[40]
global lockRating# as float
global locks as typeLock[20]
global locksDeleted as typeLockDeleted
global locksSavedInDB as integer
global lockSelected as integer
global locksSorted as typeLock[20]
global lockUpdates as typeLockUpdates[20]
global lockUpdatesDialogMessage$ as string
global lockUpdatesDialogTitle$ as string
global logoutAlertHidden as integer : logoutAlertHidden = val(GetLocalVariableValue("logoutAlertHidden"))
global mainRoleColour as integer
global mainRoleLevel$ as string
global mainRoleSelected as integer : mainRoleSelected = val(GetLocalVariableValue("mainRoleSelected"))
if (mainRoleSelected = 0) then mainRoleSelected = 2
global maintenance as integer
global maxAutoResets as integer
global maxCopies as integer
global maxDoubleUps as integer
global maxFreezes as integer
global maxGoAgainPercentage# as float : maxGoAgainPercentage# = 10
global maxGreens as integer
global maxListItemCount as integer
global maxMinutes as integer
global maxNoOfCardRows# as float : maxNoOfCardRows# = 15
global maxReds as integer
global maxResets as integer
global maxScrollY# as float
global maxStickies as integer
global maxUsers as integer
global maxYellowsAdd as integer
global maxYellowsAdd1 as integer
global maxYellowsAdd2 as integer
global maxYellowsAdd3 as integer
global maxYellowsMinus as integer
global maxYellowsMinus1 as integer
global maxYellowsMinus2 as integer
global maxYellowsRandom as integer
global menuHeight# as float
global menuItems as typeMenuItems[99]
global menuOffsetY# as float
global menuOpen as integer
global minCopies as integer
global minDoubleUps as integer
global minFreezes as integer
global minGoAgainPercentage# as float : minGoAgainPercentage# = 1
global minGreens as integer
global minimumReds as integer
global minMinutes as integer
global minRatingRequired as integer
global minReds as integer
global minResets as integer
global minStickies as integer
global minVersionRequired$ as string
global minYellowsAdd as integer
global minYellowsAdd1 as integer
global minYellowsAdd2 as integer
global minYellowsAdd3 as integer
global minYellowsMinus as integer
global minYellowsMinus1 as integer
global minYellowsMinus2 as integer
global minYellowsRandom as integer
global mm as integer
global multipleGreensRequired as integer
global navigationDrawer as integer
global newAPIProject as typeAPIProject
global newFixedLockAlertHidden as integer : newFixedLockAlertHidden = val(GetLocalVariableValue("newFixedLockAlertHidden"))
global newLockName$ as string
global newsItems as typeNews[99]
global newUsername$ as string
global newVariableLockAlertHidden as integer : newVariableLockAlertHidden = val(GetLocalVariableValue("newVariableLockAlertHidden"))
global newViewX# as float
global noInternet as integer
global noOfCards as integer
global noOfCardCols as integer
global noOfCardColsPerScreen# as float : noOfCardColsPerScreen# = 4
global noOfCardRows as integer
global noOfCardScreens# as float
global noOfCardSprites as integer : noOfCardSprites = 75
global noOfChances as integer
global noOfCopies as integer
global noOfDigits as integer : noOfDigits = val(GetLocalVariableValue("noOfDigits"))
if (noOfDigits <= 0) then noOfDigits = 4
global noOfDiscardPileSprites as integer : noOfDiscardPileSprites = 20
global noOfGeneratedLocks as integer
global noOfGreenPileSprites as integer : noOfGreenPileSprites = 30
global noOfKeyholderRatings as integer
global noOfKeys as integer : noOfKeys = val(GetLocalVariableValue("noOfKeys"))
global noOfKeysPurchased as integer : noOfKeysPurchased = val(GetLocalVariableValue("noOfKeysPurchased"))
global noOfKeysRequired as integer
global noOfLockRatings as integer
global noOfLocks as integer : noOfLocks = val(GetLocalVariableValue("noOfLocks"))
global noOfLocksAutoReset as integer
global noOfLocksControlledByKeyholder as integer
global noOfLocksModified as integer : noOfLocksModified = val(GetLocalVariableValue("noOfLocksModified"))
global noOfLocksNaturallyUnlocked as integer : noOfLocksNaturallyUnlocked = val(GetLocalVariableValue("noOfLocksNaturallyUnlocked"))
global noOfLockUpdatesAvailable as integer
global noOfNewsItems as integer
global noOfRatings as integer
global noOfServerCallsQueued as integer
global noOfServerUploadsQueued as integer
global noOfSharedLocks as integer
global notificationsOn as integer : notificationsOn = val(GetLocalVariableValue("notificationsOn"))
if (notificationsOn = 0) then notificationsOn = 1
global offline as integer
global offlineModeStartTime as integer
global offsetX# as float
global offsetY# as float
global othersFriends as typeFriendsLists
global permanent as integer
global previousBreadcrumb as integer
global privateProfile as integer : privateProfile = val(GetLocalVariableValue("privateProfile"))
global proAccount as integer : proAccount = val(GetLocalVariableValue("proAccount"))
global profileData as typeProfileData
global profileID as integer
global pushNotificationResult as integer
global pushNotificationToken$ as string
global randomCombination as typeCombination[99]
global randomCombinationAudioOn as integer : randomCombinationAudioOn = val(GetLocalVariableValue("randomCombinationAudioOn"))
global reasonBanned$ as string : reasonBanned$ = GetLocalVariableValue("reasonBanned")
global redrawScreen as integer
global regularity# as float
global repositionItemsInCard as integer
global requireDM as integer
global resetCards as integer
global resetFrequencyInSeconds as integer
global resetOptions as integer : resetOptions = 0
global responseCode as integer
global restoreUserID$ as string
global resumed as integer
global roleColours as typeRoleColours
global sandboxMode as integer
global saveToCloud as integer : saveToCloud = val(GetLocalVariableValue("saveToCloud"))
if (saveToCloud = 0 or GetCloudDataVariable(lower(constAppName$) + ".userID", "") = "") then saveToCloud = 2
global saveYourUserIDAlertHidden as integer : saveYourUserIDAlertHidden = val(GetLocalVariableValue("saveYourUserIDAlertHidden"))
global screen as typeScreen[100]
global screenBoundsTop# as float : screenBoundsTop# = GetScreenBoundsTop()
global screenNo as integer
global screenToView as integer
global screenToViewY# as float
global scrollStartX# as float
global scrollStartY# as float
global secondsLeft as integer
global secondsLocked as integer
global secondsRunning as integer
global selectedLockOptionsTab as integer
if (selectedLockOptionsTab = 0) then selectedLockOptionsTab = 1
global selectedLocksTab as integer : selectedLocksTab = val(GetLocalVariableValue("selectedLocksTab"))
if (selectedLocksTab = 0) then selectedLocksTab = 1
global selectedManageUsersTab as integer : selectedManageUsersTab = val(GetLocalVariableValue("selectedManageUsersTab"))
if (selectedManageUsersTab = 0) then selectedManageUsersTab = 1
global selectedNewLockTab as integer : selectedNewLockTab = 1
global settingOptions as typeSettingOptions[40]
global sharedID$ as string
global shareInAPI as integer
global sharedLockCard as typeSharedLockCard[10]
global sharedLockError$ as string
global sharedLockInfo$ as string
global sharedLockJustCreated as integer
global sharedLockName$ as string
global sharedLockNo as integer
global sharedLockParameters$ as string
global sharedLocks as typeSharedLocks[200, 4]
global sharedLockSelected as integer
global sharedLocksSearchString$ as string
global sharedLocksSorted as typeSharedLocks[200]
global sharedLockUsersSorted as typeUsersSorted[200]
global shareID$ as string
global showCombinationsToKeyholders as integer : showCombinationsToKeyholders = val(GetLocalVariableValue("showCombinationsToKeyholders"))
if (showCombinationsToKeyholders = 2) then showCombinationsToKeyholders = 0
global showLoadingWheelUntilQueueCleared as integer
global shownDialog as integer
global showPleaseWaitWheel as integer
global showTargetedAds as integer : showTargetedAds = val(GetLocalVariableValue("showTargetedAds"))
if (showTargetedAds = 0) then showTargetedAds = 2
global shuffledCardSprites as integer[]
global shuffledDeck as integer[3000]
global shuffleDeckAfterTweens as integer
global showAPIProject as integer
global simulationAverageMinutesLocked as integer
global simulationAverageNoOfCardsDrawn as integer
global simulationAverageNoOfLockResets as integer
global simulationAverageNoOfTurns as integer
global simulationBestCaseMinutesLocked as integer
global simulationBestCaseNoOfCardsDrawn as integer
global simulationBestCaseNoOfLockResets as integer
global simulationBestCaseNoOfTurns as integer
global simulationCount as integer
global simulationDeck$ as string[]
global simulationInitialDoubleUps as integer
global simulationInitialFreezes as integer
global simulationInitialGreens as integer
global simulationInitialReds as integer
global simulationInitialResets as integer
global simulationInitialStickies as integer
global simulationInitialYellowsAdd1 as integer
global simulationInitialYellowsAdd2 as integer
global simulationInitialYellowsAdd3 as integer
global simulationInitialYellowsMinus1 as integer
global simulationInitialYellowsMinus2 as integer
global simulationMinimumRedCards as integer	
global simulationMinutesLocked as integer
global simulationMultipleGreensRequired as integer
global simulationNoOfCardsDrawn as integer
global simulationNoOfDoubleUps as integer
global simulationNoOfFreezes as integer
global simulationNoOfGreens as integer
global simulationNoOfLockResets as integer
global simulationNoOfReds as integer
global simulationNoOfResets as integer
global simulationNoOfStickies as integer
global simulationNoOfTurns as integer
global simulationNoOfYellows as integer
global simulationNoOfYellowsAdd1 as integer
global simulationNoOfYellowsAdd2 as integer
global simulationNoOfYellowsAdd3 as integer
global simulationNoOfYellowsMinus1 as integer
global simulationNoOfYellowsMinus2 as integer
global simulationSecondsLocked as integer
global simulationsToTry as integer : simulationsToTry = 100
global simulationWorstCaseMinutesLocked as integer
global simulationWorstCaseNoOfCardsDrawn as integer
global simulationWorstCaseNoOfLockResets as integer
global simulationWorstCaseNoOfTurns as integer
global singleLogRow as typeLog
global sortDesertedUsersBy$ as string : sortDesertedUsersBy$ = GetLocalVariableValue("sortDesertedUsersBy")
if (sortDesertedUsersBy$ = "") then sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted"
if (sortDesertedUsersBy$ = "SortDesertedUsersByRandom") then sortDesertedUsersBy$ = "SortDesertedUsersByDateDeleted"
global sortDesertedUsersOrder$ as string : sortDesertedUsersOrder$ = GetLocalVariableValue("sortDesertedUsersOrder")
if (sortDesertedUsersOrder$ = "") then sortDesertedUsersOrder$ = "DESC"
global sortedIteration as integer
global sortLockedUsersBy$ as string : sortLockedUsersBy$ = GetLocalVariableValue("sortLockedUsersBy")
if (sortLockedUsersBy$ = "") then sortLockedUsersBy$ = "SortLockedUsersByRandom"
global sortLockedUsersOrder$ as string : sortLockedUsersOrder$ = GetLocalVariableValue("sortLockedUsersOrder")
if (sortLockedUsersOrder$ = "") then sortLockedUsersOrder$ = "DESC"
global sortLockGeneratorBy$ as string : sortLockGeneratorBy$ = GetLocalVariableValue("sortLockGeneratorBy")
if (sortLockGeneratorBy$ = "") then sortLockGeneratorBy$ = "SortLockGeneratorByTime"
global sortLockGeneratorOrder$ as string : sortLockGeneratorOrder$ = GetLocalVariableValue("sortLockGeneratorOrder")
if (sortLockGeneratorOrder$ = "") then sortLockGeneratorOrder$ = "ASC"
global sortLogBy$ as string : sortLogBy$ = GetLocalVariableValue("sortLogBy")
if (sortLogBy$ = "") then sortLogBy$ = "SortLogByTime"
global sortLogOrder$ as string : sortLogOrder$ = GetLocalVariableValue("sortLogOrder")
if (sortLogOrder$ = "") then sortLogOrder$ = "ASC"
global sortMyLocksBy$ as string : sortMyLocksBy$ = GetLocalVariableValue("sortMyLocksBy")
if (sortMyLocksBy$ = "") then sortMyLocksBy$ = "SortMyLocksByTimeLeft"
global sortMyLocksOrder$ as string : sortMyLocksOrder$ = GetLocalVariableValue("sortMyLocksOrder")
if (sortMyLocksOrder$ = "") then sortMyLocksOrder$ = "ASC"
global sortSharedLocksBy$ as string : sortSharedLocksBy$ = GetLocalVariableValue("sortSharedLocksBy")
if (sortSharedLocksBy$ = "") then sortSharedLocksBy$ = "SortSharedLocksByCreated"
global sortSharedLocksOrder$ as string : sortSharedLocksOrder$ = GetLocalVariableValue("sortSharedLocksOrder")
if (sortSharedLocksOrder$ = "") then sortSharedLocksOrder$ = "DESC"
global sortUnlockedUsersBy$ as string : sortUnlockedUsersBy$ = GetLocalVariableValue("sortUnlockedUsersBy")
if (sortUnlockedUsersBy$ = "") then sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked"
if (sortUnlockedUsersBy$ = "SortUnlockedUsersByRandom") then sortUnlockedUsersBy$ = "SortUnlockedUsersByDateUnlocked"
global sortUnlockedUsersOrder$ as string : sortUnlockedUsersOrder$ = GetLocalVariableValue("sortUnlockedUsersOrder")
if (sortUnlockedUsersOrder$ = "") then sortUnlockedUsersOrder$ = "DESC"
global sortUsersLogBy$ as string : sortUsersLogBy$ = GetLocalVariableValue("sortUsersLogBy")
if (sortUsersLogBy$ = "") then sortUsersLogBy$ = "SortUsersLogByTime"
global sortUsersLogOrder$ as string : sortUsersLogOrder$ = GetLocalVariableValue("sortUsersLogOrder")
if (sortUsersLogOrder$ = "") then sortUsersLogOrder$ = "ASC"
global sprBlackOverlay as integer
global sprCam as integer
global sprCancelCardButton as integer
global sprCardsScrim as integer
global sprDropDownMenuOverlay as integer
global sprEmailIcon as integer
global sprFacebookIcon as integer
global sprFlagButton as integer[10]
global sprFlagIcon as integer[10]
global sprFlagsMenuOverlay as integer
global spriteHit as integer
global sprLoadBar as integer
global sprLoadBarBackground as integer
global sprMenuBackground as integer
global sprMenuBlackOverlay as integer
global sprScrollBar as integer
global sprScrollToTopButton as integer
global sprServerCall as integer
global sprServerUpload as integer
global sprTooltip as integer
global sprTumblrIcon as integer
global sprTwitterIcon as integer
global sprViewCardButton as integer
global ss as integer
global ssl as integer : ssl = 1
global startListY# as float
global startLockFrozen as integer
global startLockSettingsBlueFont as integer
global startLockSettingsManagedByBlackFont as integer
global startLockSettingsManagedByRedFont as integer
global startLockSettingsRedFont as integer
global startLockSettingsTestLockRedFont as integer
global startScrollBarY# as float
global startTime# as float
global startX# as float
global statusBarHeight# as float : statusBarHeight# = (50.0 / GetDeviceHeight()) * 100.0
if (GetDeviceBaseName() <> "ios") then statusBarHeight# = 0
global statusSelected as integer : statusSelected = val(GetLocalVariableValue("statusSelected"))
if (statusSelected = 0) then statusSelected = 1
global stickyCards as integer
global store$ as string
global stringForCopyButton$ as string
global temporarilyDisabled as integer
global testLock as integer
global theme as typeTheme[20]
global themeDark as typeTheme[20]
global themeLight as typeTheme[20]
global themeSelected as integer : themeSelected = val(GetLocalVariableValue("themeSelected"))
if (themeSelected = 0) then themeSelected = 2
global timerHidden as integer
global timesReviewBoxShown as integer : timesReviewBoxShown = val(GetLocalVariableValue("timesReviewBoxShown"))
global timestampFromDevice as integer
global timestampFromServer as integer
global timestampLastModifiedLock as integer
global timestampLastReceivedUpdateResponse as integer
global timestampLastUnlocked as integer
global timestampNow as integer
global timeUntilNextPushRequest as integer	
global tooltip as integer
global tooltipTextForAfterScreenRefresh$ as string
global touchTime# as float
global trackBarHeight# as float
global trackHeightReduction# as float
global trustKeyholder as integer
global tweenBlackOverlay as integer
global tweenScroll as integer
global tweenScrollBar as integer
global tweenScrollCardsScreen as integer
global tweenSprite as integer
global tweensRunning as integer
global twitterHandle$ as string : twitterHandle$ = GetLocalVariableValue("twitterHandle")
global txtPrivacy as integer
global txtTerms as integer
global txtTooltip as integer
global txtViewCard as integer
global unlockedUserCount as integer
global updateUser as typeUpdateUser
global urlRestoreUserID1$ as string
global urlRestoreUserID2$ as string
global urlUserID1$ as string
global urlUserID2$ as string
global usedNotificationIDs as integer[50]
global userCard as typeUserCard[10]
global userDBRow as integer : userDBRow = val(GetLocalVariableValue("userDBRow"))
global userID$ as string : userID$ = GetLocalVariableValue("userID")
global username$ as string : username$ = GetLocalVariableValue("username")
global usernameColor as integer[4]
global usernameError as integer
global usernameFree as integer
global userNo as integer
global userPages as typeUserPages[11]
global userSelected as integer
global usersFlag1 as integer[]
if (GetFileExists("usersFlag1.json")) then usersFlag1.load("usersFlag1.json")
global usersFlag2 as integer[]
if (GetFileExists("usersFlag2.json")) then usersFlag2.load("usersFlag2.json")
global usersFlag3 as integer[]
if (GetFileExists("usersFlag3.json")) then usersFlag3.load("usersFlag3.json")
global usersFlag4 as integer[]
if (GetFileExists("usersFlag4.json")) then usersFlag4.load("usersFlag4.json")
global usersFlag5 as integer[]
if (GetFileExists("usersFlag5.json")) then usersFlag5.load("usersFlag5.json")
global usersFlag6 as integer[]
if (GetFileExists("usersFlag6.json")) then usersFlag6.load("usersFlag6.json")
global usersFlag7 as integer[]
if (GetFileExists("usersFlag7.json")) then usersFlag7.load("usersFlag7.json")
global usersLogSorted as typeLog[]
global usersPageNo as integer : usersPageNo = 1
global usersTab as integer
global version$ as string
global viewingProfileID as integer
global viewX# as float
global viewY# as float
global visibleInPublicStats as integer : visibleInPublicStats = val(GetLocalVariableValue("visibleInPublicStats"))
if (visibleInPublicStats = 2) then visibleInPublicStats = 0
global yellowCards as integer
global yourFriends as typeFriendsLists

