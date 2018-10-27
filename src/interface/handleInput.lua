local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/inputCharacters")

local numberOfZeros = 0
local maximumNumberOfZeros = 16 -- this number probably system dependent
local lastRecognizedCharacter = -1
local lastMidiNote = -1


function handleInput()




	inputCharacter = gfx.getchar()

	--print('inputCharacter: ' .. inputCharacter)
	--print('lastRecognizedCharacter: ' .. lastRecognizedCharacter)
	--print('numberOfZeros: ' .. numberOfZeros)


if numberOfZeros > maximumNumberOfZeros and lastMidiNote ~= -1 then

	stopNoteFromPlaying(lastMidiNote)
	lastMidiNote = -1
end

if inputCharacter == 0 then
	numberOfZeros = numberOfZeros + 1
	return
end

if inputCharacter == inputCharacters["q"] then

	if lastRecognizedCharacter == inputCharacters["q"] then

		if numberOfZeros > maximumNumberOfZeros then
			lastMidiNote = playScaleNote1Action()
		end
	else
			lastMidiNote = playScaleNote1Action()
	end

	numberOfZeros = 0
	lastRecognizedCharacter = inputCharacters["q"]
end



--


	--print(inputCharacter)

--	if inputCharacter == 0 then
--		print(inputCharacter)
--	end

--[[
	if inputCharacter ~= -1 then
		print(inputCharacter)
	end
]]--


	-- if inputCharacter == g then
	-- 	setSelectedScaleNote(3)
	-- 	playChord()
	-- end
end