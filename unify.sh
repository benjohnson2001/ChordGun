#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function removeFile() {

	outputFile=${1##*/}

	rm "./pkg/$outputFile"
}

function insertIntoFile() {

	dependencyFile=$1
	outputFile=${2##*/}

	grep -v "^require" "${DIR}"/$dependencyFile >> ./pkg/$outputFile
}

function unifyMainProgram() {

	removeFile $1

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
	insertIntoFile src/insertChord.lua $1
	insertIntoFile src/previewChord.lua $1
	insertIntoFile src/scaleData.lua $1

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
	insertIntoFile src/interface/handleInput.lua $1

	insertIntoFile src/interface/Interface.lua $1
	insertIntoFile src/interface/frames/InterfaceTopFrame.lua $1
	insertIntoFile src/interface/frames/InterfaceBottomFrame.lua $1

	insertIntoFile src/$1 $1
}

function unifyKeyboardShortcut() {

	removeFile $1

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
	insertIntoFile src/insertChord.lua $1
	insertIntoFile src/previewChord.lua $1
	insertIntoFile src/scaleData.lua $1
	
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

unifyKeyboardShortcut actions/ChordGun_insertScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord2.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord3.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord4.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord5.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord6.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord7.lua

unifyKeyboardShortcut actions/ChordGun_previewScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord1.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord2.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord3.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord4.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord5.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord6.lua
unifyKeyboardShortcut actions/ChordGun_previewScaleChord7.lua
