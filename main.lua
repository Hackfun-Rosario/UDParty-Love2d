-- LOVE receiver
-- Ejecutar: love .

local socket = require("socket")
local udp
local msgParams = {}
local r = 0
local g = 0
local b = 0


function mysplit (inputstr, sep)
   -- if sep is null, set it as space
   if sep == nil then
      sep = '%s'
   end
   -- define an array
   local t={}
   -- split string based on sep   
   for str in string.gmatch(inputstr, '([^'..sep..']+)') 
   do
      -- insert the substring in table
      table.insert(t, str)
   end
   -- return the array
   return t
end

function love.load()
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
end

function love.update(dt)
    while true do
        local data, ip, port = udp:receivefrom()
        if data then
            print(data)

            msgParams = mysplit(data, ',')

            print('Primero: ', msgParams[1])
            print('Segundo: ', msgParams[2])

            if msgParams[1] == 'r' then
                r = 255
            else
                r = 0
            end

            if msgParams[1] == 'g' then
                g = 255
            else
                g = 0
            end

            if msgParams[1] == 'b' then
                b = 255
            else
                b = 0
            end
        else
            -- Salir del bucle si no hay más mensajes (no bloquear)
            break
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(r, g, b)
end