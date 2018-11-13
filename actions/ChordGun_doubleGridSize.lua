local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


doubleGridSize()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)