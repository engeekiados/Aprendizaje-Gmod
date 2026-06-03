AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

local casas = {"Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw"}
--lua_run local ent = ents.Create("ix_sombreroSeleccionador") ent:SetPos(Entity(1):GetEyeTrace().HitPos) ent:Spawn()

function ENT:Initialize()
    self:SetModel("models/genosrp/sombrero_seleccionador/sombrero_seleccionador.mdl") -- Cambiar por el modelo real

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:Wake()
    end
end


function ENT:Use(client)
    print("[SOMBRERO] USE DETECTADO")

    if (!IsValid(client) or !client:IsPlayer()) then
        return
    end

    client:ChatPrint("Funciona!")

    local casa = casas[math.random(#casas)]
    print("[casa] USE DETECTADO"..casa)
    local seleccion = "El Sombrero Seleccionador te ha asignado a la casa: "..casa

-- Mensaje directo al jugador (debug)
    client:ChatPrint(seleccion)

    -- Mensaje usando el canal Helix
    ix.chat.Send(client, "seleccionador", seleccion)

    SombreroEnviarCasa(casa)
end
