-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")
require(workingDirectory .. "/MidiNote")

local function transposeSelectedNotes(numberOfSemitones)

  local numberOfNotes = getNumberOfNotes()
  local midiNotes = {}

  for noteIndex = 0, numberOfNotes-1 do

    local _, noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ, channel, pitch, velocity = reaper.MIDI_GetNote(activeTake(), noteIndex)

    if noteIsSelected then
      table.insert(midiNotes, MidiNote:new(noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ, channel, pitch, velocity))
    end
  end

  deleteSelectedNotes()

  for i = 1, #midiNotes do

    local midiNote = midiNotes[i]
    local noSort = true
    reaper.MIDI_InsertNote(activeTake(), midiNote.noteIsSelected, midiNote.noteIsMuted, midiNote.noteStartPositionPPQ, midiNote.noteEndPositionPPQ, midiNote.channel, midiNote.pitch+numberOfSemitones, midiNote.velocity, noSort)
  end

  reaper.MIDI_Sort(activeTake())
end

function transposeSelectedNotesUpOneOctave()
  transposeSelectedNotes(12)
end

function transposeSelectedNotesDownOneOctave()
  transposeSelectedNotes(-12)
end