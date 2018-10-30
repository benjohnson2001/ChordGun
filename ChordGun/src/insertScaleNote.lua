-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")
require(workingDirectory .. "/changeSelectedNotes")


local function insertScaleNoteImplImpl(octaveAdjustment, keepNotesSelected)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  deleteExistingNotesInNextInsertionTimePeriod()
  insertMidiNote(noteValue, keepNotesSelected)
  moveCursor()
end

function insertScaleNoteForSelection(octaveAdjustment)
	insertScaleNoteImplImpl(octaveAdjustment, true)
end

local function insertScaleNoteImpl(octaveAdjustment)

  if activeTake() == nil then
    return
  end

  if thereAreNotesSelected() then 
    changeSelectedNotesToScaleNotes(octaveAdjustment)
  else
    insertScaleNoteImplImpl(octaveAdjustment, false)
  end
end

function insertLowerScaleNote()

	if getOctave() < 0 then
		return
	end

	insertScaleNoteImpl(-1)
end

function insertScaleNote()
  insertScaleNoteImpl(0)
end

function insertHigherScaleNote()

	if getOctave() > 7 then
		return
	end

	insertScaleNoteImpl(1)
end