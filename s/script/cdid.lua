local args = {
	"JanjiJiwa"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("Job"):FireServer(unpack(args))
local running = true
-- goto
task.wait(4)
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local target = workspace.Etc.Waypoint.Waypoint

local TweenService = game:GetService("TweenService")

local goal = {}
goal.CFrame = CFrame.new(target.CFrame.Position)

local info = TweenInfo.new(
    30,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local tween = TweenService:Create(hrp, info, goal)
tween:Play()
-- fix args
game.ReplicatedStorage.NetworkContainer.RemoteEvents.Job:FireServer("JanjiJiwa")
-- NPC folder 
local npcFolder = game.Workspace:WaitForChild("NPC")


spawn(function()
    while running do
        
        -- GET COFFEE
        local args = {
	"GetCoffee"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer(unpack(args))

        task.wait(16)

        -- DELIVERY
        local args = {
	"Delivery"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer(unpack(args))

        -- DELETE NPC
        for _, npc in ipairs(npcFolder:GetChildren()) do
            npc:Destroy()
        end

        task.wait(0.5)
    end
end)

while true do
	local HttpService = game:GetService("HttpService")
        local WEBHOOK = "https://discord.com/api/webhooks/1441305379425226783/DxcnGuxHEtbl2iMnCNSGMR2cpgexUdkdLq7J5qBOR5If-BJZ29HJxOgkfe7whot7xZ2L"

        local message = _G.userm.PlayerGui.Main.Container.Hub.CashFrame.Frame.TextLabel.Text

        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                content = "@here" .. _G.name .. " Money: " .. message
            })
        })
end
