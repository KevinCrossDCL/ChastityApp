
screenNo = constAPIProjectSettingsScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:API Project;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// PROJECT NAME
editBoxAPIProjectName as integer : editBoxAPIProjectName = OryUICreateTextfield("labelText:Project Name;position:-1000,-1000;width:90;showTrailingIcon:true;trailingIcon:cancel;depth:19")

// WHAT ARE YOU BUILDING?
crdWhatAreYouBuilding as integer : crdWhatAreYouBuilding = OryUICreateTextCard("width:94;headerText:What are you building?;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
chkBoxDontKnow as integer : chkBoxDontKnow = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxDontKnow as integer : txtChkBoxDontKnow = OryUICreateText("text:Don't Know;size:2.5;position:-1000,-1000;depth:19")
chkBoxMobileApp as integer : chkBoxMobileApp = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxMobileApp as integer : txtChkBoxMobileApp = OryUICreateText("text:Mobile App;size:2.5;position:-1000,-1000;depth:19")
chkBoxDesktopApp as integer : chkBoxDesktopApp = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxDesktopApp as integer : txtChkBoxDesktopApp = OryUICreateText("text:Desktop App;size:2.5;position:-1000,-1000;depth:19")
chkBoxWebsite as integer : chkBoxWebsite = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxWebsite as integer : txtChkBoxWebsite = OryUICreateText("text:Website;size:2.5;position:-1000,-1000;depth:19")
chkBoxBot as integer : chkBoxBot = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxBot as integer : txtChkBoxBot = OryUICreateText("text:Bot;size:2.5;position:-1000,-1000;depth:19")
chkBoxLockBox as integer : chkBoxLockBox = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxLockBox as integer : txtChkBoxLockBox = OryUICreateText("text:Lock Box;size:2.5;position:-1000,-1000;depth:19")
chkBoxSomethingElse as integer : chkBoxSomethingElse = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(oryUICheckboxUncheckedImage) + ";depth:19")
txtChkBoxSomethingElse as integer : txtChkBoxSomethingElse = OryUICreateText("text:Something Else;size:2.5;position:-1000,-1000;depth:19")

// CLIENT ID
crdClientID as integer : crdClientID = OryUICreateTextCard("width:94;headerText:Client ID;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
btnCopyClientID as integer : btnCopyClientID = OryUICreateButton("text:Copy;size:20,5;position:-1000,-1000;depth:19")

// CLIENT SECRET
crdClientSecret as integer : crdClientSecret = OryUICreateTextCard("width:94;headerText:Client Secret;headerTextAlignment:center;supportingText:;supportingTextAlignment:center;position:-1000,-1000;autoHeight:true;depth:19")
btnShowClientSecret as integer : btnShowClientSecret = OryUICreateButton("text:Show;size:20,5;position:-1000,-1000;depth:19")
btnCopyClientSecret as integer : btnCopyClientSecret = OryUICreateButton("text:Copy;size:20,5;position:-1000,-1000;depth:19")
btnResetClientSecret as integer : btnResetClientSecret = OryUICreateButton("text:Reset;size:20,5;position:-1000,-1000;depth:19")

// DELETE PROJECT BUTTON
btnDeleteAPIProject as integer : btnDeleteAPIProject = OryUICreateButton("size:35,5;text:Delete Project;offset:15,0;position:-1000,-1000;depth:19")

// SAVE
fabSaveAPIProjectSettings as integer : fabSaveAPIProjectSettings = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveAPIProjectSettings)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
