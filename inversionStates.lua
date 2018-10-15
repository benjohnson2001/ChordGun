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

function setInversionState(scaleDegree, chordTypeIndex, inversionValue)
  
  if scaleDegree == 1 then
    setSelectedInversionState1(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 2 then
    setSelectedInversionState2(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 3 then
    setSelectedInversionState3(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 4 then
    setSelectedInversionState4(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 5 then
    setSelectedInversionState5(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 6 then
    setSelectedInversionState6(chordTypeIndex, inversionValue)
  end
  
  if scaleDegree == 7 then
    setSelectedInversionState7(chordTypeIndex, inversionValue)
  end
end

function getCurrentInversionValue()

  local selectedScaleDegree = getSelectedScaleDegree()
  local selectedChordTypeIndex = getSelectedChordType(selectedScaleDegree)
  
  if selectedScaleDegree == 1 then
    return getSelectedInversionStates1(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 2 then
    return getSelectedInversionStates2(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 3 then
    return getSelectedInversionStates3(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 4 then
    return getSelectedInversionStates4(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 5 then
    return getSelectedInversionStates5(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 6 then
    return getSelectedInversionStates6(selectedChordTypeIndex)
  end
  
  if selectedScaleDegree == 7 then
    return getSelectedInversionStates7(selectedChordTypeIndex)
  end
end