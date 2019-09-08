-- Character class creates character objects. A Character object has methods to load a sprite and animatios, to move the sprite and play defined animatios. One can use the Character class for creating the main character moved by the user also for creating enemies bot.

-- declare common properties to all Character objects
local Character = {
    x = 0,
    y = 0,
    isGround = false,
    pv = 1,
    _speed = 0,
    speed = 4,
    spriteOptions = { }
}

-- new() is the constructor of the Character class. It creates a new Character object instance
function Character:new(name, camera)
    local o = {
        camera = camera,
        name = name
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- setDirection() method scale the sprite to match character's direction. It also invert the speed
    -- direction = a string that can be 'right' or 'left' to set the sprite direction
function Character:setDirection(direction)

    local s = math.abs(self._speed)
    
    if direction == 'right' then
        self.sprite.xScale = 1
        self._speed = s
    elseif direction == 'left' then
        self.sprite.xScale = -1
        self._speed = s * -1
    end

end

function Character:jump(velocity)

    if self.isGround == true then
        self.sprite:setLinearVelocity(0, velocity)
    end
end
-- setSprite() method set the sprite and animations sequences.
    -- infoPath = string, a full path to the lua file describing the sprite sheet (generated using TexturePacker)
    -- sheetPath = string, full path to the png sheet of the sprite (generated using TexturePacker)
function Character:setSprite(infoPath, sheetPath)
    self.spriteOptions.info = require(infoPath)
    self.spriteOptions.sheetPath = sheetPath
end

-- show() method creates the sprite object and corresponding animations. Then if physic properties was set through the setPhysic() method, add a physic body to the sprite. Also add the sprite to the camera display group if it was previously set.
function Character:init()
    self.sheet = graphics.newImageSheet(self.spriteOptions.sheetPath, self.spriteOptions.info:getSheet())
    
    self.sprite = display.newSprite(self.sheet, self.spriteOptions.info:getSequenceData(800))
    self.sprite.x = self.x
    self.sprite.y = self.y

    physics.addBody(self.sprite, 'dynamic', {
        bounce = 0
    })
    self.sprite.isFixedRotation = true

    local collisionObj = {
        name = self.name
    }
    self._collision = collisionObj
    self.sprite._collision = collisionObj
    self.sprite:addEventListener("collision", self)
    
    if self.camera then
        self.camera:add(self.sprite)
    end
    
    self:setDirection('right')
    self:stand()
    self.sprite:play()
end

function Character:collision(event)
    if ( event.phase == "began" ) then

        if event.other._collision.name == "ground"  then
            self.isGround = true
        end
 
    elseif ( event.phase == "ended" ) then
        
        if event.other._collision.name == "ground" then
            self.isGround = false
            print('nope')
        end

    end
end

-- run() method set direction and speed
function Character:run(direction)
    self:setDirection(direction)
    self._speed = self.speed
    self.sprite:setSequence('run')
    self.sprite:play()
end

-- stand() method stops the Character object setting is speed to 0 and play the 'idle' animation
function Character:stand()
    self._speed = 0
    self.sprite:setSequence('idle')
    self.sprite:play()
end

-- update() method is called once per frame and update the character position by its speed
function Character:update()

    self.sprite.x = self.sprite.x + self._speed

    if self.sprite.y > display.contentHeight then
        self.pv = 0
    end
end

-- delete() method deletes the sprite and character object
function Character:delete()
    display.remove(self.sprite)
    self = nil
end

return Character