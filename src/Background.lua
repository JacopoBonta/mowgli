-- Background permette di creare un background formato da più immagini (layers). I layers vengono stampati uno sopra l'altro.
local Background = {}

-- new() crea un nuovo oggetto Background
-- group = un grouppo al quale aggiungere gli sprite creati
function Background:new(group)
    local o = {
        group = group,
        x = 0,
        y = 0,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- addLayer() aggiunge un immagine al background. Da chiamare prima dell'init().
-- path = stringa, percorso dell'immagine
-- width = numero, larghezza immagine
-- height = numero, altezza immagine
function Background:addLayer(path, width, height)
    local images = self.layers or {}
    local z = self.zIndex or 1
    table.insert(images, z, {
        path = path,
        width = width,
        height = height
    })
    self.zIndex = z + 1
    self.layers = images
end

-- delete() rimuove il background
function Background:delete()
    for _, v in pairs(self.rects) do
        display.remove(v)
    end
    self = nil
end

-- init() inizializza il background caricando tutte le immagini aggiunte una sopra l'altra. I rect creati per ogni immagine sono memorizzati all'interno della tablla rects.
function Background:init()
    local rects = self.rects or {}
    for _, v in pairs(self.layers) do
        local rect = display.newImageRect(v.path, v.width, v.height)
        rect.x = self.x
        rect.y = self.y
        
        table.insert(rects, rect)
        
        if self.group then
            self.group:insert(rect)
        end
    end
    self.rects = rects
end

return Background