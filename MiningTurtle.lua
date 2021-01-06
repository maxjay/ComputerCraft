function MiningTurtle:new (o, turtle, size)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.turtle = turtle
    self.x = 0
    self.y = 0
    self.z = 70
    self.direction = 0
    self.size = size or 4
    return 0
end

function MiningTurtle:getLocation ()
    print("Location: ", self.x, self.y, self.z, "\tDirection:", self.direction)
end

function MiningTurtle:dig ()
    self.turtle:dig()
    self.turtle.digUp()
    self.turtle.digDown()
end

function MiningTurtle:forward ()
    self:dig()
    if self.direction == 0 then
        self.y = self.y + 1
    elseif self.direction == 2 then
        self.y = self.y - 1
    elseif self.direction == 3 then
        self.x = self.x - 1
    elseif self.direction == 1 then
        self.x = self.x + 1
    end
end

mt = MiningTurtle:new(nil, turtle, 4)
mt:forward()
mt:getLocation()