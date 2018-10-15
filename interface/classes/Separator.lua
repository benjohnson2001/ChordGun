local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/colors")
require(workingDirectory .. "/util")

Separator = {}
Separator.__index = Separator

function Separator:new(x, y, width, height)

  local self = {}
  setmetatable(self, Separator)

  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Separator:drawLines()

	setDrawColorToSeparator()

  local antiAliasingValue = 1
	gfx.line(self.x, self.y+self.height/2-1, self.x+self.width, self.y+self.height/2-1, antiAliasingValue)
end

function Separator:update()
  self:drawLines()
end