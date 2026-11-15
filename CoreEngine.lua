local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
local RegisterHit = Remotes and Remotes:FindFirstChild("RegisterHit")

local Engine = {
    Config = {
        ActiveTask = "None",
        TargetCFrame = nil,
        BringMobEnabled = true,
        FastAttackEnabled = true,
        BringRange = 120
    }
}

local currentTween = nil
local lastHitTick = 0
local HIT_COOLDOWN = 0.05

local function InitializeFastAttack()
    pcall(function()
        local combatFramework = ReplicatedStorage:WaitForChild("CombatFramework", 5)
        if combatFramework then
            local CF = require(combatFramework)
            local CFR = rawget(CF, "activeController")
            if CFR and CFR.attack then
                for _, v in pairs(debug.getupvalues(CFR.attack)) do
                    if type(v) == "table" and rawget(v, "CHIT") then
                        local oldHit = v.CHIT
                        v.CHIT = function(self, ...)
                            if not Engine.Config.FastAttackEnabled then
                                return oldHit(self, unpack({...}))
                            end
                            local hits = {...}
                            local currentTime = tick()
                            if RegisterHit and #hits > 0 and (currentTime - lastHitTick >= HIT_COOLDOWN) then
                                lastHitTick = currentTime
                                pcall(function()
                                    for _, hitPart in ipairs(hits) do
                                        if typeof(hitPart) == "Instance" and hitPart:IsA("BasePart") then
                                            RegisterHit:FireServer(hitPart, {hitPart})
                                        end
                                    end
                                end)
                            end
                            return oldHit(self, unpack(hits))
                        end
                    end
                end
            end
        end
    end)
end

local function EquipBestWeapon()
    pcall(function()
        local character = LocalPlayer.Character
        local backpack = LocalPlayer.Backpack
        if not character or not backpack then return end
        if not character:FindFirstChildOfClass("Tool") then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword" or tool.ToolTip == "Blox Fruit" or tool.ToolTip == "Gun") then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:EquipTool(tool) break end
                end
            end
        end
    end)
end

local function ProcessMovementAndBring()
    pcall(function()
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")
        local enemies = Workspace:FindFirstChild("Enemies")
        if not rootPart or not humanoid then return end

        if Engine.Config.TargetCFrame then
            humanoid.PlatformStand = true
            local distance = (rootPart.Position - Engine.Config.TargetCFrame.Position).Magnitude
            
            if distance > 25 then
                if not currentTween or currentTween.PlaybackState ~= Enum.PlaybackState.Playing then
                    if currentTween then currentTween:Cancel() end
                    local speed = 300
                    local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
                    currentTween = TweenService:Create(rootPart, info, {CFrame = Engine.Config.TargetCFrame})
                    currentTween:Play()
                end
            else
                if currentTween then
                    currentTween:Cancel()
                    currentTween = nil
                end
                rootPart.CFrame = Engine.Config.TargetCFrame
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        else
            if currentTween then
                currentTween:Cancel()
                currentTween = nil
            end
            humanoid.PlatformStand = false
        end

        if Engine.Config.BringMobEnabled and enemies and rootPart then
            local primaryTarget = nil
            for _, mob in ipairs(enemies:GetChildren()) do
                local mHum = mob:FindFirstChild("Humanoid")
                local mRoot = mob:FindFirstChild("HumanoidRootPart")
                if mHum and mRoot and mHum.Health > 0 then
                    if (mRoot.Position - rootPart.Position).Magnitude <= Engine.Config.BringRange then
                        primaryTarget = mob
                        break
                    end
                end
            end

            local pRoot = primaryTarget and primaryTarget:FindFirstChild("HumanoidRootPart")
            if pRoot then
                for _, mob in ipairs(enemies:GetChildren()) do
                    if mob ~= primaryTarget then
                        local mRoot = mob:FindFirstChild("HumanoidRootPart")
                        local mHum = mob:FindFirstChild("Humanoid")
                        if mRoot and mHum and mHum.Health > 0 then
                            local dist = (mRoot.Position - rootPart.Position).Magnitude
                            if dist <= Engine.Config.BringRange then
                                mRoot.CFrame = pRoot.CFrame
                                mRoot.Anchored = true
                                mHum.PlatformStand = true
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function ProcessCombat()
    pcall(function()
        if not Engine.Config.FastAttackEnabled then return end
        local combatFramework = ReplicatedStorage:FindFirstChild("CombatFramework")
        if combatFramework then
            local CFModule = require(combatFramework)
            local AC = debug.getupvalue(CFModule, 2)
            if AC and AC.activeController then
                AC.activeController.timeToNextAttack = 0
                AC.activeController.hitboxMagnitude = 180
                AC.activeController.isEquipped = true
                AC.activeController:attack()
                if AC.activeController.master and AC.activeController.master.attack then
                    pcall(function()
                        AC.activeController:attack()
                    end)
                end
            end
        end
    end)
end

function Engine.SetTarget(cframe, taskName)
    Engine.Config.TargetCFrame = cframe
    Engine.Config.ActiveTask = taskName or "Custom"
end

function Engine.ClearTarget()
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    Engine.Config.TargetCFrame = nil
    Engine.Config.ActiveTask = "None"
end

function Engine.Init()
    task.spawn(InitializeFastAttack)
    
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)

    RunService.Heartbeat:Connect(function()
        EquipBestWeapon()
        ProcessMovementAndBring()
        ProcessCombat()
    end)
    
    return Engine
end

return Engine
