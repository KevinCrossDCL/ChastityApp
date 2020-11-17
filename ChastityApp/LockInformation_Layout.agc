
screenNo = constLockInformationScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock ID 1234567890;textAlignment:center;depth:10")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Info")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Log")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)

// DIALOG
screen[screenNo].dialog = OryUICreateDialog("autoHeight:true")
		
// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// LOCK NAME
crdLockName as integer : crdLockName = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
editBoxLockName as integer : editBoxLockName = OryUICreateTextfield("labelText:Name;position:-1000,-1000;width:90;showTrailingIcon:true;trailingIcon:cancel;depth:19")

// API LOCK IDs
crdAPILockIDs as integer : crdAPILockIDs = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// QR CODE URL
crdQRCodeURL as integer : crdQRCodeURL = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText: ;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
btnQRCodeURL as integer : btnQRCodeURL = OryUICreateButton("size:94,5;text:XXXX;position:-1000,-1000;depth:19")

// LOCK TYPE
crdLockType as integer : crdLockType = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// TIME LOCKED
crdTimeLocked as integer : crdTimeLocked = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// CHECK-IN
crdCheckIn as integer : crdCheckIn = OryUICreateTextCard("width:94;headerText:Check-In;headerTextAlignment:center;supportingText:Last checked in XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
btnCheckIn as integer : btnCheckIn = OryUICreateButton("size:30,5;text:Check-In;offset:15,0;position:-1000,-1000;depth:14")

// RESETS IN
crdResetsIn as integer : crdResetsIn = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// LAST X UPDATES
crdLastXUpdates as integer : crdLastXUpdates = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
listLastXUpdates as integer : listLastXUpdates = OryUICreateList("noOfLeftLines:1;noOfRightLines:1;itemSize:100,8;position:-1000,-1000;depth:19")

// CARDS LAST PICKED
crdCardsLastPicked as integer : crdCardsLastPicked = OryUICreateTextCard("width:94;headerText:Cards Last Picked / Discarded;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
crdDiscardPileImages as integer : crdDiscardPileImages = OryUICreateTextCard("width:94;headerText:;supportingText:;position:-1000,-1000;autoHeight:false;depth:19")
sprDiscardPile as integer[11]
for i = 1 to 10
	sprDiscardPile[i] = OryUICreateSprite("size:" + str((cardWidth# * 0.40) / GetDisplayAspect()) + "," + str(cardHeight# * 0.40) + ";position:-1000,-1000;depth:18")
next

// CARD COUNTS
crdCardCounts as integer : crdCardCounts = OryUICreateTextCard("width:94;headerText:XXXX;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
crdCardImages as integer : crdCardImages = OryUICreateTextCard("width:94;headerText: ;supportingText: ;position:-1000,-1000;autoHeight:false;depth:19")
sprCardsInLock as integer[7]
sprCardsInLockSecretSticker as integer[7]
btnCardsInLockAdd as integer[7]
txtCardsInLockCount as integer[7]
txtCardsInLockPercentage as integer[7]
for i = 1 to 7
	sprCardsInLock[i] = OryUICreateSprite("size:" + str((cardWidth# * 0.8) / GetDisplayAspect()) + "," + str(cardHeight# * 0.8) + ";offset:" + str(((cardWidth# * 0.8) / GetDisplayAspect()) / 2) + ",0;position:-1000,-1000;depth:18")
	sprCardsInLockSecretSticker[i] = OryUICreateSprite("size:16,-1;offset:center;position:-1000,-1000;image:" + str(imgRectangleSecretSticker) + ";angle:" + str(random(350, 370)) + ";depth:17")
	txtCardsInLockCount[i] = OryUICreateText("text:XXXX;size:3.2;bold:true;alignment:center;position:-1000,-1000;depth:18")
	txtCardsInLockPercentage[i] = OryUICreateText("text:XXXX;size:2.2;alignment:center;position:-1000,-1000;depth:18")
	btnCardsInLockAdd[i] = OryUICreateButton("size:-1,3;icon:add;position:-1000,-1000;depth:18")
next

// CURRENT LOCK SIMULATION
crdCurrentLockEstimations as integer : crdCurrentLockEstimations = OryUICreateTextCard("width:94;headerText:Lock estimations;supportingText:These estimates are based on 100 test runs of this lock. They do not take into account time away from the app, i.e. sleeping.;position:-1000,-1000;autoHeight:true;depth:19")
currentLockEstimations as typeLockEstimations[4]
for i = 1 to 4
	currentLockEstimations[i].txtChartTitle = OryUICreateText("alignment:center;size:2.5;bold:true;depth:19")
	currentLockEstimations[i].sprBackground = OryUICreateSprite("size:80,8;position:-1000,-1000;depth:19")
	currentLockEstimations[i].txtBestCaseTitle = OryUICreateText("text:Best;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	currentLockEstimations[i].txtAverageCaseTitle = OryUICreateText("text:Avg.;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	currentLockEstimations[i].txtWorstCaseTitle = OryUICreateText("text:Worst;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	currentLockEstimations[i].sprBestCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	currentLockEstimations[i].sprAverageCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	currentLockEstimations[i].sprWorstCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	currentLockEstimations[i].txtBestCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	currentLockEstimations[i].txtAverageCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	currentLockEstimations[i].txtWorstCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	currentLockEstimations[i].sprChartOverlay = OryUICreateSprite("size:80,8;color:0,0,0,200;position:-1000,-1000;depth:17")
	currentLockEstimations[i].txtRunningSimulation = OryUICreateText("text:Running Lock Simulation XXX of XXX;size:2.6;bold:true;alignment:center;position:-1000,-1000;depth:16")	
next
btnRerunCurrentLockSimulation as integer : btnRerunCurrentLockSimulation = OryUICreateButton("size:90,5;text:Rerun Simulation;position:-1000,-1000;depth:19")

// ADD TIME TO LOCK?
crdAddTimeToLock as integer : crdAddTimeToLock = OryUICreateTextCard("width:94;headerText:Add time to lock?;supportingText:This can not be undone once time has been added.;position:-1000,-1000;autoHeight:true;depth:19")
crdMinAddTimeToLock as integer : crdMinAddTimeToLock = OryUICreateTextCard("width:94;headerText:Minimum time to add?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMinAddDays as integer : txtMinAddDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinAddHours as integer : txtMinAddHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinAddMinutes as integer : txtMinAddMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
spinMinAddNumberOfDays as integer : spinMinAddNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMinAddNumberOfHours as integer : spinMinAddNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMinAddNumberOfMinutes as integer : spinMinAddNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
crdMaxAddTimeToLock as integer : crdMaxAddTimeToLock = OryUICreateTextCard("width:94;headerText:Maximum time to add?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMaxAddDays as integer : txtMaxAddDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxAddHours as integer : txtMaxAddHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxAddMinutes as integer : txtMaxAddMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
spinMaxAddNumberOfDays as integer : spinMaxAddNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxAddNumberOfHours as integer : spinMaxAddNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
spinMaxAddNumberOfMinutes as integer : spinMaxAddNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// IS THIS A TEST LOCK?
crdTestLock as integer : crdTestLock = OryUICreateTextCard("width:94;headerText:Is this a test lock?;supportingText:Test locks won't be included in your lock history and stats.;position:-1000,-1000;autoHeight:true;depth:19")
grpTestLock as integer : grpTestLock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpTestLock, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpTestLock, -1, "name:No;text:No")

// TRUST THE KEYHOLDER?
crdTrustTheKeyholder as integer : crdTrustTheKeyholder = OryUICreateTextCard("width:94;headerText:Do you trust the keyholder?;supportingText:Trusting the keyholder will remove all limitations from them as your keyholder on this lock and any other locks within the same group that may have been created at the same time i.e. fake copies. This means that they can add/remove as much time as they want, and as often as they want. It also means that the lock can run for a lot longer than you expected. This can not be undone once changed.;position:-1000,-1000;autoHeight:true;depth:19")
grpTrustTheKeyholder as integer : grpTrustTheKeyholder = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpTrustTheKeyholder, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpTrustTheKeyholder, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpTrustTheKeyholder, 2)

// DISABLE KEYS?
crdDisableKeys as integer : crdDisableKeys = OryUICreateTextCard("width:94;headerText:Disable keys?;supportingText:If disabled you won't be able to purchase digital keys to unlock early if you need to in an emergency. It will disable keys on all locks within the same group of locks that were created at the same time, if fake copies were created. It's recommended to leave the keys enabled if this is the first time you've locked with this keyholder. This can not be undone once changed.;position:-1000,-1000;autoHeight:true;depth:19")
grpDisableKeys as integer : grpDisableKeys = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpDisableKeys, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpDisableKeys, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpDisableKeys, 2)

// INCREASE NUMBER OF KEYS REQUIRED FOR EMERGENCY RELEASE?
crdIncreaseNumberOfKeysRequired as integer : crdIncreaseNumberOfKeysRequired = OryUICreateTextCard("width:94;headerText:Increase number of keys required for emergency release?;supportingText:If you want to remove the temptation of buying a key but still want the option available incase of an emergency you can choose how many keys you would need to purchase. Keys aren't lost if used on a fake lock.;position:-1000,-1000;autoHeight:true;depth:19")
txtIncreaseNumberOfKeysRequired as integer : txtIncreaseNumberOfKeysRequired = OryUICreateText("text:1 key required;bold:true;size:2.5;alignment:center;position:-1000,-1000;depth:19")
spinIncreaseNumberOfKeysRequired as integer : spinIncreaseNumberOfKeysRequired = OryUICreateInputSpinner("size:27,5;min:1;max:50;step:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")

// SAVE
fabSaveLockInformation as integer : fabSaveLockInformation = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveLockInformation)
