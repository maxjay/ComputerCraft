modem = peripheral.wrap("right")
modem.open(69)
modem.open(1)
while true
    do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    print(message)
    if message == "Go" then
        turtle.digUp()
        turtle.transferTo(16)
        turtle.select(1)
        os.run({}, "MiningTurtle.lua")
    elseif message == "Refuel" then
        modem.transmit(69, 1, "Refuelling: " .. tostring(turtle.getFuelLevel()))
        while turtle.getFuelLevel() <= 20000
        do
            turtle.suckDown()
            turtle.refuel()
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
        modem.transmit(69, 1, "Refuel Done: " .. tostring(turtle.getFuelLevel()))
    end
end
