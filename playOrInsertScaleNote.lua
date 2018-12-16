-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")
require(workingDirectory .. "/changeSelectedNotes")


local function playScaleNote(noteValue)

  stopNotesThatArePlayingOnChannelOne()
  playMidiNote(noteValue)
  setNotesThatArePlayingOnChannelOne({noteValue})
  setChordText("")
end


function insertScaleNote(noteValue, keepNotesSelected)

	deleteExistingNotesInNextInsertionTimePeriod()
	insertMidiNote(noteValue, keepNotesSelected)
	moveCursor()
end

function previewScaleNote(octaveAdjustment)

	local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

	playScaleNote(noteValue)
end

function playOrInsertScaleNote(octaveAdjustment, actionDescription)

	local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  if activeTake() ~= nil and notCurrentlyRecording() then

  	startUndoBlock()

		  if thereAreNotesSelected() then 
		    changeSelectedNotesToScaleNotes(noteValue)
		  else
		    insertScaleNote(noteValue, false)
		  end

		endUndoBlock(actionDescription)
  end

	playScaleNote(noteValue)
end