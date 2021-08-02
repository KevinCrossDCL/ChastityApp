
screenNo = constManageDesertedUsersScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:ABCDEFGHIJKLM;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Locked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Unlocked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Deserted")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 3)

// FILTER BAR
sprFilterDesertedUsersBar as integer : sprFilterDesertedUsersBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:15")
sprFilterDesertedUsersBarShadow as integer : sprFilterDesertedUsersBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:15")
btnIconFilterDesertedUsersByFlags as integer : btnIconFilterDesertedUsersByFlags = OryUICreateButton("size:-1,3.5;offset:0,1.75;position:-1000,-1000;text: ;image:" + str(imgFlags[0]) + ";depth:12")
btnIconFilterDesertedUsers as integer : btnIconFilterDesertedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:14")
btnTextFilteredDesertedUsersBy as integer : btnTextFilteredDesertedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortDesertedUsers as integer : btnIconSortDesertedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedDesertedUsersBy as integer : btnTextSortedDesertedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER/SORT MENUS
menuFilterDesertedUsersByFlags as integer : menuFilterDesertedUsersByFlags = OryUICreateMenu("width:17;showLeftIcon:true;showRightIcon:true;depth:5")
menuFilterDesertedUsers as integer : menuFilterDesertedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
menuSortDesertedUsers as integer : menuSortDesertedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortDesertedUsers as integer : grpSortDesertedUsers = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortDesertedUsers, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortDesertedUsers, -1, "name:DESC;text:DESC")
if (sortDesertedUsersOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortDesertedUsers, 1)
if (sortDesertedUsersOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortDesertedUsers, 2)

// SEARCH BAR
sprDesertedUsersSearchBar as integer : sprDesertedUsersSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editDesertedUsersSearch as integer : editDesertedUsersSearch = OryUICreateTextfield("labelText:Search deserted lockees...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:30")

// NO USERS
txtNoDesertedUsers as integer : txtNoDesertedUsers = OryUICreateText("text:No Users;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
