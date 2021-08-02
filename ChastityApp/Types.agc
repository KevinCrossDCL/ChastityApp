
type typeAlert
	blackOverlay as integer
	buttonPressed$ as string
	buttonsKey$ as string[9]
	buttonWidth# as float
	checkboxOn as integer
	linkURLs$ as string[9]
	messageHeight# as float
	noOfButtons as integer
	noOfLinks as integer
	showCheckbox as integer
	showLinks as integer
	sprBottom as integer
	sprButtons as integer[9]
	sprButtonsPanel as integer
	sprCheckbox as integer
	sprLinksPanel as integer
	sprMessage as integer
	sprTitle as integer
	sprTop as integer
	titleHeight# as float
	txtButtons as integer[9]
	txtLinks as integer[9]
	txtMessage as integer
	txtTitle as integer
endtype

type typeAPIProject
	clientID$ as string
	clientSecret$ as string
	banned as integer
	bot as integer
	desktopApp as integer
	dontKnow as integer
	lastCalled as integer
	lockBox as integer
	mobileApp as integer
	name$ as string
	resetsIn as integer
	somethingElse as integer
	tokens as integer
	tokensPerMinute as integer
	totalRequestsMade as integer
	website as integer
endtype

type typeAPIProjectCard
	dialog as integer
	iteration as integer
	sprBackground as integer
	sprButtonBar as integer
	sprEditButton as integer
	sprEditIcon as integer
	sprLeftEmptyButton as integer
	sprRightEmptyButton as integer
	txtBanned as integer
	txtClientID as integer
	txtLastCalled as integer
	txtName as integer
	txtResetsIn as integer
	txtTokens as integer
	txtTokensPerMinute as integer
	txtTotalRequestsMade as integer
endtype

type typeBotsData
	keyholderLevel as integer
	lockedCount as integer
	phrase$ as string
	rating# as float
	noOfRatings as integer
	totalManaged as integer
endtype	

type typeCard
	cardFlipTime# as float
	id as integer
	originalDepth as float
	originalHeight# as float
	originalWidth# as float
	originalX# as float
	originalY# as float
	sprite as integer
	txtBottom as integer
	txtCenter as integer
	txtTop as integer
	tweenCustom as integer[19]
	tweenCustomChain as integer
	tweenSprite as integer[19]
	tweenSpriteChain as integer
	tweenSpriteChainDuration# as float
	tweenSpriteChainStartTime# as float
	tweenText as integer[19]
	tweenTextChain as integer
	value$ as string
endtype

type typeColorMode
	backgroundColor as integer
	barColor as integer
	barIconColor as integer
	dialogBackgroundColor as integer
	dialogButtonColor as integer
	menuColor as integer
	navigationDrawerColor as integer
	navigationDrawerOptionActiveOverlayColor as integer
	navigationDrawerStatusBarColor as integer
	navigationDrawerSubtitleColor as integer
	pageColor as integer
	selectedButtonColor as integer
	tabs as integer
	textColor as integer
	textfieldColor as integer
	textfieldStrokeColor as integer
	topBar as integer
	unselectedButtonColor as integer
	urlColor as integer
endtype

type typeCombination
	txtCombination as integer[99]
	timeToDestroy as integer[99]
	timeToStart as integer[99]
endtype

type typeDeck
	angle# as float
	id as integer
	picked as integer
	sprite as integer
	value$ as string
endtype

type typeDropDownMenuItems
	itemTag$ as string
	selected as integer
	imageTags$ as string[9]
	itemType$ as string
	sprBackground as integer
	sprButtons as integer[9]
	sprIcons as integer[9]
	sprSelected as integer
	txtButtons as integer[9]
	txtItem as integer
endtype

type typeFriend
	sortKey$ as string
	discordID$ as string
	id as integer
	iteration as integer
	jsonCount as integer
	jsonNo as integer
	keyholderLevel as integer
	lockeeLevel as integer
	mainRole as integer
	onlineStatus as integer
	relationStatus as integer
	timestampLastActive as integer
	twitterHandle$ as string
	username$ as string
endtype
	
type typeFriendsLists
	blockedByOthers as typeFriend[0]
	blockedByOthersDelimitedIDs$ as string
	blockedByOthersSorted as typeFriend[0]
	blockedByYou as typeFriend[0]
	blockedByYouDelimitedIDs$ as string
	blockedByYouSorted as typeFriend[0]
	followers as typeFriend[0]
	followersDelimitedIDs$ as string
	followersSorted as typeFriend[0]
	following as typeFriend[0]
	followingDelimitedIDs$ as string
	followingSorted as typeFriend[0]
	pendingByOthers as typeFriend[0]
	pendingByOthersDelimitedIDs$ as string
	pendingByOthersSorted as typeFriend[0]
	pendingByYou as typeFriend[0]
	pendingByYouDelimitedIDs$ as string
	pendingByYouSorted as typeFriend[0]
endtype

type typeGeneratedLocks
	sortKey$ as string
	build as integer
	id as integer
	level as integer
	maxRandomDoubleUps as integer
	maxRandomFreezes as integer
	maxRandomGreens as integer
	maxRandomReds as integer
	maxRandomResets as integer
	maxRandomStickies as integer
	maxRandomYellows as integer
	maxRandomYellowsAdd as integer
	maxRandomYellowsMinus as integer
	minRandomDoubleUps as integer
	minRandomFreezes as integer
	minRandomGreens as integer
	minRandomReds as integer
	minRandomResets as integer
	minRandomStickies as integer
	minRandomYellows as integer
	minRandomYellowsAdd as integer
	minRandomYellowsMinus as integer
	minVersionRequired$ as string
	multipleGreensRequired as integer
	noOfMatches as integer
	regularity# as float
	simulationAverageMinutesLocked as integer 
	simulationBestCaseMinutesLocked as integer    
	simulationWorstCaseMinutesLocked as integer  
	version$ as string
endtype

type typeGeneratedLocksCard
	dialog as integer
	iteration as integer
	rightButton as integer
	sprBackground as integer
	sprCols as integer[3]
	txtColHeaders as integer[3]
	txtColValues as integer[3] 
	txtConfig as integer
	txtID as integer
	txtOptions as integer
endtype

type typeJSONVariables
	variable as string
	value as string
endtype

type typeLastXUpdates
	timestampUpdated as integer
	update$ as string
endtype

type typeLock
	sortKey$ as string
	autoResetsPaused as integer
	blockBotFromUnlocking as integer
	blockUsersAlreadyLocked as integer
	botChosen as integer
	build as integer
	cardInfoHidden as integer
	chancesAccumulatedBeforeFreeze as integer
	checkInFrequencyInSeconds as integer
	checkingForUpdates as integer
	combination$ as string
	cumulative as integer
	dateDeleted$ as string
	dateLastPicked$ as string
	dateLocked$ as string
	dateUnlocked$ as string
	deleting as integer
	deleted as integer
	discardPile$ as string
	displayInStats as integer
	doubleUpCards as integer
	doubleUpCardsAdded as integer
	doubleUpCardsPicked as integer
	emojiChosen as integer
	emojiColourSelected as integer
	fake as integer
	filterIn as integer
	fixed as integer
	flagChosen as integer
	freezeCards as integer
	freezeCardsAdded as integer
	goAgainCards as integer
	goAgainCardsPercentage# as float
	greenCards as integer
	greensPickedSinceReset as integer
	groupID as integer
	hiddenFromOwner as integer
	hiddenFromOwnerAlertHidden as integer
	hideGreensUntilPickCount as integer
	id as integer
	initialDoubleUpCards as integer
	initialFreezeCards as integer
	initialGreenCards as integer
//~	initialMaximumDoubleUpCards as integer
//~	initialMaximumFreezeCards as integer
//~	initialMaximumGreenCards as integer
//~	initialMaximumMinutes as integer
//~	initialMaximumRedCards as integer
//~	initialMaximumResetCards as integer
//~	initialMaximumStickyCards as integer
//~	initialMaximumYellowAddCards as integer
//~	initialMaximumYellowMinusCards as integer
//~	initialMaximumYellowRandomCards as integer
//~	initialMinimumDoubleUpCards as integer
//~	initialMinimumFreezeCards as integer
//~	initialMinimumGreenCards as integer
//~	initialMinimumMinutes as integer
//~	initialMinimumRedCards as integer
//~	initialMinimumResetCards as integer
//~	initialMinimumStickyCards as integer
//~	initialMinimumYellowAddCards as integer
//~	initialMinimumYellowMinusCards as integer
//~	initialMinimumYellowRandomCards as integer
	initialMinutes as integer
	initialRedCards as integer
	initialResetCards as integer
	initialStickyCards as integer
	initialYellowAdd1Cards as integer
	initialYellowAdd2Cards as integer
	initialYellowAdd3Cards as integer
	initialYellowCards as integer
	initialYellowMinus1Cards as integer
	initialYellowMinus2Cards as integer
	iteration as integer
	justUnlocked as integer
	keyDisabled as integer
	keyholderAllowsFreeUnlock as integer
	keyholderBuildNumberInstalled as integer
	keyholderDecisionDisabled as integer
	keyholderDisabledKey as integer
	keyholderEmojiChosen as integer
	keyholderEmojiColourSelected as integer
	keyholderID as integer
	keyholderLastActive as integer
	keyholderMainRole as integer
	keyholderMainRoleLevel as integer
	keyholderStatus as integer
	keyholderUsername$ as string
	keyUsed as integer
	lastUpdateIDSeen as integer
	lastXUpdates as typeLastXUpdates[5]
	lateCheckInWindowInSeconds as integer
	lockFrozenByCard as integer
	lockFrozenByKeyholder as integer
	//lockFrozenByLockee as integer
	lockLog as typeLog[]
	lockName$ as string
	maximumAutoResets as integer
	maximumMinutes as integer
	maximumRedCards as integer
	minimumMinutes as integer
	minimumRedCards as integer
	minutes as integer
	minutesAdded as integer
	multipleGreensRequired as integer
	noOfAdd1Cards as integer
	noOfAdd2Cards as integer
	noOfAdd3Cards as integer
	noOfKeysRequired as integer
	noOfMinus1Cards as integer
	noOfMinus2Cards as integer
	noOfTimesAutoReset as integer
	noOfTimesCardReset as integer
	noOfTimesFullReset as integer
	noOfTimesGreenCardRevealed as integer
	noOfTimesReset as integer
	notificationID as integer
	notificationTimestamp as integer
	percentageTimer as integer
	permanent as integer
	pickedCount as integer
	pickedCountIncludingYellows as integer
	pickedCountSinceReset as integer
	randomCardsAdded as integer
	rating as integer
	readyToPick as integer
	readyToUnlock as integer
	redCards as integer
	redCardsAdded as integer
	regularity# as float
	removedByKeyholder as integer
	removedByKeyholderAlertHidden
	resetCards as integer
	resetCardsAdded as integer
	resetCardsPicked as integer
	resetFrequencyInSeconds as integer
	ribbonType$ as string
	rowInDB as integer
	sharedID$ as string
	simulationAverageMinutesLocked as integer
	simulationBestCaseMinutesLocked as integer
	simulationWorstCaseMinutesLocked as integer
	stickyCards as integer
	test as integer
	timeLeftUntilNextChanceBeforeFreeze as integer
	timerHidden as integer
	timestampCleanTimeRequestBlockedUntil as integer
	timestampDeleted as integer
	timestampDeniedCleanTime as integer
	timestampEndedCleanTime as integer
	timestampFrozenByCard as integer
	timestampFrozenByKeyholder as integer
	//timestampFrozenByLockee as integer
	timestampHiddenFromOwner as integer
	timestampKeyholderRated as integer
	timestampLastAutoReset as integer
	timestampLastCardReset as integer
	timestampLastCheckedIn as integer
	timestampLastCheckedUpdates as integer
	timestampLastFullReset as integer
	timestampLastPicked as integer
	timestampLastReset as integer
	timestampLastSynced as integer
	timestampLastUpdated as integer
	timestampLocked as integer
	timestampRated as integer
	timestampRealLastPicked as integer
	timestampRemovedByKeyholder as integer
	timestampRequestedCleanTime as integer
	timestampRequestedKeyholdersDecision as integer
	timestampRibbonAdded as integer
	timestampStartedCleanTime as integer
	timestampUnfreezes as integer
	timestampUnfrozen as integer
	timestampUnlocked as integer
	totalTimeCleaning as integer
	totalTimeFrozen as integer
	trustKeyholder as integer
	unlocked as integer
	version$ as string
	yellowCards as integer
endtype

type typeLockCard
	dialog as integer
	flagButtonGroup as integer
	iteration as integer
	rightButtonGroup as integer
	shaderArc as integer[5]
	shaderCooldown as integer
	shaderChanceArc as integer[8]
	sprAdd1To4 as integer
	sprAddTimeButton as integer
	sprArc as integer[5]
	sprBackground as integer
	sprButtonBar as integer
	sprChanceArc as integer[8]
	sprCheckInButton as integer
	sprCheckInCooldown as integer
	sprCheckInIcon as integer
	sprCircle as integer[5]
	sprCircleSecretSticker as integer[5]
	sprCleanButton as integer
	sprCleanIcon as integer
	sprCleanIconOverlay as integer
	sprDeleteButton as integer
	sprDeleteIcon as integer
	sprDeletingBackground as integer
	sprEmptyLeftButton as integer
	sprEmptyRightButton as integer
	sprFlagButton as integer
	sprFlagIcon as integer
	sprIceCapArch as integer[5]
	sprInfoButton as integer
	sprInfoIcon as integer
	sprKeyholderEmojiIcon as integer
	sprMoodBackground as integer
	sprMoodButton as integer
	sprMoodIcon as integer
	sprMoreButton as integer
	sprMoreIcon as integer
	sprOverlay as integer
	sprRatingStar as integer[6]
	sprRestartButton as integer
	sprRestartIcon as integer
	sprRibbon as integer
	sprScrim as integer
	sprSyncStatus as integer
	sprUnlockButton as integer
	sprUnlockIcon as integer
	sprUsernameButton as integer
	stickerAngle as integer
	txtAdd1To4 as integer
	txtCircle as integer[5]
	txtCircleFooter as integer[5]
	txtCircleHeader as integer[5]
	txtCirclePercentage as integer[5]
	txtCleanButton as integer
	txtCombination as integer
	txtCombinationHeader as integer
	txtDeleteButton as integer
	txtDeleting as integer
	txtFooter as integer
	txtGreaterThanSign as integer
	txtGroupID as integer
	txtInfoButton as integer
	txtLockName as integer
	txtMoodButton as integer
	txtMoreButton as integer
	txtNextChanceInHeader as integer
	txtRateKeyholder as integer
	txtTapToUnlock as integer
	txtTapToUnlockFooter as integer
	txtTimeLocked as integer
	txtTimeLockedFooter as integer
	txtTimeLockedHeader as integer
	txtTimerHidden as integer
	txtTimerHiddenFooter as integer
	txtUnlockButton as integer
	txtUnlocksInHeader as integer
endtype

type typeLockDeleted
	myLocks as typeLock[0]
	sharedLocks as typeSharedLocks[0]
endtype

type typeLockDeletedCard
	dialog as integer
	iteration as integer
	rightButton as integer
	sprBackground as integer
	sprUsernameButton as integer
	txtDeletedWhen as integer
	txtFooter as integer
	txtHeader as integer
	txtLockedByHidden as integer
	txtLockInformation as integer
	txtUsernameHidden as integer
endtype

type typeLockEstimations
	sprAverageCaseBar as integer
	sprBackground as integer
	sprBestCaseBar as integer
	sprChartOverlay as integer
	sprWorstCaseBar as integer
	txtAverageCaseLabel as integer
	txtAverageCaseTitle as integer
	txtBestCaseLabel as integer
	txtBestCaseTitle as integer
	txtChartTitle as integer
	txtRunningSimulation as integer
	txtWorstCaseLabel as integer
	txtWorstCaseTitle as integer
endtype

type typeLockOptions
	buttonSelected as integer
	buttonWidth# as float
	noOfButtons as integer
	optionID as integer
	randomSelected as integer
	rangeAddButtonDisabled as integer[10]
	rangeMaxValue# as float
	rangeMinusButtonDisabled as integer[10]
	rangeMinValue# as float
	rangeStepBy# as float
	rangeValue# as float[10]
	rangeOptions as integer
	sliderButtons as integer
	sliderMaxValue# as float
	sliderMinValue# as float
	sliderStepBy# as float
	sliderValue# as float[10]
	sprBackground as integer
	sprButton as integer[10]
	sprButtonImage as integer[10]
	sprEstimateBarChartBackground as integer
	sprEstimateBarAverageCase as integer
	sprEstimateBarBestCase as integer
	sprEstimateBarWorstCase as integer
	sprRangeAddButton as integer[10]
	sprRangeCountBackground as integer[10]
	sprRangeMaxLabelBackground as integer
	sprRangeMinLabelBackground as integer
	sprRangeMinusButton as integer[10]
	sprRangeToLabelBackground as integer
	sprRandomButton as integer
	sprSliderAddButton as integer
	sprSliderButton as integer[2]
	sprSliderMinusButton as integer
	sprSliderSlot as integer
	sprSliderSlotFill as integer
	txtButton as integer[10]
	txtEstimateBarAverageCaseLabel as integer
	txtEstimateBarAverageCaseTitle as integer
	txtEstimateBarBestCaseLabel as integer
	txtEstimateBarBestCaseTitle as integer
	txtEstimateBarWorstCaseLabel as integer
	txtEstimateBarWorstCaseTitle as integer
	txtLabel as integer
	txtRangeCount as integer[10]
	txtRangeMaxLabel as integer
	txtRangeMinLabel as integer
	txtRangeToLabel as integer
	txtSliderButton as integer[2]
	txtSliderMaxLabel as integer
	txtSliderMinLabel as integer
	txtSubLabel as integer
	txtSubLabel2 as integer
endtype

type typeLockUpdates
	actionUpdate as integer
	allowFreeUnlockModifiedBy as integer
	autoResetsPausedModifiedBy as integer
	cardInfoHiddenModifiedBy as integer
	cumulativeModifiedBy as integer
	doubleUpCardsModifiedBy as integer
	freezeCardsModifiedBy as integer
	greenCardsModifiedBy as integer
	hidden as integer
	id as integer
	lockedBy$ as string
	lockFrozenByKeyholder as integer
	lockFrozenByKeyholderModifiedBy as integer
	lockID as integer
	lockNo as integer
	minutesModifiedBy as integer
	noOfAdd1CardsModifiedBy as integer
	noOfAdd2CardsModifiedBy as integer
	noOfAdd3CardsModifiedBy as integer
	noOfFreeze1CardsModifiedBy as integer
	noOfFreeze2CardsModifiedBy as integer
	noOfFreeze3CardsModifiedBy as integer
	noOfMinus1CardsModifiedBy as integer
	noOfMinus2CardsModifiedBy as integer
	readyToUnlock as integer
	redCardsModifiedBy as integer
	regularity# as float
	reset as integer
	resetCardsModifiedBy as integer
	stickyCardsModifiedBy as integer
	timerHiddenModifiedBy as integer
	timestampModified as integer
	unlocked as integer
	updatesString$ as string
	yellowCardsModifiedBy as integer
endtype

type typeLog
	sortKey$ as string
	id as integer
	action$ as string
	actionedBy$ as string
	hidden as integer
	iteration as integer
	lockID as integer
	private as integer
	result$ as string
	timestamp as integer
	totalActionTime as integer
endtype

type typeMenuItems
	disabled as integer
	itemType$ as string
	originalY# as float
	spr as integer
	txtCenter as integer
	txtLeft as integer
	txtRight as integer
endtype

type typeNews
	id as integer
	body$ as string
	date$ as string
	deleted as integer
	sprBackground as integer
	timestamp as integer
	title$ as string
	txtBody as integer
	txtTimePosted as integer
	txtTitle as integer
endtype

type typePages
	sprButton as integer
	txtButton as integer
endtype

type typeProfileData
	id as integer
	avatarApproved as integer
	avatarName$ as string
	averageRating# as float
	averageSecondsLocked as integer
	banned as integer
	cumulativeSecondsLocked as integer
	discordDiscriminator as integer
	discordID$ as string
	discordUsername$ as string
	followers as integer
	following as integer
	joined$ as string
	keyholderLevel as integer
	lockeeLevel as integer
	longestSecondsLocked as integer
	mainRoleColour as integer
	mainRoleLevel$ as string
	mainRoleSelected as integer
	noOfLocks as integer
	noOfLocksCompleted as integer
	noOfLocksManaged as integer
	noOfLocksManagingNow as integer
	noOfRatings as integer
	privateProfile as integer
	secondsLockedInCurrentLock as integer
	showKeyholderStatsOnProfile as integer
	showLockeeStatsOnProfile as integer
	statusSelected as integer
	timestampJoined as integer
	timestampLastActive as integer
	twitterHandle$ as string
	username$ as string
	visibleInPublicStats as integer		
endtype

type typeRecentActivity
	sortKey$ as string
	id as integer
	activityType$ as string
	iteration as integer
	lockID$ as string
	mentionedUserID as integer
	mentionedUsername$ as string
	readActivity as integer
	shareID$ as string
	testLock as integer
	timestamp as integer
endtype
	
type typeRoleColours
	admin as integer
	keyholder as integer[10]
	lockee as integer[10]
	lockeeBlue as integer[10]
	lockeePink as integer[10]
	moderator as integer[10]
endtype

type typeScreen
	btnNext as integer
	dialog as integer
	endScreenDrawTime# as float
	initialisedScreen as integer
	lastViewY# as float
	menuMore as integer
	progressBar as integer
	scrollBar as integer
	scrollToTop as integer
	sprPage as integer
	sprPullToRefreshIcon as integer
	sprScrollBar as integer
	startScreenDrawTime# as float
	tabs as integer
	topBar as integer
endtype

type typeServerCall
	id$ as string
	failedCount as integer
	parameters$ as string
	response$ as string
	script$ as string
	sentTime# as float
	stickUntilComplete as integer
endtype

type typeServerUpload
	id$ as string
	failedCount as integer
	file$ as string
	parameters$ as string
	response$ as string
	script$ as string
	sentTime# as float
	stickUntilComplete as integer
endtype

type typeSettingOptions
	buttonSelected as integer
	buttonWidth# as float
	editbox as integer
	noOfButtons as integer
	optionID as integer
	randomSelected as integer
	rangeAddButtonDisabled as integer[10]
	rangeMaxValue# as float
	rangeMinusButtonDisabled as integer[10]
	rangeMinValue# as float
	rangeStepBy# as float
	rangeValue# as float[10]
	rangeOptions as integer
	sliderButtons as integer
	sliderMaxValue# as float
	sliderMinValue# as float
	sliderStepBy# as float
	sliderValue# as float[10]
	sprBackground as integer
	sprButton as integer[20]
	sprButtonImage as integer[20]
	sprEditBoxLine as integer
	sprRangeAddButton as integer[10]
	sprRangeCountBackground as integer[10]
	sprRangeMaxLabelBackground as integer
	sprRangeMinLabelBackground as integer
	sprRangeMinusButton as integer[10]
	sprRangeToLabelBackground as integer
	sprRandomButton as integer
	sprSliderAddButton as integer
	sprSliderButton as integer[2]
	sprSliderMinusButton as integer
	sprSliderSlot as integer
	sprSliderSlotFill as integer
	txtButton as integer[20]
	txtLabel as integer
	txtRangeCount as integer[10]
	txtRangeMaxLabel as integer
	txtRangeMinLabel as integer
	txtRangeToLabel as integer
	txtSliderButton as integer[2]
	txtSliderMaxLabel as integer
	txtSliderMinLabel as integer
	txtSubLabel as integer
	txtSubLabel2 as integer
endtype

type typeSharedLockCard
	sortKey$ as string
	dialog as integer
	iteration as integer
	menuShare as integer
	menuShowMatchingUsers as integer
	minimised as integer
	sprBackground as integer
	sprButtonBar as integer
	sprCloneButton as integer
	sprCloneIcon as integer
	sprConfirmButton as integer
	sprConfirmIcon as integer
	sprDeleteButton as integer
	sprDeleteIcon as integer
	sprDeletingBackground as integer
	sprEditButton as integer
	sprKeyDisabled as integer
	sprLeftEmptyButton as integer
	sprManageButton as integer
	sprManageIcon as integer
	sprMoreButton as integer
	sprMoreIcon as integer
	sprOverlay as integer
	sprRightEmptyButton as integer
	sprShareButton as integer
	sprShareIcon as integer
	sprShowMatchingUsersButton as integer
	sprShowMatchingUsersIcon as integer
	sprSyncStatus as integer
	sprVisibleButton as integer
	txtAddToRandomUserHeader as integer
	txtAutoResets as integer
	txtCards as integer
	txtCheckIns as integer
	txtDeleteButton as integer
	txtDeleting as integer
	txtInfoButton as integer
	txtLockName as integer
	txtManageButton as integer
	txtNameHeader as integer
	txtOptions as integer
	txtRating as integer
	txtShareButton as integer
	txtShareID as integer
	txtUsers as integer
	txtUsersHeader as integer
endtype

type typeSharedLocks
	sortKey$ as string
	allowCopies as integer
	awaitingDecision as integer
	blockTestLocks as integer
	blockUsersAlreadyLocked as integer
	blockUsersWithStatsHidden as integer
	build as integer
	cardInfoHidden as integer
	checkInFrequencyInSeconds as integer
	cumulative as integer
	deleting as integer
	desertedUsers as integer
	desertedUsersAwaitingRating as integer
	desertedUsersDelimited$ as string
	desertedUsersFavourites as integer
	editBoxLockName as integer
	fakeLockedUsers as integer
	filterIn as integer
	fixed as integer
	forceTrust as integer
	hiddenFromOwner as integer
	id as integer
	iteration as integer
	jsonCount as integer
	jsonNo as integer
	keyDisabled as integer
	keyholderDecisionDisabled as integer
	keyholderID as integer
	keyholderLastActive as integer
	keyholderRating# as float
	keyholderStatus as integer
	keyholderUsername$ as string
	lateCheckInWindowInSeconds as integer
	lockedUsers as integer
	lockedUsersDelimited$ as string
	lockedUsersExcludingTest as integer
	lockedUsersIncludingTest as integer
	lockedUsersFavourites as integer
	lockName$ as string
	lockRating# as float
	maxAutoResets as integer
	maxRandomCopies as integer
	maxRandomDoubleUps as integer
	maxRandomFreezes as integer
	maxRandomGreens as integer
	maxRandomMinutes as integer
	maxRandomReds as integer
	maxRandomResets as integer
	maxRandomStickies as integer
	maxRandomYellows as integer
	maxRandomYellowsAdd as integer
	maxRandomYellowsMinus as integer
	maxUsers as integer
	minRandomCopies as integer
	minRandomDoubleUps as integer
	minRandomFreezes as integer
	minRandomGreens as integer
	minRandomMinutes as integer
	minRandomReds as integer
	minRandomResets as integer
	minRandomStickies as integer
	minRandomYellows as integer
	minRandomYellowsAdd as integer
	minRandomYellowsMinus as integer
	minRatingRequired as integer
	minVersionRequired$ as string
	multipleGreensRequired as integer
	noOfKeyholderRatings as integer
	noOfLockRatings as integer
	noOfUsers as integer
	regularity# as float
	requireDM as integer
	resetFrequencyInSeconds as integer
	shareID$ as string
	shareInAPI as integer
	simulationAverageMinutesLocked as integer
	simulationBestCaseMinutesLocked as integer
	simulationWorstCaseMinutesLocked as integer
	startLockFrozen as integer
	temporarilyDisabled as integer
	timerHidden as integer
	timestampCreated as integer
	timestampHidden as integer
	timestampLastSync as integer
	unlockedUsers as integer
	unlockedUsersAwaitingRating as integer
	unlockedUsersDelimited$ as string
	unlockedUsersFavourites as integer
	usersAutoResetsPaused as integer[200]
	usersAutoResetsPausedModifiedBy as integer[200]
	usersAverageRatingFromKeyholders# as float[200]
	usersBuildNumberInstalled as integer[200]
	usersCardInfoHidden as integer[200]
	usersCardInfoHiddenModifiedBy as integer[200]
	usersChancesAccumulatedBeforeFreeze as integer[200]
	usersCheckInFrequencyInSeconds as integer[200]
	usersCombination$ as string[200]
	usersCumulative as integer[200]
	usersCumulativeModifiedBy as integer[200]
	usersDateDeleted$ as string[200]
	usersDateLocked$ as string[200]
	usersDateUnlocked$ as string[200]
	usersDiscardPile$ as string[200]
	usersDoubleUpCards as integer[200]
	usersDoubleUpCardsModifiedBy as integer[200]
	usersEmojiChosen as integer[200]
	usersEmojiColourSelected as integer[200]
	usersFavourite as integer[200]
	usersFakeLock as integer[200]
	usersFreezeCards as integer[200]
	usersFreezeCardsModifiedBy as integer[200]
	usersGreenCards as integer[200]
	usersGreenCardsModifiedBy as integer[200]
	usersGreenCardsPicked as integer[200]
	usersHideGreensUntilPickedCount as integer[200]
	usersID as integer[200]
	usersInitialDoubleUpCards as integer[200]
	usersInitialFreezeCards as integer[200]
	usersInitialGreenCards as integer[200]
//~	usersInitialMaximumDoubleUpCards as integer[200]
//~	usersInitialMaximumFreezeCards as integer[200]
//~	usersInitialMaximumGreenCards as integer[200]
//~	usersInitialMaximumMinutes as integer[200]
//~	usersInitialMaximumRedCards as integer[200]
//~	usersInitialMaximumResetCards as integer[200]
//~	usersInitialMaximumStickyCards as integer[200]
//~	usersInitialMaximumYellowAddCards as integer[200]
//~	usersInitialMaximumYellowMinusCards as integer[200]
//~	usersInitialMaximumYellowRandomCards as integer[200]
//~	usersInitialMinimumDoubleUpCards as integer[200]
//~	usersInitialMinimumFreezeCards as integer[200]
//~	usersInitialMinimumGreenCards as integer[200]
//~	usersInitialMinimumMinutes as integer[200]
//~	usersInitialMinimumRedCards as integer[200]
//~	usersInitialMinimumResetCards as integer[200]
//~	usersInitialMinimumStickyCards as integer[200]
//~	usersInitialMinimumYellowAddCards as integer[200]
//~	usersInitialMinimumYellowMinusCards as integer[200]
//~	usersInitialMinimumYellowRandomCards as integer[200]
	usersInitialMinutes as integer[200]
	usersInitialMinutesModifiedBy as integer[200]
	usersInitialRedCards as integer[200]
	usersInitialResetCards as integer[200]
	usersInitialStickyCards as integer[200]
	usersInitialYellowCards as integer[200,6]
	usersKeyholderAllowsFreeUnlock as integer[200]
	usersKeyholderAllowsFreeUnlockModifiedBy as integer[200]
	usersKeyholderEmojiChosen as integer[200]
	usersKeyholderEmojiColourSelected as integer[200]
	usersKeysDisabled as integer[200]
	usersLastActive as integer[200]
	usersLastUpdateHidden as integer[200]
	usersLastUpdateIDSeen as integer[200]
	usersLateCheckInWindowInSeconds as integer[200]
	usersLockBuildNumber as integer[200]
	usersLockFrozenByCard as integer[200]
	usersLockFrozenByKeyholder as integer[200]
	usersLockFrozenByKeyholderModifiedBy as integer[200]
	usersLockID as integer[200]
	usersLog as typeLog[200,0]
	usersMainRole as integer[200]
	usersMainRoleLevel as integer[200]
	usersMaxAutoResets as integer[200]
	usersMinutes as integer[200]
	usersMinutesModifiedBy as integer[200]
	usersNoOfKeyholders as integer[200]
	usersNoOfRatingsFromKeyholders as integer[200]
	usersOtherKeyholders$ as string[200]
	usersRatingFromKeyholder as integer[200]
	usersNoOfTimesAutoReset as integer[200]
	usersNoOfTimesCardReset as integer[200]
	usersNoOfTimesFullReset as integer[200]
	usersNoOfTimesGreenCardRevealed as integer[200]
	usersNoOfTimesReset as integer[200]
	usersPickedCount as integer[200]
	usersPickedCountSinceReset as integer[200]
	usersReadyToUnlock as integer[200]
	usersRedCards as integer[200]
	usersRedCardsModifiedBy as integer[200]
	usersReset as integer[200]
	usersResetCards as integer[200]
	usersResetCardsModifiedBy as integer[200]
	usersResetFrequencyInSeconds as integer[200]
	usersStatus as integer[200]
	usersStickyCards as integer[200]
	usersStickyCardsModifiedBy as integer[200]
	usersTestLock as integer[200]
	usersTimerHidden as integer[200]
	usersTimerHiddenModifiedBy as integer[200]
	usersTimerToggle as integer[200]
	usersTimestampDeleted as integer[200]
	usersTimestampFrozenByCard as integer[200]
	usersTimestampFrozenByKeyholder as integer[200]
	usersTimestampKeyholderRated as integer[200]
	usersTimestampLastModified as integer[200]
	usersTimestampLastAutoReset as integer[200]
	usersTimestampLastCardReset as integer[200]
	usersTimestampLastCheckedIn as integer[200]
	usersTimestampLastFullReset as integer[200]
	usersTimestampLastPicked as integer[200]
	usersTimestampLastReset as integer[200]
	usersTimestampLastSynced as integer[200]
	usersTimestampLastUpdated as integer[200]
	usersTimestampLocked as integer[200]
	usersTimestampRealLastPicked as integer[200]
	usersTimestampRequestedKeyholdersDecision as integer[200]
	usersTimestampUnfreezes as integer[200]
	usersTimestampUnfrozen as integer[200]
	usersTimestampUnlocked as integer[200]
	usersTotalTimeFrozen as integer[200]
	usersTrustKeyholder as integer[200]
	usersUnlocked as integer[200]
	usersUsedKey as integer[200]
	usersUsername$ as string[200]
	usersVersion$ as string[200]
	usersYellowCards as integer[200,6]
	usersYellowCardsModifiedBy as integer[200,6]
	version$ as string
endtype

type typeSharedLockUsers
	jsonNo as integer
	usersAverageRatingFromKeyholders# as float
	usersAutoResetsPaused as integer
	usersBuildNumberInstalled as integer
	usersCardInfoHidden as integer
	usersCardInfoHiddenModifiedBy as integer
	usersChancesAccumulatedBeforeFreeze as integer
	usersCheckInFrequencyInSeconds as integer
	usersCombination$ as string
	usersCumulative as integer
	usersCumulativeModifiedBy as integer
	usersDateDeleted$ as string
	usersDateLocked$ as string
	usersDateUnlocked$ as string
	usersDiscardPile$ as string
	usersDoubleUpCards as integer
	usersDoubleUpCardsModifiedBy as integer
	usersEmojiChosen as integer
	usersEmojiColourSelected as integer
	usersFavourite as integer
	usersFakeLock as integer
	usersFreezeCards as integer
	usersFreezeCardsModifiedBy as integer
	usersGreenCards as integer
	usersGreenCardsModifiedBy as integer
	usersGreenCardsPicked as integer
	usersHideGreensUntilPickedCount as integer
	usersID as integer
	usersInitialDoubleUpCards as integer
	usersInitialFreezeCards as integer
	usersInitialGreenCards as integer
//~	usersInitialMaximumDoubleUpCards as integer
//~	usersInitialMaximumFreezeCards as integer
//~	usersInitialMaximumGreenCards as integer
//~	usersInitialMaximumMinutes as integer
//~	usersInitialMaximumRedCards as integer
//~	usersInitialMaximumResetCards as integer
//~	usersInitialMaximumStickyCards as integer
//~	usersInitialMaximumYellowAddCards as integer
//~	usersInitialMaximumYellowMinusCards as integer
//~	usersInitialMaximumYellowRandomCards as integer
//~	usersInitialMinimumDoubleUpCards as integer
//~	usersInitialMinimumFreezeCards as integer
//~	usersInitialMinimumGreenCards as integer
//~	usersInitialMinimumMinutes as integer
//~	usersInitialMinimumRedCards as integer
//~	usersInitialMinimumResetCards as integer
//~	usersInitialMinimumStickyCards as integer
//~	usersInitialMinimumYellowAddCards as integer
//~	usersInitialMinimumYellowMinusCards as integer
//~	usersInitialMinimumYellowRandomCards as integer
	usersInitialMinutes as integer
	usersInitialRedCards as integer
	usersInitialResetCards as integer
	usersInitialStickyCards as integer
	usersInitialYellowCards as integer[6]
	usersKeyholderAllowsFreeUnlock as integer
	usersKeyholderAllowsFreeUnlockModifiedBy as integer
	usersKeyholderEmojiChosen as integer
	usersKeyholderEmojiColourSelected as integer
	usersKeysDisabled as integer
	usersLastActive as integer
	usersLastUpdateHidden as integer
	usersLastUpdateIDSeen as integer
	usersLateCheckInWindowInSeconds as integer
	usersLockBuildNumber as integer
	usersLockFrozenByCard as integer
	usersLockFrozenByKeyholder as integer
	usersLockFrozenByKeyholderModifiedBy as integer
	usersLockID as integer
	usersLog as typeLog[]
	usersMainRole as integer
	usersMainRoleLevel as integer
	usersMaxAutoResets as integer
	usersMinutes as integer
	usersMinutesModifiedBy as integer
	usersNoOfKeyholders as integer
	usersNoOfRatingsFromKeyholders as integer
	usersNoOfTimesAutoReset as integer
	usersNoOfTimesCardReset as integer
	usersNoOfTimesFullReset as integer
	usersNoOfTimesGreenCardRevealed as integer
	usersNoOfTimesReset as integer
	usersPickedCount as integer
	usersPickedCountSinceReset as integer
	usersOtherKeyholders$ as string
	usersRatingFromKeyholder as integer
	usersReadyToUnlock as integer
	usersRedCards as integer
	usersRedCardsModifiedBy as integer
	usersResetCards as integer
	usersResetCardsModifiedBy as integer
	usersResetFrequencyInSeconds as integer
	usersStatus as integer
	usersStickyCards as integer
	usersTestLock as integer
	usersTimerHidden as integer
	usersTimerToggle as integer
	usersTimestampDeleted as integer
	usersTimestampFrozenByCard as integer
	usersTimestampFrozenByKeyholder as integer
	usersTimestampKeyholderRated as integer
	usersTimestampLastModified as integer
	usersTimestampLastAutoReset as integer
	usersTimestampLastCardReset as integer
	usersTimestampLastCheckedIn as integer
	usersTimestampLastFullReset as integer
	usersTimestampLastPicked as integer
	usersTimestampLastReset as integer
	usersTimestampLastSynced as integer
	usersTimestampLastUpdated as integer
	usersTimestampLocked as integer
	usersTimestampRealLastPicked as integer
	usersTimestampRequestedKeyholdersDecision as integer
	usersTimestampUnfreezes as integer
	usersTimestampUnfrozen as integer
	usersTimestampUnlocked as integer
	usersTotalTimeFrozen as integer
	usersTrustKeyholder as integer
	usersUnlocked as integer
	usersUsedKey as integer
	usersUsername$ as string
	usersVersion$ as string
	usersYellowCards as integer[6]
	usersYellowCardsModifiedBy as integer[6]
endtype

type typeTheme
	color as integer[100]
endtype

type typeUpdateUser
	sprCircle as integer[5]
	btnAdd as integer[5]
	btnMinus as integer[5]
	crdHideUpdate as integer
	crdSplitUpdate as integer
	grpHideUpdate as integer
	grpSplitUpdate as integer
	spinCardCount as integer[20]
	sprCard as integer[20]
	sprTrustKeyholder as integer
	sprUsernameButton as integer
	txtCardModifiedBy as integer[20]
	txtCardPercentage as integer[20]
	txtCircle as integer[5]
	txtCircleFooter as integer[5]
	txtGreensRequiredToUnlock as integer
	txtModifiedBy as integer
	txtCardPickedCount as integer[20]
	txtUsername as integer
endtype

type typeURLs
    Domain as string
    URLPath as string
    AcceptFollowRequest as string
	AddNewAPIProject as string
	AddNewUserID as string
	BlockUser as string
	CheckNewShareID as string
	CheckNewUserID as string
	CheckNewUsername as string
	CheckRestoreID as string
	CreateNewSharedLock as string
	DeclineFollowRequest as string
	DeleteAPIProject as string
	DeleteLock as string
	DeleteSharedLock as string
	DisconnectDiscord as string
	DisconnectTwitter as string
	FollowUser as string
	GetAccountData as string
	GetAPIProjects as string
	GetKeyholdersData as string
	GetLockLog as string
	GetLockTemplates as string
	GetLockUpdates as string
	GetMyLocksDeleted as string
	GetOthersRelations as string
	GetProfileData as string
	GetRecentActivity as string
	GetServerVariables as string
	GetSharedLockInformation as string
	GetSharedLocksData as string
	GetSharedLocksDeleted as string
	GetSharedLockUsersData as string
	GetUserLog as string
	GetYourRelations as string
	RemoveUserFromLock as string
	ResetAPIClientSecret as string
	RestoreAccount as string
	RestoreDeletedSharedLock as string
	UnblockUser as string
	UnfollowUser as string
	UnlockUsersLock as string
	UpdateAccount as string
	UpdateAPIProject as string
	UpdateKeyholdersEmoji as string
	UpdateLocksDatabase as string
	UpdateRecentActivityReadFlag as string
	UpdateRecentActivityReadFlagForAll as string
	UpdateSharedLock as string
	UpdateUsername as string
	UpdateUsersLock as string
	UpdateUsersRatingFromKeyholder as string
endtype

type typeUserCard
	dialog as integer
	flagButtonGroup as integer
	iteration as integer
	shaderCooldown as integer
	sprBackground as integer
	sprBlankButton as integer
	sprButtonBar as integer
	sprCheckInButton as integer
	sprCheckInCooldown as integer
	sprCheckInIcon as integer
	sprConfirmButton as integer
	sprConfirmIcon as integer
	sprDoubleUpCard as integer
	sprEditButton as integer
	sprEditIcon as integer
	sprEmojiIcon as integer
	sprFakeLock as integer
	sprFavouriteButton as integer
	sprFavouriteIcon as integer
	sprFixedCircle as integer[5]
	sprFixedCount as integer
	sprFixedCountAdd as integer
	sprFixedCountCancel as integer
	sprFixedCountMinus as integer
	sprFixedHideTimerButton as integer
	sprFixedHideTimerCancel as integer	
	sprFixedHideTimerCircle as integer
	sprFixedHideTimerIcon as integer
	sprFixedHideTimer as integer
	sprFlagButton as integer
	sprFlagIcon as integer
	sprFreeUnlock as integer
	sprFreezeLockButton as integer
	sprFreezeLockIcon as integer
	sprFreezeCard as integer
	sprGreenCard as integer
	sprHideCardInfoButton as integer	
	sprHideCardInfoIcon as integer
	sprKeysDisabled as integer
	sprLeftEmptyButton as integer
	sprModifyLockInBackground as integer
	sprMoodButton as integer
	sprMoodBackground as integer
	sprMoodIcon as integer
	sprMoreButton as integer
	sprMoreIcon as integer
	sprMultipleKeyholders as integer
	sprOverlay as integer
	sprRatingRibbon as integer
	sprRatingStar as integer[6]
	sprRedCard as integer
	sprResetButton as integer
	sprResetIcon as integer
	sprResetCard as integer
	sprRightEmptyButton as integer
	sprScrim as integer
	sprStatus as integer
	sprStickyCard as integer
	sprTestLock as integer
	sprTrustKeyholder as integer
	sprUnlockButton as integer
	sprUnlockIcon as integer
	sprUsedKey as integer
	sprUsernameButton as integer
	sprYellowCard as integer
	txtConfirmButton as integer
	txtDoubleUpCount as integer
	txtDoubleUpFooter as integer
	txtDoubleUpHeader as integer
	txtEditButton as integer
	txtFavouriteButton as integer
	txtFixedCircle as integer[5]
	txtFixedCircleFooter as integer[5]
	txtFixedCount as integer[5]
	txtFixedCountFooter as integer
	txtFixedCountHeader as integer
	txtFixedHideTimerHeader as integer
	txtFixedHideTimerFooter as integer
	txtFreezeCount as integer
	txtFreezeFooter as integer
	txtFreezeHeader as integer
	txtFreezeLockFooter as integer
	txtFreezeLockHeader as integer
	txtGreenCount as integer
	txtGreenFooter as integer
	txtGreenHeader as integer
	txtHideCardInfoFooter as integer
	txtHideCardInfoHeader as integer
	txtTicker as integer
	txtModifyLockIn as integer
	txtModifyLockInFooter as integer
	txtMoodButton as integer
	txtRatingRibbon as integer
	txtRateUser as integer
	txtRedCount as integer
	txtRedFooter as integer
	txtRedHeader as integer	
	txtResetButton as integer
	txtResetCount as integer
	txtResetFooter as integer
	txtResetHeader as integer
	txtStickyCount as integer
	txtStickyFooter as integer
	txtStickyHeader as integer
	txtUnlockButton as integer
	txtUnlocksIn as integer
	txtUpdateVersion as integer
	txtUsername as integer
	txtYellowCount as integer
	txtYellowFooter as integer
	txtYellowHeader as integer
endtype

type typeUserPages
	sprButton as integer
	txtButton as integer
endtype

type typeUsersSorted
	sortKey$ as string
	iteration as integer
endtype
