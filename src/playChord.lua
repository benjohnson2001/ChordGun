@noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")


function playChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   

  stopNotesFromPlaying()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

  setNotesThatArePlaying(chordNotesArray)

  updateChordText(root, chord, chordNotesArray)
end