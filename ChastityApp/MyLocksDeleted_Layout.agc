
screenNo = constMyLocksDeletedScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Deleted Locks" + chr(10) + "Last 30 Days;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:refresh;icon:Refresh")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// NO MY LOCKS DELETED
txtNoMyLocksDeleted as integer : txtNoMyLocksDeleted = OryUICreateText("text:No Deleted Locks;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
