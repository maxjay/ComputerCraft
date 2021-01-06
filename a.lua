direction = 0 --left = -1, right = +1
x = 0
y = 0
size = 2

function loc()
    print(x, y, direction)
end

function moveRight()
    turtle.turnRight()
    direction = (direction + 1) % 4 
end

function moveLeft()
    turtle.turnLeft()
    direction = (direction - 1) % 4 
end

function forward()
    turtle.dig()
    turtle.forward()
    if direction == 0 then y = y + 1
    elseif direction == 1 then x = x + 1
    elseif direction == 2 then y = y - 1
    elseif direction == 3 then x = x - 1 end 
end

function zigZagTurn(flip)
    if flip then
        moveRight()
        forward()
        moveRight()
    else
        moveLeft()
        forward()
        moveLeft()
    end
end

function mine(size)
    flip = true
    for i = size -1, 1, -1
    do
        forward()
    end
    for i = size - 1, 1, -1
    do
        zigZagTurn(flip)
        for i = size - 1, 1, -1
        do
            forward()
        end
        flip = not flip
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
