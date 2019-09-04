-- Ground generates a ground based on ground blocks
local Ground = {}

-- new() method is the Ground class constructor
    -- width = number, the width of the ground
function Ground:new(width, camera)
    local o = {
        blocks = {},
        camera = camera,
        width = width,
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
    self._createBlock = function ()
        return Block:new(path, width, height)
    end
end

-- show() method create a new display object and eventually set the physic and camera group
function Ground:show()
    local offsetX = 0
    while offsetX < self.width do
        local block = self._createBlock()
        table.insert(self.blocks, block)
        block.x = offsetX
        block.y = display.contentHeight - 16
        block:show()
        self.camera:insert(block.sprite)
        offsetX = offsetX + block.width
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