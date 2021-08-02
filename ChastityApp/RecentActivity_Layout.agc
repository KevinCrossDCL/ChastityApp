
screenNo = constRecentActivityScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Recent Activity;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// FILTER BAR
sprFilterRecentActivityBar as integer : sprFilterRecentActivityBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:13")
sprFilterRecentActivityBarShadow as integer : sprFilterRecentActivityBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:13")
btnIconFilterRecentActivity as integer : btnIconFilterRecentActivity = OryUICreateButton("size:-1,3;offset:0,1.5;position:-1000,-1000;text: ;image:" + str(imgFilterIcon) + ";depth:12")
btnTextFilteredRecentActivityBy as integer : btnTextFilteredRecentActivityBy = OryUICreateButton("size:30,3.5;offset:0,1.75;position:-1000,-1000;text:Filter[colon];textSize:2;textAlignment:left;depth:12")
btnRecentActivityReadAll as integer : btnRecentActivityReadAll = OryUICreateButton("size:25,3.5;offset:25,1.75;position:-1000,-1000;text:Mark All Read;textSize:2;depth:12")

// FILTER MENU
menuFilterRecentActivity as integer : menuFilterRecentActivity = OryUICreateMenu("width:80;showRightIcon:true;depth:5")

// NO LOG ITEMS
txtNoRecentActivity as integer : txtNoRecentActivity = OryUICreateText("text:No Recent Activity;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// LIST RECENT ACTIVITY
listRecentActivity as integer : listRecentActivity = OryUICreateList("noOfLeftLines:2;noOfRightLines:1;showRightIcon:true;itemSize:100,8;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
