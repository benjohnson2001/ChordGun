function mouseIsHoveringOver(element)

	local x = gfx.mouse_x
	local y = gfx.mouse_y

	local isInHorizontalRegion = (x >= element.x and x < element.x+element.width)
	local isInVerticalRegion = (y >= element.y and y < element.y+element.height)
	return isInHorizontalRegion and isInVerticalRegion
end

function leftMouseButtonIsHeldDown()
  return gfx.mouse_cap & 1 == 1
end

function leftMouseButtonIsNotHeldDown()
  return gfx.mouse_cap & 1 ~= 1
end

function clearConsoleWindow()
  
  reaper.ShowConsoleMsg("")
end

function print(arg)
  
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
end

