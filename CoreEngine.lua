local P, R, T, S = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("TweenService"), game:GetService("RunService")
local L = P.LocalPlayer
local C = R:WaitForChild("Remotes"):WaitForChild("CommF_", 999)
local A = R:WaitForChild("Remotes"):WaitForChild("Validator", 10)

return {
    StartMasterBrain = function(F, Lvl, I)
        task.spawn(function()
            local tAtk = 0
            local V = pcall(function() return game:GetService("VirtualInputManager") end) and game:GetService("VirtualInputManager") or nil
            while task.wait(0.04) do
                pcall(function()
                    local ch = L.Character
                    local bp = L.Backpack
                    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end
                    if bp and not ch:FindFirstChildOfClass("Tool") then
                        for _, tp in pairs(bp:GetChildren()) do
                            if tp:IsA("Tool") and (tp.ToolTip == "Melee" or tp.ToolTip == "Sword" or tp.ToolTip == "Blox Fruit") then
                                ch.Humanoid:EquipTool(tp)
                                break
                            end
                        end
                    end
                    local en = workspace:FindFirstChild("Enemies")
                    if en then
                        for _, e in pairs(en:GetChildren()) do
                            local eh, hm = e:FindFirstChild("HumanoidRootPart"), e:FindFirstChild("Humanoid")
                            if eh and hm and hm.Health > 0 and (ch.HumanoidRootPart.Position - eh.Position).Magnitude < 80 then
                                if tick() - tAtk >= 0.06 then
                                    tAtk = tick()
                                    ch.HumanoidRootPart.CFrame = eh.CFrame * CFrame.new(0, 0, 3)
                                    if V then
                                        V:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                        V:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                    end
                                    if A then A:FireServer(eh.Position) end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        pcall(function()
            if Lvl and type(Lvl.Run) == "function" then Lvl.Run() end
        end)
    end
}
