local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/classes/Button")
require(workingDirectory .. "/interface/classes/Header")
require(workingDirectory .. "/interface/classes/Label")
require(workingDirectory .. "/interface/classes/Frame")
require(workingDirectory .. "/interface/classes/Dropdown")


Interface = {}
Interface.__index = Interface

function Interface:init(name, x, y, width, height)

  local self = {}
  setmetatable(self, Interface)

  self.name = name
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.elements = {}

  return self
end

function Interface:addMainWindow()

	gfx.clear = reaper.ColorToNative(36, 36, 36)
	local dockState = 0
	gfx.init(self.name, self.width, self.height, dockState, self.x, self.y)
end

function doThis()
	print("ur mom")
end

function Interface:addButton(buttonText)

	local x = 220
	local y = 220
	local buttonWidth = 73
	local buttonHeight = 30
	local button = Button:new(buttonText, x, y, buttonWidth, buttonHeight, doThis)
	table.insert(self.elements, button)
end

function Interface:addHeader(headerText, x, y, width, height)

	local header = Header:new(headerText, x, y, width, height)
	table.insert(self.elements, header)
end

function Interface:addFrame(x, y, frameWidth, frameHeight)

	local frame = Frame:new(x, y, frameWidth, frameHeight)
	table.insert(self.elements, frame)
end

function Interface:addLabel(text, x, y, width, height)

	local label = Label:new(text, x, y, width, height)
	table.insert(self.elements, label)
end

function Interface:addDropdown(x, y, width, height, options, defaultOptionIndex)

	local dropdown = Dropdown:new(x, y, width, height, options, defaultOptionIndex)
	table.insert(self.elements, dropdown)
end

function Interface:addChordButtonComponents()

	self:addButton("Cm")
	self:addHeader("iii")
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

require(workingDirectory .. "/interface/frames/InterfaceTopFrame")
require(workingDirectory .. "/interface/frames/InterfaceBottomFrame")