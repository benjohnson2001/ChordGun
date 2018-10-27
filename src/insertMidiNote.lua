local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/midiEditor")

local function getActiveTake()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
  return reaper.MIDIEditor_GetTake(activeMidiEditor)
end

local function getMediaItem()

	local activeTake = getActiveTake()
	return reaper.GetMediaItemTake_Item(activeTake)
end


local function getMediaItemStartPosition()

	local mediaItem = getMediaItem()

	return reaper.GetMediaItemInfo_Value(mediaItem, "D_POSITION")
end

local function getMediaItemEndPosition()

	local mediaItem = getMediaItem()

	local position = reaper.GetMediaItemInfo_Value(mediaItem, "D_POSITION")
	local length = reaper.GetMediaItemInfo_Value(mediaItem, "D_LENGTH")

	return position + length
end

local function getNoteLengthInSeconds()

	local activeTake = getActiveTake()
  local noteLengthQN = getNoteLength()
  local noteLengthPPQ = reaper.MIDI_GetPPQPosFromProjQN(activeTake, noteLengthQN)
  return reaper.MIDI_GetProjTimeFromPPQPos(activeTake, noteLengthPPQ)
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

local function loopIsActive()

	local repeatIsNotOn = (reaper.GetSetRepeat(-1) == 0)

	if repeatIsNotOn then
		return false
	end

	local loopStartPosition, loopEndPosition = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)

	if loopStartPosition == loopEndPosition then
		return false
	else
		return true
	end
end

function moveCursor()
  
  local cursorPosition = reaper.GetCursorPosition()
  local noteLength = getNoteLengthInSeconds()

  local mediaItemStartPosition = getMediaItemStartPosition()
  local mediaItemEndPosition = getMediaItemEndPosition()
  
  local loopStartPosition, loopEndPosition = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)

--[[
  print("cursorPosition: " .. cursorPosition)
  print("noteLength: " .. noteLength)
  print("mediaItemStartPosition: " .. mediaItemStartPosition)
  print("mediaItemEndPosition: " .. mediaItemEndPosition)
  print("loopStartPosition: " .. loopStartPosition)
  print("loopEndPosition: " .. loopEndPosition)
  print("loopIsActive: " .. tostring(loopIsActive))
]]--

	local tolerance = 0.000001
  if loopIsActive() and loopEndPosition < mediaItemEndPosition then

  	if cursorPosition + noteLength >= loopEndPosition - tolerance then

  		if loopStartPosition > mediaItemStartPosition then
  			setEditCursorPosition(loopStartPosition)
  		else
  			setEditCursorPosition(mediaItemStartPosition)
  		end

  	else
  		moveEditCursorPosition(noteLength)
  	end

  elseif loopIsActive() and mediaItemEndPosition <= loopEndPosition then 

  	if cursorPosition + noteLength >= mediaItemEndPosition - tolerance then

  		if loopStartPosition > mediaItemStartPosition then
  			setEditCursorPosition(loopStartPosition)
  		else
  			setEditCursorPosition(mediaItemStartPosition)
  		end

  	else
  		moveEditCursorPosition(noteLength)
  	end

  elseif cursorPosition + noteLength >= mediaItemEndPosition then
			setEditCursorPosition(mediaItemStartPosition)
	else

		moveEditCursorPosition(noteLength)
  end
end

--

function getCursorPositionPPQ()

	local activeTake = getActiveTake()

	local cursorPosition = reaper.GetCursorPosition()
	local cursorPositionPPQ = reaper.MIDI_GetPPQPosFromProjTime(activeTake, cursorPosition)
	return cursorPositionPPQ
end

local function getCursorPositionQN(activeTake)
	local cursorPosition = reaper.GetCursorPosition()
	local cursorPositionPPQ = reaper.MIDI_GetPPQPosFromProjTime(activeTake, cursorPosition)
	local cursorPositionQN = reaper.MIDI_GetProjQNFromPPQPos(activeTake, cursorPositionPPQ)
	return cursorPositionQN
end

function getNoteLength()

	local activeTake = getActiveTake()
	local gridLen, _, noteLen = reaper.MIDI_GetGrid(activeTake)
	
	local noteLength = gridLen

	if noteLen ~= 0 then
		noteLength = noteLen
	end

	return noteLength
end

local function getEndPosition()

	local activeTake = getActiveTake()

	local noteLength = getNoteLength()
	local startPosition = getCursorPositionQN(activeTake)
	local endPosition = reaper.MIDI_GetPPQPosFromProjQN(activeTake, startPosition + noteLength)

	return endPosition
end

function insertMidiNote(note)

	local activeTake = getActiveTake()
	local noteIsSelected = false
	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getEndPosition()

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake, noteIsSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end