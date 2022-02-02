-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/inputCharacters")


local function moveEditCursorLeftByGrid()
	local commandId = 40047
	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

local function moveEditCursorRightByGrid()
	local commandId = 40048
	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

function handleInput()

	local operatingSystem = string.lower(reaper.GetOS())

	inputCharacter = gfx.getchar()
	
	if inputCharacter == inputCharacters["ESC"] then
		gfx.quit()
	end

	if inputCharacter == inputCharacters["LEFTARROW"] then
		moveEditCursorLeftByGrid()
	end

	if inputCharacter == inputCharacters["RIGHTARROW"] then
		moveEditCursorRightByGrid()
	end


	local function middleMouseButtonIsHeldDown()
		return gfx.mouse_cap & 64 == 64
	end

	if inputCharacter == inputCharacters["0"] or middleMouseButtonIsHeldDown() then
		stopAllNotesFromPlaying()
	end

	--

	if inputCharacter == inputCharacters["1"] then
		previewScaleChordAction(1)
	end

	if inputCharacter == inputCharacters["2"] then
		previewScaleChordAction(2)
	end

	if inputCharacter == inputCharacters["3"] then
		previewScaleChordAction(3)
	end

	if inputCharacter == inputCharacters["4"] then
		previewScaleChordAction(4)
	end

	if inputCharacter == inputCharacters["5"] then
		previewScaleChordAction(5)
	end

	if inputCharacter == inputCharacters["6"] then
		previewScaleChordAction(6)
	end

	if inputCharacter == inputCharacters["7"] then
		previewScaleChordAction(7)
	end

	--


	if inputCharacter == inputCharacters["!"] then
		scaleChordAction(1)
	end

	if inputCharacter == inputCharacters["@"] then
		scaleChordAction(2)
	end

	if inputCharacter == inputCharacters["#"] then
		scaleChordAction(3)
	end

	if inputCharacter == inputCharacters["$"] then
		scaleChordAction(4)
	end

	if inputCharacter == inputCharacters["%"] then
		scaleChordAction(5)
	end

	if inputCharacter == inputCharacters["^"] then
		scaleChordAction(6)
	end

	if inputCharacter == inputCharacters["&"] then
		scaleChordAction(7)
	end

	--


	if inputCharacter == inputCharacters["q"] then
		previewHigherScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["w"] then
		previewHigherScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["e"] then
		previewHigherScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["r"] then
		previewHigherScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["t"] then
		previewHigherScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["y"] then
		previewHigherScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["u"] then
		previewHigherScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["a"] then
		previewScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["s"] then
		previewScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["d"] then
		previewScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["f"] then
		previewScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["g"] then
		previewScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["h"] then
		previewScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["j"] then
		previewScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["z"] then
		previewLowerScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["x"] then
		previewLowerScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["c"] then
		previewLowerScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["v"] then
		previewLowerScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["b"] then
		previewLowerScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["n"] then
		previewLowerScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["m"] then
		previewLowerScaleNoteAction(7)
	end



	--


	if inputCharacter == inputCharacters["Q"] then
		higherScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["W"] then
		higherScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["E"] then
		higherScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["R"] then
		higherScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["T"] then
		higherScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["Y"] then
		higherScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["U"] then
		higherScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["A"] then
		scaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["S"] then
		scaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["D"] then
		scaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["F"] then
		scaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["G"] then
		scaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["H"] then
		scaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["J"] then
		scaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["Z"] then
		lowerScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["X"] then
		lowerScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["C"] then
		lowerScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["V"] then
		lowerScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["B"] then
		lowerScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["N"] then
		lowerScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["M"] then
		lowerScaleNoteAction(7)
	end

-----------------


	local function shiftKeyIsHeldDown()
		return gfx.mouse_cap & 8 == 8
	end

	local function controlKeyIsHeldDown()
		return gfx.mouse_cap & 32 == 32 
	end

	local function optionKeyIsHeldDown()
		return gfx.mouse_cap & 16 == 16
	end

	local function commandKeyIsHeldDown()
		return gfx.mouse_cap & 4 == 4
	end

	--

	local function shiftKeyIsNotHeldDown()
		return gfx.mouse_cap & 8 ~= 8
	end

	local function controlKeyIsNotHeldDown()
		return gfx.mouse_cap & 32 ~= 32
	end

	local function optionKeyIsNotHeldDown()
		return gfx.mouse_cap & 16 ~= 16
	end

	local function commandKeyIsNotHeldDown()
		return gfx.mouse_cap & 4 ~= 4
	end

	--

	local function controlModifierIsActive()
		return controlKeyIsHeldDown() and optionKeyIsNotHeldDown() and commandKeyIsNotHeldDown()
	end

	local function optionModifierIsActive()
		return optionKeyIsHeldDown() and controlKeyIsNotHeldDown() and commandKeyIsNotHeldDown()
	end

	local function commandModifierIsActive()
		return commandKeyIsHeldDown() and optionKeyIsNotHeldDown() and controlKeyIsNotHeldDown()
	end

---

	if inputCharacter == inputCharacters[","] and controlModifierIsActive() then
		decrementScaleTonicNoteAction()
	end

	if inputCharacter == inputCharacters["."] and controlModifierIsActive() then
		incrementScaleTonicNoteAction()
	end

	if inputCharacter == inputCharacters["<"] and controlModifierIsActive() then
		decrementScaleTypeAction()
	end

	if inputCharacter == inputCharacters[">"] and controlModifierIsActive() then
		incrementScaleTypeAction()
	end


	if operatingSystem == "win64" or operatingSystem == "win32" then

		if inputCharacter == inputCharacters[","] and shiftKeyIsNotHeldDown() and optionModifierIsActive() then
			halveGridSize()
		end

		if inputCharacter == inputCharacters["."] and shiftKeyIsNotHeldDown() and optionModifierIsActive() then
			doubleGridSize()
		end

		if inputCharacter == inputCharacters[","] and shiftKeyIsHeldDown() and optionModifierIsActive() then
			decrementOctaveAction()
		end

		if inputCharacter == inputCharacters["."] and shiftKeyIsHeldDown() and optionModifierIsActive() then
			incrementOctaveAction()
		end

		--

		if inputCharacter == inputCharacters[","] and shiftKeyIsNotHeldDown() and commandModifierIsActive() then
			decrementChordTypeAction()
		end

		if inputCharacter == inputCharacters["."] and shiftKeyIsNotHeldDown() and commandModifierIsActive() then
			incrementChordTypeAction()
		end

		if inputCharacter == inputCharacters[","] and shiftKeyIsHeldDown() and commandModifierIsActive() then
			decrementChordInversionAction()
		end

		if inputCharacter == inputCharacters["."] and shiftKeyIsHeldDown() and commandModifierIsActive() then
			incrementChordInversionAction()
		end

	else

		if inputCharacter == inputCharacters[","] and optionModifierIsActive() then
			halveGridSize()
		end

		if inputCharacter == inputCharacters["."] and optionModifierIsActive() then
			doubleGridSize()
		end

		if inputCharacter == inputCharacters["<"] and optionModifierIsActive() then
			decrementOctaveAction()
		end

		if inputCharacter == inputCharacters[">"] and optionModifierIsActive() then
			incrementOctaveAction()
		end

		--

		if inputCharacter == inputCharacters[","] and commandModifierIsActive() then
			decrementChordTypeAction()
		end

		if inputCharacter == inputCharacters["."] and commandModifierIsActive() then
			incrementChordTypeAction()
		end

		if inputCharacter == inputCharacters["<"] and commandModifierIsActive() then
			decrementChordInversionAction()
		end

		if inputCharacter == inputCharacters[">"] and commandModifierIsActive() then
			incrementChordInversionAction()
		end
	end
end
