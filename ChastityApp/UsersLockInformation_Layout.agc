
screenNo = constUsersLockInformationScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Lock ID 1234567890;textAlignment:center;depth:10")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Update")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Info")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Log")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// USERNAME
sprUsersLockUsernameButton as integer : sprUsersLockUsernameButton = OryUICreateSprite("size:0,3;position:-1000,-1000;depth:19")
txtUsersLockUsername as integer : txtUsersLockUsername = OryUICreateText("text: ;size:4;bold:true;alignment:center;position:-1000,-1000;depth:18")
		
// COMBINATION
crdUsersLockCombination as integer : crdUsersLockCombination = OryUICreateTextCard("width:94;headerText:Lock Combination;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// TIME LOCKED
crdUsersLockTimeLocked as integer : crdUsersLockTimeLocked = OryUICreateTextCard("width:94;headerText:Time Locked;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// LAST CHECKED IN
crdUsersLastCheckedIn as integer : crdUsersLastCheckedIn = OryUICreateTextCard("width:94;headerText:Check-Ins;headerTextAlignment:center;supportingText:XXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// LAST UPDATED
crdUsersLockLastUpdated as integer : crdUsersLockLastUpdated = OryUICreateTextCard("width:94;headerText:Last Updated;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// LAST ONLINE
crdUsersLockLastOnline as integer : crdUsersLockLastOnline = OryUICreateTextCard("width:94;headerText:Last Online;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// LOCK FROZEN
crdUsersLockFrozen as integer : crdUsersLockFrozen = OryUICreateTextCard("width:94;headerText:Lock Frozen;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// RESETS IN
crdUsersLockResetsIn as integer : crdUsersLockResetsIn = OryUICreateTextCard("width:94;headerText:Resets In;headerTextAlignment:center;supportingText:XXXX;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// PAUSE AUTO RESETS
crdUsersPauseAutoResets as integer : crdUsersPauseAutoResets = OryUICreateTextCard("width:94;headerText:Pause Auto Resets?;headerTextAlignment:center;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpUsersPauseAutoResets as integer : grpUsersPauseAutoResets = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpUsersPauseAutoResets, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpUsersPauseAutoResets, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpUsersPauseAutoResets, 2)

// CHANCES ACCUMULATED
crdUsersLockChancesAccumulated as integer : crdUsersLockChancesAccumulated = OryUICreateTextCard("width:94;headerText:Chances Accumulated;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// TOGGLE CUMULATIVE/NON-CUMULATIVE
crdUsersToggleCumulative as integer : crdUsersToggleCumulative = OryUICreateTextCard("width:94;headerText:Cumulative / Non-Cumulative;headerTextAlignment:center;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpUsersToggleCumulative as integer : grpUsersToggleCumulative = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpUsersToggleCumulative, -1, "name:Cumulative;text:Cumulative")
OryUIInsertButtonGroupItem(grpUsersToggleCumulative, -1, "name:NonCumulative;text:Non-Cumulative")

// NEXT CHANCE IN
crdUsersLockNextChanceIn as integer : crdUsersLockNextChanceIn = OryUICreateTextCard("width:94;headerText:Next Chance To Pick;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")

// CARDS LAST PICKED
crdUsersLockCardsLastPicked as integer : crdUsersLockCardsLastPicked = OryUICreateTextCard("width:94;headerText:Cards Last Picked / Discarded;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
crdUsersLockDiscardPileImages as integer : crdUsersLockDiscardPileImages = OryUICreateTextCard("width:94;headerText:;supportingText:;position:-1000,-1000;autoHeight:false;depth:19")
sprCardsInDiscardPile as integer[11]
for i = 1 to 10
	sprCardsInDiscardPile[i] = OryUICreateSprite("size:" + str((cardWidth# * 0.4) / GetDisplayAspect()) + "," + str(cardHeight# * 0.4) + ";position:-1000,-1000;depth:18")
next

// USERS LOCK SIMULATION
crdUsersLockEstimations as integer : crdUsersLockEstimations = OryUICreateTextCard("width:94;headerText:Lock estimations;headerTextAlignment:center;supportingText:These estimates are based on 100 test runs of this lock. They do not take into account time away from the app, i.e. sleeping.;position:-1000,-1000;autoHeight:true;depth:19")
usersLockEstimations as typeLockEstimations[4]
for i = 1 to 4
	usersLockEstimations[i].txtChartTitle = OryUICreateText("alignment:center;size:2.5;bold:true;depth:19")
	usersLockEstimations[i].sprBackground = OryUICreateSprite("size:80,8;position:-1000,-1000;depth:19")
	usersLockEstimations[i].txtBestCaseTitle = OryUICreateText("text:Best;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	usersLockEstimations[i].txtAverageCaseTitle = OryUICreateText("text:Avg.;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	usersLockEstimations[i].txtWorstCaseTitle = OryUICreateText("text:Worst;size:2.5;alignment:right;position:-1000,-1000;depth:18")
	usersLockEstimations[i].sprBestCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	usersLockEstimations[i].sprAverageCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	usersLockEstimations[i].sprWorstCaseBar = OryUICreateSprite("size:0,2;position:-1000,-1000;depth:18")
	usersLockEstimations[i].txtBestCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	usersLockEstimations[i].txtAverageCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	usersLockEstimations[i].txtWorstCaseLabel = OryUICreateText("text:XX;size:2.5;position:-1000,-1000;depth:18")
	usersLockEstimations[i].sprChartOverlay = OryUICreateSprite("size:80,8;color:0,0,0,200;position:-1000,-1000;depth:17")
	usersLockEstimations[i].txtRunningSimulation = OryUICreateText("text:Running Lock Simulation XXX of XXX;size:2.6;bold:true;alignment:center;position:-1000,-1000;depth:16")	
next
btnRerunUsersLockSimulation as integer : btnRerunUsersLockSimulation = OryUICreateButton("size:90,5;text:Rerun Simulation;position:-1000,-1000;depth:19")

// ALLOW FREE UNLOCK
crdUsersAllowFreeUnlock as integer : crdUsersAllowFreeUnlock = OryUICreateTextCard("width:94;headerText:Allow user to unlock for free?;headerTextAlignment:center;supportingText:Selecting 'Yes' will allow the user to unlock for free when they need to. For example, an upcoming appointment that you may not be available to unlock them for. If the user does unlock it will be added to the log.;position:-1000,-1000;autoHeight:true;depth:19")
grpUsersAllowFreeUnlock as integer : grpUsersAllowFreeUnlock = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpUsersAllowFreeUnlock, -1, "name:Yes;text:Yes")
OryUIInsertButtonGroupItem(grpUsersAllowFreeUnlock, -1, "name:No;text:No")
OryUISetButtonGroupItemSelectedByIndex(grpUsersAllowFreeUnlock, 2)

// DELETE USER FROM LOCK
crdDeleteUserFromLock as integer : crdDeleteUserFromLock = OryUICreateTextCard("width:94;headerText:Delete user from this lock?;headerTextAlignment:center;supportingText:XXXXX;position:-1000,-1000;autoHeight:true;depth:19")
btnDeleteUserFromLock as integer : btnDeleteUserFromLock = OryUICreateButton("size:35,5;offset:17.5,0;text:Delete User;position:-1000,-1000;depth:19")

// SAVE
fabSaveUsersLockInformation as integer : fabSaveUsersLockInformation = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveUsersLockInformation)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
