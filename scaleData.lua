local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/inversionStates")
require(workingDirectory .. "/scaleFunctions")
require(workingDirectory .. "/scales")
require(workingDirectory .. "/scaleDegreeHeaders")
require(workingDirectory .. "/insertChord")
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/util")

scaleNotes = {}
scaleChords = {}

scalePattern = nil

chordButtons = {}

function getNotesString(chordNotesArray)

  local notesString = '                '
  for i, note in ipairs(chordNotesArray) do
        
    local noteName = getNoteName(note+1)
    
    if i ~= #chordNotesArray then
      notesString = notesString .. noteName .. ', '
    else
      notesString = notesString .. noteName .. ''
    end
  end
  
  return notesString
end

function applyInversion(chord)
  
  local chordLength = #chord
  local chordInversionValue = getCurrentInversionValue()
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

function insertNote(note, noteColumnIndex)

  if noteColumnIndex > renoise.song().selected_track.max_note_columns then
    return
  end
  
  -- Not enough space? Compensate!
  if noteColumnIndex > renoise.song().selected_track.visible_note_columns then
    renoise.song().selected_track.visible_note_columns = noteColumnIndex
  end
    
  local noteColumn = renoise.song().selected_line.note_columns[noteColumnIndex]
  
  if (note > -1 and note < 122) then
    noteColumn.note_value = note
  end
  
  if renoise.song().transport.keyboard_velocity_enabled then
    noteColumn.volume_value = renoise.song().transport.keyboard_velocity
  else
    noteColumn.volume_value = 255
  end
  noteColumn.instrument_value = renoise.song().selected_instrument_index - 1
end

--------------------------------------------------------------------------------

function updateScaleNotes()

  scaleNotes = {}

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if noteIsInScale(note) then
      scaleNotes[scaleNoteIndex] = note
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end

function updateScaleChords()

  scaleChords = {}

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if noteIsInScale(note) then
      scaleChords[scaleNoteIndex] = getScaleChordsForRootNote(note)
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end

function removeFlatsAndSharps(arg)
  return arg:gsub('b',''):gsub('#','')
end

function aNoteIsRepeated()

  local numberOfScaleNoteNames = 7
  local previousScaleNoteName = getScaleNoteName(numberOfScaleNoteNames)
  local scaleNoteName = nil

  for scaleDegree = 1,  numberOfScaleNoteNames do

    scaleNoteName = getScaleNoteName(scaleDegree)

    if removeFlatsAndSharps(scaleNoteName) == removeFlatsAndSharps(previousScaleNoteName) then
      return true
    end

    previousScaleNoteName = scaleNoteName
  end

  return false
end

function updateScaleNoteNames()
  
  local previousScaleNoteName = getSharpNoteName(getScaleTonicNote() + 11)
  local scaleNoteName = nil
  
  local scaleDegree = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if scalePattern[getNotesIndex(note)] then

      scaleNoteName = getSharpNoteName(note) 
      setScaleNoteName(scaleDegree, scaleNoteName)      
      scaleDegree = scaleDegree + 1
      previousScaleNoteName = scaleNoteName
    end
  end
  
  if aNoteIsRepeated() then
  
    local previousScaleNoteName = getFlatNoteName(getScaleTonicNote() + 11)
    local scaleNoteName = nil
    
    local scaleDegree = 1
    for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
    
      if scalePattern[getNotesIndex(note)] then
            
        scaleNoteName = getFlatNoteName(note)        
        setScaleNoteName(scaleDegree, scaleNoteName)      
        scaleDegree = scaleDegree + 1
        previousScaleNoteName = scaleNoteName
      end
    end
  end
end

function updateScaleNotesText()
  
  local scaleNotesText = ''
  
  for i = 1, #scaleNotes do
    if scaleNotesText ~= '' then 
      scaleNotesText = scaleNotesText .. ', '
    end
    
    scaleNotesText = scaleNotesText .. getScaleNoteName(i)
  end

  setScaleNotesText(scaleNotesText)
end

function getChordInversionText(chordNotesArray)

  local inversionValue = getCurrentInversionValue()
  
  if inversionValue == 0 then
    return ''
  end
  
  if math.fmod(inversionValue, #chordNotesArray) == 0 then
    return ''
  end
    
  return '/' .. getNoteName(chordNotesArray[1]+1)
end

function getChordInversionOctaveIndicator(numberOfChordNotes)

  local inversionValue = getCurrentInversionValue()

  local octaveIndicator = nil
   
  if inversionValue > 0 then
  
    local offsetValue = math.floor(inversionValue / numberOfChordNotes)
    
    if offsetValue > 0 then
      return '+' .. offsetValue
    else
      return '+'
    end
  
  elseif inversionValue < 0 then
  
    local offsetValue = math.abs(math.ceil(inversionValue / numberOfChordNotes))
    
    if offsetValue > 0 then
      return '-' .. offsetValue
    else  
      return '-'
    end
  else
    return ''
  end  
end

function updateChordText(root, chord, chordNotesArray)
  
  local rootNoteName = getNoteName(root)
  local chordInversionText = getChordInversionText(chordNotesArray)
  local chordInversionOctaveIndicator = getChordInversionOctaveIndicator(#chordNotesArray)
  local chordString = rootNoteName .. chord["display"]
  local notesString = getNotesString(chordNotesArray)

  local chordTextValue = ''
  if string.match(chordInversionOctaveIndicator, "-") then
    chordTextValue = ("%20s%20s%s%20s"):format(chordInversionOctaveIndicator, chordString, chordInversionText, notesString)
  elseif string.match(chordInversionOctaveIndicator, "+") then
    chordTextValue = ("%20s%20s%s%20s%20s"):format('', chordString, chordInversionText, notesString, chordInversionOctaveIndicator)
  else
    chordTextValue = ("%20s%20s%s%20s"):format('', chordString, chordInversionText, notesString)
  end

  setChordText(chordTextValue)
  
  reaper.Help_Set(chordTextValue, false)
end

function updateScaleData()

  scalePattern = getScalePattern(getScaleTonicNote(), scales[getScaleType()])
  updateScaleNotes()
  updateScaleNoteNames()
  updateScaleNotesText()
  updateScaleChords()
  
  if (viewBuilder ~= nil) then
    updateChordButtons()
    highlightSelectedChordTypes()
  end
end

function showScaleStatus()

  local scaleTonicText =  notes[getScaleTonicNote()]
  local scaleTypeText = scales[getScaleType()].name
  local scaleNotesText = getScaleNotesText()
  reaper.Help_Set(("%s %s: %s"):format(scaleTonicText, scaleTypeText, scaleNotesText))
end