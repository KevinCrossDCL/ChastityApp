
screenNo = constOthersFollowersListScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Blocked Users;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")
	
// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Followers")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Following")

// SEARCH BAR
sprOthersFollowersSearchBar as integer : sprOthersFollowersSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editOthersFollowersSearch as integer : editOthersFollowersSearch = OryUICreateTextfield("labelText:Search followers...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:cancel;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NO FOLLOWERS
txtOthersNoFollowersLine1 as integer : txtOthersNoFollowersLine1 = OryUICreateText("text:No Followers Yet;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// LIST FOLLOWERS
global listOthersFollowers : listOthersFollowers = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:false;showRightButton:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
