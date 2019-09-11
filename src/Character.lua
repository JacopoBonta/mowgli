-- Character class creates character objects. A Character object has methods to load a sprite and animatios, to move the sprite and play defined animatios. One can use the Character class for creating the main character moved by the user and also for creating enemies bot.
local Character = {}

-- new() is the constructor of the Character class. It creates a new Character object instance
function Character:new(name)
    local o = {
        isGround = false,
        isRound = false,
        name = name,
        onCollision = function() end,
        onExitCollision = function() end,
        pv = 1,
        speed = 0,
        spriteOptions = { },
        x = 0,
        y = 0
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- collision() method is the collision event handler
function Character:collision(event)
    if ( event.phase == "began" ) then
        self.onCollision(self, event)
    elseif ( event.phase == "ended" ) then
        self.onExitCollision(self, event)
    end
end

-- delete() method deletes the sprite and character object
function Character:delete()
    display.remove(self.sprite)
    self = nil
end

-- init() method initialize the character object. It creates the sprite object and load the animations.
-- This method must be called inside the scene's event 'show' during the 'will' phase
function Character:init()

    -- load sprite sheet and animations
    self.sheet = graphics.newImageSheet(self.spriteOptions.sheetPath, self.spriteOptions.info:getSheet())
    self.sprite = display.newSprite(self.sheet, self.spriteOptions.info:getSequenceData(self.spriteOptions.time))

    -- add physic body
    local phyOpts = { bounce = 0 }
    if self.isRound == true then
        phyOpts.radius = self.sprite.width / 2
    end
    physics.addBody(self.sprite, 'dynamic', phyOpts)
    if self.isRound == false then
        self.sprite.isFixedRotation = true
    end

    -- add collision properties and handlers
    local collisionObj = {
        name = self.name
    }
    self._collision = collisionObj
    self.sprite._collision = collisionObj
    self.sprite:addEventListener("collision", self)
    
    -- reset character's parameters that can be changed
    self.isGround = false
    self.pv = 1
    self.sprite.x = self.x
    self.sprite.y = self.y
end

-- jump() method apply a force along y axis to make the player jump
-- velocity = positive number, the amount of force to apply
function Character:jump(velocity)
    velocity = velocity * -1
    if self.isGround == true then
        self.sprite:setLinearVelocity(0, velocity)
        self.sprite:setSequence("jump")
    end
end

-- run() method set direction and speed
function Character:run(direction, speed)
    self:setDirection(direction)
    self.speed = speed
    self.sprite:setSequence('run')
end

-- setDirection() method scale the sprite and invert the speed in order to set the character's direction.
-- direction = a string, it can be 'right' or 'left'
function Character:setDirection(direction)
    
    local s = math.abs(self.speed)
    
    if direction == 'right' then
        self.sprite.xScale = 1
        self.speed = s
    elseif direction == 'left' then
        self.sprite.xScale = -1
        self.speed = s * -1
    else
        error('invalid direction')
    end
    
end

-- setSprite() method set the character's sprite and animations.
-- infoPath = string, a full path to the lua file describing the sprite sheet (generated using TexturePacker)
-- sheetPath = string, full path to the png sheet of the sprite (generated using TexturePacker)
-- time = number, the animation timing
function Character:setSprite(infoPath, sheetPath, time)
    self.spriteOptions.info = require(infoPath)
    self.spriteOptions.sheetPath = sheetPath
    self.spriteOptions.time = time
end

-- stand() method stops the Character object setting is speed to 0 and play the 'idle' animation
function Character:stand()
    self.speed = 0
    self.sprite:setSequence('idle')
end

-- update() method is called once per frame
function Character:update()
    
    -- play animation if it is not
    if self.sprite.isPlaying == false then
        self.sprite:play()
    end

    -- move the character by its speed
    if self.speed > 0 then
        self.sprite.x = self.sprite.x + self.speed
    end

    -- check if the character is fallen off the ground and if so kill it
    if self.sprite.y > display.contentHeight then
        self.pv = 0
    end
end

return Character