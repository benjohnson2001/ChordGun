-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/ChordGunMini_src"
require(workingDirectory .. "/midiEditor")

SelectedNote = {}
SelectedNote.__index = SelectedNote

function SelectedNote:new(endPosition, velocity, channel, muteState, pitch)
  local self = {}
  setmetatable(self, SelectedNote)

  self.endPosition = endPosition
  self.velocity = velocity
  self.channel = channel
  self.muteState = muteState
  self.pitch = pitch

  return self
end

SelectedChord = {}
SelectedChord.__index = SelectedChord

function SelectedChord:new(startPosition, endPosition, velocity, channel, muteState, pitch)
  local self = {}
  setmetatable(self, SelectedChord)

  self.startPosition = startPosition
  self.longestEndPosition = endPosition

  self.selectedNotes = {}
  table.insert(self.selectedNotes, SelectedNote:new(endPosition, velocity, channel, muteState, pitch))

  return self
end



local function noteStartPositionDoesNotExist(selectedChords, startPositionArg)

	for index, selectedChord in pairs(selectedChords) do

		if selectedChord.startPosition == startPositionArg then
			return false
		end
	end

	return true
end

local function updateSelectedChord(selectedChords, startPositionArg, endPositionArg, velocityArg, channelArg, muteStateArg, pitchArg)

	for index, selectedChord in pairs(selectedChords) do

		if selectedChord.startPosition == startPositionArg then

			table.insert(selectedChord.selectedNotes, SelectedNote:new(endPositionArg, velocityArg, channelArg, muteStateArg, pitchArg))

			if endPositionArg > selectedChord.longestEndPosition then
				selectedChord.longestEndPosition = endPositionArg
			end

		end
	end
end

local function getSelectedChords()

	local numberOfNotes = getNumberOfNotes()
	local selectedChords = {}

	for noteIndex = 0, numberOfNotes-1 do

		local _, noteIsSelected, muteState, noteStartPositionPPQ, noteEndPositionPPQ, channel, pitch, velocity = reaper.MIDI_GetNote(activeTake(), noteIndex)

		if noteIsSelected then

			if noteStartPositionDoesNotExist(selectedChords, noteStartPositionPPQ) then
				table.insert(selectedChords, SelectedChord:new(noteStartPositionPPQ, noteEndPositionPPQ, velocity, channel, muteState, pitch))
			else
				updateSelectedChord(selectedChords, noteStartPositionPPQ, noteEndPositionPPQ, velocity, channel, muteState, pitch)
			end
		end
	end

	for selectedChordIndex = 1, #selectedChords do
		table.sort(selectedChords[selectedChordIndex].selectedNotes, function(a,b) return a.pitch < b.pitch end)
	end

	return selectedChords
end

local function deleteSelectedNotes()

	local numberOfNotes = getNumberOfNotes()

	for noteIndex = numberOfNotes-1, 0, -1 do

		local _, noteIsSelected = reaper.MIDI_GetNote(activeTake(), noteIndex)
	
		if noteIsSelected then
			deleteNote(noteIndex)
		end
	end
end

local function setEditCursorTo(arg)

	local cursorPosition = reaper.MIDI_GetProjTimeFromPPQPos(activeTake(), arg)
	setEditCursorPosition(cursorPosition)
end

function changeSelectedNotesToScaleChords(chordNotesArray)

	local selectedChords = getSelectedChords()
	deleteSelectedNotes()
	
	for i = 1, #selectedChords do
		setEditCursorTo(selectedChords[i].startPosition)
		insertScaleChord(chordNotesArray, true, selectedChords[i])
	end
end

function changeSelectedNotesToScaleNotes(noteValue)

	local selectedChords = getSelectedChords()
	deleteSelectedNotes()

	for i = 1, #selectedChords do
		setEditCursorTo(selectedChords[i].startPosition)
		insertScaleNote(noteValue, true, selectedChords[i])
	end
end