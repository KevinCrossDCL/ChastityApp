
screenNo = constSharedLockInformationScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:" + constAppName$ + " Lock 1;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// LOCK NAME
crdSharedLockName as integer : crdSharedLockName = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
editBoxSharedLockName as integer : editBoxSharedLockName = OryUICreateTextfield("labelText:Name;position:-1000,-1000;width:90;showTrailingIcon:true;trailingIcon:cancel;depth:19")

// QR CODE URL
crdSharedLockQRCodeURL as integer : crdSharedLockQRCodeURL = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
btnSharedLockQRCodeURL as integer : btnSharedLockQRCodeURL = OryUICreateButton("size:94,5;text:XXXX;position:-1000,-1000;depth:19")

// LOCK CONFIGURATION
crdSharedLockConfiguration as integer : crdSharedLockConfiguration = OryUICreateTextCard("width:94;headerText:Lock Configuration;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// TEMPORARILY DISABLE LOCK?
crdTemporarilyDisable as integer : crdTemporarilyDisable = OryUICreateTextCard("width:94;headerText:Temporarily Disable Lock?;supportingText:Temporarily disabling this lock would stop people from being able to load it until it is enabled again. It won't affect anyone that is already locked with it.;position:-1000,-1000;autoHeight:true;depth:19")
grpTemporarilyDisable as integer : grpTemporarilyDisable = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpTemporarilyDisable, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpTemporarilyDisable, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpTemporarilyDisable, 2)

// SHARE IN APP API
crdShareInAPI as integer : crdShareInAPI = OryUICreateTextCard("width:94;headerText:Share in " + constAppName$ + " API?;supportingText:Making this lock available to the " + constAppName$ + " API will allow other developers to create services where they could display this, and any other shared locks you've allowed. It may also eventually make them available on your profile page within the " + constAppName$ + " app and via future search options.;position:-1000,-1000;autoHeight:true;depth:19")
grpShareInAPI as integer : grpShareInAPI = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpShareInAPI, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpShareInAPI, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpShareInAPI, 2)

// HIDE CARD INFORMATION
crdSharedLockShowCardInformation as integer : crdSharedLockShowCardInformation = OryUICreateTextCard("width:94;headerText:Hide card information?;supportingText:If hidden they will not see card counts or percentages. To make it harder to count the exact number of cards some fake 'Go Again' cards may also be included in the deck. These cards do not affect the length of the lock in anyway, because when revealed they get to pick another card.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockShowCardInformation as integer : grpSharedLockShowCardInformation = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockShowCardInformation, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockShowCardInformation, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockShowCardInformation, 2)

// HIDE TIMER
crdSharedLockHideTimer as integer : crdSharedLockHideTimer = OryUICreateTextCard("width:94;headerText:Hide timer?;supportingText:If hidden you will not see how long is left of the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockHideTimer as integer : grpSharedLockHideTimer = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockHideTimer, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockHideTimer, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockHideTimer, 2)

// CREATE FAKE COMBINATION
crdSharedLockCreateFakeCombination as integer : crdSharedLockCreateFakeCombination = OryUICreateTextCard("width:94;headerText:Create copies with fake combinations?;supportingText:Multiple copies of the same lock can be created, each with a fake combination. You won't know which one is real or fake until you try the combination.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockCreateFakeCombination as integer : grpSharedLockCreateFakeCombination = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockCreateFakeCombination, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockCreateFakeCombination, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCreateFakeCombination, 2)

// NUMBER OF FAKE COMBINATION COPIES?
crdSharedLockNumberOfFakeCombinationCopies as integer : crdSharedLockNumberOfFakeCombinationCopies = OryUICreateTextCard("width:94;headerText:Number of fake combination copies?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
spinSharedLockMinNumberOfFakeCombinationCopies as integer : spinSharedLockMinNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:19;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
txtSharedLockNumberOfFakeCombinationCopiesTo as integer : txtSharedLockNumberOfFakeCombinationCopiesTo = OryUICreateText("text:to;size:3.5;alignment:center;position:-1000,-1000;depth:19")
spinSharedLockMaxNumberOfFakeCombinationCopies as integer : spinSharedLockMaxNumberOfFakeCombinationCopies = OryUICreateInputSpinner("size:27,5;min:0;max:19;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// SCHEDULE AUTO RESETS?
crdSharedLockScheduleAutoResets as integer : crdSharedLockScheduleAutoResets = OryUICreateTextCard("width:94;headerText:Schedule auto resets?;supportingText:If yes, you will be able to set how often the lock resets. The reset will act like a keyholder reset.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockScheduleAutoResets as integer : grpSharedLockScheduleAutoResets = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockScheduleAutoResets, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockScheduleAutoResets, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockScheduleAutoResets, 2)

// RESET FREQUENCY
crdSharedLockResetFrequency as integer : crdSharedLockResetFrequency = OryUICreateTextCard("width:94;headerText:Reset frequency?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
txtSharedLockResetFrequency as integer : txtSharedLockResetFrequency = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinSharedLockResetFrequency as integer : spinSharedLockResetFrequency = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// MAXIMUM NUMBER OF AUTO RESETS
crdSharedLockMaxNumberOfAutoResets as integer : crdSharedLockMaxNumberOfAutoResets = OryUICreateTextCard("width:94;headerText:Maximum number of resets?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinSharedLockMaxNumberOfAutoResets as integer : spinSharedLockMaxNumberOfAutoResets = OryUICreateInputSpinner("size:27,5;min:1;max:20;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// CHECK-INS REQUIRED?
crdSharedLockCheckInsRequired as integer : crdSharedLockCheckInsRequired = OryUICreateTextCard("width:94;headerText:Check-ins required?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockCheckInsRequired as integer : grpSharedLockCheckInsRequired = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockCheckInsRequired, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockCheckInsRequired, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockCheckInsRequired, 2)

// AGREE TO CHECK-IN CHANGE?
crdSharedLockAgreeToCheckInChange as integer : crdSharedLockAgreeToCheckInChange = OryUICreateTextCard("width:94;headerText:Change current check-in settings?;supportingText:Changing the current check-in settings will let you also choose how long after a check-in is required before it's classed as late, but it may mean that the current gap between each check-in is no longer valid, and once changed you won't be able to revert it. If you choose to leave it with the current settings it will still work for all future users loading the lock.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockAgreeToCheckInChange as integer : grpSharedLockAgreeToCheckInChange = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockAgreeToCheckInChange, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockAgreeToCheckInChange, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockAgreeToCheckInChange, 2)

// CHECK-IN FREQUENCY
crdSharedLockCheckInFrequency as integer : crdSharedLockCheckInFrequency = OryUICreateTextCard("width:94;headerText:Check-in frequency?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
txtSharedLockCheckInFrequency as integer : txtSharedLockCheckInFrequency = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinSharedLockCheckInFrequency as integer : spinSharedLockCheckInFrequency = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// LATE CHECK-INS
crdSharedLockLateCheckIns as integer : crdSharedLockLateCheckIns = OryUICreateTextCard("width:94;headerText:Check-in window?;supportingText:How long is the check-in window before it's classed as a late check-in?;position:-1000,-1000;autoHeight:true;depth:19")
txtSharedLockLateCheckIns as integer : txtSharedLockLateCheckIns = OryUICreateText("text:Every day;size:3;alignment:center;position:-1000,-1000;depth:16")
spinSharedLockLateCheckIns as integer : spinSharedLockLateCheckIns = OryUICreateInputSpinner("size:90,5;min:2;max:399;step:1;maxLength:3;autoCorrectIfOutOfRange:true;disableKeyboardInput:true;position:-1000,-1000;depth:18")

// ENABLE EARLY RELEASE WITH A PURCHASED KEY
crdSharedLockEnableEarlyReleaseWithAPurchasedKey as integer : crdSharedLockEnableEarlyReleaseWithAPurchasedKey = OryUICreateTextCard("width:94;headerText:Enable early release with a purchased key?;supportingText:Once enabled, they can not be disabled again;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockEnableEarlyReleaseWithAPurchasedKey as integer : grpSharedLockEnableEarlyReleaseWithAPurchasedKey = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockEnableEarlyReleaseWithAPurchasedKey, 1)

// START LOCK FROZEN
crdSharedLockStartLockFrozen as integer : crdSharedLockStartLockFrozen = OryUICreateTextCard("width:94;headerText:Start lock frozen?;supportingText:If yes, the lock will automatically be frozen when they load the lock and it will remain frozen until you unfreeze it.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockStartLockFrozen as integer : grpSharedLockStartLockFrozen = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockStartLockFrozen, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockStartLockFrozen, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockStartLockFrozen, 2)

// DISABLE KEYHOLDER DECISION AT END OF LOCK
crdSharedLockDisableKeyholderDecision as integer : crdSharedLockDisableKeyholderDecision = OryUICreateTextCard("width:94;headerText:Disable keyholder decision at end of lock?;supportingText:If disabled, they will not have the option at the end of the lock to ask for your decision as to whether the combination is revealed, or the lock is reset. If you're running this as a short lock for scenarios that might be considered dangerous, and worried that you might not always be available to make the decision when they request it, then it's a good idea to disable it.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockDisableKeyholderDecision as integer : grpSharedLockDisableKeyholderDecision = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockDisableKeyholderDecision, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockDisableKeyholderDecision, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockDisableKeyholderDecision, 2)

// LIMIT THE NUMBER OF USERS
crdSharedLockLimitNumberOfUsers as integer : crdSharedLockLimitNumberOfUsers = OryUICreateTextCard("width:94;headerText:Limit the number of users?;supportingText:You can set the maximum number of users you want to manage at once with on this lock. Once the lock has reached the maximum number of users, all new users trying to load it will see a message asking them to try again soon.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockLimitNumberOfUsers as integer : grpSharedLockLimitNumberOfUsers = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockLimitNumberOfUsers, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockLimitNumberOfUsers, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockLimitNumberOfUsers, 2)

// MAXIMUM NUMBER OF USERS
crdSharedLockMaximumNumberOfUsers as integer : crdSharedLockMaximumNumberOfUsers = OryUICreateTextCard("width:94;headerText:Maximum number of users?;supportingText:Fake locks aren't included in this count.;position:-1000,-1000;autoHeight:true;depth:19")
spinSharedLockMaximumNumberOfUsers as integer : spinSharedLockMaximumNumberOfUsers = OryUICreateInputSpinner("size:27,5;min:1;max:100;step:1;defaultValue:40;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// BLOCK USERS WITH A SPECIFIC RATING?
crdSharedLockBlockUsersWithSpecificRating as integer : crdSharedLockBlockUsersWithSpecificRating = OryUICreateTextCard("width:94;headerText:Block users with a specific rating?;supportingText:If yes, you can restrict the lock so that only users with a certain rating and above can load the lock which is useful if you want to block users that have been rated badly by other users. Doing so may however lower your chances of finding people to load it, and it will also block all new users which haven't been rated yet, or haven't enough ratings to calculate a fair average rating.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockBlockUsersWithSpecificRating as integer : grpSharedLockBlockUsersWithSpecificRating = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersWithSpecificRating, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersWithSpecificRating, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithSpecificRating, 2)

// MINIMUM RATING REQUIRED?
crdSharedLockMinimumRatingRequired as integer : crdSharedLockMinimumRatingRequired = OryUICreateTextCard("width:94;headerText:Minimum rating required?;supportingText:Based on a 5 star rating i.e. 1 is bad and 5 is excellent.;position:-1000,-1000;autoHeight:true;depth:19")
spinSharedLockMinimumRatingRequired as integer : spinSharedLockMinimumRatingRequired = OryUICreateInputSpinner("size:27,5;min:1;max:5;step:1;defaultValue:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// BLOCK USERS ALREADY LOCKED?
crdSharedLockBlockUsersAlreadyLocked as integer : crdSharedLockBlockUsersAlreadyLocked = OryUICreateTextCard("width:94;headerText:Block users already locked?;supportingText:If 'Yes' then the user won't be able to load your lock until their other locks have finished. If they are unlocked and load your lock with version 2.5.0+ of " + constAppName$ + ", they will not be able to load a lock from another keyholder until they finish or abandon this one.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockBlockUsersAlreadyLocked as integer : grpSharedLockBlockUsersAlreadyLocked = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersAlreadyLocked, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersAlreadyLocked, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersAlreadyLocked, 2)

// BLOCK USERS WITH STATS HIDDEN?
crdSharedLockBlockUsersWithStatsHidden as integer : crdSharedLockBlockUsersWithStatsHidden = OryUICreateTextCard("width:94;headerText:Block users with stats hidden?;supportingText:If 'Yes' then the user won't be able to load your lock if they've chosen to hide their stats and lock history.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockBlockUsersWithStatsHidden as integer : grpSharedLockBlockUsersWithStatsHidden = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersWithStatsHidden, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockBlockUsersWithStatsHidden, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockBlockUsersWithStatsHidden, 2)

// FORCE TRUST?
crdSharedLockForceTrust as integer : crdSharedLockForceTrust = OryUICreateTextCard("width:94;headerText:Only accept users that trust you?;supportingText:Once you choose 'No', you will not be able to change it again.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockForceTrust as integer : grpSharedLockForceTrust = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockForceTrust, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockForceTrust, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockForceTrust, 2)

// REQUIRE DM BEFORE LOADING?
crdSharedLockRequireDM as integer : crdSharedLockRequireDM = OryUICreateTextCard("width:94;headerText:Require DM before loading?;supportingText:Do you require a DM/PM (direct/private message) from the user before they load the lock? While the app can't enforce or verify it, they will have to confirm that they've contacted you before loading it. The message will also be shown on the QR code screen for when sharing.;position:-1000,-1000;autoHeight:true;depth:19")
grpSharedLockRequireDM as integer : grpSharedLockRequireDM = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSharedLockRequireDM, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpSharedLockRequireDM, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpSharedLockRequireDM, 2)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")

// SAVE
fabSaveSharedLockInformation as integer : fabSaveSharedLockInformation = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveSharedLockInformation)
