local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Engine = getgenv().CoreEngine or require(script.Parent:WaitForChild("CoreEngine"))
Engine.Init()

local QuestData = {
    [1] = {
        LevelReq = 1,
        QuestName = "BanditQuest1",
        QuestId = 1,
        NPC = "Bandit Quest Giver",
        MobName = "Bandit",
        MobSpawn = CFrame.new(1059, 16, 1373)
    },
    [10] = {
        LevelReq = 10,
        QuestName = "JungleQuest",
        QuestId = 1,
        NPC = "Jungle Quest Giver",
        MobName = "Monkey",
        MobSpawn = CFrame.new(-1601, 37, 153)
    },
    [15] = {
        LevelReq = 15,
        QuestName = "JungleQuest",
        QuestId = 2,
        NPC = "Jungle Quest Giver",
        MobName = "Gorilla",
        MobSpawn = CFrame.new(-1142, 10, 511)
    },
    [30] = {
        LevelReq = 30,
        QuestName = "BuggyQuest1",
        QuestId = 1,
        NPC = "Pirate Village Quest Giver",
        MobName = "Pirate",
        MobSpawn = CFrame.new(-1106, 14, 3817)
    },
    [40] = {
        LevelReq = 40,
        QuestName = "BuggyQuest1",
        QuestId = 2,
        NPC = "Pirate Village Quest Giver",
        MobName = "Brute",
        MobSpawn = CFrame.new(-1205, 18, 4278)
    },
    [60] = {
        LevelReq = 60,
        QuestName = "DesertQuest",
        QuestId = 1,
        NPC = "Desert Quest Giver",
        MobName = "Desert Bandit",
        MobSpawn = CFrame.new(903, 7, 4398)
    },
    [75] = {
        LevelReq = 75,
        QuestName = "DesertQuest",
        QuestId = 2,
        NPC = "Desert Quest Giver",
        MobName = "Desert Officer",
        MobSpawn = CFrame.new(1478, 11, 4383)
    },
    [90] = {
        LevelReq = 90,
        QuestName = "SnowQuest",
        QuestId = 1,
        NPC = "Snow Village Quest Giver",
        MobName = "Snow Bandit",
        MobSpawn = CFrame.new(1389, 87, -1300)
    },
    [100] = {
        LevelReq = 100,
        QuestName = "SnowQuest",
        QuestId = 2,
        NPC = "Snow Village Quest Giver",
        MobName = "Snowman",
        MobSpawn = CFrame.new(1257, 146, -1455)
    },
    [120] = {
        LevelReq = 120,
        QuestName = "MarineQuest",
        QuestId = 1,
        NPC = "Marine Outpost Quest Giver",
        MobName = "Chief Petty Officer",
        MobSpawn = CFrame.new(-4901, 23, 4137)
    },
    [150] = {
        LevelReq = 150,
        QuestName = "SkyQuest",
        QuestId = 1,
        NPC = "Sky Islands Quest Giver",
        MobName = "Sky Bandit",
        MobSpawn = CFrame.new(-4843, 718, -2622)
    },
    [175] = {
        LevelReq = 175,
        QuestName = "SkyQuest",
        QuestId = 2,
        NPC = "Sky Islands Quest Giver",
        MobName = "Dark Master",
        MobSpawn = CFrame.new(-5243, 388, -2275)
    },
    [190] = {
        LevelReq = 190,
        QuestName = "PrisonerQuest",
        QuestId = 1,
        NPC = "Prison Quest Giver",
        MobName = "Prisoner",
        MobSpawn = CFrame.new(511, 3, 474)
    },
    [210] = {
        LevelReq = 210,
        QuestName = "PrisonerQuest",
        QuestId = 2,
        NPC = "Prison Quest Giver",
        MobName = "Dangerous Prisoner",
        MobSpawn = CFrame.new(530, 3, 475)
    },
    [250] = {
        LevelReq = 250,
        QuestName = "ColosseumQuest",
        QuestId = 1,
        NPC = "Colosseum Quest Giver",
        MobName = "Toga Warrior",
        MobSpawn = CFrame.new(-1580, 7.3, -2975)
    },
    [275] = {
        LevelReq = 275,
        QuestName = "ColosseumQuest",
        QuestId = 2,
        NPC = "Colosseum Quest Giver",
        MobName = "Gladiator",
        MobSpawn = CFrame.new(-1432, 7.3, -3200)
    },
    [300] = {
        LevelReq = 300,
        QuestName = "MagmaQuest",
        QuestId = 1,
        NPC = "Magma Village Quest Giver",
        MobName = "Military Soldier",
        MobSpawn = CFrame.new(-5317, 12, 8515)
    },
    [325] = {
        LevelReq = 325,
        QuestName = "MagmaQuest",
        QuestId = 2,
        NPC = "Magma Village Quest Giver",
        MobName = "Military Spy",
        MobSpawn = CFrame.new(-5805, 51, 8821)
    },
    [375] = {
        LevelReq = 375,
        QuestName = "FishmanQuest",
        QuestId = 1,
        NPC = "Underwater City Quest Giver",
        MobName = "Fishman Warrior",
        MobSpawn = CFrame.new(6112, 18.5, 1555)
    },
    [400] = {
        LevelReq = 400,
        QuestName = "FishmanQuest",
        QuestId = 2,
        NPC = "Underwater City Quest Giver",
        MobName = "Fishman Commando",
        MobSpawn = CFrame.new(6186, 18.5, 2337)
    },
    [450] = {
        LevelReq = 450,
        QuestName = "FountainQuest",
        QuestId = 1,
        NPC = "Fountain City Quest Giver",
        MobName = "Galley Pirate",
        MobSpawn = CFrame.new(5259, 38, 4048)
    },
    [500] = {
        LevelReq = 500,
        QuestName = "FountainQuest",
        QuestId = 2,
        NPC = "Fountain City Quest Giver",
        MobName = "Galley Captain",
        MobSpawn = CFrame.new(5539, 38, 4894)
    },
    [700] = {
        LevelReq = 700,
        QuestName = "Area1Quest",
        QuestId = 1,
        NPC = "Docks Quest Giver",
        MobName = "Raider",
        MobSpawn = CFrame.new(-423, 73, 1836)
    },
    [725] = {
        LevelReq = 725,
        QuestName = "Area1Quest",
        QuestId = 2,
        NPC = "Docks Quest Giver",
        MobName = "Mercenary",
        MobSpawn = CFrame.new(-868, 142, 1346)
    },
    [750] = {
        LevelReq = 750,
        QuestName = "Area2Quest",
        QuestId = 1,
        NPC = "Green Zone Quest Giver",
        MobName = "Swan Pirate",
        MobSpawn = CFrame.new(662, 114, 1222)
    },
    [800] = {
        LevelReq = 800,
        QuestName = "Area2Quest",
        QuestId = 2,
        NPC = "Green Zone Quest Giver",
        MobName = "Factory Staff",
        MobSpawn = CFrame.new(506, 114, -282)
    },
    [850] = {
        LevelReq = 850,
        QuestName = "SnowMountainQuest",
        QuestId = 1,
        NPC = "Snow Mountain Quest Giver",
        MobName = "Snow Warrior",
        MobSpawn = CFrame.new(301, 401, -5555)
    },
    [875] = {
        LevelReq = 875,
        QuestName = "SnowMountainQuest",
        QuestId = 2,
        NPC = "Snow Mountain Quest Giver",
        MobName = "Winter Warrior",
        MobSpawn = CFrame.new(565, 401, -6155)
    },
    [900] = {
        LevelReq = 900,
        QuestName = "IceSideQuest",
        QuestId = 1,
        NPC = "Hot and Cold Quest Giver",
        MobName = "Lab Subordinate",
        MobSpawn = CFrame.new(-6016, 15, -4902)
    },
    [950] = {
        LevelReq = 950,
        QuestName = "IceSideQuest",
        QuestId = 2,
        NPC = "Hot and Cold Quest Giver",
        MobName = "Horned Warrior",
        MobSpawn = CFrame.new(-6322, 15, -5742)
    },
    [1000] = {
        LevelReq = 1000,
        QuestName = "FireSideQuest",
        QuestId = 1,
        NPC = "Hot and Cold Quest Giver",
        MobName = "Magma Ninja",
        MobSpawn = CFrame.new(-5405, 15, -5978)
    },
    [1050] = {
        LevelReq = 1050,
        QuestName = "FireSideQuest",
        QuestId = 2,
        NPC = "Hot and Cold Quest Giver",
        MobName = "Lava Pirate",
        MobSpawn = CFrame.new(-5197, 21, -4678)
    },
    [1100] = {
        LevelReq = 1100,
        QuestName = "ShipQuest1",
        QuestId = 1,
        NPC = "Cursed Ship Quest Giver",
        MobName = "Ship Deckhand",
        MobSpawn = CFrame.new(1022, 125, 32908)
    },
    [1125] = {
        LevelReq = 1125,
        QuestName = "ShipQuest1",
        QuestId = 2,
        NPC = "Cursed Ship Quest Giver",
        MobName = "Ship Engineer",
        MobSpawn = CFrame.new(921, 43, 32777)
    },
    [1175] = {
        LevelReq = 1175,
        QuestName = "ShipQuest2",
        QuestId = 1,
        NPC = "Cursed Ship Quest Giver",
        MobName = "Ship Steward",
        MobSpawn = CFrame.new(910, 131, 33333)
    },
    [1200] = {
        LevelReq = 1200,
        QuestName = "ShipQuest2",
        QuestId = 2,
        NPC = "Cursed Ship Quest Giver",
        MobName = "Ship Officer",
        MobSpawn = CFrame.new(1122, 131, 33333)
    },
    [1250] = {
        LevelReq = 1250,
        QuestName = "IceIslandQuest",
        QuestId = 1,
        NPC = "Ice Cream Island Quest Giver",
        MobName = "Arctic Warrior",
        MobSpawn = CFrame.new(6075, 49, -6155)
    },
    [1300] = {
        LevelReq = 1300,
        QuestName = "IceIslandQuest",
        QuestId = 2,
        NPC = "Ice Cream Island Quest Giver",
        MobName = "Snow Lurker",
        MobSpawn = CFrame.new(6322, 49, -5742)
    },
    [1350] = {
        LevelReq = 1350,
        QuestName = "FireIslandQuest",
        QuestId = 1,
        NPC = "Peanut Island Quest Giver",
        MobName = "Peanut Scout",
        MobSpawn = CFrame.new(-2015, 51, -12155)
    },
    [1400] = {
        LevelReq = 1400,
        QuestName = "FireIslandQuest",
        QuestId = 2,
        NPC = "Peanut Island Quest Giver",
        MobName = "Peanut Präsident",
        MobSpawn = CFrame.new(-2215, 51, -12355)
    },
    [1450] = {
        LevelReq = 1450,
        QuestName = "HauntedQuest1",
        QuestId = 1,
        NPC = "Haunted Castle Quest Giver",
        MobName = "Reborn Skeleton",
        MobSpawn = CFrame.new(-9479, 141, 5565)
    },
    [1500] = {
        LevelReq = 1500,
        QuestName = "HauntedQuest1",
        QuestId = 2,
        NPC = "Haunted Castle Quest Giver",
        MobName = "Living Zombie",
        MobSpawn = CFrame.new(-10144, 141, 6185)
    },
    [1525] = {
        LevelReq = 1525,
        QuestName = "HauntedQuest2",
        QuestId = 1,
        NPC = "Haunted Castle Quest Giver",
        MobName = "Demonic Soul",
        MobSpawn = CFrame.new(-9515, 172, 6078)
    },
    [1575] = {
        LevelReq = 1575,
        QuestName = "HauntedQuest2",
        QuestId = 2,
        NPC = "Haunted Castle Quest Giver",
        MobName = "Posessed Mummy",
        MobSpawn = CFrame.new(-9181, 172, 6122)
    },
    [1600] = {
        LevelReq = 1600,
        QuestName = "NutIslandQuest",
        QuestId = 1,
        NPC = "Nut Island Quest Giver",
        MobName = "Cocoa Warrior",
        MobSpawn = CFrame.new(-144, 23, -12745)
    },
    [1625] = {
        LevelReq = 1625,
        QuestName = "NutIslandQuest",
        QuestId = 2,
        NPC = "Nut Island Quest Giver",
        MobName = "Chocolate Bar Battler",
        MobSpawn = CFrame.new(234, 23, -12545)
    },
    [1700] = {
        LevelReq = 1700,
        QuestName = "MummyQuest",
        QuestId = 1,
        NPC = "Tiki Outpost Quest Giver",
        MobName = "Sweet Thief",
        MobSpawn = CFrame.new(-300, 23, -11945)
    },
    [1725] = {
        LevelReq = 1725,
        QuestName = "MummyQuest",
        QuestId = 2,
        NPC = "Tiki Outpost Quest Giver",
        MobName = "Candy Rebel",
        MobSpawn = CFrame.new(-500, 23, -12145)
    },
    [1750] = {
        LevelReq = 1750,
        QuestName = "Area1Quest3",
        QuestId = 1,
        NPC = "Sea of Treats Quest Giver",
        MobName = "Candy Pirate",
        MobSpawn = CFrame.new(-1200, 23, -14145)
    },
    [1800] = {
        LevelReq = 1800,
        QuestName = "Area1Quest3",
        QuestId = 2,
        NPC = "Sea of Treats Quest Giver",
        MobName = "Snow Demon",
        MobSpawn = CFrame.new(-1400, 23, -14345)
    },
    [1900] = {
        LevelReq = 1900,
        QuestName = "MarineTreeIsland",
        QuestId = 1,
        NPC = "Mythological Island Quest Giver",
        MobName = "Pirate Millionaire",
        MobSpawn = CFrame.new(-380, 77, 5555)
    },
    [1950] = {
        LevelReq = 1950,
        QuestName = "MarineTreeIsland",
        QuestId = 2,
        NPC = "Mythological Island Quest Giver",
        MobName = "Pistol Corsair",
        MobSpawn = CFrame.new(-580, 77, 5755)
    },
    [2000] = {
        LevelReq = 2000,
        QuestName = "JunglePirateQuest",
        QuestId = 1,
        NPC = "Floating Turtle Quest Giver",
        MobName = "Forest Pirate",
        MobSpawn = CFrame.new(-13200, 331, -7800)
    },
    [2050] = {
        LevelReq = 2050,
        QuestName = "JunglePirateQuest",
        QuestId = 2,
        NPC = "Floating Turtle Quest Giver",
        MobName = "Mythological Pirate",
        MobSpawn = CFrame.new(-13500, 483, -6900)
    },
    [2100] = {
        LevelReq = 2100,
        QuestName = "HydraQuest",
        QuestId = 1,
        NPC = "Hydra Island Quest Giver",
        MobName = "Jungle Pirate",
        MobSpawn = CFrame.new(-2200, 15, -10200)
    },
    [2125] = {
        LevelReq = 2125,
        QuestName = "HydraQuest",
        QuestId = 2,
        NPC = "Hydra Island Quest Giver",
        MobName = "Musketeer Pirate",
        MobSpawn = CFrame.new(-2000, 15, -10400)
    },
    [2200] = {
        LevelReq = 2200,
        QuestName = "GreatTreeQuest",
        QuestId = 1,
        NPC = "Great Tree Quest Giver",
        MobName = "1",
        MobSpawn = CFrame.new(2500, 16, -10500)
    },
    [2225] = {
        LevelReq = 2225,
        QuestName = "GreatTreeQuest",
        QuestId = 2,
        NPC = "Great Tree Quest Giver",
        MobName = "2",
        MobSpawn = CFrame.new(2700, 60, -10700)
    },
    [2300] = {
        LevelReq = 2300,
        QuestName = "CastleQuest",
        QuestId = 1,
        NPC = "Castle on the Sea Quest Giver",
        MobName = "Marine Commodore",
        MobSpawn = CFrame.new(-5000, 315, -3000)
    },
    [2350] = {
        LevelReq = 2350,
        QuestName = "CastleQuest",
        QuestId = 2,
        NPC = "Castle on the Sea Quest Giver",
        MobName = "Marine Rear Admiral",
        MobSpawn = CFrame.new(-5200, 315, -3200)
    },
    [2400] = {
        LevelReq = 2400,
        QuestName = "SeaKingQuest",
        QuestId = 1,
        NPC = "Tiki Outpost Quest Giver 2",
        MobName = "Fishman Raider",
        MobSpawn = CFrame.new(-16000, 15, -500)
    },
    [2450] = {
        LevelReq = 2450,
        QuestName = "SeaKingQuest",
        QuestId = 2,
        NPC = "Tiki Outpost Quest Giver 2",
        MobName = "Sea Monster",
        MobSpawn = CFrame.new(-16200, 15, -700)
    },
    [2500] = {
        LevelReq = 2500,
        QuestName = "TikiQuest1",
        QuestId = 1,
        NPC = "Tiki Outpost Quest Giver",
        MobName = "Island Boy",
        MobSpawn = CFrame.new(-18900, 15, -1000)
    },
    [2600] = {
        LevelReq = 2600,
        QuestName = "TikiQuest2",
        QuestId = 1,
        NPC = "Tiki Outpost Quest Giver",
        MobName = "Sunken Sailor",
        MobSpawn = CFrame.new(-19200, 15, -1300)
    },
    [2700] = {
        LevelReq = 2700,
        QuestName = "TikiQuest3",
        QuestId = 1,
        NPC = "Tiki Outpost Quest Giver",
        MobName = "Tiki Shark",
        MobSpawn = CFrame.new(-19500, 15, -1500)
    },
    [2800] = {
        LevelReq = 2800,
        QuestName = "TikiQuestMax",
        QuestId = 1,
        NPC = "Max Level Quest Giver",
        MobName = "Ultimate Boss",
        MobSpawn = CFrame.new(-20000, 20, -2000)
    }
}

local function GetCurrentQuest()
    local playerLevel = LocalPlayer.Data and LocalPlayer.Data.Level.Value or 1
    local selectedQuest = nil
    for level, data in pairs(QuestData) do
        if playerLevel >= level then
            if not selectedQuest or level > selectedQuest.LevelReq then
                selectedQuest = data
            end
        end
    end
    return selectedQuest
end

local function GetNearestMob(mobName)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local nearest, shortest = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then nil end

    for _, mob in ipairs(enemies:GetChildren()) do
        if mob.Name == mobName then
            local hum = mob:FindFirstChild("Humanoid")
        local mRoot = mob:FindFirstChild("HumanoidRootPart")
            if hum and mRoot and hum.Health > 0 then
                local dist = (mRoot.Position - root.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    nearest = mRoot
                end
            end
        end
    end
    return nearest
end

local function CheckAndHandleSeaTransition(playerLevel)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes or not remotes:FindFirstChild("CommF_") then return end

    if playerLevel >= 700 and game.PlaceId == 2753915549 then
        Engine.SetTarget(CFrame.new(-380.2, 77.2, 183.5), "TransitToSea2")
        local detective = Workspace:FindFirstChild("NPC") and Workspace.NPC:FindFirstChild("Detective")
        if detective and (LocalPlayer.Character.HumanoidRootPart.Position - detective.HumanoidRootPart.Position).Magnitude < 15 then
            remotes.CommF_:InvokeServer("DressrosaQuest")
            task.wait(1)
        end
        return true
    elseif playerLevel >= 1500 and game.PlaceId == 4442272183 then
        Engine.SetTarget(CFrame.new(-65.4, 16.2, 1824.1), "TransitToSea3")
        local king = Workspace:FindFirstChild("NPC") and Workspace.NPC:FindFirstChild("King Red Head")
        if king and (LocalPlayer.Character.HumanoidRootPart.Position - king.HumanoidRootPart.Position).Magnitude < 15 then
            remotes.CommF_:InvokeServer("ThirdSea")
            task.wait(1)
        end
        return true
    end
    return false
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end

            local playerLevel = LocalPlayer.Data and LocalPlayer.Data.Level.Value or 1

            if CheckAndHandleSeaTransition(playerLevel) then
                return
            end

            local currentQuest = GetCurrentQuest()
            if not currentQuest then return end

            local questFolder = LocalPlayer.PlayerGui:FindFirstChild("Quest")
            local hasActiveQuest = questFolder and questFolder.Enabled and questFolder.Main.QuestTitle.Text:find(currentQuest.MobName)

            if not hasActiveQuest then
                Engine.SetTarget(currentQuest.MobSpawn, "GettingQuest")
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("CommF_") then
                    local distToNPC = (character.HumanoidRootPart.Position - currentQuest.MobSpawn.Position).Magnitude
                    if distToNPC < 20 then
                        remotes.CommF_:InvokeServer("StartQuest", currentQuest.QuestName, currentQuest.QuestId)
                        task.wait(1)
                    end
                end
            else
                local targetMobRoot = GetNearestMob(currentQuest.MobName)
                if targetMobRoot then
                    Engine.SetTarget(targetMobRoot.CFrame + Vector3.new(0, 5, 0), "FarmMob")
                else
                    Engine.SetTarget(currentQuest.MobSpawn, "WaitingMob")
                end
            end
        end)
    end
end)
