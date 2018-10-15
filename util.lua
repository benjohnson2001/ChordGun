function mouseIsHoveringOver(button)

	local x = gfx.mouse_x
	local y = gfx.mouse_y

	local isInHorizontalRegion = (x >= button.x and x < button.x+button.width)
	local isInVerticalRegion = (y >= button.y and y < button.y+button.height)
	return isInHorizontalRegion and isInVerticalRegion
end

function clearConsoleWindow()
  
  reaper.ShowConsoleMsg("")
end

function print(arg)
  
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
end

function copy(obj)
  if type(obj) ~= 'table' then return obj end
  local res = {}
  for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  return res
end