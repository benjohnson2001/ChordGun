local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chordNotesArray")

function insertChord(scaleDegree, chordType)
  
  local chord = scaleChords[scaleDegree][chordType]
  local root = scaleNotes[scaleDegree]

  -- TODO, need an octave selector
  local octave = 3

  local chordNotesArray = getChordNotesArray(root, chord, octave)   
  
  if preferences.addTriggerNoteCheckbox.value then 
    addTriggerNotesToChordArray(chordNotesArray)
  end
  
  playChordWithOsc(chordNotesArray)

  if renoise.song().transport.edit_mode == true then
    insertNotesFromChordArray(chordNotesArray)
  end

  updateChordText(root, chord, chordNotesArray)
end



