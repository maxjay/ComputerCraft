modem = peripheral.wrap("right")

modem.open(1)
while true
    do
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    if message == "Go" then
        break
    end
end
os.run({}, "rom/MiningTurtle.lua")