-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/playScaleChord")
require(workingDirectory .. "/insertScaleChord")

local function playScaleChord(chordNotesArray)

  stopNotesFromPlaying()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

  setNotesThatArePlaying(chordNotesArray) 
end

function insertScaleChord(chordNotesArray, keepNotesSelected)

  if keepNotesSelected then
    deleteSelectedNotes()
  else
    deleteExistingNotesInNextInsertionTimePeriod()
  end

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end

  reaper.MIDI_Sort(activeTake())

  if not keepNotesSelected then
    moveCursor()
  end
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