@noindex
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
		insertChord()
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
		insertChord()
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
		insertChord()
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
		insertChord()
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
		transposeSelectedNotesDownOneOctave()
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
		transposeSelectedNotesUpOneOctave()
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

--

function insertScaleChord1Action()

	setSelectedScaleNote(1)
	insertChord()
	playChord()
end

--

function insertScaleChord2Action()

	setSelectedScaleNote(2)
	insertChord()
	playChord()
end

--

function insertScaleChord3Action()

	setSelectedScaleNote(3)
	insertChord()
	playChord()
end

--

function insertScaleChord4Action()

	setSelectedScaleNote(4)
	insertChord()
	playChord()
end

--

function insertScaleChord5Action()

	setSelectedScaleNote(5)
	insertChord()
	playChord()
end

--

function insertScaleChord6Action()

	setSelectedScaleNote(6)
	insertChord()
	playChord()
end

--

function insertScaleChord7Action()

	setSelectedScaleNote(7)
	playChord()
	insertChord()
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

--

function insertScaleNote1Action()

	setSelectedScaleNote(1)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote2Action()

	setSelectedScaleNote(2)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote3Action()

	setSelectedScaleNote(3)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote4Action()

	setSelectedScaleNote(4)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote5Action()

	setSelectedScaleNote(5)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote6Action()

	setSelectedScaleNote(6)
	insertScaleNote()
	playScaleNote()
end

--

function insertScaleNote7Action()

	setSelectedScaleNote(7)
	insertScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote1Action()

	setSelectedScaleNote(1)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote2Action()

	setSelectedScaleNote(2)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote3Action()

	setSelectedScaleNote(3)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote4Action()

	setSelectedScaleNote(4)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote5Action()

	setSelectedScaleNote(5)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote6Action()

	setSelectedScaleNote(6)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertLowerScaleNote7Action()

	setSelectedScaleNote(7)
	insertLowerScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote1Action()

	setSelectedScaleNote(1)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote2Action()

	setSelectedScaleNote(2)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote3Action()

	setSelectedScaleNote(3)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote4Action()

	setSelectedScaleNote(4)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote5Action()

	setSelectedScaleNote(5)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote6Action()

	setSelectedScaleNote(6)
	insertHigherScaleNote()
	playScaleNote()
end

--

function insertHigherScaleNote7Action()

	setSelectedScaleNote(7)
	insertHigherScaleNote()
	playScaleNote()
end
