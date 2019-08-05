function GroundCreator(path, width, height)
    local ground = {
        path = path,
        x = 0,
        y = 0,
        width = width,
        height = height,
        physic = {
            type = nil,
            options = {}
        },
        displayObject = nil
    }

    function ground:setPhysic(type, density, friction, bounce)
        self.physic.type = type 
        self.physic.options.density = density
        self.physic.options.friction = friction
        self.physic.options.bounce = bounce
        self.physic.options.box = {
            halfWidth = self.width / 2,
            halfHeight = self.height / 2,
            y = 16,
            x = 0
        }
    end

    function ground:setPos(x, y)
        self.x = x
        self.y = y
    end

    function ground:show(view)
        local ground = display.newImageRect(view, self.path, self.width, self.height)
        ground.x = self.x
        ground.y = self.y

        if self.physic.type ~= nil then
            physics.addBody(ground, self.physic.type, self.physic.options)
        end

        self.displayObject = ground
    end

    return ground
end

return GroundCreator