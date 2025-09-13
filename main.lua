-- LOVE receiver
-- Ejecutar: love .
local socket = require("socket")
local udp
local utils = require("utils/utils")
local currentEffect = 'init'

-- Efectos disponibles
local standby = require("effects/standby/standby")
local blink = require("effects/blink/blink")

function love.load(filtered_args, args)
    -- Leer configuración desde archivo
    local success, config = pcall(require, "config")
    if not success then
        print("No se encontró el archivo config.lua:", config)
        config = {}
    end

    if config.port then
        print("Port from config:", config.port)
    else
        print("No se especificó el puerto. Usando valor por defecto 12345")
        config.port = 12345
    end

    -- Socket UDP
    udp = socket.udp()
    -- udp:setoption("reuseaddr", true)
    local success, err = udp:setsockname("*", config.port)
    if not success then
        print("Error al enlazar socket: ", err)
    else
        print("Escuchando...")
    end
    udp:settimeout(0) -- para que no bloquee el hilo principal

    -- Inicializar efectos
    standby.load()
    blink.load()
end

function love.update(dt)
    while true do
        local data = udp:receivefrom()

        if data then
            print("Recibido: ", data)

            local dataParams = utils.split(data, ',')
            currentEffect = dataParams[1]

            if currentEffect == 'standby' then
                standby.update();
            end

            if currentEffect == 'blink' then
                blink.update(dt, data)
            end
        else
            -- Salir del bucle si no hay más mensajes (no bloquear)
            break
        end
    end
end

function love.draw()
    if currentEffect == 'init' then
        love.graphics.setBackgroundColor(0, 0, 0)
    end

    if currentEffect == 'standby' then
        standby.draw()
    end

    if currentEffect == 'blink' then
        blink.draw()
    end
end
