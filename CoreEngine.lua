local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function InitializeFastAttack()
    pcall(function()
        local CF = require(ReplicatedStorage:WaitForChild("CombatFramework"))
        local CFR = rawget(CF, "activeController")
        if CFR then
            for _, v in pairs(debug.getupvalues(CFR.attack)) do
                if type(v) == "table" and rawget(v, "CHIT") then
                    local oldHit = v.CHIT
                    v.CHIT = function(self, ...) return oldHit(self, ...) end
                end
            end
        end
    end)
end

local function GetNearestEnemy()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    local nearest, minDist = nil, math.huge
    for _, mob in ipairs(enemies:GetChildren()) do
        local mRoot = mob:FindFirstChild("HumanoidRootPart")
        local mHum = mob:FindFirstChild("Humanoid")
        if mRoot and mHum and mHum.Health > 0 then
            local dist = (mRoot.Position - rootPart.Position).Magnitude
            if dist < minDist then minDist = dist nearest = mob end
        end
    end
    return nearest
end

local function ProcessCombatAndMovement()
    pcall(function()
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")
        local enemies = Workspace:FindFirstChild("Enemies")
        if not rootPart or not humanoid or not enemies then return end
        local targetMob = GetNearestEnemy()
        if targetMob then
            local mRoot = targetMob:FindFirstChild("HumanoidRootPart")
            local mHum = targetMob:FindFirstChild("Humanoid")
            if mRoot and mHum then
                for _, mob in ipairs(enemies:GetChildren()) do
                    local oRoot = mob:FindFirstChild("HumanoidRootPart")
                    local oHum = mob:FindFirstChild("Humanoid")
                    if oRoot and oHum and oHum.Health > 0 then
                        if (oRoot.Position - mRoot.Position).Magnitude <= 350 then
                            oRoot.CFrame = mRoot.CFrame
                            oHum.WalkSpeed = 0
                            oHum.JumpPower = 0
                            oHum.PlatformStand = true
                        end
                    end
                end
                humanoid.PlatformStand = false
                rootPart.CFrame = mRoot.CFrame + Vector3.new(0, 6, 0)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
            end
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

return {
    Init = function()
        task.spawn(InitializeFastAttack)
        task.spawn(function()
            while task.wait(0.1) do ProcessCombatAndMovement() end
        end)
    end
}
