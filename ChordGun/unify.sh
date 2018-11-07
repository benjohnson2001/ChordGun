#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function removeFile() {

	outputFile=${1##*/}

	rm "./pkg/$outputFile"
}

function insertNoIndexHeader() {
	echo "-- @noindex" >> "./pkg/${1##*/}"
}

function insertIntoFile() {

	dependencyFile=$1
	outputFile="${2##*/}"

	grep -v -e "^require" -e "^-- @noindex" "${DIR}/$dependencyFile" >> "./pkg/$outputFile"
}

function unifyMainProgram() {

	removeFile "$1"

	insertNoIndexHeader "$1"

	insertIntoFile src/chords.lua "$1"
	insertIntoFile src/defaultValues.lua "$1"
	insertIntoFile src/preferences.lua "$1"
	insertIntoFile src/util.lua "$1"
	insertIntoFile src/Timer.lua "$1"
	insertIntoFile src/globalState.lua "$1"
	insertIntoFile src/scales.lua "$1"
	insertIntoFile src/scaleFunctions.lua "$1"
	insertIntoFile src/scaleDegreeHeaders.lua "$1"
	insertIntoFile src/midiEditor.lua "$1"
	insertIntoFile src/midiMessages.lua "$1"
	insertIntoFile src/chordNotesArray.lua "$1"
	insertIntoFile src/insertMidiNote.lua "$1"
	insertIntoFile src/playOrInsertScaleChord.lua "$1"
	insertIntoFile src/playOrInsertScaleNote.lua "$1"
	insertIntoFile src/changeSelectedNotes.lua "$1"
	insertIntoFile src/scaleData.lua "$1"
	insertIntoFile src/transposeSelectedNotes.lua "$1"

	insertIntoFile src/actions/actionFunctions.lua "$1"

	insertIntoFile src/interface/images/drawDropdownIcon.lua "$1"
	insertIntoFile src/interface/images/drawLeftArrow.lua "$1"
	insertIntoFile src/interface/images/drawRightArrow.lua "$1"

	insertIntoFile src/interface/colors.lua "$1"
	insertIntoFile src/interface/classes/Docker.lua "$1"
	insertIntoFile src/interface/classes/HitArea.lua "$1"
	insertIntoFile src/interface/classes/OctaveValueBox.lua "$1"
	insertIntoFile src/interface/classes/Label.lua "$1"
	insertIntoFile src/interface/classes/Header.lua "$1"
	insertIntoFile src/interface/classes/Frame.lua "$1"
	insertIntoFile src/interface/classes/Dropdown.lua "$1"
	insertIntoFile src/interface/classes/ChordInversionValueBox.lua "$1"
	insertIntoFile src/interface/classes/ChordButton.lua "$1"
	insertIntoFile src/interface/inputCharacters.lua "$1"
	insertIntoFile src/interface/handleInput.lua "$1"

	insertIntoFile src/interface/Interface.lua "$1"
	insertIntoFile src/interface/frames/InterfaceTopFrame.lua "$1"
	insertIntoFile src/interface/frames/InterfaceBottomFrame.lua "$1"

	insertIntoFile "src/$1" "$1"
}

function unifyKeyboardShortcut() {

	removeFile "$1"

	insertNoIndexHeader "$1"

	insertIntoFile src/chords.lua "$1"
	insertIntoFile src/defaultValues.lua "$1"
	insertIntoFile src/preferences.lua "$1"
	insertIntoFile src/util.lua "$1"
	insertIntoFile src/Timer.lua "$1"
	insertIntoFile src/globalState.lua "$1"
	insertIntoFile src/scales.lua "$1"
	insertIntoFile src/scaleFunctions.lua "$1"
	insertIntoFile src/scaleDegreeHeaders.lua "$1"
	insertIntoFile src/midiEditor.lua "$1"
	insertIntoFile src/midiMessages.lua "$1"
	insertIntoFile src/chordNotesArray.lua "$1"
	insertIntoFile src/insertMidiNote.lua "$1"
	insertIntoFile src/playOrInsertScaleChord.lua "$1"
	insertIntoFile src/playOrInsertScaleNote.lua "$1"
	insertIntoFile src/changeSelectedNotes.lua "$1"
	insertIntoFile src/scaleData.lua "$1"
	insertIntoFile src/transposeSelectedNotes.lua "$1"

	insertIntoFile src/actions/actionFunctions.lua "$1"
	
	insertIntoFile "src/$1" "$1"
}

unifyMainProgram pandabot_ChordGun.lua

unifyKeyboardShortcut "actions/pandabot_ChordGun: decrement chord inversion.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: decrement chord type.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: decrement octave.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: decrement scale tonic note.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: decrement scale type.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: increment chord inversion.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: increment chord type.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: increment octave.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: increment scale tonic note.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: increment scale type.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 1.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 2.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 3.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 4.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 5.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 6.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale chord 7.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 1.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 2.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 3.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 4.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 5.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 6.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: scale note 7.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 1.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 2.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 3.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 4.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 5.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 6.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: lower scale note 7.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 1.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 2.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 3.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 4.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 5.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 6.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: higher scale note 7.lua"

unifyKeyboardShortcut "actions/pandabot_ChordGun: stop all notes from playing.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: double grid size.lua"
unifyKeyboardShortcut "actions/pandabot_ChordGun: halve grid size.lua"