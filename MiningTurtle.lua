MiningTurtle = {}
modem = peripheral.wrap("left")

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

function MiningTurtle:broadcastDone() 
    modem.transmit(69, 1, "Done")
end

function MiningTurtle:broadcastStatus()
    modem.transmit(69, 1, "(" + self.x + ", " + self.y + ", " + self.z + ") " + turtle.getFuelLevel())
end

function MiningTurtle:goBackToOrigin ()
    while (self.z ~= 0) 
    do
        turtle.up()
        self.z = self.z + 1
    end
    if (self.x > 0) then
        if (self.direction == 1) then
            self:turnRight()
            self:turnRight()
        elseif (self.direction == 0) then
            self:turnLeft()
        elseif (self.direction == 2) then
            self:turnRight()
        end
        while (self.x ~= 0)
        do
            self:forward()
        end
    elseif (self.x < 0) then
        if (self.direction == 3) then
            self:turnRight()
            self:turnRight()
        elseif (self.direction == 2) then
            self:turnLeft()
        elseif (self.direction == 0) then
            self:turnRight()
        end
        while (self.x ~= 0)
        do
            self:forward()
        end
    end
    if (self.y > 0) then
        if (self.direction == 0) then
            self:turnRight()
            self:turnRight()
        elseif (self.direction == 3) then
            self:turnLeft()
        elseif (self.direction == 1) then
            self:turnRight()
        end
        while (self.y ~= 0)
        do
            self:forward()
        end
    elseif (self.y < 0) then
        if (self.direction == 2) then
            self:turnRight()
            self:turnRight()
        elseif (self.direction == 1) then
            self:turnLeft()
        elseif (self.direction == 3) then
            self:turnRight()
        end
        while (self.y ~= 0)
        do
            self:forward()
        end
    end
end

function MiningTurtle:getLocation ()
    print("Location: ", self.x, self.y, self.z, "\tDirection:", self.direction)
    return "Location: " + self.x, self.y, self.z, "\tDirection:", self.direction
end

function MiningTurtle:deposit()
    turtle.select(16)
    turtle.digUp()
    turtle.placeUp()
    for selectslot=1, 15, 1 do
        turtle.select(selectslot)
        turtle.dropUp()
    end
    turtle.select(16)
    turtle.digUp()
end

function MiningTurtle:liftChest()
    turtle.select(16)
    turtle.placeUp()
end

function MiningTurtle:isFull() 
    if turtle.getItemCount(15) ~= 0 then
        turtle.select(16)
        turtle.digUp()
        turtle.placeUp()
        for selectslot=1, 15, 1 do
            turtle.select(selectslot)
            turtle.dropUp()
        end
        turtle.select(16)
        turtle.digUp()
    end
end

function MiningTurtle:dig ()
    while (turtle.detect())
    do
        turtle.dig()
    end
    self:isFull()
    turtle.digUp()
    self:isFull()
    turtle.digDown()
    self:isFull()
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
    for i = 71, 2, -3
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
    self.z = self.z + 3
end

mt = MiningTurtle:new(nil, turtle, 8)
mt:snakeMine()
mt:goBackToOrigin()
mt:deposit()
mt:liftChest()
mt:broadcastDone()
mt:getLocation()