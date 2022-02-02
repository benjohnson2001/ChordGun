-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/ChordGunMini_src"
require(workingDirectory .. "/scales")
require(workingDirectory .. "/scaleFunctions")

local windowWidth = 470

scaleNames = {}
for key, scale in ipairs(scales) do
  table.insert(scaleNames, scale['name'])
end

local xMargin = 8
local yMargin = 8
local xPadding = 8
local yPadding = 5

local scaleLabelWidth = nil
local horizontalMargin = 8

local scaleTonicNoteWidth = 50
local scaleTypeWidth = 116

keySelectionFrameHeight = 25
function Interface:addTopFrame()

	self:addFrame(xMargin+dockerXPadding, yMargin, self.width - 2 * xMargin, keySelectionFrameHeight)
	self:addScaleLabel()
	self:addScaleTonicNoteDropdown()
	self:addScaleTypeDropdown()
	self:addScaleNotesTextLabel()
end

function Interface:addScaleLabel()

	local labelText = "Key:"
	scaleLabelWidth = gfx.measurestr(labelText)
	local labelXpos = xMargin+xPadding + 5
	local labelYpos = yMargin+yPadding
	local labelHeight = 16
	self:addLabel(labelXpos+dockerXPadding, labelYpos, scaleLabelWidth, labelHeight, function() return labelText end)
end

function Interface:addScaleTonicNoteDropdown()

	local scaleTonicNoteXpos = xMargin+xPadding+scaleLabelWidth+horizontalMargin - 1
	local scaleTonicNoteYpos = yMargin+yPadding+1
	local scaleTonicNoteHeight = 15

	local onScaleTonicNoteSelection = function(i)

		setScaleTonicNote(i)
		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetChordInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
	end

	local scaleTonicNote = getScaleTonicNote()
	self:addDropdown(scaleTonicNoteXpos+dockerXPadding, scaleTonicNoteYpos, scaleTonicNoteWidth, scaleTonicNoteHeight, notes, scaleTonicNote, onScaleTonicNoteSelection)

end

function Interface:addScaleTypeDropdown()

	local scaleTypeXpos = xMargin+xPadding+scaleLabelWidth+scaleTonicNoteWidth+horizontalMargin*1.5 - 1
	local scaleTypeYpos = yMargin+yPadding+1
	local scaleTypeHeight = 15

	local onScaleTypeSelection = function(i)

		setScaleType(i)
		setSelectedScaleNote(1)
		setChordText("")
		resetSelectedChordTypes()
		resetChordInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
	end
	
	local scaleName = getScaleType()
	self:addDropdown(scaleTypeXpos+dockerXPadding, scaleTypeYpos, scaleTypeWidth, scaleTypeHeight, scaleNames, scaleName, onScaleTypeSelection)
end

function Interface:addScaleNotesTextLabel()

	local getScaleNotesTextCallback = function() return getScaleNotesText() end
	local scaleNotesXpos = xMargin+xPadding+scaleLabelWidth+scaleTonicNoteWidth+scaleTypeWidth+horizontalMargin*2+4-64
	local scaleNotesYpos = yMargin+yPadding+1
	local scaleNotesWidth = 360
	local scaleNotesHeight = 15
	self:addLabel(scaleNotesXpos+dockerXPadding, scaleNotesYpos, scaleNotesWidth, scaleNotesHeight, getScaleNotesTextCallback)
end
