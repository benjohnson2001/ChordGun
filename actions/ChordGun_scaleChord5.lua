local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


updateScaleData()
scaleChordAction(5)
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)