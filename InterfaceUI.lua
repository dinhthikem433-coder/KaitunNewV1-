local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
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

            local ParticleHolder = Instance.new("Frame", MainFrame)
            ParticleHolder.Size = UDim2.new(1, 0, 1, 0)
            ParticleHolder.BackgroundTransparency = 1
            ParticleHolder.ZIndex = 2

            for i = 1, 15 do
                local spark = Instance.new("Frame", ParticleHolder)
                spark.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
                spark.Position = UDim2.new(math.random(), 0, 1, 0)
                spark.BackgroundColor3 = Color3.fromRGB(255, math.random(150, 255), 0)
                spark.BorderSizePixel = 0
                local sCorner = Instance.new("UICorner", spark)
                sCorner.CornerRadius = UDim.new(1, 0)

                task.spawn(function()
                    while true do
                        local randomX = math.random()
                        spark.Position = UDim2.new(randomX, 0, 1.1, 0)
                        local tweenTime = math.random(15, 25) / 10
                        TweenService:Create(spark, TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Position = UDim2.new(randomX + (math.random(-20, 20)/100), 0, -0.2, 0),
                            BackgroundTransparency = 1
                        }):Play()
                        task.wait(tweenTime)
                        spark.BackgroundTransparency = 0
                    end
                end)
            end

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
            Status.Text = "⚡ STATUS: BRING MOBS & FAST ATTACK ACTIVE"
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
            Footer.Text = "✨ SCRIPT BY THÀNH 2K13 - MAX 2800 ✨"
            Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
            Footer.TextScaled = true
            Footer.Font = Enum.Font.GothamSemibold
            Footer.ZIndex = 3

            task.spawn(function()
                local tickTime = 0
                while task.wait(0.04) do
                    tickTime = tickTime + 0.04
                    local hue = tickTime % 5 / 5
                    local rainbowColor = Color3.fromHSV(hue, 1, 1)
                    
                    UIStroke.Color = rainbowColor
                    Title.TextColor3 = rainbowColor
                    SubTitle.TextColor3 = Color3.fromHSV((hue + 0.3) % 1, 1, 1)
                    Footer.TextColor3 = Color3.fromHSV((hue + 0.6) % 1, 1, 1)
                    BarGrad.Rotation = (tickTime * 60) % 360
                end
            end)
        end)
    end
}
