function BackgroundManager(view)

    local bgManager = {
        view = view,
        zIndex = 1,
        layers = {}
    }
    
    function bgManager:addLayer(path, x, y)
        table.insert(self.layers, self.zIndex, {
            path = path,
            x = x,
            y = y
        })
        self.zIndex = self.zIndex + 1
    end
    
    function bgManager:show()
        for i, v in ipairs(self.layers) do
            display.newImage(self.view, v.path, v.x, v.y)
        end
    end
    
    return bgManager
end

return BackgroundManager