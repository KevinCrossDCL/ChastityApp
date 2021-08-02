
screenNo = constOthersFollowingListScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Blocked Users;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")
	
// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Followers")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Following")

// SEARCH BAR
sprOthersFollowingSearchBar as integer : sprOthersFollowingSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editOthersFollowingSearch as integer : editOthersFollowingSearch = OryUICreateTextfield("labelText:Search following...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NOT FOLLOWING ANYONE
txtOthersNotFollowingAnyoneLine1 as integer : txtOthersNotFollowingAnyoneLine1 = OryUICreateText("text:Not Following Anyone Yet;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// LIST FOLLOWING
global listOthersFollowing : listOthersFollowing = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:false;showRightButton:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
