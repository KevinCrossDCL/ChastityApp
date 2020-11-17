
screenNo = constSetCombinationScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Set Combination;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

txtSetCombinationScreenParagraph as integer[10]

// INSTRUCTUCTIONS
txtSetCombinationScreenParagraph[1] = OryUICreateText("text:" + OryUIWrapText("Place the item you want to lock away in your lockbox or safe.", 2.5, 90) + ";size:2.5;position:-1000,-1000;depth:19")
txtSetCombinationScreenParagraph[2] = OryUICreateText("text:" + OryUIWrapText("NEVER LOCK YOUR SAFE OVERRIDE KEYS INSIDE THE SAFE.", 2.8, 90) + ";size:2.8;position:-1000,-1000;depth:19")
txtSetCombinationScreenParagraph[3] = OryUICreateText("text:" + OryUIWrapText("Set the combination to[colon]", 2.5, 90) + ";size:2.5;position:-1000,-1000;depth:19")
txtSetCombinationScreenParagraph[4] = OryUICreateText("text:XXXXXXXX;size:9;position:-1000,-1000;alignment:center;depth:19")
btnRegenerateCombination as integer : btnRegenerateCombination = OryUICreateButton("size:-1,5;text: ;offset:center;position:-1000,-1000;image:" + str(imgRegenerateCodeIcon) + ";depth:11")
txtSetCombinationScreenParagraph[5] = OryUICreateText("text:" + OryUIWrapText("Press the refresh button beside the above combination if you want a new one." + chr(10) + chr(10) + "The above combination will be shown again when the lock ends." + chr(10) + chr(10) + "When you press 'Next' your locks will be created and you will be taken to a screen showing a number of random combinations. Try to read as many as you can in the time given. Doing so should help you forget the above combination.", 2.5, 90) + ";size:2.5;position:-1000,-1000;depth:19")
txtSetCombinationScreenParagraph[6] = OryUICreateText("text:" + OryUIWrapText("Before continuing, please make sure you have a backup release plan in place in case of unforeseen technical issues, especially if the situation you're using this for lock could be considered dangerous.", 2.8, 90) + ";size:2.8;position:-1000,-1000;depth:19")

// NEXT BUTTON
screen[screenNo].btnNext = OryUICreateButton("size:30,7;text:Next;offset:15,0;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
