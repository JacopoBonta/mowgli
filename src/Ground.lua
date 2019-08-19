function Ground(path, width, height)
    local ground = {
        path = path,
        x = 0,
        y = 0,
        width = width,
        height = height,
        physic = {
            type = nil,
            options = {}
        }
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

    function ground:setCamera(camera)
        self.camera = camera
    end

    function ground:show(group)
        local ground = display.newImageRect(self.path, self.width, self.height)
        ground.x = self.x
        ground.y = self.y

        if self.physic.type ~= nil then
            physics.addBody(ground, self.physic.type, self.physic.options)
        end

        if self.camera then
            self.camera:insert(ground)
        end

        if group then
            table.insert(group, ground)
        end
    end

    return ground
end

return Ground