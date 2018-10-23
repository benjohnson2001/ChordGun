local slash = package.config:sub(1,1)
local workingDirectory = reaper.GetResourcePath() .. slash .. "Scripts" .. slash .. "ChordGun"
require(workingDirectory .. slash .. "midiEditor")

function getCursorPositionPPQ()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

	local cursorPosition = reaper.GetCursorPosition()
	local cursorPositionPPQ = reaper.MIDI_GetPPQPosFromProjTime(activeTake, cursorPosition)
	return cursorPositionPPQ
end

local function getCursorPositionQN(activeTake)
	local cursorPosition = reaper.GetCursorPosition()
	local cursorPositionPPQ = reaper.MIDI_GetPPQPosFromProjTime(activeTake, cursorPosition)
	local cursorPositionQN = reaper.MIDI_GetProjQNFromPPQPos(activeTake, cursorPositionPPQ)
	return cursorPositionQN
end

function getNoteLength()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)
	local gridLen, _, noteLen = reaper.MIDI_GetGrid(activeTake)
	
	local noteLength = gridLen

	if noteLen ~= 0 then
		noteLength = noteLen
	end

	return noteLength
end

local function getEndPosition()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

	local noteLength = getNoteLength()
	local startPosition = getCursorPositionQN(activeTake)
	local endPosition = reaper.MIDI_GetPPQPosFromProjQN(activeTake, startPosition + noteLength)

	return endPosition
end

function insertMidiNote(note)

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)
	local noteIsSelected = false
	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getEndPosition()

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake, noteIsSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end