local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/src"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scaleData")
require(workingDirectory .. "/interface/handleInput")


--clearConsoleWindow()
updateScaleData()

local interface = Interface:init("ChordGun")
interface:startGui()

local function windowHasNotBeenClosed()
	return inputCharacter ~= -1
end

local function main()

	reaper.DockWindowActivate("ChordGun")
	handleInput()

	if windowHasNotBeenClosed() then
		reaper.runloop(main)
	end
	
	interface:update()
end

local function dockWindow()
	gfx.dock(0x0201)
end

dockWindow()

main()
reaper.atexit(stopAllNotesFromPlaying)
