
screenNo = constScanQRCodeScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Scan QR Code;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// CAMERA
sprCam = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:-1000,-1000;depth:19")

// SCAN FRAME
sprScanFrame as integer : sprScanFrame = OryUICreateSprite("size:80,-1;offset:center;position:-1000,-1000;depth:15")

// SCAN LINE
sprScanLine as integer : sprScanLine = OryUICreateSprite("size:80,-1;offset:center;position:-1000,-1000;depth:15")
scanLineDirection# as float : scanLineDirection# = 0.5
