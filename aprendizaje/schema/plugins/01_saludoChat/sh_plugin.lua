PLUGIN.name = "01_saludoChat"
PLUGIN.author = "Kiramui"
PLUGIN.description = "Agrega el comando /saludo y permite activarlo con una tecla."

ix.chat.Register("saludo", {
    format = "%s dice: %s",
    GetColor = function(self, speaker, text)
        return Color(200, 200, 255)
    end,
    CanHear = ix.config.Get("chatRange", 280),
    prefix = {"/saludo"}
})

ix.command.Add("saludo", {
    description = "Presenta tu personaje automáticamente.",
    OnRun = function(self, client)
        local character = client:GetCharacter()
        if character then
            local name = character:GetName()
            local faction = ix.faction.Get(character:GetFaction()).name
            local saludo = "¡Saludos! Soy " .. name .. " de la facción " .. faction .. "."
            
            ix.chat.Send(client, "saludo", saludo, false)
        end
    end
})


if CLIENT then
    local keyPressed = false

    hook.Add("Think", "ixSaludoKey", function()
        -- Cambia KEY_G por la tecla que quieras
        if input.IsKeyDown(KEY_G) and not keyPressed then
            RunConsoleCommand("say", "/saludo") 
            keyPressed = true
        elseif not input.IsKeyDown(KEY_G) then
            keyPressed = false
        end
    end)
end