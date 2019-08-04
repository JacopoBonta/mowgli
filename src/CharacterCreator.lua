function CharacterCreator(sheetPath, width, height, frames)

    local character = {
        path = sheetPath,
        x = 0,
        y = 0,
        width = width,
        height = height,
        physic = {
            type = nil,
            options = {}
        },
        sprite = {
            frames = frames,
            sequences = {}
        }
    }

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

    -- addSequence add a new sequence for the sprite. A sequence is a table with the following properties:
     -- - name
     -- - start
     -- - count
     -- - time
     -- - loopCount
     -- - loopDirection
    function character:addSequence(sequence)
        table.insert(self.sprite.sequences, sequence)
    end

    function character:show(view)
        local sheet = graphics.newImageSheet(self.path, { width = self.width, height = self.height, numFrames = self.sprite.frames })
        local chSprite = display.newSprite(view, sheet, self.sprite.sequences)
        chSprite.x = self.x
        chSprite.y = self.y
        chSprite.isFixedRotation = true

        if self.physic.type ~= nil then
            physics.addBody(chSprite, self.physic.type, self.physic.options)
        end

        self.displayObject = chSprite

        self.displayObject:setSequence('idle')
        self.displayObject:play()
    end

    return character
end

return CharacterCreator