
screenNo = constRestoreAccountScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Restore Account;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

txtRestoreScreenParagraph as integer[10]

// INSTRUCTIONS
txtRestoreScreenParagraph[1] = OryUICreateText("text:" + OryUIWrapText("Locks on this device are saved online with this user id[colon]", 2.5, 90) + ";size:2.5;position:-1000,-1000;depth:19")
txtRestoreScreenParagraph[2] = OryUICreateText("text:" + userID$ + ";size:4.5;position:-1000,-1000;alignment:center;depth:19")
txtRestoreScreenParagraph[3] = OryUICreateText("text:" + OryUIWrapText("Restoring locks from a previous device or install will remove all of the locks on this device. They can be retrieved at a later date with the above user id." + chr(10) + chr(10) + "You can restore locks from another device or install by entering the user id assigned to those locks below." + chr(10) + chr(10) + "Please note that locks can't be restored without your user id, even if you remember your username.", 2.5, 90) + ";size:2.5;position:-1000,-1000;depth:19")
tooltipCopiedUserID = OryUICreateTooltip("text:Copied to clipboard")

// ENTER USER ID
txtRestoreScreenParagraph[4] = OryUICreateText("text:" + OryUIWrapText("Enter previous user id", 3.4, 90) + ";size:3.4;position:-1000,-1000;alignment:center;depth:19")
btnPasteText = OryUICreateButton("size:-1,5;text: ;offset:center;color:255,255,255,255;position:-1000,-1000;image:" + str(imgPasteText) + ";depth:18")
btnCloudText = OryUICreateButton("size:-1,5;text: ;offset:center;color:255,255,255,255;position:-1000,-1000;image:" + str(imgCloudText) + ";depth:18")
editBoxEnterUserID = OryUICreateTextfield("labelText:User ID;showHelperText:false;helperText:Hyphens not required and case-insensitive;position:-1000,-1000;width:90;showTrailingIcon:true;trailingIcon:clear;depth:19")

// RESTORE BUTTON
screen[screenNo].btnNext = OryUICreateButton("size:30,7;offset:center;text:Restore;position:-1000,-1000;depth:19")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
