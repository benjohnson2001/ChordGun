local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

local function decrementChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(selectedScaleNote)

  if selectedChordType <= 1 then
    return
  end

  setSelectedChordType(selectedScaleNote, selectedChordType-1)
end

updateScaleData()
decrementChordType()
previewChord()