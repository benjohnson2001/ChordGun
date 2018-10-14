local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/colors")
require(workingDirectory .. "/interface/util")
require(workingDirectory .. "/interface/globalState")

Button = {}
Button.__index = Button

function Button:new(text, x, y, width, height, onPressCallback, onShiftPressCallback)

  local self = {}
  setmetatable(self, Button)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.selected = false
  self.onPressCallback = onPressCallback
  self.onShiftPressCallback = onShiftPressCallback

  return self
end

function Button:drawButtonRectangle()

		if self.selected then

			if mouseIsHoveringOver(self) then
				setDrawColorToHighlightedSelectedButton()
			else
				setDrawColorToSelectedButton()
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

function Button:drawButtonOutline()

		setDrawColorToButtonOutline()
		gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function Button:drawRectangles()

	self:drawButtonRectangle()
	self:drawButtonOutline()	
end

function Button:drawText()

		if self.selected then

			if mouseIsHoveringOver(self) then
				setDrawColorToSelectedButtonText()
			else
				setDrawColorToHighlightedSelectedButtonText()
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

function Button:update()

		self:drawRectangles()
		self:drawText()

		if mouseButtonIsNotPressedDown and buttonHasBeenClicked(self) then
			self.selected = true
			mouseButtonIsNotPressedDown = false

			if shiftModifierIsHeldDown() then
				self.onShiftPressCallback()
			else
				self.onPressCallback()
			end
		end
end