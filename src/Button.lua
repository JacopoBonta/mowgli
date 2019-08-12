function Button()

    local button = {
        displayObject = nil,
        x = 0,
        y = 0,
        handlers = {
            before = function() print('before touch') end,
            after = function() print('after touch') end
        },
        sprite = {
            path = "",
            width = 0,
            height = 0
        },
        text = {
            string = nil,
            fontSize = 18,
        },
        view = nil
    }

    function button:setSprite(path, width, height)
        self.sprite.path = path
        self.sprite.width = width
        self.sprite.height = height
    end

    function button:setText(string, fontSize)
        self.text.string = string
        self.text.fontSize = fontSize
    end

    function button:setPos(x, y)
        self.x = x
        self.y = y
    end

    function button:registerBeforeTouchHandler(cb)
        self.handlers.before = cb
    end

    function button:registerAfterTouchHandler(cb)
        self.handlers.after = cb
    end

    function button:show(view)

        local button
        if self.text.string == nil then
            button = display.newImageRect(self.sprite.path, self.sprite.width, self.sprite.height)
            button.x = self.x
            button.y = self.y
        else
            button = display.newText(view, self.text.string, self.x, self.y, "assets/fonts/Windlass.ttf", self.text.fontSize)
            button:setFillColor( 0.76, 0.77, 0.18 )
        end

        button:addEventListener("touch", function(event)
            if event.phase == "began" then
                display.getCurrentStage():setFocus( event.target )
                self.handlers.before()
            elseif event.phase == "ended" then
                self.handlers.after()
                display.getCurrentStage():setFocus( nil )
            end
        end)

        self.displayObject = button
    end

    return button
    
end

return Button