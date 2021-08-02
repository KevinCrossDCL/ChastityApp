
screenNo = constLoginScreen

local sprLoginBackground as integer
if (colorModeSelected <> 2)
	sprLoginBackground = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:" + str(constLoginScreen * 100) + "," + str(GetScreenBoundsTop()) + ";color:255,255,255,255;image:" + str(imgGradientBackgroundLight) + ";depth:20")
else
	sprLoginBackground = OryUICreateSprite("size:100," + str(abs(GetScreenBoundsTop() * 2) + 100) + ";position:" + str(constLoginScreen * 100) + "," + str(GetScreenBoundsTop()) + ";color:0,0,0,255;depth:20")
endif
sprLoginAppLogo as integer : sprLoginAppLogo = OryUICreateSprite("size:40,-1;offset:center;position:-1000,-1000;image:" + str(imgTransparentLogo) + ";depth:19")
sprLoginAppTitle as integer : sprLoginAppTitle = OryUICreateSprite("size:100,7.8125;position:-1000,-1000;image:" + str(imgAppTitle) + ";depth:19")

// LOGIN USER ID
btnLoginPasteText as integer : btnLoginPasteText = OryUICreateButton("size:-1,5;text: ;offset:center;color:255,255,255,255;position:-1000,-1000;image:" + str(imgPasteText) + ";depth:18")
btnLoginCloudText as integer : btnLoginCloudText = OryUICreateButton("size:-1,5;text: ;offset:center;color:255,255,255,255;position:-1000,-1000;image:" + str(imgCloudText) + ";depth:18")
global editBoxLoginUserID as integer : editBoxLoginUserID = OryUICreateTextfield("labelText:" + constAppName$ + " User ID;showHelperText:true;helperText:e.g. XXXXX-XXXXX-XXXXX-XXXXX;helperTextColor:255,255,255,255;multiline:false;position:-1000,-1000;showTrailingIcon:true;trailingIcon:clear;width:80;depth:19")

// LOGIN BUTTON
btnLoginUserID as integer : btnLoginUserID = OryUICreateButton("size:40,7;offset:center;text:LOGIN;position:-1000,-1000;depth:19")

// LOG IN WITH TEXT
txtLoginWith as integer : txtLoginWith = OryUICreateText("size:2.5;text: Or log in with ;alignment:center;position:-1000,-1000;depth:19")
sprLoginWithLeftLine as integer : sprLoginWithLeftLine = OryUICreateSprite("size:-1,0.1;depth:19")
sprLoginWithRightLine as integer : sprLoginWithRightLine = OryUICreateSprite("size:-1,0.1;depth:19")

// LOG IN WITH SOCIAL ACCOUNTS
btnLoginWithDiscord as integer : btnLoginWithDiscord = OryUICreateButton("size:-1,7;image:" + str(imgAccountsLogoBox) + ";text: ;color:114,137,218,255;position:-1000,-1000;depth:18")
sprLoginWithDiscord as integer : sprLoginWithDiscord = OryUICreateSprite("size:-1,5;image:" + str(imgDiscordLogo) + ";offset:center;position:-1000,-1000;depth:17")
btnLoginWithTwitter as integer : btnLoginWithTwitter = OryUICreateButton("size:-1,7;image:" + str(imgAccountsLogoBox) + ";text: ;color:29,161,242,255;position:-1000,-1000;depth:18")
sprLoginWithTwitter as integer : sprLoginWithTwitter = OryUICreateSprite("size:-1,5;image:" + str(imgTwitterLogo) + ";offset:center;position:-1000,-1000;depth:17")

// NEW USER?
txtNewUser as integer : txtNewUser = OryUICreateText("size:3;text:New User?;alignment:center;color:255,255,255,255;position:-1000,-1000;depth:18")
btnNewUser as integer : btnNewUser = OryUICreateButton("size:60,5;text:CREATE ACCOUNT;textAlignment:center;textBold:true;textSize:3;color:255,255,255,30;position:-1000,-1000;depth:18")

