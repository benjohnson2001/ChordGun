local resourcePath = reaper.GetResourcePath()
require(resourcePath .. "/Scripts/ChordGun/interface/Interface")
require(resourcePath .. "/Scripts/ChordGun/interface/Colors")

clearConsoleWindow()
--showGui()

local interface = Interface:init("ChordGun", 383, 200, 675, 510)
interface:show()
interface:addFrame(9, 9, 400, 400)
interface:addButton("Cm")
interface:addLabel("iii")

local function Main()

	local char = gfx.getchar()
	if char ~= -1 then
		reaper.defer(Main)
	end
	
	interface:update()
end

Main()

