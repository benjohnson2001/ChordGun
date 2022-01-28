-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")

NotePosition = {}
NotePosition.__index = NotePosition

function NotePosition:new(startPosition, endPosition)
  local self = {}
  setmetatable(self, NotePosition)

  self.startPosition = startPosition
  self.endPosition = endPosition

  return self
end

local function noteStartPositionDoesNotExist(notePositions, startPositionArg)

	for index, notePosition in pairs(notePositions) do

		if notePosition.startPosition == startPositionArg then
			return false
		end
	end

	return true
end

local function updateNoteEndPositionToBeTheLongerValue(notePositions, startPositionArg, endPositionArg)

	for index, notePosition in pairs(notePositions) do

		if notePosition.startPosition == startPositionArg then

			if endPositionArg > notePosition.endPosition then
				notePosition.endPosition = endPositionArg
			end
		end
	end
end

local function getNotePositions()

	local numberOfNotes = getNumberOfNotes()
	local notePositions = {}

	for noteIndex = 0, numberOfNotes-1 do

		local _, noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ = reaper.MIDI_GetNote(activeTake(), noteIndex)
	
		if noteIsSelected then

			if noteStartPositionDoesNotExist(notePositions, noteStartPositionPPQ) then
				table.insert(notePositions, NotePosition:new(noteStartPositionPPQ, noteEndPositionPPQ))
			else
				updateNoteEndPositionToBeTheLongerValue(notePositions, noteStartPositionPPQ, noteEndPositionPPQ)
			end
		end
	end

	return notePositions
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

	local notePositions = getNotePositions()
	deleteSelectedNotes()
	
	for i = 1, #notePositions do
		setEditCursorTo(notePositions[i].startPosition)
		insertScaleChord(chordNotesArray, true, notePositions[i].endPosition)
	end
end

function changeSelectedNotesToScaleNotes(noteValue)

	local notePositions = getNotePositions()
	deleteSelectedNotes()

	for i = 1, #notePositions do
		setEditCursorTo(notePositions[i].startPosition)
		insertScaleNote(noteValue, true, notePositions[i].endPosition)
	end
end