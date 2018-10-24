local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/Timer")

mouseButtonIsNotPressedDown = true

local numberOfSecondsForChordPreview = 5
chordPreviewTimer = Timer:new(numberOfSecondsForChordPreview)