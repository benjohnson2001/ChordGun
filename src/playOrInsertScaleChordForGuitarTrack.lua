function activeTrackIs(trackNameArg)

  if activeMidiEditor() == nil then
    return trackIsArmed(trackNameArg)
  else
    return activeTrackNameIs(trackNameArg)
  end
end

function activeTrackNameIs(trackNameArg)
  local _, trackName = reaper.GetTrackName(activeTrack(), "")
  return trackName == trackNameArg
end

function trackIsArmed(trackNameArg)

  local activeProjectIndex = 0
  local numberOfTracks = reaper.CountTracks(activeProjectIndex)

  for i = 0, numberOfTracks - 1 do

    local track = reaper.GetTrack(activeProjectIndex, i)
    local trackIsArmed = (reaper.GetMediaTrackInfo_Value(track, "I_RECARM") == 1)
    local _, trackName = reaper.GetTrackName(track, "")

    if trackIsArmed and (trackName == trackNameArg) then
      return true
    end
  end

  return false
end

local function getModiferNote(root, chord, octave)

  local noteValue = root + ((octave+1) * 12) - 1

  if chord.code == "1_dyad" then
    return nil
  end

  if chord.code == "2_dyad" then
    return noteValue + 11
  end

  if chord.code == "min3_dyad" then
    return noteValue + 1
  end

  if chord.code == "maj3_dyad" then
    return noteValue + 1
  end

  if chord.code == "flat5_dyad" then
    return nil
  end      

  if chord.code == "5_dyad" then
    return nil
  end      
end

function insertScaleChordForGuitarTrack(chordNotesArray, keepNotesSelected)

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end
end

function insertModifierNotesForGuitarTrack(modifierNotesArray, keepNotesSelected)

  for note = 1, #modifierNotesArray do
    local channel = 1
    insertMidiNote(modifierNotesArray[note], keepNotesSelected, channel)
  end
end

local function playOrInsertScaleChordForGuitarTrack(actionDescription)

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()

  local chordNotesArray = getChordNotesArray(root, chord, octave)

  local modifierNotesArray = {}
  local modifierNote = getModiferNote(root, chord, octave)
  if modifierNote ~= nil then
    table.insert(modifierNotesArray, modifierNote)
  end
  
  local triggerNote = 72
  table.insert(modifierNotesArray, triggerNote)

  if activeTake() ~= nil and notCurrentlyRecording() then

    startUndoBlock()

      if thereAreNotesSelected() then 
        changeSelectedNotesToScaleChordsForGuitarTrack(chordNotesArray, modifierNotesArray)
      else

        deleteExistingNotesInNextInsertionTimePeriod()
        
        insertScaleChordForGuitarTrack(chordNotesArray, false)
        insertModifierNotesForGuitarTrack(modifierNotesArray, false)
        
        moveCursor()
      end
    
    endUndoBlock(actionDescription)
  end

  playScaleChord(chordNotesArray)
  playModifierNotes(modifierNotesArray)
  updateChordText(root, chord, chordNotesArray)
end