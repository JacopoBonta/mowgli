-- GroundBlock è un singolo blocco usato dalla classe Ground. Può essere anche usato indipendentemente per realizzare della piattaforme. L'immagine usata per un ground block deve avere larghezza e altezza in potenza di due dato che sarà ripetuta per riempire la larghezza effettiva di tutto il blocco.
local GroundBlock = {}

-- new() crea un nuovo blocco
-- path = string, percorso dell'immagine da usare per il blocco
-- width = numero, larghezza immagine
-- height = number, altezza immagine
function GroundBlock:new(path, width, height)
    local o = {
        path = path,
        t_width = width,
        t_height = height,
        x = 0,
        y = 0
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- init() inizializza il ground e setta l'immagine in modo da riempire per tutta la lunghzza. Aggiunge corpo fisico.
-- width = number, larghezza del blocco
function GroundBlock:init(width)

    self.width = width
    
    self.sprite = display.newRect(self.x, self.y, self.width, self.t_height)
    
    -- ripete l'immagine per tutta la larghezza del blocco
    display.setDefault("textureWrapX", "repeat")
    self.sprite.fill = { type = "image", filename = self.path }
    self.sprite.fill.scaleX = self.t_width / self.width
    display.setDefault("textureWrapX", "clampToEdge")

    -- aggiunge corpo fisico
    physics.addBody(self.sprite, 'static', {
        density = 0,
        friction = 0,
        bounce = 0,
        box = {
            halfWidth = self.width / 2,
            halfHeight = self.t_height / 2,
            y = 26,
            x = 0
        }
    })

    -- setta oggetto collisione
    local collisionObj = {
        name = 'ground'
    }
    self._collision = collisionObj
    self.sprite._collision = collisionObj

    self.isShow = true
end

-- delete() cancella il blocco
function GroundBlock:delete()
    display:remove(self.sprite)
    self = nil
end

return GroundBlock