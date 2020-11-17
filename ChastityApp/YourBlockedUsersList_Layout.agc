
screenNo = constYourBlockedUsersListScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Blocked Users;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")
	
// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Followers")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Following")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Blocked")

// SEARCH BAR
sprYourBlockedUsersSearchBar as integer : sprYourBlockedUsersSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editYourBlockedUsersSearch as integer : editYourBlockedUsersSearch = OryUICreateTextfield("labelText:Search blocked users...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:cancel;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NO BLOCKED USERS
txtYourNoBlockedUsersLine1 as integer : txtYourNoBlockedUsersLine1 = OryUICreateText("text:No Blocked Users;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtYourNoBlockedUsersLine2 as integer : txtYourNoBlockedUsersLine2 = OryUICreateText("text:You haven't blocked anyone yet;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// LIST BLOCKED USERS
global listYourBlockedUsers : listYourBlockedUsers = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:false;showRightButton:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
