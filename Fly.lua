return function(ExtraTab)
    local flying = false
    local speed = 50
    local height = 0
    local flyConnection
    local minimized = false

    -- Section Fly
    ExtraTab:CreateSection("Fly Controls")

    -- Toggle Fly
    local flyToggle = ExtraTab:CreateToggle({
        Name = "Fly Mode",
        CurrentValue = false,
        Flag = "FlyToggle",
        Callback = function(Value)
            flying = Value
            if flying then
                local player = game.Players.LocalPlayer
                local hrp = player.Character:WaitForChild("HumanoidRootPart")
                flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    if flying and hrp then
                        hrp.Velocity = Vector3.new(0, height, 0) + hrp.CFrame.LookVector * speed
                    end
                end)
            else
                if flyConnection then flyConnection:Disconnect() end
            end
        end,
    })

    -- Naik (UP)
    local upButton = ExtraTab:CreateButton({
        Name = "UP",
        Callback = function()
            height = 50
        end,
    })

    -- Turun (DOWN)
    local downButton = ExtraTab:CreateButton({
        Name = "DOWN",
        Callback = function()
            height = -50
        end,
    })

    -- Speed + 
    local plusButton = ExtraTab:CreateButton({
        Name = "Increase Speed (+)",
        Callback = function()
            speed = math.clamp(speed + 10, 1, 100)
            Rayfield:Notify({Title="Speed Changed", Content="Speed sekarang: "..speed, Duration=2})
        end,
    })

    -- Speed -
    local minusButton = ExtraTab:CreateButton({
        Name = "Decrease Speed (-)",
        Callback = function()
            speed = math.clamp(speed - 10, 1, 100)
            Rayfield:Notify({Title="Speed Changed", Content="Speed sekarang: "..speed, Duration=2})
        end,
    })

    -- Minimize Button
    ExtraTab:CreateButton({
        Name = "Minimize Fly Controls",
        Callback = function()
            minimized = not minimized
            flyToggle.Visible = not minimized
            upButton.Visible = not minimized
            downButton.Visible = not minimized
            plusButton.Visible = not minimized
            minusButton.Visible = not minimized
        end,
    })
end
