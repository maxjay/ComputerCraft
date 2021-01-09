Controller = {}
modem = peripheral.wrap("left")
modem.open(69)
modem.open(1)
function Controller:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = 0
    self.y = 0
    self.z = 0
    self.direction = 0
    return o
end

function Controller:goBackToOrigin ()
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
    while (self.z ~= 0) 
    do
        turtle.down()
        self.z = self.z - 1
    end
    self:orientate()
end

function Controller:dig ()
    while (turtle.detect())
    do
        turtle.dig()
    end
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

function Controller:validate()
    local turtles = 0
    local chests = 0
    for i = 1, 16, 1
    do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "computercraft:turtle_expanded" then
                turtles = turtles + 1
            elseif item.name == "enderstorage:ender_storage" then
                chests = item.count
            end
        end
    end
    if (turtle == 4 and chest == 4) then return true end
    return false
end 
        

function Controller:deposit()
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

function Controller:cleanUp()
    print("Collecting")
    self:forward()
    for j = 0, 3, 1
    do
        for i = 0, 7, 1
        do
            self:forward()
            turtle.digUp()
        end
        self:turnLeft()
    end
    self:goBackToOrigin()
    self:validate()
end

function Controller:selectTurtle()
    for i = 1, 15, 1
    do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "computercraft:turtle_expanded" then
                turtle.select(i)
                return true
            end
        end
    end
end

function Controller:placeTurtle()
    while (turtle.detectDown())
    do
        turtle.digDown()
    end
    self:selectTurtle()
    turtle.placeDown()
    peripheral.call("bottom", "turnOn")
end

function Controller:selectChest()
    for i = 1, 15, 1
    do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "enderstorage:ender_storage" then
                turtle.select(i)
                return true
            end
        end
    end
end

function Controller:selectBucket()
    for i = 1, 15, 1
    do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "minecraft:bucket" then
                turtle.select(i)
                return true
            end
        end
    end
end

function Controller:placeChest()
    self:turnRight()
    self:turnRight()
    self:selectChest()
    turtle.place()
    self:turnRight()
    self:turnRight()
end

function Controller:up()
    turtle.up()
    self.z = self.z + 1
end

function Controller:orientate()
    while (self.direction ~= 0)
    do
        self:turnLeft()
    end
end

function Controller:setup()
    self:up()
    self:forward()

    self:placeTurtle()
    self:turnLeft()
    self:forward()
    self:placeChest()
    for i = 0, 6, 1
    do 
        self:forward()
    end
    self:orientate()
    self:placeTurtle()
    self:forward()
    self:placeChest()
    for i = 0, 6, 1
    do 
        self:forward()
    end
    self:orientate()
    self:placeTurtle()
    self:turnRight()
    self:forward()
    self:placeChest()
    for i = 0, 6, 1
    do 
        self:forward()
    end
    self:orientate()
    self:placeTurtle()
    self:turnRight()
    self:turnRight()
    self:forward()
    self:placeChest()
    self:up()
    self:up()
    self:goBackToOrigin()
end

function Controller:sendGo()
    modem.transmit(1, 69, "Go")
    modem.transmit(1, 69, "Go")
    modem.transmit(1, 69, "Go")
    modem.transmit(1, 69, "Go")
end

function Controller:wait()
    local _1 = false
    local _2 = false
    local _3 = false
    local _4 = false
    while not (_1 and _2 and _3 and _4)
    do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
        print(message)
        if message == "Done" then
            if replyChannel == 1 then 
                _1 = true 
            elseif replyChannel == 2 then
                _2 = true
            elseif replyChannel == 3 then
                _3 = true
            elseif replyChannel == 4 then
                _4 = true
            end
        end
    end
    modem.transmit(69, 70, "Chunk cleared")
end

function Controller:refuel ()
    turtle.select(16)
    turtle.place()
    turtle.up()
    turtle.up()
    turtle.forward()
    for i = 1, 15, 1
    do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "computercraft:turtle_expanded" then
                turtle.select(i)
                turtle.placeDown()
                turtle.turnRight()
                turtle.turnRight()
                peripheral.call("bottom", "turnOn")
                turtle.turnRight()
                turtle.turnRight()
                modem.transmit(1, 69, "Refuel")
                while true
                do
                    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
                    if string.sub(message, 1, 11) == "Refuel Done" then
                        turtle.digDown()
                        break
                    end
                end
            end
        end
    end
    turtle.down()
    while turtle.getFuelLevel() < 20000
    do
        turtle.suckDown()
        turtle.refuel()
        self:selectBucket()
        turtle.dropDown()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
        turtle.turnRight()
    end
    turtle.back()
    turtle.down()
    turtle.select(16)
    turtle.dig()
    modem.transmit(69, 70, "Refuelled!!!")
end

con = Controller:new(nil)
con:setup()
con:sendGo()
con:deposit()
con:wait()
con:cleanUp()
con:refuel()