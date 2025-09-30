return function(Window)
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    local flying = false
    local flySpeed = 50
    local minimized = false

    -- GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FlyGui"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Enabled = false -- awalnya disembunyiin

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 200, 0, 150)
    Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Parent = ScreenGui

    local UIList = Instance.new("UIListLayout")
    UIList.FillDirection = Enum.FillDirection.Vertical
    UIList.Parent = Frame

    -- Tombol Fly
    local flyBtn = Instance.new("TextButton")
    flyBtn.Text = "Fly: OFF"
    flyBtn.Size = UDim2.new(1, 0, 0, 30)
    flyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    flyBtn.TextColor3 = Color3.new(1,1,1)
    flyBtn.Parent = Frame

    -- Speed Info
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Text = "Speed: " .. flySpeed
    speedLabel.Size = UDim2.new(1, 0, 0, 30)
    speedLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    speedLabel.TextColor3 = Color3.new(1,1,1)
    speedLabel.Parent = Frame

    -- + Speed
    local plusBtn = Instance.new("TextButton")
    plusBtn.Text = "+"
    plusBtn.Size = UDim2.new(0.5, 0, 0, 30)
    plusBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    plusBtn.TextColor3 = Color3.new(1,1,1)
    plusBtn.Parent = Frame

    -- - Speed
    local minusBtn = Instance.new("TextButton")
    minusBtn.Text = "-"
    minusBtn.Size = UDim2.new(0.5, 0, 0, 30)
    minusBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    minusBtn.TextColor3 = Color3.new(1,1,1)
    minusBtn.Parent = Frame

    -- UP
    local upBtn = Instance.new("TextButton")
    upBtn.Text = "UP"
    upBtn.Size = UDim2.new(0.5, 0, 0, 30)
    upBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    upBtn.TextColor3 = Color3.new(1,1,1)
    upBtn.Parent = Frame

    -- DOWN
    local downBtn = Instance.new("TextButton")
    downBtn.Text = "DOWN"
    downBtn.Size = UDim2.new(0.5, 0, 0, 30)
    downBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    downBtn.TextColor3 = Color3.new(1,1,1)
    downBtn.Parent = Frame

    -- Minimize
    local miniBtn = Instance.new("TextButton")
    miniBtn.Text = "–"
    miniBtn.Size = UDim2.new(0.5, 0, 0, 30)
    miniBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 0)
    miniBtn.TextColor3 = Color3.new(1,1,1)
    miniBtn.Parent = Frame

    -- Close
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0.5, 0, 0, 30)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Parent = Frame

    --------------------
    -- FLY FUNCTIONAL
    --------------------
    local vel = nil

    local function startFly()
        if not hrp then return end
        flying = true
        flyBtn.Text = "Fly: ON"

        vel = Instance.new("BodyVelocity")
        vel.Velocity = Vector3.zero
        vel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        vel.Parent = hrp

        while flying and vel.Parent do
            game:GetService("RunService").Heartbeat:Wait()
            if hrp then
                vel.Velocity = hrp.CFrame.LookVector * flySpeed
            end
        end
    end

    local function stopFly()
        flying = false
        flyBtn.Text = "Fly: OFF"
        if vel then vel:Destroy() end
    end

    --------------------
    -- BUTTON LOGIC
    --------------------
    flyBtn.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
        else
            startFly()
        end
    end)

    plusBtn.MouseButton1Click:Connect(function()
        flySpeed = flySpeed + 5
        speedLabel.Text = "Speed: " .. flySpeed
    end)

    minusBtn.MouseButton1Click:Connect(function()
        flySpeed = math.max(5, flySpeed - 5)
        speedLabel.Text = "Speed: " .. flySpeed
    end)

    upBtn.MouseButton1Click:Connect(function()
        if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0,5,0) end
    end)

    downBtn.MouseButton1Click:Connect(function()
        if hrp then hrp.CFrame = hrp.CFrame - Vector3.new(0,5,0) end
    end)

    miniBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        for _,child in ipairs(Frame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                if child ~= miniBtn then
                    child.Visible = not minimized
                end
            end
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        stopFly()
        ScreenGui.Enabled = false
    end)

    --------------------
    -- RAYFIELD INTEGRATION
    --------------------
    local ExtraTab = Window:CreateTab("Extra Tools", 4483362458)

    ExtraTab:CreateToggle({
        Name = "Fly GUI",
        CurrentValue = false,
        Callback = function(Value)
            ScreenGui.Enabled = Value
        end
    })
end
