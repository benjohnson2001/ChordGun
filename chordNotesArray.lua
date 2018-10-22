local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/preferences")

function applyInversion(chord)
  
  local chordLength = #chord
  local chordInversionValue = getChordInversion()
  local chord_ = chord
  local oct = 0  
  
  if chordInversionValue < 0 then
    oct = math.floor(chordInversionValue / chordLength)
    chordInversionValue = chordInversionValue + (math.abs(oct) * chordLength)
  end
  
  for i = 1, chordInversionValue do
    local r = table.remove(chord_, 1)
    r = r + 12
    table.insert(chord_, #chord_ + 1, r )
  end
    
  for i = 1, #chord_ do
    chord_[i] = chord_[i] + (oct * 12)
  end

  return chord_
end

function getChordNotesArray(root, chord, octave)

  local chordLength = 0
  local chordNotesArray = {}
  local chordPattern = chord["pattern"]
  for n = 0, #chordPattern-1 do
    if chordPattern:sub(n+1, n+1) == '1' then
      chordLength = chordLength + 1
      
      local noteValue = root + n + ((octave+1) * 12) - 1
      table.insert(chordNotesArray, noteValue)
    end
  end
  
  chordNotesArray = applyInversion(chordNotesArray)
  
  return chordNotesArray
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