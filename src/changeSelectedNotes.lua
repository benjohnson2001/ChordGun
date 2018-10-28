local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")

local function getNumberOfNotes()

	local _, numberOfNotes = reaper.MIDI_CountEvts(activeTake())
	return numberOfNotes
end

local function deleteNote(noteIndex)

	reaper.MIDI_DeleteNote(activeTake(), noteIndex)
end

local function thereAreNotesSelected()

	local numberOfNotes = getNumberOfNotes()

	for noteIndex = 0, numberOfNotes-1 do

		local _, noteIsSelected = reaper.MIDI_GetNote(activeTake(), noteIndex)

		if noteIsSelected then
			return true
		end
	end

	return false
end

local function getNoteStartingPositions()

	local numberOfNotes = getNumberOfNotes()
	local previousNoteStartPositionPPQ = -1
	local noteStartingPositions = {}

	for noteIndex = 0, numberOfNotes-1 do

		local _, noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ = reaper.MIDI_GetNote(activeTake(), noteIndex)
	
		if noteIsSelected then

			if noteStartPositionPPQ ~= previousNoteStartPositionPPQ then
				table.insert(noteStartingPositions, noteStartPositionPPQ)
			end

			previousNoteStartPositionPPQ = noteStartPositionPPQ
		end
	end

	return noteStartingPositions
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

function changeSelectedNotesToScaleChords()

	local noteStartingPositions = getNoteStartingPositions()
	deleteSelectedNotes()
	
	for i = 1, #noteStartingPositions do
		setEditCursorTo(noteStartingPositions[i])
		insertChordForSelection()
	end
end

function changeSelectedNotesToScaleNotes(octaveAdjustment)

	local noteStartingPositions = getNoteStartingPositions()
	deleteSelectedNotes()

	for i = 1, #noteStartingPositions do
		setEditCursorTo(noteStartingPositions[i])
		insertScaleNoteForSelection(octaveAdjustment)
	end
end