-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/ChordGunMini_src"
require(workingDirectory .. "/preferences")

mouseButtonIsNotPressedDown = true

currentWidth = 0

scaleTonicNote = getScaleTonicNote()
scaleType = getScaleType()

guiShouldBeUpdated = false