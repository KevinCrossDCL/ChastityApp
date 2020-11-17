
screenNo = constUsersLockUpdateScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:ABCDEFGHIJKLM;textAlignment:center;depth:10")

// TABS
screen[screenNo].tabs = OryUICreateTabs("position:-1000,-1000;scrollable:false;depth:10")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Update")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Info")
OryUIInsertTabsButton(screen[screenNo].tabs, -1, "text:Log")
OryUISetTabsButtonSelected(screen[screenNo].tabs, 1)

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:30")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")

// SAVE
fabUpdateUser as integer : fabUpdateUser = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabUpdateUser)
