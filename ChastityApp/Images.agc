
local img as integer

global imgAccountsLogoBox as integer : imgAccountsLogoBox = LoadImage("AccountsLogoBox.png")
global imgArc as integer : imgArc = LoadImage("ArcMask.png")
global imgAdd10s as integer
global imgAdd15s as integer
global imgAdd20s as integer
global imgAdd25s as integer
global imgAdd30s as integer
global imgAppLogo as integer
global imgAppTitle : imgAppTitle = LoadImage("AppTitle.png")
global imgAudioOff as integer
global imgAudioOn as integer
global imgAutoResetRibbon as integer
global imgAvatarCircleMask as integer : imgAvatarCircleMask = LoadImage("AvatarCircleMask.png")
global imgBlank as integer : imgBlank = LoadImage("Blank.png")
global imgBot01 as integer
global imgBot02 as integer
global imgBot03 as integer
global imgBot04 as integer
global imgCancelButton : imgCancelButton = LoadImage("CancelButton.png")
global imgCancelCardButton : imgCancelCardButton = LoadImage("CancelCardButton.png")
global imgCardBack : imgCardBack = LoadImage("AppCardBack.png")
global imgCardDoubleUp025 : imgCardDoubleUp025 = LoadImage("AppCardDoubleUp025.png")
global imgCardDoubleUp100 : imgCardDoubleUp100 = LoadImage("AppCardDoubleUp100.png")
global imgCardDoubleUpDark : imgCardDoubleUpDark = LoadImage("AppCardDoubleUpDark.png")
global imgCardFreeze025 : imgCardFreeze025 = LoadImage("AppCardFreeze025.png")
global imgCardFreeze100 : imgCardFreeze100 = LoadImage("AppCardFreeze100.png")
global imgCardFreezeDark : imgCardFreezeDark = LoadImage("AppCardFreezeDark.png")
global imgCardGoAgain : imgCardGoAgain = LoadImage("AppCardGoAgain.png")
global imgCardGreen025 : imgCardGreen025 = LoadImage("AppCardGreen025.png")
global imgCardGreen100 : imgCardGreen100 = LoadImage("AppCardGreen100.png")
global imgCardGreenDark : imgCardGreenDark = LoadImage("AppCardGreenDark.png")
global imgCardInfoHidden : imgCardInfoHidden = LoadImage("CardInfoHidden.png")
global imgCardInfoVisible : imgCardInfoVisible = LoadImage("CardInfoVisible.png")
global imgCardRed025 : imgCardRed025 = LoadImage("AppCardRed025.png")
global imgCardRed100 : imgCardRed100 = LoadImage("AppCardRed100.png")
global imgCardRedDark : imgCardRedDark = LoadImage("AppCardRedDark.png")
global imgCardRedAdd1 : imgCardRedAdd1 = LoadImage("AppCardRedAdd1.png")
global imgCardRedAdd2 : imgCardRedAdd2 = LoadImage("AppCardRedAdd2.png")
global imgCardRedAdd3 : imgCardRedAdd3 = LoadImage("AppCardRedAdd3.png")
global imgCardRedRandom : imgCardRedRandom = LoadImage("AppCardRedRandom.png")
global imgCardReset025 : imgCardReset025 = LoadImage("AppCardReset025.png")
global imgCardReset100 : imgCardReset100 = LoadImage("AppCardReset100.png")
global imgCardResetDark : imgCardResetDark = LoadImage("AppCardResetDark.png")
global imgCardSticky025 : imgCardSticky025 = LoadImage("AppCardSticky025.png")
global imgCardSticky100 : imgCardSticky100 = LoadImage("AppCardSticky100.png")
global imgCardStickyDark : imgCardStickyDark = LoadImage("AppCardStickyDark.png")
global imgCardYellowAdd1 : imgCardYellowAdd1 = LoadImage("AppCardYellowAdd1.png")
global imgCardYellowAdd2 : imgCardYellowAdd2 = LoadImage("AppCardYellowAdd2.png")
global imgCardYellowAdd3 : imgCardYellowAdd3 = LoadImage("AppCardYellowAdd3.png")
global imgCardYellowMinus1 : imgCardYellowMinus1 = LoadImage("AppCardYellowMinus1.png")
global imgCardYellowMinus2 : imgCardYellowMinus2 = LoadImage("AppCardYellowMinus2.png")
global imgCardYellowRandom025 : imgCardYellowRandom025 = LoadImage("AppCardYellowRandom025.png")
global imgCardYellowRandom100 : imgCardYellowRandom100 = LoadImage("AppCardYellowRandom100.png")
global imgCardYellowRandomDark : imgCardYellowRandomDark = LoadImage("AppCardYellowRandomDark.png")
global imgCheckedIn as integer : imgCheckedIn = LoadImage("CheckedIn.png")
global imgCheckInIcon as integer : imgCheckInIcon = LoadImage("CheckInIcon.png")
global imgCircle as integer : imgCircle = LoadImage("Circle.png")
global imgCloudText as integer : imgCloudText = LoadImage("CloudText.png")
global imgCooldown as integer : imgCooldown = LoadImage("CooldownMask.png")
global imgCopyText as integer : imgCopyText = LoadImage("CopyText.png")
global imgDefaultAvatar as integer : imgDefaultAvatar = LoadImage("DefaultAvatar.png")
global imgDeleteIcon as integer : imgDeleteIcon = LoadImage("DeleteIcon.png")
global imgDiscordIcon as integer
global imgDiscordLogo as integer : imgDiscordLogo = LoadImage("DiscordLogo.png")
global imgEditIcon as integer : imgEditIcon = LoadImage("EditIcon.png")
global imgEditUsersLockIcon as integer : imgEditUsersLockIcon = LoadImage("EditUsersLockIcon.png")
global imgEmailIcon as integer
global imgEmojiBorder as integer : imgEmojiBorder = LoadImage("emojis\Border.png")
global imgEmojiIcon as integer : imgEmojiIcon = LoadImage("emojis\Icon.png")
global imgEmojis as integer[9, 99]
for a = 1 to 7
	img = LoadImage("emojis\" + AddLeadingZeros(str(a), 3) + "\emojis" + AddLeadingZeros(str(a), 3) + ".png")
	for b = 1 to 78
		imgEmojis[a, b] = LoadSubImage(img, "emoji" + str(b))
	next
	imgEmojis[a, 99] = LoadSubImage(img, "emoji" + str(99))
next
global imgFacebookIcon as integer
global imgFakeLock as integer : imgFakeLock = LoadImage("FakeLock.png")
global imgFavouriteOff as integer : imgFavouriteOff = LoadImage("FavouriteOff.png")
global imgFavouriteOn as integer : imgFavouriteOn = LoadImage("FavouriteOn.png")
global imgFeltBackground as integer
global imgFilterIcon as integer : imgFilterIcon = LoadImage("FilterIcon.png")
global imgFlags as integer[10]
imgFlags[0] = LoadImage("FlagOff.png")
imgFlags[1] = LoadImage("FlagBlack.png")
imgFlags[2] = LoadImage("FlagBlue.png")
imgFlags[3] = LoadImage("FlagGreen.png")
imgFlags[4] = LoadImage("FlagOrange.png")
imgFlags[5] = LoadImage("FlagPurple.png")
imgFlags[6] = LoadImage("FlagRed.png")
imgFlags[7] = LoadImage("FlagYellow.png")
imgFlags[9] = LoadImage("FlagCancel.png")
global imgFreezeIconOff as integer : imgFreezeIconOff = LoadImage("FreezeIconOff.png")
global imgFreezeIconOn as integer : imgFreezeIconOn = LoadImage("FreezeIconOn.png")
global imgGitHubIcon as integer
global imgIceCapArch as integer : imgIceCapArch = LoadImage("IceCapArch.png")
global imgInfoIcon as integer : imgInfoIcon = LoadImage("InfoIcon.png")
global imgKeyDisabled as integer : imgKeyDisabled = LoadImage("KeyDisabled.png")
global imgKeyholderUpdatedRibbon as integer
global imgListAddedCards as integer
global imgListAddedTime as integer
global imgListAutoResetLock as integer
global imgListBlank as integer
global imgListCheckedIn as integer
global imgListCheckedInLate as integer
global imgListDeletedLock as integer
global imgListDoubleUpCard as integer
global imgListFreezeCard as integer
global imgListFrozen as integer
global imgListGoAgainCard as integer
global imgListGreenCard as integer
global imgListHidden as integer
global imgListHiddenWhite as integer
global imgListLocked as integer
global imgListOldVersion as integer
global imgListRatedLock as integer
global imgListRedCard as integer
global imgListRemovedCards as integer
global imgListRemovedTime as integer
global imgListResetCard as integer
global imgListResetLock as integer
global imgListRestoredLock as integer
global imgListStickyCard as integer
global imgListUnfrozen as integer
global imgListUnlocked as integer
global imgListUpdateHidden as integer
global imgListVisible as integer
global imgListVisibleWhite as integer
global imgListYellowAdd1Card as integer
global imgListYellowAdd2Card as integer
global imgListYellowAdd3Card as integer
global imgListYellowMinus1Card as integer
global imgListYellowMinus2Card as integer
global imgLoadImageButton as integer : imgLoadImageButton = LoadImage("LoadImageIcon.png")
global imgLoginWithText as integer : imgLoginWithText = LoadImage("LoginWithText.png")
global imgLogo as integer
global imgMadeWithAppGameKit as integer
global imgManageUsersIcon as integer : imgManageUsersIcon = LoadImage("ManageUsersIcon.png")
global imgMoreIcon as integer : imgMoreIcon = LoadImage("MoreIcon.png")
global imgMultipleKeyholders as integer : imgMultipleKeyholders = LoadImage("MultipleKeyholders.png")
global imgNewLockIcon as integer : imgNewLockIcon = LoadImage("NewLockIcon.png")
global imgNotCheckedIn as integer : imgNotCheckedIn = LoadImage("NotCheckedIn.png")
global imgNotSynced as integer : imgNotSynced = LoadImage("NotSynced.png")
global imgPasteText as integer : imgPasteText = LoadImage("PasteText.png")
global imgPendingFollowRequests as integer
global imgPullToRefreshCircle as integer : imgPullToRefreshCircle = LoadImage("PullToRefreshCircle.png")
global imgPullToRefreshIcon as integer : imgPullToRefreshIcon = LoadImage("PullToRefreshIcon.png")
global imgRectangleSecretSticker as integer : imgRectangleSecretSticker = LoadImage("RectangleSecretSticker.png")
global imgRegenerateCodeIcon as integer : imgRegenerateCodeIcon = LoadImage("RegenerateCodeIcon.png")
global imgResetLockIcon as integer : imgResetLockIcon = LoadImage("ResetLockIcon.png")
global imgRoundSecretSticker as integer : imgRoundSecretSticker = LoadImage("RoundSecretSticker.png")
global imgScanFrame as integer
global imgScanImageButton as integer : imgScanImageButton = LoadImage("ScanImageIcon.png")
global imgScanLine as integer
global imgShareIcon as integer : imgShareIcon = LoadImage("ShareIcon.png")
global imgShowMatchingUsersIcon as integer : imgShowMatchingUsersIcon = LoadImage("ShowMatchingUsersIcon.png")
global imgSortIconAscending as integer : imgSortIconAscending = LoadImage("SortIconAscending.png")
global imgSortIconDescending as integer : imgSortIconDescending = LoadImage("SortIconDescending.png")
global imgSortIconRandom as integer : imgSortIconRandom = LoadImage("SortIconRandom.png")
global imgStar as integer : imgStar = LoadImage("Star.png")
global imgStarBorder as integer : imgStarBorder = LoadImage("StarBorder.png")
global imgStarHollow as integer : imgStarHollow = LoadImage("StarHollow.png")
global imgStarOff as integer : imgStarOff = LoadImage("StarOff.png")
global imgStarOn as integer : imgStarOn = LoadImage("StarOn.png")
global imgStatusAvailableIcon as integer : imgStatusAvailableIcon = LoadImage("StatusAvailableIcon.png")
global imgStatusBusyIcon as integer : imgStatusBusyIcon = LoadImage("StatusBusyIcon.png")
global imgStatusOfflineIcon as integer : imgStatusOfflineIcon = LoadImage("StatusOfflineIcon.png")
global imgStatusSleepingIcon as integer : imgStatusSleepingIcon = LoadImage("StatusSleepingIcon.png")
global imgSynced as integer : imgSynced = LoadImage("Synced.png")
global imgSyncing as integer : imgSyncing = LoadImage("Syncing.png")
global imgTestLock as integer : imgTestLock = LoadImage("TestLock.png")
global imgThemeBorder as integer
global imgTickIcon as integer : imgTickIcon = LoadImage("TickIcon.png")
global imgTimerHidden as integer : imgTimerHidden = LoadImage("TimerHidden.png")
global imgTimerVisible as integer : imgTimerVisible = LoadImage("TimerVisible.png")
global imgTransparentLogo as integer : imgTransparentLogo = LoadImage("TransparentLogo.png")
global imgTransparentSplashScreenLogo as integer : imgTransparentSplashScreenLogo = LoadImage("TransparentSplashScreenLogo.png")
global imgTrustKeyholder as integer : imgTrustKeyholder = LoadImage("TrustKeyholder.png")
global imgTwitterIcon as integer
global imgTwitterLogo as integer : imgTwitterLogo = LoadImage("TwitterLogo.png")
global imgUndeleteIcon as integer : imgUndeleteIcon = LoadImage("UndeleteIcon.png")
global imgUnlockIcon as integer : imgUnlockIcon = LoadImage("UnlockIcon.png")
global imgUsedKey as integer : imgUsedKey = LoadImage("UsedKey.png")
global imgUserRatingRibbon as integer : imgUserRatingRibbon = LoadImage("UserRatingRibbon.png")

