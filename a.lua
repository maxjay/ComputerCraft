direction = 0 --left = -1, right = +1
x = 0
y = 0
size = 2

function loc()
    print(x, y, direction)
end

function moveRight()
    turtle.turnRight()
    direction = direction +1
end

function moveLeft()
    turtle.turnLeft()
    direction = direction - 1
end

function forward()
    turtle.dig()
    turtle.forward()
    if direction == 0 then y = y + 1
    elseif direction == 1 then x = x + 1
    elseif direction == 2 then y = y - 1
    elseif direction == 3 then x = x - 1 end 
end

function zigZagTurn()
    if direction == 0 then
        moveRight()
        turtle.dig()
        forward()
        moveRight()
        turtle.dig()
    elseif direction == 2 then
        moveLeft()
        turtle.dig()
        forward()
        moveRight()
        turtle.dig()
    end
end

function mine(size)
    turtle.dig()
    for i = size, 1, -1
    do
        for i = size, 1, -1
        do
            forward()
        end
        zigZagTurn()
    end
end

function resetDirection()
    while (direction > 0)
    do
        turtle.turnLeft()
        direction = (direction - 1) % 4 
    end
end

function depositIntoChest()
    if direction ~= 0 then resetDirection() end
    turtle.turnLeft()
    for i = 16, 1, -1 
    do
        turtle.select(i)
        turtle.drop()
        print("Hello")
    end
    turtle.turnRight()
end

print("Initialising")
mine(size)
