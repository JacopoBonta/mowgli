function GroundManager(view)

    local groundManager = {
        view = view,
        properties = {}
    }

    function groundManager:newGround(type, path, x, y)
        self.type = type
        self.path = path
        self.x = x
        self.y = y
    end

    function groundManager:setProperties(density, friction, bounce)
        self.properties.density = density
        self.properties.friction = friction
        self.properties.bounce = bounce
    end

    function groundManager:show()
        local ground = display.newImage(self.view, self.path, self.x, self.y)
        physics.addBody(ground, self.type)
    end

    return groundManager
end

return GroundManager