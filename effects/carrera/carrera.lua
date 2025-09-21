-- Crea la ilusión de un cubo en profundidad
-- Formato de payload: "cube"

local utils = require "utils/utils"

return {
    load = function()
        car = Car()
    end,

    update = function(dt, data)
        local msgParams = utils.split(data, ',')

        dx = tonumber(msgParams[2]) or 0
        dy = tonumber(msgParams[3]) or 0

        if dx > 75 then
            car:moveRight(160)
        elseif dx > 65 then
            car:moveRight(120)
        elseif dx > 45 then
            car:moveRight(80)
        elseif dx > 25 then
            car:moveRight(40)
        elseif dx < -75 then
            car:moveLeft(160)
        elseif dx < -65 then
            car:moveLeft(120)
        elseif dx < -45 then
            car:moveLeft(80)
        elseif dx < -25 then
            car:moveLeft(40)
        else
            car:stopHorizontal()
        end

        if dy > 75 then
            car:moveDown(220)
        elseif dy > 55 then
            car:moveDown(190)
        elseif dy > 35 then
            car:moveDown(100)
        elseif dy > 15 then
            car:moveDown(40)
        elseif dy < -75 then
            car:moveUp(220)
        elseif dy < -55 then
            car:moveUp(190)
        elseif dy < -35 then
            car:moveUp(100)
        elseif dy < -15 then
            car:moveUp(40)
        else
            car:stopVertical()
        end

        car:update(dt)
    end,

    draw = function()
        love.graphics.setBackgroundColor(0.13,0.13,0.13)
        car:draw()
    end
}
