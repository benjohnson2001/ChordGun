-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actionFunctions")


halveGridSize()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)