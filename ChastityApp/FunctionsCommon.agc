
function AddLeadingZeros(string$ as string, noOfZeros as integer)
	local i as integer
	
	for i = 1 to noOfZeros
		if (len(string$) < noOfZeros)
			string$ = "0" + string$
		endif
	next
endfunction string$

function AddOrdinalSuffix(i)
	local j as integer
	local k as integer
	local l$ as string
	
	j = mod(i, 10)
	k = mod(i, 100)
	if (j = 1 and k <> 11)
		l$ = str(i) + "st"
	elseif (j = 2 and k <> 12)
		l$ = str(i) + "nd"
	elseif (j = 3 and k <> 13)
		l$ = str(i) + "rd"
	else
		l$ = str(i) + "th"
	endif
endfunction l$

function AddThousandsSeperator(number as integer, seperator$ as string)
	local counter as integer
	local formattedNumber$ as string
	local i as integer
	local numberLength as integer
	
	numberLength = len(str(number))
	
	if (numberLength < 4)
		formattedNumber$ = str(number)
	else
		counter = 0
		for i = numberLength to 1 step -1
			inc counter
			formattedNumber$ = Mid(str(number), i, 1) + formattedNumber$
			if (mod(counter, 3) = 0 and i <> 1) then formattedNumber$ = seperator$ + formattedNumber$
		next
	endif
endfunction formattedNumber$

function ApproximateNumber(number as integer)
	local approximate as integer
	approximate = number
	if (len(str(number)) = 1) then approximate = number
	if (len(str(number)) = 2) then approximate = val(Mid(str(number), 1, 1)) * 10
	if (len(str(number)) = 3) then approximate = val(Mid(str(number), 1, 2)) * 10
	if (len(str(number)) = 4) then approximate = val(Mid(str(number), 1, 1)) * 1000
	if (len(str(number)) = 5) then approximate = val(Mid(str(number), 1, 2)) * 1000
	if (len(str(number)) = 6) then approximate = val(Mid(str(number), 1, 3)) * 1000
	if (len(str(number)) = 7) then approximate = val(Mid(str(number), 1, 4)) * 1000
	if (len(str(number)) = 8) then approximate = val(Mid(str(number), 1, 5)) * 1000
	if (len(str(number)) = 9) then approximate = val(Mid(str(number), 1, 6)) * 1000
	if (len(str(number)) = 10) then approximate = val(Mid(str(number), 1, 7)) * 1000
endfunction approximate

function Base64DecodeChar(c as integer)
	local v as integer
	
    if (c >= 65 and c <= 90)
        v = c - 65
        exitfunction v
    endif
    if (c >= 97 and c <= 122)
        v = c - 97 + 26
        exitfunction v
    endif
    if (c >= 48 and c <= 57)
        v = c - 48 + 52
        exitfunction v
    endif
    if (c = 43) then exitfunction 62
endfunction 63

function Base64ToMemblock(text$ as string)
	local b as integer
	local b1 as integer
	local b2 as integer
	local b3 as integer
	local b4 as integer
	local b64 as integer
	local c1 as integer
	local c2 as integer
	local c3 as integer
	local c4 as integer
	local e as integer
	local i as integer
	local index as integer
	local memblock as integer
	local size as integer
	local textLength as integer
	
    textLength = len(text$)
    memblock = CreateMemblock(textLength + 1)
    SetMemblockString(memblock, 0, text$)
    e = 0
    for i = textLength to textLength - 3 step - 1
        if (GetMemblockByte(memblock, i) = 65)
			inc e
		else
			exit
		endif
    next i
    size = (textLength / 4) * 3 - e
    b64 = CreateMemblock(size)
    index = 0
    for i = 0 to textLength - 1 step 4
        c1 = GetMemblockByte(memblock, i)
        c2 = 65
        c3 = 65
        c4 = 65
        if (i + 1 <= textLength) then c2 = GetMemblockByte(memblock, i + 1)
        if (i + 2 <= textLength) then c3 = GetMemblockByte(memblock, i + 2)
        if (i + 3 <= textLength) then c4 = GetMemblockByte(memblock, i + 3)
        b1 = Base64DecodeChar(c1)
        b2 = Base64DecodeChar(c2)
        b3 = Base64DecodeChar(c3)
        b4 = Base64DecodeChar(c4)
        b = b1 << 2 || b2 >> 4
        SetMemblockByte(b64, index, b)
        if (c3 <> 61)
            inc index
            b = ((b2&&0xf) << 4) || (b3 >> 2)
            SetMemblockByte(b64, index, b)
        endif
        if (c4 <> 61)
            inc index
            b = ((b3&&0x3) << 6) || b4
            SetMemblockByte(b64, index, b)
        endif
        inc index
    next i
    DeleteMemblock(memblock)
endfunction b64

function Base64ToString(text$ as string)
	local memblock as integer
	
	memblock = Base64ToMemblock(text$)
	text$ = GetMemblockString(memblock, 0, GetMemblockSize(memblock))
	DeleteMemblock(memblock)
endfunction text$

function GetJSONDataVariableValue(variable$ as string)
	local i as integer
	local value$ as string
	
	for i = 0 to jsonData.length
		if (jsonData[i].variable = variable$)
			value$ = jsonData[i].value
		endif
	next
endfunction value$

function GetLocalVariableValue(variable$ as string)
	local i as integer
	local variableValue$ as string
	
	for i = 0 to localVariables.length
		if (localVariables[i].variable = "") then localVariables.remove(i)
		if (lower(localVariables[i].variable) = lower(variable$))
			variableValue$ = localVariables[i].value
		endif
	next
endfunction variableValue$

function MaxFloat(a# as float, b# as float)
	local maxValue# as integer
	if (a# > b#)
		maxValue# = a#
	else
		maxValue# = b#
	endif
endfunction maxValue#

function MaxInt(a, b)
	local maxValue as integer
	if (a > b)
		maxValue = a
	else
		maxValue = b
	endif
endfunction maxValue

function MinFloat(a# as float, b# as float)
	local minValue# as integer
	if (a# < b#)
		minValue# = a#
	else
		minValue# = b#
	endif
endfunction minValue#

function MinInt(a, b)
	local minValue as integer
	if (a < b)
		minValue = a
	else
		minValue = b
	endif
endfunction minValue

function PurchaseInApp(id as integer)
	local purchased as integer
	
	purchased = 0
	InAppPurchaseActivate(id)
	// WAIT FOR USER TO PURCHASE OR CANCEL PROMPT
	while (GetInAppPurchaseState() = 0)
		Sync()
	endwhile
	// USER HAS CANCELLED OR HAS ALREADY PURCHASED
	if (GetInAppPurchaseAvailable(id) < 1)

	endif
	// USER HAS PURCHASED
	if (GetInAppPurchaseAvailable(id) = 1)
		purchased = 1
	endif
endfunction purchased

function ReverseString(text$ as string)
	local i as integer
	local reversed$ as string
	
	for i = len(text$) to 1 step -1
		reversed$ = reversed$ + mid(text$, i, 1)
	next
endfunction reversed$

function RoundDownWithReducedPrecision(number)
	local digits as integer
	local numberToRemove as integer
	
	digits = len(str(number))
	if (digits = 1) then numberToRemove = number
	if (digits >= 2)
		numberToRemove = val(mid(str(number), 2, digits - 1))
	endif
	number = number - numberToRemove
endfunction number

function RoundUpWithReducedPrecision(number)
	local digits as integer
	local numberToAdd as integer
	
	digits = len(str(number))
	if (digits = 1) then numberToAdd = 10 - number
	if (digits >= 2)
		numberToAdd = val("1" + mid("00000000000000000000", 1, digits - 1)) - val(mid(str(number), 2, digits - 1))
	endif
	number = number + numberToAdd
endfunction number

function SaveLocalVariable(variable$ as string, value$ as string)
	local i as integer
	local indexFound as integer
	
	if ((FindString(constVersionNumber$, "alpha", 1, 1) >= 1 or FindString(constVersionNumber$, "beta", 1, 1) >= 1) and variable$ = "adsRemoved") then exitfunction
	if ((FindString(constVersionNumber$, "alpha", 1, 1) >= 1 or FindString(constVersionNumber$, "beta", 1, 1) >= 1) and variable$ = "noOfKeys") then exitfunction
	if ((FindString(constVersionNumber$, "alpha", 1, 1) >= 1 or FindString(constVersionNumber$, "beta", 1, 1) >= 1) and variable$ = "noOfKeysPurchased") then exitfunction
	indexFound = -1
	for i = 0 to localVariables.length
		if (lower(localVariables[i].variable) = lower(variable$))
			indexFound = i
			localVariables[i].value = value$
		endif
	next
	if (indexFound = -1)
		localVariables.insert(blankVariable)
		localVariables[localVariables.length].variable = variable$
		localVariables[localVariables.length].value = value$
	endif
	localVariables.sort()
	localVariables.save("localVariables.json")
endfunction

function SetLastScreenViewed(screenNumber as integer)
	lastScreenViewed = screenNumber
endfunction

function SetScreenToView(screenNumber as integer)
	if (screenNumber = constMyLocksScreen or screenNumber = constSharedLocksScreen) then ClearBreadcrumbs()
	screenToView = screenNumber
	changingScreen = 1
	if (adsRemoved = 0) then RequestAdvertRefresh()
	SetViewZoom(1)
	OryUISetScreenZoomLimits(1, 1)
	OryUISetScreenScrollLimits(0, 0, 0, 0)
	OryUIEnableScreenScrolling()
	AddBreadcrumb(screenNumber)
	gosub syncScreen
endfunction
