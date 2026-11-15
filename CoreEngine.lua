-- CoreEngine.lua
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local KaitunState = {
    IsRaidRunning = false,
    IsBusyWithCriticalTask = false,
    CurrentTask = "Initializing"
}

local idledConnection
if LocalPlayer then
    idledConnection = LocalPlayer.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0, 0))
        end)
    end)
end

local function ServerHop()
    pcall(function()
        local httpService = game:GetService("HttpService")
        local success, req = pcall(function()
            return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        end)
        if not success or not req then return end
        
        local decodeSuccess, body = pcall(function()
            return httpService:JSONDecode(req)
        end)
        if not decodeSuccess or not body or not body.data then return end

        local servers = {}
        for _, s in pairs(body.data) do
            if type(s) == "table" and s.playing and s.maxPlayers and s.id then
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end

local function StartMasterBrain(fruitModule, levelModule, itemModule)
    task.spawn(function()
        while true do
            pcall(function()
                if KaitunState.IsRaidRunning then
                    KaitunState.CurrentTask = "Running Raid & Dungeons"
                    task.wait(1)
                    return
                end

                if fruitModule and type(fruitModule.CheckInventoryAndTriggerRaid) == "function" then
                    pcall(function()
                        fruitModule.CheckInventoryAndTriggerRaid(KaitunState)
                    end)
                end

                if not KaitunState.IsBusyWithCriticalTask and itemModule then
                    if type(itemModule.CheckLegendaryItemsAndQuests) == "function" then
                        pcall(function()
                            itemModule.CheckLegendaryItemsAndQuests(KaitunState)
                        end)
                    end
                    if type(itemModule.FightingStyleProgression) == "function" then
                        pcall(function()
                            itemModule.FightingStyleProgression(KaitunState)
                        end)
                    end
                end

                if not KaitunState.IsBusyWithCriticalTask and levelModule then
                    if type(levelModule.ExecuteLevelFarm) == "function" then
                        pcall(function()
                            levelModule.ExecuteLevelFarm(KaitunState)
                        end)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end

return {
    KaitunState = KaitunState,
    ServerHop = ServerHop,
    StartMasterBrain = StartMasterBrain
}
