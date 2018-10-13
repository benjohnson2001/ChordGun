local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/util")
require(resourcePath .. "/Scripts/ChordGun/Interface/colors")
require(resourcePath .. "/Scripts/ChordGun/Interface/util")

Dropdown = {}
Dropdown.__index = Dropdown

local radius = 5

function Dropdown:new(text, x, y, width, height)

  local self = {}
  setmetatable(self, Dropdown)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end