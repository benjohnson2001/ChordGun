-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/defaultValues")

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