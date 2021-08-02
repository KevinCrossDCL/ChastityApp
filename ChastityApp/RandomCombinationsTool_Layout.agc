
screenNo = constRandomCombinationsToolScreen

TextToSpeechSetup()

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Random Combinations;textAlignment:center;depth:10")
if (GetTextToSpeechReady())
	OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Audio")
endif

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// LENGTH OF COMBINATIONS?
crdLengthOfCombinations as integer : crdLengthOfCombinations = OryUICreateTextCard("width:100;headerText:Length of combinations;headerTextAlignment:center;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
spinLengthOfCombinations as integer : spinLengthOfCombinations = OryUICreateInputSpinner("size:27,5;min:3;max:12;step:1;maxLength:1;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
 
// RANDOM COMBINATIONS
for a = 1 to 20
	for b = 1 to 10
		randomCombination[a].timeToStart[b] = 0
		randomCombination[a].timeToDestroy[b] = 0
		randomCombination[a].txtCombination[b] = OryUICreateText("text:0000;size:7;alignment:center;position:-1000,-1000;depth:21")
	next
next

// QUIT BUTTON
btnQuitRandomCombinationsTool as integer : btnQuitRandomCombinationsTool = OryUICreateButton("size:30,7;text:Quit;offset:15,0;position:-1000,-1000;depth:19")

// TIMER
//~sprAddTimeHolder as integer : sprAddTimeHolder = OryUICreateSprite("size:-1,5;offset:center;alpha:0;position:-1000,-1000")
//~fabAddTime as integer : fabAddTime = OryUICreateFloatingActionButton("shadow:true;depth:5")
//~OryUIHideFloatingActionButton(fabAddTime)
//~OryUIUpdateSprite(OryUIFloatingActionButtonCollection[fabAddTime].sprIcon, "size:-1,5")
//~sprTimerBackground as integer : sprTimerBackground = OryUICreateSprite("size:100,5;position:-1000,-1000;depth:19")
//~timerBar as integer : timerBar = OryUICreateProgressIndicator("size:100,5;position:-1000,-1000;colorID:" + str(theme[themeSelected].color[2]) + ";depth:10")
//~txtTimer as integer : txtTimer = OryUICreateText("text:60;size:5;position:-1000,-1000;depth:7")
