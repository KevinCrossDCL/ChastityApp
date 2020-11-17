
screenNo = constLockLogScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock ID 1234567890;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Info")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Log")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)

// FILTER BAR
sprFilterLogBar as integer : sprFilterLogBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:13")
sprFilterLogBarShadow as integer : sprFilterLogBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:13")
btnIconFilterLog as integer : btnIconFilterLog = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:12")
btnTextFilteredLogBy as integer : btnTextFilteredLogBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortLog as integer : btnIconSortLog = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedLogBy as integer : btnTextSortedLogBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER MENU
menuFilterLog as integer : menuFilterLog = OryUICreateMenu("width:60;showRightIcon:true;depth:5")

// SORT MENU
menuSortLog as integer : menuSortLog = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortLog as integer : grpSortLog = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortLog, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortLog, -1, "name:DESC;text:DESC")
if (sortLogOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortLog, 1)
if (sortLogOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortLog, 2)

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO LOG ITEMS
txtNoLogItems as integer : txtNoLogItems = OryUICreateText("text:No Log Items;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// LIST LOG
listLockLog as integer : listLockLog = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:true;noOfRightLines:1;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
