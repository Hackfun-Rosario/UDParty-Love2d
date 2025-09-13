local thread
local utils = require("utils/utils")
local color = { r = 0, g = 0, b = 0 }
local alpha = 0

return {
    load = function()
        thread = love.thread.newThread('effects/blink/threadcode/blink_thread.lua')
    end,

    update = function(dt, data)
        local msgParams = utils.split(data, ',')
        color.r = tonumber(msgParams[1])
        color.g = tonumber(msgParams[2]) or 0
        color.b = tonumber(msgParams[3]) or 0
        local msgTimes = tonumber(msgParams[4]) or 1
        thread:start(dt, msgTimes)
    end,

    draw = function()
        love.graphics.setBackgroundColor(0, 0, 0)
        local blinkres = love.thread.getChannel('blink'):pop()

        if (blinkres) then
            alpha = tonumber(blinkres) or 0
            -- else
            --     color.r = 0
        end

        love.graphics.setColor(color.r, color.g, color.b, alpha)
        w = love.graphics.getWidth()
        h = love.graphics.getHeight()
        love.graphics.rectangle('fill', 0, 0, w, h)
    end
}