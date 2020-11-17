
screenNo = constRandomCombinationsScreen

TextToSpeechSetup()

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text: ;textAlignment:center;depth:10")
if (GetTextToSpeechReady())
	OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Audio")
endif

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// RANDOM COMBINATIONS
for a = 1 to 20
	for b = 1 to 10
		randomCombination[a].timeToStart[b] = 0
		randomCombination[a].timeToDestroy[b] = 0
		randomCombination[a].txtCombination[b] = OryUICreateText("text:0000;size:7;alignment:center;position:-1000,-1000;depth:21")
	next
next

// TIMER
sprAddTimeHolder as integer : sprAddTimeHolder = OryUICreateSprite("size:-1,5;offset:center;alpha:0;position:-1000,-1000")
fabAddTime as integer : fabAddTime = OryUICreateFloatingActionButton("shadow:true;depth:5")
OryUIHideFloatingActionButton(fabAddTime)
OryUIUpdateSprite(OryUIFloatingActionButtonCollection[fabAddTime].sprIcon, "size:-1,5")
sprTimerBackground as integer : sprTimerBackground = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:19")
timerBar as integer : timerBar = OryUICreateProgressIndicator("size:100,5;position:-1000,-1000;colorID:" + str(theme[themeSelected].color[2]) + ";depth:10")
txtTimer as integer : txtTimer = OryUICreateText("text:60;size:5;position:-1000,-1000;depth:7")
