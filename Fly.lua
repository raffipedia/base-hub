return function(ExtraTab)
    local flyWindow
    local flying = false
    local speed = 50
    local height = 0
    local flyConnection

    -- Fungsi bikin window
    local function CreateFlyWindow()
        if flyWindow then flyWindow:Destroy() end

        -- Buat window kecil (contoh pake Instance bawaan biar universal)
        flyWindow = Instance.new("ScreenGui")
        flyWindow.Name = "FlyWindow"
        flyWindow.ResetOnSpawn = false
        flyWindow.Parent = game:GetService("CoreGui")

        local frame = Instance.new("Frame", flyWindow)
        frame.Size = UDim2.new(0, 250, 0, 180)
        frame.Position = UDim2.new(0.5, -125, 0.5, -90)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        frame.Active = true
        frame.Draggable = true

        -- Tombol Fly
        local flyBtn = Instance.new("TextButton", frame)
        flyBtn.Size = UDim2.new(0, 80, 0, 30)
        flyBtn.Position = UDim2.new(0, 10, 0, 10)
        flyBtn.Text = "Fly: OFF"

        flyBtn.MouseButton1Click:Connect(function()
            flying = not flying
            flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")
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
        end)

        -- Tombol Speed +
        local plusBtn = Instance.new("TextButton", frame)
        plusBtn.Size = UDim2.new(0, 40, 0, 30)
        plusBtn.Position = UDim2.new(0, 100, 0, 10)
        plusBtn.Text = "+"

        plusBtn.MouseButton1Click:Connect(function()
            speed = speed + 5
        end)

        -- Tombol Speed -
        local minusBtn = Instance.new("TextButton", frame)
        minusBtn.Size = UDim2.new(0, 40, 0, 30)
        minusBtn.Position = UDim2.new(0, 150, 0, 10)
        minusBtn.Text = "-"

        minusBtn.MouseButton1Click:Connect(function()
            speed = math.max(0, speed - 5)
        end)

        -- Tombol Up
        local upBtn = Instance.new("TextButton", frame)
        upBtn.Size = UDim2.new(0, 80, 0, 30)
        upBtn.Position = UDim2.new(0, 10, 0, 50)
        upBtn.Text = "Up"

        upBtn.MouseButton1Click:Connect(function()
            height = height + 5
        end)

        -- Tombol Down
        local downBtn = Instance.new("TextButton", frame)
        downBtn.Size = UDim2.new(0, 80, 0, 30)
        downBtn.Position = UDim2.new(0, 100, 0, 50)
        downBtn.Text = "Down"

        downBtn.MouseButton1Click:Connect(function()
            height = height - 5
        end)

        -- Tombol Minimize
        local minimizeBtn = Instance.new("TextButton", frame)
        minimizeBtn.Size = UDim2.new(0, 80, 0, 30)
        minimizeBtn.Position = UDim2.new(0, 10, 0, 90)
        minimizeBtn.Text = "Minimize"

        minimizeBtn.MouseButton1Click:Connect(function()
            frame.Visible = not frame.Visible
        end)

        -- Tombol Close
        local closeBtn = Instance.new("TextButton", frame)
        closeBtn.Size = UDim2.new(0, 80, 0, 30)
        closeBtn.Position = UDim2.new(0, 100, 0, 90)
        closeBtn.Text = "Close"

        closeBtn.MouseButton1Click:Connect(function()
            if flyWindow then flyWindow:Destroy() end
            flyWindow = nil
            if flyConnection then flyConnection:Disconnect() end
            flying = false
            ExtraTab.Flags["FlyWindowToggle"]:Set(false)
        end)
    end

    -- Toggle di ExtraTools
    ExtraTab:CreateToggle({
        Name = "Fly Window",
        CurrentValue = false,
        Flag = "FlyWindowToggle",
        Callback = function(Value)
            if Value then
                CreateFlyWindow()
            else
                if flyWindow then flyWindow:Destroy() end
                flyWindow = nil
                if flyConnection then flyConnection:Disconnect() end
                flying = false
            end
        end,
    })
end        downBtn.Position = UDim2.new(0, 100, 0, 50)
        downBtn.Text = "Down"

        downBtn.MouseButton1Click:Connect(function()
            height = height - 5
        end)

        -- Tombol Minimize
        local minimizeBtn = Instance.new("TextButton", frame)
        minimizeBtn.Size = UDim2.new(0, 80, 0, 30)
        minimizeBtn.Position = UDim2.new(0, 10, 0, 90)
        minimizeBtn.Text = "Minimize"

        minimizeBtn.MouseButton1Click:Connect(function()
            frame.Visible = not frame.Visible
        end)

        -- Tombol Close
        local closeBtn = Instance.new("TextButton", frame)
        closeBtn.Size = UDim2.new(0, 80, 0, 30)
        closeBtn.Position = UDim2.new(0, 100, 0, 90)
        closeBtn.Text = "Close"

        closeBtn.MouseButton1Click:Connect(function()
            if flyWindow then flyWindow:Destroy() end
            flyWindow = nil
            if flyConnection then flyConnection:Disconnect() end
            flying = false
            ExtraTab.Flags["FlyWindowToggle"]:Set(false)
        end)
    end

    -- Toggle di ExtraTools
    ExtraTab:CreateToggle({
        Name = "Fly Window",
        CurrentValue = false,
        Flag = "FlyWindowToggle",
        Callback = function(Value)
            if Value then
                CreateFlyWindow()
            else
                if flyWindow then flyWindow:Destroy() end
                flyWindow = nil
                if flyConnection then flyConnection:Disconnect() end
                flying = false
            end
        end,
    })
end        end,
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
