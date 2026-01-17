-- get job
local args = {
    "JanjiJiwa"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("Job"):FireServer(unpack(args))
task.wait(2)
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

-- Goal
local goal = {
    CFrame = target.CFrame + Vector3.new(0, 10, 0) -- misalnya agak di atas target
}

-- Tween
local tween = TweenService:Create(root, tweenInfo, goal)

-- Supaya player bisa gerak lagi setelah tween selesai
tween.Completed:Connect(function()
    root.Anchored = false
end)

-- Anchor
root.Anchored = true
tween:Play()
end

goto(workspace.Etc.Waypoint.Waypoint)
task.wait(11)
local delay = getgenv().delay
-- work
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
-- webhook
task.spawn(function()
while true do 
local player = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")
local money = player.PlayerGui.Main.Container.Hub.CashFrame.Frame.TextLabel
local datawh = {
        ["embeds"] = {
            {
                ["title"] = player.Name,
                ["description"] = "||@here|| <:shut:1432612191064031252>",
                ["color"] = 16711680,
                ["thumbnail"] = {
                    ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["fields"] = {
                    {["name"]="Name",["value"]=player.Name,["inline"]=false},
                    {["name"]="Cash",["value"]=money.Text,["inline"]=false}
                },
                ["footer"] = {
                    ["text"] = "Place: " .. game.JobId,
                    ["icon_url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }
request({
Url = "https://discord.com/api/webhooks/1441305379425226783/DxcnGuxHEtbl2iMnCNSGMR2cpgexUdkdLq7J5qBOR5If-BJZ29HJxOgkfe7whot7xZ2L",
Method = "POST",
Headers = { ["Content-Type"] = "application/json" },
Body = HttpService:JSONEncode(datawh)
})
task.wait(16)
    end
end)
