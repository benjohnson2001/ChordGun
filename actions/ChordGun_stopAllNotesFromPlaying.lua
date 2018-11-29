local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/midiMessages")
require(workingDirectory .. "/util")



stopAllNotesFromPlaying()
reaper.defer(emptyFunctionToPreventAutomaticCreationOfUndoPoint)