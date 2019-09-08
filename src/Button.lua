-- Button is an UI element that display an image that a user can touch.


local Button = {
    x = display.contentWidth / 2,
    y = display.contentHeight / 2,
}

-- new() method constructor. Create a Button object.
function Button:new(path, width, height)
    local o = {
        path = path,
        width = width,
        height = height
    }
    setmetatable(o, self) -- here we set the Button table as the metatable of our new object 'o'
    self.__index = self -- here we tell lua to look up at the Button table when accessing fields not present in 'o' - setting the Button table as the prototype of 'o'
    return o -- we return 'o' as a new Button object
end

-- registerBeforeTouchHandler() method register a callback fucntion that will be called when the button is pressed
function Button:registerBeforeTouchHandler(cb)
    self.beforeCb = cb
end

-- registerBeforeTouchHandler() method register a callback fucntion that will be called when the button is released
function Button:registerAfterTouchHandler(cb)
    self.afterCb = cb
end

-- init() abstract method must be implemented from the child classes
function Button:init()
    self.imgRect = display.newImageRect(self.path, self.width, self.height)
    self.imgRect.x = self.x
    self.imgRect.y = self.y
    
    self.imgRect:addEventListener("touch", self)
end

-- touch() method is the touch event handler
function Button:touch(event)
    if event.phase == "began" then
        display.getCurrentStage():setFocus( self )
        self:beforeCb()
    elseif event.phase == "ended" then
        self:afterCb()
        display.getCurrentStage():setFocus( nil )
    end
end

-- delete() asbtrace method must be implemented in to child classes
function Button:delete()
    self.imgRect:removeEventListener("touch", self)
    display.remove(self.imgRect)
    self = nil
end

return Button