
screenNo = constEmojisScreen

// TOP BAR
screen[screenNo].topBar = OryUICreateTopBar("position:-1000,-1000;navigationIcon:back;navigationName:Back;text:Select Your Mood;textAlignment:center;depth:10")

// PAGE
screen[screenNo].sprPage = OryUICreateSprite("size:94,0;position:-1000,-1000;depth:20")

// EMOJIS
sprEmojis as integer[78]
emojiCount as integer : emojiCount = 0
emojiWidth# as integer : emojiWidth# = 0
for y = 1 to 13
	for x = 1 to 6
		inc emojiCount
		emojiWidth# = (94.0 - (4.0 / GetDisplayAspect())) / 6.0
		sprEmojis[emojiCount] = OryUICreateSprite("size:" + str(emojiWidth#) + ",-1;image:" + str(imgEmojis[1, emojiCount]) + ";position:-1000,-1000;depth:17")
	next
next
sprEmojiBorder as integer : sprEmojiBorder = OryUICreateSprite("size:" + str(emojiWidth#) + ",-1;image:" + str(imgEmojiBorder) + ";depth:19")
	
// EMOJI COLOUR
sprEmojiColourShadow as integer : sprEmojiColourShadow = OryUICreateSprite("size:100,1;image:" + str(oryUITopShadowImage) + ";position:-1000,-1000;depth:12")
sprEmojiColour as integer[8]
emojiColourWidth# as float : emojiColourWidth# = (100 / 7.0)
sprEmojiColour[1] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:246,217,101;position:-1000,-1000;depth:16")
sprEmojiColour[2] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:239,174,113;position:-1000,-1000;depth:16")
sprEmojiColour[3] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:240,141,130;position:-1000,-1000;depth:16")
sprEmojiColour[4] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:191,149,209;position:-1000,-1000;depth:16")
sprEmojiColour[5] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:118,173,210;position:-1000,-1000;depth:16")
sprEmojiColour[6] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:117,203,153;position:-1000,-1000;depth:16")
sprEmojiColour[7] = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;color:201,219,230;position:-1000,-1000;depth:16")
sprEmojiColourBorder as integer : sprEmojiColourBorder = OryUICreateSprite("size:" + str(emojiColourWidth#) + ",-1;image:" + str(imgEmojiBorder) + ";color:0,0,0,128;depth:15")
emojiColourSelected as integer : emojiColourSelected = 1

// SAVE
fabSaveEmoji as integer : fabSaveEmoji = OryUICreateFloatingActionButton("icon:Save;depth:10")
OryUIHideFloatingActionButton(fabSaveEmoji)
