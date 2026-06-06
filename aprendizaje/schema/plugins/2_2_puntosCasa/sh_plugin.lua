PLUGIN.name = "Puntos Casa"
PLUGIN.author = "Kiramui"
PLUGIN.description = "Sistema de puntos."

PLUGIN.housePoints = {
    ["Gryffindor"] = 0,
    ["Slytherin"] = 0,
    ["Hufflepuff"] = 0,
    ["Ravenclaw"] = 0
}

ix.util.Include("sv_plugin.lua", "server")
ix.util.Include("cl_plugin.lua", "client")

local PLUGIN = PLUGIN

ix.config.Add(
    "permiteModificarPuntos",
    true,
    "Permite modificar los puntos de las casas.",
    nil,
    {
        category = "Config Puntos"
    }
)

if (SERVER) then
    util.AddNetworkString("HousePoints_OpenMenu")
    util.AddNetworkString("HousePoints_SendPoints")
    util.AddNetworkString("HousePoints_AddPoint")
    util.AddNetworkString("HousePoints_RemovePoint")
    util.AddNetworkString("HousePoints_Reset")
end

ix.command.Add("AbrirPuntos", {
    description = "Abre el menú.",

    OnRun = function(self, client)
        print("[HousePoints] Comando ejecutado")
        net.Start("HousePoints_SendPoints")
        net.WriteTable(PLUGIN.housePoints)
        net.Send(client)
        print("[HousePoints] Comando ejecutado 2")
        net.Start("HousePoints_OpenMenu")
        net.Send(client)

    end
})

