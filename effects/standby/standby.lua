-- Pone la pantalla en standby
-- Formato de payload: "stdby"

local thread
local utils = require("utils/utils")
local color = { r = 0, g = 0, b = 0 }
local alpha = 0

return {
    load = function()
        -- thread = love.thread.newThread('effects/standby/threadcode/standby_thread.lua')
    end,

    update = function(dt, data)
        thread:start(dt)
    end,

    draw = function()
        love.graphics.setBackgroundColor(0, 0, 0)
    end
}
