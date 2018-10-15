local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/colors")
require(workingDirectory .. "/util")
require(workingDirectory .. "/interface/globalState")

ChordButton = {}
ChordButton.__index = ChordButton

function ChordButton:new(text, x, y, width, height, scaleNoteIndex, chordTypeIndex, onPressCallback, onShiftPressCallback)

  local self = {}
  setmetatable(self, ChordButton)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.scaleNoteIndex = scaleNoteIndex
  self.chordTypeIndex = chordTypeIndex
  self.onPressCallback = onPressCallback
  self.onShiftPressCallback = onShiftPressCallback

  return self
end

function ChordButton:isSelectedChordType()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(self.scaleNoteIndex)

	local chordTypeIsSelected = (tonumber(self.chordTypeIndex) == tonumber(selectedChordType))
	local scaleNoteIsNotSelected = (tonumber(self.scaleNoteIndex) ~= tonumber(selectedScaleNote))

	return chordTypeIsSelected and scaleNoteIsNotSelected

end

function ChordButton:isSelectedChordTypeAndSelectedScaleNote()

	local selectedScaleNote = getSelectedScaleNote()
	local selectedChordType = getSelectedChordType(self.scaleNoteIndex)

	local chordTypeIsSelected = (tonumber(self.chordTypeIndex) == tonumber(selectedChordType))
	local scaleNoteIsSelected = (tonumber(self.scaleNoteIndex) == tonumber(selectedScaleNote))

	return chordTypeIsSelected and scaleNoteIsSelected
end


function ChordButton:drawButtonRectangle()

		if self:isSelectedChordTypeAndSelectedScaleNote() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButton()
			else
				setDrawColorToSelectedChordTypeAndScaleNoteButton()
			end

		elseif self:isSelectedChordType() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeButton()
			else
				setDrawColorToSelectedChordTypeButton()
			end

		else

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedButton()
			else
				setDrawColorToNormalButton()
			end
		end

		gfx.rect(self.x, self.y, self.width, self.height)
end

function ChordButton:drawButtonOutline()

		setDrawColorToButtonOutline()
		gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function ChordButton:drawRectangles()

	self:drawButtonRectangle()
	self:drawButtonOutline()	
end

function ChordButton:drawText()

		if self:isSelectedChordTypeAndSelectedScaleNote() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeAndScaleNoteButtonText()
			else
				setDrawColorToSelectedChordTypeAndScaleNoteButtonText()
			end

		elseif self:isSelectedChordType() then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedChordTypeButtonText()
			else
				setDrawColorToSelectedChordTypeButtonText()
			end

		else

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedButtonText()
			else
				setDrawColorToNormalButtonText()
			end
		end

		local stringWidth, stringHeight = gfx.measurestr(self.text)
		gfx.x = self.x + ((self.width - stringWidth) / 2)
		gfx.y = self.y + ((self.height - stringHeight) / 2)
		gfx.drawstr(self.text)
end

local function buttonHasBeenClicked(button)
	return mouseIsHoveringOver(button) and gfx.mouse_cap & 1 == 1
end

local function shiftModifierIsHeldDown()
	return gfx.mouse_cap & 8 == 8
end

function ChordButton:update()

		self:drawRectangles()
		self:drawText()

		if mouseButtonIsNotPressedDown and buttonHasBeenClicked(self) then

			setSelectedScaleNote(self.scaleNoteIndex)
			setSelectedChordType(self.scaleNoteIndex, self.chordTypeIndex)

			mouseButtonIsNotPressedDown = false

			if shiftModifierIsHeldDown() then
				self.onShiftPressCallback()
			else
				self.onPressCallback()
			end
		end
end