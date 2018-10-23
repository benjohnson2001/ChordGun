local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/timer")


function previewChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  stopAllNotesFromPlaying()
  
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local root = scaleNotes[scaleNoteIndex]

  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   

  resetTimer()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

  updateChordText(root, chord, chordNotesArray)
end