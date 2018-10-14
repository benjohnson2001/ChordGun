local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/interface/Colors")

clearConsoleWindow()

local x = 383
local y = 200
local width = 675
local height = 510

local interface = Interface:init("ChordGun", x, y, width, height)
interface:addMainWindow()
interface:addKeySelectionComponents()
interface:addChordButtonComponents()

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

