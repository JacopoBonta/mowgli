-- WoodObstacle crea un oggetto circoloare in grado di spostarsi in base ad una forza applicata al centro
local WoodObstacle = {}

-- new() crea un nuovo oggetto WoodObstacle
-- path = string, percorso immagine
-- width = number, larghezza immagine
-- height = number, altezza immagine
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

-- delete() cancella il WoodObstacle
function WoodObstacle:delete()
    self.sprite:removeSelf()
    self = nil
end

-- init() inizializzaza l'oggetto creando l'immagine e settando la fisica
-- this method must be called inside the scene's show
function WoodObstacle:init()

    self.sprite = display.newImageRect(self.path, self.width, self.height)
    physics.addBody(self.sprite, { density = 0.5, bounce = 0, friction = 0, radius = self.width / 2 })

    local collisionObj = {
        name = "wood"
    }
    self._collision = collisionObj
    self.sprite._collision = collisionObj

    self.sprite.x = self.x
    self.sprite.y = self.y
end

-- roll() fa rotolare l'oggetto nella direzione indicata applicato una data forza
-- direction = string, direzione dell'oggetto, può essere "right" o "left"
-- force = number, la forza da applicare all'oggetto
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