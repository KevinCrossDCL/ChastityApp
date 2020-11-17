
screenNo = constLockGeneratorInformationScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Lock Templates;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// INFORMATION
crdLockGeneratorInformation as integer : crdLockGeneratorInformation = OryUICreateTextCard("width:94;headerText:Information;headerTextAlignment:center;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")

// DISCLAIMER
crdLockGeneratorDisclaimer as integer : crdLockGeneratorDisclaimer = OryUICreateTextCard("width:94;headerText:Disclaimer;headerTextAlignment:center;supportingText:Locks may run longer or shorter than what the simulation data shows." + chr(10) + chr(10) + "Also, creating a lock from one of the template locks and changing the lock draw time to a higher one (i.e. from 1 hour to 6 hours) before starting it would create locks that run longer than the original simulation data.;position:-1000,-1000;autoHeight:true;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
