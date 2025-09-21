-- Pone la pantalla en standby
-- Formato de payload: "standby"

return {
    load = function()
        image = love.graphics.newImage("assets/standby.jpg", {dpiscale = 0.55})
    end,

    update = function()
        image = love.graphics.newImage("assets/standby.jpg", {dpiscale = 0.55})
    end,

    draw = function()
        love.graphics.setColor(1,1,1)
        love.graphics.draw(image, 0, 0)
    end
}
