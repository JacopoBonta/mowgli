-- Ground class is used to create ground objects. A ground object is a sprite with a static physic body. It is useful to create platforms and other ground like object in game
local Ground = {}

-- new() function is the Ground class constructor
-- path = string, full path to the sprite png
-- width = number, the width of the image
-- height = number, the height of the image
function Ground:new(path, width, height)
    local o = {
        x = 0,
        y = 0,
        physic = {
            type = nil,
            options = {}
        },
        path = path,
        width = width,
        height = height,
        isShow = false
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- addToCamera() method set the camera display group where the Ground object will be added
function Ground:addToCamera(camera)
    self.cameraGroup = camera
end

-- show() method create a new display object and eventually set the physic and camera group
function Ground:show()
    self.imgRect = display.newImageRect(self.path, self.width, self.height)
    self.imgRect.x = self.x
    self.imgRect.y = self.y

    physics.addBody(self.imgRect, 'static', {
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
        self.cameraGroup:insert(self.imgRect)
    end

    self.isShow = true
end

-- delete() method remove the ground object
function Ground:delete()
    self.imgRect:removeSelf()
    self = nil
end

return Ground