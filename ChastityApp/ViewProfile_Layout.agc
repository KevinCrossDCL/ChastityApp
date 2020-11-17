
screenNo = constViewProfileScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Profile;textAlignment:center;depth:10")

// MORE MENU
screen[screenNo].menuMore = OryUICreateMenu("width:60;depth:5")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// TOP PANEL
sprProfileTopPanel as integer : sprProfileTopPanel = OryUICreateSprite("size:100,0;position:-1000,-1000;depth:15")

// AVATAR
sprProfileAvatar as integer : sprProfileAvatar = OryUICreateSprite("size:30,-1;image:" + str(imgDefaultAvatar) + ";offset:15,0;position:-1000,-1000;depth:14")
sprProfileAvatarCircleMask as integer : sprProfileAvatarCircleMask = OryUICreateSprite("size:30,-1;image:" + str(imgAvatarCircleMask) + ";offset:15,0;position:-1000,-1000;depth:13")

// USERNAME
txtProfileUsername as integer : txtProfileUsername = OryUICreateText("string:XXXX;bold:true;size:4;alignment:center;position:-1000,-1000;depth:14")

// STATUS
sprProfileStatus as integer : sprProfileStatus = OryUICreateSprite("size:-1,3;offset:center;image:" + str(imgStatusOfflineIcon) + ";position:-1000,-1000;depth:14")
		
// ROLE LEVEL
sprProfileUserLevel as integer : sprProfileUserLevel = OryUICreateSprite("size:50,4;color:0,0,0,255;position:-1000,-1000;depth:14")
txtProfileUserLevel as integer : txtProfileUserLevel = OryUICreateText("string:Renowned Keyholder;bold:true;size:3;alignment:center;color:255,255,255,255;position:-1000,-1000;depth:13")

// RATING
dim sprProfileRatingStar[5]
dim sprProfileRatingStarBorder[5]
sprProfileRatingBackground as integer : sprProfileRatingBackground = OryUICreateSprite("size:" + str((2.8 / GetDisplayAspect()) * 5) + ",2.8;offset:" + str((1.4 / GetDisplayAspect()) * 5) + ",0;position:-1000,-1000;depth:14")
sprProfileRatingBar as integer : sprProfileRatingBar = OryUICreateSprite("size:0,2.8;position:-1000,-1000;color:255,185,2,255;depth:13")
for i = 1 to 5
	sprProfileRatingStar[i] = OryUICreateSprite("size:-1,2.8;image:" + str(imgStarHollow) + ";position:-1000,-1000;depth:12")
	sprProfileRatingStarBorder[i] = OryUICreateSprite("size:-1,2.8;image:" + str(imgStarBorder) + ";color:172,107,1;position:-1000,-1000;depth:11")
next
txtProfileRating as integer : txtProfileRating = OryUICreateText("string:X.X out of X (XXX);size:2;alignment:center;position:-1000,-1000;depth:14")

// LAST ONLINE
txtProfileLastOnline as integer : txtProfileLastOnline = OryUICreateText("string:;alignment:center;size:2.4;position:-1000,-1000")

// PRIVATE ACCOUNT
txtPrivateAccountLine1 as integer : txtPrivateAccountLine1 = OryUICreateText("text:Private Account;size:3;bold:true;position:-1000,-1000;alignment:center;depth:14")
txtPrivateAccountLine2 as integer : txtPrivateAccountLine2 = OryUICreateText("text:Follow this account to see their profile;size:2.6;position:-1000,-1000;alignment:center;depth:14")

// FOLLOWERS/FOLLOWING COUNT
sprFollowersCount as integer : sprFollowersCount = OryUICreateSprite("size:-1,10;offset:center;position:-1000,-1000;alpha:0;depth:15")
txtFollowersCount as integer : txtFollowersCount = OryUICreateText("size:3.5;text:Followers;alignment:center;bold:true;position:-1000,-1000;depth:14")
txtFollowersLabel as integer : txtFollowersLabel = OryUICreateText("size:2.4;text:Followers;alignment:center;position:-1000,-1000;depth:14")
sprFollowingCount as integer : sprFollowingCount = OryUICreateSprite("size:-1,10;offset:center;position:-1000,-1000;alpha:0;depth:15")
txtFollowingCount as integer : txtFollowingCount = OryUICreateText("size:3.5;text:Following;alignment:center;bold:true;position:-1000,-1000;depth:14")
txtFollowingLabel as integer : txtFollowingLabel = OryUICreateText("size:2.4;text:Following;alignment:center;position:-1000,-1000;depth:14")

// FOLLOW BUTTON
btnProfileUserFollow as integer : btnProfileUserFollow = OryUICreateButton("size:40,4;text:Follow;offset:20,0;position:-1000,-1000;depth:14")

// REQUEST SENT
btnProfileUserRequestSent as integer : btnProfileUserRequestSent = OryUICreateButton("size:40,4;text:Requested;offset:20,0;position:-1000,-1000;depth:14")

// UNFOLLOW BUTTON
btnProfileUserUnfollow as integer : btnProfileUserUnfollow = OryUICreateButton("size:40,4;text:Unfollow;offset:20,0;position:-1000,-1000;depth:14")

// UNBLOCK BUTTON
btnProfileUserUnblock as integer : btnProfileUserUnblock = OryUICreateButton("size:40,4;text:Unblock;offset:20,0;position:-1000,-1000;depth:14")

// DISCORD LOGO
sprDiscordLogo as integer : sprDiscordLogo = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(imgDiscordLogo) + ";color:114,137,218,255;depth:14")
sprDiscordNameButton as integer : sprDiscordNameButton = OryUICreateSprite("size:5,5;position:-1000,-1000;alpha:0;depth:15")
txtDiscordName as integer : txtDiscordName = OryUICreateText("text: ;size:3;position:-1000,-1000;depth:14")

// TWITTER LOGO
sprTwitterLogo as integer : sprTwitterLogo = OryUICreateSprite("size:-1,4;position:-1000,-1000;image:" + str(imgTwitterLogo) + ";color:29,161,242,255;depth:14")
sprTwitterHandleButton as integer : sprTwitterHandleButton = OryUICreateSprite("size:5,5;position:-1000,-1000;alpha:0;depth:15")
txtTwitterHandle as integer : txtTwitterHandle = OryUICreateText("text: ;size:3;position:-1000,-1000")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")
