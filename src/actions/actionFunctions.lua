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

	updateScaleData()
	decrementChordInversion()
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

	updateScaleData()
	decrementChordType()
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

	updateScaleData()
	decrementOctave()
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

	updateScaleData()
	decrementScaleTonicNote()
end

--

local function decrementScaleType()

	local scaleType = getScaleType()

	if scaleType <= 1 then
		return
	end

	setScaleType(scaleType-1)
	showScaleStatus()
end

function decrementScaleTypeAction()

	updateScaleData()
	decrementScaleType()
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

	updateScaleData()
	incrementChordInversion()
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

	updateScaleData()
	incrementChordType()
	playChord()
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

	updateScaleData()
	incrementOctave()
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

	updateScaleData()
	incrementScaleTonicNote()
end

--

local function incrementScaleType()

	local scaleType = getScaleType()

	if scaleType >= #scales then
		return
	end

	setScaleType(scaleType+1)
	showScaleStatus()
end

function incrementScaleTypeAction()

	updateScaleData()
	incrementScaleType()
end

--

function insertScaleChord1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	playChord()
	insertChord()
end

--

function insertScaleChord2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	playChord()
	insertChord()
end

--

function insertScaleChord3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	playChord()
	insertChord()
end

--

function insertScaleChord4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	playChord()
	insertChord()
end

--

function insertScaleChord5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	playChord()
	insertChord()
end

--

function playScaleChord6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	playChord()
end

--

function insertScaleChord7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	playChord()
	insertChord()
end

--

function playScaleChord1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	playChord()
end

--

function playScaleChord2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	playChord()
end

--

function playScaleChord3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	playChord()
end

--

function playScaleChord4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	playChord()
end

--

function playScaleChord5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	playChord()
end

--

function insertScaleChord6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	playChord()
	insertChord()
end

--

function playScaleChord7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	playChord()
end

--

function playScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return playScaleNote()
end

--

function playScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return playScaleNote()
end

--

function playScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return playScaleNote()
end

--

function playScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return playScaleNote()
end

--

function playScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return playScaleNote()
end

--

function playScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return playScaleNote()
end

--

function playScaleNote7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	return playScaleNote()
end

--

function playLowerScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return playLowerScaleNote()
end

--

function playLowerScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return playLowerScaleNote()
end

--

function playLowerScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return playLowerScaleNote()
end

--

function playLowerScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return playLowerScaleNote()
end

--

function playLowerScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return playLowerScaleNote()
end

--

function playLowerScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return playLowerScaleNote()
end

--

function playLowerScaleNote7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	return playLowerScaleNote()
end

--

function playHigherScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return playHigherScaleNote()
end

--

function playHigherScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return playHigherScaleNote()
end

--

function playHigherScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return playHigherScaleNote()
end

--

function playHigherScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return playHigherScaleNote()
end

--

function playHigherScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return playHigherScaleNote()
end

--

function playHigherScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return playHigherScaleNote()
end

--

function playHigherScaleNote7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	return playHigherScaleNote()
end

--

function insertScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return insertScaleNote()
end

--

function insertScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return insertScaleNote()
end

--

function insertScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return insertScaleNote()
end

--

function insertScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return insertScaleNote()
end

--

function insertScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return insertScaleNote()
end

--

function insertScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return insertScaleNote()
end

--

function insertScaleNote7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	return insertScaleNote()
end

--

function insertLowerScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return insertLowerScaleNote()
end

--

function insertLowerScaleNote7Action()

	updateScaleData()
	setSelectedScaleNote(7)
	return insertLowerScaleNote()
end

--

function insertHigherScaleNote1Action()

	updateScaleData()
	setSelectedScaleNote(1)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote2Action()

	updateScaleData()
	setSelectedScaleNote(2)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote3Action()

	updateScaleData()
	setSelectedScaleNote(3)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote4Action()

	updateScaleData()
	setSelectedScaleNote(4)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote5Action()

	updateScaleData()
	setSelectedScaleNote(5)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote6Action()

	updateScaleData()
	setSelectedScaleNote(6)
	return insertHigherScaleNote()
end

--

function insertHigherScaleNote7Action()

	if getOctave() > 7 then
		return
	end

	updateScaleData()
	setSelectedScaleNote(7)
	return insertHigherScaleNote()
end

--
