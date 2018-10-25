local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/interface/classes/ChordButton")
require(workingDirectory .. "/interface/classes/Header")
require(workingDirectory .. "/interface/classes/Label")
require(workingDirectory .. "/interface/classes/Frame")
require(workingDirectory .. "/interface/classes/Dropdown")
require(workingDirectory .. "/interface/classes/ChordInversionValueBox")
require(workingDirectory .. "/interface/classes/OctaveValueBox")
require(workingDirectory .. "/interface/classes/Docker")
require(workingDirectory .. "/util")
require(workingDirectory .. "/globalState")
require(workingDirectory .. "/midiMessages")

Interface = {}
Interface.__index = Interface

local interfaceWidth = 775
local interfaceHeight = 620

local function getInterfaceXPos()

	local _, _, width, _ = reaper.my_getViewport(0, 0, 0, 0, 0, 0, 0, 0, true)
	return width/2 - interfaceWidth/2
end

local function getInterfaceYPos()

	local _, _, _, height = reaper.my_getViewport(0, 0, 0, 0, 0, 0, 0, 0, true)
	return height/2 - interfaceHeight/2
end

local dockerXPadding = 0

function Interface:init(name)

  local self = {}
  setmetatable(self, Interface)

  self.name = name
  self.x = getInterfaceXPos()
  self.y = getInterfaceYPos()
  self.width = interfaceWidth
  self.height = interfaceHeight

  self.elements = {}

  return self
end

function Interface:restartGui()
	self.elements = {}
	self:startGui()
end

function Interface:startGui()

	if windowIsDocked() then
		dockerXPadding = getInterfaceXPos()
	end

	self:addMainWindow()
	self:addDocker()
	self:addTopFrame()
	self:addBottomFrame()	
end

function Interface:addMainWindow()

	gfx.clear = reaper.ColorToNative(36, 36, 36)
	local dockState = gfx.dock(-1)
	gfx.init(self.name, self.width, self.height, dockState, self.x, self.y)
end

function Interface:addDocker()

	local docker = Docker:new()
	table.insert(self.elements, docker)
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

function Interface:addChordInversionValueBox(x, y, width, height)

	local valueBox = ChordInversionValueBox:new(x, y, width, height)
	table.insert(self.elements, valueBox)
end

function Interface:addOctaveValueBox(x, y, width, height)

	local valueBox = OctaveValueBox:new(x, y, width, height)
	table.insert(self.elements, valueBox)
end

function Interface:updateElements()

	for _, element in pairs(self.elements) do
		element:update()
	end
end

function Interface:update()

	self:updateElements()

	if not mouseButtonIsNotPressedDown and leftMouseButtonIsNotHeldDown() then
		mouseButtonIsNotPressedDown = true
	end

	if chordPreviewTimer:timeHasElapsed() then
		stopAllNotesFromPlaying()
		chordPreviewTimer:stop()
	end

	if scaleTonicNote ~= getScaleTonicNote() then
		scaleTonicNote = getScaleTonicNote()
		updateScaleData()
		self:restartGui()
	end

	if scaleType ~= getScaleType() then
		scaleType = getScaleType()
		updateScaleData()
		self:restartGui()
	end

	if windowIsDockedState ~= windowIsDocked() then
		windowIsDockedState = windowIsDocked()
		self:restartGui()
	end

	gfx.update()
end

require(workingDirectory .. "/interface/frames/InterfaceTopFrame")
require(workingDirectory .. "/interface/frames/InterfaceBottomFrame")