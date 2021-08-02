
screenNo = constCardsScreen

// FELT BACKGROUND
sprFeltBackground as integer : sprFeltBackground = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:-1000,-1000;depth:3999")

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;shadow:false;navigationName:Back;text:Locked Since XX/XX/XXXX;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Info;iconID:" + str(imgInfoIcon))

// DIALOG
screen[screenNo].dialog = OryUICreateDialog("autoHeight:true")
		
// ADD CARDS TRAY
sprAddCards as integer : sprAddCards = OryUICreateSprite("size:100,2.8;position:-1000,-1000;depth:10")
txtAddCards as integer : txtAddCards = OryUICreateText("string:Add Cards?;size:2.5;bold:true;position:-1000,-1000;depth:9")
sprAddCardsTray as integer : sprAddCardsTray = OryUICreateSprite("size:100," + str(cardHeight# * 0.6) + ";position:-1000,-1000;color:0,0,0,192;depth:20")
btnAdd1RedCard as integer : btnAdd1RedCard = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardRedAdd1) + ";depth:15")
sprRedCard1Of1 as integer : sprRedCard1Of1 = OryUICreateSprite("size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";image:" + str(imgCardRed100) + ";depth:16")
btnAdd2RedCards as integer : btnAdd2RedCards = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardRedAdd2) + ";depth:15")
sprRedCard1Of3 as integer : sprRedCard1Of3 = OryUICreateSprite("size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";image:" + str(imgCardRed100) + ";depth:18")
sprRedCard2Of3 as integer : sprRedCard2Of3 = OryUICreateSprite("size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";image:" + str(imgCardRed100) + ";depth:17")
sprRedCard3Of3 as integer : sprRedCard3Of3 = OryUICreateSprite("size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";image:" + str(imgCardRed100) + ";depth:16")
btnAdd1To4RedRandom as integer : btnAdd1To4RedRandom = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardRedRandom) + ";depth:15")
btnAdd1YellowRandom as integer : btnAdd1YellowRandom = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardYellowRandom100) + ";depth:15")
btnAdd1StickyCard as integer : btnAdd1StickyCard = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardSticky100) + ";depth:15")
btnAdd1FreezeCard as integer : btnAdd1FreezeCard = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardFreeze100) + ";depth:15")
btnAdd1DoubleUpCard as integer : btnAdd1DoubleUpCard = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardDoubleUp100) + ";depth:15")
btnAdd1ResetCard as integer : btnAdd1ResetCard = OryUICreateButton("text: ;size:" + str((cardWidth# * 0.5) / GetDisplayAspect()) + "," + str(cardHeight# * 0.5) + ";offset:center;position-1000,-1000;angle:" + str(random(355, 365)) + ";color:255,255,255,255;image:" + str(imgCardReset100) + ";depth:15")
	
// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;alpha:0;depth:40")

// CARDS
sprCardsScrim = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:-1000,-1000;color:0,0,0,66;depth:7")
btnViewCard = OryUICreateButton("size:" + str((cardWidth# * 1.8) / GetDisplayAspect()) + "," + str(cardHeight# * 1.8) + ";offset:center;color:0,0,0,0;text:Tap to view...;textSize:3;textColor:255,255,255,255;position:-1000,-1000;depth:1")
btnCancelCard = OryUICreateButton("size:-1,4;offset:center;position:-1000,-1000;text: ;color:255,255,255,255;image:" + str(imgCancelButton) + ";depth:1")

// PAGE BUTTONS
cardPages = OryUICreatePagination("position:-1000,-1000;color:0,0,0,128;inactiveColor:0,0,0,0;inactiveTextColor:255,255,255,66;unselectedColor:0,0,0,0;unselectedTextColor:255,255,255,255;maxButtonsToDisplay:11;showSkipToEndButtons:true")

// DISCARD PILES
sprDiscardPileCover as integer : sprDiscardPileCover = OryUICreateSprite("size:80,18;position:-1000,-1000;color:0,0,0,0;depth:10")
txtGreensFound as integer : txtGreensFound = OryUICreateText("text:??/??;size:4;bold:true;alignment:center;position:-1000,-1000;depth:11")

// NO OF CHANCES
sprNoOfChancesBar as integer : sprNoOfChancesBar = OryUICreateSprite("size:100,5;position:-1000,-1000;color:0,0,0,125;depth:9")
txtNoOfChances as integer : txtNoOfChances = OryUICreateText("text:Please pick a card;size:3.5;position:-1000,-1000;depth:8")
