local P, R = game:GetService("Players"), game:GetService("ReplicatedStorage")
local L = P.LocalPlayer
local A = R:WaitForChild("Remotes"):WaitForChild("Validator", 10)

return {
    StartMasterBrain = function(FruitModule, AutoLevelModule, ItemModule)
        task.spawn(function()
            local tAtk = 0
            local V = pcall(function() return game:GetService("VirtualInputManager") end) and game:GetService("VirtualInputManager") or nil
            
            while task.wait(0.02) do
                pcall(function()
                    local ch = L.Character
                    local bp = L.Backpack
                    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = ch.HumanoidRootPart
                    local hum = ch:FindFirstChild("Humanoid")

                    if not ch:FindFirstChild("Buso") then game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("Buso") end

                    if bp and not ch:FindFirstChildOfClass("Tool") then
                        for _, tp in pairs(bp:GetChildren()) do
                            if tp:IsA("Tool") and (tp.ToolTip == "Melee" or tp.ToolTip == "Sword") then
                                hum:EquipTool(tp)
                                break
                            end
                        end
                    end

                    local en = workspace:FindFirstChild("Enemies")
                    if en then
                        for _, e in pairs(en:GetChildren()) do
                            local ehrp = e:FindFirstChild("HumanoidRootPart")
                            local hm = e:FindFirstChild("Humanoid")
                            if ehrp and hm and hm.Health > 0 then
                                local dist = (hrp.Position - ehrp.Position).Magnitude
                                if dist < 350 then
                                    ehrp.CFrame = hrp.CFrame * CFrame.new(0, -2, 0)
                                    ehrp.CanCollide = false
                                    if hm:FindFirstChild("Animator") then
                                        pcall(function() hm.Animator:Destroy() end)
                                    end
                                    hm.PlatformStand = true
                                    hm.WalkSpeed = 0
                                    hm.JumpPower = 0

                                    if tick() - tAtk >= 0.03 then
                                        tAtk = tick()
                                        if V then
                                            V:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                            V:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                        end
                                        if A then A:FireServer(ehrp.Position) end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)

        pcall(function()
            if AutoLevelModule and type(AutoLevelModule.Run) == "function" then AutoLevelModule.Run() end
            if FruitModule and type(FruitModule.Run) == "function" then FruitModule.Run() end
            if ItemModule and type(ItemModule.Run) == "function" then ItemModule.Run() end
        end)
    end
}
