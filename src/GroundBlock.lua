-- GroundBlock is a single block of ground used to create the world's ground
local GroundBlock = {
    x = 0, -- the x initial position
    y = 0, -- the y initial position
    isShow = false -- once created the block is not showed. It will be showd once show method is called
}

-- new() constructor, set the block's sprite and properties
    -- path = string, a path to the image sprite
    -- width = number, the width of the block
    -- height = number, the height of the block
function GroundBlock:new(path, width, height)
    local o = {
        path = path,
        width = width,
        height = height
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- show() method set the sprite of the ground block and physic to that sprite
function GroundBlock:init()
    -- create a new sprite from imgRect
    self.sprite = display.newImageRect(self.path, self.width, self.height)

    -- set sprite position
    self.sprite.x = self.x
    self.sprite.y = self.y

    -- add physic because ground have physic
    -- the box options' property is used because we know that the block sprite has an empty space at the top
    physics.addBody(self.sprite, 'static', {
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

    local collisionObj = {
        name = 'ground'
    }

    self._collision = collisionObj
    self.sprite._collision = collisionObj

    self.isShow = true
end

-- delete() method is used to delete the ground block
function GroundBlock:delete()
    display:remove(self.sprite)
    self = nil
end

return GroundBlock