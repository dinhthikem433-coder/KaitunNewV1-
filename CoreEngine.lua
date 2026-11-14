-- [File: CoreEngine.lua]
local CoreEngine = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

CoreEngine.Speed = 320
CoreEngine.Offset = Vector3.new(0, 15, 0)

function CoreEngine:GetRootPart()
    local character = LocalPlayer.Character
    if character then
        return character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

function CoreEngine:FastTween(targetCFrame)
    local rootPart = self:GetRootPart()
    if not rootPart then return end
    
    local adjustedTarget = targetCFrame + self.Offset
    local distance = (rootPart.Position - adjustedTarget.Position).Magnitude
    local travelTime = distance / CoreEngine.Speed
    
    local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(adjustedTarget.Position)})
    
    tween:Play()
    return tween
end

function CoreEngine:BringMobs(targetPosition, mobName)
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") then
            local humanoid = mob:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                mob.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
            end
        end
    end
end

function CoreEngine:InitAntiAfk()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

return CoreEngine
