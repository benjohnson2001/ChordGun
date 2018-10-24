local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

updateScaleData()
setSelectedScaleNote(2)
previewChord()