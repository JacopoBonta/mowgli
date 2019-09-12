-- Character crea uno sprite con corpo fisico in grado di muoversi e saltare. Gli sprite sono creati utilizzando i file esportati da TexturePacker.
local Character = {}

-- new() crea un nuovo oggetto Character
-- name = string, nome per le collisioni
-- infoPath = string, path al file lua che descrive lo sprite sheet (generated using TexturePacker)
-- sheetPath = string, path allo sprite sheet (generated using TexturePacker)
-- time = number, tempo dell'animazione
function Character:new(name, infoPath, sheetPath, time)
    local o = {
        canJump = false,
        name = name,
        onCollision = function() end,
        onExitCollision = function() end,
        pv = 1,
        speed = 0,
        spriteOptions = {
            info = require(infoPath),
            sheetPath = sheetPath,
            time = time
        },
        x = 0,
        y = 0
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- collision() handler per le collisioni
function Character:collision(event)
    if ( event.phase == "began" ) then
        self.onCollision(self, event)
    elseif ( event.phase == "ended" ) then
        self.onExitCollision(self, event)
    end
end

-- delete() cancella lo sprite e l'oggetto Character
function Character:delete()
    display.remove(self.sprite)
    self = nil
end

-- init() inizializza il Character. Crea lo sprite, ci aggiunge un corpo fisico e registra l'handler per le collsioni. Resetta anche alcuni valori iniziali.
function Character:init()

    -- carica sprite ed animazioni
    self.sheet = graphics.newImageSheet(self.spriteOptions.sheetPath, self.spriteOptions.info:getSheet())
    self.sprite = display.newSprite(self.sheet, self.spriteOptions.info:getSequenceData(self.spriteOptions.time))

    -- aggiungi corpo fisico allo sprite
    physics.addBody(self.sprite, 'dynamic', { bounce = 0, friction = 0 })
    self.sprite.isFixedRotation = true

    -- setta proprietà collisioni e registra collision handler
    local collisionObj = {
        name = self.name
    }
    self._collision = collisionObj
    self.sprite._collision = collisionObj
    self.sprite:addEventListener("collision", self)
    
    -- reset variabili
    self.canJump = false
    self.pv = 1
    self.sprite.x = self.x
    self.sprite.y = self.y
end

-- jump() applica una forza dal basso per far saltare il Character
-- velocity = positive number, the amount of force to apply
function Character:jump(velocity)
    velocity = velocity * -1
    if self.canJump == true then
        self.canJump = false
        self.sprite:setLinearVelocity(0, velocity)
        self.sprite:setSequence("jump")
    end
end

-- run() setta la velocità e direzione del personaggio
function Character:run(direction, speed)
    self:setDirection(direction)
    self.speed = speed
    self.sprite:setSequence('run')
end

-- setDirection() setta la direzione dello sprite aggiustando anche la velocità.
-- direction = string, può essere 'right' o 'left'
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

-- stand() ferma il Character settando la sua velocità a 0 e settando una sequenza di 'idle'
function Character:stand()
    self.speed = 0
    self.sprite:setSequence('idle')
end

-- update() viene chiamato ad ogni frame
function Character:update()
    
    -- avvia l'animazione
    if self.sprite.isPlaying == false then
        self.sprite:play()
    end

    -- sposta il personaggio
    self.sprite.x = self.sprite.x + self.speed

    -- se il personaggio cade setta i suoi punti vita a 0
    if self.sprite.y > display.contentHeight then
        self.pv = 0
    end
end

return Character