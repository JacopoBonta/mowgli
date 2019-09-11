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
        lastCameraPos = camera.borderRight,
        offsetX = display.contentCenterX
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

-- setBlock() method is used to set the block type used for the ground
-- Block = class table, usually the GroundBlock class.
-- path = string, image sprite used for the block
-- height = number, height of the block
function Ground:setBlock(Block, path, width, height)
    -- _createBlock function creates new blocks given the block type and width
        -- width = number, width of the block
    self._createBlock = function (w)
        local block = Block:new(path, width, height)
        table.insert(self.blocks, block)
        block.x = self.offsetX
        block.y = display.contentHeight - 16
        block:init(w)
        self.camera:add(block.sprite)
        self.offsetX = self.offsetX + block.width / 2
        return block
    end
end

-- init() method initialize the ground with a fixed number of blocks
function Ground:init()
    self.offsetX = display.contentCenterX
    self._lastBlock = self._createBlock(self.camera.borderRight * 3)
end

function Ground:update()

    if (self._lastBlock.x - self.camera.x < self._lastBlock.width) then

        local blockWidth = math.random(1200, 3800)
        local holeWidth = math.random(100, 200)

        self.offsetX = self.offsetX + blockWidth / 2 + holeWidth
        
        self._lastBlock = self._createBlock(blockWidth)

    end

    for i, block in ipairs(self.blocks) do
        if block.sprite.x + block.width / 2 < self.camera.borderLeft then
        table.remove(self.blocks, i)
            self.camera:remove(block.sprite)
            block:delete()
        end
    end

end

-- delete() method remove the grounds' blocks and the ground itself
function Ground:delete()
    for _, block in pairs(self.blocks) do
        self.camera:remove(block.sprite)
        block:delete()
    end
    self.blocks = {}
    self = nil
end

return Ground
