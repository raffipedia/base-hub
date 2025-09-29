local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vip Script: Ryuu Hub",
    LoadingTitle = "Tunggu Ya Ganteng/Cantik Lagi Loading.",
    LoadingSubtitle = "By Ryuu",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
       Title = "Key System",
       Subtitle = "Masukan Key",
       Note = "Mau Key?\ndm ig: @raffiardnsyhh",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"RyuuSeii"}
    }
})

-- INFO TAB
local InfoTab = Window:CreateTab("Tutorial", 4483362458)

InfoTab:CreateSection("Cara Penggunaan Script")

InfoTab:CreateParagraph({
    Title = "Panduan Penggunaan",
    Content = "1.buka tab gunung yang ingin digunakan\n2.Aktifkan fitur teleport sesuai kebutuhan\n3.Atur delay teleport sesuai kecepatan yang diinginkan\n4.Gunakan fitur tambahan seperti auto-kill untuk efisiensi\n\nTips: Gunakan private server untuk menghindari deteksi anti-cheat"
})

InfoTab:CreateParagraph({
    Title = "Fitur Utama",
    Content = "-Auto Teleport (Sekali): Teleport otomatis melalui semua checkpoint sekali\n-Auto Teleport (Looping): Teleport berulang melalui semua checkpoint\n-Auto Kill: Karakter mati otomatis saat mencapai puncak\n-Auto Return: Kembali ke spawn otomatis (khusus Mt.Akhirat)\n-Auto Rejoin: Berganti server otomatis setelah mencapai puncak"
})

InfoTab:CreateParagraph({
    Title = "Pengaturan Delay",
    Content = "Setiap gunung memiliki pengaturan delay yang dapat disesuaikan. Delay rendah (1-5 detik) lebih cepat tapi berisiko terdeteksi. Delay tinggi (16-30 detik) lebih aman tapi lebih lambat. Disarankan menggunakan delay 5-15."
})

InfoTab:CreateParagraph({
    Title = "Pengaturan Keamanan",
    Content = "Jangan gunakan script secara berlebihan. Hindari teleport terlalu cepat antar chekpoint.  Disarankan menggunakan private server. Gunakan delay yang wajar (minimal 5 detik) dan beri jeda antara sesi farming."
})

-- ==========================================
-- LAYAR KOORDINAT
-- ==========================================
local KoordinatParagraph = InfoTab:CreateParagraph({
    Title = "Posisi Karakter",
    Content = "X: 0 | Y: 0 | Z: 0"
})

task.spawn(function()
    while task.wait(1) do
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            KoordinatParagraph:Set({
                Title = "Posisi Karakter",
                Content = string.format("X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
            })
        end
    end
end)

-- ==========================================
-- WAKTU PUSH SUMMIT
-- ==========================================
InfoTab:CreateSection("Waktu Push Summit Terbaik")

InfoTab:CreateLabel("Push summit lebih baik di jam 19:00 - 22:00 atau 00:30 - 05:00")
InfoTab:CreateLabel("Server lebih sepi pada malam hari")
InfoTab:CreateLabel("Gunakan Private Server jika memungkinkan")
InfoTab:CreateLabel("Jika tidak ada private server, cari server yang sepi")

-- EXTRA TAB
local ExtraTab = Window:CreateTab("Extra Tools", 4483362458)

-- WalkSpeed Slider
ExtraTab:CreateSection("Atur Kecepatan Lari")

ExtraTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {1, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

-- JumpHeight Slider
ExtraTab:CreateSection("Atur Loncatan")

ExtraTab:CreateSlider({
    Name = "Jump Height",
    Range = {10, 500},
    Increment = 1,
    Suffix = "Height",
    CurrentValue = 50,
    Flag = "Slider2",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.UseJumpPower = true -- wajib aktifin ini dulu
            humanoid.JumpPower = Value   -- baru bisa diatur
        end
    end,
})
