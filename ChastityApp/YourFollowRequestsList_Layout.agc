
screenNo = constYourFollowRequestsListScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Follow Requests;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")

// SEARCH BAR
sprYourFollowRequestsSearchBar as integer : sprYourFollowRequestsSearchBar = OryUICreateSprite("size:100,5.02;position:-1000,-1000;depth:19")
editYourFollowRequestsSearch as integer : editYourFollowRequestsSearch = OryUICreateTextfield("labelText:Search follow requests...;position:-1000,-1000;size:90,5;showTrailingIcon:true;trailingIcon:clear;depth:18")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NOT FOLLOWING ANYONE
txtYourNoFollowRequestsLine1 as integer : txtYourNoFollowRequestsLine1 = OryUICreateText("text:No Follow Requests;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtYourNoFollowRequestsLine2 as integer : txtYourNoFollowRequestsLine2 = OryUICreateText("text:When people ask to follow you, they will be listed here;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// LIST FOLLOW REQUESTS
global listYourFollowRequests : listYourFollowRequests = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:false;showRightButton:true;showRightIcon:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
