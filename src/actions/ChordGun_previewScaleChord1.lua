local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

local numberOfSeconds = 5
local timer = Timer:new(numberOfSeconds)
timer:start()

local function main()

	if timer:timeHasNotElapsed() then
		reaper.runloop(main)
	else
		timer:stop()
		stopAllNotesFromPlaying()
	end
	
	showChordText()
end

updateScaleData()
setSelectedScaleNote(1)
previewChord()
main()