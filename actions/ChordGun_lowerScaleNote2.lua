local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/actions/actionFunctions")


updateScaleData()
lowerScaleNoteAction(2)
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)