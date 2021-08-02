
screenNo = constSettingsScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:arrow_back_ios;navigationName:Back;text:Settings;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// THEME
crdSettingsTheme as integer : crdSettingsTheme = OryUICreateTextCard("width:94;headerText:Theme;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsTheme as integer : grpSettingsTheme = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[1].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[2].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[3].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[4].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[5].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[6].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[7].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[8].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[9].color[3]))
OryUIInsertButtonGroupItem(grpSettingsTheme, -1, "text: ;colorID:" + str(theme[10].color[3]))
sprThemeButtonBorder as integer : sprThemeButtonBorder = OryUICreateSprite("size:-1,5;depth:17")

// FRAMES PER SECOND
crdSettingsFramesPerSecond as integer : crdSettingsFramesPerSecond = OryUICreateTextCard("width:94;headerText:App Speed;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsFramesPerSecond as integer : grpSettingsFramesPerSecond = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsFramesPerSecond, -1, "text:30 FPS")
OryUIInsertButtonGroupItem(grpSettingsFramesPerSecond, -1, "text:60 FPS")

// COLOR MODE
crdSettingsColorMode as integer : crdSettingsColorMode = OryUICreateTextCard("width:94;headerText:Color Mode;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsColorMode as integer : grpSettingsColorMode = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsColorMode, -1, "text:Light")
OryUIInsertButtonGroupItem(grpSettingsColorMode, -1, "text:Dark")

// ALLOW NOTIFICATIONS?
crdSettingsAllowNotifications as integer : crdSettingsAllowNotifications = OryUICreateTextCard("width:94;headerText:Allow notifications?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsAllowNotifications as integer : grpSettingsAllowNotifications = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsAllowNotifications, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsAllowNotifications, -1, "text:No")

// COMBINATION TYPE
crdSettingsCombinationType as integer : crdSettingsCombinationType = OryUICreateTextCard("width:94;headerText:Combination type;supportingText: ;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsCombinationType as integer : grpSettingsCombinationType = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsCombinationType, -1, "text:123")
OryUIInsertButtonGroupItem(grpSettingsCombinationType, -1, "text:ABC")
OryUIInsertButtonGroupItem(grpSettingsCombinationType, -1, "text:ABC123")

// ALLOW DUPLICATE DIGITS/CHARACTERS
crdSettingsUniqueCombinations as integer : crdSettingsUniqueCombinations = OryUICreateTextCard("width:94;headerText:Allow duplicate digits/characters?;supportingText:Allowing duplicate digits/characters in a combination will generate combinations where a digit/character might appear more than once i.e. 1221. Choosing 'No' would generate combinations where each digit/character will be unique i.e. 1234;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsUniqueCombinations as integer : grpSettingsUniqueCombinations = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsUniqueCombinations, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsUniqueCombinations, -1, "text:No")

// SHOW COMBINATIONS TO KEYHOLDERS
crdSettingsShowCombinationsToKeyholders as integer : crdSettingsShowCombinationsToKeyholders = OryUICreateTextCard("width:94;headerText:Show combinations to keyholder(s);supportingText:If you choose 'Yes', your keyholder(s) will see the combination for your locks that they are managing. Having it visible on their side may help if there are technical issues, but it does not mean that they are obligated to give it to you when you want it.;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsShowCombinationsToKeyholders as integer : grpSettingsShowCombinationsToKeyholders = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsShowCombinationsToKeyholders, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsShowCombinationsToKeyholders, -1, "text:No")

// ENABLE ACTIVE LOCK DELETIONS
crdEnableLockDeletions as integer : crdEnableLockDeletions = OryUICreateTextCard("width:94;headerText:Enable deletion of active locks?;supportingText:Choosing 'No' may help prevent accidental deletions. If you choose 'No' you will need to enable before you can delete any of your active locks, including locks you've created as a keyholder.;position:-1000,-1000;autoHeight:true;depth:19")
grpEnableLockDeletions as integer : grpEnableLockDeletions = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpEnableLockDeletions, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpEnableLockDeletions, -1, "text:No")

// SHOW CARD SHUFFLES?
crdSettingsShowCardAnimations as integer : crdSettingsShowCardAnimations = OryUICreateTextCard("width:94;headerText:Show card shuffles?;supportingText:;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsShowCardAnimations as integer : grpSettingsShowCardAnimations = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsShowCardAnimations, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsShowCardAnimations, -1, "text:No")

// DISPLAY USERNAME IN PUBLIC STATS/LISTS/DATA?
crdSettingsDisplayUsernameInStats as integer : crdSettingsDisplayUsernameInStats = OryUICreateTextCard("width:94;headerText:Display username in public stats, lists, and data?;supportingText:If you opt in, your username and lock history as a lockee and/or keyholder will be available in the public " + constAppName$ + " API, and any custom version of it." + chr(10) + chr(10) + "The API is used by a number of different 3rd party projects including the Kiera bot we have on our Discord server. With the API users can look up the data on other users to see things like[colon] longest lock time, average lock time, previous keyholders, and lockees that are currently locked by a keyholder etc. It can also be used to look up your own stats easily, including displaying the " + constAppName$ + " forum ticker." + chr(10) + chr(10) + "Aside from your username, no other PI data is shared.;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsDisplayUsernameInStats as integer : grpSettingsDisplayUsernameInStats = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsDisplayUsernameInStats, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsDisplayUsernameInStats, -1, "text:No")

// SAVE USER DATA TO THE CLOUD?
crdSettingsCloudData as integer : crdSettingsCloudData = OryUICreateTextCard("width:94;headerText:Save user id in your Cloud account?;supportingText:This includes leaderboard type lists, and data made available to the Discord Kiera bot. This does not block stats from being displayed in the " + constAppName$ + " Tickers.;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsCloudData as integer : grpSettingsCloudData = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsCloudData, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsCloudData, -1, "text:No")

// SHOW TARGETED ADS?
crdSettingsShowTargetedAds as integer : crdSettingsShowTargetedAds = OryUICreateTextCard("width:94;headerText:Show targeted advertising?;supportingText:This app uses Google AdMob to show ads. Ads enable and support further development of " + constAppName$ + ". In line with the new European Data Protection Regulation (GDPR), we need your consent to serve ads tailored for you. These ad providers and their partners may collect and process personal data such as device identifiers, location data, and other demographic and interest data to provide an advertising experience tailored to you." + chr(10) + chr(10) + "Can your data be used to show ads tailored for you? If you ever change your mind, you can change the setting here anytime. You will still see ads choosing 'No', but they may not be as relevant to your interests.;position:-1000,-1000;autoHeight:true;depth:19")
grpSettingsShowTargetedAds as integer : grpSettingsShowTargetedAds = OryUICreateButtonGroup("width:90;position:-1000,-1000;depth:18")
OryUIInsertButtonGroupItem(grpSettingsShowTargetedAds, -1, "text:Yes")
OryUIInsertButtonGroupItem(grpSettingsShowTargetedAds, -1, "text:No")
OryUIInsertButtonGroupItem(grpSettingsShowTargetedAds, -1, "text:Remove Ads")

// RE-ENABLE HIDDEN ALERTS?
crdSettingsReenableHiddenAlerts as integer : crdSettingsReenableHiddenAlerts = OryUICreateTextCard("width:94;headerText:Re-enable hidden alerts?;supportingText:Re-enabling hidden alerts will turn back on all alerts that you've previously chosen to not show again.;position:-1000,-1000;autoHeight:true;depth:19")
btnSettingsReenableHiddenAlerts as integer : btnSettingsReenableHiddenAlerts = OryUICreateButton("size:90,5;text:Re-enable Hidden Alerts;position:-1000,-1000;depth:18")

// SCROLL TO TOP
screen[screenNo].scrollToTop = OryUICreateScrollToTop("")

