-- FruitManagement.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

local function SafeTweenTo(targetCFrame)
    local success = pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        if distance < 15 then
            hrp.CFrame = targetCFrame
            return
        end
        local speed = 300
        local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
        
        tween:Play()
        local completed = false
        local connection
        connection = tween.Completed:Connect(function()
            completed = true
            if connection then connection:Disconnect() end
        end)
        
        local startTime = tick()
        while not completed and tick() - startTime < (distance / speed) + 2 do
            if not char.Parent or hum.Health <= 0 then
                tween:Cancel()
                if connection then connection:Disconnect() end
                break
            end
            task.wait(0.1)
        end
    end)
    return success
end

local function InstantCollectFruit(fruitInstance)
    pcall(function()
        if fruitInstance and fruitInstance:FindFirstChild("Handle") then
            local handle = fruitInstance.Handle
            SafeTweenTo(handle.CFrame + Vector3.new(0, 3, 0))
            task.wait(0.2)
            if handle and handle.Parent then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    firetouchinterest(char.HumanoidRootPart, handle, 0)
                    firetouchinterest(char.HumanoidRootPart, handle, 1)
                end
            end
        end
    end)
end

local function CheckInventoryAndTriggerRaid(stateTable)
    pcall(function()
        local dataFolder = LocalPlayer:FindFirstChild("Data") or LocalPlayer:FindFirstChild("leaderstats")
        if not dataFolder then return end
        local levelVal = dataFolder:FindFirstChild("Level")
        if not levelVal or type(levelVal.Value) ~= "number" or levelVal.Value < 1100 then return end
        if stateTable.IsBusyWithCriticalTask then return end

        local containers = {LocalPlayer.Backpack, LocalPlayer.Character}
        for _, container in ipairs(containers) do
            if container then
                for _, fruit in pairs(container:GetChildren()) do
                    if fruit:IsA("Tool") and fruit.Name:find("Fruit") then
                        local isMythical = false
                        local rarityAttr = fruit:GetAttribute("Rarity")
                        if rarityAttr and tonumber(rarityAttr) and tonumber(rarityAttr) >= 4 then
                            isMythical = true
                        elseif fruit:FindFirstChild("Rarity") and tonumber(fruit.Rarity.Value) and tonumber(fruit.Rarity.Value) >= 4 then
                            isMythical = true
                        end

                        if not isMythical then
                            InstantCollectFruit(fruit)
                            if CommF_ then
                                CommF_:InvokeServer("LoadRaid", fruit.Name)
                            end

                            if not stateTable.IsRaidRunning then
                                stateTable.IsRaidRunning = true
                            end
                        end
                    end
                end
            end
        end
    end)
end

return {
    InstantCollectFruit = InstantCollectFruit,
    CheckInventoryAndTriggerRaid = CheckInventoryAndTriggerRaid
}
