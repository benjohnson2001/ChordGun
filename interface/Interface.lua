local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/classes/ChordButton")
require(workingDirectory .. "/interface/classes/Header")
require(workingDirectory .. "/interface/classes/Label")
require(workingDirectory .. "/interface/classes/Frame")
require(workingDirectory .. "/interface/classes/Dropdown")
require(workingDirectory .. "/interface/classes/ValueBox")


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

function Interface:addChordButton(buttonText, x, y, width, height, scaleNoteIndex, chordTypeIndex, chordIsInScale)

	local chordButton = ChordButton:new(buttonText, x, y, width, height, scaleNoteIndex, chordTypeIndex, chordIsInScale)
	table.insert(self.elements, chordButton)
end

function Interface:addHeader(headerText, x, y, width, height, getTextCallback)

	local header = Header:new(headerText, x, y, width, height, getTextCallback)
	table.insert(self.elements, header)
end

function Interface:addFrame(x, y, width, height)

	local frame = Frame:new(x, y, width, height)
	table.insert(self.elements, frame)
end

function Interface:addLabel(x, y, width, height, getTextCallback)

	local label = Label:new(x, y, width, height, getTextCallback)
	table.insert(self.elements, label)
end

function Interface:addDropdown(x, y, width, height, options, defaultOptionIndex, onSelectionCallback)

	local dropdown = Dropdown:new(x, y, width, height, options, defaultOptionIndex, onSelectionCallback)
	table.insert(self.elements, dropdown)
end

function Interface:addValueBox(text, x, y, width, height, onPressOfLeftButtonCallback, onPressOfRightButtonCallback)

	local valueBox = ValueBox:new(text, x, y, width, height, onPressOfLeftButtonCallback, onPressOfRightButtonCallback)
	table.insert(self.elements, valueBox)
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