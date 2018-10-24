function mouseIsHoveringOver(element)

	local x = gfx.mouse_x
	local y = gfx.mouse_y

	local isInHorizontalRegion = (x >= element.x and x < element.x+element.width)
	local isInVerticalRegion = (y >= element.y and y < element.y+element.height)
	return isInHorizontalRegion and isInVerticalRegion
end

function leftMouseButtonIsHeldDown()
  return gfx.mouse_cap & 1 == 1
end

function leftMouseButtonIsNotHeldDown()
  return gfx.mouse_cap & 1 ~= 1
end

function clearConsoleWindow()
  reaper.ShowConsoleMsg("")
end

function print(arg)
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
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

local numberOfSecondsForChordPreview = 5
chordPreviewTimer = Timer:new(numberOfSecondsForChordPreview)
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
    setSelectedInversionState1(0)
    setSelectedInversionState2(0)
    setSelectedInversionState3(0)
    setSelectedInversionState4(0)
    setSelectedInversionState5(0)
    setSelectedInversionState6(0)
    setSelectedInversionState7(0)
  end
end
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

function insertNotesFromChordArray(chordNotesArray)

  local noteColumnIndex = renoise.song().selected_note_column_index
  for note = 1, #chordNotesArray do
    insertNote(chordNotesArray[note], noteColumnIndex)
    noteColumnIndex = noteColumnIndex + 1
  end
  
  local visibleNoteColumns = renoise.song().selected_track.visible_note_columns
      
  if visibleNoteColumns >= noteColumnIndex then
    for i = noteColumnIndex, visibleNoteColumns do
      local noteColumn = renoise.song().selected_line:note_column(i)
      
      if preferences.insertNoteOffInRemainingNoteColumns.value then
        noteColumn.note_value = 120
      else
        noteColumn.note_value = 121
      end
  
      noteColumn.instrument_value = 255
    end
  end
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

function getCursorPositionPPQ()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

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

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)
	local gridLen, _, noteLen = reaper.MIDI_GetGrid(activeTake)
	
	local noteLength = gridLen

	if noteLen ~= 0 then
		noteLength = noteLen
	end

	return noteLength
end

local function getEndPosition()

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

	local noteLength = getNoteLength()
	local startPosition = getCursorPositionQN(activeTake)
	local endPosition = reaper.MIDI_GetPPQPosFromProjQN(activeTake, startPosition + noteLength)

	return endPosition
end

function insertMidiNote(note)

	local activeMidiEditor = reaper.MIDIEditor_GetActive()
	local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)
	local noteIsSelected = false
	local noteIsMuted = false
	local startPosition = getCursorPositionPPQ()
	local endPosition = getEndPosition()

	local channel = getCurrentNoteChannel()
	local velocity = getCurrentVelocity()
	local noSort = false

	reaper.MIDI_InsertNote(activeTake, noteIsSelected, noteIsMuted, startPosition, endPosition, channel, note, velocity, noSort)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local function moveCursor()
  
  local activeMidiEditor = reaper.MIDIEditor_GetActive()
  local activeTake = reaper.MIDIEditor_GetTake(activeMidiEditor)

  local noteLengthQN = getNoteLength()
  local noteLengthPPQ = reaper.MIDI_GetPPQPosFromProjQN(activeTake, noteLengthQN)
  local noteLength = reaper.MIDI_GetProjTimeFromPPQPos(activeTake, noteLengthPPQ)

  local timeSelection = false
  reaper.MoveEditCursor(noteLength, timeSelection)
end

function insertChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)
  
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local root = scaleNotes[scaleNoteIndex]
  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   
  
  for note = 1, #chordNotesArray do
    insertMidiNote(chordNotesArray[note])
  end

  updateChordText(root, chord, chordNotesArray)
  moveCursor()
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


function previewChord()
  
  local scaleNoteIndex = getSelectedScaleNote()
  local chordTypeIndex = getSelectedChordType(scaleNoteIndex)

  stopAllNotesFromPlaying()
  
  local chord = scaleChords[scaleNoteIndex][chordTypeIndex]
  local root = scaleNotes[scaleNoteIndex]

  local octave = getOctave()
  
  local chordNotesArray = getChordNotesArray(root, chord, octave)   

  chordPreviewTimer:start()
  
  for note = 1, #chordNotesArray do
    playMidiNote(chordNotesArray[note])
  end

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
  showScaleStatus()
end

function showScaleStatus()

  local scaleTonicText =  notes[getScaleTonicNote()]
  local scaleTypeText = scales[getScaleType()].name
  local scaleNotesText = getScaleNotesText()
  reaper.Help_Set(("%s %s: %s"):format(scaleTonicText, scaleTypeText, scaleNotesText), false)
end
local function hex2rgb(arg) 

	local r, g, b = arg:match('(..)(..)(..)')
	r = tonumber(r, 16)/255
	g = tonumber(g, 16)/255
	b = tonumber(b, 16)/255
	return r, g, b
end

local function setColor(hexColor)

	local r, g, b = hex2rgb(hexColor)
	gfx.set(r, g, b, 1)
end

--[[ window ]]--

function setDrawColorToBackground()
	setColor("242424")
end

--[[ buttons ]]--

function setDrawColorToNormalButton()
	setColor("2D2D2D")
end

function setDrawColorToHighlightedButton()
	setColor("474747")
end

--

function setDrawColorToSelectedChordTypeButton()
	setColor("474747")
end

function setDrawColorToHighlightedSelectedChordTypeButton()
	setColor("717171")
end

--

function setDrawColorToSelectedChordTypeAndScaleNoteButton()
	setColor("DCDCDC")
end

function setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButton()
	setColor("FFFFFF")
end

--

function setDrawColorToOutOfScaleButton()
	setColor("121212")
end

function setDrawColorToHighlightedOutOfScaleButton()
	setColor("474747")
end

--

function setDrawColorToButtonOutline()
	setColor("1D1D1D")
end

--[[ button text ]]--

function setDrawColorToNormalButtonText()
	setColor("D7D7D7")
end

function setDrawColorToHighlightedButtonText()
	setColor("EEEEEE")
end

--

function setDrawColorToSelectedChordTypeButtonText()
	setColor("F1F1F1")
end

function setDrawColorToHighlightedSelectedChordTypeButtonText()
	setColor("FDFDFD")
end

--

function setDrawColorToSelectedChordTypeAndScaleNoteButtonText()
	setColor("121212")
end

function setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButtonText()
	setColor("000000")
end

--[[ buttons ]]--

function setDrawColorToHeaderOutline()
	setColor("151515")
end

function setDrawColorToHeaderBackground()
	setColor("242424")
end

function setDrawColorToHeaderText()
	setColor("818181")
end


--[[ frame ]]--
function setDrawColorToFrameOutline()
	setColor("0D0D0D")
end

function setDrawColorToFrameBackground()
	setColor("181818")
end


--[[ dropdown ]]--
function setDrawColorToDropdownOutline()
	setColor("090909")
end

function setDrawColorToDropdownBackground()
	setColor("1D1D1D")
end

function setDrawColorToDropdownText()
	setColor("D7D7D7")
end

--[[ valuebox ]]--
function setDrawColorToValueBoxOutline()
	setColor("090909")
end

function setDrawColorToValueBoxBackground()
	setColor("161616")
end

function setDrawColorToValueBoxText()
	setColor("9F9F9F")
end


--[[ text ]]--
function setDrawColorToText()
	setColor("878787")
end


--[[ debug ]]--

function setDrawColorToRed()
	setColor("FF0000")
end





--[[
function setDrawColorToBackground()

	local r, g, b
	local backgroundColor = {36, 36, 36, 1}		-- #242424
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToNormalButton()

	local backgroundColor = {45, 45, 45, 1}		-- #2D2D2D
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToHighlightedButton()

	local backgroundColor = {71, 71, 71, 1}		-- #474747
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToSelectedButton()

	local backgroundColor = {220, 220, 220, 1}	-- #DCDCDC
	gfx.set(table.unpack(backgroundColor))
end
]]--
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

OctaveValueBox = {}
OctaveValueBox.__index = OctaveValueBox

function OctaveValueBox:new(x, y, width, height)

  local self = {}
  setmetatable(self, OctaveValueBox)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function OctaveValueBox:drawRectangle()

    setDrawColorToValueBoxBackground()
    gfx.rect(self.x, self.y, self.width, self.height)
end

function OctaveValueBox:drawRectangleOutline()

    setDrawColorToValueBoxOutline()
    gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function OctaveValueBox:drawRectangles()

  self:drawRectangle()
  self:drawRectangleOutline() 
end

function OctaveValueBox:drawLeftArrow()

  local imagePath = workingDirectory .. "/interface/leftArrow.png"
  gfx.x = self.x + 2
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function OctaveValueBox:drawRightArrow()

  local imagePath = workingDirectory .. "/interface/rightArrow.png"
  local imageWidth = 9
  gfx.x = self.x + self.width - imageWidth - 3
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function OctaveValueBox:drawImages()
  self:drawLeftArrow()
  self:drawRightArrow()
end

function OctaveValueBox:drawText()

  local octaveText = getOctave()

	setDrawColorToValueBoxText()
	local stringWidth, stringHeight = gfx.measurestr(octaveText)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(octaveText)
end

HitArea = {}
HitArea.__index = HitArea
function HitArea:new(x, y, width, height)
  local self = {}
  setmetatable(self, HitArea)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

local hitAreaWidth = 18

local function leftButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x-1, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

local function rightButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x+valueBox.width-hitAreaWidth, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

local function decrementOctave()

  local octave = getOctave()

  if octave <= -1 then
    return
  end

  setOctave(octave-1)
end

local function incrementOctave()

  local octave = getOctave()

  if octave >= 8 then
    return
  end

  setOctave(octave+1)
end

function OctaveValueBox:update()

  self:drawRectangles()
  self:drawImages()

  if mouseButtonIsNotPressedDown and leftButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    decrementOctave()
  end

  if mouseButtonIsNotPressedDown and rightButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    incrementOctave()
  end

  self:drawText()
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

Label = {}
Label.__index = Label

function Label:new(x, y, width, height, getTextCallback)

  local self = {}
  setmetatable(self, Label)

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.getTextCallback = getTextCallback

  return self
end

function Label:drawRedOutline()
  setDrawColorToRed()
  gfx.rect(self.x, self.y, self.width, self.height, false)
end

function Label:drawText(text)

	setDrawColorToText()
	local stringWidth, stringHeight = gfx.measurestr(text)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
  gfx.drawstr(text)
end

function Label:update()
  --self:drawRedOutline()

  local text = self.getTextCallback()
  self:drawText(text)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

Header = {}
Header.__index = Header

local radius = 5

function Header:new(x, y, width, height, getTextCallback)

  local self = {}
  setmetatable(self, Header)

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.getTextCallback = getTextCallback

  return self
end

function Header:drawCorners(offset)
  gfx.circle(self.x + radius + offset, self.y + radius + offset, radius, true)
  gfx.circle(self.x + self.width - radius - offset, self.y + radius + offset, radius, true)
end

function Header:drawEnds(offset)
  gfx.rect(self.x + offset, self.y + radius + offset, radius, self.height - radius * 2 - 2 * offset, true)
  gfx.rect(self.x + self.width - radius - offset, self.y + radius + offset, radius + 1, self.height - radius * 2 - 2 * offset, true)
end

function Header:drawBodyAndSides(offset)
  gfx.rect(self.x + radius + offset, self.y + offset, self.width - radius * 2 - 2 * offset, self.height - radius - 2 * offset, true)
end

function Header:drawHeaderOutline()

  setDrawColorToHeaderOutline()
  self:drawCorners(0)
  self:drawEnds(0)
  self:drawBodyAndSides(0)
end

function Header:drawRoundedRectangle()

  setDrawColorToHeaderBackground()
  self:drawCorners(1)
  self:drawEnds(1)
  self:drawBodyAndSides(1)
end

function Header:drawRoundedRectangles()
  
  self:drawHeaderOutline()
  self:drawRoundedRectangle()
end

function Header:drawText(text)

    setDrawColorToHeaderText()
    local stringWidth, stringHeight = gfx.measurestr(text)
    gfx.x = self.x + ((self.width + 4 * 1 - stringWidth) / 2)
    gfx.y = self.y + ((self.height - 4 * 1 - stringHeight) / 2)
    gfx.drawstr(text)
end

function Header:update()

    self:drawRoundedRectangles()

    local text = self.getTextCallback()
    self:drawText(text)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

Frame = {}
Frame.__index = Frame

local radius = 10

function Frame:new(x, y, width, height)

  local self = {}
  setmetatable(self, Frame)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Frame:drawCorners(offset)
  gfx.circle(self.x + radius + offset, self.y + radius + offset, radius, true)
  gfx.circle(self.x + self.width - radius - offset, self.y + radius + offset, radius, true)
  gfx.circle(self.x + radius + offset, self.y + self.height - radius - offset, radius, true)
  gfx.circle(self.x + self.width - radius - offset, self.y + self.height - radius - offset, radius, true)
end

function Frame:drawEnds(offset)
  gfx.rect(self.x + offset, self.y + radius + offset, radius, self.height - radius * 2, true)
  gfx.rect(self.x + self.width - radius - offset, self.y + radius - offset, radius + 1, self.height - radius * 2, true)
end

function Frame:drawBodyAndSides(offset)
  gfx.rect(self.x + radius + offset, self.y + offset, self.width - radius * 2 - 2 * offset, self.height + 1 - 2 * offset, true)
end

function Frame:drawFrameOutline()

  setDrawColorToFrameOutline()
  self:drawCorners(0)
  self:drawEnds(0)
  self:drawBodyAndSides(0)
end

function Frame:drawRectangle()

  setDrawColorToFrameBackground()
  self:drawCorners(1)
  self:drawEnds(1)
  self:drawBodyAndSides(1)
end

function Frame:drawRectangles()
  
  self:drawFrameOutline()
  self:drawRectangle()
end

function Frame:update()

    self:drawRectangles()
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:new(x, y, width, height, options, defaultOptionIndex, onSelectionCallback)

  local self = {}
  setmetatable(self, Dropdown)

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.options = options
  self.selectedIndex = defaultOptionIndex
  self.onSelectionCallback = onSelectionCallback
  self.dropdownList = {}
  self:updateDropdownList()
  return self
end

function Dropdown:drawRectangle()

		setDrawColorToDropdownBackground()
		gfx.rect(self.x, self.y, self.width, self.height)
end

function Dropdown:drawRectangleOutline()

		setDrawColorToDropdownOutline()
		gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function Dropdown:drawRectangles()

	self:drawRectangle()
	self:drawRectangleOutline()	
end

function Dropdown:drawText()

	local text = self.options[self.selectedIndex]

	setDrawColorToDropdownText()
	local stringWidth, stringHeight = gfx.measurestr(text)
	gfx.x = self.x + 7
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(text)
end

function Dropdown:drawImage()

	local imagePath = workingDirectory .. "/interface/dropdownIcon.png"
	local imageWidth = 14
	gfx.x = self.x + self.width - imageWidth - 1
	gfx.y = self.y
	local imageIndex = gfx.loadimg(0, imagePath)
	gfx.blit(imageIndex, 1.0, 0.0)
end

local function dropdownHasBeenClicked(dropdown)
	return mouseIsHoveringOver(dropdown) and leftMouseButtonIsHeldDown()
end

function Dropdown:updateDropdownList()

	self.dropdownList = {}

	for index, option in pairs(self.options) do

		if (self.selectedIndex == index) then
			table.insert(self.dropdownList, "!" .. option)
		else
			table.insert(self.dropdownList, option)
		end
	end
end

function Dropdown:openMenu()

	local selectedIndex = gfx.showmenu(table.concat(self.dropdownList,"|"))

	if selectedIndex <= 0 then
		return
	end

	self.selectedIndex = selectedIndex
	self.onSelectionCallback(selectedIndex)
	self:updateDropdownList()
end

function Dropdown:update()

		self:drawRectangles()
		self:drawText()
		self:drawImage()
		
		if mouseButtonIsNotPressedDown and dropdownHasBeenClicked(self) then
			mouseButtonIsNotPressedDown = false
			self:openMenu()
		end
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

ChordInversionValueBox = {}
ChordInversionValueBox.__index = ChordInversionValueBox

function ChordInversionValueBox:new(x, y, width, height)

  local self = {}
  setmetatable(self, ChordInversionValueBox)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function ChordInversionValueBox:drawRectangle()

    setDrawColorToValueBoxBackground()
    gfx.rect(self.x, self.y, self.width, self.height)
end

function ChordInversionValueBox:drawRectangleOutline()

    setDrawColorToValueBoxOutline()
    gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function ChordInversionValueBox:drawRectangles()

  self:drawRectangle()
  self:drawRectangleOutline() 
end

function ChordInversionValueBox:drawLeftArrow()

  local imagePath = workingDirectory .. "/interface/leftArrow.png"
  gfx.x = self.x + 2
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function ChordInversionValueBox:drawRightArrow()

  local imagePath = workingDirectory .. "/interface/rightArrow.png"
  local imageWidth = 9
  gfx.x = self.x + self.width - imageWidth - 3
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function ChordInversionValueBox:drawImages()
  self:drawLeftArrow()
  self:drawRightArrow()
end

function ChordInversionValueBox:drawText()

  local chordInversionText = getCurrentInversionValue()

  if chordInversionText > -1 then
    chordInversionText = "0" .. chordInversionText
  end

	setDrawColorToValueBoxText()
	local stringWidth, stringHeight = gfx.measurestr(chordInversionText)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(chordInversionText)
end

HitArea = {}
HitArea.__index = HitArea
function HitArea:new(x, y, width, height)
  local self = {}
  setmetatable(self, HitArea)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

local hitAreaWidth = 18

local function leftButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x-1, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

local function rightButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x+valueBox.width-hitAreaWidth, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

local function decrementChordInversion()

  local chordInversionMin = getChordInversionMin()
  local chordInversion = getCurrentInversionValue()

  if chordInversion <= chordInversionMin then
    return
  end

  setInversionState(chordInversion-1)
end

local function incrementChordInversion()

  local chordInversionMax = getChordInversionMax()
  local chordInversion = getCurrentInversionValue()

  if chordInversion >= chordInversionMax then
    return
  end

  setInversionState(chordInversion+1)
end

function ChordInversionValueBox:update()

  self:drawRectangles()
  self:drawImages()

  if mouseButtonIsNotPressedDown and leftButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    decrementChordInversion()
    previewChord()
  end

  if mouseButtonIsNotPressedDown and rightButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    incrementChordInversion()
    previewChord()
  end

  self:drawText()
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
--require(workingDirectory .. "/insertMidiNote")

ChordButton = {}
ChordButton.__index = ChordButton

function ChordButton:new(text, x, y, width, height, scaleNoteIndex, chordTypeIndex, chordIsInScale)

  local self = {}
  setmetatable(self, ChordButton)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.scaleNoteIndex = scaleNoteIndex
  self.chordTypeIndex = chordTypeIndex
  self.chordIsInScale = chordIsInScale

  return self
end

function ChordButton:isSelectedChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(self.scaleNoteIndex)

	local chordTypeIsSelected = (tonumber(self.chordTypeIndex) == tonumber(selectedChordType))
	local scaleNoteIsNotSelected = (tonumber(self.scaleNoteIndex) ~= tonumber(selectedScaleNote))

	return chordTypeIsSelected and scaleNoteIsNotSelected
end

function ChordButton:isSelectedChordTypeAndSelectedScaleNote()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(self.scaleNoteIndex)

	local chordTypeIsSelected = (tonumber(self.chordTypeIndex) == tonumber(selectedChordType))
	local scaleNoteIsSelected = (tonumber(self.scaleNoteIndex) == tonumber(selectedScaleNote))

	return chordTypeIsSelected and scaleNoteIsSelected
end


function ChordButton:drawButtonRectangle()

		if self:isSelectedChordTypeAndSelectedScaleNote() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButton()
			else
				setDrawColorToSelectedChordTypeAndScaleNoteButton()
			end

		elseif self:isSelectedChordType() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeButton()
			else
				setDrawColorToSelectedChordTypeButton()
			end

		else

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedButton()
			else

				if self.chordIsInScale then
					setDrawColorToNormalButton()
				else
					setDrawColorToOutOfScaleButton()
				end			
			end
		end

		gfx.rect(self.x, self.y, self.width, self.height)
end

function ChordButton:drawButtonOutline()

		setDrawColorToButtonOutline()
		gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function ChordButton:drawRectangles()

	self:drawButtonRectangle()
	self:drawButtonOutline()	
end

function ChordButton:drawText()

	if self:isSelectedChordTypeAndSelectedScaleNote() then

		if mouseIsHoveringOver(self) then
			setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButtonText()
		else
			setDrawColorToSelectedChordTypeAndScaleNoteButtonText()
		end

	elseif self:isSelectedChordType() then

		if mouseIsHoveringOver(self) then
			setDrawColorToHighlightedSelectedChordTypeButtonText()
		else
			setDrawColorToSelectedChordTypeButtonText()
		end

	else

		if mouseIsHoveringOver(self) then
			setDrawColorToHighlightedButtonText()
		else
			setDrawColorToNormalButtonText()
		end
	end

	local stringWidth, stringHeight = gfx.measurestr(self.text)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(self.text)
end

local function buttonHasBeenClicked(button)
	return mouseIsHoveringOver(button) and leftMouseButtonIsHeldDown()
end

local function shiftModifierIsHeldDown()
	return gfx.mouse_cap & 8 == 8
end

function ChordButton:onPress()
	previewChord()
end

function ChordButton:onShiftPress()
	previewChord()
	insertChord()
end

function ChordButton:update()

		self:drawRectangles()
		self:drawText()

		if mouseButtonIsNotPressedDown and buttonHasBeenClicked(self) then

			setSelectedScaleNote(self.scaleNoteIndex)
			setSelectedChordType(self.scaleNoteIndex, self.chordTypeIndex)

			mouseButtonIsNotPressedDown = false

			if shiftModifierIsHeldDown() then
				self:onShiftPress()
			else
				self:onPress()
			end
		end
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

Interface = {}
Interface.__index = Interface

function Interface:init(name, x, y, width, height)

  local self = {}
  setmetatable(self, Interface)

  self.name = name
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.elements = {}

  return self
end

function Interface:restartGui()
	self.elements = {}
	self:startGui()
end

function Interface:startGui()
	self:addMainWindow()
	self:addTopFrame()
	self:addBottomFrame()	
end

function Interface:addMainWindow()

	gfx.clear = reaper.ColorToNative(36, 36, 36)
	local dockState = 0
	gfx.init(self.name, self.width, self.height, dockState, self.x, self.y)
end

function Interface:addChordButton(buttonText, x, y, width, height, scaleNoteIndex, chordTypeIndex, chordIsInScale)

	local chordButton = ChordButton:new(buttonText, x, y, width, height, scaleNoteIndex, chordTypeIndex, chordIsInScale)
	table.insert(self.elements, chordButton)
end

function Interface:addHeader(headerText, x, y, width, height, getTextCallback)

	local header = Header:new(headerText, x, y, width, height, getTextCallback)
	table.insert(self.elements, header)
end

function Interface:addFrame(x, y, width, height)

	local frame = Frame:new(x, y, width, height)
	table.insert(self.elements, frame)
end

function Interface:addLabel(x, y, width, height, getTextCallback)

	local label = Label:new(x, y, width, height, getTextCallback)
	table.insert(self.elements, label)
end

function Interface:addDropdown(x, y, width, height, options, defaultOptionIndex, onSelectionCallback)

	local dropdown = Dropdown:new(x, y, width, height, options, defaultOptionIndex, onSelectionCallback)
	table.insert(self.elements, dropdown)
end

function Interface:addChordInversionValueBox(x, y, width, height)

	local valueBox = ChordInversionValueBox:new(x, y, width, height)
	table.insert(self.elements, valueBox)
end

function Interface:addOctaveValueBox(x, y, width, height)

	local valueBox = OctaveValueBox:new(x, y, width, height)
	table.insert(self.elements, valueBox)
end

function Interface:updateElements()

	for _, element in pairs(self.elements) do
		element:update()
	end
end

function Interface:update()

	self:updateElements()

	if not mouseButtonIsNotPressedDown and leftMouseButtonIsNotHeldDown() then
		mouseButtonIsNotPressedDown = true
	end

	if chordPreviewTimer:timeHasElapsed() then
		stopAllNotesFromPlaying()
		chordPreviewTimer:stop()
	end

	gfx.update()
end

local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local windowWidth = 775

scaleNames = {}
for key, scale in ipairs(scales) do
  table.insert(scaleNames, scale['name'])
end

local xMargin = 8
local yMargin = 8
local xPadding = 16
local yPadding = 5

local scaleLabelWidth = nil
local horizontalMargin = 8

local scaleTonicNoteWidth = 50
local scaleTypeWidth = 150

local octaveLabelWidth = nil
local octaveValueBoxWidth = 55

keySelectionFrameHeight = 25
function Interface:addTopFrame()

	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, keySelectionFrameHeight)
	self:addScaleLabel()
	self:addScaleTonicNoteDropdown()
	self:addScaleTypeDropdown()
	self:addScaleNotesTextLabel()
	self:addOctaveLabel()
	self:addOctaveSelectorValueBox()
end

function Interface:addScaleLabel()

	local labelText = "Scale:"
	scaleLabelWidth = gfx.measurestr(labelText)
	local labelXpos = xMargin+xPadding
	local labelYpos = yMargin+yPadding
	local labelHeight = 16
	self:addLabel(labelXpos, labelYpos, scaleLabelWidth, labelHeight, function() return labelText end)
end

function Interface:addScaleTonicNoteDropdown()

	local scaleTonicNoteXpos = xMargin+xPadding+scaleLabelWidth+horizontalMargin
	local scaleTonicNoteYpos = yMargin+yPadding+1
	local scaleTonicNoteHeight = 15

	local onScaleTonicNoteSelection = function(i)

		setScaleTonicNote(i)
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		self:restartGui()
	end

	local scaleTonicNote = getScaleTonicNote()
	self:addDropdown(scaleTonicNoteXpos, scaleTonicNoteYpos, scaleTonicNoteWidth, scaleTonicNoteHeight, notes, scaleTonicNote, onScaleTonicNoteSelection)

end

function Interface:addScaleTypeDropdown()

	local scaleTypeXpos = xMargin+xPadding+scaleLabelWidth+scaleTonicNoteWidth+horizontalMargin*1.5
	local scaleTypeYpos = yMargin+yPadding+1
	local scaleTypeHeight = 15

	local onScaleTypeSelection = function(i)

		setScaleType(i)
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		self:restartGui()
	end
	
	local scaleName = getScaleType()
	self:addDropdown(scaleTypeXpos, scaleTypeYpos, scaleTypeWidth, scaleTypeHeight, scaleNames, scaleName, onScaleTypeSelection)
end

function Interface:addScaleNotesTextLabel()

	local getScaleNotesTextCallback = function() return getScaleNotesText() end
	local scaleNotesXpos = xMargin+xPadding+scaleLabelWidth+scaleTonicNoteWidth+scaleTypeWidth+horizontalMargin*2+4
	local scaleNotesYpos = yMargin+yPadding+1
	local scaleNotesWidth = 360
	local scaleNotesHeight = 15
	self:addLabel(scaleNotesXpos, scaleNotesYpos, scaleNotesWidth, scaleNotesHeight, getScaleNotesTextCallback)
end

function Interface:addOctaveLabel()

	local labelText = "Octave:"
	octaveLabelWidth = gfx.measurestr(labelText)	
	local labelYpos = yMargin+yPadding+1
	local labelHeight = 15
	local labelXpos = windowWidth - 80 - octaveValueBoxWidth
	self:addLabel(labelXpos, labelYpos, octaveLabelWidth, labelHeight, function() return labelText end)
end

function Interface:addOctaveSelectorValueBox()

	local windowWidth = 775
	local valueBoxXPos = windowWidth - octaveValueBoxWidth - xMargin - xPadding + 3
	local valueBoxYPos = yMargin + 6
	local valueBoxHeight = 15
	self:addOctaveValueBox(valueBoxXPos, valueBoxYPos, octaveValueBoxWidth, valueBoxHeight)
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"

local xMargin = 8
local yMargin = 8 + keySelectionFrameHeight + 6
local xPadding = 7
local yPadding = 30

local headerHeight = 25
local inversionLabelWidth = 80
local inversionValueBoxWidth = 55
local chordTextWidth = nil

function Interface:addBottomFrame()

	local chordButtonsFrameHeight = self.height - yMargin - 6
	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, chordButtonsFrameHeight)
  
  self:addChordTextLabel()
  self:addInversionLabel()
  self:addInversionValueBox()
  
  self:addHeaders()
	self:addChordButtons()
end

function Interface:addChordTextLabel()

  local getChordTextCallback = function() return getChordText() end
  local chordTextXpos = xMargin + xPadding
  local chordTextYpos = yMargin + 4
  chordTextWidth = self.width - 4 * xMargin - inversionLabelWidth - inversionValueBoxWidth - 6
  local chordTextHeight = 24
  self:addLabel(chordTextXpos, chordTextYpos, chordTextWidth, chordTextHeight, getChordTextCallback)
end

function Interface:addInversionLabel()

  local inversionLabelText = "Inversion:"
  local inversionLabelXPos = xMargin + xPadding + chordTextWidth
  local inversionLabelYPos = yMargin + 4
  local stringWidth, _ = gfx.measurestr(labelText)
  local inversionLabelTextHeight = 24

  self:addLabel(inversionLabelXPos, inversionLabelYPos, inversionLabelWidth, inversionLabelTextHeight, function() return inversionLabelText end)
end

function Interface:addInversionValueBox()

  local inversionValueBoxXPos = xMargin + xPadding + chordTextWidth + inversionLabelWidth + 2
  local inversionValueBoxYPos = yMargin + 9
  local inversionValueBoxHeight = 15
  self:addChordInversionValueBox(inversionValueBoxXPos, inversionValueBoxYPos, inversionValueBoxWidth, inversionValueBoxHeight)
end

function Interface:addHeaders()
  
  for i = 1, #scaleNotes do

    local headerWidth = 104
    local innerSpacing = 2

    local headerXpos = xMargin+xPadding-1 + headerWidth * (i-1) + innerSpacing * i
    local headerYpos = yMargin+yPadding
    self:addHeader(headerXpos, headerYpos, headerWidth, headerHeight, function() return getScaleDegreeHeader(i) end)
  end
end

function Interface:addChordButtons()

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do

    if noteIsInScale(note) then

      for chordTypeIndex, chord in ipairs(scaleChords[scaleNoteIndex]) do

      	local text = getScaleNoteName(scaleNoteIndex) .. chord['display']

      	local buttonWidth = 104
      	local buttonHeight = 38
				local innerSpacing = 2
      	
      	local xPos = xMargin + xPadding + buttonWidth * (scaleNoteIndex-1) + innerSpacing * scaleNoteIndex
      	local yPos = yMargin + yPadding + headerHeight + buttonHeight * (chordTypeIndex-1) + innerSpacing * (chordTypeIndex-1) - 3
  
  			local numberOfChordsInScale = getNumberOfScaleChordsForScaleNoteIndex(scaleNoteIndex)

       	if chordTypeIndex > numberOfChordsInScale then
          local chordIsInScale = false
      		self:addChordButton(text, xPos, yPos, buttonWidth, buttonHeight, scaleNoteIndex, chordTypeIndex, chordIsInScale)
      	else
          local chordIsInScale = true
      		self:addChordButton(text, xPos, yPos, buttonWidth, buttonHeight, scaleNoteIndex, chordTypeIndex, chordIsInScale)
      	end     	
      end
      
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"


--clearConsoleWindow()
updateScaleData()

local x = 300
local y = 200
local width = 775
local height = 620

local interface = Interface:init("ChordGun", x, y, width, height)
interface:startGui()

local function windowHasNotBeenClosed()
	return gfx.getchar() ~= -1
end

local function main()

	if windowHasNotBeenClosed() then
		reaper.runloop(main)
	end
	
	interface:update()
end

main()

