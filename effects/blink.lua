require("love.timer")

local dt, times = ...

local i = 1
repeat
    -- print('Color:', color)
    -- if color == 'r' then
        love.thread.getChannel('blink'):push(255)
        love.timer.sleep(1 / 8 - dt)
        love.thread.getChannel('blink'):push(0)
        love.timer.sleep(1 / 8 - dt)
    -- else
        -- r = 0
    -- end
    i = i + 1
until i > times

