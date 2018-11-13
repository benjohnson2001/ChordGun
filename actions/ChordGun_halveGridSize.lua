local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


halveGridSize()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)