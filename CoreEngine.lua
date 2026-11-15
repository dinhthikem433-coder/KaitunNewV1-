local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local LevelFarm    = loadstring(game:HttpGet("https://raw.githubusercontent.com/dinhthikem433-coder/KaitunNewV1-/main/AutoLevel.lua"))()
local ItemQuests   = loadstring(game:HttpGet("https://raw.githubusercontent.com/dinhthikem433-coder/KaitunNewV1-/main/ItemQuests.lua"))()
local RaidManager  = loadstring(game:HttpGet("https://raw.githubusercontent.com/dinhthikem433-coder/KaitunNewV1-/main/RaidManager.lua"))()

local function InitializeFastAttack()
    pcall(function()
        local CombatFramework = require(ReplicatedStorage:WaitForChild("CombatFramework"))
        local CombatFrameworkR = rawget(CombatFramework, "activeController")
        if CombatFrameworkR then
            for _, v in pairs(debug.getupvalues(CombatFrameworkR.attack)) do
                if type(v) == "table" and rawget(v, "CHIT") then
                    local oldHit = v.CHIT
                    v.CHIT = function(...)
                        local success, err = pcall(oldHit, ...)
                        return success and err
                    end
                end
            end
        end
    end)
end

local function ProcessCombat()
    pcall(function()
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")
        local enemies = Workspace:FindFirstChild("Enemies")
        if not rootPart or not humanoid or not enemies then return end

        local targetMob = nil
        for _, mob in ipairs(enemies:GetChildren()) do
            local mRoot = mob:FindFirstChild("HumanoidRootPart")
            local mHum = mob:FindFirstChild("Humanoid")
            if mRoot and mHum and mHum.Health > 0 then
                targetMob = mob
                break
            end
        end

        if targetMob then
            local mRoot = targetMob:FindFirstChild("HumanoidRootPart")
            local mHum = targetMob:FindFirstChild("Humanoid")
            if mRoot and mHum then
                for _, mob in ipairs(enemies:GetChildren()) do
                    local otherRoot = mob:FindFirstChild("HumanoidRootPart")
                    local otherHum = mob:FindFirstChild("Humanoid")
                    if otherRoot and otherHum and otherHum.Health > 0 then
                        if (otherRoot.Position - mRoot.Position).Magnitude <= 350 then
                            otherRoot.CFrame = mRoot.CFrame
                            otherHum.WalkSpeed = 0
                            otherHum.JumpPower = 0
                        end
                    end
                end

                humanoid.PlatformStand = true
                rootPart.CFrame = mRoot.CFrame + Vector3.new(0, 25, 0)
                rootPart.Velocity = Vector3.new(0, -20, 0)
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            end
        else
            humanoid.PlatformStand = false
        end

        pcall(function()
            local AC = debug.getupvalue(require(ReplicatedStorage.CombatFramework), 2)
            if AC and AC.activeController then
                AC.activeController.timeToNextAttack = 0
                AC.activeController.agitating = true
                AC.activeController.focusMob = nil
                AC.activeController:attack()
            end
        end)
    end)
end

local function HasSpareFruitForRaid()
    local bp = LocalPlayer.Backpack
    local ch = LocalPlayer.Character
    local inventory = {}
    
    if bp then
        for _, item in ipairs(bp:GetChildren()) do
            if item:IsA("Tool") and (item.Name:match("Fruit") or item:FindFirstChild("Fruit")) then
                table.insert(inventory, item.Name)
            end
        end
    end
    
    if ch then
        for _, item in ipairs(ch:GetChildren()) do
            if item:IsA("Tool") and (item.Name:match("Fruit") or item:FindFirstChild("Fruit")) then
                table.insert(inventory, item.Name)
            end
        end
    end

    for _, name in ipairs(inventory) do
        if not (name:find("Leopard") or name:find("Dragon") or name:find("Kitsune") or name:find("Spirit") or name:find("Control") or name:find("Venom") or name:find("Shadow") or name:find("Dough") or name:find("T-Rex") or name:find("Mammoth") or name:find("Yeti") or name:find("Gas") or name:find("Portal") or name:find("Rumble")) then
            return true
        end
    end
    return false
end

return {
    Init = function()
        task.spawn(InitializeFastAttack)

        task.spawn(function()
            while task.wait(0.2) do
                pcall(function()
                    ProcessCombat()
                    
                    local dt = LocalPlayer:FindFirstChild("Data")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1

                    if lv >= 1100 and HasSpareFruitForRaid() then
                        pcall(function() RaidManager.Run() end)
                        return
                    end

                    LevelFarm.RunOnce = LevelFarm.RunOnce or (function()
                        task.spawn(function() LevelFarm.Run() end)
                        return true
                    end)()

                    if lv >= 1500 and lv <= 2800 then
                        ItemQuests.RunOnce = ItemQuests.RunOnce or (function()
                            task.spawn(function() ItemQuests.Run() end)
                            return true
                        end)()
                    end
                end)
            end
        end)
    end
}
