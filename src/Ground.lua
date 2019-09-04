-- Ground generates a ground based on ground blocks
local Ground = {}

-- new() method is the Ground class constructor
-- width = number, the width of the ground
function Ground:new(camera)
    -- here we set the seed for randomness - TODO replace 1 with os.time()
    math.randomseed(1)
    local o = {
        blocks = {},
        camera = camera,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- setBlock() method is used to set the block type used for the ground
-- Block = class table, usually the GroundBlock class.
-- path = string, image sprite used for the block
-- width = number, width of the block
-- height = number, height of the block
-- nb: set block define a new "private" function that creates new blocks given the block type
function Ground:setBlock(Block, path, width, height)
    self._blockWidth = width
    self._skippedBlock = 0
    self._createBlock = function (skip)
        if skip == 1 then
            print('creating block')
            local block = Block:new(path, width, height)
            table.insert(self.blocks, block)
            block.x = self.offsetX
            block.y = display.contentHeight - 16
            block:init()
            self.camera:add(block.sprite)
        else
            print('skipped block')
        end
        self.offsetX = self.offsetX + self._blockWidth
        return block
    end
end

-- init() method initialize the ground with a fixed number of blocks depending on its initial width
function Ground:init()
    self.offsetX = 0
    while self.offsetX < self.camera.borderRight * 2 do
        self._createBlock(1)
    end
    self.lastCameraPos = self.camera.borderRight
end

function Ground:update()
    -- print the next ground when the character reach half of the camera viewport

    if (self.camera.borderRight - self.lastCameraPos > self._blockWidth) then
        local rand = math.ceil(math.random() * 10) % 2

        -- non creare mai buchi piu grandi di tre blocchi
        if self._skippedBlock >= 2 or rand == 0 then
            self._createBlock(1)
            self._skippedBlock = 0
        else
            self._createBlock(0)
            self._skippedBlock = self._skippedBlock + 1
        end

        self.lastCameraPos = self.camera.borderRight
    end
    
    -- -- if the ground disapper from the screen to the left, assign the next ground to the current one and generate a new ground as the next ground

    for i, block in ipairs(self.blocks) do
        if block.sprite.x < self.camera.borderLeft - block.width then
            table.remove(self.blocks, i)
            self.camera:remove(block.sprite)
            block:delete()
        end
    end
end

-- delete() method remove the grounds' blocks and the ground itself
function Ground:delete()
    for _, block in pairs(self.blocks) do
        block:delete()
    end
    self = nil
end

return Ground