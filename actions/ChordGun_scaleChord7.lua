local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


updateScaleData()
scaleChordAction(7)
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)