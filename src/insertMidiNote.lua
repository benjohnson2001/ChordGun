local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")


local function activeMidiEditor()
	return reaper.MIDIEditor_GetActive()
end

local function activeTake()
  return reaper.MIDIEditor_GetTake(activeMidiEditor())
end

local function activeMediaItem()
	return reaper.GetMediaItemTake_Item(activeTake())
end

local function mediaItemStartPosition()
	return reaper.GetMediaItemInfo_Value(activeMediaItem(), "D_POSITION")
end

local function mediaItemLength()
	return reaper.GetMediaItemInfo_Value(activeMediaItem(), "D_LENGTH")
end

local function mediaItemEndPosition()
	return mediaItemStartPosition() + mediaItemLength()
end

local function cursorPosition()
	return reaper.GetCursorPosition()
end

local function loopStartPosition()

	local loopStartPosition, _ = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)
	return loopStartPosition
end

local function loopEndPosition()

	local _, loopEndPosition = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)
	return loopEndPosition
end

local function noteLength()

  local noteLengthQN = getNoteLengthQN()
  local noteLengthPPQ = reaper.MIDI_GetPPQPosFromProjQN(activeTake(), noteLengthQN)
  return reaper.MIDI_GetProjTimeFromPPQPos(activeTake(), noteLengthPPQ)
end

local function setEditCursorPosition(arg)

	local activeProjectIndex = 0
	local moveView = false
	local seekPlay = false
	reaper.SetEditCurPos2(activeProjectIndex, arg, moveView, seekPlay)
end

local function moveEditCursorPosition(arg)

	local moveTimeSelection = false
  reaper.MoveEditCursor(arg, moveTimeSelection)
end

local function repeatIsNotOn()
	return reaper.GetSetRepeat(-1) == 0
end

local function loopIsActive()

	if repeatIsNotOn() then
		return false
	end

	if loopStartPosition() == loopEndPosition() then
		return false
	else
		return true
	end
end

function moveCursor()

	local tolerance = 0.000001
  if loopIsActive() and loopEndPosition() < mediaItemEndPosition() then

  	if cursorPosition() + noteLength() >= loopEndPosition() - tolerance then

  		if loopStartPosition() > mediaItemStartPosition() then
  			setEditCursorPosition(loopStartPosition())
  		else
  			setEditCursorPosition(mediaItemStartPosition())
  		end

  	else
  		moveEditCursorPosition(noteLength())
  	end

  elseif loopIsActive() and mediaItemEndPosition() <= loopEndPosition() then 

  	if cursorPosition() + noteLength() >= mediaItemEndPosition() - tolerance then

  		if loopStartPosition() > mediaItemStartPosition() then
  			setEditCursorPosition(loopStartPosition())
  		else
  			setEditCursorPosition(mediaItemStartPosition())
  		end

  	else
  		moveEditCursorPosition(noteLength())
  	end

  elseif cursorPosition() + noteLength() >= mediaItemEndPosition() then
			setEditCursorPosition(mediaItemStartPosition())
	else

		moveEditCursorPosition(noteLength())
  end
end

--

function getCursorPositionPPQ()
	return reaper.MIDI_GetPPQPosFromProjTime(activeTake(), cursorPosition())
end

local function getCursorPositionQN()
	return reaper.MIDI_GetProjQNFromPPQPos(activeTake(), getCursorPositionPPQ())
end

function getNoteLengthQN()

	local gridLen, _, noteLen = reaper.MIDI_GetGrid(activeTake())
	
	local noteLength = gridLen

	if noteLen ~= 0 then
		noteLength = noteLen
	end

	return noteLength
end

local function getMidiEndPositionPPQ()

	local noteLength = getNoteLengthQN()
	local startPosition = getCursorPositionQN()
	return reaper.MIDI_GetPPQPosFromProjQN(activeTake(), startPosition + noteLength)
end

function deselectAllNotes()

	local selectAllNotes = false
	reaper.MIDI_SelectAll(activeTake(), selectAllNotes)
end

function insertMidiNote(note)

	local noteIsSelected = true
	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getMidiEndPositionPPQ()

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake(), noteIsSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end