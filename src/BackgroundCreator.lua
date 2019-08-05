-- BackgroundCreator gestisce il background di una scena
function BackgroundCreator()

    local bg = {
        x = 0,
        y = 0,
        zIndex = 1,
        layers = {},
        displayObjects = {}
    }
    
    -- addImage aggiunge una nuova immagine allo sfondo. Le immagine vengono stampate seguendo l'ordine di inserimento.
    function bg:addImage(path, width, height)
        table.insert(self.layers, self.zIndex, {
            path = path,
            width = width,
            height = height
        })
        self.zIndex = self.zIndex + 1
    end

    function bg:setPos(x, y)
        self.x = x
        self.y = y
    end
    
    -- show stampa il background
    function bg:show(view)
        local displayObjects = self.displayObjects
        for i, v in ipairs(self.layers) do
            local layer = display.newImageRect(view, v.path, v.width, v.height)
            layer.x = self.x
            layer.y = self.y
            table.insert(displayObjects, layer)
        end
        self.displayObjects = displayObjects
    end
    
    return bg
end

return BackgroundCreator