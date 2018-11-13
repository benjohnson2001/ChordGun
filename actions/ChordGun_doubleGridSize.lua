-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actionFunctions")


doubleGridSize()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)