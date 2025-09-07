-- CLI Receiver
-- Ejecutar: lua receiver.lua

local socket = require("socket")
local udp = socket.udp()
udp:setsockname("*", 12345)

print("Listening...")

while true do
    local data, ip, port = udp:receivefrom()

    if data then
        print("Received:", data, "from", ip, port)
    end

end