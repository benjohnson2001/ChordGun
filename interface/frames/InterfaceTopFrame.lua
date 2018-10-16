local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/scales")
require(workingDirectory .. "/scaleFunctions")

scaleNames = {}
for key, scale in ipairs(scales) do
  table.insert(scaleNames, scale['name'])
end

local xMargin = 8
local yMargin = 8
local xPadding = 16
local yPadding = 5

local labelWidth = nil
local horizontalMargin = 8

local scaleTonicNoteWidth = 50
local scaleTypeWidth = 150

keySelectionFrameHeight = 25
function Interface:addTopFrame()

	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, keySelectionFrameHeight)
	self:addScaleLabel()
	self:addScaleTonicNoteDropdown()
	self:addScaleTypeDropdown()
	self:addScaleNotesTextLabel()
end

function Interface:addScaleLabel()

	local labelText = "Scale:"
	labelWidth = gfx.measurestr(labelText)
	local labelXpos = xMargin+xPadding
	local labelYpos = yMargin+yPadding
	local labelWidth = 50
	local labelHeight = 16
	self:addLabel(labelXpos, labelYpos, labelWidth, labelHeight, function() return labelText end)
end


function Interface:addScaleTonicNoteDropdown()

	local scaleTonicNoteXpos = xMargin+xPadding+labelWidth+horizontalMargin
	local scaleTonicNoteYpos = yMargin+yPadding+1
	local scaleTonicNoteHeight = 15

	local onScaleTonicNoteSelection = function(i)

		setScaleTonicNote(i)
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		self:restartGui()
	end

	local scaleTonicNote = getScaleTonicNote()
	self:addDropdown(scaleTonicNoteXpos, scaleTonicNoteYpos, scaleTonicNoteWidth, scaleTonicNoteHeight, notes, scaleTonicNote, onScaleTonicNoteSelection)

end

function Interface:addScaleTypeDropdown()

	local scaleTypeXpos = xMargin+xPadding+labelWidth+scaleTonicNoteWidth+horizontalMargin*1.5
	local scaleTypeYpos = yMargin+yPadding+1
	local scaleTypeHeight = 15

	local onScaleTypeSelection = function(i)

		setScaleType(i)
		resetSelectedChordTypes()
		resetSelectedInversionStates()
		updateScaleData()
		updateScaleDegreeHeaders()
		self:restartGui()
	end
	
	local scaleName = getScaleType()
	self:addDropdown(scaleTypeXpos, scaleTypeYpos, scaleTypeWidth, scaleTypeHeight, scaleNames, scaleName, onScaleTypeSelection)
end

function Interface:addScaleNotesTextLabel()

	local getScaleNotesTextCallback = function() return getScaleNotesText() end
	local scaleNotesXpos = xMargin+xPadding+labelWidth+scaleTonicNoteWidth+scaleTypeWidth+horizontalMargin*2+4
	local scaleNotesYpos = yMargin+yPadding+1
	local scaleNotesWidth = 360
	local scaleNotesHeight = 15
	self:addLabel(scaleNotesXpos, scaleNotesYpos, scaleNotesWidth, scaleNotesHeight, getScaleNotesTextCallback)
end