local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiMessages")

local g = 103

function handleInput()


--	reaper.Main_OnCommand(41624, 0)
--	reaper.Main_OnCommand(41625, 0)
  local commandId = reaper.NamedCommandLookup("_RSf5a1fbe71eaa92f79bc6a4c8726309dfbc8dc7a1")
--is_new,name,sec,cmd,rel,res,val = reaper.get_action_context()
--print("sec: ".. sec)
--print("cmd: " .. cmd)
  reaper.SetToggleCommandState(0, commandId, 1)

	inputCharacter = gfx.getchar()

--[[
	if inputCharacter ~= 0 then
		print(inputCharacter)
	end

]]--

	if inputCharacter == g then
		setSelectedScaleNote(3)
		previewChord()
	end
end