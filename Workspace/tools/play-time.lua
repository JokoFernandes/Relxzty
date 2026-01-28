local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local timer = Instance.new("ScreenGui")
timer.Name = "Timer"
timer.Parent = gethui()

local time = Instance.new("TextLabel") -- benerin ejaan
time.Parent = timer -- WAJIB biar kelihatan
time.Size = UDim2.new(0, 50, 0, 25)
time.Position = UDim2.new(0.13, 0, 0, 50) -- turun 50px
time.Text = "Text"
time.BackgroundTransparency =1
time.TextColor3 = Color3.fromRGB(255,255,255)
time.TextSize = 20

task.spawn(function()
while true do
local t = math.floor(game.Workspace.DistributedGameTime)

local jam = math.floor(t / 3600)
local menit = math.floor((t % 3600) / 60)
local detik = t % 60

time.Text =jam .. "jam".. menit .. "menit" .. detik .. "detik"
task.wait(1)
end
end)
task.wait(10)
timer:Destroy()
