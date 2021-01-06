MiningTurtle = {}

function MiningTurtle:new (o, turtle, size)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = 0
    self.y = 0
    self.z = 0
    self.direction = 0
    self.size = size or 4
    return o
end

function MiningTurtle:getLocation ()
    print("Location: ", self.x, self.y, self.z, "\tDirection:", self.direction)
end

function MiningTurtle:isFull() 
    for i = 1, 16 do
        turtle.getItemCount(i)
        if turtle.getItemCount(i) == 0 then
            return true
        end
    end
    return false
end

function MiningTurtle:dropOff()
    print("DROP OFF")
end

function MiningTurtle:dig ()
    turtle.dig()
    if self:isFull() then self:dropOff()
    turtle.digUp()
    if self:isFull() then self:dropOff()
    turtle.digDown()
    if self:isFull() then self:dropOff()
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
    flip = false
    for i = 0, math.floor(self.size/2) - 1, 1
    do
        for j = self.size, 2, -1
        do 
            print(j)
            self:forward()
        end
        self:snakeTurn(flip)
        flip = not flip
        for j = self.size, 2, -1
        do 
            self:forward()
        end
        if i ~= (math.floor(self.size/2) - 1) then
            self:snakeTurn(flip)
        end
        flip = not flip
    end
end

function MiningTurtle:snakeMine ()
    for i = 71, 5, -2
    do
        self:snakeMineLayer()
        self:turnLeft()
        self:dig()
        turtle.down()
        self:dig()
        turtle.down()
        self:dig()
        turtle.down()
        self:dig()
        self.z = self.z - 3
    end
end

mt = MiningTurtle:new(nil, turtle, 4)
mt:snakeMine()
mt:getLocation()