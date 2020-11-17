
screenNo = constLockOptionsScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock Options;textAlignment:center;depth:10")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:New Lock")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Load Lock")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)

// LOCK TEMPLATES
crdLockTemplates as integer : crdLockTemplates = OryUICreateTextCard("width:94;headerText:;supportingText:Need help or inspiration with creating a lock? If so, check out the " + constAppName$ + " Lock Templates feature.;position:-1000,-1000;autoHeight:true;depth:19")
btnLockTemplates as integer : btnLockTemplates = OryUICreateButton("size:50,5;offset:25,0;text:Lock Templates;position:-1000,-1000;depth:19")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// LOAD LOCK
crdLoadLock as integer : crdLoadLock = OryUICreateTextCard("width:94;headerText:Load or scan a QR code?;supportingText:Looking for a shared lock/keyholder?" + chr(10) + "You may find one on the " + constAppName$ + " forums.;position:-1000,-1000;autoHeight:true;depth:19")
grpLoadLock as integer : grpLoadLock = OryUICreateButtonGroup("size:45,14;iconPlacement:top;iconSize:-1,10;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpLoadLock, -1, "name:Load;iconID:" + str(imgLoadImageButton) + ";text:Load")
OryUIInsertButtonGroupItem(grpLoadLock, -1, "name:Scan;iconID:" + str(imgScanImageButton) + ";text:Scan")
OryUISetButtonGroupItemSelectedByIndex(grpLoadLock, 1)

// DISPLAY SHARED LOCK ERROR
txtSharedLockError as integer : txtSharedLockError = OryUICreateText("text: ;bold:true;size:2.6;alignment:center;position:-1000,-1000;depth:19")

// DISPLAY SHARED LOCK INFORMATION
txtSharedLockInformation as integer : txtSharedLockInformation = OryUICreateText("text: ;bold:true;size:2.6;alignment:center;position:-1000,-1000;depth:19")

// WHO IS THE LOCK FOR?
crdWhoIsTheLockFor as integer : crdWhoIsTheLockFor = OryUICreateTextCard("width:94;headerText:Who is the lock for?;supportingText:A lock that runs on your device for you to use will be created. It can run with or without a keyholder.;position:-1000,-1000;autoHeight:true;depth:19")
grpWhoIsTheLockFor as integer : grpWhoIsTheLockFor = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpWhoIsTheLockFor, -1, "name:Myself;text:Myself")
OryUIInsertButtonGroupItem(grpWhoIsTheLockFor, -1, "name:Others;text:Others")
OryUISetButtonGroupItemSelectedByIndex(grpWhoIsTheLockFor, 1)

// IS THIS A TEST LOCK?
crdIsThisATestLock as integer : crdIsThisATestLock = OryUICreateTextCard("width:94;headerText:Is this a test lock?;supportingText:Test locks will run like real locks but won't be included in your lock history and stats.;position:-1000,-1000;autoHeight:true;depth:19")
grpIsThisATestLock as integer : grpIsThisATestLock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpIsThisATestLock, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpIsThisATestLock, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpIsThisATestLock, 2)

// WOULD YOU LIKE A BOT TO KEYHOLD?
crdWouldYouLikeABotToKeyhold as integer : crdWouldYouLikeABotToKeyhold = OryUICreateTextCard("width:94;headerText:Would you like a bot to keyhold?;supportingText:A bot will choose some of the settings and control the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpWouldYouLikeABotToKeyhold as integer : grpWouldYouLikeABotToKeyhold = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpWouldYouLikeABotToKeyhold, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpWouldYouLikeABotToKeyhold, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpWouldYouLikeABotToKeyhold, 2)

// WHICH BOT?
crdWhichBot as integer : crdWhichBot = OryUICreateTextCard("width:94;headerText:Would you like a bot to keyhold?;supportingText:A bot will choose some of the settings and control the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpWhichBot as integer : grpWhichBot = OryUICreateButtonGroup("size:90,17;iconSize:20,-1;iconPlacement:Top;position:-1000,-1000;depth:18") //iconSize:-1,10
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Hailey;text:Hailey")
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Blaine;text:Blaine")
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Zoe;text:Zoe")
OryUIInsertButtonGroupItem(grpWhichBot, -1, "name:Chase;text:Chase")
OryUISetButtonGroupItemSelectedByIndex(grpWhichBot, 1)

// DO YOU TRUST THE KEYHOLDER?
crdDoYouTrustTheKeyholder as integer : crdDoYouTrustTheKeyholder = OryUICreateTextCard("width:94;headerText:Do you trust the keyholder?;supportingText:Trusting the keyholder will remove all limitations from them as your keyholder which means that they can add/remove as much time as they want, and as often as they want. It also means that the lock can run for a lot longer than you expected. If this is your first session with this keyholder then it's recommended that you choose 'No'.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouTrustTheKeyholder as integer : grpDoYouTrustTheKeyholder = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouTrustTheKeyholder, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouTrustTheKeyholder, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouTrustTheKeyholder, 2)

// TYPE OF LOCK?
crdTypeOfLock as integer : crdTypeOfLock = OryUICreateTextCard("width:94;headerText:Type of lock?;supportingText:You will have a chance at regular intervals to unlock. Variable locks use a card system.;position:-1000,-1000;autoHeight:true;depth:19")
grpTypeOfLock as integer : grpTypeOfLock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpTypeOfLock, -1, "name:VariableLock;text:Variable Lock")
OryUIInsertButtonGroupItem(grpTypeOfLock, -1, "name:FixedLock;text:Fixed Lock")
OryUISetButtonGroupItemSelectedByIndex(grpTypeOfLock, 1)

// REGULARITY?
crdRegularity as integer : crdRegularity = OryUICreateTextCard("width:94;headerText: ;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
crdTestRegularity as integer : crdTestRegularity = OryUICreateTextCard("width:94;headerText:;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
grpRegularity as integer : grpRegularity = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:24H;text:24H")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:12H;text:12H")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:6H;text:6H")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:3H;text:3H")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:1H;text:1H")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:30M;text:30M")
OryUIInsertButtonGroupItem(grpRegularity, -1, "name:15M;text:15M")
OryUISetButtonGroupItemSelectedByIndex(grpRegularity, 1)

// CUMULATIVE CHANCES?
crdCumulativeChances as integer : crdCumulativeChances = OryUICreateTextCard("width:94;headerText:Cumulative chances?;supportingText:You will have X chances after being away for X days. For example if you were away for 3 days you would get 3 chances when you return.;position:-1000,-1000;autoHeight:true;depth:19")
grpCumulativeChances as integer : grpCumulativeChances = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpCumulativeChances, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpCumulativeChances, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpCumulativeChances, 1)

// NUMBER OF DIGITS/CHARACTERS IN COMBINATION
crdNumberOfDigitsInCombination as integer : crdNumberOfDigitsInCombination = OryUICreateTextCard("width:94;headerText:Number of digits in combination?;supportingText:You can change the type of combinations generated from the settings screen.;position:-1000,-1000;autoHeight:true;depth:19")
spinNumberOfDigitsInCombination as integer : spinNumberOfDigitsInCombination = OryUICreateInputSpinner("size:27,5;min:3;max:12;step:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF RED CARDS
crdNumberOfRedCards as integer : crdNumberOfRedCards = OryUICreateTextCard("width:94;headerText:Number of red cards?;supportingText:When a red card is revealed you have to wait 24 hours before you can pick again.;position:-1000,-1000;autoHeight:true;depth:19")
txtNumberOfRedCards as integer : txtNumberOfRedCards = OryUICreateText("text:Approximately 1 day;bold:true;size:2.5;alignment:center;position:-1000,-1000;depth:19")
spinMinNumberOfRedCards as integer : spinMinNumberOfRedCards = OryUICreateInputSpinner("size:27,5;min:0;max:" + str(cappedRedCards) + ";step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfRedCardsTo as integer : txtNumberOfRedCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfRedCards as integer : spinMaxNumberOfRedCards = OryUICreateInputSpinner("size:27,5;min:0;max:" + str(cappedRedCards) + ";step:1;defaultValue:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// MINIMUM LOCK DURATION
crdMinLockDuration as integer : crdMinLockDuration = OryUICreateTextCard("width:94;headerText:Minimum lock duration?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMinDays as integer : txtMinDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinHours as integer : txtMinHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinMinutes as integer : txtMinMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
global spinMinNumberOfDays as integer
spinMinNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMinNumberOfHours as integer
spinMinNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMinNumberOfMinutes as integer
spinMinNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// MAXIMUM LOCK DURATION
crdMaxLockDuration as integer : crdMaxLockDuration = OryUICreateTextCard("width:94;headerText:Maximum lock duration?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMaxDays as integer : txtMaxDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxHours as integer : txtMaxHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxMinutes as integer : txtMaxMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
global spinMaxNumberOfDays as integer
spinMaxNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMaxNumberOfHours as integer
spinMaxNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMaxNumberOfMinutes as integer
spinMaxNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD YELLOW CARDS?
crdDoYouWantToAddYellowCards as integer : crdDoYouWantToAddYellowCards = OryUICreateTextCard("width:94;headerText:Do you want to add yellow cards?;supportingText:When a yellow card is revealed red cards will either be added or removed.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddYellowCards as integer : grpDoYouWantToAddYellowCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddYellowCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddYellowCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddYellowCards, 2)

// NUMBER OF RANDOM YELLOW CARDS?
crdNumberOfRandomYellowCards as integer : crdNumberOfRandomYellowCards = OryUICreateTextCard("width:94;headerText:Random yellow cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfRandomYellowCards as integer : spinMinNumberOfRandomYellowCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfRandomYellowCardsTo as integer : txtNumberOfRandomYellowCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfRandomYellowCards as integer : spinMaxNumberOfRandomYellowCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF YELLOW CARDS THAT REMOVE RED CARDS?
crdNumberOfYellowMinusCards as integer : crdNumberOfYellowMinusCards = OryUICreateTextCard("width:94;headerText:Yellows that remove red cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfYellowMinusCards as integer : spinMinNumberOfYellowMinusCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfYellowMinusCardsTo as integer : txtNumberOfYellowMinusCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfYellowMinusCards as integer : spinMaxNumberOfYellowMinusCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// NUMBER OF YELLOWS THAT ADD REDS?
crdNumberOfYellowAddCards as integer : crdNumberOfYellowAddCards = OryUICreateTextCard("width:94;headerText:Yellows that add red cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfYellowAddCards as integer : spinMinNumberOfYellowAddCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfYellowAddCardsTo as integer : txtNumberOfYellowAddCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfYellowAddCards as integer : spinMaxNumberOfYellowAddCards = OryUICreateInputSpinner("size:27,5;min:0;max:200;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD STICKY CARDS?
crdDoYouWantToAddStickyCards as integer : crdDoYouWantToAddStickyCards = OryUICreateTextCard("width:94;headerText:Do you want to add sticky cards?;supportingText:Sticky cards are like red cards, when revealed you will have to wait 24 hours before you can pick again. But unlike red cards, the sticky card goes back into play and never leaves the deck.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddStickyCards as integer : grpDoYouWantToAddStickyCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddStickyCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddStickyCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddStickyCards, 2)

// NUMBER OF STICKY CARDS?
crdNumberOfStickyCards as integer : crdNumberOfStickyCards = OryUICreateTextCard("width:94;headerText:Number of sticky cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfStickyCards as integer : spinMinNumberOfStickyCards = OryUICreateInputSpinner("size:27,5;min:0;max:30;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfStickyCardsTo as integer : txtNumberOfStickyCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfStickyCards as integer : spinMaxNumberOfStickyCards = OryUICreateInputSpinner("size:27,5;min:0;max:30;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD FREEZE CARDS?
crdDoYouWantToAddFreezeCards as integer : crdDoYouWantToAddFreezeCards = OryUICreateTextCard("width:94;headerText:Do you want to add freeze cards?;supportingText:When a freeze card is revealed the lock will be frozen for 2-4 days.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddFreezeCards as integer : grpDoYouWantToAddFreezeCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddFreezeCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddFreezeCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddFreezeCards, 2)

// NUMBER OF FREEZE CARDS?
crdNumberOfFreezeCards as integer : crdNumberOfFreezeCards = OryUICreateTextCard("width:94;headerText:Number of freeze cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfFreezeCards as integer : spinMinNumberOfFreezeCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfFreezeCardsTo as integer : txtNumberOfFreezeCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfFreezeCards as integer : spinMaxNumberOfFreezeCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// DO YOU WANT TO ADD DOUBLE UP CARDS?
crdDoYouWantToAddDoubleUpCards as integer : crdDoYouWantToAddDoubleUpCards = OryUICreateTextCard("width:94;headerText:Do you want to add double up cards?;supportingText:When a double up card is revealed the number of red and yellow cards currently in play is doubled.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddDoubleUpCards as integer : grpDoYouWantToAddDoubleUpCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddDoubleUpCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddDoubleUpCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddDoubleUpCards, 2)

// NUMBER OF DOUBLE UP CARDS?
crdNumberOfDoubleUpCards as integer : crdNumberOfDoubleUpCards = OryUICreateTextCard("width:94;headerText:Number of double up cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfDoubleUpCards as integer : spinMinNumberOfDoubleUpCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfDoubleUpCardsTo as integer : txtNumberOfDoubleUpCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfDoubleUpCards as integer : spinMaxNumberOfDoubleUpCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// DO YOU WANT TO ADD RESET CARDS?
crdDoYouWantToAddResetCards as integer : crdDoYouWantToAddResetCards = OryUICreateTextCard("width:94;headerText:Do you want to add reset cards?;supportingText:When a reset card is revealed the lock is reset to the number of green, red, and yellow cards the lock initially started with. It does not reset the number of double up, freeze, or reset cards. The lock combination does not change.;position:-1000,-1000;autoHeight:true;depth:19")
grpDoYouWantToAddResetCards as integer : grpDoYouWantToAddResetCards = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDoYouWantToAddResetCards, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDoYouWantToAddResetCards, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDoYouWantToAddResetCards, 2)

// NUMBER OF RESET CARDS?
crdNumberOfResetCards as integer : crdNumberOfResetCards = OryUICreateTextCard("width:94;headerText:Number of reset cards?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfResetCards as integer : spinMinNumberOfResetCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfResetCardsTo as integer : txtNumberOfResetCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfResetCards as integer : spinMaxNumberOfResetCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// NUMBER OF GREEN CARDS?
crdNumberOfGreenCards as integer : crdNumberOfGreenCards = OryUICreateTextCard("width:94;headerText:Number of green cards?;supportingText:Green cards are required to unlock. However, the next option decides if all greens need to be found to unlock, or just one green card.;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfGreenCards as integer : spinMinNumberOfGreenCards = OryUICreateInputSpinner("size:27,5;min:0;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfGreenCardsTo as integer : txtNumberOfGreenCardsTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfGreenCards as integer : spinMaxNumberOfGreenCards = OryUICreateInputSpinner("size:27,5;min:1;max:20;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// MULTIPLE GREENS REQUIRED?
crdMultipleGreensRequired as integer : crdMultipleGreensRequired = OryUICreateTextCard("width:94;headerText:Multiple green cards required to unlock?;supportingText:If multiple green cards are required you will need to find all green cards that are in play to unlock. Otherwise you just need to find one green card.;position:-1000,-1000;autoHeight:true;depth:19")
grpMultipleGreensRequired as integer : grpMultipleGreensRequired = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpMultipleGreensRequired, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpMultipleGreensRequired, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpMultipleGreensRequired, 2)

// HIDE CARD INFORMATION
crdHideCardInformation as integer : crdHideCardInformation = OryUICreateTextCard("width:94;headerText:Hide card information?;supportingText:If hidden you will not see card counts or percentages. To make it harder to count the exact number of cards some fake 'Go Again' cards may also be included in the deck. These cards do not affect the length of the lock in anyway, because when revealed you get to pick another card.;position:-1000,-1000;autoHeight:true;depth:19")
grpHideCardInformation as integer : grpHideCardInformation = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpHideCardInformation, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpHideCardInformation, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpHideCardInformation, 2)

// HIDE TIMER
crdHideTimer as integer : crdHideTimer = OryUICreateTextCard("width:94;headerText:Hide timer?;supportingText:If hidden you will not see how long is left of the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpHideTimer as integer : grpHideTimer = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpHideTimer, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpHideTimer, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpHideTimer, 2)

// CREATE FAKE COMBINATION
global showFakeCombinationOptions as integer
crdCreateFakeCombination as integer : crdCreateFakeCombination = OryUICreateTextCard("width:94;headerText:Create copies with fake combinations?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. You won't know which one is real or fake until you try the combination.;position:-1000,-1000;autoHeight:true;depth:19")
grpCreateFakeCombination as integer : grpCreateFakeCombination = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpCreateFakeCombination, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpCreateFakeCombination, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpCreateFakeCombination, 2)

// NUMBER OF FAKE COMBINATION COPIES?
crdNumberOfFakeCombinationCopies as integer : crdNumberOfFakeCombinationCopies = OryUICreateTextCard("width:94;headerText:Number of fake combination copies?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinMinNumberOfFakeCombinationCopies as integer : spinMinNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:19;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtNumberOfFakeCombinationCopiesTo as integer : txtNumberOfFakeCombinationCopiesTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinMaxNumberOfFakeCombinationCopies as integer : spinMaxNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:19;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// SCHEDULE AUTO RESETS?
crdScheduleAutoResets as integer : crdScheduleAutoResets = OryUICreateTextCard("width:94;headerText:Schedule auto resets?;supportingText:If yes, you will be able to set how often the lock resets. The reset will act like a keyholder reset.;position:-1000,-1000;autoHeight:true;depth:19")
grpScheduleAutoResets as integer : grpScheduleAutoResets = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpScheduleAutoResets, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpScheduleAutoResets, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpScheduleAutoResets, 2)

// RESET FREQUENCY
crdResetFrequency as integer : crdResetFrequency = OryUICreateTextCard("width:94;headerText:Reset frequency?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
txtResetFrequency as integer : txtResetFrequency = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinResetFrequency as integer : spinResetFrequency = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// MAXIMUM NUMBER OF AUTO RESETS
crdMaxNumberOfAutoResets as integer : crdMaxNumberOfAutoResets = OryUICreateTextCard("width:94;headerText:Maximum number of resets?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinMaxNumberOfAutoResets as integer : spinMaxNumberOfAutoResets = OryUICreateInputSpinner("size:27,5;min:1;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// CHECK-INS REQUIRED?
crdCheckInsRequired as integer : crdCheckInsRequired = OryUICreateTextCard("width:94;headerText:Check-ins required?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpCheckInsRequired as integer : grpCheckInsRequired = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpCheckInsRequired, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpCheckInsRequired, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpCheckInsRequired, 2)

// CHECK-IN FREQUENCY
crdCheckInFrequency as integer : crdCheckInFrequency = OryUICreateTextCard("width:94;headerText:Check-in frequency?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
txtCheckInFrequency as integer : txtCheckInFrequency = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinCheckInFrequency as integer : spinCheckInFrequency = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// LATE CHECK-INS
crdLateCheckIns as integer : crdLateCheckIns = OryUICreateTextCard("width:94;headerText:Check-in window?;supportingText:How long is the check-in window before it's classed as a late check-in?;position:-1000,-1000;autoHeight:true;depth:19")
txtLateCheckIns as integer : txtLateCheckIns = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinLateCheckIns as integer : spinLateCheckIns = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// ENABLE EARLY RELEASE WITH A PURCHASED KEY
crdEnableEarlyReleaseWithAPurchasedKey as integer : crdEnableEarlyReleaseWithAPurchasedKey = OryUICreateTextCard("width:94;headerText:Enable early release with a purchased key?;supportingText:If enabled, and in case of an emergency you have the option to purchase a digital key which will finish and unlock the lock automatically. It is recommended that you keep these enabled, especially if you're not fully used to the equipment you will be using during the lock session. If you do disable them please have a back up plan in place that will allow you to unlock early in an emergency.;position:-1000,-1000;autoHeight:true;depth:19")
grpEnableEarlyReleaseWithAPurchasedKey as integer : grpEnableEarlyReleaseWithAPurchasedKey = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpEnableEarlyReleaseWithAPurchasedKey, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpEnableEarlyReleaseWithAPurchasedKey, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpEnableEarlyReleaseWithAPurchasedKey, 1)

// NUMBER OF KEYS REQUIRED FOR EMERGENCY RELEASE?
crdNumberOfKeysRequired as integer : crdNumberOfKeysRequired = OryUICreateTextCard("width:94;headerText:Number of keys required for emergency release?;supportingText:If you want to remove the temptation of buying a key but still want the option available incase of an emergency you can choose how many keys you would need to purchase. Keys aren't lost if used on a fake lock.;position:-1000,-1000;autoHeight:true;depth:19")
txtNumberOfKeysRequired as integer : txtNumberOfKeysRequired = OryUICreateText("text:1 key required;bold:true;size:2.5;alignment:center;position:-1000,-1000;depth:19")
spinNumberOfKeysRequired as integer : spinNumberOfKeysRequired = OryUICreateInputSpinner("size:27,5;min:1;max:50;step:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// START LOCK FROZEN?
crdStartLockFrozen as integer : crdStartLockFrozen = OryUICreateTextCard("width:94;headerText:Start lock frozen?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpStartLockFrozen as integer : grpStartLockFrozen = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpStartLockFrozen, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpStartLockFrozen, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpStartLockFrozen, 2)

// DISABLE KEYHOLDER DECISION AT END OF LOCK
crdDisableKeyholderDecision as integer : crdDisableKeyholderDecision = OryUICreateTextCard("width:94;headerText:Disable keyholder decision at end of lock?;supportingText:If disabled, they will not have the option at the end of the lock to ask for your decision as to whether the combination is revealed, or the lock is reset. If you're running this as a short lock for scenarios that might be considered dangerous, and worried that you might not always be available to make the decision when they request it, then it's a good idea to disable it.;position:-1000,-1000;autoHeight:true;depth:19")
grpDisableKeyholderDecision as integer : grpDisableKeyholderDecision = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDisableKeyholderDecision, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDisableKeyholderDecision, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDisableKeyholderDecision, 2)

// LIMIT THE NUMBER OF USERS
crdLimitNumberOfUsers as integer : crdLimitNumberOfUsers = OryUICreateTextCard("width:94;headerText:Limit the number of users?;supportingText:You can set the maximum number of users you're willing to manage at one time. Once the lock has reached the maximum number of users, all new users trying to load it will see a message asking them to try again soon.;position:-1000,-1000;autoHeight:true;depth:19")
grpLimitNumberOfUsers as integer : grpLimitNumberOfUsers = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpLimitNumberOfUsers, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpLimitNumberOfUsers, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpLimitNumberOfUsers, 2)

// MAXIMUM NUMBER OF USERS
crdMaximumNumberOfUsers as integer : crdMaximumNumberOfUsers = OryUICreateTextCard("width:94;headerText:Maximum number of users?;supportingText:Fake locks aren't included in this count.;position:-1000,-1000;autoHeight:true;depth:19")
spinMaximumNumberOfUsers as integer : spinMaximumNumberOfUsers = OryUICreateInputSpinner("size:27,5;min:1;max:100;step:1;defaultValue:40;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// BLOCK USERS WITH A SPECIFIC RATING?
crdBlockUsersWithSpecificRating as integer : crdBlockUsersWithSpecificRating = OryUICreateTextCard("width:94;headerText:Block users with a specific rating?;supportingText:If yes, you can restrict the lock so that only users with a certain rating and above can load the lock which is useful if you want to block users that have been rated badly by other users. Doing so may however lower your chances of finding people to load it, and it will also block all new users which haven't been rated yet, or haven't enough ratings to calculate a fair average rating.;position:-1000,-1000;autoHeight:true;depth:19")
grpBlockUsersWithSpecificRating as integer : grpBlockUsersWithSpecificRating = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpBlockUsersWithSpecificRating, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpBlockUsersWithSpecificRating, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithSpecificRating, 2)

// MINIMUM RATING REQUIRED?
crdMinimumRatingRequired as integer : crdMinimumRatingRequired = OryUICreateTextCard("width:94;headerText:Minimum rating required?;supportingText:Based on a 5 star rating i.e. 1 is bad and 5 is excellent.;position:-1000,-1000;autoHeight:true;depth:19")
spinMinimumRatingRequired as integer : spinMinimumRatingRequired = OryUICreateInputSpinner("size:27,5;min:1;max:5;step:1;defaultValue:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// BLOCK USERS ALREADY LOCKED?
crdBlockUsersAlreadyLocked as integer : crdBlockUsersAlreadyLocked = OryUICreateTextCard("width:94;headerText:Block users already locked?;supportingText:If 'Yes' then the user won't be able to load your lock until their other locks have finished. If they are unlocked and load your lock with version 2.5.0+ of " + constAppName$ + ", they will not be able to load a lock from another keyholder until they finish or abandon this one.;position:-1000,-1000;autoHeight:true;depth:19")
grpBlockUsersAlreadyLocked as integer : grpBlockUsersAlreadyLocked = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpBlockUsersAlreadyLocked, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpBlockUsersAlreadyLocked, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersAlreadyLocked, 2)

// BLOCK USERS WITH STATS HIDDEN?
crdBlockUsersWithStatsHidden as integer : crdBlockUsersWithStatsHidden = OryUICreateTextCard("width:94;headerText:Block users with stats hidden?;supportingText:If 'Yes' then the user won't be able to load your lock if they've chosen to hide their stats and lock history.;position:-1000,-1000;autoHeight:true;depth:19")
grpBlockUsersWithStatsHidden as integer : grpBlockUsersWithStatsHidden = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpBlockUsersWithStatsHidden, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpBlockUsersWithStatsHidden, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpBlockUsersWithStatsHidden, 2)

// FORCE TRUST?
crdForceTrust as integer : crdForceTrust = OryUICreateTextCard("width:94;headerText:Only accept users that trust you?;supportingText:Saying yes will remove the option that asks the user if they trust you as a keyholder. By loading the lock they automatically agree to trusting you. With 'trust', all keyholder limitations are removed.;position:-1000,-1000;autoHeight:true;depth:19")
grpForceTrust as integer : grpForceTrust = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpForceTrust, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpForceTrust, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpForceTrust, 2)

// REQUIRE DM BEFORE LOADING?
crdRequireDM as integer : crdRequireDM = OryUICreateTextCard("width:94;headerText:Require DM before loading?;supportingText:Do you require a DM/PM (direct/private message) from the user before they load the lock? While the app can't enforce or verify it, they will have to confirm that they've contacted you before loading it. The message will also be shown on the QR code screen for when sharing.;position:-1000,-1000;autoHeight:true;depth:19")
grpRequireDM as integer : grpRequireDM = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpRequireDM, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpRequireDM, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpRequireDM, 2)

// CONTACTED KEYHOLDER?
crdContactedKeyholder as integer : crdContactedKeyholder = OryUICreateTextCard("width:94;headerText:Contacted Keyholder?;supportingText:The keyholder requires that you DM/PM (direct/private message) them before you load this lock. Have you contacted them, and have they given you permission to load the lock?;position:-1000,-1000;autoHeight:true;depth:19")
global grpContactedKeyholder as integer : grpContactedKeyholder = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpContactedKeyholder, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpContactedKeyholder, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpContactedKeyholder, 2)

// LOCK ESTIMATIONS
crdLockEstimations as integer : crdLockEstimations = OryUICreateTextCard("width:94;headerText:Lock estimations;supportingText:These estimates are based on 100 test runs of a lock with the above settings. They do not take into account time away from the app, i.e. sleeping.;position:-1000,-1000;autoHeight:true;depth:19")
lockEstimations as typeLockEstimations[4]
for i = 1 to 4
	lockEstimations[i].txtChartTitle = OryUICreateText("alignment:center;size:2.5;bold:true;depth:19")
	lockEstimations[i].sprBackground = OryUICreateSprite("size:80,8;position:-1000,-1000;depth:19")
	lockEstimations[i].txtBestCaseTitle = OryUICreateText("text:Best;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	lockEstimations[i].txtAverageCaseTitle = OryUICreateText("text:Avg.;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	lockEstimations[i].txtWorstCaseTitle = OryUICreateText("text:Worst;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	lockEstimations[i].sprBestCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	lockEstimations[i].sprAverageCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	lockEstimations[i].sprWorstCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	lockEstimations[i].txtBestCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	lockEstimations[i].txtAverageCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	lockEstimations[i].txtWorstCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	lockEstimations[i].sprChartOverlay = OryUICreateSprite("size:80,8;color:0,0,0,200;position:-1000,-1000;depth:17")
	lockEstimations[i].txtRunningSimulation = OryUICreateText("text:Running Lock Simulation XXX of XXX;size:2.6;bold:true;alignment:center;position:-1000,-1000;depth:16")	
next
btnRerunSimulation as integer : btnRerunSimulation = OryUICreateButton("size:90,5;text:Rerun Simulation;position:-1000,-1000;depth:19")

// NEXT BUTTON
screen[screenNo].btnNext = OryUICreateButton("size:30,7;text:Next;offset:15,0;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
