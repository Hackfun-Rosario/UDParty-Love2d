-- Crea la ilusión de un cubo en profundidad
-- Formato de payload: "cube"

local utils = require("utils/utils")

local x
local y
local width
local height

return {
    load = function()
        width = love.graphics.getWidth() / 3
        height = love.graphics.getHeight() / 3
        x = (love.graphics.getWidth() / 2) - (width / 2)
        y = (love.graphics.getHeight() / 2) - (height / 2)
    end,

    update = function(dt, data)
        local msgParams = utils.split(data, ',')

        xOffset = tonumber(msgParams[2]) or 0
        yOffset = tonumber(msgParams[3]) or 0

        -- x = x + xOffset
        -- y = y + yOffset
        x = xOffset + love.graphics.getWidth() / 2 - width / 2
        y = yOffset + love.graphics.getHeight() / 2 - height / 2
    end,

    draw = function()
        -- Rectángulo central
        love.graphics.rectangle("line", x, y, width, height)

        -- Esquina superior izquierda
        love.graphics.line(0, 0, x, y)

        -- Esquina superior derecha
        love.graphics.line(love.graphics.getWidth(), 0, x + width, y)

        -- Esquina inferior izquierda
        love.graphics.line(0, love.graphics.getHeight(), x, y + height)

        -- Esquina inferior derecha
        love.graphics.line(love.graphics.getWidth(), love.graphics.getHeight(), x + width, y + height)
    end
}
