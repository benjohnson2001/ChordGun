local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/colors")
require(resourcePath .. "/Scripts/ChordGun/Interface/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/globalState")

Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:new(text, x, y, width, height, options, defaultOptionIndex)

  local self = {}
  setmetatable(self, Dropdown)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.selectedIndex = defaultOptionIndex
  self.options = options
  self.dropdownList = {}
  self:updateDropdownList()
  return self
end

function Dropdown:drawRectangle()

		setDrawColorToDropdownBackground()
		gfx.rect(self.x, self.y, self.width, self.height)
end

function Dropdown:drawRectangleOutline()

		setDrawColorToDropdownOutline()
		gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function Dropdown:drawRectangles()

	self:drawRectangle()
	self:drawRectangleOutline()	
end

function Dropdown:drawText()

	setDrawColorToDropdownText()
	local stringWidth, stringHeight = gfx.measurestr(self.text)
	gfx.x = self.x + ((self.width - stringWidth) * 1 / 5)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(self.text)
end

function Dropdown:drawImage()

	local imagePath = resourcePath .. "/Scripts/ChordGun/Interface/dropdownIcon.png"
	local imageWidth = 14
	gfx.x = self.x + self.width - imageWidth - 1
	gfx.y = self.y
	local imageIndex = gfx.loadimg(0, imagePath)
	gfx.blit(imageIndex, 1.0, 0.0)
end

local function dropdownHasBeenClicked(dropdown)
	return mouseIsHoveringOver(dropdown) and gfx.mouse_cap & 1 == 1
end

function Dropdown:updateDropdownList()

	self.dropdownList = {}

	for index, option in pairs(self.options) do

		if (self.selectedIndex == index) then
			table.insert(self.dropdownList, "!" .. option)
		else
			table.insert(self.dropdownList, option)
		end
	end
end

function Dropdown:openMenu()

	local selectedIndex = gfx.showmenu(table.concat(self.dropdownList,"|"))

	if selectedIndex <= 0 then
		return
	end

	self.selectedIndex = selectedIndex
	self:updateDropdownList()
end

function Dropdown:update()

		self:drawRectangles()
		self:drawText()
		self:drawImage()
		
		if mouseButtonIsNotPressedDown and dropdownHasBeenClicked(self) then
			mouseButtonIsNotPressedDown = false
			self:openMenu()
		end
end