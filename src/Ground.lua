-- Ground class is used to create ground objects. A ground object is a sprite with a static physic body. It is useful to create platforms and other ground like object in game

local Ground = {
    x = 0,
    y = 0,
    physic = {
        type = nil,
        options = {}
    }
}
Ground.__index = Ground

-- new() function is the Ground class constructor
-- path = string, full path to the sprite png
-- width = number, the width of the image
-- height = number, the height of the image
function Ground:new(path, width, height)
    local o = {
        path = path,
        width = width,
        height = height
    }
    setmetatable(o, self)
    self._index = self
    return o
end

-- addToCamera() method set the camera display group where the Ground object will be added
function Ground:addToCamera(camera)
    self.cameraGroup = camera
end

-- show() method create a new display object and eventually set the physic and camera group
function Ground:show()
    local ground = display.newImageRect(self.path, self.width, self.height)
    ground.x = self.x
    ground.y = self.y

    physics.addBody(ground, 'static', {
        density = 0,
        friction = 0,
        bounce = 0,
        box = {
            halfWidth = self.width / 2,
            halfHeight = self.height / 2,
            y = 16,
            x = 0
        }
    })
    
    if self.cameraGroup then
        self.cameraGroup:insert(ground)
    end
end

return Ground