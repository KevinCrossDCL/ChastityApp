
screenNo = constUsersLockLogScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock ID 1234567890;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Update")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Info")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Log")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 3)

// FILTER BAR
sprFilterUsersLogBar as integer : sprFilterUsersLogBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:13")
sprFilterUsersLogBarShadow as integer : sprFilterUsersLogBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:13")
btnIconFilterUsersLog as integer : btnIconFilterUsersLog = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:12")
btnTextFilteredUsersLogBy as integer : btnTextFilteredUsersLogBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortUsersLog as integer : btnIconSortUsersLog = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedUsersLogBy as integer : btnTextSortedUsersLogBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER MENU
menuFilterUsersLog as integer : menuFilterUsersLog = OryUICreateMenu("width:60;showRightIcon:true;depth:5")

// SORT MENU
menuSortUsersLog as integer : menuSortUsersLog = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortUsersLog as integer : grpSortUsersLog = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortUsersLog, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortUsersLog, -1, "name:DESC;text:DESC")
if (sortUsersLogOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortUsersLog, 1)
if (sortUsersLogOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortUsersLog, 2)

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO LOG ITEMS
txtUsersNoLogItems as integer : txtUsersNoLogItems = OryUICreateText("text:No Log Items;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// LIST LOG
listUsersLog as integer : listUsersLog = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:true;noOfRightLines:1;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
