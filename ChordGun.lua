local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/interface/Colors")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scaleData")

clearConsoleWindow()
updateScaleData()


local x = 300
local y = 200
local width = 675
local height = 520

local interface = Interface:init("ChordGun", x, y, width, height)
interface:addMainWindow()
interface:addTopFrame()
interface:addBottomFrame()



local function windowHasNotBeenClosed()
	return gfx.getchar() ~= -1
end

local function Main()

	if windowHasNotBeenClosed() then
		reaper.defer(Main)
	end
	
	interface:update()
end

Main()

