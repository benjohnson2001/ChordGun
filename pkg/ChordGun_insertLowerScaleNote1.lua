chords = {
  {
    name = 'major',
    code = 'maj',
    display = '',
    pattern = '10001001'
  },
  {
    name = 'minor',
    code = 'min',
    display = 'm',
    pattern = '10010001'
  },
  {
    name = 'power chord',
    code = 'power',
    display = '5',
    pattern = '10000001'
  },
  {
    name = 'suspended second',
    code = 'sus2',
    display = 'sus2',
    pattern = '10100001'
  },
  {
    name = 'suspended fourth',
    code = 'sus4',
    display = 'sus4',
    pattern = '10000101'
  },
  {
    name = 'diminished',
    code = 'dim',
    display = 'dim',
    pattern = '1001001'
  },  
  {
    name = 'augmented',
    code = 'aug',
    display = 'aug',
    pattern = '100010001'
  },
  {
    name = 'major sixth',
    code = 'maj6',
    display = '6',
    pattern = '1000100101'
  },
  {
    name = 'minor sixth',
    code = 'min6',
    display = 'm6',
    pattern = '1001000101'
  },
  {
    name = 'dominant seventh',
    code = '7',
    display = '7',
    pattern = '10001001001'
  },
  {
    name = 'major seventh',
    code = 'maj7',
    display = 'maj7',
    pattern = '100010010001'
  },
  {
    name = 'minor seventh',
    code = 'min7',
    display = 'm7',
    pattern = '10010001001'
  },
  {
    name = 'flat fifth',
    code = 'flat5',
    display = '5-',
    pattern = '10000010'
  },
}
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

defaultScaleTonicNoteValue = 1
defaultScaleTypeValue = 1
defaultScaleNotesTextValue = ""
defaultChordTextValue = ""
defaultChordInversionMin = -8
defaultChordInversionMax = 8
defaultSelectedScaleNote = 1
defaultOctave = 4

defaultSelectedChordTypes = {}
for i = 1, 7 do
  table.insert(defaultSelectedChordTypes, 1)
end

defaultSelectedInversionStates = {}
for i = 1, #chords do
  table.insert(defaultSelectedInversionStates, 0)
end

defaultScaleNoteNames = {'C', 'D', 'E', 'F', 'G', 'A', 'B'}
defaultScaleDegreeHeaders = {'I', 'ii', 'iii', 'IV', 'V', 'vi', 'viio'}

defaultNotesThatArePlaying = {}
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local activeProjectIndex = 0
local sectionName = "com.pandabot.ChordGun"

local scaleTonicNoteKey = "scaleTonicNote"
local scaleTypeKey = "scaleType"
local scaleNotesTextKey = "scaleNotesText"
local chordTextKey = "chordText"
local chordInversionMinKey = "chordInversionMin"
local chordInversionMaxKey = "chordInversionMax"
local selectedScaleNoteKey = "selectedScaleNote"
local octaveKey = "octave"
local selectedChordTypesKey = "selectedChordTypes"
local scaleNoteNamesKey = "scaleNoteNames"
local scaleDegreeHeadersKey = "scaleDegreeHeaders"
local selectedInversionStates1Key = "selectedInversionStates1"
local selectedInversionStates2Key = "selectedInversionStates2"
local selectedInversionStates3Key = "selectedInversionStates3"
local selectedInversionStates4Key = "selectedInversionStates4"
local selectedInversionStates5Key = "selectedInversionStates5"
local selectedInversionStates6Key = "selectedInversionStates6"
local selectedInversionStates7Key = "selectedInversionStates7"
local notesThatArePlayingKey = "notesThatArePlaying"

--

local function setValue(key, value)
  reaper.SetProjExtState(activeProjectIndex, sectionName, key, value)
end

local function getValue(key, defaultValue)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)

  if valueExists == 0 then
    setValue(key, defaultValue)
    return defaultValue
  end

  return value
end

--

local function getTableFromString(arg)

  local output = {}

  for match in arg:gmatch("([^,%s]+)") do
    output[#output + 1] = match
  end

  return output
end

local function setTableValue(key, value)
  reaper.SetProjExtState(activeProjectIndex, sectionName, key, table.concat(value, ","))
end

local function getTableValue(key, defaultValue)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)

  if valueExists == 0 then
    setTableValue(key, defaultValue)
    return defaultValue
  end

  return getTableFromString(value)
end

--[[ ]]--

function getScaleTonicNote()
  return tonumber(getValue(scaleTonicNoteKey, defaultScaleTonicNoteValue))
end

function setScaleTonicNote(arg)
  setValue(scaleTonicNoteKey, arg)
end

--

function getScaleType()
  return tonumber(getValue(scaleTypeKey, defaultScaleTypeValue))
end

function setScaleType(arg)
  setValue(scaleTypeKey, arg)
end

--

function getScaleNotesText()
  return getValue(scaleNotesTextKey, defaultScaleNotesTextValue)
end

function setScaleNotesText(arg)
  setValue(scaleNotesTextKey, arg)
end

--

function getChordText()
  return getValue(chordTextKey, defaultChordTextValue)
end

function setChordText(arg)
  setValue(chordTextKey, arg)
end

--

function getChordInversionMin()
  return tonumber(getValue(chordInversionMinKey, defaultChordInversionMin))
end

function setChordInversionMin(arg)
  setValue(chordInversionMinKey, arg)
end

--

function getChordInversionMax()
  return tonumber(getValue(chordInversionMaxKey, defaultChordInversionMax))
end

function setChordInversionMax(arg)
  setValue(chordInversionMaxKey, arg)
end

--

function getSelectedScaleNote()
  return tonumber(getValue(selectedScaleNoteKey, defaultSelectedScaleNote))
end

function setSelectedScaleNote(arg)
  setValue(selectedScaleNoteKey, arg)
end

--

function getOctave()
  return tonumber(getValue(octaveKey, defaultOctave))
end

function setOctave(arg)
  setValue(octaveKey, arg)
end

--

function getSelectedChordTypes()

  return getTableValue(selectedChordTypesKey, defaultSelectedChordTypes)
end

function getSelectedChordType(index)

  local temp = getTableValue(selectedChordTypesKey, defaultSelectedChordTypes)
  return tonumber(temp[index])
end

function setSelectedChordType(index, arg)

  local temp = getSelectedChordTypes()
  temp[index] = arg
  setTableValue(selectedChordTypesKey, temp)
end

--

function getScaleNoteNames()
  return getTableValue(scaleNoteNamesKey, defaultScaleNoteNames)
end

function getScaleNoteName(index)
  local temp = getTableValue(scaleNoteNamesKey, defaultScaleNoteNames)
  return temp[index]
end

function setScaleNoteName(index, arg)

  local temp = getScaleNoteNames()
  temp[index] = arg
  setTableValue(scaleNoteNamesKey, temp)
end

--

function getScaleDegreeHeaders()
  return getTableValue(scaleDegreeHeadersKey, defaultScaleDegreeHeaders)
end

function getScaleDegreeHeader(index)
  local temp = getTableValue(scaleDegreeHeadersKey, defaultScaleDegreeHeaders)
  return temp[index]
end

function setScaleDegreeHeader(index, arg)

  local temp = getScaleDegreeHeaders()
  temp[index] = arg
  setTableValue(scaleDegreeHeadersKey, temp)
end

--

function getSelectedInversionStates1()
  return getTableValue(selectedInversionStates1Key, defaultSelectedInversionStates)
end

function getSelectedInversionState1(index)

  local temp = getTableValue(selectedInversionStates1Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState1(index, arg)

  local temp = getSelectedInversionStates1()
  temp[index] = arg
  setTableValue(selectedInversionStates1Key, temp)
end

--

function getSelectedInversionStates2()
  return getTableValue(selectedInversionStates2Key, defaultSelectedInversionStates)
end

function getSelectedInversionState2(index)

  local temp = getTableValue(selectedInversionStates2Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState2(index, arg)

  local temp = getSelectedInversionStates2()
  temp[index] = arg
  setTableValue(selectedInversionStates2Key, temp)
end

--

function getSelectedInversionStates3()
  return getTableValue(selectedInversionStates3Key, defaultSelectedInversionStates)
end

function getSelectedInversionState3(index)

  local temp = getTableValue(selectedInversionStates3Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState3(index, arg)

  local temp = getSelectedInversionStates3()
  temp[index] = arg
  setTableValue(selectedInversionStates3Key, temp)
end

--

function getSelectedInversionStates4()
  return getTableValue(selectedInversionStates4Key, defaultSelectedInversionStates)
end

function getSelectedInversionState4(index)

  local temp = getTableValue(selectedInversionStates4Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState4(index, arg)

  local temp = getSelectedInversionStates4()
  temp[index] = arg
  setTableValue(selectedInversionStates4Key, temp)
end

--

function getSelectedInversionStates5()
  return getTableValue(selectedInversionStates5Key, defaultSelectedInversionStates)
end

function getSelectedInversionState5(index)

  local temp = getTableValue(selectedInversionStates5Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState5(index, arg)

  local temp = getSelectedInversionStates5()
  temp[index] = arg
  setTableValue(selectedInversionStates5Key, temp)
end

--

function getSelectedInversionStates6()
  return getTableValue(selectedInversionStates6Key, defaultSelectedInversionStates)
end

function getSelectedInversionState6(index)

  local temp = getTableValue(selectedInversionStates6Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState6(index, arg)

  local temp = getSelectedInversionStates6()
  temp[index] = arg
  setTableValue(selectedInversionStates6Key, temp)
end

--

function getSelectedInversionStates7()
  return getTableValue(selectedInversionStates7Key, defaultSelectedInversionStates)
end

function getSelectedInversionState7(index)

  local temp = getTableValue(selectedInversionStates7Key, defaultSelectedInversionStates)
  return tonumber(temp[index])
end

function setSelectedInversionState7(index, arg)

  local temp = getSelectedInversionStates7()
  temp[index] = arg
  setTableValue(selectedInversionStates7Key, temp)
end

--

function resetSelectedChordTypes()

  local numberOfSelectedChordTypes = 7

  for i = 1, numberOfSelectedChordTypes do
    setSelectedChordType(i, 1)
  end
end

function resetSelectedInversionStates()

  local numberOfSelectedInversionStates = #defaultSelectedInversionStates

  for i = 1, numberOfSelectedInversionStates do
    setSelectedInversionState1(i, 0)
    setSelectedInversionState2(i, 0)
    setSelectedInversionState3(i, 0)
    setSelectedInversionState4(i, 0)
    setSelectedInversionState5(i, 0)
    setSelectedInversionState6(i, 0)
    setSelectedInversionState7(i, 0)
  end
end

--

function getNotesThatArePlaying()
  return getTableValue(notesThatArePlayingKey, defaultNotesThatArePlaying)
end

function setNotesThatArePlaying(arg)
  setTableValue(notesThatArePlayingKey, arg)
end

--
function mouseIsHoveringOver(element)

	local x = gfx.mouse_x
	local y = gfx.mouse_y

	local isInHorizontalRegion = (x >= element.x and x < element.x+element.width)
	local isInVerticalRegion = (y >= element.y and y < element.y+element.height)
	return isInHorizontalRegion and isInVerticalRegion
end

function setPositionAtMouseCursor()

  gfx.x = gfx.mouse_x
  gfx.y = gfx.mouse_y
end

function leftMouseButtonIsHeldDown()
  return gfx.mouse_cap & 1 == 1
end

function leftMouseButtonIsNotHeldDown()
  return gfx.mouse_cap & 1 ~= 1
end

function rightMouseButtonIsHeldDown()
  return gfx.mouse_cap & 2 == 2
end

function clearConsoleWindow()
  reaper.ShowConsoleMsg("")
end

function print(arg)
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
end

function getScreenWidth()
	local _, _, screenWidth, _ = reaper.my_getViewport(0, 0, 0, 0, 0, 0, 0, 0, true)
	return screenWidth
end

function getScreenHeight()
	local _, _, _, screenHeight = reaper.my_getViewport(0, 0, 0, 0, 0, 0, 0, 0, true)
	return screenHeight
end

function windowIsDocked()
	return gfx.dock(-1) > 0
end

function windowIsNotDocked()
	return not windowIsDocked()
end

function notesAreSelected()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

	local noteIndex = 0
	local noteExists = true
	local noteIsSelected = false

	while noteExists do

		noteExists, noteIsSelected = reaper.MIDI_GetNote(activeTake, noteIndex)

		if noteIsSelected then
			return true
		end
	
		noteIndex = noteIndex + 1
	end

	return false
end

Timer = {}
Timer.__index = Timer

function Timer:new(numberOfSeconds)

  local self = {}
  setmetatable(self, Timer)

  self.startingTime = reaper.time_precise()
  self.numberOfSeconds = numberOfSeconds
  self.timerIsStopped = true

  return self
end

function Timer:start()

	self.timerIsStopped = false
	self.startingTime = reaper.time_precise()
end

function Timer:stop()

	self.timerIsStopped = true
end

function Timer:timeHasElapsed()

	local currentTime = reaper.time_precise()

	if self.timerIsStopped then
		return false
	end

	if currentTime - self.startingTime > self.numberOfSeconds then
		return true
	else
		return false
	end
end

function Timer:timeHasNotElapsed()
	return not self:timeHasElapsed()
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

mouseButtonIsNotPressedDown = true

currentWidth = 0

scaleTonicNote = getScaleTonicNote()
scaleType = getScaleType()
scales = {
  { name = "Major", pattern = "101011010101" },
  { name = "Natural Minor", pattern = "101101011010" },
  { name = "Harmonic Minor", pattern = "101101011001" },
  { name = "Melodic Minor", pattern = "101101010101" },
  { name = "Pentatonic", pattern = "101010010100" },
  { name = "Ionian", pattern = "101011010101" },
  { name = "Aeolian", pattern = "101101011010" },
  { name = "Dorian", pattern = "101101010110" },
  { name = "Mixolydian", pattern = "101011010110" },
  { name = "Phrygian", pattern = "110101011010" },
  { name = "Lydian", pattern = "101010110101" },
  { name = "Locrian", pattern = "110101101010" }
}
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

notes = { 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B' };
flatNotes = { 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B' };

function getScalePattern(scaleTonicNote, scale)

  local scalePatternString = scale['pattern']
  local scalePattern = {false,false,false,false,false,false,false,false,false,false,false}

  for i = 0, #scalePatternString do
    local note = getNotesIndex(scaleTonicNote+i)
    if scalePatternString:sub(i+1, i+1) == '1' then
      scalePattern[note] = true
    end
  end
  return scalePattern
end

function getNotesIndex(note) 
   return ((note - 1) % 12) + 1
end

function getNoteName(note)

  local noteName = getSharpNoteName(note)
  
  if not string.match(getScaleNotesText(), noteName) then
    return getFlatNoteName(note)
  else
    return noteName
  end
end

function getSharpNoteName(note)
  local notesIndex = getNotesIndex(note)
  return notes[notesIndex]
end

function getFlatNoteName(note)
  local notesIndex = getNotesIndex(note)
  return flatNotes[notesIndex]
end

function chordIsNotAlreadyIncluded(scaleChordsForRootNote, chordCode)

  for chordIndex, chord in ipairs(scaleChordsForRootNote) do
  
    if chord.code == chordCode then
      return false
    end
  end
  
  return true
end

function getNumberOfScaleChordsForScaleNoteIndex(scaleNoteIndex)

  local chordCount = 0
  local scaleChordsForRootNote = {}
  
  for chordIndex, chord in ipairs(chords) do
  
    if chordIsInScale(scaleNotes[scaleNoteIndex], chordIndex) then
      chordCount = chordCount + 1
      scaleChordsForRootNote[chordCount] = chord   
    end
  end

  return chordCount
end

function getScaleChordsForRootNote(rootNote)
  
  local chordCount = 0
  local scaleChordsForRootNote = {}
  
  for chordIndex, chord in ipairs(chords) do
  
    if chordIsInScale(rootNote, chordIndex) then
      chordCount = chordCount + 1
      scaleChordsForRootNote[chordCount] = chord   
    end
  end
    
  --[[  
  if preferences.enableModalMixtureCheckbox.value then

    for chordIndex, chord in ipairs(chords) do
             
      if chordIsNotAlreadyIncluded(scaleChordsForRootNote, chord.code) and chordIsInModalMixtureScale(rootNote, chordIndex) then
        chordCount = chordCount + 1
        scaleChordsForRootNote[chordCount] = chord
      end
    end
  end
  ]]--


  -- here is where you color the chord buttons differently
  for chordIndex, chord in ipairs(chords) do
           
    if chordIsNotAlreadyIncluded(scaleChordsForRootNote, chord.code) then
      chordCount = chordCount + 1
      scaleChordsForRootNote[chordCount] = chord
    end
  end
  
  return scaleChordsForRootNote
end

function noteIsInScale(note)
  return scalePattern[getNotesIndex(note)]
end

function noteIsNotInScale(note)
  return not noteIsInScale(note)
end

function chordIsInScale(rootNote, chordIndex)

  local chord = chords[chordIndex]
  local chordPattern = chord['pattern']
  
  for i = 0, #chordPattern do
    local note = getNotesIndex(rootNote+i)
    if chordPattern:sub(i+1, i+1) == '1' and noteIsNotInScale(note) then
      return false
    end
  end
  
  return true
end

function noteIsInModalMixtureScale(note)

  local modalMixtureScaleType = 2
  local modalMixtureScalePattern = getScalePattern(getScaleTonicNote(), scales[modalMixtureScaleType])
  return modalMixtureScalePattern[getNotesIndex(note)]
end

function noteIsNotInModalMixtureScale(note)
  return not noteIsInModalMixtureScale(note)
end

function chordIsInModalMixtureScale(rootNote, chordIndex)

  local chord = chords[chordIndex]
  local chordPattern = chord['pattern']
  
  for i = 0, #chordPattern do
    local note = getNotesIndex(rootNote+i)
        
    if chordPattern:sub(i+1, i+1) == '1' and noteIsNotInModalMixtureScale(note) then
      return false
    end
  end
  
  return true
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

function updateScaleDegreeHeaders()

  local minorSymbols = {'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii'}
  local majorSymbols = {'I', 'II', 'III', 'IV', 'V', 'VI', 'VII'}
  local diminishedSymbol = 'o'
  local augmentedSymbol = '+'
  local sixthSymbol = '6'
  local seventhSymbol = '7'
  
  local i = 1
  for i = 1, #scaleNotes do
  
    local symbol = ""
   
    local chord = scaleChords[i][1]
    
    if string.match(chord.code, "maj") or chord.code == '7' then
      symbol = majorSymbols[i]
    else
      symbol = minorSymbols[i]
    end
    
    if (chord.code == 'aug') then
      symbol = symbol .. augmentedSymbol
    end

    if (chord.code == 'dim') then
      symbol = symbol .. diminishedSymbol
    end

    if string.match(chord.code, "6") then
      symbol = symbol .. sixthSymbol
    end
    
    if string.match(chord.code, "7") then
      symbol = symbol .. seventhSymbol
    end
        
    setScaleDegreeHeader(i, symbol) 
  end
end

--[[

  setDrawColorToRed()
  gfx.setfont(1, "Arial")       <-- default bitmap font does not support Unicode characters
  local degreeSymbolCharacter = 0x00B0  <-- this is the degree symbol for augmented chords,  "°"
  gfx.drawchar(degreeSymbolCharacter)

]]--
function activeMidiEditor()
  return reaper.MIDIEditor_GetActive()
end

function activeTake()
  return reaper.MIDIEditor_GetTake(activeMidiEditor())
end

function activeMediaItem()
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

function getMidiEndPositionPPQ()

  local noteLength = getNoteLengthQN()
  local startPosition = getCursorPositionQN()
  return reaper.MIDI_GetPPQPosFromProjQN(activeTake(), startPosition + noteLength)
end

function deselectAllNotes()

  local selectAllNotes = false
  reaper.MIDI_SelectAll(activeTake(), selectAllNotes)
end

function getCurrentNoteChannel()

  local activeMidiEditor = reaper.MIDIEditor_GetActive()

  if activeMidiEditor == nil then
    return 0
  end

  return reaper.MIDIEditor_GetSetting_int(activeMidiEditor, "default_note_chan")
end

function getCurrentVelocity()

  local activeMidiEditor = reaper.MIDIEditor_GetActive()

  if activeMidiEditor == nil then
    return 96
  end

  return reaper.MIDIEditor_GetSetting_int(activeMidiEditor, "default_note_vel")
end

function getNumberOfNotes()

  local _, numberOfNotes = reaper.MIDI_CountEvts(activeTake())
  return numberOfNotes
end

function deleteNote(noteIndex)

  reaper.MIDI_DeleteNote(activeTake(), noteIndex)
end

function thereAreNotesSelected()

  if activeTake() == nil then
    return false
  end

  local numberOfNotes = getNumberOfNotes()

  for noteIndex = 0, numberOfNotes-1 do

    local _, noteIsSelected = reaper.MIDI_GetNote(activeTake(), noteIndex)

    if noteIsSelected then
      return true
    end
  end

  return false
end

function multiplyGridSizeByOneHalf()
  reaper.Main_OnCommand(40212, 0)
end

function multiplyGridSizeByTwo()
  reaper.Main_OnCommand(40210, 0)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

function playMidiNote(midiNote)

  local virtualKeyboardMode = 0
  local channel = getCurrentNoteChannel()
  local noteOnCommand = 0x90 + channel
  local velocity = getCurrentVelocity()

  reaper.StuffMIDIMessage(virtualKeyboardMode, noteOnCommand, midiNote, velocity)
end

function stopAllNotesFromPlaying()

  for midiNote = 0, 127 do

    local virtualKeyboardMode = 0
    local channel = getCurrentNoteChannel()
    local noteOffCommand = 0x80 + channel
    local velocity = 0

    reaper.StuffMIDIMessage(virtualKeyboardMode, noteOffCommand, midiNote, velocity)
  end
end

function stopNoteFromPlaying(midiNote)

  local virtualKeyboardMode = 0
  local channel = getCurrentNoteChannel()
  local noteOffCommand = 0x80 + channel
  local velocity = 0

  reaper.StuffMIDIMessage(virtualKeyboardMode, noteOffCommand, midiNote, velocity)
end

function stopNotesFromPlaying()

  local notesThatArePlaying = getNotesThatArePlaying()

  for noteIndex = 1, #notesThatArePlaying do
    stopNoteFromPlaying(notesThatArePlaying[noteIndex])
  end

  setNotesThatArePlaying({})
end
inversionStates = {}

function updateInversionStates()

  inversionStates = {}

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if noteIsInScale(note) then

      if inversionStates[scaleNoteIndex] == nil then
        inversionStates[scaleNoteIndex] = {}
      end
      
      local chordCount = 0

      for k, chord in ipairs(chords) do

        if chordIsInScale(note, k) then
          chordCount = chordCount + 1

          if inversionStates[scaleNoteIndex][chordCount] == nil then
            inversionStates[scaleNoteIndex][chordCount] = 0
          end
        end
      end
    
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end

function setInversionState(inversionValue)

  local selectedScaleDegree = getSelectedScaleNote()
  local selectedChordTypeIndex = getSelectedChordType(selectedScaleDegree)
  
  if selectedScaleDegree == 1 then
    setSelectedInversionState1(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 2 then
    setSelectedInversionState2(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 3 then
    setSelectedInversionState3(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 4 then
    setSelectedInversionState4(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 5 then
    setSelectedInversionState5(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 6 then
    setSelectedInversionState6(selectedChordTypeIndex, inversionValue)
  end
  
  if selectedScaleDegree == 7 then
    setSelectedInversionState7(selectedChordTypeIndex, inversionValue)
  end
end

function getCurrentInversionValue()

  local selectedScaleDegree = getSelectedScaleNote()
  local selectedChordTypeIndex = getSelectedChordType(selectedScaleDegree)
  
  if selectedScaleDegree == 1 then
    return getSelectedInversionState1(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 2 then
    return getSelectedInversionState2(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 3 then
    return getSelectedInversionState3(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 4 then
    return getSelectedInversionState4(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 5 then
    return getSelectedInversionState5(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 6 then
    return getSelectedInversionState6(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 7 then
    return getSelectedInversionState7(selectedChordTypeIndex)
  end
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

function applyInversion(chord)
  
  local chordLength = #chord
  local chordInversionValue = getCurrentInversionValue()
  local chord_ = chord
  local oct = 0  
  
  if chordInversionValue < 0 then
    oct = math.floor(chordInversionValue / chordLength)
    chordInversionValue = chordInversionValue + (math.abs(oct) * chordLength)
  end
  
  for i = 1, chordInversionValue do
    local r = table.remove(chord_, 1)
    r = r + 12
    table.insert(chord_, #chord_ + 1, r )
  end
    
  for i = 1, #chord_ do
    chord_[i] = chord_[i] + (oct * 12)
  end

  return chord_
end

function getChordNotesArray(root, chord, octave)

  local chordLength = 0
  local chordNotesArray = {}
  local chordPattern = chord["pattern"]
  for n = 0, #chordPattern-1 do
    if chordPattern:sub(n+1, n+1) == '1' then
      chordLength = chordLength + 1
      
      local noteValue = root + n + ((octave+1) * 12) - 1
      table.insert(chordNotesArray, noteValue)
    end
  end
  
  chordNotesArray = applyInversion(chordNotesArray)
  
  return chordNotesArray
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

function insertMidiNote(note, keepNotesSelected)

	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getMidiEndPositionPPQ()

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake(), keepNotesSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

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
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local function insertChordImpl(keepNotesSelected)

  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)
  
  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)

  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note], keepNotesSelected)
  end

  updateChordText(root, chord, chordNotesArray)
  moveCursor()
end

function insertChordForSelection()
  insertChordImpl(true)
end

function insertChord()

  if thereAreNotesSelected() then 
    changeSelectedNotesToScaleChords()
  else
    insertChordImpl(false)
  end
end

local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


function playChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  local root = scaleNotes[scaleNoteIndex]
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   

  stopNotesFromPlaying()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

  setNotesThatArePlaying(chordNotesArray)

  updateChordText(root, chord, chordNotesArray)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

scaleNotes = {}
scaleChords = {}

scalePattern = nil

chordButtons = {}

function getNotesString(chordNotesArray)

  local notesString = ''
  for i, note in ipairs(chordNotesArray) do
        
    local noteName = getNoteName(note+1)
    
    if i ~= #chordNotesArray then
      notesString = notesString .. noteName .. ','
    else
      notesString = notesString .. noteName .. ''
    end
  end
  
  return notesString
end

--------------------------------------------------------------------------------

function updateScaleNotes()

  scaleNotes = {}

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if noteIsInScale(note) then
      scaleNotes[scaleNoteIndex] = note
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end

function updateScaleChords()

  scaleChords = {}

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if noteIsInScale(note) then
      scaleChords[scaleNoteIndex] = getScaleChordsForRootNote(note)
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end

function removeFlatsAndSharps(arg)
  return arg:gsub('b',''):gsub('#','')
end

function aNoteIsRepeated()

  local numberOfScaleNoteNames = 7
  local previousScaleNoteName = getScaleNoteName(numberOfScaleNoteNames)
  local scaleNoteName = nil

  for scaleDegree = 1,  numberOfScaleNoteNames do

    scaleNoteName = getScaleNoteName(scaleDegree)

    if removeFlatsAndSharps(scaleNoteName) == removeFlatsAndSharps(previousScaleNoteName) then
      return true
    end

    previousScaleNoteName = scaleNoteName
  end

  return false
end

function updateScaleNoteNames()
  
  local previousScaleNoteName = getSharpNoteName(getScaleTonicNote() + 11)
  local scaleNoteName = nil
  
  local scaleDegree = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
  
    if scalePattern[getNotesIndex(note)] then

      scaleNoteName = getSharpNoteName(note) 
      setScaleNoteName(scaleDegree, scaleNoteName)      
      scaleDegree = scaleDegree + 1
      previousScaleNoteName = scaleNoteName
    end
  end
  
  if aNoteIsRepeated() then
  
    local previousScaleNoteName = getFlatNoteName(getScaleTonicNote() + 11)
    local scaleNoteName = nil
    
    local scaleDegree = 1
    for note = getScaleTonicNote(), getScaleTonicNote() + 11 do
    
      if scalePattern[getNotesIndex(note)] then
            
        scaleNoteName = getFlatNoteName(note)        
        setScaleNoteName(scaleDegree, scaleNoteName)      
        scaleDegree = scaleDegree + 1
        previousScaleNoteName = scaleNoteName
      end
    end
  end
end

function updateScaleNotesText()
  
  local scaleNotesText = ''
  
  for i = 1, #scaleNotes do
    if scaleNotesText ~= '' then 
      scaleNotesText = scaleNotesText .. ', '
    end
    
    scaleNotesText = scaleNotesText .. getScaleNoteName(i)
  end

  setScaleNotesText(scaleNotesText)
end

function getChordInversionText(chordNotesArray)

  local inversionValue = getCurrentInversionValue()
  
  if inversionValue == 0 then
    return ''
  end
  
  if math.fmod(inversionValue, #chordNotesArray) == 0 then
    return ''
  end
    
  return '/' .. getNoteName(chordNotesArray[1]+1)
end

function getChordInversionOctaveIndicator(numberOfChordNotes)

  local inversionValue = getCurrentInversionValue()

  local octaveIndicator = nil
   
  if inversionValue > 0 then
  
    local offsetValue = math.floor(inversionValue / numberOfChordNotes)
    
    if offsetValue > 0 then
      return '+' .. offsetValue
    else
      return '+'
    end
  
  elseif inversionValue < 0 then
  
    local offsetValue = math.abs(math.ceil(inversionValue / numberOfChordNotes))
    
    if offsetValue > 0 then
      return '-' .. offsetValue
    else  
      return '-'
    end
  else
    return ''
  end  
end

function updateChordText(root, chord, chordNotesArray)
  
  local rootNoteName = getNoteName(root)
  local chordInversionText = getChordInversionText(chordNotesArray)
  local chordInversionOctaveIndicator = getChordInversionOctaveIndicator(#chordNotesArray)
  local chordString = rootNoteName .. chord["display"]
  local notesString = getNotesString(chordNotesArray)

  local chordTextValue = ''
  if string.match(chordInversionOctaveIndicator, "-") then
    chordTextValue = ("%s%12s%s%12s"):format(chordInversionOctaveIndicator, chordString, chordInversionText, notesString)
  elseif string.match(chordInversionOctaveIndicator, "+") then
    chordTextValue = ("%s%12s%s%12s%12s"):format('', chordString, chordInversionText, notesString, chordInversionOctaveIndicator)
  else
    chordTextValue = ("%s%12s%s%12s"):format('', chordString, chordInversionText, notesString)
  end

  setChordText(chordTextValue)
  
  showChordText()
end

function showChordText()

  local chordText = getChordText()
  reaper.Help_Set(chordText, false)
end

function updateScaleData()

  scalePattern = getScalePattern(getScaleTonicNote(), scales[getScaleType()])
  updateScaleNotes()
  updateScaleNoteNames()
  updateScaleNotesText()
  updateScaleChords()
  updateScaleDegreeHeaders()
end

function showScaleStatus()

  local scaleTonicText =  notes[getScaleTonicNote()]
  local scaleTypeText = scales[getScaleType()].name
  local scaleNotesText = getScaleNotesText()
  reaper.Help_Set(("%s %s: %s"):format(scaleTonicText, scaleTypeText, scaleNotesText), false)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local function transposeSelectedNotes(numberOfSemitones)

  local numberOfNotes = getNumberOfNotes()

  for noteIndex = numberOfNotes-1, 0, -1 do

    local _, noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ, channel, pitch, velocity = reaper.MIDI_GetNote(activeTake(), noteIndex)
  
    if noteIsSelected then
      deleteNote(noteIndex)
      local noSort = false
      reaper.MIDI_InsertNote(activeTake(), noteIsSelected, noteIsMuted, noteStartPositionPPQ, noteEndPositionPPQ, channel, pitch+numberOfSemitones, velocity, noSort)
    end
  end
end

function transposeSelectedNotesUpOneOctave()
  transposeSelectedNotes(12)
end

function transposeSelectedNotesDownOneOctave()
  transposeSelectedNotes(-12)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


local function insertScaleNoteImplImpl(octaveAdjustment, keepNotesSelected)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  insertMidiNote(noteValue, keepNotesSelected)
  moveCursor()
end

function insertScaleNoteForSelection(octaveAdjustment)
	insertScaleNoteImplImpl(octaveAdjustment, true)
end

local function insertScaleNoteImpl(octaveAdjustment)

  if thereAreNotesSelected() then 
    changeSelectedNotesToScaleNotes(octaveAdjustment)
  else
    insertScaleNoteImplImpl(octaveAdjustment, false)
  end
end

function insertLowerScaleNote()

	if getOctave() < 0 then
		return
	end

	insertScaleNoteImpl(-1)
end

function insertScaleNote()
  insertScaleNoteImpl(0)
end

function insertHigherScaleNote()

	if getOctave() > 7 then
		return
	end

	insertScaleNoteImpl(1)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


local function playScaleNoteImpl(octaveAdjustment)

  local scaleNoteIndex = getSelectedScaleNote()

  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  local noteValue = root + ((octave+1+octaveAdjustment) * 12) - 1

  stopNotesFromPlaying()
  playMidiNote(noteValue)
  setNotesThatArePlaying({noteValue})
  setChordText("")

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
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


local function decrementChordInversion()

  local chordInversionMin = getChordInversionMin()
  local chordInversion = getCurrentInversionValue()

  if chordInversion <= chordInversionMin then
    return
  end

  setInversionState(chordInversion-1)
end

function decrementChordInversionAction()

	decrementChordInversion()

	if thereAreNotesSelected() then
		insertChord()
	end

	playChord()
end

--

local function incrementChordInversion()

  local chordInversionMax = getChordInversionMax()
  local chordInversion = getCurrentInversionValue()

  if chordInversion >= chordInversionMax then
    return
  end

  setInversionState(chordInversion+1)
end

function incrementChordInversionAction()

	incrementChordInversion()

	if thereAreNotesSelected() then
		insertChord()
	end
	
	playChord()
end


--

local function decrementChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(selectedScaleNote)

  if selectedChordType <= 1 then
    return
  end

  setSelectedChordType(selectedScaleNote, selectedChordType-1)
end

function decrementChordTypeAction()

	decrementChordType()

	if thereAreNotesSelected() then
		insertChord()
	end

	playChord()
end

--

local function incrementChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(selectedScaleNote)

  if selectedChordType >= #chords then
    return
  end

  setSelectedChordType(selectedScaleNote, selectedChordType+1)
end

function incrementChordTypeAction()

	incrementChordType()

	if thereAreNotesSelected() then
		insertChord()
	end

	playChord()
end

--

local function decrementOctave()

  local octave = getOctave()

  if octave <= -1 then
    return
  end

  setOctave(octave-1)
end

function decrementOctaveAction()

	decrementOctave()

	if thereAreNotesSelected() then
		transposeSelectedNotesDownOneOctave()
	else
		playTonicNote()
	end
end

--

local function incrementOctave()

  local octave = getOctave()

  if octave >= 8 then
    return
  end

  setOctave(octave+1)
end

function incrementOctaveAction()

	incrementOctave()

	if thereAreNotesSelected() then
		transposeSelectedNotesUpOneOctave()
	else
		playTonicNote()
	end	
end

--

local function decrementScaleTonicNote()

	local scaleTonicNote = getScaleTonicNote()

	if scaleTonicNote <= 1 then
		return
	end

	setScaleTonicNote(scaleTonicNote-1)
end

function decrementScaleTonicNoteAction()

	decrementScaleTonicNote()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function incrementScaleTonicNote()

	local scaleTonicNote = getScaleTonicNote()

	if scaleTonicNote >= #notes then
		return
	end

	setScaleTonicNote(scaleTonicNote+1)
end

function incrementScaleTonicNoteAction()

	incrementScaleTonicNote()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function decrementScaleType()

	local scaleType = getScaleType()

	if scaleType <= 1 then
		return
	end

	setScaleType(scaleType-1)
	
end

function decrementScaleTypeAction()

	decrementScaleType()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function incrementScaleType()

	local scaleType = getScaleType()

	if scaleType >= #scales then
		return
	end

	setScaleType(scaleType+1)
end

function incrementScaleTypeAction()

	incrementScaleType()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

function insertScaleChord1Action()

	setSelectedScaleNote(1)
	insertChord()
	playChord()
end

--

function insertScaleChord2Action()

	setSelectedScaleNote(2)
	insertChord()
	playChord()
end

--

function insertScaleChord3Action()

	setSelectedScaleNote(3)
	insertChord()
	playChord()
end

--

function insertScaleChord4Action()

	setSelectedScaleNote(4)
	insertChord()
	playChord()
end

--

function insertScaleChord5Action()

	setSelectedScaleNote(5)
	insertChord()
	playChord()
end

--

function insertScaleChord6Action()

	setSelectedScaleNote(6)
	insertChord()
	playChord()
end

--

function insertScaleChord7Action()

	setSelectedScaleNote(7)
	playChord()
	insertChord()
end

--

function playScaleChord1Action()

	setSelectedScaleNote(1)
	playChord()
end

--

function playScaleChord2Action()

	setSelectedScaleNote(2)
	playChord()
end

--

function playScaleChord3Action()

	setSelectedScaleNote(3)
	playChord()
end

--

function playScaleChord4Action()

	setSelectedScaleNote(4)
	playChord()
end

--

function playScaleChord5Action()

	setSelectedScaleNote(5)
	playChord()
end

--

function playScaleChord6Action()

	setSelectedScaleNote(6)
	playChord()
end

--

function playScaleChord7Action()

	setSelectedScaleNote(7)
	playChord()
end

--

function playScaleNote1Action()

	setSelectedScaleNote(1)
	return playScaleNote()
end

--

function playScaleNote2Action()

	setSelectedScaleNote(2)
	return playScaleNote()
end

--

function playScaleNote3Action()

	setSelectedScaleNote(3)
	return playScaleNote()
end

--

function playScaleNote4Action()

	setSelectedScaleNote(4)
	return playScaleNote()
end

--

function playScaleNote5Action()

	setSelectedScaleNote(5)
	return playScaleNote()
end

--

function playScaleNote6Action()

	setSelectedScaleNote(6)
	return playScaleNote()
end

--

function playScaleNote7Action()

	setSelectedScaleNote(7)
	return playScaleNote()
end

--

function playLowerScaleNote1Action()

	setSelectedScaleNote(1)
	return playLowerScaleNote()
end

--

function playLowerScaleNote2Action()

	setSelectedScaleNote(2)
	return playLowerScaleNote()
end

--

function playLowerScaleNote3Action()

	setSelectedScaleNote(3)
	return playLowerScaleNote()
end

--

function playLowerScaleNote4Action()

	setSelectedScaleNote(4)
	return playLowerScaleNote()
end

--

function playLowerScaleNote5Action()

	setSelectedScaleNote(5)
	return playLowerScaleNote()
end

--

function playLowerScaleNote6Action()

	setSelectedScaleNote(6)
	return playLowerScaleNote()
end

--

function playLowerScaleNote7Action()

	setSelectedScaleNote(7)
	return playLowerScaleNote()
end

--

function playHigherScaleNote1Action()

	setSelectedScaleNote(1)
	return playHigherScaleNote()
end

--

function playHigherScaleNote2Action()

	setSelectedScaleNote(2)
	return playHigherScaleNote()
end

--

function playHigherScaleNote3Action()

	setSelectedScaleNote(3)
	return playHigherScaleNote()
end

--

function playHigherScaleNote4Action()

	setSelectedScaleNote(4)
	return playHigherScaleNote()
end

--

function playHigherScaleNote5Action()

	setSelectedScaleNote(5)
	return playHigherScaleNote()
end

--

function playHigherScaleNote6Action()

	setSelectedScaleNote(6)
	return playHigherScaleNote()
end

--

function playHigherScaleNote7Action()

	setSelectedScaleNote(7)
	return playHigherScaleNote()
end

--

function insertScaleNote1Action()

	setSelectedScaleNote(1)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote2Action()

	setSelectedScaleNote(2)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote3Action()

	setSelectedScaleNote(3)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote4Action()

	setSelectedScaleNote(4)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote5Action()

	setSelectedScaleNote(5)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote6Action()

	setSelectedScaleNote(6)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote7Action()

	setSelectedScaleNote(7)
	insertScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote1Action()

	setSelectedScaleNote(1)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote2Action()

	setSelectedScaleNote(2)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote3Action()

	setSelectedScaleNote(3)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote4Action()

	setSelectedScaleNote(4)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote5Action()

	setSelectedScaleNote(5)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote6Action()

	setSelectedScaleNote(6)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote7Action()

	setSelectedScaleNote(7)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote1Action()

	setSelectedScaleNote(1)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote2Action()

	setSelectedScaleNote(2)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote3Action()

	setSelectedScaleNote(3)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote4Action()

	setSelectedScaleNote(4)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote5Action()

	setSelectedScaleNote(5)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote6Action()

	setSelectedScaleNote(6)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote7Action()

	setSelectedScaleNote(7)
	insertHigherScaleNote()
	playScaleNote()
end

--
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


updateScaleData()
insertLowerScaleNote1Action()
