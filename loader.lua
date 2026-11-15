local BaseURL = "https://raw.githubusercontent.com/dinhthikem433-coder/KaitunNewV1-/main/"

local function LoadModule(fileName)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(BaseURL .. fileName))()
    end)
    return success and result or {}
end

local AutoLevel         = LoadModule("AutoLevel.lua")
local CoreEngine        = LoadModule("CoreEngine.lua")
local FruitManagement   = LoadModule("FruitManagement.lua")
local InterfaceUI       = LoadModule("InterfaceUI.lua")
local ItemQuests        = LoadModule("ItemQuests.lua")
local RaidManager       = LoadModule("RaidManager.lua")

return {
    Init = function()
        pcall(function() if InterfaceUI.Init then task.spawn(InterfaceUI.Init) end end)
        pcall(function() if FruitManagement.Run then task.spawn(FruitManagement.Run) end end)
        pcall(function() if CoreEngine.Init then task.spawn(CoreEngine.Init) end end)
        pcall(function() if AutoLevel.Run then task.spawn(AutoLevel.Run) end end)
        pcall(function() if ItemQuests.Run then task.spawn(ItemQuests.Run) end end)
        pcall(function() if RaidManager.Run then task.spawn(RaidManager.Run) end end)
    end
}
