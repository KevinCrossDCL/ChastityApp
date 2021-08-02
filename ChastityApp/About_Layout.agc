
screenNo = constAboutScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:About;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:20")

// APP LOGO
sprAppLogo as integer : sprAppLogo = OryUICreateSprite("size:-1,18;offset:center;position:-1000,-1000;depth:19")

// APP TITLE
txtAppTitle as integer : txtAppTitle = OryUICreateText("text:" + constAppName$ + ";size:3.5;bold:true;alignment:center;position:-1000,-1000;depth:19")

// APP VERSION
txtAppVersion as integer : txtAppVersion = OryUICreateText("text:Version " + constVersionNumber$ + " (Build " + str(constBuildNumber) + ");size:2;alignment:center;position:-1000,-1000;depth:19")

// VERSION HISTORY
btnVersionHistory as integer : btnVersionHistory = OryUICreateButton("size:50,3;text:Version History;offset:center;textSize:2.5;position:-1000,-1000;depth:19")

// PRIVACY POLICY
btnPrivacyPolicy as integer : btnPrivacyPolicy = OryUICreateButton("size:50,3;text:Privacy Policy;offset:center;textSize:2.5;position:-1000,-1000;depth:19")

// TERMS & CONDITIONS
btnTermsAndConditions as integer : btnTermsAndConditions = OryUICreateButton("size:50,3;text:Terms & Conditions;offset:center;textSize:2.5;position:-1000,-1000;depth:19")

// APP SERVER TIME TITLE
txtAppServerTimeTitle as integer : txtAppServerTimeTitle = OryUICreateText("text:Server Time;size:2.5;bold:true;alignment:center;position:-1000,-1000;depth:19")

// APP SERVER TIME
txtAppServerTime as integer : txtAppServerTime = OryUICreateText("text:Server Time;size:2;alignment:center;position:-1000,-1000;depth:19")

// MADE WITH APPGAMEKIT
sprMadeWithAppGameKit as integer : sprMadeWithAppGameKit = OryUICreateSprite("size:-1,6;position:-1000,-1000;depth:19")

// FOLLOW BUTTONS
grpFollowButtons as integer : grpFollowButtons = OryUICreateButtonGroup("size:75,8;offset:center;iconSize:" + str(6 / GetDisplayAspect()) + ",-1;position:-1000,-1000;depth:19")
OryUISetButtonGroupItemCount(grpFollowButtons, 5)

// MAINTAINED BY ONE
txtMaintainedByOne as integer : txtMaintainedByOne = OryUICreateText("text:The " + constAppName$ + " mobile app is maintained by one person." + chr(10) + "Please understand the limitations this entails.;size:2;alignment:center;position:-1000,-1000;depth:19")

// COPYRIGHT
txtCopyright as integer : txtCopyright = OryUICreateText("text:© " + constCompanyName$ + ";size:2;bold:true;alignment:center;position:-1000,-1000;depth:19")
