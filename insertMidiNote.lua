-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/midiEditor")

function insertMidiNote(note, keepNotesSelected, channelArg, offset)

	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()

	if offset ~= nil then
		startPosition = startPosition + offset
	end

	local endPosition = getMidiEndPositionPPQ()

	local channel = getCurrentNoteChannel(channelArg)
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake(), keepNotesSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end