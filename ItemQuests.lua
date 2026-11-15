-- ItemQuests.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

local function CheckLegendaryItemsAndQuests(stateTable)
    pcall(function()
        local backpack = LocalPlayer.Backpack
        local character = LocalPlayer.Character
        
        local hasSoulGuitar = backpack:FindFirstChild("Soul Guitar") or (character and character:FindFirstChild("Soul Guitar"))
        local hasCDK = backpack:FindFirstChild("Cursed Dual Katana") or (character and character:FindFirstChild("Cursed Dual Katana"))
        local hasMirrorFractal = backpack:FindFirstChild("Mirror Fractal") or (character and character:FindFirstChild("Mirror Fractal"))

        if not hasSoulGuitar then
            stateTable.CurrentTask = "Hunting Soul Guitar Materials & Graveyard Puzzle"
            return
        end

        if not hasCDK then
            stateTable.CurrentTask = "Executing Tushita & Yama Trials for CDK"
            return
        end

        if not hasMirrorFractal then
            stateTable.CurrentTask = "Hunting Cake Prince / Dough King for Mirror Fractal"
            return
        end
    end)
end

local FightingStyleRequirements = {
    {V2 = "Godhuman", V1 = "Superhuman", ReqMastery = 400, ReqBeli = 5000000, ReqFrags = 5000},
    {V2 = "ElectricClaw", V1 = "Electric", ReqMastery = 400, ReqBeli = 3000000, ReqFrags = 5000},
    {V2 = "SharkmanKarate", V1 = "Water Kung Fu", ReqMastery = 400, ReqBeli = 2500000, ReqFrags = 5000},
    {V2 = "DragonTalon", V1 = "Dragon Breath", ReqMastery = 400, ReqBeli = 3000000, ReqFrags = 5000},
    {V2 = "DeathStep", V1 = "Dark Step", ReqMastery = 400, ReqBeli = 2500000, ReqFrags = 5000}
}

local function FightingStyleProgression(stateTable)
    pcall(function()
        stateTable.IsBusyWithCriticalTask = true
        
        local dataFolder = LocalPlayer:FindFirstChild("Data") or LocalPlayer:FindFirstChild("leaderstats")
        if not dataFolder then
            stateTable.IsBusyWithCriticalTask = false
            return
        end
        local playerMoneyVal = dataFolder:FindFirstChild("Beli")
        local playerFragmentsVal = dataFolder:FindFirstChild("Fragments")
        local playerMoney = playerMoneyVal and playerMoneyVal.Value or 0
        local playerFragments = playerFragmentsVal and playerFragmentsVal.Value or 0

        for _, style in ipairs(FightingStyleRequirements) do
            if CommF_ then
                local success, res = pcall(function()
                    return CommF_:InvokeServer("Buy" .. style.V2, true)
                end)
                
                if success then
                    local isStringRes = (type(res) == "string")
                    local needUnlock = isStringRes and (res == "Not enough materials" or res == "You need to unlock" or res:find("unlock") or res:find("Mastery"))
                    
                    if needUnlock or res == false or res == nil then
                        stateTable.CurrentTask = "Training " .. style.V1 .. " to " .. style.ReqMastery .. " Mastery & Gathering Materials for " .. style.V2
                        pcall(function()
                            CommF_:InvokeServer("Buy" .. style.V2, false)
                        end)
                        task.wait(1)
                        stateTable.IsBusyWithCriticalTask = false
                        return
                    end
                    
                    if playerMoney >= style.ReqBeli and playerFragments >= style.ReqFrags then
                        stateTable.CurrentTask = "Purchasing Fighting Style: " .. style.V2
                        pcall(function()
                            CommF_:InvokeServer("Buy" .. style.V2)
                        end)
                        task.wait(1)
                    end
                end
            end
        end
        
        stateTable.IsBusyWithCriticalTask = false
    end)
end

return {
    CheckLegendaryItemsAndQuests = CheckLegendaryItemsAndQuests,
    FightingStyleProgression = FightingStyleProgression
}
