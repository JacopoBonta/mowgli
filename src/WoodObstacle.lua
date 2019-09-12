-- WoodObstacle is a wood that can roll and slow down the character
local WoodObstacle = {}

-- new() create a new wood obstacle object
function WoodObstacle:new(path, width, height)
    local o = {
        height = height,
        path = path,
        width = width,
        x = 0,
        y = 0
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- delete() remove the WoodObstacle sprite
function WoodObstacle:delete()
    self.sprite:removeSelf()
    self = nil
end

-- init() create the sprite and add the physic body.
-- this method must be called inside the scene's show
function WoodObstacle:init()

    self.sprite = display.newImageRect(self.path, self.width, self.height)
    self.sprite.rotation = 20
    physics.addBody(self.sprite, { density = 0.5, bounce = 0, friction = 0, radius = self.width / 2 })
    self.sprite.isFixedRotation = false

    local collisionObj = {
        name = "wood"
    }

    self._collision = collisionObj
    self.sprite._collision = collisionObj

    self.sprite.x = self.x
    self.sprite.y = self.y
end

-- roll() tell the wood in wich direction and with how much force it has to roll
function WoodObstacle:roll(direction, force)

    if direction == "right" then
        force = force
    elseif direction == "left" then
        force = force * -1
    else
        error("invalid direction")
    end

    self.sprite:applyLinearImpulse(force, 0, self.sprite.x, self.sprite.y)
end

return WoodObstacle