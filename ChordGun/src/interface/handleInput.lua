-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/inputCharacters")


function handleInput()

	inputCharacter = gfx.getchar()

	if inputCharacter == inputCharacters["0"] then
		stopAllNotesFromPlaying()
	end

	if inputCharacter == inputCharacters["1"] then
		playScaleChordAction(1)
	end

	if inputCharacter == inputCharacters["2"] then
		playScaleChordAction(2)
	end

	if inputCharacter == inputCharacters["3"] then
		playScaleChordAction(3)
	end

	if inputCharacter == inputCharacters["4"] then
		playScaleChordAction(4)
	end

	if inputCharacter == inputCharacters["5"] then
		playScaleChordAction(5)
	end

	if inputCharacter == inputCharacters["6"] then
		playScaleChordAction(6)
	end

	if inputCharacter == inputCharacters["7"] then
		playScaleChordAction(7)
	end

	--

	if inputCharacter == inputCharacters["!"] then
		insertScaleChordAction(1)
	end

	if inputCharacter == inputCharacters["@"] then
		insertScaleChordAction(2)
	end

	if inputCharacter == inputCharacters["#"] then
		insertScaleChordAction(3)
	end

	if inputCharacter == inputCharacters["$"] then
		insertScaleChordAction(4)
	end

	if inputCharacter == inputCharacters["%"] then
		insertScaleChordAction(5)
	end

	if inputCharacter == inputCharacters["^"] then
		insertScaleChordAction(6)
	end

	if inputCharacter == inputCharacters["&"] then
		insertScaleChordAction(7)
	end

	--


	if inputCharacter == inputCharacters["q"] then
		playHigherScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["w"] then
		playHigherScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["e"] then
		playHigherScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["r"] then
		playHigherScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["t"] then
		playHigherScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["y"] then
		playHigherScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["u"] then
		playHigherScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["a"] then
		playScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["s"] then
		playScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["d"] then
		playScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["f"] then
		playScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["g"] then
		playScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["h"] then
		playScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["j"] then
		playScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["z"] then
		playLowerScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["x"] then
		playLowerScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["c"] then
		playLowerScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["v"] then
		playLowerScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["b"] then
		playLowerScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["n"] then
		playLowerScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["m"] then
		playLowerScaleNoteAction(7)
	end

		--


	if inputCharacter == inputCharacters["Q"] then
		insertHigherScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["W"] then
		insertHigherScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["E"] then
		insertHigherScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["R"] then
		insertHigherScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["T"] then
		insertHigherScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["Y"] then
		insertHigherScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["U"] then
		insertHigherScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["A"] then
		insertScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["S"] then
		insertScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["D"] then
		insertScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["F"] then
		insertScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["G"] then
		insertScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["H"] then
		insertScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["J"] then
		insertScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["Z"] then
		insertLowerScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["X"] then
		insertLowerScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["C"] then
		insertLowerScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["V"] then
		insertLowerScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["B"] then
		insertLowerScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["N"] then
		insertLowerScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["M"] then
		insertLowerScaleNoteAction(7)
	end

-----------------

--[[
	local function shiftKeyIsHeldDown()
		return gfx.mouse_cap & 8 == 8
	end
]]--
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

--[[
	local function shiftKeyIsNotHeldDown()
		return gfx.mouse_cap & 8 ~= 8
	end
]]--

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

--[[
	local function shiftModifierIsActive()
		return shiftKeyIsHeldDown() and controlKeyIsNotHeldDown() and optionKeyIsNotHeldDown() and commandKeyIsNotHeldDown()
	end
]]--

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