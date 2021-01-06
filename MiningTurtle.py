class MiningTurtle():
    def __init__(self, size=16):
        self.x = 0
        self.y = 0
        self.z = 70
        self.direction = 0
        self.size = size

    def getLocation(self):
        print("Location: ", (self.x, self.y, self.z), "\tDirection:", self.direction)

    def dig(self):
        print("dig up")
        print("dig down")
        print("dig infront")

    def forward(self):
        self.dig()
        print("go forward")
        if self.direction == 0:
            self.y += 1
        elif self.direction == 2:
            self.y -= 1
        elif self.direction == 3:
            self.x -= 1
        elif self.direction == 1:
            self.x += 1

    def turnLeft(self):
        print("turn left")
        self.direction = (self.direction - 1) % 4

    def turnRight(self):
        print("turn left")
        self.direction = (self.direction + 1) % 4

    def snakeTurn(self, flip):
        if flip:
            self.turnRight()
            self.forward()
            self.turnRight()
        else:
            self.turnLeft()
            self.forward()
            self.turnLeft()
    
    def snakeMine(self):
        for i in range(68, 0, -2):
            z = i
            self.snakeMineLayer()
            self.turnLeft()
            self.dig()

    def snakeMineLayer(self):
        for i in range(self.size//2):
            flip = False
            for j in range(self.size, 1, -1):
                self.forward()
            self.snakeTurn(flip)
            flip = not flip
            for j in range(self.size, 1, -1):
                self.forward()
            if i != (size//2) - 1:
                self.snakeTurn(flip)
            flip = not flip