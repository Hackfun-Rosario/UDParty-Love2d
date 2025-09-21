-- Parpadea la pantalla del color indicado, una o múltiples veces
-- Formato de payload
-- r,g,b,rep en donde r, g y b son los colores primarios y rep es la cantidad de repeticiones
-- Ejemplo: 255,0,255,3  -> parpadea el color violeta 3 veces sucesivamente

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
        color.r = tonumber(msgParams[2]) / 255
        color.g = tonumber(msgParams[3]) / 255 or 0
        color.b = tonumber(msgParams[4]) / 255 or 0
        local msgTimes = tonumber(msgParams[5]) or 1

        if msgTimes > 10 then
            return -- No te zarpes
        end

        thread:start(dt, msgTimes)
    end,

    draw = function()       
        -- Obtiene valor de alpha
        local blinkAlpha = love.thread.getChannel('blink'):pop()
        if (blinkAlpha) then
            alpha = tonumber(blinkAlpha) or 0
        end

        -- Dimensiones del rectángulo: pantalla
        w = love.graphics.getWidth()
        h = love.graphics.getHeight()
        -- Define el color
        love.graphics.setColor(color.r, color.g, color.b, alpha)
        -- Pinta el rectángulo
        love.graphics.rectangle('fill', 0, 0, w, h)
    end
}
