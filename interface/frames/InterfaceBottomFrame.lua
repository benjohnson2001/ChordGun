local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/scaleFunctions")

local xMargin = 8
local yMargin = 8 + keySelectionFrameHeight + 6
local xPadding = 7
local yPadding = 30

local headerHeight = 25

function Interface:addBottomFrame()

	local chordButtonsFrameHeight = self.height - yMargin - 6
	self:addFrame(xMargin, yMargin, self.width - 2 * xMargin, chordButtonsFrameHeight)

	for i = 1, 7 do

		local headerText = getScaleDegreeHeader(i)
		local headerWidth = 90
		local innerSpacing = 2

		local headerXpos = xMargin+xPadding-1 + headerWidth * (i-1) + innerSpacing * i
		local headerYpos = yMargin+yPadding
		self:addHeader(headerText, headerXpos, headerYpos, headerWidth, headerHeight)
	end

	self:addChordButtons()
end

function Interface:addChordButtons()

  local scaleNoteIndex = 1
  for note = getScaleTonicNote(), getScaleTonicNote() + 11 do

    if noteIsInScale(note) then

      for chordTypeIndex, chord in ipairs(scaleChords[scaleNoteIndex]) do

      	local text = getScaleNoteName(scaleNoteIndex) .. chord['display']

      	local width = 90
      	local height = 30
				local innerSpacing = 2
      	
      	local xPos = xMargin + xPadding + width * (scaleNoteIndex-1) + innerSpacing * scaleNoteIndex
      	local yPos = yMargin + yPadding + headerHeight + height * (chordTypeIndex-1) + innerSpacing * (chordTypeIndex-1) - 3
      	
				
        local onPressCallback = function()
        																print("this is the onPress callback")
                                        --setSelectedChordType(scaleNoteIndex_, chordIndex_)
                                        --insertChord(scaleNoteIndex_)
                                        --setChordInversion(getCurrentInversionValue())
                                      end
        local onShiftPressCallback = function() 
    																		print("this is the onShiftPress callback")
                                       end

        self:addChordButton(text, xPos , yPos , width, height, scaleNoteIndex, chordTypeIndex, onPressCallback, onShiftPressCallback)
      end
      
      scaleNoteIndex = scaleNoteIndex + 1
    end
  end
end