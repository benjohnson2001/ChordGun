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

--