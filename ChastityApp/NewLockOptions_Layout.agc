
screenNo = constNewLockOptionsScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;text:Lock Options;textAlignment:center;depth:10")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:New Lock")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Load Lock")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// WHO IS THE LOCK FOR?
crdWhoIsTheLockFor = OryUICreateTextCard("width:94;headerText:Who is the lock for?;supportingText:A lock that runs on your device for you to use will be created. It can run with or without a keyholder.;position:-1000,-1000;autoHeight:true;depth:19")
grpWhoIsTheLockFor = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpWhoIsTheLockFor, -1, "name:Myself;text:Myself")
OryUIInsertButtonGroupItem(grpWhoIsTheLockFor, -1, "name:Others;text:Others")
OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)

// IS THIS A TEST LOCK?
crdIsThisATestLock = OryUICreateTextCard("width:94;headerText:Is this a test lock?;supportingText:Test locks will run like real locks but won't be included in your lock history and stats.;position:-1000,-1000;autoHeight:true;depth:19")
grpIsThisATestLock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpIsThisATestLock, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpIsThisATestLock, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpIsThisATestLock, 2)

// WOULD YOU LIKE A BOT TO KEYHOLD?
crdWouldYouLikeABotToKeyhold = OryUICreateTextCard("width:94;headerText:Would you like a bot to keyhold?;supportingText:A bot will choose some of the settings and control the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpWouldYouLikeABotToKeyhold = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpWouldYouLikeABotToKeyhold, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpWouldYouLikeABotToKeyhold, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpWouldYouLikeABotToKeyhold, 2)

// WHICH BOT?
crdWhichBot = OryUICreateTextCard("width:94;headerText:Would you like a bot to keyhold?;supportingText:A bot will choose some of the settings and control the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpWhichBot = OryUICreateButtonGroup("size:90,17;iconSize:20,-1;iconPlacement:Top;position:-1000,-1000;depth:18") //iconSize:-1,10
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Hailey;text:Hailey;iconID:" + str(imgBot01))
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Blaine;text:Blaine;iconID:" + str(imgBot02))
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Zoe;text:Zoe;iconID:" + str(imgBot03))
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Chase;text:Chase;iconID:" + str(imgBot04))
OryUISetButtonGroupItemSelectedByIndex(grpWhichBot, 1)

// DO YOU TRUST THE BOT?
crdDoYouTrustTheBot = OryUICreateTextCard("width:94;headerText:Do you trust the bot?;supportingText:Trusting the bot will remove all limitations from them as your keyholder which means that they can add/remove as much time as they want, and as often as they want. It also means that the lock can run for a lot longer than you expected. If this is your first session with a bot then it's recommended that you choose 'No';position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouTrustTheBot = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouTrustTheBot, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouTrustTheBot, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouTrustTheBot, 2)

// TYPE OF LOCK?
crdTypeOfLock = OryUICreateTextCard("width:94;headerText:Type of lock?;supportingText:You will have a chance at regular intervals to unlock. Variable locks use a card system.;position:-1000,-1000;autoHeight:true;depth:19")
grpTypeOfLock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpTypeOfLock, -1, "name:VariableLock;text:Variable Lock")
OryUIInsertButtonGroupItem(grpTypeOfLock, -1, "name:FixedLock;text:Fixed Lock")
OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 1)

// CHANCE REGULARITY?
crdChanceRegularity = OryUICreateTextCard("width:94;headerText:Chance regularity?;supportingText:You will be given a chance every 24 hours to unlock early.;position:-1000,-1000;autoHeight:true;depth:19")
grpChanceRegularity = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:24H;text:24H")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:12H;text:12H")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:6H;text:6H")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:3H;text:3H")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:1H;text:1H")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:30M;text:30M")
OryUIInsertButtonGroupItem(grpChanceRegularity, -1, "name:15M;text:15M")
OryUISetButtonGroupItemSelectedByIndex(grpChanceRegularity, 1)

// UNIT OF TIME?
crdUnitOfTime = OryUICreateTextCard("width:94;headerText:Unit of time?;supportingText:You will be given a chance every 24 hours to unlock early.;position:-1000,-1000;autoHeight:true;depth:19")
grpUnitOfTime = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpUnitOfTime, -1, "name:Daily;text:Daily")
OryUIInsertButtonGroupItem(grpUnitOfTime, -1, "name:Hourly;text:Hourly")
OryUISetButtonGroupItemSelectedByIndex(grpUnitOfTime, 1)

// CUMULATIVE CHANCES?
crdCumulativeChances = OryUICreateTextCard("width:94;headerText:Cumulative chances?;supportingText:You will have X chances after being away for X days. For example if you were away for 3 days you would get 3 chances when you return.;position:-1000,-1000;autoHeight:true;depth:19")
grpCumulativeChances = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpCumulativeChances, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpCumulativeChances, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)

// NUMBER OF DIGITS/CHARACTERS IN COMBINATION
crdNumberOfDigitsInCombination = OryUICreateTextCard("width:94;headerText:Number of digits in combination?;supportingText:You can change the type of combinations generated from the settings screen.;position:-1000,-1000;autoHeight:true;depth:19")
spinNumberOfDigitsInCombination = OryUICreateInputSpinner("size:27,5;min:3;max:8;step:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF RED CARDS / DAYS / HOURS / MINUTES?
crdNumberOfRedCards = OryUICreateTextCard("width:94;headerText:Number of red cards?;supportingText:When a red card is revealed you have to wait 24 hours before you can pick again.;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfRedCards = OryUICreateInputSpinner("size:27,5;min:0;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfRedCards = OryUICreateInputSpinner("size:27,5;min:0;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// DO YOU WANT TO ADD YELLOW CARDS?
crdDoYouWantToAddYellowCards = OryUICreateTextCard("width:94;headerText:Do you want to add yellow cards?;supportingText:When a yellow card is revealed red cards will either be added or removed.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddYellowCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddYellowCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddYellowCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)

// NUMBER OF RANDOM YELLOW CARDS?
crdNumberOfRandomYellowCards = OryUICreateTextCard("width:94;headerText:Random yellow cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfRandomYellowCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfRandomYellowCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF YELLOW CARDS THAT REMOVE RED CARDS?
crdNumberOfYellowMinusCards = OryUICreateTextCard("width:94;headerText:Yellows that remove red cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfYellowMinusCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfYellowMinusCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF YELLOWS THAT ADD REDS?
crdNumberOfYellowAddCards = OryUICreateTextCard("width:94;headerText:Yellows that add red cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfYellowAddCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfYellowAddCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD FREEZE CARDS?
crdDoYouWantToAddFreezeCards = OryUICreateTextCard("width:94;headerText:Do you want to add freeze cards?;supportingText:When a freeze card is revealed the lock will be frozen for 2-4 days.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddFreezeCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddFreezeCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddFreezeCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)

// NUMBER OF FREEZE CARDS?
crdNumberOfFreezeCards = OryUICreateTextCard("width:94;headerText:Number of freeze cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfFreezeCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfFreezeCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD DOUBLE UP CARDS?
crdDoYouWantToAddDoubleUpCards = OryUICreateTextCard("width:94;headerText:Do you want to add double up cards?;supportingText:When a double up card is revealed the number of red and yellow cards currently in play is doubled.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddDoubleUpCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddDoubleUpCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddDoubleUpCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)

// NUMBER OF DOUBLE UP CARDS?
crdNumberOfDoubleUpCards = OryUICreateTextCard("width:94;headerText:Number of double up cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfDoubleUpCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfDoubleUpCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// DO YOU WANT TO ADD RESET CARDS?
crdDoYouWantToAddResetCards = OryUICreateTextCard("width:94;headerText:Do you want to add reset cards?;supportingText:When a reset card is revealed the lock is reset to the number of green, red, and yellow cards the lock initially started with. It does not reset the number of double up, freeze, or reset cards. The lock combination does not change.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddResetCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddResetCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddResetCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)

// NUMBER OF DOUBLE UP CARDS?
crdNumberOfResetCards = OryUICreateTextCard("width:94;headerText:Number of reset cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfResetCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfResetCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// MULTIPLE GREENS REQUIRED?
crdMultipleGreensRequired = OryUICreateTextCard("width:94;headerText:Multiple green cards required to unlock?;supportingText:If multiple green cards are required you will need to find all green cards that are in play to unlock. Otherwise you just need to find one green card.;position:-1000,-1000;autoHeight:true;depth:19")
grpMultipleGreensRequired = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpMultipleGreensRequired, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpMultipleGreensRequired, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)

// NUMBER OF GREEN CARDS?
crdNumberOfGreenCards = OryUICreateTextCard("width:94;headerText:Number of green cards?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfGreenCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfGreenCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// HIDE CARD INFORMATION
crdShowCardInformation = OryUICreateTextCard("width:94;headerText:Hide card information?;supportingText:If hidden you will not see card counts or percentages. To make it harder to count the exact number of cards some fake 'Go Again' cards may also be included in the deck. These cards do not affect the length of the lock in anyway, because when revealed you get to pick another card.;position:-1000,-1000;autoHeight:true;depth:19")
grpShowCardInformation = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpShowCardInformation, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpShowCardInformation, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpShowCardInformation, 2)

// HIDE TIMER
crdHideTimer = OryUICreateTextCard("width:94;headerText:Hide timer?;supportingText:If hidden you will not see how long is left of the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpHideTimer = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpHideTimer, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpHideTimer, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)

// CREATE FAKE COMBINATION
crdCreateFakeCombination = OryUICreateTextCard("width:94;headerText:Create copies with fake combinations?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. You won't know which one is real or fake until you try the combination.;position:-1000,-1000;autoHeight:true;depth:19")
grpCreateFakeCombination = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpCreateFakeCombination, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpCreateFakeCombination, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)

// NUMBER OF FAKE COMBINATION COPIES?
crdNumberOfFakeCombinationCopies = OryUICreateTextCard("width:94;headerText:Number of fake combination copies?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

remstart

// SHOW TIMER
if (loadingSharedLock = 0 and fixed = 1 and permanent = 0)
	lockOptionY# = contentHeight# + 2
	if (lockOptions[LockOptionShowTimer].buttonSelected = 0)
		lockOptions[LockOptionShowTimer].buttonSelected = 1
	endif
	if (lockOptions[LockOptionShowTimer].buttonSelected = 1)
		timerHidden = 0
	elseif (lockOptions[LockOptionShowTimer].buttonSelected = 2)
		timerHidden = 1
	elseif (lockOptions[LockOptionShowTimer].buttonSelected = 3)
		timerHidden = 3
	endif
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionShowTimer, "label:Show timer?;subLabel:If hidden " + lower(userText$) + " will not see how long is left of the lock.;position:" + str((screenNo * 10000) + 3) + "," + str(lockOptionY#) + ";buttons:Yes,No" + botDecidesButton$ + ";selected:" + str(lockOptions[LockOptionShowTimer].buttonSelected))
else
	if (lockOptionsChanged = 1) then UpdateNewLockOption(LockOptionShowTimer, "position:-1000,-1000")
	if (loadingSharedLock = 0) then timerHidden = 0
endif

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
// NUMBER OF
remstart
	#constant LockOptionNoOfYellowMinus 16
	#constant LockOptionNoOfYellowAdd 17
	#constant LockOptionAddFreezeCards 18
	#constant LockOptionNoOfFreezeCards 19
	#constant LockOptionAddDoubleUpCards 20
	#constant LockOptionNoOfDoubleUpCards 21
	#constant LockOptionAddResetCards 22
	#constant LockOptionNoOfResetCards 23
	#constant LockOptionMultipleGreenCardsRequired 24
	#constant LockOptionNoOfGreenCardsRequired 25
	#constant LockOptionShowCardInformation 26
	#constant LockOptionCreateFakeCombinationCopies 27
	#constant LockOptionHowManyFakeCombinationCopies 28
	#constant LockOptionShowTimer 29
	#constant LockOptionEnableEarlyReleaseWithAPurchasedKey 30
	#constant LockOptionNoOfKeysRequired 31
	#constant LockOptionLimitNumberOfUsers 32
	#constant LockOptionMaximumNumberOfUsers 33
	#constant LockOptionBlockUsersAlreadyLocked 34
	#constant LockOptionUsersHaveToTrustYou 35
	#constant LockOptionLockEstimationsTime 36
	#constant LockOptionLockEstimationsChances 37
	#constant LockOptionLockEstimationsCardsDrawn 38
	#constant LockOptionLockRerunSimulation 39
remend
