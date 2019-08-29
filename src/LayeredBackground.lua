-- LayeredBackground permette di creare un background formato da più immagini (layers). I layers vengono stampati uno sopra l'altro.

-- Here we use a table as the namespace of our class
local LayeredBackground = {}

-- new() method is used as the constructor for a LayeredBackground object
function LayeredBackground:new(o)
    o = o or { x = 0, y = 0 }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- addLayer() add a new layer to the background. It takes three arguments, a string that is the path to the actual image and two numbers that are the width and the length of the image
function LayeredBackground:addLayer(path, width, height)
    local images = self.layers or {}
    local z = self.zIndex or 1
    table.insert(images, z, {
        path = path,
        width = width,
        height = height
    })
    self.zIndex = z + 1
    self.layers = images
end

-- addToCamera() method add the display objects created for each image to a display object group. Use this if you have a camera and want the background move accordingly.
function LayeredBackground:addToCamera(camera)
    self.cameraGroup = camera
end

-- show() method creates an image rect for each image and position them accordingly. Eventually if a camera was set, add the rects to that display group.
function LayeredBackground:show()
    local rects = self.rects or {}
    for _, v in pairs(self.layers) do
        local rect = display.newImageRect(v.path, v.width, v.height)
        rect.x = self.x
        rect.y = self.y

        table.insert(rects, rect)

        if self.cameraGroup then
            self.cameraGroup:insert(rect)
        end
    end
    self.rects = rects
end

function LayeredBackground:delete()
    for _, v in pairs(self.rects) do
        display.removeObjec(v)
    end
    self = nil
end

return LayeredBackground