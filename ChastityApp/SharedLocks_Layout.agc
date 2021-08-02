
screenNo = constSharedLocksScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:menu;navigationName:Menu;text:" + constAppName$ + ";depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Profile;icon:account_box")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")
sprSharedLocksStatusIcon as integer : sprSharedLocksStatusIcon = OryUICreateSprite("size:-1,2;position:-1000,-1000;depth:9")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[constSharedLocksScreen].tabs, -1, "text:My Locks")
OryUIInsertTabsButton(screen[constSharedLocksScreen].tabs, -1, "text:Shared Locks")

// FILTER BAR
sprFilterSharedLocksBar as integer : sprFilterSharedLocksBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:15")
sprFilterSharedLocksBarShadow as integer : sprFilterSharedLocksBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:15")
btnIconFilterSharedLocks as integer : btnIconFilterSharedLocks = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:14")
btnTextFilteredSharedLocksBy as integer : btnTextFilteredSharedLocksBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortSharedLocks as integer : btnIconSortSharedLocks = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedSharedLocksBy as integer : btnTextSortedSharedLocksBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER/SORT MENUS
menuFilterSharedLocks as integer : menuFilterSharedLocks = OryUICreateMenu("width:80;showRightIcon:true;depth:5")
menuSortSharedLocks as integer : menuSortSharedLocks = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortSharedLocks as integer : grpSortSharedLocks = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortSharedLocks, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortSharedLocks, -1, "name:DESC;text:DESC")
if (sortSharedLocksOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortSharedLocks, 1)
if (sortSharedLocksOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortSharedLocks, 2)

// SEARCH BAR
sprSharedLocksSearchBar as integer : sprSharedLocksSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
global editSharedLocksSearch : editSharedLocksSearch = OryUICreateTextfield("labelText:Search your locks and lockees...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO LOCKS
txtNoSharedLocks as integer : txtNoSharedLocks = OryUICreateText("text:No Shared Locks;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtPressPlusToCreateSharedLock as integer : txtPressPlusToCreateSharedLock = OryUICreateText("text:Press the + button below to create new locks;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// ADD BUTTON
fabAddSharedLock as integer : fabAddSharedLock = OryUICreateFloatingActionButton("icon:Add;depth:10")
OryUIHideFloatingActionButton(fabAddSharedLock)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
