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
		playScaleChord1Action()
	end

	if inputCharacter == inputCharacters["2"] then
		playScaleChord2Action()
	end

	if inputCharacter == inputCharacters["3"] then
		playScaleChord3Action()
	end

	if inputCharacter == inputCharacters["4"] then
		playScaleChord4Action()
	end

	if inputCharacter == inputCharacters["5"] then
		playScaleChord5Action()
	end

	if inputCharacter == inputCharacters["6"] then
		playScaleChord6Action()
	end

	if inputCharacter == inputCharacters["7"] then
		playScaleChord7Action()
	end

	--

	if inputCharacter == inputCharacters["!"] then
		insertScaleChord1Action()
	end

	if inputCharacter == inputCharacters["@"] then
		insertScaleChord2Action()
	end

	if inputCharacter == inputCharacters["#"] then
		insertScaleChord3Action()
	end

	if inputCharacter == inputCharacters["$"] then
		insertScaleChord4Action()
	end

	if inputCharacter == inputCharacters["%"] then
		insertScaleChord5Action()
	end

	if inputCharacter == inputCharacters["^"] then
		insertScaleChord6Action()
	end

	if inputCharacter == inputCharacters["&"] then
		insertScaleChord7Action()
	end

	--


	if inputCharacter == inputCharacters["q"] then
		playHigherScaleNote1Action()
	end

	if inputCharacter == inputCharacters["w"] then
		playHigherScaleNote2Action()
	end

	if inputCharacter == inputCharacters["e"] then
		playHigherScaleNote3Action()
	end

	if inputCharacter == inputCharacters["r"] then
		playHigherScaleNote4Action()
	end

	if inputCharacter == inputCharacters["t"] then
		playHigherScaleNote5Action()
	end

	if inputCharacter == inputCharacters["y"] then
		playHigherScaleNote6Action()
	end

	if inputCharacter == inputCharacters["u"] then
		playHigherScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["a"] then
		playScaleNote1Action()
	end

	if inputCharacter == inputCharacters["s"] then
		playScaleNote2Action()
	end

	if inputCharacter == inputCharacters["d"] then
		playScaleNote3Action()
	end

	if inputCharacter == inputCharacters["f"] then
		playScaleNote4Action()
	end

	if inputCharacter == inputCharacters["g"] then
		playScaleNote5Action()
	end

	if inputCharacter == inputCharacters["h"] then
		playScaleNote6Action()
	end

	if inputCharacter == inputCharacters["j"] then
		playScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["z"] then
		playLowerScaleNote1Action()
	end

	if inputCharacter == inputCharacters["x"] then
		playLowerScaleNote2Action()
	end

	if inputCharacter == inputCharacters["c"] then
		playLowerScaleNote3Action()
	end

	if inputCharacter == inputCharacters["v"] then
		playLowerScaleNote4Action()
	end

	if inputCharacter == inputCharacters["b"] then
		playLowerScaleNote5Action()
	end

	if inputCharacter == inputCharacters["n"] then
		playLowerScaleNote6Action()
	end

	if inputCharacter == inputCharacters["m"] then
		playLowerScaleNote7Action()
	end

		--


	if inputCharacter == inputCharacters["Q"] then
		insertHigherScaleNote1Action()
	end

	if inputCharacter == inputCharacters["W"] then
		insertHigherScaleNote2Action()
	end

	if inputCharacter == inputCharacters["E"] then
		insertHigherScaleNote3Action()
	end

	if inputCharacter == inputCharacters["R"] then
		insertHigherScaleNote4Action()
	end

	if inputCharacter == inputCharacters["T"] then
		insertHigherScaleNote5Action()
	end

	if inputCharacter == inputCharacters["Y"] then
		insertHigherScaleNote6Action()
	end

	if inputCharacter == inputCharacters["U"] then
		insertHigherScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["A"] then
		insertScaleNote1Action()
	end

	if inputCharacter == inputCharacters["S"] then
		insertScaleNote2Action()
	end

	if inputCharacter == inputCharacters["D"] then
		insertScaleNote3Action()
	end

	if inputCharacter == inputCharacters["F"] then
		insertScaleNote4Action()
	end

	if inputCharacter == inputCharacters["G"] then
		insertScaleNote5Action()
	end

	if inputCharacter == inputCharacters["H"] then
		insertScaleNote6Action()
	end

	if inputCharacter == inputCharacters["J"] then
		insertScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["Z"] then
		insertLowerScaleNote1Action()
	end

	if inputCharacter == inputCharacters["X"] then
		insertLowerScaleNote2Action()
	end

	if inputCharacter == inputCharacters["C"] then
		insertLowerScaleNote3Action()
	end

	if inputCharacter == inputCharacters["V"] then
		insertLowerScaleNote4Action()
	end

	if inputCharacter == inputCharacters["B"] then
		insertLowerScaleNote5Action()
	end

	if inputCharacter == inputCharacters["N"] then
		insertLowerScaleNote6Action()
	end

	if inputCharacter == inputCharacters["M"] then
		insertLowerScaleNote7Action()
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