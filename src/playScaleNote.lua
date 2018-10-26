local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/chordNotesArray")
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/timer")


local function playScaleNoteImpl(octaveAdjustment)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1


  stopAllNotesFromPlaying()
  notesPlayingTimer:start()
  playMidiNote(noteValue)

  	-- TODO
    -- highlight the scale degree header for a few seconds
    -- TODO

  return noteValue
end

function playLowerScaleNote()
	return playScaleNoteImpl(-1)
end

function playScaleNote()
  return playScaleNoteImpl(0)
end

function playLowerScaleNote()
	return playScaleNoteImpl(1)
end