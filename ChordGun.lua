local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/interface/Interface")
require(workingDirectory .. "/interface/Colors")
require(workingDirectory .. "/Preferences")

clearConsoleWindow()

local x = 383
local y = 200
local width = 675
local height = 510

local interface = Interface:init("ChordGun", x, y, width, height)
interface:addMainWindow()
interface:addTopFrame()
interface:addBottomFrame()


local storedValue = getThisValue()
print("storedValue: " .. storedValue)
local myTable = getTableFromString(storedValue)
print("table length: " .. #myTable)
print("table element 1: " .. myTable[1])
print("table element 2: " .. myTable[2])
print("table element 3: " .. myTable[3])
print("table element 4: " .. myTable[4])
print("table element 5: " .. myTable[5])
print("table element 6: " .. myTable[6])
print("table element 7: " .. myTable[7])

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

