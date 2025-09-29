-- Mt-Atin.lua
-- File ini harus di-load dari VipHub.lua seperti:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/username/repo/main/Mt-Atin.lua"))()(Window)

return function(Window)
    local AtinTab = Window:CreateTab("Mt.Atin", 4483362458)

    AtinTab:CreateSection("Teleport Checkpoints")

    -- Teleport ke Base (spawn)
    AtinTab:CreateButton({
        Name = "Spawn",
        Callback = function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(16.5, 55.2, -1082.8)
            else
                Rayfield:Notify({Title = "Error", Content = "HumanoidRootPart tidak ditemukan.", Duration = 4})
            end
        end,
    })

    -- Teleport CP1
    AtinTab:CreateButton({
        Name = "Base >> Cp1",
        Callback = function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(4.3, 12.6, -406.2)
            else
                Rayfield:Notify({Title = "Error", Content = "HumanoidRootPart tidak ditemukan.", Duration = 4})
            end
        end,
    })

    -- Teleport CP2
    AtinTab:CreateButton({
        Name = "Cp1 >> Cp2",
        Callback = function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(-184.1, 128.1, 409.9)
            else
                Rayfield:Notify({Title = "Error", Content = "HumanoidRootPart tidak ditemukan.", Duration = 4})
            end
        end,
    })

    -- Teleport CP3
    AtinTab:CreateButton({
        Name = "Cp2 >> Cp3",
        Callback = function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(-165, 229.6, 652.9)
            else
                Rayfield:Notify({Title = "Error", Content = "HumanoidRootPart tidak ditemukan.", Duration = 4})
            end
        end,
    })

    -- Optional: tombol kembali ke Base (Auto Return)
    AtinTab:CreateButton({
        Name = "Kembali ke Base",
        Callback = function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(16.5, 55.2, -1082.8)
                Rayfield:Notify({Title = "Return", Content = "Dikembalikan ke Base.", Duration = 3})
            else
                Rayfield:Notify({Title = "Error", Content = "HumanoidRootPart tidak ditemukan.", Duration = 4})
            end
        end,
    })

    -- Catatan kecil di tab (optional)
    AtinTab:CreateLabel("Tips: Gunakan delay 5-15 detik antar teleport untuk mengurangi risiko anti-cheat.")
end
