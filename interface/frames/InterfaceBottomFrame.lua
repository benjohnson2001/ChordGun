local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"

local xMargin = 12
local yMargin = 12 + keySelectionFrameHeight + 6
local xPadding = 16
local yPadding = 5


function Interface:addBottomFrame()

	local chordButtonsFrameHeight = self.height - yMargin - 6
	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, chordButtonsFrameHeight)
end