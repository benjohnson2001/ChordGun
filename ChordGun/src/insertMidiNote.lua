-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")

function insertMidiNote(note, keepNotesSelected, noteEndPosition)

	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()

	local endPosition = nil
	
	if keepNotesSelected then
		endPosition = noteEndPosition
	else
		endPosition = getMidiEndPositionPPQ()
	end

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake(), keepNotesSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end