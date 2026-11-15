local P, R, T = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
local L = P.LocalPlayer
local C = R:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

local function GlideTo(targetCf)
    pcall(function()
        local char = L.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if hrp and hum then
            hum.PlatformStand = true
            local distance = (hrp.Position - targetCf.Position).Magnitude
            if distance < 15 then 
                hrp.CFrame = targetCf 
                hum.PlatformStand = false
                return 
            end
            local speed = 320
            local tween = T:Create(hrp, TweenInfo.new(distance / speed, Enum.EasingStyle.Linear), {CFrame = targetCf + Vector3.new(0, 5, 0)})
            tween:Play()
            task.wait(distance / speed)
            hum.PlatformStand = false
        end
    end)
end

local Z = {
    {Min = 1, Max = 10, Q = "BanditQuest1", CF = CFrame.new(1062, 16, 1547)},
    {Min = 10, Max = 30, Q = "JungleQuest", CF = CFrame.new(-1599, 36, 153)},
    {Min = 30, Max = 60, Q = "JungleQuest", CF = CFrame.new(-1242, 6, -502)},
    {Min = 60, Max = 90, Q = "PirateQuest", CF = CFrame.new(-1163, 4, 3828)},
    {Min = 90, Max = 120, Q = "PirateQuest", CF = CFrame.new(-1140, 14, 4314)},
    {Min = 120, Max = 150, Q = "DesertQuest", CF = CFrame.new(903, 7, 4355)},
    {Min = 150, Max = 175, Q = "DesertQuest", CF = CFrame.new(1573, 9, 4380)},
    {Min = 175, Max = 190, Q = "SnowQuest", CF = CFrame.new(1274, 106, -1327)},
    {Min = 190, Max = 210, Q = "SnowQuest", CF = CFrame.new(1348, 145, -1571)},
    {Min = 210, Max = 250, Q = "MarineQuest", CF = CFrame.new(-4815, 21, 4362)},
    {Min = 250, Max = 300, Q = "SkyQuest", CF = CFrame.new(-4981, 717, -2622)},
    {Min = 300, Max = 325, Q = "ColosseumQuest", CF = CFrame.new(-1580, 11, 513)},
    {Min = 325, Max = 375, Q = "ColosseumQuest", CF = CFrame.new(-1432, 51, -290)},
    {Min = 375, Max = 400, Q = "MagmaQuest", CF = CFrame.new(-5411, 16, 8477)},
    {Min = 400, Max = 450, Q = "MagmaQuest", CF = CFrame.new(-5801, 16, 8820)},
    {Min = 450, Max = 525, Q = "FishmanQuest", CF = CFrame.new(6112, 18, 1549)},
    {Min = 525, Max = 625, Q = "PrisonQuest", CF = CFrame.new(5131, 4, 716)},
    {Min = 625, Max = 700, Q = "FountainQuest", CF = CFrame.new(5513, 61, 6088)},
    {Min = 700, Max = 725, Q = "Area1Quest", CF = CFrame.new(-424, 73, 1837)},
    {Min = 725, Max = 750, Q = "Area1Quest", CF = CFrame.new(-861, 73, 1400)},
    {Min = 750, Max = 775, Q = "Area2Quest", CF = CFrame.new(878, 122, 1235)},
    {Min = 775, Max = 800, Q = "Area2Quest", CF = CFrame.new(290, 73, -54)},
    {Min = 800, Max = 875, Q = "MarineQuest3", CF = CFrame.new(-2441, 73, -3215)},
    {Min = 875, Max = 950, Q = "ZombieQuest", CF = CFrame.new(-5489, 47, -795)},
    {Min = 950, Max = 1000, Q = "SnowMountainQuest", CF = CFrame.new(469, 402, -5388)},
    {Min = 1000, Max = 1050, Q = "SnowMountainQuest", CF = CFrame.new(5754, 402, -6261)},
    {Min = 1050, Max = 1100, Q = "IceSideQuest", CF = CFrame.new(627, 431, 2697)},
    {Min = 1100, Max = 1125, Q = "IceSideQuest", CF = CFrame.new(2292, 431, 3144)},
    {Min = 1125, Max = 1175, Q = "FireSideQuest", CF = CFrame.new(5398, 60, 8527)},
    {Min = 1175, Max = 1250, Q = "FireSideQuest", CF = CFrame.new(5075, 40, 6030)},
    {Min = 1250, Max = 1275, Q = "ShipQuest1", CF = CFrame.new(1038, 125, 32742)},
    {Min = 1275, Max = 1350, Q = "ShipQuest1", CF = CFrame.new(919, 125, 33414)},
    {Min = 1350, Max = 1425, Q = "JungleQuest2", CF = CFrame.new(-532, 85, 8515)},
    {Min = 1425, Max = 1500, Q = "CocoaQuest", CF = CFrame.new(-221, 62, 1150)},
    {Min = 1500, Max = 1575, Q = "PortQuest1", CF = CFrame.new(-290, 43, 5580)},
    {Min = 1575, Max = 1625, Q = "PortQuest2", CF = CFrame.new(-472, 74, 5957)},
    {Min = 1625, Max = 1700, Q = "HydraQuest1", CF = CFrame.new(5229, 104, 1251)},
    {Min = 1700, Max = 1750, Q = "HydraQuest2", CF = CFrame.new(5734, 121, 1214)},
    {Min = 1750, Max = 1800, Q = "GreatTreeQuest1", CF = CFrame.new(2401, 72, -6801)},
    {Min = 1800, Max = 1900, Q = "GreatTreeQuest2", CF = CFrame.new(2900, 230, -7450)},
    {Min = 1900, Max = 1950, Q = "MarineQuest1", CF = CFrame.new(-3072, 15, -10145)},
    {Min = 1950, Max = 2000, Q = "MarineQuest2", CF = CFrame.new(-2450, 73, -10214)},
    {Min = 2000, Max = 2075, Q = "CandyQuest1", CF = CFrame.new(-2050, 45, -12300)},
    {Min = 2075, Max = 2150, Q = "CandyQuest2", CF = CFrame.new(-2200, 45, -12700)},
    {Min = 2150, Max = 2225, Q = "IceCreamQuest1", CF = CFrame.new(-820, 65, -10950)},
    {Min = 2225, Max = 2300, Q = "IceCreamQuest2", CF = CFrame.new(-1200, 65, -11150)},
    {Min = 2300, Max = 2400, Q = "CakeQuest1", CF = CFrame.new(-2050, 50, -12100)},
    {Min = 2400, Max = 2550, Q = "CakeQuest2", CF = CFrame.new(-1950, 50, -11800)},
    {Min = 2550, Max = 2700, Q = "TikiQuest1", CF = CFrame.new(-16500, 15, -15500)},
    {Min = 2700, Max = 2800, Q = "TikiQuest2", CF = CFrame.new(-16800, 50, -17200)},
    {Min = 2800, Max = 9999, Q = "MaxFarm", CF = CFrame.new(-16500, 50, -16500)}
}

return {
    Run = function()
        task.spawn(function()
            local lQ = 0
            while task.wait(0.2) do
                pcall(function()
                    local dt = L:FindFirstChild("Data") or L:FindFirstChild("leaderstats")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1
                    if lv == 700 then GlideTo(CFrame.new(-380, 23, 1883)) C:InvokeServer("TravelDressrosa") return end
                    if lv == 1500 then GlideTo(CFrame.new(-606, 15, 1352)) C:InvokeServer("TravelZou") return end
                    for _, z in ipairs(Z) do
                        if lv >= z.Min and lv < z.Max then
                            GlideTo(z.CF)
                            local qg = L.PlayerGui:FindFirstChild("Main")
                            qg = qg and qg:FindFirstChild("Quest")
                            if (not qg or not qg.Visible) and (tick() - lQ > 2) then
                                lQ = tick()
                                C:InvokeServer("StartQuest", z.Q, 1)
                            end
                            break
                        end
                    end
                end)
            end
        end)
    end
}
