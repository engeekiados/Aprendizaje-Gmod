print("[HousePoints] Servidor cargado")

local PLUGIN = PLUGIN

local function SendPoints(client)

    net.Start("HousePoints_SendPoints")
    net.WriteTable(PLUGIN.housePoints)
    net.Send(client)

end

local function SendPointsToAll()

    for _, ply in player.Iterator() do
        SendPoints(ply)
    end

end

net.Receive("HousePoints_AddPoint", function(len, client)

    print(
        "Config:",
        ix.config.Get("permiteModificarPuntos", true)
    )

    if (!ix.config.Get("permiteModificarPuntos", true)) then
        return
    end

    local house = net.ReadString()
    local amount = net.ReadUInt(16)


    print("Casa recibida:", house)

    if (PLUGIN.housePoints[house]) then
        PLUGIN.housePoints[house] = PLUGIN.housePoints[house] + amount

        print(
            house,
            "ahora tiene",
            PLUGIN.housePoints[house],
            "puntos"
        )
    end
    SendPointsToAll()

end)

net.Receive("HousePoints_RemovePoint", function(len, client)

    if (!ix.config.Get("permiteModificarPuntos", true)) then
        return
    end

    local house  = net.ReadString()
    local amount = net.ReadUInt(16)

    if (PLUGIN.housePoints[house]) then
        PLUGIN.housePoints[house] = math.max( 0, PLUGIN.housePoints[house] - amount )
         
        print( house, "ahora tiene", PLUGIN.housePoints[house], "puntos")
    end
    SendPointsToAll()

end)

net.Receive("HousePoints_Reset", function(len, client)

    if (!ix.config.Get("permiteModificarPuntos", true)) then
        return
    end

    print(client:Nick() .. " ha reseteado los puntos")

    for house, _ in pairs(PLUGIN.housePoints) do
        PLUGIN.housePoints[house] = 0
    end
    SendPointsToAll()

end)