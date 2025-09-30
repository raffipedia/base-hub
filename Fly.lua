return function(Window)
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local flying = false
    local flySpeed = 50
    local bv

    -- Ambil tab ExtraTools dari Window
    local ExtraTab = Window.Tabs["Extra Tools"] or Window:CreateTab("Extra Tools", 4483362458)
    ExtraTab:CreateSection("Fly Feature")

    -- Switch Fly GUI
    ExtraTab:CreateToggle({
        Name = "Fly GUI",
        CurrentValue = false,
        Callback = function(state)
            if state then
                -- GUI Frame
                local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
                ScreenGui.Name = "FlyGUI"

                local Frame = Instance.new("Frame", ScreenGui)
                Frame.Size = UDim2.new(0, 200, 0, 160)
                Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
                Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Frame.Active = true
                Frame.Draggable = true

                -- Tombol close & minimize
                local Close = Instance.new("TextButton", Frame)
                Close.Text = "X"
                Close.Size = UDim2.new(0, 30, 0, 30)
                Close.Position = UDim2.new(1, -35, 0, 5)

                local Minimize = Instance.new("TextButton", Frame)
                Minimize.Text = "-"
                Minimize.Size = UDim2.new(0, 30, 0, 30)
                Minimize.Position = UDim2.new(1, -70, 0, 5)

                -- Tombol Fly ON/OFF
                local FlyBtn = Instance.new("TextButton", Frame)
                FlyBtn.Text = "Fly OFF"
                FlyBtn.Size = UDim2.new(0, 180, 0, 30)
                FlyBtn.Position = UDim2.new(0, 10, 0, 40)

                -- Tombol Speed -
                local SpeedMinus = Instance.new("TextButton", Frame)
                SpeedMinus.Text = "-"
                SpeedMinus.Size = UDim2.new(0, 30, 0, 30)
                SpeedMinus.Position = UDim2.new(0, 10, 0, 80)

                -- Label Speed
                local SpeedLabel = Instance.new("TextLabel", Frame)
                SpeedLabel.Text = tostring(flySpeed)
                SpeedLabel.Size = UDim2.new(0, 80, 0, 30)
                SpeedLabel.Position = UDim2.new(0, 50, 0, 80)
                SpeedLabel.TextColor3 = Color3.new(1,1,1)
                SpeedLabel.BackgroundTransparency = 1

                -- Tombol Speed +
                local SpeedPlus = Instance.new("TextButton", Frame)
                SpeedPlus.Text = "+"
                SpeedPlus.Size = UDim2.new(0, 30, 0, 30)
                SpeedPlus.Position = UDim2.new(0, 140, 0, 80)

                -- Tombol UP
                local UpBtn = Instance.new("TextButton", Frame)
                UpBtn.Text = "UP"
                UpBtn.Size = UDim2.new(0, 60, 0, 30)
                UpBtn.Position = UDim2.new(0, 10, 0, 120)

                -- Tombol DOWN
                local DownBtn = Instance.new("TextButton", Frame)
                DownBtn.Text = "DOWN"
                DownBtn.Size = UDim2.new(0, 60, 0, 30)
                DownBtn.Position = UDim2.new(0, 80, 0, 120)

                -- Fungsi terbang
                local function startFly()
                    if not bv then
                        bv = Instance.new("BodyVelocity")
                        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                        bv.Velocity = Vector3.zero
                        bv.Parent = hrp

                        task.spawn(function()
                            while flying and bv do
                                local move = Vector3.zero
                                if UIS:IsKeyDown(Enum.KeyCode.W) then move += hrp.CFrame.LookVector end
                                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= hrp.CFrame.LookVector end
                                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= hrp.CFrame.RightVector end
                                if UIS:IsKeyDown(Enum.KeyCode.D) then move += hrp.CFrame.RightVector end

                                bv.Velocity = move * flySpeed
                                task.wait()
                            end
                        end)
                    end
                end

                local function stopFly()
                    if bv then bv:Destroy() bv = nil end
                end

                -- Tombol Fly toggle
                FlyBtn.MouseButton1Click:Connect(function()
                    flying = not flying
                    FlyBtn.Text = flying and "Fly ON" or "Fly OFF"
                    if flying then startFly() else stopFly() end
                end)

                -- Speed control
                SpeedPlus.MouseButton1Click:Connect(function()
                    flySpeed = math.clamp(flySpeed + 1, 1, 100)
                    SpeedLabel.Text = tostring(flySpeed)
                end)
                SpeedMinus.MouseButton1Click:Connect(function()
                    flySpeed = math.clamp(flySpeed - 1, 1, 100)
                    SpeedLabel.Text = tostring(flySpeed)
                end)

                -- Up / Down control
                UpBtn.MouseButton1Click:Connect(function()
                    if flying and hrp then
                        hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
                    end
                end)
                DownBtn.MouseButton1Click:Connect(function()
                    if flying and hrp then
                        hrp.CFrame = hrp.CFrame - Vector3.new(0, 5, 0)
                    end
                end)

                -- Close & Minimize
                Close.MouseButton1Click:Connect(function()
                    ScreenGui:Destroy()
                    flying = false
                    stopFly()
                end)
                Minimize.MouseButton1Click:Connect(function()
                    if Frame.Size.Y.Offset == 30 then
                        Frame.Size = UDim2.new(0, 200, 0, 160)
                    else
                        Frame.Size = UDim2.new(0, 200, 0, 30)
                    end
                end)
            else
                local gui = game.CoreGui:FindFirstChild("FlyGUI")
                if gui then gui:Destroy() end
            end
        end,
    })
end
