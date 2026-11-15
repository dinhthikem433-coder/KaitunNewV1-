local P, R, W = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("Workspace")
local TP = game:GetService("TeleportService")
local TS = game:GetService("TweenService")
local L = P.LocalPlayer
local C = R:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

local function SafeCall(...)
    local success, err = pcall(C.InvokeServer, C, ...)
    return success and err
end

local function Hop()
    pcall(function()
        local s = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        if s and s.data then
            for _, v in ipairs(s.data) do
                if type(v) == "table" and v.playing and v.maxPlayers and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TP:TeleportToPlaceInstance(game.PlaceId, v.id, L)
                    break
                end
            end
        end
    end)
end

local function GetChar()
    return L.Character or L.CharacterAdded:Wait()
end

local function GetRoot(ch)
    return ch:FindFirstChild("HumanoidRootPart") or ch:WaitForChild("HumanoidRootPart", 5)
end

local function SmartFly(targetCFrame)
    local ch = GetChar()
    local root = GetRoot(ch)
    local hum = ch:FindFirstChild("Humanoid")
    if not root or not hum then return end

    local bv = root:FindFirstChild("KaitunFlightBV")
    local bg = root:FindFirstChild("KaitunFlightBG")

    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "KaitunFlightBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.zero
        bv.Parent = root
    end

    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "KaitunFlightBG"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = root.CFrame
        bg.Parent = root
    end

    hum.PlatformStand = true
    local dist = (root.Position - targetCFrame.Position).Magnitude
    local speed = 350
    local timeDist = dist / speed

    local info = TweenInfo.new(timeDist, Enum.EasingStyle.Linear)
    local tween = TS:Create(root, info, {CFrame = targetCFrame})
    tween:Play()
end

local function StopFly()
    local ch = GetChar()
    local root = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChild("Humanoid")
    if root then
        local bv = root:FindFirstChild("KaitunFlightBV")
        local bg = root:FindFirstChild("KaitunFlightBG")
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
    if hum then hum.PlatformStand = false end
end

local function BringMobs(rootPos, mobName)
    local enemies = W:FindFirstChild("Enemies")
    if not enemies then return end
    for _, mob in ipairs(enemies:GetChildren()) do
        local mRoot = mob:FindFirstChild("HumanoidRootPart")
        local mHum = mob:FindFirstChild("Humanoid")
        if mRoot and mHum and mHum.Health > 0 and mob.Name == mobName then
            if (mRoot.Position - rootPos).Magnitude <= 350 then
                mRoot.CFrame = CFrame.new(rootPos + Vector3.new(0, 5, 0))
                mHum.WalkSpeed = 0
                mHum.JumpPower = 0
                if mob:FindFirstChild("Head") then
                    sethiddenproperty(L, "SimulationRadius", math.huge)
                end
            end
        end
    end
end

local QuestsList = {
    {min = 1, max = 10, mob = "Bandit [Level 5]", questName = "BanditQuest1", levelIndex = 1, npcPos = CFrame.new(1061, 16, 1546)},
    {min = 10, max = 15, mob = "Monkey [Level 14]", questName = "JungleQuest", levelIndex = 1, npcPos = CFrame.new(-1598, 36, 153)},
    {min = 15, max = 30, mob = "Gorilla [Level 20]", questName = "JungleQuest", levelIndex = 2, npcPos = CFrame.new(-1598, 36, 153)},
    {min = 30, max = 40, mob = "Pirate [Level 35]", questName = "BuggyQuest1", levelIndex = 1, npcPos = CFrame.new(-1140, 4, 3827)},
    {min = 40, max = 60, mob = "Brute [Level 45]", questName = "BuggyQuest1", levelIndex = 2, npcPos = CFrame.new(-1140, 4, 3827)},
    {min = 60, max = 75, mob = "Desert Bandit [Level 60]", questName = "DesertQuest", levelIndex = 1, npcPos = CFrame.new(895, 6, 4388)},
    {min = 75, max = 90, mob = "Desert Officer [Level 70]", questName = "DesertQuest", levelIndex = 2, npcPos = CFrame.new(895, 6, 4388)},
    {min = 90, max = 100, mob = "Snow Bandit [Level 90]", questName = "SnowQuest", levelIndex = 1, npcPos = CFrame.new(1389, 87, -1298)},
    {min = 100, max = 120, mob = "Snowman [Level 100]", questName = "SnowQuest", levelIndex = 2, npcPos = CFrame.new(1389, 87, -1298)},
    {min = 120, max = 150, mob = "Chief Petty Officer [Level 120]", questName = "MarineQuest2", levelIndex = 1, npcPos = CFrame.new(-5035, 27, 4325)},
    {min = 150, max = 175, mob = "Sky Bandit [Level 150]", questName = "SkyQuest", levelIndex = 1, npcPos = CFrame.new(-4842, 717, -2623)},
    {min = 175, max = 190, mob = "Dark Master [Level 175]", questName = "SkyQuest", levelIndex = 2, npcPos = CFrame.new(-4842, 717, -2623)},
    {min = 190, max = 210, mob = "Prisoner [Level 190]", questName = "PrisonerQuest", levelIndex = 1, npcPos = CFrame.new(487, 47, 606)},
    {min = 210, max = 250, mob = "Dangerous Prisoner [Level 220]", questName = "PrisonerQuest", levelIndex = 2, npcPos = CFrame.new(487, 47, 606)},
    {min = 250, max = 275, mob = "Toga Warrior [Level 250]", questName = "ColosseumQuest", levelIndex = 1, npcPos = CFrame.new(-1579, 7, -2990)},
    {min = 275, max = 300, mob = "Gladiator [Level 275]", questName = "ColosseumQuest", levelIndex = 2, npcPos = CFrame.new(-1579, 7, -2990)},
    {min = 300, max = 325, mob = "Military Soldier [Level 300]", questName = "MagmaQuest", levelIndex = 1, npcPos = CFrame.new(-5315, 11, 8515)},
    {min = 325, max = 375, mob = "Military Spy [Level 325]", questName = "MagmaQuest", levelIndex = 2, npcPos = CFrame.new(-5315, 11, 8515)},
    {min = 375, max = 400, mob = "Fishman Warrior [Level 375]", questName = "FishmanQuest", levelIndex = 1, npcPos = CFrame.new(61122, 18, 1569)},
    {min = 400, max = 450, mob = "Fishman Commando [Level 400]", questName = "FishmanQuest", levelIndex = 2, npcPos = CFrame.new(61122, 18, 1569)},
    {min = 450, max = 475, mob = "God's Guard [Level 450]", questName = "SkyExp1Quest", levelIndex = 1, npcPos = CFrame.new(-7862, 5545, -380)},
    {min = 475, max = 525, mob = "Shanda [Level 475]", questName = "SkyExp1Quest", levelIndex = 2, npcPos = CFrame.new(-7862, 5545, -380)},
    {min = 525, max = 550, mob = "Wandas [Level 525]", questName = "SkyExp2Quest", levelIndex = 1, npcPos = CFrame.new(-7903, 5635, -1411)},
    {min = 550, max = 625, mob = "Royal Squad [Level 550]", questName = "SkyExp2Quest", levelIndex = 2, npcPos = CFrame.new(-7903, 5635, -1411)},
    {min = 625, max = 700, mob = "Galley Pirate [Level 625]", questName = "FountainQuest", levelIndex = 1, npcPos = CFrame.new(5259, 38, 4050)},
    {min = 700, max = 725, mob = "Raider [Level 700]", questName = "Area1Quest", levelIndex = 1, npcPos = CFrame.new(-429, 72, 1836)},
    {min = 725, max = 775, mob = "Mercenary [Level 725]", questName = "Area1Quest", levelIndex = 2, npcPos = CFrame.new(-429, 72, 1836)},
    {min = 775, max = 800, mob = "Swan Pirate [Level 775]", questName = "Area2Quest", levelIndex = 1, npcPos = CFrame.new(633, 73, 918)},
    {min = 800, max = 850, mob = "Factory Staff [Level 800]", questName = "Area2Quest", levelIndex = 2, npcPos = CFrame.new(633, 73, 918)},
    {min = 850, max = 900, mob = "Marine Lieutenant [Level 850]", questName = "MarineQuest3", levelIndex = 1, npcPos = CFrame.new(-2442, 73, -3219)},
    {min = 900, max = 950, mob = "Marine Captain [Level 900]", questName = "MarineQuest3", levelIndex = 2, npcPos = CFrame.new(-2442, 73, -3219)},
    {min = 950, max = 1000, mob = "Zombie [Level 950]", questName = "ZombieQuest", levelIndex = 1, npcPos = CFrame.new(-5497, 48, -794)},
    {min = 1000, max = 1050, mob = "Vampire [Level 1000]", questName = "ZombieQuest", levelIndex = 2, npcPos = CFrame.new(-5497, 48, -794)},
    {min = 1050, max = 1100, mob = "Snow Trooper [Level 1050]", questName = "SnowMountainQuest", levelIndex = 1, npcPos = CFrame.new(604, 402, -5372)},
    {min = 1100, max = 1175, mob = "Winter Warrior [Level 1100]", questName = "SnowMountainQuest", levelIndex = 2, npcPos = CFrame.new(604, 402, -5372)},
    {min = 1175, max = 1250, mob = "Lab Subordinate [Level 1175]", questName = "IceSideQuest", levelIndex = 1, npcPos = CFrame.new(-6061, 16, -4907)},
    {min = 1250, max = 1300, mob = "Horned Warrior [Level 1250]", questName = "IceSideQuest", levelIndex = 2, npcPos = CFrame.new(-6061, 16, -4907)},
    {min = 1300, max = 1350, mob = "Magma Ninja [Level 1300]", questName = "FireSideQuest", levelIndex = 1, npcPos = CFrame.new(5435, 20, 6023)},
    {min = 1350, max = 1425, mob = "Lava Pirate [Level 1350]", questName = "FireSideQuest", levelIndex = 2, npcPos = CFrame.new(5435, 20, 6023)},
    {min = 1425, max = 1500, mob = "Ship Deckhand [Level 1425]", questName = "ShipQuest1", levelIndex = 1, npcPos = CFrame.new(1038, 125, 32910)},
    {min = 1500, max = 1575, mob = "Pirate Millionaire [Level 1500]", questName = "PiratePortQuest", levelIndex = 1, npcPos = CFrame.new(-290, 43, 5581)},
    {min = 1575, max = 1625, mob = "Pistol Billionaire [Level 1575]", questName = "PiratePortQuest", levelIndex = 2, npcPos = CFrame.new(-290, 43, 5581)},
    {min = 1625, max = 1700, mob = "Dragon Crew Warrior [Level 1625]", questName = "AmazonQuest", levelIndex = 1, npcPos = CFrame.new(5833, 51, -1102)},
    {min = 1700, max = 1750, mob = "Dragon Crew Archer [Level 1700]", questName = "AmazonQuest", levelIndex = 2, npcPos = CFrame.new(5833, 51, -1102)},
    {min = 1750, max = 1800, mob = "Female Islander [Level 1750]", questName = "AmazonQuest2", levelIndex = 1, npcPos = CFrame.new(5451, 602, -756)},
    {min = 1800, max = 1900, mob = "Giant Islander [Level 1800]", questName = "AmazonQuest2", levelIndex = 2, npcPos = CFrame.new(5451, 602, -756)},
    {min = 1900, max = 1975, mob = "Marine Commodore [Level 1900]", questName = "MarineTreeIslandQuest", levelIndex = 1, npcPos = CFrame.new(2180, 28, -6740)},
    {min = 1975, max = 2075, mob = "Marine Rear Admiral [Level 1975]", questName = "MarineTreeIslandQuest", levelIndex = 2, npcPos = CFrame.new(2180, 28, -6740)},
    {min = 2075, max = 2125, mob = "Fishman Raider [Level 2075]", questName = "DeepForestIslandQuest", levelIndex = 1, npcPos = CFrame.new(-10582, 331, -8758)},
    {min = 2125, max = 2200, mob = "Fishman Captain [Level 2125]", questName = "DeepForestIslandQuest", levelIndex = 2, npcPos = CFrame.new(-10582, 331, -8758)},
    {min = 2200, max = 2250, mob = "Forest Pirate [Level 2200]", questName = "DeepForestIslandQuest2", levelIndex = 1, npcPos = CFrame.new(-13231, 332, -7628)},
    {min = 2250, max = 2300, mob = "Mythological Pirate [Level 2250]", questName = "DeepForestIslandQuest2", levelIndex = 2, npcPos = CFrame.new(-13231, 332, -7628)},
    {min = 2300, max = 2450, mob = "Reborn Skeleton [Level 2300]", questName = "HauntedCastleQuest", levelIndex = 1, npcPos = CFrame.new(-9515, 142, 5535)},
    {min = 2450, max = 2600, mob = "Living Zombie [Level 2400]", questName = "HauntedCastleQuest", levelIndex = 2, npcPos = CFrame.new(-9515, 142, 5535)},
    {min = 2600, max = 2700, mob = "Peanut Scout [Level 2600]", questName = "PeanutQuest", levelIndex = 1, npcPos = CFrame.new(-2104, 45, -10165)},
    {min = 2700, max = 2800, mob = "Peanut President [Level 2700]", questName = "PeanutQuest", levelIndex = 2, npcPos = CFrame.new(-2104, 45, -10165)}
}

local function GetCurrentQuestData(lv)
    for _, q in ipairs(QuestsList) do
        if lv >= q.min and lv < q.max then
            return q
        end
    end
    return QuestsList[#QuestsList]
end

return {
    Run = function()
        task.spawn(function()
            while task.wait(0.2) do
                pcall(function()
                    local ch = GetChar()
                    local root = GetRoot(ch)
                    if not root then return end

                    if ch and not ch:FindFirstChild("Buso") then SafeCall("Buso") end

                    local dt = L:FindFirstChild("Data")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1

                    if lv > 2800 then
                        Hop()
                        return
                    end

                    local qData = GetCurrentQuestData(lv)
                    local activeQuest = dt and dt:FindFirstChild("Quest") and dt.Quest.Value ~= ""

                    if not activeQuest then
                        StopFly()
                        if (root.Position - qData.npcPos.Position).Magnitude > 15 then
                            SmartFly(qData.npcPos)
                        else
                            SafeCall("SetSpawnPoint")
                            SafeCall("StartQuest", qData.questName, qData.levelIndex)
                        end
                    else
                        local targetMobPos = nil
                        local enemies = W:FindFirstChild("Enemies")
                        if enemies then
                            for _, mob in ipairs(enemies:GetChildren()) do
                                local mRoot = mob:FindFirstChild("HumanoidRootPart")
                                local mHum = mob:FindFirstChild("Humanoid")
                                if mRoot and mHum and mHum.Health > 0 and mob.Name == qData.mob then
                                    targetMobPos = mRoot.Position
                                    break
                                end
                            end
                        end

                        if targetMobPos then
                            BringMobs(targetMobPos, qData.mob)
                            SmartFly(CFrame.new(targetMobPos + Vector3.new(0, 25, 0)))
                        else
                            SmartFly(qData.npcPos)
                        end
                    end
                end)
            end
        end)
    end
}
