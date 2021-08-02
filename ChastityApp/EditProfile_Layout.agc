
screenNo = constEditProfileScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Edit Profile;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// AVATAR
sprAvatar as integer : sprAvatar = OryUICreateSprite("size:40,-1;image:" + str(imgDefaultAvatar) + ";offset:20,0;position:-1000,-1000;depth:19")
sprAvatarAwaitingApproval as integer : sprAvatarAwaitingApproval = OryUICreateSprite("size:40,-1;color:0,0,0,130;offset:20,0;position:-1000,-1000;depth:18")
txtAvatarAwaitingApproval as integer : txtAvatarAwaitingApproval = OryUICreateText("string:Awaiting" + chr(10) + "Approval;size:4;bold:true;alignment:center;position:-1000,-1000;depth:17")	
sprAvatarCircleMask as integer : sprAvatarCircleMask = OryUICreateSprite("size:40,-1;image:" + str(imgAvatarCircleMask) + ";offset:20,0;position:-1000,-1000;depth:16")
fabChangeAvatar as integer : fabChangeAvatar = OryUICreateFloatingActionButton("icon:camera_alt;mini:true;shadow:false;depth:15")
OryUIHideFloatingActionButton(fabChangeAvatar)

// VIEW PROFILE
btnViewProfile as integer : btnViewProfile = OryUICreateButton("size:28,4;text:View Profile;textSize:2.8;textBold:true;offset:28,0;position:-1000,-1000;depth:13")

// USERNAME
editBoxAppUsername as integer : editBoxAppUsername = OryUICreateTextfield("labelText:Username;position:-1000,-1000;width:90;showTrailingIcon:true;trailingIcon:clear;depth:19")

// PRIVATE PROFILE
crdPrivateProfile as integer : crdPrivateProfile = OryUICreateTextCard("width:94;headerText:Private Profile?;headerTextAlignment:center;supportingText:When private, only people you approve can see your profile and social accounts.;position:-1000,-1000;autoHeight:true;depth:19")
grpPrivateProfile as integer : grpPrivateProfile = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpPrivateProfile, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpPrivateProfile, -1, "text:No")
if (privateProfile = 1)
	OryUISetButtonGroupItemSelectedByIndex(grpPrivateProfile, 1)
else
	OryUISetButtonGroupItemSelectedByIndex(grpPrivateProfile, 2)
endif

// STATUS
crdSetStatus as integer : crdSetStatus = OryUICreateTextCard("width:94;headerText:Set Status;headerTextAlignment:center;supportingText:Seen by others as 'Online' when active;position:-1000,-1000;autoHeight:true;depth:19")
grpSetStatus as integer : grpSetStatus = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSetStatus, -1, "text:Available")
OryUIInsertButtonGroupItem(grpSetStatus, -1, "text:Busy")
OryUIInsertButtonGroupItem(grpSetStatus, -1, "text:Sleeping")
OryUIInsertButtonGroupItem(grpSetStatus, -1, "text:Invisible")
OryUISetButtonGroupItemSelectedByIndex(grpSetStatus, statusSelected)

// MAIN ROLE
crdMainRole as integer : crdMainRole = OryUICreateTextCard("width:94;headerText:Main Role;headerTextAlignment:center;supportingText:What is your main role using " + constAppName$ + "?;position:-1000,-1000;autoHeight:true;depth:19")
grpMainRole as integer : grpMainRole = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpMainRole, -1, "text:Keyholder")
OryUIInsertButtonGroupItem(grpMainRole, -1, "text:Lockee")

// SHOE STATS ON PROFILE?
crdShowStatsOnProfile as integer : crdShowStatsOnProfile = OryUICreateTextCard("width:94;headerText:Show Stats On Profile?;headerTextAlignment:center;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpShowStatsOnProfile as integer : grpShowStatsOnProfile = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpShowStatsOnProfile, -1, "text:Keyholder")
OryUIInsertButtonGroupItem(grpShowStatsOnProfile, -1, "text:Lockee")
OryUIInsertButtonGroupItem(grpShowStatsOnProfile, -1, "text:Both")
OryUIInsertButtonGroupItem(grpShowStatsOnProfile, -1, "text:None")

// APP USER ID
crdAppUserIDInfo as integer : crdAppUserIDInfo = OryUICreateTextCard("width:94;headerText:" + constAppName$ + " User ID;headerTextAlignment:center;supportingText:Your " + constAppName$ + " User ID is your unique and private account ID. It is recommended that you keep a copy of this so that you can log in to your account again at a later date.;position:-1000,-1000;autoHeight:true;depth:19")
crdAppUserID as integer : crdAppUserID = OryUICreateTextCard("width:94;headerText:;supportingText:***********************;supportingTextAlignment:center;supportingTextBold:true;supportingTextSize:2.5;position:-1000,-1000;autoHeight:true;depth:19")
btnShowAppUserID as integer : btnShowAppUserID = OryUICreateButton("text:Show;size:20,5;position:-1000,-1000;depth:19")
btnCopyAppUserID as integer : btnCopyAppUserID = OryUICreateButton("text:Copy;size:20,5;position:-1000,-1000;depth:19")

// CONNECT SOCIAL ACCOUNTS
crdConnectSocialAccounts as integer : crdConnectSocialAccounts = OryUICreateTextCard("width:94;headerText:Connect Social Accounts;headerTextAlignment:center;supportingText:Connect your social accounts so that other users can contact you outside of " + constAppName$ + "." + chr(10) + chr(10) + "Connecting your accounts also makes it easier to log in to your " + constAppName$ + " account." + chr(10) + chr(10) + "You may need to re-connect your social accounts if you change your username on them.;position:-1000,-1000;autoHeight:true;depth:19")
btnDiscord as integer : btnDiscord = OryUICreateButton("size:-1,7;image:" + str(imgAccountsLogoBox) + ";text: ;color:114,137,218,255;position:-1000,-1000;depth:18")
sprDiscord as integer : sprDiscord = OryUICreateSprite("size:-1,5;image:" + str(imgDiscordLogo) + ";offset:center;position:-1000,-1000;depth:17")
btnTwitter as integer : btnTwitter = OryUICreateButton("size:-1,7;image:" + str(imgAccountsLogoBox) + ";text: ;color:29,161,242,255;position:-1000,-1000;depth:18")
sprTwitter as integer : sprTwitter = OryUICreateSprite("size:-1,5;image:" + str(imgTwitterLogo) + ";offset:center;position:-1000,-1000;depth:17")

// SOCIAL ACCOUNTS LISTS
listConnectDiscord = OryUICreateList("position:-1000,1000")
listConnectTwitter = OryUICreateList("position:-1000,1000")

// SAVE
fabSaveProfile as integer : fabSaveProfile = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveProfile)

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")

