-- Reproduce un video en loop
-- Formato de payload: "video"

local utils = require("utils/utils")

return {
    load = function()
        video = love.graphics.newVideo("assets/video.ogv")
        video:play()
    end,

    update = function(dt, data)
        --
    end,

    draw = function()
        love.graphics.draw(video, 0, 0)
        if video:isPlaying() then
            --
        else
            video:rewind()
            video:play()
        end
    end
}
