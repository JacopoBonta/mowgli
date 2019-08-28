-- Character class creates character objects. A Character object has methods to load a sprite and animatios, to move the sprite and play defined animatios. One can use the Character class for creating the main character moved by the user also for creating enemies bot.

-- declare common properties to all Character objects
local Character = {
    x = 0,
    y = 0,
    physic = {
        type = nil,
        options = {}
    },
    pv = 1,
    speed = 0,
    sprite = { }
}

-- new() is the constructor of the Character class. It creates a new Character object instance
function Character:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- setDirection() mathod is used to set the direction of the Character object
    -- direction = a string that can be 'right' or 'left' to set the sprite direction
function Character:setDirection(direction, speed)
    if speed > 0 then
        if direction == 'right' then
            self.displayObject.xScale = 1
            self.speed = speed
        elseif direction == 'left' then
            self.displayObject.xScale = -1
            self.speed = speed * -1
        end
        self.displayObject:setSequence('run')
        self.displayObject:play()
    end
end

-- setPhysic() method add physic properties to the Character object. If they were set when show() method is called a physic body is added to the sprite.
    -- type = string, type of the physic body
    -- density = number, density of the physic body
    -- friction = number, friction of the physic body
    -- bounce = number, the bounciness of the physic body
function Character:setPhysic(type, density, friction, bounce)
    self.physic.type = type 
    self.physic.options.density = density
    self.physic.options.friction = friction
    self.physic.options.bounce = bounce
end

-- setSprite() method set the sprite and animations sequences.
    -- infoPath = string, a full path to the lua file describing the sprite sheet (generated using TexturePacker)
    -- sheetPath = string, full path to the png sheet of the sprite (generated using TexturePacker)
    -- sequenceData = a table containing tables describing sequences. Each sequence table must have three properties:
        -- name: string, the name of the animation
        -- frames: an ordered table of strings where each string correspond to an animation's frame
        -- time: number, the duration in milliseconds of the animation
function Character:setSprite(infoPath, sheetPath)
    self.sprite.info = require(infoPath)
    self.sprite.sheetPath = sheetPath
end

-- setCamera() method is used if you want to add the Character object to the camera. When the show() method is called and the camera property was set then the Character object is added to the camera display group
function Character:setCamera(camera)
    self.camera = camera
end

-- show() method creates the sprite object and corresponding animations. Then if physic properties was set through the setPhysic() method, add a physic body to the sprite. Also add the sprite to the camera display group if it was previously set.
function Character:show()
    local sheet = graphics.newImageSheet(self.sprite.sheetPath, self.sprite.info:getSheet())

    local chSprite = display.newSprite(sheet, self.sprite.info:getSequenceData(800))
    chSprite.x = self.x
    chSprite.y = self.y
    chSprite.isFixedRotation = true
    
    if self.physic.type ~= nil then
        physics.addBody(chSprite, self.physic.type, self.physic.options)
    end
    
    if self.camera then
        self.camera:insert(chSprite)
    end
    
    self.displayObject = chSprite
    self.displayObject:play()
end

-- stand() method stops the Character object setting is speed to 0 and play the 'idle' animation
function Character:stand()
    self.speed = 0
    self.displayObject:setSequence('idle')
    self.displayObject:play()
end

-- updatePosition() method is called once per frame and update the character position by its speed
function Character:updatePosition()
    self.displayObject.x = self.displayObject.x + self.speed
end

return Character