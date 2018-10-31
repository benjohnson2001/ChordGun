-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/scaleData")

local function decrementChordInversion()

  local chordInversionMin = getChordInversionMin()
  local chordInversion = getCurrentInversionValue()

  if chordInversion <= chordInversionMin then
    return
  end

  setInversionState(chordInversion-1)
end

function decrementChordInversionAction()

	startUndoBlock()

		decrementChordInversion()
		playOrInsertScaleChord()

	endUndoBlock("decrement chord inversion")
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

	startUndoBlock()

		incrementChordInversion()
		playOrInsertScaleChord()

	endUndoBlock("increment chord inversion")
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

	startUndoBlock()

		decrementChordType()
		playOrInsertScaleChord()

	endUndoBlock("decrement chord type")
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

	startUndoBlock()

		incrementChordType()
		playOrInsertScaleChord()

	endUndoBlock("increment chord type")
end

--

function playTonicNote()

  local root = scaleNotes[1]
  local octave = getOctave()
  local noteValue = root + ((octave+1) * 12) - 1

  stopNotesFromPlaying()
  playMidiNote(noteValue)
  setNotesThatArePlaying({noteValue})
end

local function decrementOctave()

  local octave = getOctave()

  if octave <= -1 then
    return
  end

  setOctave(octave-1)
end

function decrementOctaveAction()

	startUndoBlock()

		decrementOctave()

		if thereAreNotesSelected() then
			transposeSelectedNotesDownOneOctave()
		else
			playTonicNote()
		end

	endUndoBlock("decrement octave")
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

	startUndoBlock()

		incrementOctave()

		if thereAreNotesSelected() then
			transposeSelectedNotesUpOneOctave()
		else
			playTonicNote()
		end

	endUndoBlock("increment octave")
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

	startUndoBlock()

		decrementScaleTonicNote()

		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		showScaleStatus()

	endUndoBlock("decrement scale tonic note")
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

	startUndoBlock()

		incrementScaleTonicNote()

		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		showScaleStatus()

	endUndoBlock("increment scale tonic note")
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

	startUndoBlock()

		decrementScaleType()

		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		showScaleStatus()

	endUndoBlock("decrement scale type")
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

	startUndoBlock()

		incrementScaleType()

		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		showScaleStatus()

	endUndoBlock("increment scale type")
end

----

function scaleChordAction(scaleNoteIndex)

	startUndoBlock()

		setSelectedScaleNote(scaleNoteIndex)
		playOrInsertScaleChord()

		local selectedChordType = getSelectedChordType(scaleNoteIndex)
		local chord = scaleChords[scaleNoteIndex][selectedChordType]

	endUndoBlock("scale chord " .. scaleNoteIndex .. "  (" .. chord.code .. ")")
end

--

function scaleNoteAction(scaleNoteIndex)

	startUndoBlock()

		setSelectedScaleNote(scaleNoteIndex)
		playOrInsertScaleNote(0)

	endUndoBlock("scale note " .. scaleNoteIndex)
end

--

function lowerScaleNoteAction(scaleNoteIndex)

  if getOctave() <= -1 then
    return
  end

	startUndoBlock()

		setSelectedScaleNote(scaleNoteIndex)
		playOrInsertScaleNote(-1)

	endUndoBlock("lower scale note " .. scaleNoteIndex)
end

--

function higherScaleNoteAction(scaleNoteIndex)

  if getOctave() >= 8 then
    return
  end

	startUndoBlock()

		setSelectedScaleNote(scaleNoteIndex)
		playOrInsertScaleNote(1)

	endUndoBlock("higher scale note " .. scaleNoteIndex)
end
