local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

return {
    Init = function()
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "ThanhHub Notification",
                Text = "Script Beta tác giả Thành 2k13🔥",
                Duration = 5
            })

            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            if PlayerGui:FindFirstChild("ThanhHubKaitunUI") then 
                PlayerGui.ThanhHubKaitunUI:Destroy() 
            end

            local ScreenGui = Instance.new("ScreenGui", PlayerGui)
            ScreenGui.Name = "ThanhHubKaitunUI"
            ScreenGui.ResetOnSpawn = false
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local LoadScreen = Instance.new("Frame", ScreenGui)
            LoadScreen.Size = UDim2.new(1, 0, 1, 0)
            LoadScreen.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
            LoadScreen.ZIndex = 10

            local LoadText = Instance.new("TextLabel", LoadScreen)
            LoadText.Size = UDim2.new(0, 400, 0, 80)
            LoadText.AnchorPoint = Vector2.new(0.5, 0.5)
            LoadText.Position = UDim2.new(0.5, 0, 0.45, 0)
            LoadText.BackgroundTransparency = 1
            LoadText.Text = "THANHHUB KAITUN LOADING... 0%"
            LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
            LoadText.TextScaled = true
            LoadText.Font = Enum.Font.FredokaOne
            LoadText.ZIndex = 11

            local LoadBarBg = Instance.new("Frame", LoadScreen)
            LoadBarBg.Size = UDim2.new(0, 400, 0, 16)
            LoadBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
            LoadBarBg.Position = UDim2.new(0.5, 0, 0.55, 0)
            LoadBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            LoadBarBg.BorderSizePixel = 0
            LoadBarBg.ZIndex = 11

            local LoadBarCorner = Instance.new("UICorner", LoadBarBg)
            LoadBarCorner.CornerRadius = UDim.new(1, 0)

            local LoadBarFill = Instance.new("Frame", LoadBarBg)
            LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
            LoadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
            LoadBarFill.BorderSizePixel = 0
            LoadBarFill.ZIndex = 12

            local FillCorner = Instance.new("UICorner", LoadBarFill)
            FillCorner.CornerRadius = UDim.new(1, 0)

            task.spawn(function()
                for i = 1, 100 do
                    LoadText.Text = "THANHHUB KAITUN LOADING... " .. i .. "%"
                    LoadBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
                    task.wait(0.02)
                end
                TweenService:Create(LoadScreen, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(LoadText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
                TweenService:Create(LoadBarBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(LoadBarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                task.wait(0.5)
                LoadScreen:Destroy()
            end)

            local MainFrame = Instance.new("Frame", ScreenGui)
            MainFrame.Size = UDim2.new(0, 380, 0, 210)
            MainFrame.Position = UDim2.new(0.03, 0, 0.1, 0)
            MainFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
            MainFrame.BorderSizePixel = 0
            MainFrame.ClipsDescendants = true

            local UICorner = Instance.new("UICorner", MainFrame)
            UICorner.CornerRadius = UDim.new(0, 14)

            local UIStroke = Instance.new("UIStroke", MainFrame)
            UIStroke.Thickness = 3.5

            local dragging, dragInput, dragStart, startPos
            MainFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = MainFrame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end)

            RunService.RenderStepped:Connect(function()
                if dragging and dragInput then
                    local delta = dragInput.Position - dragStart
                    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)

            local BgGradient = Instance.new("Frame", MainFrame)
            BgGradient.Size = UDim2.new(1, 0, 1, 0)
            BgGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BgGradient.BorderSizePixel = 0
            BgGradient.ZIndex = 1

            local UIGrad = Instance.new("UIGradient", BgGradient)
            UIGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 20, 20)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 10, 10))
            })
            UIGrad.Rotation = 45

            local Title = Instance.new("TextLabel", MainFrame)
            Title.Size = UDim2.new(1, -20, 0, 40)
            Title.Position = UDim2.new(0, 12, 0, 12)
            Title.BackgroundTransparency = 1
            Title.Text = "ThanhHub Kaitun Beta🔥"
            Title.TextScaled = true
            Title.Font = Enum.Font.FredokaOne
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.ZIndex = 3

            local SubTitle = Instance.new("TextLabel", MainFrame)
            SubTitle.Size = UDim2.new(1, -20, 0, 25)
            SubTitle.Position = UDim2.new(0, 12, 0, 50)
            SubTitle.BackgroundTransparency = 1
            SubTitle.Text = "TikTok @✨Hoàng Sắc Thiểm Quang✨"
            SubTitle.TextScaled = true
            SubTitle.Font = Enum.Font.GothamBold
            SubTitle.TextXAlignment = Enum.TextXAlignment.Left
            SubTitle.ZIndex = 3

            local Status = Instance.new("TextLabel", MainFrame)
            Status.Size = UDim2.new(1, -24, 0, 40)
            Status.Position = UDim2.new(0, 12, 0, 85)
            Status.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
            Status.BackgroundTransparency = 0.3
            Status.Text = "⚡ STATUS: FAST ATTACK ACTIVE"
            Status.TextColor3 = Color3.fromRGB(0, 255, 128)
            Status.TextScaled = true
            Status.Font = Enum.Font.GothamBold
            Status.ZIndex = 3

            local StatusCorner = Instance.new("UICorner", Status)
            StatusCorner.CornerRadius = UDim.new(0, 8)

            local BarBg = Instance.new("Frame", MainFrame)
            BarBg.Size = UDim2.new(1, -24, 0, 10)
            BarBg.Position = UDim2.new(0, 12, 0, 138)
            BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            BarBg.BorderSizePixel = 0
            BarBg.ZIndex = 3

            local BarBgCorner = Instance.new("UICorner", BarBg)
            BarBgCorner.CornerRadius = UDim.new(1, 0)

            local RainbowBar = Instance.new("Frame", BarBg)
            RainbowBar.Size = UDim2.new(0.75, 0, 1, 0)
            RainbowBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowBar.BorderSizePixel = 0
            RainbowBar.ZIndex = 4

            local BarCorner = Instance.new("UICorner", RainbowBar)
            BarCorner.CornerRadius = UDim.new(1, 0)

            local BarGrad = Instance.new("UIGradient", RainbowBar)
            BarGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))
            })

            local Footer = Instance.new("TextLabel", MainFrame)
            Footer.Size = UDim2.new(1, 0, 0, 25)
            Footer.Position = UDim2.new(0, 0, 0, 165)
            Footer.BackgroundTransparency = 1
            Footer.Text = "✨ THÀNH 2K13 | FPS: -- | Ping: --ms ✨"
            Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
            Footer.TextScaled = true
            Footer.Font = Enum.Font.GothamSemibold
            Footer.ZIndex = 3

            local lastUpdate = 0
            local frameCount = 0
            local currentFPS = 60

            RunService.RenderStepped:Connect(function(dt)
                frameCount = frameCount + 1
                if tick() - lastUpdate >= 1 then
                    currentFPS = math.floor(frameCount / (tick() - lastUpdate))
                    frameCount = 0
                    lastUpdate = tick()
                end
            end)

            task.spawn(function()
                local tickTime = 0
                while task.wait(0.5) do
                    tickTime = tickTime + 0.5
                    local hue = tickTime % 5 / 5
                    local rainbowColor = Color3.fromHSV(hue, 1, 1)
                    
                    UIStroke.Color = rainbowColor
                    Title.TextColor3 = rainbowColor
                    SubTitle.TextColor3 = Color3.fromHSV((hue + 0.3) % 1, 1, 1)
                    
                    local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                    local timeStr = os.date("%H:%M:%S")
                    Footer.Text = string.format("✨ THÀNH 2K13 | FPS: %d | Ping: %dms | %s ✨", currentFPS, ping, timeStr)
                    Footer.TextColor3 = Color3.fromHSV((hue + 0.6) % 1, 1, 1)
                    BarGrad.Rotation = (tickTime * 60) % 360
                end
            end)
        end)
    end
}
