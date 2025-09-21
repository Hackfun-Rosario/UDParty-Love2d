local thread
local utils = require("utils/utils")

return {
    load = function()
        thread = love.thread.newThread('effects/carrera/threadcode/carrera_thread.lua')
    end,

    update = function(dt, data)

        -- thread:start(dt, param)
    end,

    draw = function()
        -- 
    end
}
