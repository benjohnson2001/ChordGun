-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")
require(workingDirectory .. "/changeSelectedNotes")

local function insertChordImpl(keepNotesSelected)

  startUndoBlock()

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)
  
  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)

  deleteExistingNotesInNextInsertionTimePeriod()

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end

  updateChordText(root, chord, chordNotesArray)
  moveCursor()

  endUndoBlock("inserted scale chord " .. scaleNoteIndex)
end

function insertChordForSelection()
  insertChordImpl(true)
end

function insertChord()

  if activeTake() == nil then
    return
  end

  if thereAreNotesSelected() then 
    changeSelectedNotesToScaleChords()
  else
    insertChordImpl(false)
  end
end

