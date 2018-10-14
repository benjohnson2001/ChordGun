local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/defaultValues")

local activeProjectIndex = 0
local sectionName = "com.pandabot.ChordGun"

local scaleTonicNoteKey = "scaleTonicNote"
local scaleTypeKey = "scaleType"
local scaleNotesTextKey = "scaleNotesText"
local chordTextKey = "chordText"
local chordInversionKey = "chordInversion"
local chordInversionMinKey = "chordInversionMin"
local chordInversionMaxKey = "chordInversionMax"
local selectedScaleDegreeKey = "selectedScaleDegree"
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
  return getValue(scaleTonicNoteKey, defaultScaleTonicNoteValue)
end

function setScaleTonicNote(arg)
  setValue(scaleTonicNoteKey, arg)
end

--

function getScaleType()
  return getValue(scaleTypeKey, defaultScaleTypeValue)
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

function getChordInversion()
  return getValue(chordInversionKey, defaultChordInversion)
end

function setChordInversion(arg)
  setValue(chordInversionKey, arg)
end

--

function getChordInversionMin()
  return getValue(chordInversionMinKey, defaultChordInversionMin)
end

function setChordInversionMin(arg)
  setValue(chordInversionMinKey, arg)
end

--

function getChordInversionMax()
  return getValue(chordInversionMaxKey, defaultChordInversionMax)
end

function setChordInversionMax(arg)
  setValue(chordInversionMaxKey, arg)
end

--

function getSelectedScaleDegree()
  return getValue(selectedScaleDegreeKey, defaultSelectedScaleDegree)
end

function setSelectedScaleDegree(arg)
  setValue(selectedScaleDegreeKey, arg)
end

--

function getSelectedScaleDegree()
  return getValue(selectedScaleDegreeKey, defaultSelectedScaleDegree)
end

function setSelectedScaleDegree(arg)
  setValue(selectedScaleDegreeKey, arg)
end

--

function getSelectedChordTypes()
  return getTableValue(selectedChordTypesKey, defaultSelectedChordTypes)
end

function setSelectedChordTypes(arg)
  setTableValue(selectedChordTypesKey, arg)
end

--

function getScaleNoteNames()
  return getTableValue(scaleNoteNamesKey, defaultScaleNoteNames)
end

function setScaleNoteNames(arg)
  setTableValue(scaleNoteNamesKey, arg)
end

--

function getScaleDegreeHeaders(index)
  local temp = getTableValue(scaleDegreeHeadersKey, defaultScaleDegreeHeaders)
  return temp[index]
end

function setScaleDegreeHeaders(index, arg)

  local temp = getScaleDegreeHeaders()
  temp[index] = arg
  setTableValue(scaleDegreeHeadersKey, temp)
end

--

function getSelectedInversionStates1()
  return getTableValue(selectedInversionStates1Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates1(arg)
  setTableValue(selectedInversionStates1Key, arg)
end

--

function getSelectedInversionStates2()
  return getTableValue(selectedInversionStates2Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates2(arg)
  setTableValue(selectedInversionStates2Key, arg)
end

--

function getSelectedInversionStates3()
  return getTableValue(selectedInversionStates3Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates3(arg)
  setTableValue(selectedInversionStates3Key, arg)
end

--

function getSelectedInversionStates4()
  return getTableValue(selectedInversionStates4Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates4(arg)
  setTableValue(selectedInversionStates4Key, arg)
end

--

function getSelectedInversionStates5()
  return getTableValue(selectedInversionStates5Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates5(arg)
  setTableValue(selectedInversionStates5Key, arg)
end

--

function getSelectedInversionStates6()
  return getTableValue(selectedInversionStates6Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates6(arg)
  setTableValue(selectedInversionStates6Key, arg)
end

--

function getSelectedInversionStates7()
  return getTableValue(selectedInversionStates7Key, defaultSelectedInversionStates)
end

function setSelectedInversionStates7(arg)
  setTableValue(selectedInversionStates7Key, arg)
end

