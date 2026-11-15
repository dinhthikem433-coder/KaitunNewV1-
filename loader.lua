local O, R, B = "dinhthikem433-coder", "KaitunNewV1-", "main"
local function LoadM(f)
    local s, r = pcall(function() return game:HttpGet(("https://raw.githubusercontent.com/%s/%s/%s/%s.lua"):format(O, R, B, f)) end)
    if s and r then
        local c, e = loadstring(r)
        if c then
            local ok, m = pcall(c)
            if ok then return m end
        end
    end
end
local UI, Engine, Fruit, Level, Item = LoadM("InterfaceUI"), LoadM("CoreEngine"), LoadM("FruitManagement"), LoadM("AutoLevel"), LoadM("ItemQuests")
if type(UI) == "function" then pcall(UI) end
if Engine and type(Engine.StartMasterBrain) == "function" then Engine.StartMasterBrain(Fruit, Level, Item) end
