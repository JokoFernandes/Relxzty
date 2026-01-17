local args = {
    "JanjiJiwa"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("Job"):FireServer(unpack(args))
task.wait(1)
local Players = game:GetService("Players")

local function goto(target)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Tween info
local tweenInfo = TweenInfo.new(
    10, -- durasi (detik)
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

-- Goal: terbang ke target
local goal = {
    CFrame = target.CFrame + Vector3.new(0, 10, 0) -- misalnya agak di atas target
}

-- Buat tween
local tween = TweenService:Create(root, tweenInfo, goal)

-- Supaya player bisa gerak lagi setelah tween selesai
tween.Completed:Connect(function()
    root.Anchored = false
end)

-- Anchor dulu biar tween nggak bentrok sama physics
root.Anchored = true
tween:Play()
end

goto(workspace.Etc.Waypoint.Waypoint)
task.wait(11)
local delay = getgenv().delay
task.spawn(function()
while true do
-- make
local args = {
    "GetCoffee"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer(unpack(args))
task.wait(16)
-- deliver
local args = {
    "Delivery"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer(unpack(args))

for i , v in ipairs(workspace.NPC:GetChildren()) do
if v:IsA("Model") then
v:Destroy()
end
end
task.wait(delay)
end
end)
