-- LOVE receiver
-- Ejecutar: love .
local socket = require("socket")
local udp

-- Efectos disponibles
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
    blink.load()
end

function love.update(dt)
    while true do
        local data = udp:receivefrom()

        if data then
            print("Recibido: ", data)
            blink.update(dt, data)
        else
            -- Salir del bucle si no hay más mensajes (no bloquear)
            break
        end
    end
end

function love.draw()
    -- Dibujar los efectos

    blink.draw()
end
