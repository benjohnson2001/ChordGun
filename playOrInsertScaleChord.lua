-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")
require(workingDirectory .. "/changeSelectedNotes")
require(workingDirectory .. "/playOrInsertScaleChordForGuitarTrack")

function playScaleChord(chordNotesArray)

  stopNotesThatArePlayingOnChannelTwo()
  stopNotesThatArePlayingOnChannelOne()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

  setNotesThatArePlayingOnChannelOne(chordNotesArray)
end

function playModifierNotes(modifierNotesArray)
  
  for note = 1, #modifierNotesArray do
    local channel = 1
    playMidiNote(modifierNotesArray[note], channel)
  end

  setNotesThatArePlayingOnChannelTwo(modifierNotesArray)
end

function insertScaleChord(chordNotesArray, keepNotesSelected)

  deleteExistingNotesInNextInsertionTimePeriod()

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end

  moveCursor()
end

function previewScaleChord(actionDescription)

  if activeTrackIs("tele") or activeTrackIs("strat") then
    previewScaleChordForGuitarTrack(actionDescription)
    return
  end

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()

  local chordNotesArray = getChordNotesArray(root, chord, octave)
  playScaleChord(chordNotesArray)
  updateChordText(root, chord, chordNotesArray)
end

function playOrInsertScaleChord(actionDescription)

--[[
  if activeTrackIs("tele") or activeTrackIs("strat") then
    playOrInsertScaleChordForGuitarTrack(actionDescription)
    return
  end
]]--

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()

  local chordNotesArray = getChordNotesArray(root, chord, octave)

  if activeTake() ~= nil and notCurrentlyRecording() then

    startUndoBlock()

      if thereAreNotesSelected() then 
        changeSelectedNotesToScaleChords(chordNotesArray)
      else
        insertScaleChord(chordNotesArray, false)
      end

    endUndoBlock(actionDescription)
  end

  playScaleChord(chordNotesArray)
  updateChordText(root, chord, chordNotesArray)
end