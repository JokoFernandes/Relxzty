-- SCREEN GUI
local ui = Instance.new("ScreenGui")
ui.ResetOnSpawn = false
ui.Parent = game:GetService("CoreGui")
ui.Name = "Asep Store"
local player = game.Players.LocalPlayer
local hrp = player.Character:WaitForChild("HumanoidRootPart")
-- config
local bgTransparency = 0.8
local buttonTransparency = 0.5
local buttonBrdr = Color3.fromRGB(255,255,255)
local bgBrdr = Color3.fromRGB(255,255,255)
local bgrd = Color3.fromRGB(38, 0, 95)
local buttonColor = Color3.fromRGB(55, 0, 173)
-- WINDOW
local window = Instance.new("Frame", ui)
window.BorderSizePixel = 2
window.BorderMode = Enum.BorderMode.Outline
window.BorderColor3 = Color3.fromRGB(255, 255, 255)
window.Size = UDim2.new(0, 620, 0, 360)
window.Position = UDim2.new(0.5, -310, 0.5, -180)
window.BackgroundColor3 = bgrd
window.Active = true
window.BackgroundTransparency = 0.3

-- ✅ INI PENGGANTI window.CornerRadius
local corner = Instance.new("UICorner", window)
corner.CornerRadius = UDim.new(0, 10)

-- TITLE (DRAG HANDLE)
local title = Instance.new("TextLabel", window)
local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 10)
title.BackgroundTransparency = bgTransparency
title.Size = UDim2.new(1,0,0,35)
title.Text = "Asep Exploit"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = bgrd
title.Active = true

----------------------------------------------------
-- ✅ DRAG HANYA DARI TITLE
----------------------------------------------------
local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = window.Position
	end
end)

title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		window.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
----------------------------------------------------
-- ✅ PANEL KIRI (TIDAK SCROLL)
----------------------------------------------------
local leftPanel = Instance.new("Frame", window)
local leftCorner = Instance.new("UICorner", leftPanel)
corner.CornerRadius = UDim.new(0, 10)
leftPanel.BackgroundTransparency = bgTransparency
leftPanel.Size = UDim2.new(0, 150, 1, -35)
leftPanel.Position = UDim2.new(0, 0, 0, 35)
leftPanel.BackgroundColor3 = bgrd

local menuList = {"Fishing", "Teleport", "Webhook", "Misc", "Fun Action"}

local buttons = {}

for i, name in ipairs(menuList) do
	local btn = Instance.new("TextButton", leftPanel)
	local btnCorner = Instance.new("UICorner", btn)
	btnCorner.CornerRadius = UDim.new(0, 10)
	btn.BackgroundTransparency = buttonTransparency
	btn.BorderSizePixel = 1
	btn.BorderColor3 = buttonBrdr
	btn.BorderMode = Enum.BorderMode.Outline
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i-1)*43)
	btn.Text = name
	btn.BackgroundColor3 = buttonColor
	btn.TextColor3 = Color3.fromRGB(255,255,255)

	buttons[name] = btn
end

----------------------------------------------------
-- ✅ PANEL KANAN (SCROLL / OVERFLOW)
----------------------------------------------------
local rightPanel = Instance.new("ScrollingFrame", window)
local rightCorner = Instance.new("UICorner", rightPanel)
rightCorner.CornerRadius = UDim.new(0, 10)
rightPanel.BackgroundTransparency = bgTransparency
rightPanel.Size = UDim2.new(1, -160, 1, -45)
rightPanel.Position = UDim2.new(0, 155, 0, 40)
rightPanel.CanvasSize = UDim2.new(0, 0, 0, 400)
rightPanel.ScrollBarThickness = 6
rightPanel.BackgroundColor3 = bgrd

----------------------------------------------------
-- ✅ PANEL Fishing
----------------------------------------------------
local toggle = false

local inputBox = Instance.new("TextBox", rightPanel)
local inputBoxCorner = Instance.new("UICorner", inputBox)
inputBoxCorner.CornerRadius = UDim.new(0, 10)
inputBox.BackgroundTransparency = buttonTransparency
inputBox.Size = UDim2.new(1, -20, 0, 40)
inputBox.Position = UDim2.new(0, 10, 0, 10)
inputBox.PlaceholderText = "Delay Fishing"
inputBox.Text = ""
inputBox.BackgroundColor3 = buttonColor
inputBox.TextColor3 = Color3.fromRGB(255,255,255)

local inputReel = Instance.new("TextBox", rightPanel)
local inputReelCorner = Instance.new("UICorner", inputReel)
inputReelCorner.CornerRadius = UDim.new(0, 10)
inputReel.BackgroundTransparency = buttonTransparency
inputReel.Size = UDim2.new(1, -20, 0, 40)
inputReel.Position = UDim2.new(0, 10, 0, 60)
inputReel.PlaceholderText = "Delay Reel"
inputReel.Text = ""
inputReel.BackgroundColor3 = buttonColor
inputReel.TextColor3 = Color3.fromRGB(255,255,255)

local toggleBtn = Instance.new("TextButton", rightPanel)
local toggleCorner = Instance.new("UICorner", toggleBtn)
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleBtn.BackgroundTransparency = buttonTransparency
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 110)
toggleBtn.Text = "Toggle Fishing: OFF"
toggleBtn.BackgroundColor3 = buttonColor
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)


toggleBtn.MouseButton1Click:Connect(function()
	toggle = not toggle
	toggleBtn.Text = "Toggle Fishing: " .. (toggle and "ON" or "OFF")

	task.spawn(function()
		while toggle do
			local delay = tonumber(inputBox.Text) or 1
			local delayreel = tonumber(inputReel.Text) or 1
			print("Fishing Loop Aktif, Delay:", delay, "reel", delayreel)
			task.wait(delay)
		end
	end)
end)
-- instant fishing
local titleText = Instance.new("TextLabel", rightPanel)
titleText.Name = "Instant Fishing"
titleText.Size = UDim2.new(1, 0, 0, 15)
titleText.Position = UDim2.new(0.5, 0, 0, 158)
titleText.AnchorPoint = Vector2.new(0.5, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Instant Fishing"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold

local instantFishing = Instance.new("TextBox", rightPanel)
local instantFishingCorner = Instance.new("UICorner", instantFishing)
instantFishingCorner.CornerRadius = UDim.new(0, 10)
instantFishing.BackgroundTransparency = buttonTransparency
instantFishing.Size = UDim2.new(1, -20, 0, 40)
instantFishing.Position = UDim2.new(0, 10, 0, 180)
instantFishing.PlaceholderText = "Delay Complete"
instantFishing.Text = ""
instantFishing.BackgroundColor3 = buttonColor
instantFishing.TextColor3 = Color3.fromRGB(255,255,255)

local toggelInstantFishing = false
local toggleInstant = Instance.new("TextButton", rightPanel)
local toggleInstantCorner = Instance.new("UICorner", toggleInstant)
toggleInstantCorner.CornerRadius = UDim.new(0, 10)
toggleInstant.BackgroundTransparency = buttonTransparency
toggleInstant.Size = UDim2.new(1, -20, 0, 40)
toggleInstant.Position = UDim2.new(0, 10, 0, 230)
toggleInstant.Text = "Toggle Fishing: OFF"
toggleInstant.BackgroundColor3 = buttonColor
toggleInstant.TextColor3 = Color3.fromRGB(255,255,255)

toggleInstant.MouseButton1Click:Connect(function()
	local instantDelay = tonumber(instantFishing.Text)
	toggelInstantFishing = not toggelInstantFishing
	toggleInstant.Text = "Toggle Fishing: " .. (toggelInstantFishing and "ON" or "OFF")
	task.spawn(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RFChargeFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
		RFChargeFishingRod:InvokeServer()
		task.wait(0.28)
		while true do
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Argument1 = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/RequestFishingMinigameStarted"]
			Argument1:InvokeServer(-1.233184814453125,0.8976325017669844,1764318083.535636)
			task.wait(1)
			
			local REFishingCompleted = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/FishingCompleted"]
			REFishingCompleted:FireServer()
			
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local REUpdateChargeState = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/UpdateChargeState"]
			firesignal(REUpdateChargeState.OnClientEvent)

			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local REUpdateChargeState = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/UpdateChargeState"]
			firesignal(REUpdateChargeState.OnClientEvent)
			
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local REUpdateChargeState = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/UpdateChargeState"]
			firesignal(REUpdateChargeState.OnClientEvent)

			task.wait()
			local RFChargeFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
			RFChargeFishingRod:InvokeServer()
		end
	end)
end)
----------------------------------------------------
-- ✅ PANEL Teleport
----------------------------------------------------
local places = {"Spawn", "Ancient Jungle", "Clasic Event","Clasic Event Cave", "Ancient Ruin", "Sacred Temple", "Syssipus","Treasure Island","Crater Island"}

local dropdown = Instance.new("TextButton", rightPanel)
local dropdownCorner = Instance.new("UICorner", dropdown)
dropdownCorner.CornerRadius = UDim.new(0, 10)
dropdown.Visible = false
dropdown.BackgroundColor3 = buttonColor
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdown.BackgroundTransparency = buttonTransparency
dropdown.Size = UDim2.new(1, -20, 0, 40)
dropdown.Position = UDim2.new(0, 10, 0, 10)
dropdown.Text = "Select Place"
dropdown.ZIndex = 2

local list = Instance.new("ScrollingFrame", rightPanel)
local listCorner = Instance.new("UICorner", list)
listCorner.CornerRadius = UDim.new(0, 10)
list.Visible = false
list.BackgroundTransparency = 0
list.Size = UDim2.new(1, -20, 0, 120) -- hanya 2 item
list.Position = UDim2.new(0, 10, 0, 41)
list.BackgroundColor3 = bgrd
list.Visible = false
list.ZIndex = 3
list.ClipsDescendants = true
list.CanvasSize = UDim2.new(0, 0, 0, #places * 50)
list.ScrollBarThickness = 6

dropdown.MouseButton1Click:Connect(function()
	list.Visible = not list.Visible
end)

for i, place in pairs(places) do
	local option = Instance.new("TextButton", list)
	local optionCorner = Instance.new("UICorner", option)
	optionCorner.CornerRadius = UDim.new(0, 10)
	option.Size = UDim2.new(1, 0, 0, 40) -- lebar penuh parent, tinggi 40px
	option.Position = UDim2.new(0, 0, 0, (i-1) * 42) -- jarak vertikal 42 supaya ada spasi antar item
	option.Text = place
	option.BackgroundTransparency = 0.7
	option.BackgroundColor3 = buttonColor
	option.BorderColor3 = Color3.fromRGB(255, 255, 255)
	option.BorderMode = Enum.BorderMode.Outline -- gunakan Enum yang benar
	option.BorderSizePixel = 6
	option.TextColor3 = Color3.fromRGB(255,255,255)
	option.ZIndex = 11

	option.MouseButton1Click:Connect(function()
		dropdown.Text = place
		list.Visible = false
	end)
end

local inputDelays = Instance.new("TextBox", rightPanel)
local inputDelaysCorner = Instance.new("UICorner", inputReel)
inputDelaysCorner.CornerRadius = UDim.new(0, 10)
inputDelays.BackgroundTransparency = buttonTransparency
inputDelays.Size = UDim2.new(1, -20, 0, 40)
inputDelays.Position = UDim2.new(0, 10, 0, 60)
inputDelays.PlaceholderText = "Fish"
inputDelays.Text = ""
inputDelays.BackgroundColor3 = buttonColor
inputDelays.TextColor3 = Color3.fromRGB(255,255,255)

local CountFun = Instance.new("TextBox", rightPanel)
local CountFunCorner = Instance.new("UICorner", inputReel)
CountFunCorner.CornerRadius = UDim.new(0, 10)
CountFun.BackgroundTransparency = buttonTransparency
CountFun.Size = UDim2.new(1, -20, 0, 40)
CountFun.Position = UDim2.new(0, 10, 0, 60)
CountFun.PlaceholderText = "Count"
CountFun.Text = ""
CountFun.BackgroundColor3 = buttonColor
CountFun.TextColor3 = Color3.fromRGB(255,255,255)

local inputWeight = Instance.new("TextBox", rightPanel)
local inputWeightCorner = Instance.new("UICorner", inputReel)
inputWeightCorner.CornerRadius = UDim.new(0, 10)
inputWeight.BackgroundTransparency = buttonTransparency
inputWeight.Size = UDim2.new(1, -20, 0, 40)
inputWeight.Position = UDim2.new(0, 10, 0, 60)
inputWeight.PlaceholderText = "Weight"
inputWeight.Text = ""
inputWeight.BackgroundColor3 = buttonColor
inputWeight.TextColor3 = Color3.fromRGB(255,255,255)

local inputFishId = Instance.new("TextBox", rightPanel)
local inputFishIdCorner = Instance.new("UICorner", inputReel)
inputFishIdCorner.CornerRadius = UDim.new(0, 10)
inputFishId.BackgroundTransparency = buttonTransparency
inputFishId.Size = UDim2.new(1, -20, 0, 40)
inputFishId.Position = UDim2.new(0, 10, 0, 60)
inputFishId.PlaceholderText = "ID"
inputFishId.Text = ""
inputFishId.BackgroundColor3 = buttonColor
inputFishId.TextColor3 = Color3.fromRGB(255,255,255)

local tpBtn = Instance.new("TextButton", rightPanel)
local tpCorner = Instance.new("UICorner", tpBtn)
tpBtn.Visible = false
tpCorner.CornerRadius = UDim.new(0, 10)
tpBtn.ZIndex = 1
tpBtn.BackgroundTransparency = buttonTransparency
tpBtn.Size = UDim2.new(1, -20, 0, 40)
tpBtn.Position = UDim2.new(0, 10, 0, 60)
tpBtn.Text = "Teleport"
tpBtn.BackgroundColor3 = buttonColor
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.MouseButton1Click:Connect(function()
	local selected = dropdown.Text

	-- contoh cek berdasarkan nama murni
	if selected == "Clasic Event" or selected == "Classic Event" then
		hrp.CFrame = CFrame.new(0, 10, 0)
		-- contoh teleport (ganti CFrame ke koordinat yang benar)
		-- local char = game.Players.LocalPlayer.Character
		-- if char and char.PrimaryPart then char:SetPrimaryPartCFrame(CFrame.new(x,y,z)) end

	elseif selected == "Ancient Jungle" then
		hrp.CFrame = CFrame.new(0, 10, 0)

	elseif selected == "Ancient Ruin" then
		hrp.CFrame = CFrame.new(0, 10, 0)

	elseif selected == "Shop" then
		hrp.CFrame = CFrame.new(0, 10, 0)

	elseif selected == "Spawn" then
		hrp.CFrame = CFrame.new(0, 100, 0)

	else
		-- jika tidak cocok
		print("Invalid place selected:", dropdown.Text)
	end
end)


-- ✅ MENU KIRI → MENGGANTI ISI KANAN
----------------------------------------------------
local function show(group)
	toggleBtn.Visible = false
	inputBox.Visible = false
	inputFishId.Visible = false
	tpBtn.Visible = false
	instantFishing.Visible = false 
	toggleInstant.Visible = false
	titleText.Visible = false
	inputReel.Visible = false
	dropdown.Visible = false
	list.Visible = false
	
	CountFun.Visible = false
	inputWeight.Visible = false 
	inputDelays.Visible = false
	task.wait(0.01)
	if group == "Teleport" then
		tpBtn.Visible = true
		dropdown.Visible = true
	end
	if group == "Fun Action" then
		print("s")
	end
	if group == "Misc" then
		print("S")
	end
	if group == "Fishing" then
		instantFishing.Visible = true 
		toggleInstant.Visible = true
		titleText.Visible = true
		toggleBtn.Visible = true
		inputBox.Visible = true
		inputReel.Visible = true
	end	
	if group == "Webhook" then
		print("s")
	end
end

buttons["Fishing"].MouseButton1Click:Connect(function()
	show("Fishing")
end)

buttons["Misc"].MouseButton1Click:Connect(function()
	show("Misc")
end)

buttons["Fun Action"].MouseButton1Click:Connect(function()
	show("Fun Action")
end)

buttons["Teleport"].MouseButton1Click:Connect(function()
	show("Teleport")
end)

buttons["Webhook"].MouseButton1Click:Connect(function()
	show("Webhook")
end)

-- BUTTON HIDE / SHOW
local hideBtn = Instance.new("TextButton", title)
local hideBtnCorner = Instance.new("UICorner", hideBtn)
hideBtnCorner.CornerRadius = UDim.new(0, 10)
hideBtn.Size = UDim2.new(0, 30, 1, 0)
hideBtn.Position = UDim2.new(1, -30, 0, 0)
hideBtn.Text = "-"
hideBtn.BackgroundColor3 = bgrd
hideBtn.TextColor3 = Color3.fromRGB(255,255,255)

local isHidden = false
local normalSize = window.Size

hideBtn.MouseButton1Click:Connect(function()
	isHidden = not isHidden

	if isHidden then
		title.Size = UDim2.new(1,200,150,35)
		leftPanel.Visible = false
		rightPanel.Visible = false
		window.Size = UDim2.new(0, 0, 0, 0)
		title.BackgroundTransparency = 0.1
		hideBtn.Text = "[ ]"
	else
		title.Size = UDim2.new(1,0,0,35)
		title.BackgroundTransparency = buttonTransparency - 0.1
		leftPanel.Visible = true
		rightPanel.Visible = true
		window.Size = normalSize
		hideBtn.Text = "-"
	end
end)

show("Fishing")
