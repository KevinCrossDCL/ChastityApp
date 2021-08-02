
foldstart // OryUICard Widget (NOT USABLE YET)

type typeOryUICard
	id as integer
	autoHeight as integer
	blockOrder$ as string[]
	sprActionsContainer as integer
	sprButtons as integer[]
	sprContainer as integer
	sprIcons as integer
	sprPrimaryTitleContainer as integer
	sprRichMedia as integer
	sprRichMediaContainer as integer
	sprSupportingTextContainer as integer
	sprThumbnail as integer
	txtButtons as integer
	txtHeader as integer
	txtSubheader as integer
	txtSupportingText as integer
endtype

global OryUICardCollection as typeOryUICard[]

function OryUICreateCard(oryUIWidgetParameters$ as string)
	local oryUICardID as integer
	
	OryUICardCollection.length = OryUICardCollection.length + 1
	oryUICardID = OryUICardCollection.length
	OryUICardCollection[oryUICardID].id = oryUICardID

	oryUICreatedWidgets.insert(OryUIAddCreatedWidget(oryUICardID, "Card"))

	// DEFAULT SETTINGS
	OryUICardCollection[oryUICardID].autoHeight = 0
	
	OryUICardCollection[oryUICardID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprContainer, 94, 0)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprContainer, 255, 255, 255, 255)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUICardCollection[oryUICardID].sprContainer, 0, 0)
	SetSpritePhysicsOff(OryUICardCollection[oryUICardID].sprContainer)
	
	OryUICardCollection[oryUICardID].sprActionsContainer = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprActionsContainer, 94, 10)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprActionsContainer, random(0, 255), random(0, 255), random(0, 255), 255)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprActionsContainer, 0, 0)
	SetSpritePhysicsOff(OryUICardCollection[oryUICardID].sprActionsContainer)
	
	OryUICardCollection[oryUICardID].sprPrimaryTitleContainer = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer, 94, 10)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer, random(0, 255), random(0, 255), random(0, 255), 255)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer, 0, 0)
	SetSpritePhysicsOff(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer)
	
	OryUICardCollection[oryUICardID].sprRichMediaContainer = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprRichMediaContainer, 94, 10)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprRichMediaContainer, random(0, 255), random(0, 255), random(0, 255), 255)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprRichMediaContainer, 0, 0)
	SetSpritePhysicsOff(OryUICardCollection[oryUICardID].sprRichMediaContainer)
	
	OryUICardCollection[oryUICardID].sprSupportingTextContainer = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprSupportingTextContainer, 94, 10)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprSupportingTextContainer, random(0, 255), random(0, 255), random(0, 255), 255)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprSupportingTextContainer, 0, 0)
	SetSpritePositionByOffset(OryUICardCollection[oryUICardID].sprSupportingTextContainer, 0, 0)
	SetSpritePhysicsOff(OryUICardCollection[oryUICardID].sprSupportingTextContainer)
	
	remstart
	OryUICardCollection[oryUICardID].sprMedia = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprMedia, 94, 30)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprMedia, 155, 155, 155, 255)
	SetSpriteDepth(OryUICardCollection[oryUICardID].sprMedia, GetSpriteDepth(OryUICardCollection[oryUICardID].sprMedia) - 1)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprMedia, 0, 0)

	OryUICardCollection[oryUICardID].sprThumbnail = CreateSprite(0)
	SetSpriteSize(OryUICardCollection[oryUICardID].sprThumbnail, 12, -1)
	SetSpriteColor(OryUICardCollection[oryUICardID].sprThumbnail, 155, 155, 155, 255)
	SetSpriteDepth(OryUICardCollection[oryUICardID].sprThumbnail, GetSpriteDepth(OryUICardCollection[oryUICardID].sprContainer) - 1)
	SetSpriteOffset(OryUICardCollection[oryUICardID].sprThumbnail, 0, 0)

	OryUICardCollection[oryUICardID].txtHeader = CreateText("Header goes here")
	SetTextSize(OryUICardCollection[oryUICardID].txtHeader, 3.8)
	SetTextColor(OryUICardCollection[oryUICardID].txtHeader, 0, 0, 0, 255)
	SetTextAlignment(OryUICardCollection[oryUICardID].txtHeader, 0)
	SetTextDepth(OryUICardCollection[oryUICardID].txtHeader, GetSpriteDepth(OryUICardCollection[oryUICardID].sprContainer) - 1)
	
	OryUICardCollection[oryUICardID].txtSubheader = CreateText("Subheader goes here")
	SetTextSize(OryUICardCollection[oryUICardID].txtSubheader, 2.8)
	SetTextColor(OryUICardCollection[oryUICardID].txtSubheader, 100, 100, 100, 255)
	SetTextAlignment(OryUICardCollection[oryUICardID].txtSubheader, 0)
	SetTextDepth(OryUICardCollection[oryUICardID].txtSubheader, GetSpriteDepth(OryUICardCollection[oryUICardID].sprContainer) - 1)

	OryUICardCollection[oryUICardID].txtSupportingText = CreateText("Supporting text goes here")
	SetTextSize(OryUICardCollection[oryUICardID].txtSupportingText, 2.8)
	SetTextColor(OryUICardCollection[oryUICardID].txtSupportingText, 0, 0, 0, 255)
	SetTextAlignment(OryUICardCollection[oryUICardID].txtSupportingText, 0)
	SetTextDepth(OryUICardCollection[oryUICardID].txtSupportingText, GetSpriteDepth(OryUICardCollection[oryUICardID].sprContainer) - 1)
	remend
	
	if (oryUIWidgetParameters$ <> "") then OryUIUpdateCard(oryUICardID, oryUIWidgetParameters$)
endfunction oryUICardID

function OryUIDeleteCard(oryUICardID as integer)
	DeleteSprite(OryUICardCollection[oryUICardID].sprActionsContainer)
	DeleteSprite(OryUICardCollection[oryUICardID].sprContainer)
	//DeleteSprite(OryUICardCollection[oryUICardID].sprMedia)
	DeleteSprite(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer)
	DeleteSprite(OryUICardCollection[oryUICardID].sprRichMediaContainer)
	DeleteSprite(OryUICardCollection[oryUICardID].sprSupportingTextContainer)
	//DeleteSprite(OryUICardCollection[oryUICardID].sprThumbnail)
	//DeleteText(OryUICardCollection[oryUICardID].txtHeader)
	//DeleteText(OryUICardCollection[oryUICardID].txtSubheader)
	//DeleteText(OryUICardCollection[oryUICardID].txtSupportingText)
endfunction

function OryUIGetCardHeight(oryUICardID as integer)
	local oryUICardHeight# as float
	
	if (GetSpriteExists(OryUICardCollection[oryUICardID].sprContainer))
		oryUICardHeight# = GetSpriteHeight(OryUICardCollection[oryUICardID].sprContainer)
	endif
endfunction oryUICardHeight#

function OryUIGetCardWidth(oryUICardID as integer)
	local oryUICardWidth# as float
	
	if (GetSpriteExists(OryUICardCollection[oryUICardID].sprContainer))
		oryUICardWidth# = GetSpriteWidth(OryUICardCollection[oryUICardID].sprContainer)
	endif
endfunction oryUICardWidth#

function OryUIUpdateCard(oryUICardID as integer, oryUIWidgetParameters$ as string)
	local oryUIForI as integer
	
	OryUISetParametersType(oryUIWidgetParameters$)

	if (GetSpriteExists(OryUICardCollection[oryUICardID].sprContainer))
		if (oryUIParameters.blockOrder$.length >= 0)
			OryUICardCollection[oryUICardID].blockOrder$.length = -1
			for oryUIForI = 0 to oryUIParameters.blockOrder$.length
				OryUICardCollection[oryUICardID].blockOrder$.insert(oryUIParameters.blockOrder$[oryUIForI])
			next
		endif

		// IMPORTANT PARAMETERS FIRST WHICH AFFECT THE SIZE, OFFSET, AND POSITION OF THE WIDGET
		if (oryUIParameters.size#[1] > -999999 and oryUIParameters.size#[2] > -999999)
			SetSpriteSize(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.size#[1], oryUIParameters.size#[2])
		elseif (oryUIParameters.size#[1] > -999999 and oryUIParameters.size#[2] = -999999)
			SetSpriteSize(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.size#[1], GetSpriteHeight(OryUICardCollection[oryUICardID].sprContainer))
		elseif (oryUIParameters.size#[1] = -999999 and oryUIParameters.size#[2] > -999999)
			SetSpriteSize(OryUICardCollection[oryUICardID].sprContainer, GetSpriteWidth(OryUICardCollection[oryUICardID].sprContainer), oryUIParameters.size#[2])
		endif
		if (oryUIParameters.autoHeight >= 0)
			OryUICardCollection[oryUICardID].autoHeight = oryUIParameters.autoHeight
		endif
		//if (OryUITextCardCollection[oryUITextCardID].autoHeight = 1)
		//	SetSpriteSize(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.size#[1], 0.5 + GetTextTotalHeight(OryUITextCardCollection[oryUITextCardID].txtHeader) + 1 + GetTextTotalHeight(OryUITextCardCollection[oryUITextCardID].txtSupportingText) + 1)
		//endif

		
		if (oryUIParameters.color#[1] > -999999 or oryUIParameters.color#[2] > -999999 or oryUIParameters.color#[3] > -999999 or oryUIParameters.color#[4] > -999999)
			SetSpriteColor(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.color#[1], oryUIParameters.color#[2], oryUIParameters.color#[3], oryUIParameters.color#[4])
		endif
		if (oryUIParameters.depth > -999999)
			SetSpriteDepth(OryUICardCollection[oryUICardID].sprActionsContainer, oryUIParameters.depth - 1)
			SetSpriteDepth(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.depth)
			SetSpriteDepth(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer, oryUIParameters.depth - 1)
			SetSpriteDepth(OryUICardCollection[oryUICardID].sprRichMediaContainer, oryUIParameters.depth - 1)
			SetSpriteDepth(OryUICardCollection[oryUICardID].sprSupportingTextContainer, oryUIParameters.depth - 1)
		endif
		if (oryUIParameters.fixToScreen = 1)
			FixSpriteToScreen(OryUICardCollection[oryUICardID].sprContainer, 1)
		endif
		if (oryUIParameters.offsetCenter = 1)
			SetSpriteOffset(OryUICardCollection[oryUICardID].sprContainer, GetSpriteWidth(OryUICardCollection[oryUICardID].sprContainer) / 2, GetSpriteHeight(OryUICardCollection[oryUICardID].sprContainer) / 2)
		else
			if (oryUIParameters.offset#[1] > -999999 or oryUIParameters.offset#[2] > -999999)
				SetSpriteOffset(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.offset#[1], oryUIParameters.offset#[2])
			endif
		endif
		if (oryUIParameters.position#[1] > -999999 and oryUIParameters.position#[2] > -999999)
			SetSpritePositionByOffset(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.position#[1], oryUIParameters.position#[2])
		elseif (oryUIParameters.position#[1] > -999999 and oryUIParameters.position#[2] = -999999)
			SetSpritePositionByOffset(OryUICardCollection[oryUICardID].sprContainer, oryUIParameters.position#[1], GetSpriteYByOffset(OryUICardCollection[oryUICardID].sprContainer))
		elseif (oryUIParameters.position#[1] = -999999 and oryUIParameters.position#[2] > -999999)
			SetSpritePositionByOffset(OryUICardCollection[oryUICardID].sprContainer, GetSpriteXByOffset(OryUICardCollection[oryUICardID].sprContainer), oryUIParameters.position#[2])
		endif

		oryUIBlockY# = 0
		for oryUIForI = 0 to oryUIParameters.blockOrder$.length
			if (lower(OryUICardCollection[oryUICardID].blockOrder$[oryUIForI]) = "actions")
				OryUIPinSpriteToSprite(OryUICardCollection[oryUICardID].sprActionsContainer, OryUICardCollection[oryUICardID].sprContainer, 0, oryUIBlockY#)
				oryUIBlockY# = oryUIBlockY# + GetSpriteHeight(OryUICardCollection[oryUICardID].sprActionsContainer)
			endif
			if (lower(left(OryUICardCollection[oryUICardID].blockOrder$[oryUIForI], 7)) = "divider")

			endif
			if (lower(OryUICardCollection[oryUICardID].blockOrder$[oryUIForI]) = "richmedia")
				OryUIPinSpriteToSprite(OryUICardCollection[oryUICardID].sprRichMediaContainer, OryUICardCollection[oryUICardID].sprContainer, 0, oryUIBlockY#)
				oryUIBlockY# = oryUIBlockY# + GetSpriteHeight(OryUICardCollection[oryUICardID].sprRichMediaContainer)
			endif
			if (lower(OryUICardCollection[oryUICardID].blockOrder$[oryUIForI]) = "primarytitle")
				OryUIPinSpriteToSprite(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer, OryUICardCollection[oryUICardID].sprContainer, 0, oryUIBlockY#)
				oryUIBlockY# = oryUIBlockY# + GetSpriteHeight(OryUICardCollection[oryUICardID].sprPrimaryTitleContainer)
			endif
			if (lower(OryUICardCollection[oryUICardID].blockOrder$[oryUIForI]) = "supportingtext")
				OryUIPinSpriteToSprite(OryUICardCollection[oryUICardID].sprSupportingTextContainer, OryUICardCollection[oryUICardID].sprContainer, 0, oryUIBlockY#)
				oryUIBlockY# = oryUIBlockY# + GetSpriteHeight(OryUICardCollection[oryUICardID].sprSupportingTextContainer)
			endif
		next
	endif

	
		//oryUIParameters.contentText$ = GetTextString(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextAlignment = GetTextAlignment(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextColor#[1] = GetTextColorRed(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextColor#[2] = GetTextColorGreen(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextColor#[3] = GetTextColorBlue(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextColor#[4] = GetTextColorAlpha(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.contentTextSize# = GetTextSize(OryUICardCollection[cardID].txtContent)
		//oryUIParameters.titleText$ = GetTextString(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextAlignment = GetTextAlignment(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextColor#[1] = GetTextColorRed(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextColor#[2] = GetTextColorGreen(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextColor#[3] = GetTextColorBlue(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextColor#[4] = GetTextColorAlpha(OryUICardCollection[cardID].txtTitle)
		//oryUIParameters.titleTextSize# = GetTextSize(OryUICardCollection[cardID].txtTitle)
		

		
		//SetTextString(OryUICardCollection[cardID].txtTitle, OryUIWrapText(oryUIParameters.titleText$, oryUIParameters.titleTextSize#, oryUIParameters.size#[1]))
		//SetTextSize(OryUICardCollection[cardID].txtTitle, oryUIParameters.titleTextSize#)
		//if (oryUIParameters.titleTextBold = 0)
			//SetTextBold(OryUICardCollection[cardID].txtTitle, 0)
		//elseif (oryUIParameters.titleTextBold = 1)
			//SetTextBold(OryUICardCollection[cardID].txtTitle, 1)
		//endif
		//SetTextColor(OryUICardCollection[cardID].txtTitle, oryUIParameters.titleTextColor#[1], oryUIParameters.titleTextColor#[2], oryUIParameters.titleTextColor#[3], oryUIParameters.titleTextColor#[4])
		//SetTextAlignment(OryUICardCollection[cardID].txtTitle, oryUIParameters.titleTextAlignment)
		//SetTextDepth(OryUICardCollection[cardID].txtTitle, oryUIParameters.depth - 1)
		//if (oryUIParameters.titleTextAlignment = 0)
			//OryUIPinTextToTopLeftOfSprite(OryUICardCollection[cardID].txtTitle, OryUICardCollection[cardID].sprBackground, 2, 0.5)
		//elseif (oryUIParameters.titleTextAlignment = 1)
			//OryUIPinTextToTopCentreOfSprite(OryUICardCollection[cardID].txtTitle, OryUICardCollection[cardID].sprBackground, 0, 0.5)
		//elseif (oryUIParameters.titleTextAlignment = 2)
			//OryUIPinTextToTopRightOfSprite(OryUICardCollection[cardID].txtTitle, OryUICardCollection[cardID].sprBackground, 2, 0.5)
		//endif
		
		//SetTextString(OryUICardCollection[cardID].txtContent, OryUIWrapText(oryUIParameters.contentText$, oryUIParameters.contentTextSize#, oryUIParameters.size#[1] - 4))
		//SetTextSize(OryUICardCollection[cardID].txtContent, oryUIParameters.contentTextSize#)
		//if (oryUIParameters.contentTextBold = 0)
			//SetTextBold(OryUICardCollection[cardID].txtContent, 0)
		//elseif (oryUIParameters.contentTextBold = 1)
			//SetTextBold(OryUICardCollection[cardID].txtContent, 1)
		//endif
		//SetTextColor(OryUICardCollection[cardID].txtContent, oryUIParameters.contentTextColor#[1], oryUIParameters.contentTextColor#[2], oryUIParameters.contentTextColor#[3], oryUIParameters.contentTextColor#[4])
		//SetTextAlignment(OryUICardCollection[cardID].txtContent, oryUIParameters.contentTextAlignment)
		//SetTextDepth(OryUICardCollection[cardID].txtContent, oryUIParameters.depth - 1)
		//if (oryUIParameters.contentTextAlignment = 0)
			//OryUIPinTextToTopLeftOfSprite(OryUICardCollection[cardID].txtContent, OryUICardCollection[cardID].sprBackground, 2, 0.5 + GetTextTotalHeight(OryUICardCollection[cardID].txtTitle) + 1)
		//elseif (oryUIParameters.contentTextAlignment = 1)
			//OryUIPinTextToTopCentreOfSprite(OryUICardCollection[cardID].txtContent, OryUICardCollection[cardID].sprBackground, 0, 0.5 + GetTextTotalHeight(OryUICardCollection[cardID].txtTitle) + 1)
		//elseif (oryUIParameters.contentTextAlignment = 2)
			//OryUIPinTextToTopRightOfSprite(OryUICardCollection[cardID].txtContent, OryUICardCollection[cardID].sprBackground, 2, 0.5 + GetTextTotalHeight(OryUICardCollection[cardID].txtTitle) + 1)
		//endif
		
		//if (OryUICardCollection[cardID].autoHeight = 1)
			//SetSpriteSize(OryUICardCollection[cardID].sprBackground, oryUIParameters.size#[1], 0.5 + GetTextTotalHeight(OryUICardCollection[cardID].txtTitle) + 1 + GetTextTotalHeight(OryUICardCollection[cardID].txtContent) + 1)
		//endif
endfunction

foldend
