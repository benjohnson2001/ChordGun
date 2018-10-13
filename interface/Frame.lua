local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/colors")
require(resourcePath .. "/Scripts/ChordGun/Interface/util")

Frame = {}
Frame.__index = Frame

local radius = 10

function Frame:new(x, y, width, height)

  local self = {}
  setmetatable(self, Frame)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Frame:drawCorners(offset)
  gfx.circle(self.x + radius + offset, self.y + radius + offset, radius, true)
--  gfx.circle(self.x + self.width - radius - offset, self.y + radius - offset, radius, true)
--  gfx.circle(self.x + self.width - radius + offset, self.y + self.height - radius - offset, radius, true)
--  gfx.circle(self.x + radius - offset, self.y + self.height - radius - offset, radius, true)
end

function Frame:drawEnds(offset)
  gfx.rect(self.x + offset, self.y + radius + offset, radius, self.height - radius * 2, true)
  gfx.rect(self.x + self.width - radius - offset, self.y + radius + offset, radius + 1, self.height - radius * 2, true)
end

function Frame:drawBodyAndSides(offset)
  gfx.rect(self.x + radius + offset, self.y + offset, self.width - radius * 2 - offset, self.height + 1 - offset, true)
end

function Frame:drawFrameOutline()

  setDrawColorToFrameOutline()
  self:drawCorners(0)
  self:drawEnds(0)
  self:drawBodyAndSides(0)
end

function Frame:drawRectangle()

  setDrawColorToFrameBackground()
  self:drawCorners(2)
  self:drawEnds(2)
  self:drawBodyAndSides(2)
end

function Frame:drawRectangles()
  
  self:drawFrameOutline()
  self:drawRectangle()
end

function Frame:update()

    self:drawRectangles()
end