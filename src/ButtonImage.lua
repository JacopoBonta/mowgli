-- ButtonImage is a special kind of button that display a touchable image rect.
local Button = require( "src.Button" )

-- To inherit from the base class Button we first create a new Button instance. This will act as the prototype of our ButtonImage objects.
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
function ButtonImage:init()
    
    self.imgRect = display.newImageRect(self.path, self.width, self.height)
    self.imgRect.x = self.x
    self.imgRect.y = self.y
    
    self.imgRect:addEventListener("touch", self)
end

-- touch() method is the touch event handler
function ButtonImage:touch(event)
    if event.phase == "began" then
        display.getCurrentStage():setFocus( event.target )
        self:beforeCb()
    elseif event.phase == "ended" then
        self:afterCb()
        display.getCurrentStage():setFocus( nil )
    end
end

-- delete() must be implemented in to child classes
function ButtonImage:delete()
    self.imgRect:removeEventListener("touch", self.touch) -- TODO check, it may produce bug (https://docs.coronalabs.com/api/type/EventDispatcher/removeEventListener.html#gotchas)
    display.remove(self.imgRect)
    self = nil
end

return ButtonImage