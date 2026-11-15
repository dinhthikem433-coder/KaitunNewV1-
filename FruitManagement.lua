local P, R = game:GetService("Players"), game:GetService("ReplicatedStorage")
local L = P.LocalPlayer
local C = R:WaitForChild("Remotes"):WaitForChild("CommF_", 999)

return {
    Run = function()
        task.spawn(function()
            while task.wait(2) do
                pcall(function()
                    local char = L.Character
                    local bp = L.Backpack
                    if char then
                        for _, itm in ipairs(char:GetChildren()) do
                            if itm:IsA("Tool") and itm.ToolTip == "Blox Fruit" then
                                C:InvokeServer("StoreFruit", itm.Name)
                            end
                        end
                    end
                    if bp then
                        for _, itm in ipairs(bp:GetChildren()) do
                            if itm:IsA("Tool") and itm.ToolTip == "Blox Fruit" then
                                C:InvokeServer("StoreFruit", itm.Name)
                            end
                        end
                    end
                end)
            end
        end)
    end
}
