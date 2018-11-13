-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actionFunctions")


updateScaleData()
scaleChordAction(4)
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)