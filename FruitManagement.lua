-- [File: FruitManagement.lua]
local FruitManagement = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function FruitManagement:IsFruitStored(fruitName)
    local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if remote then
        local success, result = pcall(function()
            return remote:InvokeServer("GetInventoryFruits")
        end)
        if success and type(result) == "table" then
            for _, storedFruit in pairs(result) do
                if storedFruit.Name == fruitName then
                    return true
                end
            end
        end
    end
    return false
end

function FruitManagement:AutoStoreInventory()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local character = LocalPlayer.Character
    local containers = {backpack, character}
    
    for _, container in pairs(containers) do
        if container then
            for _, item in pairs(container:GetChildren()) do
                if item:IsA("Tool") and item:FindFirstChild("Fruit") then
                    local fruitName = item.Name
                    if self:IsFruitStored(fruitName) then
                        item.Parent = nil 
                    else
                        local remote = ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                        if remote then
                            local storedSuccess = remote:InvokeServer("StoreFruit", fruitName)
                            if not storedSuccess then
                                task.wait(1)
                                remote:InvokeServer("StoreFruit", fruitName)
                            end
                        end
                    end
                end
            end
        end
    end
end

function FruitManagement:AutoRandomFruit()
    local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if remote then
        remote:InvokeServer("Cousin", "Buy")
    end
end

function FruitManagement:Run()
    task.spawn(function()
        while task.wait(10) do
            pcall(function()
                self:AutoStoreInventory()
                self:AutoRandomFruit()
            end)
        end
    end)
end

return FruitManagement
