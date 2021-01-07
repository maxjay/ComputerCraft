import turtle

x = y = 0
z = 68
direction = 1

coords = [[x,y,z] for x in range(15, -1, -1) for y in range(15, -1, -1) for z in range(69, 0, -1)]
#print(coords)
#print(len(coords))
#t = turtle.Turtle()
#t.speed(0)
x = y = 0
z = 68
fuel = 0
def location():
    global x,y,z
    print("Location:", [x,y,z], "Direction:", direction)

def dig():
    global x,y,z
    coordsToDig = [x,y,z]
    if direction == 0:
        coordsToDig[1] += 1
    elif direction == 2:
        coordsToDig[1] -= 1
    elif direction == 3:
        coordsToDig[0] -= 1
    elif direction == 1:
        coordsToDig[0] += 1
    print("Digging:", coordsToDig)
    if coordsToDig not in coords:
        print("Inefficient!!!")
    else:
        coords.remove(coordsToDig)
        coordsToDig[2] += 1
        if coordsToDig in coords:
            coords.remove(coordsToDig)
        coordsToDig[2] += -2
        if coordsToDig in coords:
            coords.remove(coordsToDig)

def forward():
    global x,y, fuel
    fuel += 1
    dig()
    #t.forward(20)
    if direction == 0:
        y += 1
    elif direction == 2:
        y -= 1
    elif direction == 3:
        x -= 1
    elif direction == 1:
        x += 1
    #t.pensize(10)
    #t.pencolor("red")
    #t.fillcolor("red")
    #t.begin_fill()
    #t.circle(2)
    #t.end_fill()
    #t.pencolor("black")
    #t.pensize(1)

def turnLeft():
    global direction, fuel
    fuel += 1
    #t.left(90)
    direction = (direction - 1) % 4

def turnRight():
    global direction, fuel
    fuel += 1
    #t.right(90)
    direction = (direction + 1) % 4

def snakeTurn(flip):
    location()
    if flip:
        print("TURN RIGHT")
        turnRight()
        forward()
        turnRight()
    else:
        print("TURN LEFT")
        turnLeft()
        forward()
        turnLeft()
    location()

def snakeMine(size=16):
    global z
    for i in range(size, 0, -2):
        z = i
        snakeMineLayer(size)
        turnLeft()
        dig()

def snakeMineLayer(size=16):
    flip = False
    for i in range(size//2):
        print("==========", i)
        for j in range(size, 1, -1):
            print("========", j)
            #location()
            forward()
        snakeTurn(flip)
        flip = not flip
        for j in range(size, 1, -1):
            #location()
            forward()
        print(i, (size//2)-1)
        if i != (size//2)-1:
            snakeTurn(flip)
        flip = not flip

snakeMine(16)
print(coords)
print(fuel)
#t.getscreen()._root.mainloop() 