local slash = package.config:sub(1,1)
local workingDirectory = reaper.GetResourcePath() .. slash .. "Scripts" .. slash .. "ChordGun"
require(workingDirectory .. slash .. "interface" .. slash .. "colors")
require(workingDirectory .. slash .. "util")

Label = {}
Label.__index = Label

function Label:new(x, y, width, height, getTextCallback)

  local self = {}
  setmetatable(self, Label)

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.getTextCallback = getTextCallback

  return self
end

function Label:drawRedOutline()
  setDrawColorToRed()
  gfx.rect(self.x, self.y, self.width, self.height, false)
end

function Label:drawText(text)

	setDrawColorToText()
	local stringWidth, stringHeight = gfx.measurestr(text)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
  gfx.drawstr(text)
end

function Label:update()
  --self:drawRedOutline()

  local text = self.getTextCallback()
  self:drawText(text)
end