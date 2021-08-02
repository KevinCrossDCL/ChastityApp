
screenNo = constAPIDashboardScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:API Dashboard;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// NO LOCKS
txtNoAPIProjects as integer : txtNoAPIProjects = OryUICreateText("text:No API Projects;size:3;bold:true;position:-1000,-1000;alignment:center;depth:19")
txtPressPlusToCreateAPIProject as integer : txtPressPlusToCreateAPIProject = OryUICreateText("text:Press the + button below to create a new project;size:2.6;position:-1000,-1000;alignment:center;depth:19")

// PROJECTS

// API DOCUMENTATION
txtDocumentation as integer : txtDocumentation = OryUICreateText("text:For " + constAppName$ + " API documentation visit[colon];size:2.4;alignment:center;position:-1000,-1000;depth:19")
btnDocumentation as integer : btnDocumentation = OryUICreateButton("size:50,3;text:" + ReplaceString(constAppAPIDocumentsURL$, ":", "[colon]", -1) + ";offset:center;textSize:2.5;position:-1000,-1000;depth:19")

// ADD BUTTON
fabAddAPIProject as integer : fabAddAPIProject = OryUICreateFloatingActionButton("icon:Add;depth:10")
OryUIHideFloatingActionButton(fabAddAPIProject)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
