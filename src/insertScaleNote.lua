local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")


local function insertScaleNoteImpl(octaveAdjustment)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  insertMidiNote(noteValue)
  moveCursor()
end

function insertLowerScaleNote()
	return insertScaleNoteImpl(-1)
end

function insertScaleNote()
  insertScaleNoteImpl(0)
end

function insertHigherScaleNote()
	insertScaleNoteImpl(1)
end