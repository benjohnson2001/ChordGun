local slash = package.config:sub(1,1)
local workingDirectory = reaper.GetResourcePath() .. slash .. "Scripts" .. slash .. "ChordGun"
require(workingDirectory .. slash .. "chordNotesArray")
require(workingDirectory .. slash .. "midiMessages")
require(workingDirectory .. slash .. "preferences")
require(workingDirectory .. slash .. "timer")


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