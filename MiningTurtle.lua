MiningTurtle = {}

function MiningTurtle:new (o, turtle, size)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = 0
    self.y = 0
    self.z = 70
    self.direction = 0
    self.size = size or 4
    return o
end

function MiningTurtle:getLocation ()
    print("Location: ", self.x, self.y, self.z, "\tDirection:", self.direction)
end

function MiningTurtle:dig ()
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
end

function MiningTurtle:forward ()
    self:dig()
    turtle.forward()
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

function MiningTurtle:turnLeft ()
    print("TURN LEFT")
    turtle.turnLeft()
    self.direction = (self.direction - 1) % 4
end

function MiningTurtle:turnRight ()
    print("TURN RIGHT")
    turtle.turnRight()
    self.direction = (self.direction + 1) % 4
end

function MiningTurtle:snakeTurn(flip)
    if flip then
        self:turnRight()
        self:forward()
        self:turnRight()
    else
        self:turnLeft()
        self:forward()
        self:turnLeft()
    end
end

function MiningTurtle:snakeMineLayer ()
    for i = 0, math.floor(self.size/2), 1
    do
        flip = false
        for j = self.size, 1, -1
        do 
            self:forward()
        end
        self:snakeTurn(flip)
        flip = not flip
        for j = self.size, 1, -1
        do 
            self:forward()
        end
        if i ~= math.floor(self.size/2) - 1 then
            self:snakeTurn(flip)
        end
        flip = not flip
    end
end

function MiningTurtle:snakeMine ()
    for i = 1, 0, -2
    do
        z = i
        self:snakeMineLayer()
        self:turnLeft()
        self:dig()
    end
end

mt = MiningTurtle:new(nil, turtle, 4)
mt:snakeMine()
mt:getLocation()