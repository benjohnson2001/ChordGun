
local function midiEditorIsNotOpen()
	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	return activeMidiEditor == nil
end

local function getNoteVelocity()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	return reaper.MIDIEditor_GetSetting_int(activeMidiEditor, "default_note_vel")
end

function doSomething()

	print(reaper.GetProjectPath(""))

--[[
	if midiEditorIsNotOpen() then
		return
	end

	local noteVelocity = getNoteVelocity()
	print("noteVelocity: " .. noteVelocity)
]]--
end