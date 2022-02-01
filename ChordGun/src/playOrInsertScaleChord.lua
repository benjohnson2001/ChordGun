-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/playScaleChord")
require(workingDirectory .. "/insertScaleChord")

local function playScaleChord(chordNotesArray)

  stopNotesFromPlaying()
  
  for noteIndex = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[noteIndex])
  end

  setNotesThatArePlaying(chordNotesArray) 
end

function previewScaleChord()

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()

  local chordNotesArray = getChordNotesArray(root, chord, octave)
  playScaleChord(chordNotesArray)
  updateChordText(root, chord, chordNotesArray)
end

function insertScaleChord(chordNotesArray, keepNotesSelected, selectedChord)

  deleteExistingNotesInNextInsertionTimePeriod(keepNotesSelected, selectedChord)

  for noteIndex = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[noteIndex], keepNotesSelected, selectedChord, noteIndex)
  end

  moveCursor(keepNotesSelected, selectedChord)
end

function playOrInsertScaleChord(actionDescription)

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)

  if activeTake() ~= nil and notCurrentlyRecording() then

    startUndoBlock()

      if thereAreNotesSelected() then 
        changeSelectedNotesToScaleChords(chordNotesArray)
      else
        insertScaleChord(chordNotesArray, false)
      end

    endUndoBlock(actionDescription)
  end

  playScaleChord(chordNotesArray)
  updateChordText(root, chord, chordNotesArray)
end