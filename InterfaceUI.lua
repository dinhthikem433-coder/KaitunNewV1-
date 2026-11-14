-- [File: InterfaceUI.lua]
local InterfaceUI = {}
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

function InterfaceUI:Build()
    if CoreGui:FindFirstChild("ThanhEzKaitunV1") then
        CoreGui.ThanhEzKaitunV1:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ThanhEzKaitunV1"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 160)
    MainFrame.Position = UDim2.new(0.5, -160, 0.15, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2.5
    UIStroke.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 35)
    TitleLabel.Position = UDim2.new(0, 0, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "⚡ THANH EZ KAITUN ⚡"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 120, 0)
    TitleLabel.ZIndex = 10
    TitleLabel.Parent = MainFrame

    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(1, 0, 0, 20)
    SubTitle.Position = UDim2.new(0, 0, 0, 38)
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextSize = 12
    SubTitle.Font = Enum.Font.GothamMedium
    SubTitle.Text = "TikTok: @ Hoàng Sắc Thiểm Quang"
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.ZIndex = 10
    SubTitle.Parent = MainFrame

    local TopLayerTag = Instance.new("TextLabel")
    TopLayerTag.Size = UDim2.new(1, 0, 0, 20)
    TopLayerTag.Position = UDim2.new(0, 0, 0, 60)
    TopLayerTag.BackgroundTransparency = 1
    TopLayerTag.TextSize = 13
    TopLayerTag.Font = Enum.Font.GothamBold
    TopLayerTag.Text = "🔥 [ Kaitun ThEZ V1 ] Active 🔥"
    TopLayerTag.TextColor3 = Color3.fromRGB(0, 255, 200)
    TopLayerTag.ZIndex = 15
    TopLayerTag.Parent = MainFrame

    local FpsLabel = Instance.new("TextLabel")
    FpsLabel.Size = UDim2.new(0, 80, 0, 20)
    FpsLabel.Position = UDim2.new(1, -85, 0, 8)
    FpsLabel.BackgroundTransparency = 1
    FpsLabel.TextSize = 12
    FpsLabel.Font = Enum.Font.Code
    FpsLabel.Text = "FPS: 60"
    FpsLabel.ZIndex = 10
    FpsLabel.Parent = MainFrame

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, -20, 0, 35)
    StatusLabel.Position = UDim2.new(0, 10, 0, 110)
    StatusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    StatusLabel.TextSize = 11
    StatusLabel.Font = Enum.Font.Code
    StatusLabel.Text = "Status: Initializing Systems..."
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    StatusLabel.ZIndex = 10
    StatusLabel.Parent = MainFrame

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = StatusLabel

    -- Startup Particle Burst Effect
    task.spawn(function()
        for i = 1, 15 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
            particle.Position = UDim2.new(0.5, math.random(-120, 120), 0.8, 0)
            particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
            particle.BorderSizePixel = 0
            particle.ZIndex = 20
            particle.Parent = MainFrame
            
            Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
            
            local tw = game:GetService("TweenService"):Create(particle, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = particle.Position + UDim2.new(0, math.random(-40, 40), 0, math.random(-80, -40)),
                BackgroundTransparency = 1
            })
            tw:Play()
            game:GetService("Debris"):AddItem(particle, 1)
            task.wait(0.02)
        end
    end)

    -- Dynamic Rainbow, FPS Lock (60-50) & Optimization
    local frameCount = 0
    local lastTick = tick()

    RunService.RenderStepped:Connect(function()
        local hue = tick() % 4 / 4
        local rainbowColor = Color3.fromHSV(hue, 1, 1)
        UIStroke.Color = rainbowColor
        FpsLabel.TextColor3 = rainbowColor
        
        frameCount = frameCount + 1
        if tick() - lastTick >= 1 then
            FpsLabel.Text = "FPS: " .. tostring(frameCount)
            frameCount = 0
            lastTick = tick()
        end
        task.wait(0.016) -- Light frame pacing to stabilize 50-60 FPS
    end)

    return StatusLabel
end

return InterfaceUI
