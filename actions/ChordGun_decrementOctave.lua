-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actionFunctions")


updateScaleData()
decrementOctaveAction()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)