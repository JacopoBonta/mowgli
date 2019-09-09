-- Camera class defines camera objects. A camera object is used to simulate a camera in corona. You add display objects that have to stay on the camera viewport and when you move the camera with the methods like moveForward() or moveUp(), all the objects moves accordingly.
local Camera = { }

-- new() is the constructor of our objects
function Camera:new(group)
    local ds = display.newGroup() -- the group holding all the objects together
    local o = {
        borderLeft = 0, -- the border to the left of the camera viewport
        borderRight = display.contentWidth, -- the border to the right of the camera viewport
        displayObjects = ds,
        group = group,
        speed = 0,
        x = ds.x,
        y = ds.y
    }
    setmetatable(o, self) -- here we are
    self.__index = self   -- setting the prototype
    return o
end

-- add() method add a display object to the camera
    -- displayObject = a valid display object like an image rect
function Camera:add(displayObject)
    self.group:insert(displayObject)
    self.displayObjects:insert(displayObject)
end

-- moveForward() method move the camera to the right moving all the objects to the left
function Camera:moveForward()
    self.displayObjects.x = self.displayObjects.x - self.speed
    self.x = self.displayObjects.x * -1
    self.borderLeft = self.borderLeft + self.speed
    self.borderRight = self.borderRight + self.speed
end

-- moveBackward() method move the camera to the left moving all the objects to the right
function Camera:moveBackward()
    self.displayObjects.x = self.displayObjects.x + self.speed
    self.x = self.displayObjects.x * -1
    self.borderLeft = self.borderLeft - self.speed
    self.borderRight = self.borderRight - self.speed
end

-- moveUp() method move the camera up moving all the objects down
function Camera:moveUp()
    self.displayObjects.y = self.displayObjects.y + self.speed
    self.y = self.displayObjects.y * -1
end

-- moveDown() method move the camera down moving all the objects up
function Camera:moveDown()
    self.displayObjects.y = self.displayObjects.y - self.speed
    self.y = self.displayObjects.y * -1
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