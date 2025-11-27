-- GUI EXECUTOR VERSION
local ui = Instance.new("ScreenGui")
ui.Parent = game.CoreGui

-- Window
local window = Instance.new("Frame", ui)
window.Size = UDim2.new(0, 240, 0, 300)
window.Position = UDim2.new(0.5, -120, 0.5, -150)
window.BackgroundColor3 = Color3.fromRGB(40,40,40)
window.Active = true

-- TITLE (Handle Drag)
local title = Instance.new("TextLabel", window)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Executor GUI"
title.BackgroundColor3 = Color3.fromRGB(60,60,60)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Active = true

---------------------------------------------------------
-- DRAG WINDOW DARI TITLE
---------------------------------------------------------
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

---------------------------------------------------------
-- TOGGLE (Loop)
---------------------------------------------------------
local toggle = false

local toggleBtn = Instance.new("TextButton", window)
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.Text = "Toggle: OFF"

toggleBtn.MouseButton1Click:Connect(function()
	toggle = not toggle
	toggleBtn.Text = "Toggle: " .. (toggle and "ON" or "OFF")

	task.spawn(function()
		while toggle do
			print("Loop aktif")
			task.wait(1)
		end
	end)
end)

---------------------------------------------------------
-- SLIDER
---------------------------------------------------------
local slider = Instance.new("Frame", window)
slider.Size = UDim2.new(1, -20, 0, 10)
slider.Position = UDim2.new(0, 10, 0, 90)
slider.BackgroundColor3 = Color3.fromRGB(80,80,80)

local knob = Instance.new("Frame", slider)
knob.Size = UDim2.new(0, 20, 1, 0)
knob.BackgroundColor3 = Color3.fromRGB(180,180,180)
knob.Active = true
knob.Draggable = true

local sliderValue = 0

knob.Changed:Connect(function(prop)
	if prop == "Position" then
		local x = math.clamp(knob.Position.X.Offset, 0, 180)
		knob.Position = UDim2.new(0, x, 0, 0)
		sliderValue = math.floor((x / 180) * 100)
		print("Slider Value:", sliderValue)
	end
end)

---------------------------------------------------------
-- SELECT OPTION (Dropdown + OVERFLOW)
---------------------------------------------------------
local places = {"Spawn", "Shop", "Boss"}

local dropdown = Instance.new("TextButton", window)
dropdown.Size = UDim2.new(1, -20, 0, 35)
dropdown.Position = UDim2.new(0, 10, 0, 120)
dropdown.Text = "Select Place"
dropdown.ZIndex = 2

local list = Instance.new("ScrollingFrame", window)
list.Size = UDim2.new(1, -20, 0, 60) -- hanya 2 item
list.Position = UDim2.new(0, 10, 0, 160)
list.BackgroundColor3 = Color3.fromRGB(60,60,60)
list.Visible = false
list.ClipsDescendants = true
list.CanvasSize = UDim2.new(0, 0, 0, #places * 30)
list.ScrollBarThickness = 6
list.ZIndex = 10  -- ✅ supaya tidak ketutup tombol

dropdown.MouseButton1Click:Connect(function()
	list.Visible = not list.Visible
end)

for i, place in pairs(places) do
	local option = Instance.new("TextButton", list)
	option.Size = UDim2.new(1, 0, 0, 30)
	option.Position = UDim2.new(0, 0, 0, (i-1) * 30)
	option.Text = place
	option.BackgroundColor3 = Color3.fromRGB(80,80,80)
	option.TextColor3 = Color3.fromRGB(255,255,255)
	option.ZIndex = 11

	option.MouseButton1Click:Connect(function()
		dropdown.Text = "Place: " .. place
		list.Visible = false
	end)
end

---------------------------------------------------------
-- BUTTON (Teleport)
---------------------------------------------------------
local tpBtn = Instance.new("TextButton", window)
tpBtn.Size = UDim2.new(1, -20, 0, 35)
tpBtn.Position = UDim2.new(0, 10, 0, 200)
tpBtn.Text = "Teleport"
tpBtn.ZIndex = 1

tpBtn.MouseButton1Click:Connect(function()
	local char = game.Players.LocalPlayer.Character
	if not char then return end

	if dropdown.Text == "Place: Spawn" then
		char:PivotTo(CFrame.new(0, 5, 0))
	elseif dropdown.Text == "Place: Shop" then
		char:PivotTo(CFrame.new(50, 5, 0))
	elseif dropdown.Text == "Place: Boss" then
		char:PivotTo(CFrame.new(100, 5, 0))
	end
end)
