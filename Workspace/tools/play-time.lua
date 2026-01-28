local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local timer = Instance.new("ScreenGui")
timer.Name = "Timer"
timer.Parent = gethui() -- ganti gethui() biar pasti muncul di studio

local time = Instance.new("TextLabel")
time.Parent = timer
time.Size = UDim2.new(0, 200, 0, 25)
time.Position = UDim2.new(0.13, 0, 0, 50)
time.Text = "Text"
time.BackgroundTransparency = 1
time.TextColor3 = Color3.fromRGB(255,255,255)
time.TextSize = 20

local remind = Instance.new("TextLabel")
remind.Parent = timer -- ✅ WAJIB biar kelihatan
remind.Text = ""
remind.Visible = false
remind.TextSize = 15
remind.Size = UDim2.new(0, 400, 0, 25)
remind.BackgroundTransparency = 1
remind.TextColor3 = Color3.fromRGB(255,255,255)
remind.Position = UDim2.new(0.13, 0, 0.50, 0) -- ✅ benerin parameternya

task.spawn(function()
	while true do
		local t = math.floor(workspace.DistributedGameTime)

		local jam = math.floor(t / 3600)
		local menit = math.floor((t % 3600) / 60)
		local detik = t % 60

		time.Text = jam .. " jam " .. menit .. " menit " .. detik .. " detik"

		if jam > 500 then
			remind.Visible = true
			remind.Text = "Take a break you've been playing too long"
		end

		task.wait(1)
	end
end)

task.wait(100)
timer:Destroy()
