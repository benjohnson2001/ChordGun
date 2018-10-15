function insertChord(scaleDegree)
  
  preferences.selectedScaleDegree.value = scaleDegree
      
  local chordType = preferences.selectedChordTypes[scaleDegree].value
  local chord = scaleChords[scaleDegree][chordType]
  local root = scaleNotes[scaleDegree]

  local octave = renoise.song().transport.octave
  local chordNotesArray = getChordNotesArray(root, chord, octave)   
  
  local chordNotesArray_ = copy(chordNotesArray)
  
  if preferences.addTriggerNoteCheckbox.value then 
    addTriggerNotesToChordArray(chordNotesArray)
  end
  
  if renoise.song().transport.edit_mode == true then
    insertNotesFromChordArray(chordNotesArray)
  else
    playChordWithOsc(chordNotesArray)
  end

  updateChordText(root, chord, chordNotesArray_)
  
  highlightSelectedChordTypes()
end

function insertNotesFromChordArray(chordNotesArray)

  local noteColumnIndex = renoise.song().selected_note_column_index
  for note = 1, #chordNotesArray do
    insertNote(chordNotesArray[note], noteColumnIndex)
    noteColumnIndex = noteColumnIndex + 1
  end
  
  local visibleNoteColumns = renoise.song().selected_track.visible_note_columns
      
  if visibleNoteColumns >= noteColumnIndex then
    for i = noteColumnIndex, visibleNoteColumns do
      local noteColumn = renoise.song().selected_line:note_column(i)
      
      if preferences.insertNoteOffInRemainingNoteColumns.value then
        noteColumn.note_value = 120
      else
        noteColumn.note_value = 121
      end
  
      noteColumn.instrument_value = 255
    end
  end
end

