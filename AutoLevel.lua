-- AutoLevel.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_", 999)
local AttackRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Validator", 10)

local AllSeasLevelZones = {
    {Min = 1, Max = 10, Mob = "Bandit", Quest = "BanditQuest1", CFrame = CFrame.new(1062, 16, 1547)},
    {Min = 10, Max = 30, Mob = "Monkey", Quest = "JungleQuest", CFrame = CFrame.new(-1599, 36, 153)},
    {Min = 30, Max = 60, Mob = "Gorilla", Quest = "JungleQuest", CFrame = CFrame.new(-1242, 6, -502)},
    {Min = 60, Max = 90, Mob = "Pirate", Quest = "PirateQuest", CFrame = CFrame.new(-1163, 4, 3828)},
    {Min = 90, Max = 120, Mob = "Brute", Quest = "PirateQuest", CFrame = CFrame.new(-1140, 14, 4314)},
    {Min = 120, Max = 150, Mob = "Desert Bandit", Quest = "DesertQuest", CFrame = CFrame.new(903, 7, 4355)},
    {Min = 150, Max = 175, Mob = "Desert Officer", Quest = "DesertQuest", CFrame = CFrame.new(1573, 9, 4380)},
    {Min = 175, Max = 190, Mob = "Snow Bandit", Quest = "SnowQuest", CFrame = CFrame.new(1274, 106, -1327)},
    {Min = 190, Max = 210, Mob = "Snowman", Quest = "SnowQuest", CFrame = CFrame.new(1348, 145, -1571)},
    {Min = 210, Max = 250, Mob = "Chief Petty Officer", Quest = "MarineQuest", CFrame = CFrame.new(-4815, 21, 4362)},
    {Min = 250, Max = 300, Mob = "Sky Bandit", Quest = "SkyQuest", CFrame = CFrame.new(-4981, 717, -2622)},
    {Min = 300, Max = 325, Mob = "Toga Warrior", Quest = "ColosseumQuest", CFrame = CFrame.new(-1580, 11, 513)},
    {Min = 325, Max = 375, Mob = "Gladiator", Quest = "ColosseumQuest", CFrame = CFrame.new(-1432, 51, -290)},
    {Min = 375, Max = 400, Mob = "Military Soldier", Quest = "MagmaQuest", CFrame = CFrame.new(-5411, 16, 8477)},
    {Min = 400, Max = 450, Mob = "Military Spy", Quest = "MagmaQuest", CFrame = CFrame.new(-5801, 16, 8820)},
    {Min = 450, Max = 525, Mob = "Fishman Warrior", Quest = "FishmanQuest", CFrame = CFrame.new(6112, 18, 1549)},
    {Min = 525, Max = 625, Mob = "Warden", Quest = "PrisonQuest", CFrame = CFrame.new(5131, 4, 716)},
    {Min = 625, Max = 700, Mob = "Galley Pirate", Quest = "FountainQuest", CFrame = CFrame.new(5513, 61, 6088)},
    {Min = 700, Max = 725, Mob = "Raider", Quest = "Area1Quest", CFrame = CFrame.new(-424, 73, 1837)},
    {Min = 725, Max = 750, Mob = "Mercenary", Quest = "Area1Quest", CFrame = CFrame.new(-861, 73, 1400)},
    {Min = 750, Max = 775, Mob = "Swan Pirate", Quest = "Area2Quest", CFrame = CFrame.new(878, 122, 1235)},
    {Min = 775, Max = 800, Mob = "Factory Staff", Quest = "Area2Quest", CFrame = CFrame.new(290, 73, -54)},
    {Min = 800, Max = 875, Mob = "Marine Lieutenant", Quest = "MarineQuest3", CFrame = CFrame.new(-2441, 73, -3215)},
    {Min = 875, Max = 950, Mob = "Zombie", Quest = "ZombieQuest", CFrame = CFrame.new(-5489, 47, -795)},
    {Min = 950, Max = 1000, Mob = "Snow Trooper", Quest = "SnowMountainQuest", CFrame = CFrame.new(469, 402, -5388)},
    {Min = 1000, Max = 1050, Mob = "Winter Warrior", Quest = "SnowMountainQuest", CFrame = CFrame.new(5754, 402, -6261)},
    {Min = 1050, Max = 1100, Mob = "Lab Subordinate", Quest = "IceSideQuest", CFrame = CFrame.new(627, 431, 2697)},
    {Min = 1100, Max = 1125, Mob = "Horned Mole", Quest = "IceSideQuest", CFrame = CFrame.new(2292, 431, 3144)},
    {Min = 1125, Max = 1175, Mob = "Magma Ninja", Quest = "FireSideQuest", CFrame = CFrame.new(5398, 60, 8527)},
    {Min = 1175, Max = 1250, Mob = "Lava Pirate", Quest = "FireSideQuest", CFrame = CFrame.new(5075, 40, 6030)},
    {Min = 1250, Max = 1275, Mob = "Ship Deckhand", Quest = "ShipQuest1", CFrame = CFrame.new(1038, 125, 32742)},
    {Min = 1275, Max = 1350, Mob = "Ship Engineer", Quest = "ShipQuest1", CFrame = CFrame.new(919, 125, 33414)},
    {Min = 1350, Max = 1425, Mob = "Island Boy", Quest = "JungleQuest2", CFrame = CFrame.new(-532, 85, 8515)},
    {Min = 1425, Max = 1500, Mob = "Cocoa Warrior", Quest = "CocoaQuest", CFrame = CFrame.new(-221, 62, 1150)},
    {Min = 1500, Max = 1575, Mob = "Pirate Millionaire", Quest = "PortQuest1", CFrame = CFrame.new(-290, 43, 5580)},
    {Min = 1575, Max = 1625, Mob = "Pistol Billionaire", Quest = "PortQuest2", CFrame = CFrame.new(-472, 74, 5957)},
    {Min = 1625, Max = 1700, Mob = "Mythological Pirate", Quest = "HydraQuest1", CFrame = CFrame.new(5229, 104, 1251)},
    {Min = 1700, Max = 1750, Mob = "Musketeer Pirate", Quest = "HydraQuest2", CFrame = CFrame.new(5734, 121, 1214)},
    {Min = 1750, Max = 1800, Mob = "Jungle Pirate", Quest = "GreatTreeQuest1", CFrame = CFrame.new(2401, 72, -6801)},
    {Min = 1800, Max = 1900, Mob = "Musketeer Pirate", Quest = "GreatTreeQuest2", CFrame = CFrame.new(2900, 230, -7450)},
    {Min = 1900, Max = 1950, Mob = "Captain Elephant", Quest = "MarineQuest1", CFrame = CFrame.new(-3072, 15, -10145)},
    {Min = 1950, Max = 2000, Mob = "Commando", Quest = "MarineQuest2", CFrame = CFrame.new(-2450, 73, -10214)},
    {Min = 2000, Max = 2075, Mob = "Peanut Scout", Quest = "CandyQuest1", CFrame = CFrame.new(-2050, 45, -12300)},
    {Min = 2075, Max = 2150, Mob = "Peanut President", Quest = "CandyQuest2", CFrame = CFrame.new(-2200, 45, -12700)},
    {Min = 2150, Max = 2225, Mob = "Ice Cream Chef", Quest = "IceCreamQuest1", CFrame = CFrame.new(-820, 65, -10950)},
    {Min = 2225, Max = 2300, Mob = "Ice Cream Commander", Quest = "IceCreamQuest2", CFrame = CFrame.new(-1200, 65, -11150)},
    {Min = 2300, Max = 2400, Mob = "Cookie Crafter", Quest = "CakeQuest1", CFrame = CFrame.new(-2050, 50, -12100)},
    {Min = 2400, Max = 2550, Mob = "Baking Staff", Quest = "CakeQuest2", CFrame = CFrame.new(-1950, 50, -11800)},
    {Min = 2550, Max = 2700, Mob = "Candy Rebel", Quest = "TikiQuest1", CFrame = CFrame.new(-16500, 15, -15500)},
    {Min = 2700, Max = 2800, Mob = "Isle Outlaw", Quest = "TikiQuest2", CFrame = CFrame.new(-16800, 50, -17200)},
    {Min = 2800, Max = 9999, Mob = "Max Level Tiki / Treats", Quest = "MaxFarm", CFrame = CFrame.new(-16500, 50, -16500)}
}

local function SafeTweenTo(targetCFrame)
    local success = pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        if distance < 15 then
            hrp.CFrame = targetCFrame
            return
        end
        local speed = 300
        local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
        
        tween:Play()
        local completed = false
        local connection
        connection = tween.Completed:Connect(function()
            completed = true
            if connection then connection:Disconnect() end
        end)
        
        local startTime = tick()
        while not completed and tick() - startTime < (distance / speed) + 2 do
            if not char.Parent or hum.Health <= 0 then
                tween:Cancel()
                if connection then connection:Disconnect() end
                break
            end
            task.wait(0.1)
        end
    end)
    return success
end

local function AutoEquipOnce()
    pcall(function()
        local char = LocalPlayer.Character
        local backpack = LocalPlayer.Backpack
        if not char or not backpack then return end
        if not char:FindFirstChildOfClass("Tool") then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local toolTip = tool.ToolTip or ""
                    if toolTip == "Blox Fruit" or toolTip == "Melee" or toolTip == "Sword" or tool:FindFirstChild("RemoteFunction") then
                        char.Humanoid:EquipTool(tool)
                        break
                    end
                end
            end
        end
    end)
end

local isAttackRunning = false
local lastAttackTick = 0

local function FastAttackLoop()
    pcall(function()
        local vim = pcall(function() return game:GetService("VirtualInputManager") end) and game:GetService("VirtualInputManager") or nil
        task.spawn(function()
            while true do
                pcall(function()
                    AutoEquipOnce()
                    local enemiesFolder = workspace:FindFirstChild("Enemies")
                    if enemiesFolder then
                        for _, enemy in pairs(enemiesFolder:GetChildren()) do
                            local enemyHrp = enemy:FindFirstChild("HumanoidRootPart")
                            local enemyHum = enemy:FindFirstChild("Humanoid")
                            local char = LocalPlayer.Character
                            if enemyHrp and enemyHum and enemyHum.Health > 0 and char then
                                local hrp = char:FindFirstChild("HumanoidRootPart")
                                if hrp and (hrp.Position - enemyHrp.Position).Magnitude < 65 then
                                    if tick() - lastAttackTick >= 0.15 then
                                        lastAttackTick = tick()
                                        hrp.CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 3)
                                        if vim then
                                            pcall(function()
                                                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                            end)
                                        end
                                        if AttackRemote then
                                            pcall(function()
                                                AttackRemote:FireServer(enemyHrp.Position)
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end)
end

local lastQuestAttempt = 0

local function ExecuteLevelFarm(stateTable)
    pcall(function()
        local dataFolder = LocalPlayer:FindFirstChild("Data") or LocalPlayer:FindFirstChild("leaderstats")
        if not dataFolder then return end
        local levelVal = dataFolder:FindFirstChild("Level")
        if not levelVal or type(levelVal.Value) ~= "number" then return end
        
        local currentLevel = levelVal.Value

        if not isAttackRunning then
            isAttackRunning = true
            FastAttackLoop()
        end

        if currentLevel == 700 and CommF_ then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(-380, 23, 1883)
                task.wait(1)
                CommF_:InvokeServer("TravelDressrosa")
            end
            return
        elseif currentLevel == 1500 and CommF_ then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(-606, 15, 1352)
                task.wait(1)
                CommF_:InvokeServer("TravelZou")
            end
            return
        end

        local targetZone = nil
        for _, zone in ipairs(AllSeasLevelZones) do
            if currentLevel >= zone.Min and currentLevel < zone.Max then
                targetZone = zone
                break
            end
        end

        if targetZone then
            stateTable.CurrentTask = "Farming Level: " .. currentLevel
            SafeTweenTo(targetZone.CFrame)
            
            if CommF_ then
                local mainGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
                local questGui = mainGui and mainGui:FindFirstChild("Quest")
                if (not questGui or not questGui.Visible) and (tick() - lastQuestAttempt > 3) then
                    lastQuestAttempt = tick()
                    CommF_:InvokeServer("StartQuest", targetZone.Quest, 1)
                end
            end
        end
    end)
end

return {
    ExecuteLevelFarm = ExecuteLevelFarm
}
