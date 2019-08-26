local Button = require( "src.Button" )

-- ButtonImage is used to create images which a user can press like a button. It inehrits form the Button class

-- inherit from Button base class
local ButtonText = Button:new({ fontSize = 18 })

-- setText() method set the string of text the button will display
function ButtonText:setText(string)
    self.text = string
end

-- show() method create a text object and register handlers to it to make the text a button
function ButtonText:show()
    
    local button = display.newText(self.text, self.x, self.y, "assets/fonts/Windlass.ttf", self.fontSize)
    button:setFillColor( 0.76, 0.77, 0.18 )
    
    button:addEventListener("touch", function(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus( event.target )
            self.handlers.before()
        elseif event.phase == "ended" then
            self.handlers.after()
            display.getCurrentStage():setFocus( nil )
        end
    end)
    
    self.displayObject = button
end