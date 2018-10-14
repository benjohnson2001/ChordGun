local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Button")
require(workingDirectory .. "/interface/Header")
require(workingDirectory .. "/interface/Label")
require(workingDirectory .. "/interface/Frame")
require(workingDirectory .. "/interface/Dropdown")

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

function Interface:addMainWindow()

	gfx.clear = reaper.ColorToNative(36, 36, 36)
	gfx.init(self.name, self.width, self.height, 0, self.x, self.y)
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

function Interface:addHeader(headerText)

	local x = 300
	local y = 250
	local headerWidth = 73
	local headerHeight = 25
	local header = Header:new(headerText, x, y, headerWidth, headerHeight)
	table.insert(self.elements, header)
end

function Interface:addFrame(x, y, frameWidth, frameHeight)

	local frame = Frame:new(x, y, frameWidth, frameHeight)
	table.insert(self.elements, frame)
end

function Interface:addLabel(text, x, y, frameWidth, frameHeight)

	local label = Label:new(text, x, y, frameWidth, frameHeight)
	table.insert(self.elements, label)
end

function Interface:addDropdown(dropdownText)

	local x = 200
	local y = 150

	local dropdownWidth = 73
	local dropdownHeight = 14+1
	local dropdown = Dropdown:new(dropdownText, x, y, dropdownWidth, dropdownHeight, {"option1", "option2", "option3", "option4"}, 2)
	table.insert(self.elements, dropdown)
end


local keySelectionFrameHeight = 50
function Interface:addKeySelectionComponents()

	local margin = 9
	self:addFrame(margin, margin, self.width-2*margin, keySelectionFrameHeight)

	self:addDropdown("Major")
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
