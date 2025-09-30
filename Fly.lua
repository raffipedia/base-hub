return function(Window)
    -- Ambil tab ExtraTools yang sudah ada
    local ExtraTab = Window:CreateTab("Extra Tools", 4483362458)

    ExtraTab:CreateSection("Fly System")

    -- Variabel Fly
    local flying = false
    local speed = 50
    local height = 0
    local player = game.Players.LocalPlayer
    local uis = game:GetService("UserInputService")
    local runService = game:GetService("RunService")

    -- Tombol untuk ON/OFF Fly
    ExtraTab:CreateToggle({
        Name = "Fly Mode",
        CurrentValue = false,
        Flag = "FlyToggle",
        Callback = function(Value)
            flying = Value
        end,
    })

    -- Tombol + dan - untuk speed
    ExtraTab:CreateButton({
        Name = "+ Speed",
        Callback = function()
            if speed < 100 then
                speed = speed + 5
                Rayfield:Notify({Title = "Fly Speed", Content = "Speed: " .. speed, Duration = 2})
            end
        end,
    })

    ExtraTab:CreateButton({
        Name = "- Speed",
        Callback = function()
            if speed > 5 then
                speed = speed - 5
                Rayfield:Notify({Title = "Fly Speed", Content = "Speed: " .. speed, Duration = 2})
            end
        end,
    })

    -- Tombol naik turun
    ExtraTab:CreateButton({
        Name = "Naik (Up)",
        Callback = function()
            height = height + 10
        end,
    })

    ExtraTab:CreateButton({
        Name = "Turun (Down)",
        Callback = function()
            height = height - 10
        end,
    })

    -- Sistem Fly
    runService.RenderStepped:Connect(function()
        if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local moveDir = player.Character.Humanoid.MoveDirection
            hrp.Velocity = Vector3.new(moveDir.X * speed, height, moveDir.Z * speed)
        end
    end)
end
