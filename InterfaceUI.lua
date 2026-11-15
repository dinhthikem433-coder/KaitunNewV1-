return function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    if playerGui:FindFirstChild("KaitunEliteUI") then
        playerGui.KaitunEliteUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", playerGui)
    ScreenGui.Name = "KaitunEliteUI"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -200, 1, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BackgroundTransparency = 0.45 
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 10)

    local RainbowStroke = Instance.new("UIStroke", MainFrame)
    RainbowStroke.Thickness = 2.5

    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Size = UDim2.new(1, 0, 0, 35)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = "ThanhEzHub -Blox King"

    local dragging, dragInput, dragStart, startPos
    TitleLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TitleLabel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local StatsLabel = Instance.new("TextLabel", MainFrame)
    StatsLabel.Size = UDim2.new(0, 140, 0, 22)
    StatsLabel.Position = UDim2.new(1, -145, 0, 38)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    StatsLabel.TextSize = 13
    StatsLabel.Font = Enum.Font.Code
    StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
    StatsLabel.Text = "FPS: 60 | Ping: 0ms"

    local StatusLabel = Instance.new("TextLabel", MainFrame)
    StatusLabel.Size = UDim2.new(1, -20, 0, 22)
    StatusLabel.Position = UDim2.new(0, 10, 0, 38)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    StatusLabel.TextScaled = true
    StatusLabel.Font = Enum.Font.SourceSans
    StatusLabel.Text = "Status: Initializing..."

    --
    local LoadBarBg = Instance.new("Frame", MainFrame)
    LoadBarBg.Size = UDim2.new(1, -20, 0, 5)
    LoadBarBg.Position = UDim2.new(0, 10, 0, 65)
    LoadBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    LoadBarBg.BackgroundTransparency = 0.5
    LoadBarBg.BorderSizePixel = 0
    Instance.new("UICorner", LoadBarBg).CornerRadius = UDim.new(1, 0)

    local LoadBarFill = Instance.new("Frame", LoadBarBg)
    LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
    LoadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    LoadBarFill.BorderSizePixel = 0
    Instance.new("UICorner", LoadBarFill).CornerRadius = UDim.new(1, 0)

    -- 
    task.spawn(function()
        for i = 1, 15 do
            local particle = Instance.new("Frame", MainFrame)
            particle.Size = UDim2.new(0, math.random(4, 7), 0, math.random(4, 7))
            particle.Position = UDim2.new(0.5, 0, 0.7, 0)
            particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
            particle.BackgroundTransparency = 0.2
            particle.BorderSizePixel = 0
            Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
            
            local targetPos = UDim2.new(math.random(10, 380)/400, 0, math.random(10, 200)/300, 0)
            TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = targetPos,
                BackgroundTransparency = 1
            }):Play()
            task.delay(0.8, function() particle:Destroy() end)
        end
    end)

    TweenService:Create(LoadBarFill, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 1, 0)}):Play()

    -- 
    local ImageContainer = Instance.new("ImageLabel", MainFrame)
    ImageContainer.Size = UDim2.new(0, 220, 0, 120)
    ImageContainer.Position = UDim2.new(0.5, -110, 0, 80)
    ImageContainer.BackgroundTransparency = 1
    ImageContainer.Image = "rbxassetid://18684738556[span_0](start_span)"[span_0](end_span)
    ImageContainer.ScaleType = Enum.ScaleType.Fit

    -- 
    local TikTokLabel = Instance.new("TextLabel", ImageContainer)
    TikTokLabel.Size = UDim2.new(1, 0, 0, 30)
    TikTokLabel.Position = UDim2.new(0, 0, 1, -25)
    TikTokLabel.BackgroundTransparency = 1
    TikTokLabel.TextScaled = true
    TikTokLabel.Font = Enum.Font.SourceSansBold
    TikTokLabel.Text = "Tiktok @ Hoàng Sắc Thiểm Quang"

    task.delay(1.3, function()
        StatusLabel.Text = "Status: Running Smoothly..."
    end)

    local fc, lastT = 0, tick()
    RunService.RenderStepped:Connect(function()
        fc = fc + 1
        if tick() - lastT >= 1 then
            StatsLabel.Text = string.format("FPS: %d | Ping: %dms", math.floor(fc / (tick() - lastT)), math.floor(LocalPlayer:GetNetworkPing() * 1000))
            fc, lastT = 0, tick()
        end
        RainbowStroke.Color = Color3.fromHSV((tick() % 5) / 5, 1, 1)
        TikTokLabel.TextColor3 = RainbowStroke.Color
    end)
end
