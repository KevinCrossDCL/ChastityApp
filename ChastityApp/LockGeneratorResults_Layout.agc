
screenNo = constLockGeneratorResultsScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Lock Templates;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Refresh;icon:refresh")

// FILTER BAR
sprFilterLockGeneratorBar as integer : sprFilterLockGeneratorBar = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:13")
sprFilterLockGeneratorBarShadow as integer : sprFilterLockGeneratorBarShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopBarShadowImage) + ";position:-1000,-1000;depth:13")
txtLockGeneratorQuery as integer : txtLockGeneratorQuery = OryUICreateText("text:XXXXX to XXXXX;size:2;depth:12")
btnLockGeneratorEditQuery as integer : btnLockGeneratorEditQuery = OryUICreateButton("size:15,3;offset:0,1.5;position:-1000,-1000;text:Edit;textSize:2;textAlignment:center;depth:12")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO GENERATED LOCKS
txtNoGeneratedLocks as integer : txtNoGeneratedLocks = OryUICreateText("text:No Matching Locks;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

remstart
// LIST LOG
listLockLog as integer : listLockLog = OryUICreateList("noOfLeftLines:2;showLeftThumbnail:true;noOfRightLines:1;itemSize:100,8;position:-1000,-1000;depth:19")
remend

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
