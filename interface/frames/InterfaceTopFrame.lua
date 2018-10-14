local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/scales")

scaleNames = {}
for key, scale in ipairs(scales) do
  table.insert(scaleNames, scale['name'])
end

local margin = 12
local padding = 5

local keySelectionFrameHeight = 25
function Interface:addKeySelectionComponents()

	self:addFrame(margin, margin, self.width - 2 * margin, keySelectionFrameHeight)

	local labelText = "Scale: "
	self:addLabel(labelText, margin+padding, margin+padding, 60, 16)

	local stringWidth = gfx.measurestr(labelText)
	self:addDropdown(margin+padding+stringWidth+15, margin+padding+1, 150, 14+1, scaleNames, 1)
end