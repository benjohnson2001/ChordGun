local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun"
require(workingDirectory .. "/preferences")

function updateScaleDegreeHeaders()

  local minorSymbols = {'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii'}
  local majorSymbols = {'I', 'II', 'III', 'IV', 'V', 'VI', 'VII'}
  local diminishedSymbol = 'o'
  local augmentedSymbol = '+'
  local sixthSymbol = '6'
  local seventhSymbol = '7'
  
  local i = 1
  for i = 1, 7 do
  
    local symbol = ''
  
    if i > #scaleNotes then
      
      setScaleDegreeHeaders(i, symbol)

    else
     
      local chord = scaleChords[i][1]
      
      if string.match(chord.code, "maj") or chord.code == '7' then
        symbol = majorSymbols[i]
      else
        symbol = minorSymbols[i]
      end
      
      if (chord.code == 'aug') then
        symbol = symbol .. augmentedSymbol
      end
  
      if (chord.code == 'dim') then
        symbol = symbol .. diminishedSymbol
      end
  
      if string.match(chord.code, "6") then
        symbol = symbol .. sixthSymbol
      end
      
      if string.match(chord.code, "7") then
        symbol = symbol .. seventhSymbol
      end
          
      setScaleDegreeHeaders(i, symbol) 
    end
    
    if (viewBuilder ~= nil) then
      
      if (i == 1) then
        viewBuilder.views.scaleDegreeHeader1.text = symbol
      end
  
      if (i == 2) then
        viewBuilder.views.scaleDegreeHeader2.text = symbol
      end
      
      if (i == 3) then
        viewBuilder.views.scaleDegreeHeader3.text = symbol
      end
      
      if (i == 4) then
        viewBuilder.views.scaleDegreeHeader4.text = symbol
      end
      
      if (i == 5) then
        viewBuilder.views.scaleDegreeHeader5.text = symbol
      end
      
      if (i == 6) then
        viewBuilder.views.scaleDegreeHeader6.text = symbol
      end                
  
      if (i == 7) then
        viewBuilder.views.scaleDegreeHeader7.text = symbol
      end    
    end
  end
end