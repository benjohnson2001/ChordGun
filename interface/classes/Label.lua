local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/colors")
require(workingDirectory .. "/interface/util")

Label = {}
Label.__index = Label

function Label:new(text, x, y, width, height)

  local Label = {}
  setmetatable(self, Label)

  self.text = text
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  return self
end

function Label:drawText()

	setDrawColorToText()
	local stringWidth, stringHeight = gfx.measurestr(self.text)
	gfx.x = self.x + ((self.width - stringWidth) / 2)
	gfx.y = self.y + ((self.height - stringHeight) / 2)
	gfx.drawstr(self.text)
end

function Label:update()
		self:drawText()
end