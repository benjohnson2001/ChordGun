local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/scaleFunctions")

local xMargin = 8
local yMargin = 8 + keySelectionFrameHeight + 6
local xPadding = 7
local yPadding = 30

local headerHeight = 25
local inversionLabelWidth = 80
local inversionValueBoxWidth = 55
local chordTextWidth = nil

function Interface:addBottomFrame()

	local chordButtonsFrameHeight = self.height - yMargin - 6
	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, chordButtonsFrameHeight)
  
  self:addChordTextLabel()
  self:addInversionLabel()
  self:addInversionValueBox()
  
  self:addHeaders()
	self:addChordButtons()
end

function Interface:addChordTextLabel()

  local getChordTextCallback = function() return getChordText() end
  local chordTextXpos = xMargin + xPadding
  local chordTextYpos = yMargin + 4
  chordTextWidth = self.width - 4 * xMargin - inversionLabelWidth - inversionValueBoxWidth - 6
  local chordTextHeight = 24
  self:addLabel(chordTextXpos, chordTextYpos, chordTextWidth, chordTextHeight, getChordTextCallback)
end

function Interface:addInversionLabel()

  local inversionLabelText = "Inversion:"
  local inversionLabelXPos = xMargin + xPadding + chordTextWidth
  local inversionLabelYPos = yMargin + 4
  local stringWidth, _ = gfx.measurestr(labelText)
  local inversionLabelTextHeight = 24

  self:addLabel(inversionLabelXPos, inversionLabelYPos, inversionLabelWidth, inversionLabelTextHeight, function() return inversionLabelText end)
end

function Interface:addInversionValueBox()

  local onPressOfLeftButton = function()
    print("pressed the left")
  end
  local onPressOfRightButton = function() print("pressed the right") end

  local inversionValueBoxXPos = xMargin + xPadding + chordTextWidth + inversionLabelWidth + 2
  local inversionValueBoxYPos = yMargin + 9
  local inversionValueBoxHeight = 15
  self:addValueBox(inversionValueBoxXPos, inversionValueBoxYPos, inversionValueBoxWidth, inversionValueBoxHeight, onPressOfLeftButton, onPressOfRightButton)

end

function Interface:addHeaders()
  
  for i = 1, #scaleNotes do

    local headerWidth = 90
    local innerSpacing = 2

    local headerXpos = xMargin+xPadding-1 + headerWidth * (i-1) + innerSpacing * i
    local headerYpos = yMargin+yPadding
    self:addHeader(headerXpos, headerYpos, headerWidth, headerHeight, function() return getScaleDegreeHeader(i) end)
  end
end

function Interface:addChordButtons()

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do

    if noteIsInScale(note) then

      for chordTypeIndex, chord in ipairs(scaleChords[scaleNoteIndex]) do

      	local text = getScaleNoteName(scaleNoteIndex) .. chord['display']

      	local buttonWidth = 90
      	local buttonHeight = 30
				local innerSpacing = 2
      	
      	local xPos = xMargin + xPadding + buttonWidth * (scaleNoteIndex-1) + innerSpacing * scaleNoteIndex
      	local yPos = yMargin + yPadding + headerHeight + buttonHeight * (chordTypeIndex-1) + innerSpacing * (chordTypeIndex-1) - 3
  
  			local numberOfChordsInScale = getNumberOfScaleChordsForScaleNoteIndex(scaleNoteIndex)

       	if chordTypeIndex > numberOfChordsInScale then
          local chordIsInScale = false
      		self:addChordButton(text, xPos, yPos, buttonWidth, buttonHeight, scaleNoteIndex, chordTypeIndex, chordIsInScale)
      	else
          local chordIsInScale = true
      		self:addChordButton(text, xPos, yPos, buttonWidth, buttonHeight, scaleNoteIndex, chordTypeIndex, chordIsInScale)
      	end     	
      end
      
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end