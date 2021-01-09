modem = peripheral.wrap("right")

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
        while turtle.getFuelLevel() <= 15000
        do
            turtle.suckDown()
            turtle.refuel()
            os.sleep(1)
        end
        modem.transmit(69, 1, "Refuel Done: " .. tostring(turtle.getFuelLevel()))
    end
end