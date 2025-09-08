-- LOVE receiver
-- Ejecutar: love .

local socket = require("socket")
local utils = require("utils/utils")
local udp
local color = { r = 0, g = 0, b = 0 }
local thread
local alpha = 0

function love.load()
    -- SOCKET
    udp = socket.udp()
    local port = 12345
    -- udp:setoption("reuseaddr", true)
    local success, err = udp:setsockname("*", port)
    if not success then
        print("Error al enlazar socket: ", err)
    else
        print("Escuchando en puerto ", port)
    end
    udp:settimeout(0) -- para que no bloquee el hilo principal

    -- THREAD
    thread = love.thread.newThread('effects/blink.lua')
    -- thread:start()
end

function love.update(dt)
    while true do
        local data = udp:receivefrom()

        if data then
            print(data)

            local msgParams = utils.split(data, ',')
            color.r = tonumber(msgParams[1])
            color.g = tonumber(msgParams[2])
            color.b = tonumber(msgParams[3])
            local msgTimes = tonumber(msgParams[4])

            thread:start(dt, msgTimes)
        else
            -- Salir del bucle si no hay más mensajes (no bloquear)
            break
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    local blinkres = love.thread.getChannel('blink'):pop()

    if (blinkres) then
        alpha = tonumber(blinkres) or 0
        -- else
        --     color.r = 0
    end

    -- print('r ', color.r)
    -- print('g ', color.g)
    -- print('b ', color.b)
    print('a ', alpha)

    love.graphics.setColor(color.r, color.g, color.b, alpha)
    w = love.graphics.getWidth()
    h = love.graphics.getHeight()
    love.graphics.rectangle('fill', 0, 0, w, h)
end
