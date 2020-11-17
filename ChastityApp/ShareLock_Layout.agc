
screenNo = constShareLockScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Share Lock;textAlignment:center;depth:10")
OryUIInsertTopBarAction(screen[screenNo].topBar, -1, "name:Share;icon:share")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// QR CODE BACKGROUND
sprQRCodeBackground as integer : sprQRCodeBackground = OryUICreateSprite("size:-1,46;offset:center;position:-1000,-1000;depth:19")

// QR CODE
sprEncodedQRCode as integer : sprEncodedQRCode = OryUICreateSprite("size:-1,41;offset:center;position:-1000,-1000;depth:18")

// QR APP LOGO
sprQRBlackCircle as integer : sprQRBlackCircle = OryUICreateSprite("size:-1,8;offset:center;position:-1000,-1000;image:" + str(imgCircle) + ";color:0,0,0,255;depth:17")
sprQRWhiteCircle as integer : sprQRWhiteCircle = OryUICreateSprite("size:-1,7.5;offset:center;position:-1000,-1000;image:" + str(imgCircle) + ";color:255,255,255,255;depth:16")
sprQRLogo as integer : sprQRLogo = OryUICreateSprite("size:-1,7;offset:center;position:-1000,-1000;color:255,255,255,255;depth:15")

// QR LOCK NAME
txtQRLockName as integer : txtQRLockName = OryUICreateText("text: ;size:2;position:-1000,-1000;color:44,62,80,255;depth:17")

// QR SHARE ID
txtQRShareID as integer : txtQRShareID = OryUICreateText("text:XXXXXXXXXXXXXXX;size:2;alignment:right;position:-1000,-1000;color:44,62,80,255;depth:17")

// QR DOWNLOAD	
txtQRDownload as integer : txtQRDownload = OryUICreateText("text:Download " + constAppName$ + " from " + constAppName$ + ".com to use this lock;size:2;alignment:center;position:-1000,-1000;color:44,62,80,255;depth:17")

// QR CREATED BY
txtQRCreatedBy as integer : txtQRCreatedBy = OryUICreateText("text:Created by XXXXXXXXXX;size:2;position:-1000,-1000;color:44,62,80,255;depth:17")

// QR MINIMUM VERSION REQUIRED
txtQRVersion as integer : txtQRVersion = OryUICreateText("text:Requires V1.0.0+;size:2;alignment:right;color:192,57,42,255;depth:17")

// LOCK INFORMATION
sprLockTestLock as integer : sprLockTestLock = OryUICreateSprite("size:94,4;position:-1000,-1000;alpha:0;depth:19")
txtLockTestLock as integer : txtLockTestLock = OryUICreateText("text:TEST LOCK;size:3;bold:true;color:255,0,0,255;depth:18")
sprLockInformation as integer : sprLockInformation = OryUICreateSprite("size:94,33.5;position:-1000,-1000;alpha:0;depth:19")
txtLockInformation as integer : txtLockInformation = OryUICreateText("text: ;size:2.5;bold:true;color:58,128,113,255;depth:18")

// DOWNLOAD APP
txtDownload as integer : txtDownload = OryUICreateText("text:Download " + constAppName$ + " to use this lock;size:3;position:-1000,-1000;alignment:center;color:44,62,80,255;depth:17")
txtDomain as integer : txtDomain = OryUICreateText("text:www." + constAppMarketingDomain$ + ";size:2.8;position:-1000,-1000;alignment:center;color:0,0,255,255;depth:17")
