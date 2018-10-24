#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

postfix="_packageTest.lua"

function removeFile() {

	outputFile=${1//.lua}
	outputFile=${outputFile##*/}$postfix

	rm "./pkg/$outputFile"
}

function insertIntoFile() {

	dependencyFile=$1
	outputFile=${2//.lua}
	outputFile=${outputFile##*/}$postfix

	grep -v "^require" "${DIR}"/$dependencyFile >> ./pkg/$outputFile
}

function unifyMainProgram() {

	removeFile $1

	insertIntoFile util.lua $1
	insertIntoFile globalState.lua $1
	insertIntoFile timer.lua $1
	insertIntoFile scales.lua $1
	insertIntoFile chords.lua $1
	insertIntoFile defaultValues.lua $1
	insertIntoFile preferences.lua $1
	insertIntoFile scaleFunctions.lua $1
	insertIntoFile scaleDegreeHeaders.lua $1
	insertIntoFile midiEditor.lua $1
	insertIntoFile midiMessages.lua $1
	insertIntoFile inversionStates.lua $1
	insertIntoFile chordNotesArray.lua $1
	insertIntoFile insertMidiNote.lua $1
	insertIntoFile insertChord.lua $1
	insertIntoFile previewChord.lua $1
	insertIntoFile scaleData.lua $1

	insertIntoFile interface/colors.lua $1
	insertIntoFile interface/classes/OctaveValueBox.lua $1
	insertIntoFile interface/classes/Label.lua $1
	insertIntoFile interface/classes/Header.lua $1
	insertIntoFile interface/classes/Frame.lua $1
	insertIntoFile interface/classes/Dropdown.lua $1
	insertIntoFile interface/classes/ChordInversionValueBox.lua $1
	insertIntoFile interface/classes/ChordButton.lua $1

	insertIntoFile interface/Interface.lua $1
	insertIntoFile interface/frames/InterfaceTopFrame.lua $1
	insertIntoFile interface/frames/InterfaceBottomFrame.lua $1

	insertIntoFile $1 $1
}

function unifyKeyboardShortcut() {

	removeFile $1

	insertIntoFile util.lua $1
	insertIntoFile globalState.lua $1
	insertIntoFile timer.lua $1
	insertIntoFile scales.lua $1
	insertIntoFile chords.lua $1
	insertIntoFile defaultValues.lua $1
	insertIntoFile preferences.lua $1
	insertIntoFile scaleFunctions.lua $1
	insertIntoFile scaleDegreeHeaders.lua $1
	insertIntoFile midiEditor.lua $1
	insertIntoFile midiMessages.lua $1
	insertIntoFile inversionStates.lua $1
	insertIntoFile chordNotesArray.lua $1
	insertIntoFile insertMidiNote.lua $1
	insertIntoFile insertChord.lua $1
	insertIntoFile previewChord.lua $1
	insertIntoFile scaleData.lua $1
	
	insertIntoFile $1 $1
}

unifyMainProgram ChordGun.lua
unifyKeyboardShortcut actions/ChordGun_insertScaleChord1.lua



# need to do this for all actions and ChordGun