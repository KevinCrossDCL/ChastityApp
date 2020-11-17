
local sprSplashScreenBackground as integer
if (colorModeSelected <> 2)
	sprSplashScreenBackground = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:" + str(constSplashScreen * 100) + "," + str(GetScreenBoundsTop()) + ";color:255,255,255,255;image:" + str(imgGradientBackgroundLight))
else
	sprSplashScreenBackground = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:" + str(constSplashScreen * 100) + "," + str(GetScreenBoundsTop()) + ";color:0,0,0,255")
endif
sprSplashScreenAppLogo as integer : sprSplashScreenAppLogo = OryUICreateSprite("size:100,-1;offset:center;position:" + str((constSplashScreen * 100) + 50) + ",50;image:" + str(imgTransparentSplashScreenLogo))
txtSplashScreenLoadingLine as integer : txtSplashScreenLoadingLine = OryUICreateText("string:;size:3;position:" + str((constSplashScreen * 100) + 50) + ",76.5;alignment:center;bold:true;depth:1;")

splashScreenLoadBar as integer : splashScreenLoadBar = OryUICreateProgressIndicator("size:80,1;position:-1000,-1000;color:255,255,255")
OryUISetProgressIndicatorPercentage(splashScreenLoadBar, 0)

splashScreenStage$ as string : splashScreenStage$ = "Accept Terms"

