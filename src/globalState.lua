local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/Timer")
require(workingDirectory .. "/preferences")

mouseButtonIsNotPressedDown = true

currentWidth = 0

scaleTonicNote = getScaleTonicNote()
scaleType = getScaleType()

local numberOfSecondsForChordPlay = 5
notesPlayingTimer = Timer:new(numberOfSecondsForChordPlay)