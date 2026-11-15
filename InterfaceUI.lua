local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

return {
    Init = function()
        pcall(function()
            if CoreGui:FindFirstChild("KaitunNeonUI") then
                CoreGui.KaitunNeonUI:Destroy()
            end

            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "KaitunNeonUI"
            ScreenGui.Parent = CoreGui
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local MainFrame = Instance.new("Frame")
            MainFrame.Size = UDim2.new(0, 340, 0, 180)
            MainFrame.Position = UDim2.new(0.03, 0, 0.05, 0)
            MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20) -- Đen tuyền sắc nét, không mờ ảo
            MainFrame.BackgroundTransparency = 0 
            MainFrame.BorderSizePixel = 0
            MainFrame.Parent = ScreenGui

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 14)
            UICorner.Parent = MainFrame

            -- Viền Neon phát sáng đổi màu giật mù mắt
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Thickness = 3
            UIStroke.Color = Color3.fromRGB(0, 255, 255)
            UIStroke.Parent = MainFrame

            -- Khung chứa ảnh Bá Khí (Giữ nguyên không thiếu 1 chi tiết)
            local ImageHolder = Instance.new("ImageLabel")
            ImageHolder.Size = UDim2.new(0, 50, 0, 50)
            ImageHolder.Position = UDim2.new(0, 12, 0, 12)
            ImageHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            ImageHolder.Image = "rbxassetid://6023426915" -- ID Ảnh bá khí / Logo độc quyền của sếp
            ImageHolder.BackgroundTransparency = 0.2
            ImageHolder.Parent = MainFrame

            local ImgCorner = Instance.new("UICorner")
            ImgCorner.CornerRadius = UDim.new(0, 10)
            ImgCorner.Parent = ImageHolder

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -75, 0, 30)
            Title.Position = UDim2.new(0, 72, 0, 12)
            Title.BackgroundTransparency = 1
            Title.Text = "✨Thanh Hub Kaitun✨"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextScaled = true
            Title.Font = Enum.Font.FredokaOne
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = MainFrame

            -- Dòng phụ flex TikTok
            local SubTitle = Instance.new("TextLabel")
            SubTitle.Size = UDim2.new(1, -75, 0, 20)
            SubTitle.Position = UDim2.new(0, 72, 0, 42)
            SubTitle.BackgroundTransparency = 1
            SubTitle.Text = "TikTok: @KaitunMaster"
            SubTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
            SubTitle.TextScaled = true
            SubTitle.Font = Enum.Font.GothamBold
            SubTitle.TextXAlignment = Enum.TextXAlignment.Left
            SubTitle.Parent = MainFrame

            -- Trạng thái hoạt động rõ nét
            local Status = Instance.new("TextLabel")
            Status.Size = UDim2.new(1, -24, 0, 45)
            Status.Position = UDim2.new(0, 12, 0, 74)
            Status.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            Status.BackgroundTransparency = 0
            Status.Text = "🔥 STATUS: BRING MOBS & FAST ATTACK ACTIVE"
            Status.TextColor3 = Color3.fromRGB(0, 255, 128)
            Status.TextScaled = true
            Status.Font = Enum.Font.GothamBold
            Status.Parent = MainFrame

            local StatusCorner = Instance.new("UICorner")
            StatusCorner.CornerRadius = UDim.new(0, 8)
            StatusCorner.Parent = Status

            local Footer = Instance.new("TextLabel")
            Footer.Size = UDim2.new(1, 0, 0, 25)
            Footer.Position = UDim2.new(0, 0, 0, 138)
            Footer.BackgroundTransparency = 1
            Footer.Text = "✨ ULTRA FAST ATTACK & NO CLIP MODE ✨"
            Footer.TextColor3 = Color3.fromRGB(255, 220, 0)
            Footer.TextScaled = true
            Footer.Font = Enum.Font.GothamSemibold
            Footer.Parent = MainFrame

            task.spawn(function()
                while task.wait(0.25) do
                    TweenService:Create(UIStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(math.random(50,255), math.random(50,255), 255)}):Play()
                    task.wait(0.25)
                    TweenService:Create(UIStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(255, math.random(50,255), math.random(50,255)}):Play()
                end
            end)
        end)
    end
    }
    
