local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/scaleData")

updateScaleData()
setSelectedScaleNote(1)
previewChord()
insertChord()