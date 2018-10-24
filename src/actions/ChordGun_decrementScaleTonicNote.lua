local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

local function decrementScaleTonicNote()

	local scaleNoteTonic = getScaleTonicNote()

	if scaleTonic <= 1 then
		return
	end

	setScaleTonicNote(scaleNoteTonic-1)
end

updateScaleData()
decrementScaleTonicNote()