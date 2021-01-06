direction = 0 --left = -1, right = +1
x = 0
y = 0
max = 2

function loc()
    print(x, y, direction)
end

function moveRight()
    turtle.right()
    direction = direction +1
end

function moveLeft()
    turtle.left()
    direction = direction - 1
end

function forward()
    turtle.dig()
    turtle.forward()
    if direction == 0 then y = y + 1 end 
    else if direction == 1 then x = x + 1 end
    else if direction == 2 then y = y - 1 end 
    else if direction == 3 then x = x - 1 end 
end

function zigZagTurn()
    if direction == 0 then
        moveRight()
        turtle.dig()
        forward()
        moveRight()
        turtle.dig()
    else if direction == 2 then
        moveLeft()
        turtle.dig()
        forward()
        moveRight()
        turtle.dig()
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
loc()
forward()
loc()
forward()
loc()
zigZagTurn()
loc()
forward()
loc()
forward()
loc()
zigZagTurn()
loc()
