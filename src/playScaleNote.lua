local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")


local function playScaleNoteImpl(octaveAdjustment)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  stopNotesFromPlaying()
  playMidiNote(noteValue)
  setNotesThatArePlaying({noteValue})

  return noteValue
end

function playLowerScaleNote()

  if getOctave() < 0 then
    return
  end

	return playScaleNoteImpl(-1)
end

function playScaleNote()
  return playScaleNoteImpl(0)
end

function playHigherScaleNote()

  if getOctave() > 7 then
    return
  end

	return playScaleNoteImpl(1)
end

--

function playTonicNote()

  local root = scaleNotes[1]
  local octave = getOctave()
  local noteValue = root + ((octave+1) * 12) - 1

  stopNotesFromPlaying()
  playMidiNote(noteValue)
  setNotesThatArePlaying({noteValue})

  return noteValue
end