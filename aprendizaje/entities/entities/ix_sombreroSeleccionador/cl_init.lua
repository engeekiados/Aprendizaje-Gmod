include("shared.lua")

net.Receive("SombreroCasa", function()
    local casa = net.ReadString()

    local sonidos = {
        Gryffindor = "sombrero/gryffindor.wav",
        Slytherin  = "sombrero/slytherin.wav",
        Hufflepuff = "sombrero/hufflepuff.wav",
        Ravenclaw  = "sombrero/ravenclaw.wav"
    }

    local sonido = sonidos[casa]
    if sonido then
        surface.PlaySound(sonido) -- cada cliente lo reproduce localmente
    end
end)