-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")
require(workingDirectory .. "/playScaleNote")

local function decrementChordInversion()

  local chordInversionMin = getChordInversionMin()
  local chordInversion = getCurrentInversionValue()

  if chordInversion <= chordInversionMin then
    return
  end

  setInversionState(chordInversion-1)
end

function decrementChordInversionAction()

	decrementChordInversion()

	if thereAreNotesSelected() then
		startUndoBlock()
		insertChord()
		endUndoBlock("decrement chord inversion")
	end

	playChord()
end

--

local function incrementChordInversion()

  local chordInversionMax = getChordInversionMax()
  local chordInversion = getCurrentInversionValue()

  if chordInversion >= chordInversionMax then
    return
  end

  setInversionState(chordInversion+1)
end

function incrementChordInversionAction()

	incrementChordInversion()

	if thereAreNotesSelected() then
		startUndoBlock()
		insertChord()
		endUndoBlock("increment chord inversion")
	end
	
	playChord()
end


--

local function decrementChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(selectedScaleNote)

  if selectedChordType <= 1 then
    return
  end

  setSelectedChordType(selectedScaleNote, selectedChordType-1)
end

function decrementChordTypeAction()

	decrementChordType()

	if thereAreNotesSelected() then
		startUndoBlock()
		insertChord()
		endUndoBlock("decrement chord type")
	end

	playChord()
end

--

local function incrementChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(selectedScaleNote)

  if selectedChordType >= #chords then
    return
  end

  setSelectedChordType(selectedScaleNote, selectedChordType+1)
end

function incrementChordTypeAction()

	incrementChordType()

	if thereAreNotesSelected() then
		startUndoBlock()
		insertChord()
		endUndoBlock("increment chord type")
	end

	playChord()
end

--

local function decrementOctave()

  local octave = getOctave()

  if octave <= -1 then
    return
  end

  setOctave(octave-1)
end

function decrementOctaveAction()

	decrementOctave()

	if thereAreNotesSelected() then
		startUndoBlock()
		transposeSelectedNotesDownOneOctave()
		endUndoBlock("decrement octave")
	else
		playTonicNote()
	end
end

--

local function incrementOctave()

  local octave = getOctave()

  if octave >= 8 then
    return
  end

  setOctave(octave+1)
end

function incrementOctaveAction()

	incrementOctave()

	if thereAreNotesSelected() then
		startUndoBlock()
		transposeSelectedNotesUpOneOctave()
		endUndoBlock("increment octave")
	else
		playTonicNote()
	end	
end

--

local function decrementScaleTonicNote()

	local scaleTonicNote = getScaleTonicNote()

	if scaleTonicNote <= 1 then
		return
	end

	setScaleTonicNote(scaleTonicNote-1)
end

function decrementScaleTonicNoteAction()

	decrementScaleTonicNote()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function incrementScaleTonicNote()

	local scaleTonicNote = getScaleTonicNote()

	if scaleTonicNote >= #notes then
		return
	end

	setScaleTonicNote(scaleTonicNote+1)
end

function incrementScaleTonicNoteAction()

	incrementScaleTonicNote()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function decrementScaleType()

	local scaleType = getScaleType()

	if scaleType <= 1 then
		return
	end

	setScaleType(scaleType-1)
	
end

function decrementScaleTypeAction()

	decrementScaleType()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

--

local function incrementScaleType()

	local scaleType = getScaleType()

	if scaleType >= #scales then
		return
	end

	setScaleType(scaleType+1)
end

function incrementScaleTypeAction()

	incrementScaleType()

	setSelectedScaleNote(1)
	setChordText("")
	resetSelectedChordTypes()
	resetSelectedInversionStates()
	updateScaleData()
	updateScaleDegreeHeaders()
	showScaleStatus()
end

----

local function insertScaleChordAction(scaleNoteIndex)

	startUndoBlock()
	setSelectedScaleNote(scaleNoteIndex)
	insertChord()
	playChord()

	local selectedChordType = getSelectedChordType(scaleNoteIndex)
	local chord = scaleChords[scaleNoteIndex][selectedChordType]
	endUndoBlock("insert scale chord " .. scaleNoteIndex .. "  (" .. chord.code .. ")")
end

--

function insertScaleChord1Action()
	insertScaleChordAction(1)
end

--

function insertScaleChord2Action()
	insertScaleChordAction(2)
end

--

function insertScaleChord3Action()
	insertScaleChordAction(3)
end

--

function insertScaleChord4Action()
	insertScaleChordAction(4)
end

--

function insertScaleChord5Action()
	insertScaleChordAction(5)
end

--

function insertScaleChord6Action()
	insertScaleChordAction(6)
end

--

function insertScaleChord7Action()
	insertScaleChordAction(7)
end

--

function playScaleChord1Action()

	setSelectedScaleNote(1)
	playChord()
end

--

function playScaleChord2Action()

	setSelectedScaleNote(2)
	playChord()
end

--

function playScaleChord3Action()

	setSelectedScaleNote(3)
	playChord()
end

--

function playScaleChord4Action()

	setSelectedScaleNote(4)
	playChord()
end

--

function playScaleChord5Action()

	setSelectedScaleNote(5)
	playChord()
end

--

function playScaleChord6Action()

	setSelectedScaleNote(6)
	playChord()
end

--

function playScaleChord7Action()

	setSelectedScaleNote(7)
	playChord()
end

--

function playScaleNote1Action()

	setSelectedScaleNote(1)
	return playScaleNote()
end

--

function playScaleNote2Action()

	setSelectedScaleNote(2)
	return playScaleNote()
end

--

function playScaleNote3Action()

	setSelectedScaleNote(3)
	return playScaleNote()
end

--

function playScaleNote4Action()

	setSelectedScaleNote(4)
	return playScaleNote()
end

--

function playScaleNote5Action()

	setSelectedScaleNote(5)
	return playScaleNote()
end

--

function playScaleNote6Action()

	setSelectedScaleNote(6)
	return playScaleNote()
end

--

function playScaleNote7Action()

	setSelectedScaleNote(7)
	return playScaleNote()
end

--

function playLowerScaleNote1Action()

	setSelectedScaleNote(1)
	return playLowerScaleNote()
end

--

function playLowerScaleNote2Action()

	setSelectedScaleNote(2)
	return playLowerScaleNote()
end

--

function playLowerScaleNote3Action()

	setSelectedScaleNote(3)
	return playLowerScaleNote()
end

--

function playLowerScaleNote4Action()

	setSelectedScaleNote(4)
	return playLowerScaleNote()
end

--

function playLowerScaleNote5Action()

	setSelectedScaleNote(5)
	return playLowerScaleNote()
end

--

function playLowerScaleNote6Action()

	setSelectedScaleNote(6)
	return playLowerScaleNote()
end

--

function playLowerScaleNote7Action()

	setSelectedScaleNote(7)
	return playLowerScaleNote()
end

--

function playHigherScaleNote1Action()

	setSelectedScaleNote(1)
	return playHigherScaleNote()
end

--

function playHigherScaleNote2Action()

	setSelectedScaleNote(2)
	return playHigherScaleNote()
end

--

function playHigherScaleNote3Action()

	setSelectedScaleNote(3)
	return playHigherScaleNote()
end

--

function playHigherScaleNote4Action()

	setSelectedScaleNote(4)
	return playHigherScaleNote()
end

--

function playHigherScaleNote5Action()

	setSelectedScaleNote(5)
	return playHigherScaleNote()
end

--

function playHigherScaleNote6Action()

	setSelectedScaleNote(6)
	return playHigherScaleNote()
end

--

function playHigherScaleNote7Action()

	setSelectedScaleNote(7)
	return playHigherScaleNote()
end

----

local function insertScaleNoteAction(scaleNoteIndex)

	startUndoBlock()
	setSelectedScaleNote(scaleNoteIndex)
	insertScaleNote()
	playScaleNote()
	endUndoBlock("insert scale note " .. scaleNoteIndex)
end

--

function insertScaleNote1Action()

	insertScaleNoteAction(1)
end

--

function insertScaleNote2Action()

	insertScaleNoteAction(2)
end

--

function insertScaleNote3Action()

	insertScaleNoteAction(3)
end

--

function insertScaleNote4Action()

	insertScaleNoteAction(4)
end

--

function insertScaleNote5Action()

	insertScaleNoteAction(5)
end

--

function insertScaleNote6Action()

	insertScaleNoteAction(6)
end

--

function insertScaleNote7Action()

	insertScaleNoteAction(7)
end

----

local function insertLowerScaleNoteAction(scaleNoteIndex)

	startUndoBlock()
	setSelectedScaleNote(scaleNoteIndex)
	insertLowerScaleNote()
	playScaleNote()
	endUndoBlock("insert lower scale note " .. scaleNoteIndex)
end

--

function insertLowerScaleNote1Action()

	insertLowerScaleNoteAction(1)
end

--

function insertLowerScaleNote2Action()

	insertLowerScaleNoteAction(2)
end

--

function insertLowerScaleNote3Action()

	insertLowerScaleNoteAction(3)
end

--

function insertLowerScaleNote4Action()

	insertLowerScaleNoteAction(4)
end

--

function insertLowerScaleNote5Action()

	insertLowerScaleNoteAction(5)
end

--

function insertLowerScaleNote6Action()

	insertLowerScaleNoteAction(6)
end

--

function insertLowerScaleNote7Action()

	insertLowerScaleNoteAction(7)
end

----

local function insertHigherScaleNoteAction(scaleNoteIndex)

	startUndoBlock()
	setSelectedScaleNote(scaleNoteIndex)
	insertHigherScaleNote()
	playScaleNote()
	endUndoBlock("insert higher scale note " .. scaleNoteIndex)
end

--

function insertHigherScaleNote1Action()

	insertHigherScaleNoteAction(1)
end

--

function insertHigherScaleNote2Action()

	insertHigherScaleNoteAction(2)
end

--

function insertHigherScaleNote3Action()

	insertHigherScaleNoteAction(3)
end

--

function insertHigherScaleNote4Action()

	insertHigherScaleNoteAction(4)
end

--

function insertHigherScaleNote5Action()

	insertHigherScaleNoteAction(5)
end

--

function insertHigherScaleNote6Action()

	insertHigherScaleNoteAction(6)
end

--

function insertHigherScaleNote7Action()

	insertHigherScaleNoteAction(7)
end
