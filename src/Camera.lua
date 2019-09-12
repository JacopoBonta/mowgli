-- Camera simula una telecamera all'interno della scena di gioco. Tutti gli oggetti inseriti si spostano nella direzione opposta a quella richiesta per simulare un effetto di movimento.
local Camera = { }

-- new() crea un nuovo oggetto camera
function Camera:new(group)
    local o = {
        borderLeft = 0,
        borderRight = display.contentWidth,
        group = group,
        speed = 0,
        x = 0,
        y = 0
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- init() inizializza la camera. crea un nuovo display group che conterrà gli oggetti e definisce i bordi.
function Camera:init()
    self.displayObjects = display.newGroup()
    self.borderLeft = 0
    self.borderRight = display.contentWidth
end

-- add() aggiunge un oggetto alla camera
-- displayObject = oggetto di tipo display object da tracciare
function Camera:add(displayObject)
    self.group:insert(displayObject)
    self.displayObjects:insert(displayObject)
end

-- moveForward() move la telecamera a destra
function Camera:moveForward()
    self.displayObjects.x = self.displayObjects.x - self.speed
    self.x = self.displayObjects.x * -1
    self.borderLeft = self.borderLeft + self.speed
    self.borderRight = self.borderRight + self.speed
end

-- moveBackward() muove la telecamera indietro
function Camera:moveBackward()
    self.displayObjects.x = self.displayObjects.x + self.speed
    self.x = self.displayObjects.x * -1
    self.borderLeft = self.borderLeft - self.speed
    self.borderRight = self.borderRight - self.speed
end

-- moveUp() muove la telecamera in alto
function Camera:moveUp()
    self.displayObjects.y = self.displayObjects.y + self.speed
    self.y = self.displayObjects.y * -1
end

-- moveDown() muove la telecamera in basso
function Camera:moveDown()
    self.displayObjects.y = self.displayObjects.y - self.speed
    self.y = self.displayObjects.y * -1
end

-- remove() smette di tracciare un singolo elemento
    -- displayObject = the reference to the display object
function Camera:remove(displayObject)
    self.displayObjects:remove(displayObject)
end

-- delete() cancella la camera e tutti gli oggetti tracciati
function Camera:delete()
    display.remove(self.displayObjects)
    self = nil
end

return Camera