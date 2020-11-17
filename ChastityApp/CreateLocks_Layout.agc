
screenNo = constCreateLocksScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:null;text:Creating Locks;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// DO NOT CLOSE APP
txtDoNotCloseApp as integer : txtDoNotCloseApp = OryUICreateText("text:" + OryUIWrapText("Do not leave the app while the locks are being created", 3.8, 90) + ";size:3.8;alignment:center;position:-1000,-1000;color:255,0,0,255;depth:19")

// CREATING LOCKS PROGRESS BAR
txtCreatingLocksProgress as integer : txtCreatingLocksProgress = OryUICreateText("text: ;size:3;alignment:center;bold:true;position:-1000,-1000;depth:10")
creatingLocksProgressBar as integer : creatingLocksProgressBar = OryUICreateProgressIndicator("size:80,1;position:-1000,-1000;depth:10")
