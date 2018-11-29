-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/midiEditor")
require(workingDirectory .. "/preferences")

function playMidiNote(midiNote, channelArg)

  local virtualKeyboardMode = 0
  local channel = getCurrentNoteChannel(channelArg)

  local noteOnCommand = 0x90 + channel
  local velocity = getCurrentVelocity()

  reaper.StuffMIDIMessage(virtualKeyboardMode, noteOnCommand, midiNote, velocity)
end


function stopAllNotesFromPlayingImpl(channelArg)

  local virtualKeyboardMode = 0
  local channel = getCurrentNoteChannel(channelArg)
  local noteOffCommand = 0x80 + channel
  local velocity = 0

  for midiNote = 0, 127 do
    reaper.StuffMIDIMessage(virtualKeyboardMode, noteOffCommand, midiNote, velocity)
  end
end

function stopAllNotesFromPlaying()

  local channelOne = 0
  stopAllNotesFromPlayingImpl(channelOne)

  local channelTwo = 1
  stopAllNotesFromPlayingImpl(channelTwo)
end

function stopNoteFromPlaying(midiNote, channelArg)

  local virtualKeyboardMode = 0
  local channel = getCurrentNoteChannel(channelArg)
  local noteOffCommand = 0x80 + channel
  local velocity = 0

  reaper.StuffMIDIMessage(virtualKeyboardMode, noteOffCommand, midiNote, velocity)
end

function stopNotesThatArePlayingOnChannelOne()

  local notesThatArePlayingOnChannelOne = getNotesThatArePlayingOnChannelOne()

  for noteIndex = 1, #notesThatArePlayingOnChannelOne do
    local channel = 0
    stopNoteFromPlaying(notesThatArePlayingOnChannelOne[noteIndex], channel)
  end

  setNotesThatArePlayingOnChannelOne({})
end

function stopNotesThatArePlayingOnChannelTwo()

  local notesThatArePlayingOnChannelTwo = getNotesThatArePlayingOnChannelTwo()

  for noteIndex = 1, #notesThatArePlayingOnChannelTwo do
    local channel = 1
    stopNoteFromPlaying(notesThatArePlayingOnChannelTwo[noteIndex], channel)
  end

  setNotesThatArePlayingOnChannelTwo({})
end