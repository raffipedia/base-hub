-- Fly.lua
return function(Window)
    local ExtraTab = Window:CreateTab("Extra Tools", 4483362458)
    local flyGui = nil
    local flyEnabled = false
    local flySpeed = 50

    local function createFlyGui()
        local sg = Instance.new("ScreenGui")
        sg.Name = "FlyGUI"
        sg.ResetOnSpawn = false
        sg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame", sg)
        frame.Size = UDim2.new(0, 200, 0, 120)
        frame.Position = UDim2.new(0.7, 0, 0.5, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        frame.Active = true
        frame.Draggable = true

        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1, 0, 0, 25)
        title.BackgroundColor3 = Color3.fromRGB(50,50,50)
        title.Text = "Fly Control"
        title.TextColor3 = Color3.fromRGB(255,255,255)

        local speedLabel = Instance.new("TextLabel", frame)
        speedLabel.Size = UDim2.new(1, 0, 0, 25)
        speedLabel.Position = UDim2.new(0,0,0.3,0)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "Speed: "..flySpeed
        speedLabel.TextColor3 = Color3.fromRGB(255,255,255)

        local upButton = Instance.new("TextButton", frame)
        upButton.Size = UDim2.new(0.5, -5, 0, 25)
        upButton.Position = UDim2.new(0, 5, 0.6, 0)
        upButton.Text = "+"
        upButton.MouseButton1Click:Connect(function()
            flySpeed = math.clamp(flySpeed + 5, 1, 100)
            speedLabel.Text = "Speed: "..flySpeed
        end)

        local downButton = Instance.new("TextButton", frame)
        downButton.Size = UDim2.new(0.5, -5, 0, 25)
        downButton.Position = UDim2.new(0.5, 0, 0.6, 0)
        downButton.Text = "-"
        downButton.MouseButton1Click:Connect(function()
            flySpeed = math.clamp(flySpeed - 5, 1, 100)
            speedLabel.Text = "Speed: "..flySpeed
        end)

        flyGui = sg
    end

    local function destroyFlyGui()
        if flyGui then
            flyGui:Destroy()
            flyGui = nil
        end
    end

    -- Switch di ExtraTools
    ExtraTab:CreateToggle({
        Name = "Fly",
        CurrentValue = false,
        Callback = function(state)
            if state then
                flyEnabled = true
                createFlyGui()
            else
                flyEnabled = false
                destroyFlyGui()
            end
        end,
    })
end
