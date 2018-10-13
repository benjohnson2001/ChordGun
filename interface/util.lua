function mouseIsHoveringOver(button)

	local x = gfx.mouse_x
	local y = gfx.mouse_y

	local isInHorizontalRegion = (x >= button.x and x < button.x+button.width)
	local isInVerticalRegion = (y >= button.y and y < button.y+button.height)
	return isInHorizontalRegion and isInVerticalRegion
end