local P, R = game:GetService("Players"), game:GetService("ReplicatedStorage")
local TP = game:GetService("TeleportService")
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

local function HasItem(name)
    local bp = L.Backpack
    local ch = L.Character
    return (bp and bp:FindFirstChild(name)) or (ch and ch:FindFirstChild(name))
end

local function EquipItem(name)
    local bp = L.Backpack
    local ch = L.Character
    local hum = ch and ch:FindFirstChild("Humanoid")
    if ch and not ch:FindFirstChild(name) and bp and hum then
        local tool = bp:FindFirstChild(name)
        if tool and tool:IsA("Tool") then
            hum:EquipTool(tool)
        end
    end
end

local function GetMastery(name)
    local bp = L.Backpack
    local ch = L.Character
    local item = (bp and bp:FindFirstChild(name)) or (ch and ch:FindFirstChild(name))
    if item then
        local mst = item:FindFirstChild("Level") and item.Level.Value or 1
        return true, mst
    end
    return false, 0
end

local function HasSpareFruitForRaid()
    local bp = L.Backpack
    if not bp then return false end
    for _, item in ipairs(bp:GetChildren()) do
        if item:IsA("Tool") and (item.Name:match("Fruit") or item:FindFirstChild("Fruit")) then
            local name = item.Name
            if not (name:find("Leopard") or name:find("Dragon") or name:find("Kitsune") or name:find("Spirit") or name:find("Control") or name:find("Venom") or name:find("Shadow") or name:find("Dough") or name:find("T-Rex") or name:find("Mammoth") or name:find("Yeti") or name:find("Gas")) then
                return true
            end
        end
    end
    return false
end

return {
    Run = function()
        task.spawn(function()
            while task.wait(3) do
                pcall(function()
                    local ch = L.Character
                    if ch and not ch:FindFirstChild("Buso") then SafeCall("Buso") end

                    local dt = L:FindFirstChild("Data")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1
                    local beli = dt and dt:FindFirstChild("Beli") and dt.Beli.Value or 0
                    local frag = dt and dt:FindFirstChild("Fragments") and dt.Fragments.Value or 0
                    local bones = dt and dt:FindFirstChild("Bones") and dt.Bones.Value or 0
                    local ecto = dt and dt:FindFirstChild("Ectoplasm") and dt.Ectoplasm.Value or 0

                    if lv >= 700 and lv < 1500 then
                        local hasDark = HasItem("Dark Step")
                        local hasWater = HasItem("Water Kung Fu")
                        local hasElec = HasItem("Electric")
                        local hasDragon = HasItem("Dragon Breath")

                        if not hasDark then
                            SafeCall("BuyItem", "Dark Step")
                            EquipItem("Dark Step")
                        elseif not hasWater then
                            SafeCall("BuyItem", "Water Kung Fu")
                            EquipItem("Water Kung Fu")
                        elseif not hasElec then
                            SafeCall("BuyItem", "Electric")
                            SafeCall("ElectricQuest")
                            EquipItem("Electric")
                        elseif not hasDragon then
                            SafeCall("BuyItem", "Dragon Breath")
                            SafeCall("DragonBreathQuest")
                            EquipItem("Dragon Breath")
                        else
                            SafeCall("OpenLibrary")
                            SafeCall("GetLibraryKey")
                        end
                        return
                    end

                    if lv >= 1500 and lv <= 2800 then
                        local baseStyles = {"Dark Step", "Water Kung Fu", "Electric", "Dragon Breath"}
                        local allV1Full = true
                        for _, bs in ipairs(baseStyles) do
                            local hasB, mMst = GetMastery(bs)
                            if not hasB or mMst < 400 then
                                allV1Full = false
                                if not hasB then
                                    SafeCall("BuyItem", bs)
                                    EquipItem(bs)
                                else
                                    SafeCall("TrainWeapon", bs)
                                    EquipItem(bs)
                                end
                                break
                            end
                        end

                        local hasSuperhuman = HasItem("Superhuman")
                        if allV1Full and not hasSuperhuman then
                            if beli >= 3000000 then
                                SafeCall("BuyItem", "Superhuman")
                                SafeCall("GetMelee", "Superhuman")
                                EquipItem("Superhuman")
                            end
                            return
                        end

                        local v2Upgrades = {
                            {v1 = "Dragon Breath", v2 = "Dragon Talon", costB = 3000000, costF = 5000, needItem = "Fire Essence"},
                            {v1 = "Dark Step", v2 = "Death Step", costB = 5000000, costF = 5000},
                            {v1 = "Water Kung Fu", v2 = "Sharkman Karate", costB = 5000000, costF = 5000},
                            {v1 = "Electric", v2 = "Electric Claw", costB = 5000000, costF = 5000}
                        }

                        local pendingV2Condition = false
                        for _, up in ipairs(v2Upgrades) do
                            local hasV2 = HasItem(up.v2)
                            if not hasV2 then
                                local itemReady = true
                                if up.needItem and not HasItem(up.needItem) then
                                    itemReady = false
                                    if bones >= 50 then
                                        SafeCall("Bones", "Buy")
                                        SafeCall("DeathKing", "Buy")
                                    end
                                end

                                if itemReady and beli >= up.costB and frag >= up.costF then
                                    SafeCall("BuyItem", up.v2)
                                    SafeCall("GetMelee", up.v2)
                                    EquipItem(up.v2)
                                else
                                    pendingV2Condition = true
                                    if frag < up.costF and HasSpareFruitForRaid() then
                                        SafeCall("Raid", "Select", "Flame")
                                        SafeCall("Raid", "Start")
                                    end
                                end
                                break
                            end
                        end

                        if pendingV2Condition then
                            return
                        end

                        local hasGod = HasItem("Godhuman")
                        local hasCDK = HasItem("Cursed Dual Katana")
                        local hasSG = HasItem("Soul Guitar")

                        if not hasGod then
                            local reqs = {"Superhuman", "Death Step", "Sharkman Karate", "Electric Claw", "Dragon Talon"}
                            local allMastered = true
                            for _, rq in ipairs(reqs) do
                                local ok, mst = GetMastery(rq)
                                if not ok then
                                    allMastered = false
                                    break
                                elseif mst < 400 then
                                    allMastered = false
                                    SafeCall("TrainWeapon", rq)
                                    break
                                end
                            end

                            if allMastered and beli >= 5000000 and frag >= 5000 then
                                SafeCall("BuyItem", "Godhuman")
                                SafeCall("GetMelee", "Godhuman")
                                EquipItem("Godhuman")
                            end
                        elseif not hasCDK then
                            local tushita = HasItem("Tushita")
                            local yama = HasItem("Yama")
                            
                            if not tushita then
                                SafeCall("OpenCursedDualKatana")
                                SafeCall("GetTushita")
                                SafeCall("EliteHunter")
                                SafeCall("TushitaTorchPuzzle")
                            elseif not yama then
                                SafeCall("OpenCursedDualKatana")
                                SafeCall("GetYama")
                                SafeCall("EliteHunter")
                                if not HasItem("Hallow Essence") and bones >= 50 then
                                    SafeCall("Bones", "Buy")
                                    SafeCall("DeathKing", "Buy")
                                end
                            else
                                local _, tMst = GetMastery("Tushita")
                                local _, yMst = GetMastery("Yama")
                                if tMst >= 350 and yMst >= 350 then
                                    SafeCall("BuyItem", "Cursed Dual Katana")
                                    SafeCall("GetSword", "Cursed Dual Katana")
                                    SafeCall("OpenCursedDualKatana")
                                    EquipItem("Cursed Dual Katana")
                                else
                                    SafeCall("TrainWeapon", "Tushita")
                                    SafeCall("TrainWeapon", "Yama")
                                end
                            end
                        elseif not hasSG then
                            if bones >= 500 and ecto >= 250 then
                                SafeCall("BuyItem", "Soul Guitar")
                                SafeCall("GetGun", "Soul Guitar")
                                SafeCall("SoulGuitarQuest")
                                SafeCall("SoulGuitarGraveyardPuzzle")
                                SafeCall("SoulGuitarPianoPuzzle")
                                EquipItem("Soul Guitar")
                            else
                                SafeCall("OpenSoulGuitar")
                            end
                        else
                            Hop()
                        end
                    end
                end)
            end
        end)
    end
}
