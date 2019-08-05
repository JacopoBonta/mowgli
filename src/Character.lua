function Character()

    local character = {
        x = 0,
        y = 0,
        physic = {
            type = nil,
            options = {}
        },
        pv = 1,
        speed = 0,
        sprite = { }
    }

    function character:setDirection(direction, speed)
        if speed > 0 then
            if direction == 'right' then
                self.displayObject.xScale = -1
                self.speed = -speed
            elseif direction == 'left' then
                self.displayObject.xScale = 1
                self.speed = speed
            end
            self.displayObject:setSequence('run')
            self.displayObject:play()
        end
    end

    function character:setPhysic(type, density, friction, bounce)
        self.physic.type = type 
        self.physic.options.density = density
        self.physic.options.friction = friction
        self.physic.options.bounce = bounce
    end

    function character:setPos(x, y)
        self.x = x
        self.y = y
    end

    function character:setSprite(infoPath, sheetPath, sequenceData)
        self.sprite.info = require(infoPath)
        self.sprite.sheetPath = sheetPath

        -- substitute frame keys with corresponding frame index
        for i, seq in ipairs(sequenceData) do
            local frames = {}
            for i, v in ipairs(seq.frames) do
                table.insert(frames, i, self.sprite.info:getFrameIndex(v))
            end
            seq.frames = frames
        end

        self.sprite.sequenceData = sequenceData
    end

    function character:show(view)
        local sheet = graphics.newImageSheet(self.sprite.sheetPath, self.sprite.info:getSheet())
        
        local chSprite = display.newSprite(view, sheet, self.sprite.sequenceData)
        chSprite.x = self.x
        chSprite.y = self.y
        chSprite.isFixedRotation = true

        if self.physic.type ~= nil then
            physics.addBody(chSprite, self.physic.type, self.physic.options)
        end

        self.displayObject = chSprite

        self.displayObject:play()
    end

    function character:stand()
        self.speed = 0
        self.displayObject:setSequence('idle')
        self.displayObject:play()
    end

    function character:updatePosition()
        self.displayObject.x = self.displayObject.x + self.speed
    end

    return character
end

return Character