-- ButtonText creates buttons that disply a text string instead of an image rect.
local Button = require( "src.Button" )

-- inherit from Button base class and set default properties for font size and dummy text
local ButtonText = Button:new({ text = "dummy text", fontSize = 18 })

-- setFont() method set the font and properties
    -- path = absolut path of a tff font file
    -- size = size of the font
    -- fillColor = a table with 3 numeric values used by setFillColor()
function ButtonText:setFont(path, size, fillColor)
    self.path = path
    self.fontSize = size
    self.fillColor = fillColor
end

-- show() method create a text object and register handlers to it to make the text a button
function ButtonText:show()
    
    self.textRect = display.newText(self.text, self.x, self.y, self.path, self.fontSize)
    button:setFillColor( self.fillColor[1], self.fillColor[2], self.fillColor[3] )
    
    self.textRect:addEventListener("touch", function(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus( event.target )
            self.handlers.before()
        elseif event.phase == "ended" then
            self.handlers.after()
            display.getCurrentStage():setFocus( nil )
        end
    end)
end

-- delete() must be implemented in to child classes
function Button:delete()
    self.textRect:removeEventListener("touch", nil) -- TODO check, it may produce bug (https://docs.coronalabs.com/api/type/EventDispatcher/removeEventListener.html#gotchas)
    display.removeObject(self.textRect)
end

return ButtonText