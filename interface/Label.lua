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

function Label:drawOutlineCorners()
  gfx.circle(self.x + radius - 1, self.y + radius - 1,  radius, false)
  gfx.circle(self.x + self.width - radius + 1, self.y + radius - 1, radius, false)
end

function Label:drawOutlineEnds()
  gfx.rect(self.x - 1, self.y + radius - 1, radius, self.height - radius * 2 + 2, false)
  gfx.rect(self.x + self.width - radius + 1, self.y + radius - 1, radius + 1, self.height - radius * 2 + 2, false)
end

function Label:drawOutlineBodyAndSides()
  gfx.rect(self.x + radius - 1, self.y - 1, self.width - radius * 2 + 2, self.height - radius + 2, false)
end

function Label:drawCorners()
  gfx.circle(self.x + radius, self.y + radius, radius, true)
  gfx.circle(self.x + self.width - radius, self.y + radius, radius, true)
end

function Label:drawEnds()
  gfx.rect(self.x, self.y + radius, radius, self.height - radius * 2, true)
  gfx.rect(self.x + self.width - radius, self.y + radius, radius + 1, self.height - radius * 2, true)
end

function Label:drawBodyAndSides()
  gfx.rect(self.x + radius, self.y, self.width - radius * 2, self.height - radius, true)
end

function Label:drawRoundedRectangle()

  setDrawColorToLabelBackground()
  self:drawCorners()
  self:drawEnds()
  self:drawBodyAndSides()
end

function Label:drawLabelOutline()
  setDrawColorToLabelOutline()
  self:drawOutlineCorners()
  self:drawOutlineEnds()
  self:drawOutlineBodyAndSides()
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