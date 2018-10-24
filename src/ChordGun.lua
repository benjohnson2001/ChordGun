local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scaleData")


--clearConsoleWindow()
updateScaleData()

local x = 300
local y = 200
local width = 775
local height = 620

local interface = Interface:init("ChordGun", x, y, width, height)
interface:startGui()

local function windowHasNotBeenClosed()
	return gfx.getchar() ~= -1
end

local function main()

	if windowHasNotBeenClosed() then
		reaper.runloop(main)
	end
	
	interface:update()
end

main()

