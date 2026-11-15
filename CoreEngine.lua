local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- FastAttack chuẩn chỉnh theo cấu trúc script lớn (Hook CombatFramework ActiveController)
local function InitializeFastAttack()
    pcall(function()
        local CombatFramework = require(ReplicatedStorage:WaitForChild("CombatFramework"))
        local CombatFrameworkR = rawget(CombatFramework, "activeController")
        if CombatFrameworkR then
            for _, v in pairs(debug.getupvalues(CombatFrameworkR.attack)) do
                if type(v) == "table" and rawget(v, "CHIT") then
                    local oldHit = v.CHIT
                    v.CHIT = function(self, ...)
                        return oldHit(self, ...)
                    end
                end
            end
        end
    end)
end

local function GetNearestEnemy()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end

    local nearest, minDist = nil, math.huge
    for _, mob in ipairs(enemies:GetChildren()) do
        local mRoot = mob:FindFirstChild("HumanoidRootPart")
        local mHum = mob:FindFirstChild("Humanoid")
        if mRoot and mHum and mHum.Health > 0 then
            local dist = (mRoot.Position - rootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = mob
            end
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
                -- Bring Mobs: Gom tất cả quái trong bán kính 350 studs đè bẹp vào vị trí quái mục tiêu, khóa cứng chân quái
                for _, mob in ipairs(enemies:GetChildren()) do
                    local otherRoot = mob:FindFirstChild("HumanoidRootPart")
                    local otherHum = mob:FindFirstChild("Humanoid")
                    if otherRoot and otherHum and otherHum.Health > 0 then
                        if (otherRoot.Position - mRoot.Position).Magnitude <= 350 then
                            otherRoot.CFrame = mRoot.CFrame
                            otherHum.WalkSpeed = 0
                            otherHum.JumpPower = 0
                            otherHum.PlatformStand = true
                        end
                    end
                end

                -- Bay lơ lửng sát đầu chuẩn xác (Sửa lỗi đứng cơ, giữ chân cẳng linh hoạt không bị đơ)
                humanoid.PlatformStand = false -- Giữ trạng thái linh hoạt, không bị cứng khớp chân
                rootPart.CFrame = mRoot.CFrame + Vector3.new(0, 6, 0)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
            end
        end

        -- Gọi FastAttack hệ thống ngầm liên tục không giới hạn tốc độ
        pcall(function()
            local CombatFramework = require(ReplicatedStorage:WaitForChild("CombatFramework"))
            local AC = debug.getupvalue(CombatFramework, 2)
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
            while task.wait(0.1) do
                ProcessCombatAndMovement()
            end
        end)
    end
}
