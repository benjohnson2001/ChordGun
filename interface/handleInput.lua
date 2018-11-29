-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/actions/actionFunctions")
require(workingDirectory .. "/interface/inputCharacters")
require(reaper.GetResourcePath() .. "/Scripts/DrumsGun/actions/actionFunctions")

function handleInput()

	inputCharacter = gfx.getchar()

	if inputCharacter == inputCharacters["1"] then
		scaleChordAction(1)
	end

	if inputCharacter == inputCharacters["2"] then
		scaleChordAction(2)
	end

	if inputCharacter == inputCharacters["3"] then
		scaleChordAction(3)
	end

	if inputCharacter == inputCharacters["4"] then
		scaleChordAction(4)
	end

	if inputCharacter == inputCharacters["5"] then
		scaleChordAction(5)
	end

	if inputCharacter == inputCharacters["6"] then
		scaleChordAction(6)
	end

	if inputCharacter == inputCharacters["7"] then
		scaleChordAction(7)
	end

	if inputCharacter == inputCharacters["8"] then
		stopAllNotesFromPlaying()
	end

	--


	if inputCharacter == inputCharacters["q"] then
		higherScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["w"] then
		higherScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["e"] then
		higherScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["r"] then
		higherScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["t"] then
		higherScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["y"] then
		higherScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["u"] then
		higherScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["a"] then
		scaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["s"] then
		scaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["d"] then
		scaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["f"] then
		scaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["g"] then
		scaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["h"] then
		scaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["j"] then
		scaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["z"] then
		lowerScaleNoteAction(1)
	end

	if inputCharacter == inputCharacters["x"] then
		lowerScaleNoteAction(2)
	end

	if inputCharacter == inputCharacters["c"] then
		lowerScaleNoteAction(3)
	end

	if inputCharacter == inputCharacters["v"] then
		lowerScaleNoteAction(4)
	end

	if inputCharacter == inputCharacters["b"] then
		lowerScaleNoteAction(5)
	end

	if inputCharacter == inputCharacters["n"] then
		lowerScaleNoteAction(6)
	end

	if inputCharacter == inputCharacters["m"] then
		lowerScaleNoteAction(7)
	end

	--

	if inputCharacter == inputCharacters["i"] then
		playOrInsertKickNote()
	end

	if inputCharacter == inputCharacters["o"] then
		playOrInsertSnareNote()
	end

	if inputCharacter == inputCharacters["p"] then
		playOrInsertHihatNote()
	end

	if inputCharacter == inputCharacters["["] then
		playOrInsertRideNote()
	end

	if inputCharacter == inputCharacters["k"] then
		cycleKick()
	end

	if inputCharacter == inputCharacters["l"] then
		cycleSnare()
	end

	if inputCharacter == inputCharacters[";"] then
		cycleHihat()
	end

	if inputCharacter == inputCharacters["'"] then
		cycleRide()
	end

	if inputCharacter == inputCharacters["]"] then
		playOrInsertCrashNote()
	end

	if inputCharacter == inputCharacters["\\"] then
		playOrInsertChinaNote()
	end

	if inputCharacter == inputCharacters["9"] then
		playOrInsertTom4Note()
	end

	if inputCharacter == inputCharacters["0"] then
		playOrInsertTom3Note()
	end

	if inputCharacter == inputCharacters["-"] then
		playOrInsertTom2Note()
	end

	if inputCharacter == inputCharacters["="] then
		playOrInsertTom1Note()
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