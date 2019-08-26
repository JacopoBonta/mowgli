-- Button is a base class for creating buttons object.
-- Use the ButtonText child class or ButtonImage child class in your game

-- define  some default properties common to all the Button class' instances
local Button = {
    displayObject = nil,
    x = display.contentWidth / 2,
    y = display.contentHeight / 2,
    handlers = {
        before = function() print('before touch') end,
        after = function() print('after touch') end
    }
}

-- new() the constructor. Return a new instance of the Button class
function Button:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- registerBeforeTouchHandler() method register a callback fucntion to call when the button is pressed
function Button:registerBeforeTouchHandler(cb)
    self.handlers.before = cb
end

-- registerBeforeTouchHandler() method register a callback fucntion to call after the button is pressed
function Button:registerAfterTouchHandler(cb)
    self.handlers.after = cb
end

-- show() method must be implemented from the child classes
function Button:show()
    error("method not implemented")
end

return Button