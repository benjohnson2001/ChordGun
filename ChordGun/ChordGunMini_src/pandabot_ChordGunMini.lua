-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/ChordGunMini_src"
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

	handleInput()

	if windowHasNotBeenClosed() then
		reaper.runloop(main)
	end
	
	interface:update()
end

main()



-- If you want the ChordGun window to always be on top then do the following things:
--
-- 1. install julian sader extension https://forum.cockos.com/showthread.php?t=212174
--
-- 2. uncomment the following code:
--
-- 		if (reaper.JS_Window_Find) then
-- 			local hwnd = reaper.JS_Window_Find("ChordGun", true)
-- 			reaper.JS_Window_SetZOrder(hwnd, "TOPMOST", hwnd)
-- 		end
--
--
--
-- Note that this only works on Windows machines