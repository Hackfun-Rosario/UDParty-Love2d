-- LOVE receiver
-- Ejecutar: love .

local socket = require("socket")
local utils = require("utils/utils")
local udp
local color = { r = 0, g = 0, b = 0 }
local thread

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
            local msgColor = msgParams[1]
            local msgTimes = tonumber(msgParams[2])

            -- print('Color: ', color)
            -- print('Repetir: ', times)

            thread:start(dt, msgTimes)
        else
            -- Salir del bucle si no hay más mensajes (no bloquear)
            break
        end
    end
end

function love.draw()
    local blinkres = love.thread.getChannel('blink'):pop()

    if (blinkres) then
        color.r = blinkres
    -- else
    --     color.r = 0
    end
    
    love.graphics.setBackgroundColor(color.r, color.g, color.b)
end
