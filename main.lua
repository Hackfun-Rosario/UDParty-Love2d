-- LOVE receiver

local socket = require("socket")

function love.load()
    udp = socket.udp()
    udp:setsockname("*", 12345)
end

function love.update(deltatime)
    repeat
        local data, ip, port = udp:receivefrom()

        print(data, ip, port)
    until not data
end

function love.draw()

end
