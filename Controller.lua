Controller = {}

function Controller:new (o)
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

function Controller:forward ()
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

function Controller:turnLeft ()
    print("TURN LEFT")
    turtle.turnLeft()
    self.direction = (self.direction - 1) % 4
end

function Controller:turnRight ()
    print("TURN RIGHT")
    turtle.turnRight()
    self.direction = (self.direction + 1) % 4
end
