-- Button is a base class for creating buttons object. It is not intended to use as it is. Instead, use the ButtonText or ButtonImage child classes.

-- Button here is the prototype for our buttons. We provide some intial values for the button position. Every button objects will have an own copy of these properties along with the methods defined.
local Button = {
    x = display.contentWidth / 2,
    y = display.contentHeight / 2,
}

-- new() method constructor. Create a Button object.
function Button:new()
    local o = {} -- the new object
    setmetatable(o, self) -- here we set the Button table as the metatable of our new object 'o'
    self.__index = self -- here we tell lua to look up at the Button table when accessing fields not present in 'o' - setting the Button table as the prototype of 'o'
    return o
end

-- registerBeforeTouchHandler() method register a callback fucntion that will be called when the button is pressed
function Button:registerBeforeTouchHandler(cb)
    self.beforeCb = cb
end

-- registerBeforeTouchHandler() method register a callback fucntion that will be called when the button is released
function Button:registerAfterTouchHandler(cb)
    self.afterCb = cb
end

-- show() method must be implemented from the child classes
function Button:show()
    error("method not implemented")
end

return Button