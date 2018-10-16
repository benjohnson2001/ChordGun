local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/interface/Colors")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scaleData")
require(workingDirectory .. "/test")

clearConsoleWindow()
updateScaleData()

local x = 300
local y = 200
local width = 675
local height = 520

local interface = Interface:init("ChordGun", x, y, width, height)
interface:startGui()

local function windowHasNotBeenClosed()
	return gfx.getchar() ~= -1
end

local function main()

	if windowHasNotBeenClosed() then
		reaper.defer(main)
	end
	
	interface:update()
end

main()

