local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/chords")

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