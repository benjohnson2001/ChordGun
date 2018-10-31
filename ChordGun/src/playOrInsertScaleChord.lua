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

  deleteExistingNotesInNextInsertionTimePeriod()

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end

  moveCursor()
end

function previewChord()

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)
  playScaleChord(chordNotesArray)
end

function playOrInsertScaleChord()

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)

  if activeTake() ~= nil and notCurrentlyRecording() then

    if thereAreNotesSelected() then 
      changeSelectedNotesToScaleChords(chordNotesArray)
    else
      insertScaleChord(chordNotesArray, false)
    end
  end

  playScaleChord(chordNotesArray)
  updateChordText(root, chord, chordNotesArray)
end