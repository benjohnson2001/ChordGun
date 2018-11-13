-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actionFunctions")


updateScaleData()
scaleChordAction(7)
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)