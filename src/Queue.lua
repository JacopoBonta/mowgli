-- Queue class is an implementation of FIFO queue using lua's table

local Queue = {}

function Queue:new()
    local q = {
        values = {}
    }
    setmetatable(q, self)
    self.__index = self
    return q
end

function Queue:push(value)
    table.insert(self.values, value)
    self.size = # self.values
end

function Queue:get()
    local v = table.remove(self.values, 1)
    self.size = # self.values
    return v
end

return Queue