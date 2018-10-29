-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/inputCharacters")


function handleInput()

	inputCharacter = gfx.getchar()

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
		playHigherScaleNote1Action()
	end

	if inputCharacter == inputCharacters["W"] then
		playHigherScaleNote2Action()
	end

	if inputCharacter == inputCharacters["E"] then
		playHigherScaleNote3Action()
	end

	if inputCharacter == inputCharacters["R"] then
		playHigherScaleNote4Action()
	end

	if inputCharacter == inputCharacters["T"] then
		playHigherScaleNote5Action()
	end

	if inputCharacter == inputCharacters["Y"] then
		playHigherScaleNote6Action()
	end

	if inputCharacter == inputCharacters["U"] then
		playHigherScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["A"] then
		playScaleNote1Action()
	end

	if inputCharacter == inputCharacters["S"] then
		playScaleNote2Action()
	end

	if inputCharacter == inputCharacters["D"] then
		playScaleNote3Action()
	end

	if inputCharacter == inputCharacters["F"] then
		playScaleNote4Action()
	end

	if inputCharacter == inputCharacters["G"] then
		playScaleNote5Action()
	end

	if inputCharacter == inputCharacters["H"] then
		playScaleNote6Action()
	end

	if inputCharacter == inputCharacters["J"] then
		playScaleNote7Action()
	end

	--

	if inputCharacter == inputCharacters["Z"] then
		playLowerScaleNote1Action()
	end

	if inputCharacter == inputCharacters["X"] then
		playLowerScaleNote2Action()
	end

	if inputCharacter == inputCharacters["C"] then
		playLowerScaleNote3Action()
	end

	if inputCharacter == inputCharacters["V"] then
		playLowerScaleNote4Action()
	end

	if inputCharacter == inputCharacters["B"] then
		playLowerScaleNote5Action()
	end

	if inputCharacter == inputCharacters["N"] then
		playLowerScaleNote6Action()
	end

	if inputCharacter == inputCharacters["M"] then
		playLowerScaleNote7Action()
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