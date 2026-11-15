local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
local CommF = Remotes and Remotes:FindFirstChild("CommF_")
local RegisterHit = Remotes and Remotes:FindFirstChild("RegisterHit")

local function GetQuestData()
    pcall(function()
        if not CommF then return end
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local mainUI = playerGui and playerGui:FindFirstChild("Main")
        local questFrame = mainUI and mainUI:FindFirstChild("Quest")
        if questFrame and questFrame.Visible then
            local container = questFrame:FindFirstChild("Container")
            local titleBox = container and container:FindFirstChild("QuestTitle")
            if titleBox then
                return titleBox.Text
            end
        end
    end)
    return nil
end

local function AutoQuest()
    pcall(function()
        if not CommF then return end
        local level = LocalPlayer.Data and LocalPlayer.Data.Level and LocalPlayer.Data.Level.Value or 1
        local currentQuest = GetQuestData()
        
        if not currentQuest or currentQuest == "" then
            if level >= 1 and level <= 9 then
                CommF:InvokeServer("StartQuest", "BanditQuest1", 1)
            elseif level >= 10 and level <= 14 then
                CommF:InvokeServer("StartQuest", "JungleQuest", 1)
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
            if not character:FindFirstChildOfClass("Tool") then
                local anyTool = backpack:FindFirstChildOfClass("Tool")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if anyTool and humanoid then humanoid:EquipTool(anyTool) end
            end
        end
    end)
end

-- Hook FastAttack chuẩn xác giúp quái nhận damage thực tế từ Server
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
                            local hits = {...}
                            if RegisterHit and #hits > 0 then
                                pcall(function()
                                    RegisterHit:FireServer(hits[1], hits[2])
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

local function GetNearestEnemy(rootPos)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    local nearest, minDist = nil, math.huge
    for _, mob in ipairs(enemies:GetChildren()) do
        local mRoot = mob:FindFirstChild("HumanoidRootPart")
        local mHum = mob:FindFirstChild("Humanoid")
        if mRoot and mHum and mHum.Health > 0 then
            local dist = (mRoot.Position - rootPos).Magnitude
            if dist < minDist and dist <= 350 then
                minDist = dist
                nearest = mob
            end
        end
    end
    return nearest
end

return {
    Init = function()
        task.spawn(InitializeFastAttack)
        
        task.spawn(function()
            while true do
                task.spawn(AutoQuest)
                task.wait(2)
            end
        end)
        
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0,0))
        end)

        RunService.Heartbeat:Connect(function()
            pcall(function()
                EquipBestWeapon()
                local character = LocalPlayer.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                local humanoid = character and character:FindFirstChild("Humanoid")
                local enemies = Workspace:FindFirstChild("Enemies")
                if not rootPart or not humanoid or not enemies then return end

                local targetMob = GetNearestEnemy(rootPart.Position)
                if targetMob then
                    local mRoot = targetMob:FindFirstChild("HumanoidRootPart")
                    local mHum = targetMob:FindFirstChild("Humanoid")
                    if mRoot and mHum and mHum.Health > 0 then
                        -- Gom quái mượt mà, khóa cố định tránh bay nhảy lung tung
                        for _, mob in ipairs(enemies:GetChildren()) do
                            local oRoot = mob:FindFirstChild("HumanoidRootPart")
                            local oHum = mob:FindFirstChild("Humanoid")
                            if oRoot and oHum and oHum.Health > 0 and mob ~= targetMob then
                                local distToPlayer = (oRoot.Position - rootPart.Position).Magnitude
                                if distToPlayer <= 120 then
                                    oRoot.CFrame = mRoot.CFrame
                                    oRoot.Anchored = true
                                    oHum.PlatformStand = true
                                end
                            end
                        end
                        
                        humanoid.PlatformStand = false
                        local targetCFrame = mRoot.CFrame * CFrame.new(0, 6.5, 0)
                        local distanceToTarget = (rootPart.Position - targetCFrame.Position).Magnitude
                        
                        -- Di chuyển mượt bằng Tween tốc độ cao, đến nơi khóa cứng không giật
                        if distanceToTarget > 6 then
                            local info = TweenInfo.new(distanceToTarget / 400, Enum.EasingStyle.Linear)
                            local tween = TweenService:Create(rootPart, info, {CFrame = targetCFrame})
                            tween:Play()
                        else
                            rootPart.CFrame = targetCFrame
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                else
                    targetMob = nil
                end

                -- Ép tốc độ đánh cực đại (Fast Attack siêu nhanh không delay)
                pcall(function()
                    local combatFramework = ReplicatedStorage:FindFirstChild("CombatFramework")
                    if combatFramework then
                        local CFModule = require(combatFramework)
                        local AC = debug.getupvalue(CFModule, 2)
                        if AC and AC.activeController then
                            AC.activeController.timeToNextAttack = 0
                            AC.activeController.hitboxMagnitude = 180
                            AC.activeController.isEquipped = true
                            AC.activeController.focusMob = targetMob
                            if targetMob then
                                AC.activeController:attack()
                                -- Kích hoạt thêm nhịp đúp để đẩy tốc độ lên 3-4 phát/giây
                                local weaponController = AC.activeController
                                if weaponController.master and weaponController.master.attack then
                                    pcall(function()
                                        weaponController:attack()
                                    end)
                                end
                            end
                        end
                    end
                end)
            end)
        end)
    end
}
