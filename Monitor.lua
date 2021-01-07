modem = peripheral.wrap("back")

modem.open(69)
while true:
    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
    if replyChannel == 1 then
        print("Michael: " .. message)
    elseif replyChannel == 2 then
        print("Steven: " .. message)
    elseif replyChannel == 3 then
        print("Jessica: " .. message)
    elseif replyChannel == 4 then
        print("Oscar: " .. message)
    end
end