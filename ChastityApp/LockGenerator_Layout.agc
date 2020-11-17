
screenNo = constLockGeneratorScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock Templates;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Info;iconID:" + str(imgInfoIcon))

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// MINIMUM LOCK DURATION
crdMinLockGeneratorDuration as integer : crdMinLockGeneratorDuration = OryUICreateTextCard("width:94;headerText:Minimum lock duration?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMinLockGeneratorDays as integer : txtMinLockGeneratorDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinLockGeneratorHours as integer : txtMinLockGeneratorHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMinLockGeneratorMinutes as integer : txtMinLockGeneratorMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
global spinMinLockGeneratorNumberOfDays as integer
spinMinLockGeneratorNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMinLockGeneratorNumberOfHours as integer
spinMinLockGeneratorNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMinLockGeneratorNumberOfMinutes as integer
spinMinLockGeneratorNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// MAXIMUM LOCK DURATION
crdMaxLockGeneratorDuration as integer : crdMaxLockGeneratorDuration = OryUICreateTextCard("width:94;headerText:Maximum lock duration?;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
txtMaxLockGeneratorDays as integer : txtMaxLockGeneratorDays = OryUICreateText("text:DAYS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxLockGeneratorHours as integer : txtMaxLockGeneratorHours = OryUICreateText("text:HOURS;size:2.5;alignment:center;position:-1000,-1000;depth:18")
txtMaxLockGeneratorMinutes as integer : txtMaxLockGeneratorMinutes = OryUICreateText("text:MINUTES;size:2.5;alignment:center;position:-1000,-1000;depth:18")
global spinMaxLockGeneratorNumberOfDays as integer
spinMaxLockGeneratorNumberOfDays = OryUICreateInputSpinner("size:27,5;min:0;max:365;step:1;maxLength:3;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMaxLockGeneratorNumberOfHours as integer
spinMaxLockGeneratorNumberOfHours = OryUICreateInputSpinner("size:27,5;min:0;max:23;step:1;defaultValue:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")
global spinMaxLockGeneratorNumberOfMinutes as integer
spinMaxLockGeneratorNumberOfMinutes = OryUICreateInputSpinner("size:27,5;min:0;max:59;step:1;maxLength:2;autoCorrectIfOutOfRange:true;position:-1000,-1000;depth:18")

// REGULARITY
crdLockGeneratorRegularity as integer : crdLockGeneratorRegularity = OryUICreateTextCard("width:94;headerText: ;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpLockGeneratorRegularity as integer : grpLockGeneratorRegularity = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:24H;text:24H")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:12H;text:12H")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:6H;text:6H")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:3H;text:3H")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:1H;text:1H")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:30M;text:30M")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:15M;text:15M")
OryUIInsertButtonGroupItem(grpLockGeneratorRegularity, -1, "name:ANY;text:Any")
OryUISetButtonGroupItemSelectedByIndex(grpLockGeneratorRegularity, 8)

// SEARCH BUTTON
screen[screenNo].btnNext = OryUICreateButton("size:30,7;text:Search;offset:15,0;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
