local P, R, W = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("Workspace")
local TP = game:GetService("TeleportService")
local TS = game:GetService("TweenService")
local L = P.LocalPlayer
local C = R:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

local function SafeCall(...)
    local success, err = pcall(C.InvokeServer, C, ...)
    return success and err
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

    local bv = root:FindFirstChild("KaitunRaidFlightBV")
    local bg = root:FindFirstChild("KaitunRaidFlightBG")

    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "KaitunRaidFlightBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.zero
        bv.Parent = root
    end

    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "KaitunRaidFlightBG"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = root.CFrame
        bg.Parent = root
    end

    hum.PlatformStand = true
    local dist = (root.Position - targetCFrame.Position).Magnitude
    local speed = 400
    local timeDist = math.clamp(dist / speed, 0.1, 3)

    local info = TweenInfo.new(timeDist, Enum.EasingStyle.Linear)
    local tween = TS:Create(root, info, {CFrame = targetCFrame})
    tween:Play()
end

local function StopFly()
    local ch = GetChar()
    local root = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChild("Humanoid")
    if root then
        local bv = root:FindFirstChild("KaitunRaidFlightBV")
        local bg = root:FindFirstChild("KaitunRaidFlightBG")
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
    if hum then hum.PlatformStand = false end
end

local function HasSpareFruitForRaid()
    local bp = L.Backpack
    local ch = L.Character
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

local function FastAttack(targetMob)
    pcall(function()
        local ch = GetChar()
        local root = GetRoot(ch)
        if not root or not targetMob then return end
        
        local mRoot = targetMob:FindFirstChild("HumanoidRootPart")
        local mHum = targetMob:FindFirstChild("Humanoid")
        if mRoot and mHum and mHum.Health > 0 then
            SmartFly(CFrame.new(mRoot.Position + Vector3.new(0, 15, 0)))
            sethiddenproperty(L, "SimulationRadius", math.huge)
            SafeCall("Attack", "Start")
        end
    end)
end

return {
    Run = function()
        task.spawn(function()
            while task.wait(0.5) do
                pcall(function()
                    local dt = L:FindFirstChild("Data")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1

                    if lv >= 1100 and HasSpareFruitForRaid() then
                        local raidRunning = SafeCall("Raid", "Check")
                        
                        if not raidRunning then
                            SafeCall("Raid", "Select", "Ice")
                            SafeCall("Raid", "Start")
                            task.wait(1)
                        else
                            local enemies = W:FindFirstChild("Enemies")
                            local target = nil
                            if enemies then
                                for _, mob in ipairs(enemies:GetChildren()) do
                                    local mHum = mob:FindFirstChild("Humanoid")
                                    if mHum and mHum.Health > 0 then
                                        target = mob
                                        break
                                    end
                                end
                            end

                            if target then
                                FastAttack(target)
                            else
                                StopFly()
                            end
                        end
                    else
                        StopFly()
                    end
                end)
            end
        end)
    end
}
