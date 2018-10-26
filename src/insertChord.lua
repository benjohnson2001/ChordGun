local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/insertMidiNote")

local function moveCursor()
  
  local activeMidiEditor = reaper.MIDIEditor_GetActive()
  local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

  local noteLengthQN = getNoteLength()
  local noteLengthPPQ = reaper.MIDI_GetPPQPosFromProjQN(activeTake, noteLengthQN)
  local noteLength = reaper.MIDI_GetProjTimeFromPPQPos(activeTake, noteLengthPPQ)

  local timeSelection = false
  reaper.MoveEditCursor(noteLength, timeSelection)
end

function insertChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)
  
  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   
  
  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note])
  end

  updateChordText(root, chord, chordNotesArray)
  moveCursor()
end