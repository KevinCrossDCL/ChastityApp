
screenNo = constManageLockedUsersScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:ABCDEFGHIJKLM;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Locked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Unlocked")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Deserted")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)

// FILTER BAR
sprFilterLockedUsersBar as integer : sprFilterLockedUsersBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:15")
sprFilterLockedUsersBarShadow as integer : sprFilterLockedUsersBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:15")
btnIconFilterLockedUsersByFlags as integer : btnIconFilterLockedUsersByFlags = OryUICreateButton("size:-1,3.5;offset:0,1.75;position:-1000,-1000;text: ;image:" + str(imgFlags[0]) + ";depth:12")
btnIconFilterLockedUsers as integer : btnIconFilterLockedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:14")
btnTextFilteredLockedUsersBy as integer : btnTextFilteredLockedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnIconSortLockedUsers as integer : btnIconSortLockedUsers = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgSortIconDescending) + ";depth:12")
btnTextSortedLockedUsersBy as integer : btnTextSortedLockedUsersBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Sort[colon];textSize:2;textAlignment:right;depth:12")

// FILTER/SORT MENUS
menuFilterLockedUsersByFlags as integer : menuFilterLockedUsersByFlags = OryUICreateMenu("width:17;showLeftIcon:true;showRightIcon:true;depth:5")
menuFilterLockedUsers as integer : menuFilterLockedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
menuSortLockedUsers as integer : menuSortLockedUsers = OryUICreateMenu("width:60;showRightIcon:true;depth:5")
grpSortLockedUsers as integer : grpSortLockedUsers = OryUICreateButtonGroup("size:60," + str(oryUIDefaults.menuItemHeight#) + ";position:-1000,-1000;depth:2")
OryUIInsertButtonGroupItem(grpSortLockedUsers, -1, "name:ASC;text:ASC")
OryUIInsertButtonGroupItem(grpSortLockedUsers, -1, "name:DESC;text:DESC")
if (sortLockedUsersOrder$ = "ASC") then OryUISetButtonGroupItemSelectedByIndex(grpSortLockedUsers, 1)
if (sortLockedUsersOrder$ = "DESC") then OryUISetButtonGroupItemSelectedByIndex(grpSortLockedUsers, 2)

// SEARCH BAR
sprLockedUsersSearchBar as integer : sprLockedUsersSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editLockedUsersSearch as integer : editLockedUsersSearch = OryUICreateTextfield("labelText:Search locked lockees...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:cancel;depth:18")

// LAST REFRESHED BAR
sprLockedUsersLastRefreshedBar as integer : sprLockedUsersLastRefreshedBar = OryUICreateSprite("size:100,3;position:-1000,-1000;depth:15")
sprLockedUsersLastRefreshedBarShadow as integer : sprLockedUsersLastRefreshedBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopShadowImage) + ";position:-1000,-1000;depth:15")
txtLockedUsersLastRefreshed as integer : txtLockedUsersLastRefreshed = OryUICreateText("text:Last Refreshed[colon] XXm XXs ago;size:2.2;alignment:center;position:-1000,-1000")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:30")

// NO USERS
txtNoLockedUsers as integer : txtNoLockedUsers = OryUICreateText("text:No Users;size:3;bold:true;position:-1000,-1000;alignment:center;depth:29")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
