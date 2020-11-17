
screenNo = constMyLocksScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:menu;navigationName:Menu;text:" + constAppName$ + ";depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Profile;icon:profile")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")
sprMyLocksStatusIcon as integer : sprMyLocksStatusIcon = OryUICreateSprite("size:-1,2;position:-1000,-1000;depth:9")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:My Locks")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Shared Locks")

// FILTER BAR
sprFilterMyLocksBar as integer : sprFilterMyLocksBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:13")
sprFilterMyLocksBarShadow as integer : sprFilterMyLocksBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:13")
btnIconFilterMyLocksByFlags as integer : btnIconFilterMyLocksByFlags = OryUICreateButton("size:-1,3.5;offset:0,1.75;position:-1000,-1000;text: ;image:" + str(imgFlags[0]) + ";depth:12")
btnIconFilterMyLocks as integer : btnIconFilterMyLocks = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:12")
btnTextFilteredMyLocksBy as integer : btnTextFilteredMyLocksBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortMyLocks as integer : btnIconSortMyLocks = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconAscending) + ";depth:12")
btnTextSortedMyLocksBy as integer : btnTextSortedMyLocksBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER MENUS
menuFilterMyLocksByFlags as integer : menuFilterMyLocksByFlags = OryUICreateMenu("width:17;showLeftIcon:true;showRightIcon:true;depth:5")
menuFilterMyLocks as integer : menuFilterMyLocks = OryUICreateMenu("width:60;showRightIcon:true;depth:5")

// SORT MENU
menuSortMyLocks as integer : menuSortMyLocks = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortMyLocks as integer : grpSortMyLocks = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortMyLocks, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortMyLocks, -1, "name:DESC;text:DESC")
if (sortMyLocksOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortMyLocks, 1)
if (sortMyLocksOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortMyLocks, 2)

// SEARCH BAR
sprMyLocksSearchBar as integer : sprMyLocksSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editMyLocksSearch as integer : editMyLocksSearch = OryUICreateTextfield("labelText:Search your locks and keyholders...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:cancel;depth:18")

// DIALOG
screen[screenNo].dialog = OryUICreateDialog("autoHeight:true")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO LOCKS
txtNoMyLocks as integer : txtNoMyLocks = OryUICreateText("text:No Locks;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtPressPlusToCreateMyLock as integer : txtPressPlusToCreateMyLock = OryUICreateText("text:Press the + button below to create new locks;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// ADD BUTTON
fabAddMyLock as integer : fabAddMyLock = OryUICreateFloatingActionButton("icon:Add;depth:10")
OryUIHideFloatingActionButton(fabAddMyLock)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
