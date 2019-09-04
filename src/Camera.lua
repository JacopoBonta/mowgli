-- Camera class defines camera objects. A camera object is used to simulate a camera in corona. You add display objects that have to stay on the camera viewport and when you move the camera with the methods like moveForward() or moveUp(), all the objects moves accordingly.
local Camera = {
    displayObjects = display.newGroup(), -- the group holding all the objects together
    borderLeft = 0, -- the border to the left of the camera viewport
    borderRight = display.contentWidth -- the border to the right of the camera viewport
}

-- new() is the constructor of our objects
function Camera:new(o)
    o = o or {} -- use user provided object or create new one
    setmetatable(o, self) -- here we are
    self.__index = self   -- setting the prototype
    return o
end

-- add() method add a display object to the camera
    -- displayObject = a valid display object like an image rect
function Camera:add(displayObject)
    self.displayObjects:insert(displayObject)
end

-- moveForward() method move the camera to the right moving all the objects to the left
    -- speed = number, the number of pixels the camera will move
function Camera:moveForward(speed)
    self.displayObjects.x = self.displayObjects.x - speed
    self.borderLeft = self.borderLeft + speed
    self.borderRight = self.borderRight + speed
end

-- moveBackward() method move the camera to the left moving all the objects to the right
    -- speed = number, the number of pixels the camera will move
function Camera:moveBackward(speed)
    self.displayObjects.x = self.displayObjects.x + speed
    self.borderLeft = self.borderLeft - speed
    self.borderRight = self.borderRight - speed
end

-- moveUp() method move the camera up moving all the objects down
    -- speed = number, the number of pixels the camera will move
function Camera:moveUp(speed)
    self.displayObjects.y = self.displayObjects.y + speed
end

-- moveDown() method move the camera down moving all the objects up
    -- speed = number, the number of pixels the camera will move
function Camera:moveDown(speed)
    self.displayObjects.y = self.displayObjects.y - speed
end

-- remove() method remove a display object from the camera.
    -- displayObject = the reference to the display object
function Camera:remove(displayObject)
    self.displayObjects:remove(displayObject)
    displayObject = nil
end

-- delete() method remove all the display objects added to the camera and the camera itself
function Camera:delete()
    display.remove(self.displayObjects)
    self = nil
end

return Camera