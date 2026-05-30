PLUGIN.name = "00_Bienvenida"
PLUGIN.author = "Kiramui"
PLUGIN.description = "Mensaje de bienvenida."

function PLUGIN:PlayerLoadedCharacter(client)
    local character = client:GetCharacter()

    if (!character) then
        return
    end

    local money = character:GetMoney()
    local currency = ix.currency.plural or "dinero"
    local simbolo = ix.currency.symbol

    local mensaje = string.format(
        "Buenos días %s, tienes %s %s %s.",
        character:GetName(),
        simbolo,
        money,
        currency
    )

    -- Notificación Helix
    client:Notify(mensaje)

    -- Chat clásico
    client:SendLua(string.format([[
        chat.AddText(
            Color(245, 73, 39),
            "[ESTAFA] ",
            color_white,
            %q
        )
    ]], mensaje))

end