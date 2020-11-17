
foldstart // OryUIPicker Component (Updated 07/07/2020)

type typeOryUIPicker
	id as integer
	autoHeight as integer
	buttonPressed
	buttonReleased as integer
	buttons as typeOryUIPickerButton[]
	flexButtons as integer
	noOfPickers as integer
	pickers as typeOryUIPickerSpinner[]
	sprContainer as integer
	sprScrim as integer
	stackButtons as integer
	txtSupportingText as integer
	txtTitle as integer
	visible as integer
endtype

type typeOryUIPickerButton
	id as integer
	name$ as string
	pressed as integer
	released as integer
	sprContainer as integer
	txtLabel as integer
endtype

type typeOryUIPickerSpinner
	id as integer
	name$ as string
	sprBottom as integer
	sprBottomBorder as integer
	sprCenter as integer
	sprTop as integer
	sprTopBorder as integer
	txtBottom as integer
	txtCenter as integer
	txtTitle as integer
	txtTop as integer
endtype

global OryUIPickerCollection as typeOryUIPicker[]
OryUIPickerCollection.length = 1

function OryUICreatePicker(oryUIComponentParameters$ as string)
	local oryUIPickerID as integer
	
	OryUIPickerCollection.length = OryUIPickerCollection.length + 1
	oryUIPickerID = OryUIPickerCollection.length
	OryUIPickerCollection[oryUIPickerID].id = oryUIPickerID

	// DEFAULT SETTINGS
	OryUIPickerCollection[oryUIPickerID].autoHeight = oryUIDefaults.pickerAutoHeight
	OryUIPickerCollection[oryUIPickerID].flexButtons = oryUIDefaults.pickerFlexButtons
	OryUIPickerCollection[oryUIPickerID].noOfPickers = 1
	OryUIPickerCollection[oryUIPickerID].stackButtons = oryUIDefaults.pickerStackButtons
	
	OryUIPickerCollection[oryUIPickerID].sprScrim = CreateSprite(0)
	SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprScrim, 100, abs(GetScreenBoundsTop() * 2) + 100)
	SetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprScrim, oryUIDefaults.PickerDepth)
	SetSpriteColor(OryUIPickerCollection[oryUIPickerID].sprScrim, oryUIDefaults.PickerScrimColor#[1], oryUIDefaults.PickerScrimColor#[2], oryUIDefaults.PickerScrimColor#[3], oryUIDefaults.PickerScrimColor#[4])
	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].sprScrim, 0, 0)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprScrim, -999999, -999999)
	SetSpritePhysicsOff(OryUIPickerCollection[oryUIPickerID].sprScrim)
	
	OryUIPickerCollection[oryUIPickerID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerWidth#, oryUIDefaults.PickerHeight#)
	SetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerDepth - 1)
	SetSpriteColor(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerColor#[1], oryUIDefaults.PickerColor#[2], oryUIDefaults.PickerColor#[3], oryUIDefaults.PickerColor#[4])
	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, -999999, -999999)
	SetSpritePhysicsOff(OryUIPickerCollection[oryUIPickerID].sprContainer)

	OryUIPickerCollection[oryUIPickerID].txtTitle = CreateText("")
	SetTextSize(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIDefaults.PickerTitleTextSize#)
	SetTextColor(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIDefaults.PickerTitleTextColor#[1], oryUIDefaults.PickerTitleTextColor#[2], oryUIDefaults.PickerTitleTextColor#[3], oryUIDefaults.PickerTitleTextColor#[4])
	SetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIDefaults.PickerTitleTextAlignment)
	SetTextDepth(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIDefaults.PickerDepth - 2)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].txtTitle, -999999, -999999)

	OryUIPickerCollection[oryUIPickerID].txtSupportingText = CreateText("")
	SetTextSize(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIDefaults.PickerSupportingTextSize#)
	SetTextColor(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIDefaults.PickerSupportingTextColor#[1], oryUIDefaults.PickerSupportingTextColor#[2], oryUIDefaults.PickerSupportingTextColor#[3], oryUIDefaults.PickerSupportingTextColor#[4])
	SetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIDefaults.PickerSupportingTextAlignment)
	SetTextDepth(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIDefaults.PickerDepth - 2)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].txtSupportingText, -999999, -999999)

	if (oryUIComponentParameters$ <> "") then OryUIUpdatePicker(oryUIPickerID, oryUIComponentParameters$)
endfunction oryUIPickerID

function OryUIDeletePicker(oryUIPickerID as integer)
	local oryUIForI as integer
	
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].sprScrim)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].sprContainer)
	DeleteText(OryUIPickerCollection[oryUIPickerID].txtTitle)
	DeleteText(OryUIPickerCollection[oryUIPickerID].txtSupportingText)
	for oryUIForI = 1 to OryUIPickerCollection[oryUIPickerID].noOfPickers
		while (OryUIPickerCollection[oryUIPickerID].pickers.length > 0)
			OryUIDeletePickerSpinner(oryUIPickerID, 0)
		endwhile
	next
	while (OryUIPickerCollection[oryUIPickerID].buttons.length > 0)
		OryUIDeletePickerButton(oryUIPickerID, 0)
	endwhile
endfunction

function OryUIDeletePickerButton(oryUIPickerID as integer, oryUIButtonID as integer)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID].sprContainer)
	DeleteText(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID].txtLabel)
	OryUIPickerCollection[oryUIPickerID].buttons.remove(oryUIButtonID)
endfunction

function OryUIDeletePickerSpinner(oryUIPickerID as integer, oryUISpinnerID as integer)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].sprBottom)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].sprBottomBorder)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].sprCenter)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].sprTop)
	DeleteSprite(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].sprTopBorder)
	DeleteText(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].txtBottom)
	DeleteText(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].txtCenter)
	DeleteText(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].txtTitle)
	DeleteText(OryUIPickerCollection[oryUIPickerID].pickers[oryUISpinnerID].txtTop)
	OryUIPickerCollection[oryUIPickerID].pickers.remove(oryUISpinnerID)
endfunction

function OryUIGetPickerButtonCount(oryUIPickerID as integer)
	local oryUIPickerButtonCount as integer
	
	oryUIPickerButtonCount = OryUIPickerCollection[oryUIPickerID].buttons.length + 1
endfunction oryUIPickerButtonCount

function OryUIGetPickerSpinnerCount(oryUIPickerID as integer)
	local oryUIPickerSpinnerCount as integer
	
	oryUIPickerSpinnerCount = OryUIPickerCollection[oryUIPickerID].pickers.length + 1
endfunction oryUIPickerButtonCount

function OryUIGetPickerButtonHeight(oryUIPickerID as integer, oryUIButtonID as integer)
	local oryUIPickerButtonHeight# as float
	
	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer))
		oryUIPickerButtonHeight# = GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer)
	endif
endfunction oryUIPickerButtonHeight#

function OryUIGetPickerButtonReleasedByIndex(oryUIPickerID as integer, oryUIPickerButtonIndex as integer)
	local oryUIPickerButtonReleased as integer
	
	oryUIPickerButtonReleased = 0
	if (OryUIPickerCollection[oryUIPickerID].buttonReleased = oryUIPickerButtonIndex) then oryUIPickerButtonReleased = 1
endfunction oryUIPickerButtonReleased

function OryUIGetPickerButtonReleasedByName(oryUIPickerID as integer, oryUIPickerButtonName$ as string)
	local oryUIPickerButtonReleased as integer
	
	oryUIPickerButtonReleased = 0
	if (OryUIPickerCollection[oryUIPickerID].buttonReleased > 0)
		if (lower(OryUIPickerCollection[oryUIPickerID].buttons[OryUIPickerCollection[oryUIPickerID].buttonReleased - 1].name$) = lower(oryUIPickerButtonName$)) then oryUIPickerButtonReleased = 1
	endif
endfunction oryUIPickerButtonReleased

function OryUIGetPickerButtonReleasedIndex(oryUIPickerID as integer)
	local oryUIPickerButtonReleasedIndex as integer
	
	oryUIPickerButtonReleasedIndex = OryUIPickerCollection[oryUIPickerID].buttonReleased
endfunction oryUIPickerButtonReleasedIndex

function OryUIGetPickerButtonReleasedName(oryUIPickerID as integer)
	local oryUIPickerButtonReleasedName$ as string
	
	if (OryUIPickerCollection[oryUIPickerID].buttonReleased > 0)
		oryUIPickerButtonReleasedName$ = OryUIPickerCollection[oryUIPickerID].buttons[OryUIPickerCollection[oryUIPickerID].buttonReleased - 1].name$
	endif
endfunction oryUIPickerButtonReleasedName$

function OryUIGetPickerButtonWidth(oryUIPickerID as integer, oryUIButtonID as integer)
	local oryUIPickerButtonWidth# as float
	
	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer))
		oryUIPickerButtonWidth# = GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer)
	endif
endfunction oryUIPickerButtonWidth#

function OryUIGetPickerHeight(oryUIPickerID as integer)
	local oryUIPickerHeight# as float
	
	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].sprContainer))
		oryUIPickerHeight# = GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].sprContainer)
	endif
endfunction oryUIPickerHeight#

function OryUIGetPickerWidth(oryUIPickerID as integer)
	local oryUIPickerWidth# as float
	
	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].sprContainer))
		oryUIPickerWidth# = GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer)
	endif
endfunction oryUIPickerWidth#

function OryUIGetPickerVisible(oryUIPickerID as integer)

endfunction oryUIPickerVisible

function OryUIHidePicker(oryUIPickerID as integer)
	local oryUIForI as integer
	
	oryUIScrimVisible = 0
	oryUIBlockScreenScrolling = 0
	oryUIPickerVisible = 0
	OryUIPickerCollection[oryUIPickerID].visible = 0
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprScrim, -999999, -999999)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, -999999, -999999)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].txtTitle, -999999, -999999)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].txtSupportingText, -999999, -999999)
	for oryUIForI = 0 to OryUIGetPickerButtonCount(oryUIPickerID) - 1
		if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
			SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, -999999, -999999)
			SetTextPosition(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].txtLabel, -999999, -999999)
		endif
	next
endfunction

function OryUIInsertPickerButton(oryUIPickerID as integer, oryUIIndex as integer, oryUIComponentParameters$ as string)
	local oryUIPickerButtonID as integer
	
	if (oryUIIndex = -1)
		OryUIPickerCollection[oryUIPickerID].buttons.length = OryUIPickerCollection[oryUIPickerID].buttons.length + 1
		oryUIPickerButtonID = OryUIPickerCollection[oryUIPickerID].buttons.length
		OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].id = oryUIPickerButtonID + 1
	endif

	OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer, 30, oryUIDefaults.PickerButtonHeight#)
	SetSpriteDepth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer, GetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprContainer) - 1)
	SetSpriteColor(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer, oryUIDefaults.PickerButtonColor#[1], oryUIDefaults.PickerButtonColor#[2], oryUIDefaults.PickerButtonColor#[3], oryUIDefaults.PickerButtonColor#[4])
	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer, -999999, -999999)
	SetSpritePhysicsOff(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer)

	OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel = CreateText("Button")
	SetTextSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, oryUIDefaults.PickerButtonTextSize#)
	SetTextBold(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, oryUIDefaults.PickerButtonTextBold)
	SetTextColor(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, oryUIDefaults.PickerButtonTextColor#[1], oryUIDefaults.PickerButtonTextColor#[2], oryUIDefaults.PickerButtonTextColor#[3], oryUIDefaults.PickerButtonTextColor#[4])
	SetTextAlignment(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, 1)
	SetTextDepth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, GetSpriteDepth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].sprContainer) - 1)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].buttons[oryUIPickerButtonID].txtLabel, -999999, -999999)
	
	if (oryUIComponentParameters$ <> "") then OryUIUpdatePickerButton(oryUIPickerID, oryUIPickerButtonID + 1, oryUIComponentParameters$)
endfunction

function OryUIInsertPickerSpinner(oryUIPickerID as integer, oryUIIndex as integer, oryUIComponentParameters$ as string)
	local oryUIPickerSpinnerID as integer
	
	if (oryUIIndex = -1)
		OryUIPickerCollection[oryUIPickerID].pickers.length = OryUIPickerCollection[oryUIPickerID].pickers.length + 1
		oryUIPickerSpinnerID = OryUIPickerCollection[oryUIPickerID].pickers.length
		OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].id = oryUIPickerSpinnerID + 1
	endif

	OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer = CreateSprite(0)
	SetSpriteSize(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer, 30, oryUIDefaults.PickerButtonHeight#)
	SetSpriteDepth(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer, GetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprContainer) - 1)
	SetSpriteColor(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer, oryUIDefaults.PickerButtonColor#[1], oryUIDefaults.PickerButtonColor#[2], oryUIDefaults.PickerButtonColor#[3], oryUIDefaults.PickerButtonColor#[4])
	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer, 0, 0)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].sprContainer, -999999, -999999)

	OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel = CreateText("Button")
	SetTextSize(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, oryUIDefaults.PickerButtonTextSize#)
	SetTextBold(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, oryUIDefaults.PickerButtonTextBold)
	SetTextColor(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, oryUIDefaults.PickerButtonTextColor#[1], oryUIDefaults.PickerButtonTextColor#[2], oryUIDefaults.PickerButtonTextColor#[3], oryUIDefaults.PickerButtonTextColor#[4])
	SetTextAlignment(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, 1)
	SetTextDepth(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, GetSpriteDepth(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerButtonID].sprContainer) - 1)
	SetTextPosition(OryUIPickerCollection[oryUIPickerID].pickers[oryUIPickerSpinnerID].txtLabel, -999999, -999999)
	
	if (oryUIComponentParameters$ <> "") then OryUIUpdatePickerSpinner(oryUIPickerID, oryUIPickerSpinnerID + 1, oryUIComponentParameters$)
endfunction

function OryUIInsertPickerListener(oryUIPickerID as integer)
	local oryUIPickerButtonSprite as integer
	local oryUIPickerContainerSprite as integer
	local oryUIPickerScrimSprite as integer
	local oryUIForI as integer
	
	OryUIPickerCollection[oryUIPickerID].buttonPressed = -1
	OryUIPickerCollection[oryUIPickerID].buttonReleased = -1
	if (GetRawKeyPressed(27) and OryUIPickerCollection[oryUIPickerID].visible = 1)
		OryUIHidePicker(oryUIPickerID)
	endif
	if (OryUIPickerCollection[oryUIPickerID].visible = 1)
		for oryUIForI = 0 to OryUIGetPickerButtonCount(oryUIPickerID) - 1
			OryUIUpdatePickerButton(oryUIPickerID, oryUIForI + 1, "")
			if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				if (OryUIGetSwipingVertically() = 0)
					if (GetPointerPressed())
						oryUIPickerContainerSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].sprContainer, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
						oryUIPickerScrimSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].sprScrim, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
						oryUIPickerButtonSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
						if (oryUIPickerScrimSprite = 1 and oryUIPickerContainerSprite = 0)
							OryUIHidePicker(oryUIPickerID)
						endif
						if (oryUIPickerButtonSprite = 1)
							OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].pressed = 1
							OryUIPickerCollection[oryUIPickerID].buttonPressed = oryUIForI + 1
						endif
					else
						if (GetPointerState())
							oryUIPickerButtonSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
							if (OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].pressed)
								if (oryUIPickerButtonSprite = 0)
									OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].pressed = 0
									OryUIPickerCollection[oryUIPickerID].buttonPressed = 0
								endif
							endif
						endif
						if (GetPointerReleased())
							oryUIPickerScrimSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].sprScrim, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
							oryUIPickerButtonSprite = GetSpriteHitTest(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))
							if (OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].pressed)
								if (oryUIPickerButtonSprite = 1)
									OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].released = 1
									OryUIPickerCollection[oryUIPickerID].buttonReleased = oryUIForI + 1
								endif
								OryUIHidePicker(oryUIPickerID)
							endif
							OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].pressed = 0
							OryUIPickerCollection[oryUIPickerID].buttonPressed = 0
						endif
					endif
				endif
			endif
		next
	endif
endfunction

function OryUISetPickerButtonCount(oryUIPickerID as integer, oryUINewPickerButtonCount as integer)
	local oryUIForI as integer
	local oryUIOldPickerButtonCount as integer
	
	oryUIOldPickerButtonCount = OryUIGetPickerButtonCount(oryUIPickerID) - 1
	while (OryUIGetPickerButtonCount(oryUIPickerID) - 1 > oryUINewPickerButtonCount - 1)
		OryUIDeletePickerButton(oryUIPickerID, OryUIGetPickerButtonCount(oryUIPickerID) - 1)
	endwhile
	for oryUIForI = 0 to oryUINewPickerButtonCount - 1
		if (oryUIForI > oryUIOldPickerButtonCount)
			OryUIInsertPickerButton(oryUIPickerID, -1, "")
		endif
	next
endfunction

function OryUISetPickerSpinnerCount(oryUIPickerID as integer, oryUINewPickerSpinnerCount as integer)
	local oryUIForI as integer
	local oryUIOldPickerSpinnerCount as integer
	
	oryUIOldPickerSpinnerCount = OryUIGetPickerSpinnerCount(oryUIPickerID) - 1
	while (OryUIGetPickerSpinnerCount(oryUIPickerID) - 1 > oryUINewPickerSpinnerCount - 1)
		OryUIDeletePickerSpinner(oryUIPickerID, OryUIGetPickerSpinnerCount(oryUIPickerID) - 1)
	endwhile
	for oryUIForI = 0 to oryUINewPickerSpinnerCount - 1
		if (oryUIForI > oryUIOldPickerSpinnerCount)
			OryUIInsertPickerSpinner(oryUIPickerID, -1, "")
		endif
	next
endfunction

function OryUIShowPicker(oryUIPickerID as integer)
	local oryUIButtonWidth# as float
	local oryUIForI as integer
	local oryUILastButtonX# as float
	local oryUILastButtonY# as float

	oryUIScrimDepth = GetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprScrim)
	oryUIScrimVisible = 1
	oryUIBlockScreenScrolling = 1
	oryUIPickerVisible = 1
	OryUIPickerCollection[oryUIPickerID].visible = 1
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprScrim, GetViewOffsetX(), GetViewOffsetY() + GetScreenBoundsTop())

	if (OryUIPickerCollection[oryUIPickerID].autoHeight = 1)
		if (OryUIPickerCollection[oryUIPickerID].stackButtons = 0)
			SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer), oryUIDefaults.PickerTopMargin# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtTitle) + oryUIDefaults.PickerSpacingBetweenTitleAndSupportingText# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtSupportingText) + GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[0].sprContainer) + oryUIDefaults.PickerBottomMargin#)
		endif
		if (OryUIPickerCollection[oryUIPickerID].stackButtons = 1)
			SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer), oryUIDefaults.PickerTopMargin# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtTitle) + oryUIDefaults.PickerSpacingBetweenTitleAndSupportingText# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtSupportingText) + (OryUIGetPickerButtonCount(oryUIPickerID) * (GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[0].sprContainer) + oryUIDefaults.PickerButtonYSpacing#)) + oryUIDefaults.PickerBottomMargin#)
		endif
	endif
	
	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) / 2, GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].sprContainer) / 2)
	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, GetViewOffsetX() + 50, GetViewOffsetY() + 50)
	if (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtTitle) = 0)
		OryUIPinTextToTopLeftOfSprite(OryUIPickerCollection[oryUIPickerID].txtTitle, OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerLeftMargin#, oryUIDefaults.PickerTopMargin#)
	elseif (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtTitle) = 1)
		OryUIPinTextToTopCentreOfSprite(OryUIPickerCollection[oryUIPickerID].txtTitle, OryUIPickerCollection[oryUIPickerID].sprContainer, 0, oryUIDefaults.PickerTopMargin#)
	elseif (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtTitle) = 2)
		OryUIPinTextToTopRightOfSprite(OryUIPickerCollection[oryUIPickerID].txtTitle, OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerRightMargin#, oryUIDefaults.PickerTopMargin#)
	endif
	if (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtSupportingText) = 0)
		OryUIPinTextToTopLeftOfSprite(OryUIPickerCollection[oryUIPickerID].txtSupportingText, OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerLeftMargin#, oryUIDefaults.PickerTopMargin# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtTitle) + oryUIDefaults.PickerSpacingBetweenTitleAndSupportingText#)
	elseif (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtSupportingText) = 1)
		OryUIPinTextToTopCentreOfSprite(OryUIPickerCollection[oryUIPickerID].txtSupportingText, OryUIPickerCollection[oryUIPickerID].sprContainer, 0, oryUIDefaults.PickerTopMargin# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtTitle) + oryUIDefaults.PickerSpacingBetweenTitleAndSupportingText#)
	elseif (GetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtSupportingText) = 2)
		OryUIPinTextToTopRightOfSprite(OryUIPickerCollection[oryUIPickerID].txtSupportingText, OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIDefaults.PickerRightMargin#, oryUIDefaults.PickerTopMargin# + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtTitle) + oryUIDefaults.PickerSpacingBetweenTitleAndSupportingText#)
	endif

	oryUILastButtonX# = GetSpriteX(OryUIPickerCollection[oryUIPickerID].sprContainer) + GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer)
	if (OryUIPickerCollection[oryUIPickerID].stackButtons = 0)
		for oryUIForI = OryUIGetPickerButtonCount(oryUIPickerID) - 1 to 0 step - 1
			if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				if (OryUIPickerCollection[oryUIPickerID].flexButtons = 0)
					SetSpriteSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, GetTextTotalWidth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].txtLabel) + (oryUIDefaults.PickerButtonXSpacing# * 2), GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				endif
				if (OryUIPickerCollection[oryUIPickerID].flexButtons = 1)
					oryUIButtonWidth# = (GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) - ((OryUIGetPickerButtonCount(oryUIPickerID) + 1) * 2)) / OryUIGetPickerButtonCount(oryUIPickerID)
					SetSpriteSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, oryUIButtonWidth#, GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				endif
				SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, oryUILastButtonX# - oryUIDefaults.PickerButtonXSpacing# - GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer), GetTextY(OryUIPickerCollection[oryUIPickerID].txtSupportingText) + GetTextTotalHeight(OryUIPickerCollection[oryUIPickerID].txtSupportingText))
				OryUIPinTextToCentreOfSprite(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].txtLabel, OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, 0, 0)
				oryUILastButtonX# = GetSpriteX(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer)
			endif
		next
	endif
	oryUILastButtonX# = GetSpriteX(OryUIPickerCollection[oryUIPickerID].sprContainer) + GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer)
	oryUILastButtonY# = GetSpriteY(OryUIPickerCollection[oryUIPickerID].sprContainer) + GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].sprContainer)
	if (OryUIPickerCollection[oryUIPickerID].stackButtons = 1)
		for oryUIForI = OryUIGetPickerButtonCount(oryUIPickerID) - 1 to 0 step - 1
			if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				if (OryUIPickerCollection[oryUIPickerID].flexButtons = 0)
					SetSpriteSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, GetTextTotalWidth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].txtLabel) + (oryUIDefaults.PickerButtonXSpacing# * 2), GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				endif
				if (OryUIPickerCollection[oryUIPickerID].flexButtons = 1)
					oryUIButtonWidth# = GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) - (oryUIDefaults.PickerButtonXSpacing# * 2)
					SetSpriteSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, oryUIButtonWidth#, GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				endif
				SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, oryUILastButtonX# - oryUIDefaults.PickerButtonXSpacing# - GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer), oryUILastButtonY# - oryUIDefaults.PickerButtonYSpacing# - GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer))
				OryUIPinTextToCentreOfSprite(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].txtLabel, OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer, 0, 0)
				oryUILastButtonY# = GetSpriteY(OryUIPickerCollection[oryUIPickerID].buttons[oryUIForI].sprContainer)
			endif
		next
	endif
endfunction

function OryUIUpdatePicker(oryUIPickerID as integer, oryUIComponentParameters$ as string)
	OryUISetParametersType(oryUIComponentParameters$)

	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].sprContainer))

		// IMPORTANT PARAMETERS FIRST WHICH AFFECT THE SIZE, OFFSET, AND POSITION OF THE COMPONENT
		if (oryUIParameters.size#[1] > -999999 and oryUIParameters.size#[2] > -999999)
			SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.size#[1], oryUIParameters.size#[2])
		elseif (oryUIParameters.size#[1] > -999999 and oryUIParameters.size#[2] = -999999)
			SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.size#[1], GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].sprContainer))
		elseif (oryUIParameters.size#[1] = -999999 and oryUIParameters.size#[2] > -999999)
			SetSpriteSize(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer), oryUIParameters.size#[2])
		endif
		if (oryUIParameters.supportingTextBold > -999999)
			SetTextBold(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIParameters.supportingTextBold)
		endif
		if (oryUIParameters.supportingTextSize# > -999999)
			SetTextSize(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIParameters.supportingTextSize#)
		endif
		if (oryUIParameters.supportingText$ <> "")
			SetTextString(OryUIPickerCollection[oryUIPickerID].txtSupportingText, OryUIWrapText(oryUIParameters.supportingText$, GetTextSize(OryUIPickerCollection[oryUIPickerID].txtSupportingText), GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) - oryUIDefaults.PickerLeftMargin# - oryUIDefaults.PickerRightMargin#))
		endif
		if (oryUIParameters.titleTextBold > -999999)
			SetTextBold(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIParameters.titleTextBold)
		endif
		if (oryUIParameters.titleTextSize# > -999999)
			SetTextSize(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIParameters.titleTextSize#)
		endif
		if (oryUIParameters.titleText$ <> "")
			if (lower(oryUIParameters.titleText$) = "null") then oryUIParameters.titleText$ = ""
			SetTextString(OryUIPickerCollection[oryUIPickerID].txtTitle, OryUIWrapText(oryUIParameters.titleText$, GetTextSize(OryUIPickerCollection[oryUIPickerID].txtTitle), GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) - oryUIDefaults.PickerLeftMargin# - oryUIDefaults.PickerRightMargin#))
		endif
		if (oryUIParameters.autoHeight > -999999)
			OryUIPickerCollection[oryUIPickerID].autoHeight = oryUIParameters.autoHeight
		endif
		if (oryUIParameters.flexButtons > -999999)
			OryUIPickerCollection[oryUIPickerID].flexButtons = oryUIParameters.flexButtons
		endif
		//if (oryUIParameters.offsetCenter = 1)
		//	SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteWidth(OryUIPickerCollection[oryUIPickerID].sprContainer) / 2, GetSpriteHeight(OryUIPickerCollection[oryUIPickerID].sprContainer) / 2)
		//else
		//	if (oryUIParameters.offset#[1] > -999999 or oryUIParameters.offset#[2] > -999999)
		//		SetSpriteOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.offset#[1], oryUIParameters.offset#[2])
		//	endif
		//endif
		//if (oryUIParameters.position#[1] > -999999 and oryUIParameters.position#[2] > -999999)
		//	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.position#[1], oryUIParameters.position#[2])
		//elseif (oryUIParameters.position#[1] > -999999 and oryUIParameters.position#[2] = -999999)
		//	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.position#[1], GetSpriteYByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer))
		//elseif (oryUIParameters.position#[1] = -999999 and oryUIParameters.position#[2] > -999999)
		//	SetSpritePositionByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer, GetSpriteXByOffset(OryUIPickerCollection[oryUIPickerID].sprContainer), oryUIParameters.position#[2])
		//endif

		// THE REST OF THE PARAMETERS NEXT
		if (oryUIParameters.color#[1] > -999999 or oryUIParameters.color#[2] > -999999 or oryUIParameters.color#[3] > -999999 or oryUIParameters.color#[4] > -999999)
			SetSpriteColor(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.color#[1], oryUIParameters.color#[2], oryUIParameters.color#[3], oryUIParameters.color#[4])
		endif
		if (oryUIParameters.depth > -999999)
			SetSpriteDepth(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.depth)
			SetTextDepth(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIParameters.depth - 1)
			SetTextDepth(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIParameters.depth - 1)
		endif
		if (oryUIParameters.stackButtons > -999999)
			OryUIPickerCollection[oryUIPickerID].stackButtons = oryUIParameters.stackButtons
		endif
		if (oryUIParameters.titleTextAlignment > -999999)
			SetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIParameters.titleTextAlignment)
		endif
		if (oryUIParameters.titleTextColor#[1] > -999999 or oryUIParameters.titleTextColor#[2] > -999999 or oryUIParameters.titleTextColor#[3] > -999999 or oryUIParameters.titleTextColor#[4] > -999999)
			SetTextColor(OryUIPickerCollection[oryUIPickerID].txtTitle, oryUIParameters.titleTextColor#[1], oryUIParameters.titleTextColor#[2], oryUIParameters.titleTextColor#[3], oryUIParameters.titleTextColor#[4])
		endif
		if (oryUIParameters.imageID > -999999)
			SetSpriteImage(OryUIPickerCollection[oryUIPickerID].sprContainer, oryUIParameters.imageID)
		endif
		if (oryUIParameters.supportingTextAlignment > -999999)
			SetTextAlignment(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIParameters.supportingTextAlignment)
		endif
		if (oryUIParameters.supportingTextColor#[1] > -999999 or oryUIParameters.supportingTextColor#[2] > -999999 or oryUIParameters.supportingTextColor#[3] > -999999 or oryUIParameters.supportingTextColor#[4] > -999999)
			SetTextColor(OryUIPickerCollection[oryUIPickerID].txtSupportingText, oryUIParameters.supportingTextColor#[1], oryUIParameters.supportingTextColor#[2], oryUIParameters.supportingTextColor#[3], oryUIParameters.supportingTextColor#[4])
		endif
	endif
endfunction

function OryUIUpdatePickerButton(oryUIPickerID as integer, oryUIButtonID as integer, oryUIComponentParameters$ as string)
	OryUISetParametersType(oryUIComponentParameters$)

	if (GetSpriteExists(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer))
		if (oryUIParameters.color#[1] > -999999 or oryUIParameters.color#[2] > -999999 or oryUIParameters.color#[3] > -999999 or oryUIParameters.color#[4] > -999999)
			SetSpriteColor(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].sprContainer, oryUIParameters.color#[1], oryUIParameters.color#[2], oryUIParameters.color#[3], oryUIParameters.color#[4])
		endif
		if (oryUIParameters.name$ <> "")
			if (lower(oryUIParameters.name$) = "null") then oryUIParameters.name$ = ""
			OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].name$ = oryUIParameters.name$
		endif
		if (oryUIParameters.text$ <> "")
			if (lower(oryUIParameters.text$) = "null") then oryUIParameters.text$ = ""
			SetTextString(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].txtLabel, oryUIParameters.text$)
		endif
		if (oryUIParameters.textBold > -999999)
			SetTextBold(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].txtLabel, oryUIParameters.textBold)
		endif
		if (oryUIParameters.textColor#[1] > -999999 or oryUIParameters.textColor#[2] > -999999 or oryUIParameters.textColor#[3] > -999999 or oryUIParameters.textColor#[4] > -999999)
			SetTextColor(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].txtLabel, oryUIParameters.textColor#[1], oryUIParameters.textColor#[2], oryUIParameters.textColor#[3], oryUIParameters.textColor#[4])
		endif
		if (oryUIParameters.textSize# > -999999)
			SetTextSize(OryUIPickerCollection[oryUIPickerID].buttons[oryUIButtonID - 1].txtLabel, oryUIParameters.textSize#)
		endif
	endif
endfunction

foldend
