-- Background gestisce il background di una scena
function Background()

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

    function bg:setCamera(camera)
        self.camera = camera
    end
    
    -- show stampa il background
    function bg:show(group)
        for i, v in ipairs(self.layers) do
            local layer = display.newImageRect(v.path, v.width, v.height)
            layer.x = self.x
            layer.y = self.y
            
            if group then
                table.insert(group, layer)
            end

            if self.camera then
                self.camera:insert(layer)
            end
        end
    end
    
    return bg
end

return Background