local function hex2rgb(arg) 

	local r, g, b = arg:match('(..)(..)(..)')
	r = tonumber(r, 16)/255
	g = tonumber(g, 16)/255
	b = tonumber(b, 16)/255
	return r, g, b
end

local function setColor(hexColor)

	local r, g, b = hex2rgb(hexColor)
	gfx.set(r, g, b, 1)
end

--[[ window ]]--

function setDrawColorToBackground()
	setColor("242424")
end

--[[ buttons ]]--

function setDrawColorToNormalButton()
	setColor("2D2D2D")
end

function setDrawColorToHighlightedButton()
	setColor("474747")
end

function setDrawColorToSelectedButton()
	setColor("DCDCDC")
end

function setDrawColorToHighlightedSelectedButton()
	setColor("FFFFFF")
end

function setDrawColorToButtonOutline()
	setColor("1D1D1D")
end

--[[ text ]]--

function setDrawColorToNormalText()
	setColor("D7D7D7")
end

function setDrawColorToHighlightedText()
	setColor("EEEEEE")
end

function setDrawColorToSelectedText()
	setColor("121212")
end

function setDrawColorToHighlightedSelectedText()
	setColor("000000")
end


--[[ buttons ]]--

function setDrawColorToLabelOutline()
	setColor("151515")
end

function setDrawColorToLabelBackground()
	setColor("242424")
end

function setDrawColorToLabelText()
	setColor("818181")
end


--[[ frame ]]--
function setDrawColorToFrameOutline()
	setColor("0D0D0D")
end

function setDrawColorToFrameBackground()
	setColor("181818")
end



function setDrawColorToRed()
	setColor("FF0000")
end

--[[
function setDrawColorToBackground()

	local r, g, b
	local backgroundColor = {36, 36, 36, 1}		-- #242424
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToNormalButton()

	local backgroundColor = {45, 45, 45, 1}		-- #2D2D2D
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToHighlightedButton()

	local backgroundColor = {71, 71, 71, 1}		-- #474747
	gfx.set(table.unpack(backgroundColor))
end

function setDrawColorToSelectedButton()

	local backgroundColor = {220, 220, 220, 1}	-- #DCDCDC
	gfx.set(table.unpack(backgroundColor))
end
]]--