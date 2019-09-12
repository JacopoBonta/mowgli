-- Ground permette di creare un terreno che viene generato man mano che la telecamera si sposta in avanti.
local Ground = {}

-- new() crea un nuovo oggetto Ground
-- camera = un oggetto camera, usato come riferimento per creare e posizionare i blocchi
function Ground:new(camera)
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

-- setBlock() setta il tipo di blocco che sarà utilizzato per generare il terreno. Viene creata un funzione _createBlock() che crea un nuovo blocco della dimensione specificata.
-- Block = classe Blocco, la classe che verrà utilizzata per creare nuovi blocchi.
-- path = string, immagine utilizzata per il blocco
-- height = number, altezza base del blocco
-- width = number, larghezza base del blocco
function Ground:setBlock(Block, path, width, height)
    -- _createBlock crea una nuovo blocco
    self._createBlock = function ()
        local block = Block:new(path, width, height)
        table.insert(self.blocks, block)
        return block
    end
end

-- init() inizializza il terreno creando un blocco grande tre volte lo schermo
function Ground:init()
    self.offsetX = display.contentCenterX
    local block = self._createBlock()
    block.x = self.offsetX
    block.y = display.contentHeight - 16
    block:init(self.camera.borderRight * 3)
    self.camera:add(block.sprite)
    self._lastBlock = block
end

-- update() viene chiamato ad ogni frame. Crea nuovi blocchi e cancella quelli fuori schermo.
function Ground:update()
    
    -- crea nuovo blocco
    if (self._lastBlock.x - self.camera.x < self._lastBlock.width) then
        
        local blockWidth = math.random(1200, 3800)
        local holeWidth = math.random(100, 200)
        self.offsetX = self.offsetX + blockWidth / 2 + holeWidth
        
        local block = self._createBlock()
        block.x = self.offsetX
        block.y = display.contentHeight - 16
        block:init(blockWidth)
        self.camera:add(block.sprite)
        self.offsetX = self.offsetX + block.width / 2

        self._lastBlock = block
    end

    -- cancella i blocchi fuori dallo schermo
    for i, block in ipairs(self.blocks) do
        if block.sprite.x + block.width / 2 < self.camera.borderLeft then
        table.remove(self.blocks, i)
            self.camera:remove(block.sprite)
            block:delete()
        end
    end

end

-- delete() cancella i blocchi ed il terreno
function Ground:delete()
    for _, block in pairs(self.blocks) do
        self.camera:remove(block.sprite)
        block:delete()
    end
    self.blocks = {}
    self = nil
end

return Ground
