-- @noindex
MidiNote = {}
MidiNote.__index = MidiNote

function MidiNote:new(noteIsSelectedArg, noteIsMutedArg, noteStartPositionPPQArg, noteEndPositionPPQArg, channelArg, pitchArg, velocityArg)

  local self = {}
  setmetatable(self, MidiNote)

  self.noteIsSelected = noteIsSelectedArg
  self.noteIsMuted = noteIsMutedArg
  self.noteStartPositionPPQ = noteStartPositionPPQArg
  self.noteEndPositionPPQ = noteEndPositionPPQArg
  self.channel = channelArg
  self.pitch = pitchArg
  self.velocity = velocityArg

  return self
end
