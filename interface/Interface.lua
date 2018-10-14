local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/Button")
require(resourcePath .. "/Scripts/ChordGun/Interface/Label")
require(resourcePath .. "/Scripts/ChordGun/Interface/Frame")
require(resourcePath .. "/Scripts/ChordGun/Interface/Dropdown")

Interface = {}
Interface.__index = Interface

function Interface:init(name, x, y, width, height)

  local self = {}
  setmetatable(self, Interface)

  self.name = name
  self.x = y
  self.x = y
  self.width = width
  self.height = height

  self.elements = {}

  return self
end

function Interface:show()

	gfx.clear = reaper.ColorToNative(36, 36, 36)
	gfx.init(self.name, self.width, self.height, 0, self.x, self.y)
end

function Interface:updateElements()

	for _, element in pairs(self.elements) do
		element:update()
	end
end

function Interface:update()

	self:updateElements()


	if not mouseButtonIsNotPressedDown and gfx.mouse_cap & 1 ~= 1 then
		mouseButtonIsNotPressedDown = true
	end

	gfx.update()
end

function doThis()
	print("ur mom")
end

function Interface:addButton(buttonText)

	local x = 20
	local y = 20
	local buttonWidth = 73
	local buttonHeight = 30
	local button = Button:new(buttonText, x, y, buttonWidth, buttonHeight, doThis)
	table.insert(self.elements, button)
end

function Interface:addLabel(labelText)

	local x = 100
	local y = 50
	local labelWidth = 73
	local labelHeight = 25
	local label = Label:new(labelText, x, y, labelWidth, labelHeight)
	table.insert(self.elements, label)
end

function Interface:addFrame(x, y, frameWidth, frameHeight)

	local frame = Frame:new(x, y, frameWidth, frameHeight)
	table.insert(self.elements, frame)
end

function Interface:addDropdown(dropdownText)

	local x = 200
	local y = 150

	local dropdownWidth = 73
	local dropdownHeight = 14+1
	local dropdown = Dropdown:new(dropdownText, x, y, dropdownWidth, dropdownHeight, {"option1", "option2", "option3", "option4"}, 2)
	table.insert(self.elements, dropdown)
end
