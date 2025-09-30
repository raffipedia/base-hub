-- Tambahan di dalam VipHub.lua
local ExtraTab = Window:CreateTab("Extra Tools", 4483362458)

-- Variabel Fly
local flying = false
local speed = 50 -- default
local flyConnection

-- Switch On/Off Fly
ExtraTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Callback = function(state)
        flying = state
        if flying then
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            -- Mulai loop gerakan fly
            flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                local moveDir = Vector3.zero
                local uis = game:GetService("UserInputService")

                if uis:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + (workspace.CurrentCamera.CFrame.LookVector)
                end
                if uis:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - (workspace.CurrentCamera.CFrame.LookVector)
                end
                if uis:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - (workspace.CurrentCamera.CFrame.RightVector)
                end
                if uis:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + (workspace.CurrentCamera.CFrame.RightVector)
                end
                if uis:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0,1,0)
                end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0,1,0)
                end

                if hrp then
                    hrp.Velocity = moveDir.Unit * speed
                end
            end)
        else
            -- Matikan fly
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.zero
            end
        end
    end,
})

-- Slider Speed 1-100
ExtraTab:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(value)
        speed = value
    end,
})
