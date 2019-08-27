local Button = require( "src.Button" )

-- ButtonText is used to create text which a user can press like a button. It inehrits form the Button class

local ButtonImage = Button:new()

-- setImage() method is used to set the image of the button
    -- path = full path of the image
    -- width = width of the image
    -- height = height of the image
function ButtonImage:setImage(path, width, height)
    self.path = path
    self.width = width
    self.height = height
end

-- show() method creates an image rect and register before and after handlers to it to make the image a button.
function ButtonImage:show()
    
    local button = display.newImageRect(self.path, self.width, self.height)
    button.x = self.x
    button.y = self.y
    
    button:addEventListener("touch", function(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus( event.target )
            self.beforeCb()
        elseif event.phase == "ended" then
            self.afterCb()
            display.getCurrentStage():setFocus( nil )
        end
    end)
    
    self.displayObject = button
end

return ButtonImage