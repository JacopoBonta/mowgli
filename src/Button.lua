-- Button è un'immagine che l'utente può toccare
local Button = {}

-- new() crea un nuovo oggetto di tipo Button
-- path = string, il percorso dell'immagine
-- widht = numero, larghezza bottone
-- height = numero, altezza bottone
function Button:new(path, width, height)
    local o = {
        afterCb = function() end,
        beforeCb = function() end,
        height = height,
        path = path,
        width = width,
        x = display.contentWidth / 2,
        y = display.contentHeight / 2,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- delete() cancella il pulsante
function Button:delete()
    display.remove(self.imgRect)
    self = nil
end

-- init() inizializza il Button. Crea un image rect e ci registra l'handler
function Button:init()
    self.imgRect = display.newImageRect(self.path, self.width, self.height)
    self.imgRect.x = self.x
    self.imgRect.y = self.y
    
    self.imgRect:addEventListener("touch", self)
end

-- touch() è l'event handler per il touch
function Button:touch(event)
    if event.phase == "began" then
        display.getCurrentStage():setFocus( self.path )
        self:beforeCb()
    elseif event.phase == "ended" then
        self:afterCb()
        display.getCurrentStage():setFocus( nil )
    end
end

return Button