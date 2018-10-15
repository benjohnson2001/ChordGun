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

keySelectionFrameHeight = 25
function Interface:addTopFrame()

	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, keySelectionFrameHeight)

	local labelText = "Scale:"
	local labelXpos = xMargin+xPadding
	local labelYpos = yMargin+yPadding
	local labelWidth = 50
	local labelHeight = 16
	self:addLabel(labelText, labelXpos, labelYpos, labelWidth, labelHeight)
	
	local labelWidth = gfx.measurestr(labelText)
	local horizontalMargin = 8

	local scaleTonicNoteXpos = xMargin+xPadding+labelWidth+horizontalMargin
	local scaleTonicNoteYpos = yMargin+yPadding+1
	local scaleTonicNoteWidth = 50
	local scaleTonicNoteHeight = 15
	self:addDropdown(scaleTonicNoteXpos, scaleTonicNoteYpos, scaleTonicNoteWidth, scaleTonicNoteHeight, notes, 1)

	local scaleTypeXpos = xMargin+xPadding+labelWidth+scaleTonicNoteWidth+horizontalMargin*1.5
	local scaleTypeYpos = yMargin+yPadding+1
	local scaleTypeWidth = 150
	local scaleTypeHeight = 15
	self:addDropdown(scaleTypeXpos, scaleTypeYpos, scaleTypeWidth, scaleTypeHeight, scaleNames, 1)

	local scaleNotesXpos = xMargin+xPadding+labelWidth+scaleTonicNoteWidth+scaleTypeWidth+horizontalMargin*2
	local scaleNotesYpos = yMargin+yPadding+1
	local scaleNotesWidth = 360
	local scaleNotesHeight = 15
	self:addLabel("scaleNotes", scaleNotesXpos, scaleNotesYpos, scaleNotesWidth, scaleNotesHeight)
end