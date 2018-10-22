local function getCursorPositionPPQ(activeTake)
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

local function getEndPosition(activeTake)

	local gridLen, _, noteLen = reaper.MIDI_GetGrid(activeTake)

	local noteLength = gridLen

	if noteLen ~= 0 then
		noteLength = noteLen
	end

	local startPosition = getCursorPositionQN(activeTake)
	local endPosition = reaper.MIDI_GetPPQPosFromProjQN(activeTake, startPosition + noteLength)

	return endPosition
end

function insertMidiNote(note)

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)
	local noteIsSelected = false
	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ(activeTake)
	local endPosition = getEndPosition(activeTake)

	local channel = 0
	local velocity = 127
	local noSort = false

	reaper.MIDI_InsertNote(activeTake, noteIsSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end