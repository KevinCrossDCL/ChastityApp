
screenNo = constYourFollowingListScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Blocked Users;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")
	
// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Followers")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Following")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Blocked")

// SEARCH BAR
sprYourFollowingSearchBar as integer : sprYourFollowingSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editYourFollowingSearch as integer : editYourFollowingSearch = OryUICreateTextfield("labelText:Search following...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NOT FOLLOWING ANYONE
txtYourNotFollowingAnyoneLine1 as integer : txtYourNotFollowingAnyoneLine1 = OryUICreateText("text:Not Following Anyone Yet;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtYourNotFollowingAnyoneLine2 as integer : txtYourNotFollowingAnyoneLine2 = OryUICreateText("text:When you follow people, they will be listed here" + chr(10) + chr(10) + "You can follow people you interact with via their profile screen;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// LIST FOLLOWING
global listYourFollowing : listYourFollowing = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:false;showRightButton:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
