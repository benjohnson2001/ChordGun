local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")

function previewChord(scaleNoteIndex, chordTypeIndex)
  
  stopAllNotesFromPlaying()
  
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local root = scaleNotes[scaleNoteIndex]

  -- TODO, need an octave selector
  local octave = 3
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end
end