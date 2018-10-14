local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/colors")
require(resourcePath .. "/Scripts/ChordGun/Interface/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/globalState")

Dropdown = {}
Dropdown.__index = Dropdown

local radius = 5

function Dropdown:new(text, x, y, width, height)

  local self = {}
  setmetatable(self, Dropdown)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Dropdown:drawCorners(offset)
  gfx.circle(self.x + radius + offset, self.y + radius + offset, radius, true)
	gfx.circle(self.x + radius + offset, self.y + self.height - radius - offset, radius, true)
end

function Dropdown:drawEnds(offset)
  gfx.rect(self.x + offset, self.y + radius + offset, radius, self.height - radius * 2 - 2 * offset, true)
  gfx.rect(self.x + self.width - radius - offset, self.y + radius + offset, radius + 1, self.height - radius * 2 - 2 * offset, true)
end

function Dropdown:drawBodyAndSides(offset)
  gfx.rect(self.x + radius + offset, self.y + offset, self.width - radius * 2 - 2 * offset, self.height - radius - 2 * offset, true)
end

function Dropdown:drawLabelOutline()

  setDrawColorToLabelOutline()
  self:drawCorners(0)
  self:drawEnds(0)
  self:drawBodyAndSides(0)
end

function Dropdown:drawRoundedRectangle()

  setDrawColorToLabelBackground()
  self:drawCorners(1)
  self:drawEnds(1)
  self:drawBodyAndSides(1)
end

function Dropdown:drawRoundedRectangles()
  
  self:drawLabelOutline()
  self:drawRoundedRectangle()
end

function Dropdown:drawText()

	setDrawColorToDropdownText()
	local stringWidth, stringHeight = gfx.measurestr(self.text)
	gfx.x = self.x + ((self.width - stringWidth) * 2 / 5)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(self.text)
end

local function dropdownHasBeenClicked(dropdown)
	return mouseIsHoveringOver(dropdown) and gfx.mouse_cap & 1 == 1
end

function Dropdown:openMenu()
	print("what what")
end

function Dropdown:update()

		self:drawRoundedRectangles()
		self:drawText()

		if mouseButtonIsNotPressedDown and dropdownHasBeenClicked(self) then
			mouseButtonIsNotPressedDown = false
			self.openMenu()
		end
end