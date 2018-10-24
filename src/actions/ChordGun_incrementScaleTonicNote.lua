local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

local function incrementScaleTonicNote()

	local scaleNoteTonic = getScaleTonicNote()

	if scaleTonic >= #notes then
		return
	end

	setScaleTonicNote(scaleNoteTonic+1)
end

updateScaleData()
incrementScaleTonicNote()