
screenNo = constManageUnlockedUsersScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:ABCDEFGHIJKLM;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Locked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Unlocked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Deserted")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 2)

// FILTER BAR
sprFilterUnlockedUsersBar as integer : sprFilterUnlockedUsersBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:15")
sprFilterUnlockedUsersBarShadow as integer : sprFilterUnlockedUsersBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:15")
btnIconFilterUnlockedUsersByFlags as integer : btnIconFilterUnlockedUsersByFlags = OryUICreateButton("size:-1,3.5;offset:0,1.75;position:-1000,-1000;text: ;image:" + str(imgFlags[0]) + ";depth:12")
btnIconFilterUnlockedUsers as integer : btnIconFilterUnlockedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:14")
btnTextFilteredUnlockedUsersBy as integer : btnTextFilteredUnlockedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortUnlockedUsers as integer : btnIconSortUnlockedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedUnlockedUsersBy as integer : btnTextSortedUnlockedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER/SORT MENUS
menuFilterUnlockedUsersByFlags as integer : menuFilterUnlockedUsersByFlags = OryUICreateMenu("width:17;showLeftIcon:true;showRightIcon:true;depth:5")
menuFilterUnlockedUsers as integer : menuFilterUnlockedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
menuSortUnlockedUsers as integer : menuSortUnlockedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortUnlockedUsers as integer : grpSortUnlockedUsers = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortUnlockedUsers, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortUnlockedUsers, -1, "name:DESC;text:DESC")
if (sortUnlockedUsersOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortUnlockedUsers, 1)
if (sortUnlockedUsersOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortUnlockedUsers, 2)

// SEARCH BAR
sprUnlockedUsersSearchBar as integer : sprUnlockedUsersSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editUnlockedUsersSearch as integer : editUnlockedUsersSearch = OryUICreateTextfield("labelText:Search unlocked lockees...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:30")

// NO USERS
txtNoUnlockedUsers as integer : txtNoUnlockedUsers = OryUICreateText("text:No Users;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
