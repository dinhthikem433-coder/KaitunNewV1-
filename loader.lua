local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local BaseURL = "https://raw.githubusercontent.com/dinhthikem433-coder/KaitunNewV1-/main/"

local function LoadModule(fileName)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(BaseURL .. fileName))()
    end)
    if success and result then
        return result
    else
        return {}
    end
end

local AutoLevel         = LoadModule("AutoLevel.lua")
local CoreEngine        = LoadModule("CoreEngine.lua")
local FruitManagement   = LoadModule("FruitManagement.lua")
local InterfaceUI       = LoadModule("InterfaceUI.lua")
local ItemQuests        = LoadModule("ItemQuests.lua")
local RaidManager       = LoadModule("RaidManager.lua")

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
        pcall(function() if InterfaceUI and InterfaceUI.Init then task.spawn(InterfaceUI.Init) end end)
        pcall(function() if FruitManagement and FruitManagement.Run then task.spawn(FruitManagement.Run) end end)
        pcall(function() if CoreEngine and CoreEngine.Init then task.spawn(CoreEngine.Init) end end)

        task.spawn(function()
            while task.wait(0.5) do
                pcall(function()
                    local dt = LocalPlayer:FindFirstChild("Data")
                    local lv = dt and dt:FindFirstChild("Level") and dt.Level.Value or 1

                    if lv >= 1100 and HasSpareFruitForRaid() then
                        pcall(function()
                            if RaidManager and RaidManager.Run then
                                RaidManager.Run()
                            end
                        end)
                        return
                    end

                    if AutoLevel and AutoLevel.Run and not AutoLevel.IsRunning then
                        AutoLevel.IsRunning = true
                        task.spawn(function()
                            AutoLevel.Run()
                        end)
                    end

                    if lv >= 1500 and lv <= 2800 then
                        if ItemQuests and ItemQuests.Run and not ItemQuests.IsRunning then
                            ItemQuests.IsRunning = true
                            task.spawn(function()
                                ItemQuests.Run()
                            end)
                        end
                    end
                end)
            end
        end)
    end
}
