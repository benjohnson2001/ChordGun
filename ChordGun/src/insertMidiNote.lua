-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")

function insertMidiNote(note, keepNotesSelected, channelArg)

	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getMidiEndPositionPPQ()

	local channel = getCurrentNoteChannel(channelArg)
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake(), keepNotesSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end