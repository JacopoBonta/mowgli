function Camera()

    local camera = {
        displayObjects = display.newGroup(),
        borderLeft = 0,
        borderRight = display.contentWidth
    }

    function camera:insert(o)
        self.displayObjects:insert(o)
    end

    function camera:setPos(x, y)
        self.displayObjects.x = x
        self.displayObjects.y = y
    end

    function camera:moveForward(speed)
        self.displayObjects.x = self.displayObjects.x - speed
        self.borderLeft = self.borderLeft + speed
        self.borderRight = self.borderRight + speed
    end

    function camera:moveBackward(speed)
        self.displayObjects.x = self.displayObjects.x + speed
        self.borderLeft = self.borderLeft - speed
        self.borderRight = self.borderRight - speed
    end

    function camera:moveUp(speed)
        self.displayObjects.y = self.displayObjects.y + speed
    end

    function camera:moveDown(speed)
        self.displayObjects.y = self.displayObjects.y - speed
    end

    return camera
end

return Camera