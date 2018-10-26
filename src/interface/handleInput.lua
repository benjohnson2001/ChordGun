local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/inputCharacters")

local numberOfZeros = 0
local maximumNumberOfZeros = 16
local lastRecognizedCharacter = -1
local lastMidiNote = -1

-- 113 ("q")
-- 0
-- 0
-- 113 ("q")


function handleInput()


--	reaper.Main_OnCommand(41624, 0)
--	reaper.Main_OnCommand(41625, 0)
--  local commandId = reaper.NamedCommandLookup("_RSf5a1fbe71eaa92f79bc6a4c8726309dfbc8dc7a1")
--is_new,name,sec,cmd,rel,res,val = reaper.get_action_context()
--print("sec: ".. sec)
--print("cmd: " .. cmd)
  --reaper.SetToggleCommandState(0, commandId, 1)

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