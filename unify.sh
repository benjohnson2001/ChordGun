#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function removeFile() {

	outputFile=${1##*/}

	rm "./pkg/$outputFile"
}

function insertIntoFile() {

	dependencyFile=$1
	outputFile=${2##*/}

	grep -v -e "^require" -e "^@noindex" "${DIR}"/$dependencyFile >> ./pkg/$outputFile
}

function unifyMainProgram() {

	removeFile $1

	insertIntoFile src/header.txt $1
	insertIntoFile src/chords.lua $1
	insertIntoFile src/defaultValues.lua $1
	insertIntoFile src/preferences.lua $1
	insertIntoFile src/util.lua $1
	insertIntoFile src/Timer.lua $1
	insertIntoFile src/globalState.lua $1
	insertIntoFile src/scales.lua $1
	insertIntoFile src/scaleFunctions.lua $1
	insertIntoFile src/scaleDegreeHeaders.lua $1
	insertIntoFile src/midiEditor.lua $1
	insertIntoFile src/midiMessages.lua $1
	insertIntoFile src/inversionStates.lua $1
	insertIntoFile src/chordNotesArray.lua $1
	insertIntoFile src/insertMidiNote.lua $1
	insertIntoFile src/changeSelectedNotes.lua $1
	insertIntoFile src/insertChord.lua $1
	insertIntoFile src/playChord.lua $1
	insertIntoFile src/scaleData.lua $1
	insertIntoFile src/transposeSelectedNotes.lua $1
	insertIntoFile src/insertScaleNote.lua $1
	insertIntoFile src/playScaleNote.lua $1

	insertIntoFile src/actions/actionFunctions.lua $1

	insertIntoFile src/interface/images/drawDropdownIcon.lua $1
	insertIntoFile src/interface/images/drawLeftArrow.lua $1
	insertIntoFile src/interface/images/drawRightArrow.lua $1

	insertIntoFile src/interface/colors.lua $1
	insertIntoFile src/interface/classes/Docker.lua $1
	insertIntoFile src/interface/classes/HitArea.lua $1
	insertIntoFile src/interface/classes/OctaveValueBox.lua $1
	insertIntoFile src/interface/classes/Label.lua $1
	insertIntoFile src/interface/classes/Header.lua $1
	insertIntoFile src/interface/classes/Frame.lua $1
	insertIntoFile src/interface/classes/Dropdown.lua $1
	insertIntoFile src/interface/classes/ChordInversionValueBox.lua $1
	insertIntoFile src/interface/classes/ChordButton.lua $1
	insertIntoFile src/interface/inputCharacters.lua $1
	insertIntoFile src/interface/handleInput.lua $1

	insertIntoFile src/interface/Interface.lua $1
	insertIntoFile src/interface/frames/InterfaceTopFrame.lua $1
	insertIntoFile src/interface/frames/InterfaceBottomFrame.lua $1

	insertIntoFile src/$1 $1
}

function unifyKeyboardShortcut() {

	removeFile $1

	insertIntoFile src/header.txt $1
	insertIntoFile src/chords.lua $1
	insertIntoFile src/defaultValues.lua $1
	insertIntoFile src/preferences.lua $1
	insertIntoFile src/util.lua $1
	insertIntoFile src/Timer.lua $1
	insertIntoFile src/globalState.lua $1
	insertIntoFile src/scales.lua $1
	insertIntoFile src/scaleFunctions.lua $1
	insertIntoFile src/scaleDegreeHeaders.lua $1
	insertIntoFile src/midiEditor.lua $1
	insertIntoFile src/midiMessages.lua $1
	insertIntoFile src/inversionStates.lua $1
	insertIntoFile src/chordNotesArray.lua $1
	insertIntoFile src/insertMidiNote.lua $1
	insertIntoFile src/changeSelectedNotes.lua $1
	insertIntoFile src/insertChord.lua $1
	insertIntoFile src/playChord.lua $1
	insertIntoFile src/scaleData.lua $1
	insertIntoFile src/transposeSelectedNotes.lua $1
	insertIntoFile src/insertScaleNote.lua $1
	insertIntoFile src/playScaleNote.lua $1
	
	insertIntoFile src/actions/actionFunctions.lua $1
	
	insertIntoFile src/$1 $1
}

unifyMainProgram ChordGun.lua

unifyKeyboardShortcut actions/ChordGun_decrementChordInversion.lua
unifyKeyboardShortcut actions/ChordGun_decrementChordType.lua
unifyKeyboardShortcut actions/ChordGun_decrementOctave.lua
unifyKeyboardShortcut actions/ChordGun_decrementScaleTonicNote.lua
unifyKeyboardShortcut actions/ChordGun_decrementScaleType.lua

unifyKeyboardShortcut actions/ChordGun_incrementChordInversion.lua
unifyKeyboardShortcut actions/ChordGun_incrementChordType.lua
unifyKeyboardShortcut actions/ChordGun_incrementOctave.lua
unifyKeyboardShortcut actions/ChordGun_incrementScaleTonicNote.lua
unifyKeyboardShortcut actions/ChordGun_incrementScaleType.lua

unifyKeyboardShortcut actions/ChordGun_playScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord2.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord3.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord4.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord5.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord6.lua
unifyKeyboardShortcut actions/ChordGun_playScaleChord7.lua

unifyKeyboardShortcut actions/ChordGun_insertScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord2.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord3.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord4.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord5.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord6.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord7.lua

unifyKeyboardShortcut actions/ChordGun_playScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_playScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_insertScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_playLowerScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_insertLowerScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_playHigherScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote1.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote2.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote3.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote4.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote5.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote6.lua
unifyKeyboardShortcut actions/ChordGun_insertHigherScaleNote7.lua

unifyKeyboardShortcut actions/ChordGun_stopAllNotesFromPlaying.lua
unifyKeyboardShortcut actions/ChordGun_doubleGridSize.lua
unifyKeyboardShortcut actions/ChordGun_halveGridSize.lua