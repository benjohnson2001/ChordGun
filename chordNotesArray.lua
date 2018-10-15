function getChordNotesArray(root, chord, octave)

  local chordLength = 0
  local chordNotesArray = {}
  local chordPattern = chord["pattern"]
  for n = 0, #chordPattern-1 do
    if chordPattern:sub(n+1, n+1) == '1' then
      chordLength = chordLength + 1
      
      local noteValue = root + n + (octave * 12) - 1
      table.insert(chordNotesArray, noteValue)
    end
  end
  
  chordNotesArray = applyInversion(chordNotesArray)
  
  return chordNotesArray
end

local function insertSpacerNotes(chordNotesArray, numberOfColumnsForChord)

  local emptyNoteValue = 121
  if (preferences.insertNoteOffInRemainingNoteColumns.value) then
    emptyNoteValue = 120
  end
  
  -- make it so the trigger note lines up when there are 2, 3 or 4 notes in the chord
  for note = 1, numberOfColumnsForChord-#chordNotesArray do
    table.insert(chordNotesArray, emptyNoteValue)
  end
end

function addTriggerNotesToChordArray(chordNotesArray)

  insertSpacerNotes(chordNotesArray, 5)
  table.insert(chordNotesArray, preferences.triggerNote.value)
end

function addTriggerNotesToChordArrayForTwoNoteChord(chordNotesArray)

  local interval = preferences.twoNoteChordIntervalInSemitones.value
  
  if interval == 2 or interval == 5 then
    insertSpacerNotes(chordNotesArray, 4)
    table.insert(chordNotesArray, chordNotesArray[1]+11)
  elseif interval == 3 or interval == 4 then
    insertSpacerNotes(chordNotesArray, 4)
    table.insert(chordNotesArray, chordNotesArray[1]+1)
  elseif interval == 7 then
    insertSpacerNotes(chordNotesArray, 4)
    table.insert(chordNotesArray, chordNotesArray[1]+10)  
  elseif interval == 11 then
    insertSpacerNotes(chordNotesArray, 4)
    table.insert(chordNotesArray, chordNotesArray[1]+3)
  else
    insertSpacerNotes(chordNotesArray, 5)
  end  
  
  table.insert(chordNotesArray, preferences.triggerNote.value)
end