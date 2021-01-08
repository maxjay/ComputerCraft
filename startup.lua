modem = peripheral.wrap("right")

modem.open(1)
while true
    do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    print(message)
    if message == "Go" then
        break
    end
end
turtle.digUp()
turtle.transferTo(16)
turtle.select(1)
os.run({}, "MiningTurtle.lua")