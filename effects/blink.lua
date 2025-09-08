require("love.timer")

local dt, times = ...

local i = 1
repeat
    love.thread.getChannel('blink'):push(255)
    love.timer.sleep(1 / 8 - dt)
    love.thread.getChannel('blink'):push(0)
    love.timer.sleep(1 / 8 - dt)
    i = i + 1
until i > times
