local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


updateScaleData()
decrementChordTypeAction()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)