
local startingTime = nil

function resetTimer()

	startingTime = reaper.time_precise()
end

function fiveSecondsHavePassed()

	local currentTime = reaper.time_precise()

	if startingTime == nil then
		return false
	end

	if currentTime - startingTime > 5 then
		return true
	else
		return false
	end
end