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
local selectedInversionStatesKey = "selectedInversionStates"

--

local function getValue(key, defaultValue)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)

  if valueExists == 0 then
    reaper.SetProjExtState(activeProjectIndex, sectionName, key, defaultValue)
    return defaultValue
  end

  return value
end

local function setValue(key, value)
  reaper.SetProjExtState(activeProjectIndex, sectionName, key, value)
end

--

local function getTableFromString(arg)

  local output = {}

  for match in arg:gmatch("([^,%s]+)") do
    output[#output + 1] = tonumber(match)
  end

  return output
end

local function getTableValue(key, defaultValue)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)

  if valueExists == 0 then
    reaper.SetProjExtState(activeProjectIndex, sectionName, key, defaultValue)
    return defaultValue
  end

  return getTableFromString(value)
end

local function setTableValue(key, value)
  reaper.SetProjExtState(activeProjectIndex, sectionName, key, table.concat(value, ","))
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

function getSelectedChordTypes()
  return getTableValue(selectedInversionStatesKey, defaultSelectedInversionStates)
end

function setSelectedChordTypes(arg)
  setTableValue(selectedInversionStatesKey, arg)
end
