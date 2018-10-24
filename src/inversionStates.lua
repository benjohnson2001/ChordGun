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