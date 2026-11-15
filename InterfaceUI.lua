-- InterfaceUI.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function CreateKaitunUI()
    pcall(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local existingGui = playerGui:FindFirstChild("KaitunEliteUI")
        if existingGui then
            existingGui:Destroy()
        end

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "KaitunEliteUI"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = playerGui

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 450, 0, 340)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -170)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        MainFrame.BorderSizePixel = 0
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local RainbowStroke = Instance.new("UIStroke")
        RainbowStroke.Thickness = 3
        RainbowStroke.Parent = MainFrame

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Name = "TitleLabel"
        TitleLabel.Size = UDim2.new(1, 0, 0, 35)
        TitleLabel.BackgroundTransparency = 0.3
        TitleLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextScaled = true
        TitleLabel.Font = Enum.Font.SourceSansBold
        TitleLabel.Text = "BLOX FRUITS ELITE KAITUN - ULTRA"
        TitleLabel.Parent = MainFrame

        local StatsLabel = Instance.new("TextLabel")
        StatsLabel.Name = "StatsLabel"
        StatsLabel.Size = UDim2.new(0, 150, 0, 25)
        StatsLabel.Position = UDim2.new(1, -155, 0, 40)
        StatsLabel.BackgroundTransparency = 1
        StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        StatsLabel.TextSize = 14
        StatsLabel.Font = Enum.Font.Code
        StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
        StatsLabel.Text = "FPS: 60 | Ping: 0ms"
        StatsLabel.Parent = MainFrame

        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Name = "StatusLabel"
        StatusLabel.Size = UDim2.new(1, -20, 0, 30)
        StatusLabel.Position = UDim2.new(0, 10, 0, 45)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        StatusLabel.TextScaled = true
        StatusLabel.Font = Enum.Font.SourceSans
        StatusLabel.Text = "Status: Fully Optimized & Running..."
        StatusLabel.Parent = MainFrame

        local ImageContainer = Instance.new("ImageLabel")
        ImageContainer.Name = "ImageContainer"
        ImageContainer.Size = UDim2.new(0, 200, 0, 110)
        ImageContainer.Position = UDim2.new(0.5, -100, 0, 80)
        ImageContainer.BackgroundTransparency = 1
        ImageContainer.Image = "rbxassetid://18684738556"
        ImageContainer.ScaleType = Enum.ScaleType.Fit
        ImageContainer.Parent = MainFrame

        local TikTokLabel = Instance.new("TextLabel")
        TikTokLabel.Name = "TikTokLabel"
        TikTokLabel.Size = UDim2.new(1, 0, 0, 30)
        TikTokLabel.Position = UDim2.new(0, 0, 1, -35)
        TikTokLabel.BackgroundTransparency = 1
        TikTokLabel.TextScaled = true
        TikTokLabel.Font = Enum.Font.SourceSansBold
        TikTokLabel.Text = "Tiktok @ Hoàng Sắc Thiểm Quang"
        TikTokLabel.Parent = MainFrame

        local lastUpdate = 0
        local frameCount = 0
        RunService.RenderStepped:Connect(function(dt)
            frameCount = frameCount + 1
            local currentTime = tick()
            if currentTime - lastUpdate >= 1 then
                local fps = math.floor(frameCount / (currentTime - lastUpdate))
                local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                StatsLabel.Text = string.format("FPS: %d | Ping: %dms", fps, ping)
                frameCount = 0
                lastUpdate = currentTime
            end

            local hue = (tick() % 5) / 5
            local rainbowColor = Color3.fromHSV(hue, 1, 1)
            RainbowStroke.Color = rainbowColor
            TikTokLabel.TextColor3 = rainbowColor
        end)
    end)
end

return CreateKaitunUI
