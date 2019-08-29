-- Camera class defines camera objects. A camera object is used to simulate a camera in corona. You add display objects that have to stay on the camera viewport and when you move the camera with the methods like moveForward(), all the objects moves accordingly.
local Camera = {}

-- new() is the constructor of our objects
function Camera:new(o)
    -- here we define some defaults properties common to all Camera instances
    o = o or {
        displayObjects = display.newGroup(),
        borderLeft = 0,
        borderRight = display.contentWidth
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- insert() method add a display object to a displayGroup aka the collection of all the display objects the camera have to manage
function Camera:insert(o)
    self.displayObjects:insert(o)
end

-- moveForward() method move the camera to the right moving all the objects to the left by the speed parameter
-- speed = number, the number of pixels the camera will move
function Camera:moveForward(speed)
    self.displayObjects.x = self.displayObjects.x - speed
    self.borderLeft = self.borderLeft + speed
    self.borderRight = self.borderRight + speed
end

-- moveBackward() method move the camera to the left moving all the objects to the right by the speed parameter
-- speed = number, the number of pixels the camera will move
function Camera:moveBackward(speed)
    self.displayObjects.x = self.displayObjects.x + speed
    self.borderLeft = self.borderLeft - speed
    self.borderRight = self.borderRight - speed
end

-- moveUp() method move the camera up moving all the objects down by the speed parameter
-- speed = number, the number of pixels the camera will move
function Camera:moveUp(speed)
    self.displayObjects.y = self.displayObjects.y + speed
end

-- moveDown() method move the camera down moving all the objects up by the speed parameter
-- speed = number, the number of pixels the camera will move
function Camera:moveDown(speed)
    self.displayObjects.y = self.displayObjects.y - speed
end

return Camera