print("[HousePoints] Cliente cargado")

local housePoints = {}
local pointLabels = {}

net.Receive("HousePoints_SendPoints", function()

    housePoints = net.ReadTable()

    for house, points in pairs(housePoints) do

        if (IsValid(pointLabels[house])) then

            pointLabels[house]:SetText(
                house .. ": " .. points
            )

            pointLabels[house]:SizeToContents()

        end
    end

end)

net.Receive("HousePoints_OpenMenu", function()

    print("[HousePoints] Abriendo menú")

    local frame = vgui.Create("DFrame")
    frame:SetSize(500, 300)
    frame:Center()
    frame:SetTitle("Puntos de las Casas")
    frame:MakePopup()

    local y = 40

    for house, points in pairs(housePoints) do

        local label = vgui.Create("DLabel", frame)

        label:SetPos(20, y)
        label:SetText(house .. ": " .. points)
        label:SizeToContents()

        pointLabels[house] = label

        local amountEntry = vgui.Create("DTextEntry", frame)

        amountEntry:SetPos(250, y)
        amountEntry:SetSize(60, 25)

        amountEntry:SetNumeric(true)
        amountEntry:SetValue("1")

        local addButton = vgui.Create("DButton", frame)

        addButton:SetSize(30, 25)
        addButton:SetPos(320, y)
        addButton:SetText("+")

        addButton.DoClick = function()

            local amount = tonumber(amountEntry:GetValue()) or 0
            print("Sumando:", amount)
            print("Sumar a:", house)

            net.Start("HousePoints_AddPoint")
            net.WriteString(house)
            net.WriteUInt(amount, 16)
            net.SendToServer()
        end

        local removeButton = vgui.Create("DButton", frame)

        removeButton:SetSize(30, 25)
        removeButton:SetPos(360, y)
        removeButton:SetText("-")

        removeButton.DoClick = function()
            local amount = tonumber(amountEntry:GetValue()) or 0
            print("Restando:", amount)
            print("Restar a:", house)
            net.Start("HousePoints_RemovePoint")
            net.WriteString(house)
            net.WriteUInt(amount, 16)
            net.SendToServer()
        end

        y = y + 40
    end

    local resetButton = vgui.Create("DButton", frame)
    resetButton:SetSize(150, 30)
    resetButton:SetPos(20, y + 20)
    resetButton:SetText("Resetear Todo")

    resetButton.DoClick = function()
        net.Start("HousePoints_Reset")
        net.SendToServer()
    end

end)