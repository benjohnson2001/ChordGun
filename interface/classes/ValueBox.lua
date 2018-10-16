local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/colors")
require(workingDirectory .. "/util")

ValueBox = {}
ValueBox.__index = ValueBox

function ValueBox:new(text, x, y, width, height, onLeftButtonPressCallback, onRightButtonPressCallback)

  local self = {}
  setmetatable(self, ValueBox)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.onLeftButtonPressCallback = onLeftButtonPressCallback
  self.onRightButtonPressCallback = onRightButtonPressCallback

  return self
end

function ValueBox:drawRectangle()

    setDrawColorToValueBoxBackground()
    gfx.rect(self.x, self.y, self.width, self.height)
end

function ValueBox:drawRectangleOutline()

    setDrawColorToValueBoxOutline()
    gfx.rect(self.x-1, self.y-1, self.width+1, self.height+1, false)
end

function ValueBox:drawRectangles()

  self:drawRectangle()
  self:drawRectangleOutline() 
end

function ValueBox:drawLeftArrow()

  local imagePath = workingDirectory .. "/interface/leftArrow.png"
  gfx.x = self.x + 2
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function ValueBox:drawRightArrow()

  local imagePath = workingDirectory .. "/interface/rightArrow.png"
  local imageWidth = 9
  gfx.x = self.x + self.width - imageWidth - 3
  gfx.y = self.y + 2
  local imageIndex = gfx.loadimg(0, imagePath)
  gfx.blit(imageIndex, 1.0, 0.0)
end

function ValueBox:drawImages()
  self:drawLeftArrow()
  self:drawRightArrow()
end

function ValueBox:drawText()

	setDrawColorToValueBoxText()
	local stringWidth, stringHeight = gfx.measurestr(self.text)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(self.text)
end

HitArea = {}
HitArea.__index = HitArea
function HitArea:new(x, y, width, height)
  local self = {}
  setmetatable(self, HitArea)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

local hitAreaWidth = 18

local function leftButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x-1, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

local function rightButtonHasBeenClicked(valueBox)
  local hitArea = HitArea:new(valueBox.x+valueBox.width-hitAreaWidth, valueBox.y-1, hitAreaWidth, valueBox.height+1)
  return mouseIsHoveringOver(hitArea) and leftMouseButtonIsHeldDown()
end

function ValueBox:update()

  self:drawRectangles()
  self:drawImages()
  self:drawText()

  if mouseButtonIsNotPressedDown and leftButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    self.onLeftButtonPressCallback()
  end

  if mouseButtonIsNotPressedDown and rightButtonHasBeenClicked(self) then
    mouseButtonIsNotPressedDown = false
    self.onRightButtonPressCallback()
  end
end