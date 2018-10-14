defaultScaleTonicNoteValue = 1
defaultScaleTypeValue = 1
defaultScaleNotesTextValue = ''
defaultChordTextValue = ''
defaultChordInversion = 0
defaultChordInversionMin = -8
defaultChordInversionMax = 8
defaultSelectedScaleDegree = 1

defaultSelectedChordTypes = {}
for i = 1, 7 do
  table.insert(defaultSelectedChordTypes, 1)
end

defaultSelectedInversionStates = {}
for i = 1, #chords do
  table.insert(defaultSelectedInversionStates, 0)
end
