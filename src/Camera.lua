function Camera()

    local camera = {
        objects = display.newGroup()
    }

    function camera:addDisplayObject(o)
        self.objects:insert(o)
    end

    function camera:setPosition(x, y)
        self.objects.x = x
        self.objects.y = y
    end

    function camera:moveForward(speed)
        self.objects.x = self.objects.x - speed
    end

    function camera:moveBackward(speed)
        self.objects.x = self.objects.x + speed
    end

    function camera:moveUp(speed)
        self.objects.y = self.objects.y + speed
    end

    function camera:moveDown(speed)
        self.objects.y = self.objects.y - speed
    end

    return camera
end

return Camera