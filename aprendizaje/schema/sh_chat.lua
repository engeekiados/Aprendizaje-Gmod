ix.chat.Register("seleccionador", {
   -- Dejamos el formato vacío para que no escriba nada por defecto
    format = "",
    -- Usamos OnChatAdd para definir exactamente qué queremos ver
    OnChatAdd = function(self, speaker, text)
        -- Esto imprime el mensaje personalizado en el chat
        chat.AddText(
            Color(97, 65, 186), "[SOMBRERO] ", -- Color y prefijo
            Color(97, 65, 186), text        -- Color del texto y el mensaje
        )
    end,
    GetColor = function(self, speaker, text)
        return Color(97, 65, 186)
    end,
    CanHear = ix.config.Get("chatRange", 280)
})