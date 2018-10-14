local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/colors")
require(resourcePath .. "/Scripts/ChordGun/Interface/util")

Label = {}
Label.__index = Label

local radius = 5

function Label:new(text, x, y, width, height)

  local self = {}
  setmetatable(self, Label)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Label:drawCorners(offset)
  gfx.circle(self.x + radius + offset, self.y + radius + offset, radius, true)
  gfx.circle(self.x + self.width - radius - offset, self.y + radius + offset, radius, true)
end

function Label:drawEnds(offset)
  gfx.rect(self.x + offset, self.y + radius + offset, radius, self.height - radius * 2 - 2 * offset, true)
  gfx.rect(self.x + self.width - radius - offset, self.y + radius + offset, radius + 1, self.height - radius * 2 - 2 * offset, true)
end

function Label:drawBodyAndSides(offset)
  gfx.rect(self.x + radius + offset, self.y + offset, self.width - radius * 2 - 2 * offset, self.height - radius - 2 * offset, true)
end

function Label:drawLabelOutline()

  setDrawColorToLabelOutline()
  self:drawCorners(0)
  self:drawEnds(0)
  self:drawBodyAndSides(0)
end

function Label:drawRoundedRectangle()

  setDrawColorToLabelBackground()
  self:drawCorners(1)
  self:drawEnds(1)
  self:drawBodyAndSides(1)
end

function Label:drawRoundedRectangles()
  
  self:drawLabelOutline()
  self:drawRoundedRectangle()
end


function Label:drawText()

    setDrawColorToLabelText()
    local stringWidth, stringHeight = gfx.measurestr(self.text)
    gfx.x = self.x + ((self.width + 4 * 1 - stringWidth) / 2)
    gfx.y = self.y + ((self.height - 4 * 1 - stringHeight) / 2)
    gfx.drawstr(self.text)
end

function Label:update()

    self:drawRoundedRectangles()
    self:drawText()
end