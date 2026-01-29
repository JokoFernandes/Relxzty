local Player = game:GetService("Players")
local looping = 0
if not getgenv().ReaderLoaded then
getgenv().ReaderLoaded = true

local HttpService = game:GetService("HttpService")
local del = getgenv().DelaySend or 15
local delay = del / 2
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local maxCount = getgenv().MaxCount or 4
local char = player.Character or player.CharacterAdded:Wait()
char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(5637.63574, -904.970215, 15352.915, -0.77629143, 2.27446044e-08, -0.630374193, 1.00332525e-08, 1, 2.3725395e-08, 0.630374193, 1.20931185e-08, -0.77629143)
task.wait()
char:WaitForChild("HumanoidRootPart").Anchored = true
local source = game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/s/script/Notif.lua")
getgenv().MaxCount = getgenv().MaxCount
getgenv().DelaySend = getgenv().DelaySend
queue_on_teleport(
   getgenv().MaxCount = getgenv().MaxCount
getgenv().DelaySend = getgenv().DelaySend
   source
)
task.spawn(function()
   task.wait(3)
   char:WaitForChild("HumanoidRootPart").Anchored = false
end)
      
while true do
for _, crystal in ipairs(workspace.Islands["Crystal Depths"].Crystals:GetChildren()) do
   if crystal:IsA("MeshPart") and crystal:FindFirstChildWhichIsA("ProximityPrompt", true) then
        local datawh = {
        ["embeds"] = {
            {
                ["title"] = "Crystal Detected",
                ["description"] = "||@here|| <:shut:1432612191064031252>",
                ["color"] = 16711680,
                ["thumbnail"] = {
                    ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["fields"] = {
                    {["name"]="Crystal Spawned Copy to tp",["value"]="```game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(".. tostring(crystal.CFrame.Position).. ")```",["inline"]=false},
                    {["name"]="Fire Prompt",["value"]="```fireproximityprompt(".. tostring(crystal:GetFullName()).. ")```",["inline"]=false}
                },
                ["footer"] = {
                    ["text"] = "Loop:" .. tostring(looping) .. "Place: " .. game.JobId,
                    ["icon_url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }
  request({
                Url = "https://discord.com/api/webhooks/1441305375574851635/YV0xu1N8-KCGr1WV9x0RwsWiQD48Kxlg3qKd5C1DvS-K1ejfgKGYNY3NE_zQGcx_Bj8G",
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(datawh)
        })
        looping = looping + 1
        task.wait()
        if looping >= maxCount then
            local datarj = {
        ["embeds"] = {
            {
                ["title"] = "Rejoin...",
                ["description"] = player.Name,
                ["color"] = 16711680,
                ["thumbnail"] = {
                    ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["footer"] = {
                    ["text"] = "Loop:" .. tostring(looping) .. "Place: " .. game.JobId,
                    ["icon_url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }
        request({
                Url = "https://discord.com/api/webhooks/1441305375574851635/YV0xu1N8-KCGr1WV9x0RwsWiQD48Kxlg3qKd5C1DvS-K1ejfgKGYNY3NE_zQGcx_Bj8G",
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(datarj)
        })
        
           local ts = game:GetService("TeleportService")
           local p = game:GetService("Players").LocalPlayer
           ts:Teleport(game.PlaceId, p)
        end
        task.wait(delay)
        break
    end
end
task.wait(delay)
end
end
