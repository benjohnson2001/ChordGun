local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"

local xMargin = 12
local yMargin = 12 + keySelectionFrameHeight + 6
local xPadding = 4
local yPadding = 30

function Interface:addBottomFrame()

	local chordButtonsFrameHeight = self.height - yMargin - 6
	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, chordButtonsFrameHeight)

	for i = 1, 7 do

		local headerText = getScaleDegreeHeaders(i)
		local headerXpos = xMargin+xPadding
		local headerYpos = yMargin+yPadding
		local headerWidth = 90
		local headerHeight = 25
		local innerSpacing = 2
		self:addHeader(headerText, headerXpos + (headerWidth+innerSpacing)*(i-1), headerYpos, headerWidth, headerHeight)
	end
end