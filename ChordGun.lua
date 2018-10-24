<<<<<<< HEAD
local slash = package.config:sub(1,1)
local workingDirectory = reaper.GetResourcePath() .. slash .. "Scripts" .. slash .. "ChordGun"
require(workingDirectory .. slash .. "interface" .. slash .. "Interface")
require(workingDirectory .. slash .. "interface" .. slash .. "Colors")
require(workingDirectory .. slash .. "preferences")
require(workingDirectory .. slash .. "scaleData")
require(workingDirectory .. slash .. "test")
=======
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scaleData")
>>>>>>> tmp

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

