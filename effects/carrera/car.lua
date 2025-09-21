Car = Class {}

-- CAR_SPEED = 100

function Car:init()
    self.width = 100
    self.height = 30
    self.x = (love.graphics.getWidth() / 2) - (self.width / 2)
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)

    self.speed = 0 --CAR_SPEED
    self.dx = 0
    self.dy = 0
end

function Car:collides()
    return false
end

function Car:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(love.graphics.getHeight() - self.height, self.y + self.dy * dt)
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(love.graphics.getWidth() - self.width, self.x + self.dx * dt)
    end
end

function Car:moveUp(speed)
    self.dy = -speed -- -CAR_SPEED
end

function Car:moveDown(speed)
    self.dy = speed -- CAR_SPEED
end

function Car:moveLeft(speed)
    self.dx = -speed -- -CAR_SPEED
end

function Car:moveRight(speed)
    self.dx = speed -- CAR_SPEED
end

function Car:stopVertical()
    self.dy = 0
end

function Car:stopHorizontal()
    self.dx = 0
end

function Car:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
