-- execute gui
local ui = Instance.new("ScreenGui")
ui.Parent = game.CoreGui
-- local
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ui = player:WaitForChild("PlayerGui")
 
-- =========================
-- WINDOW UTAMA
-- =========================
local window = Instance.new("Frame", ui)
window.Size = UDim2.new(0, 260, 0, 270)
window.Position = UDim2.new(0.5, -130, 0.5, -135)
window.BackgroundColor3 = Color3.fromRGB(40,40,40)
window.Active = true
window.Draggable = false
window.BorderSizePixel = 0
 
-- =========================
-- TITLE (DRAG AREA)
-- =========================
local title = Instance.new("TextLabel", window)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Executor GUI"
title.BackgroundColor3 = Color3.fromRGB(60,60,60)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Active = true
title.BorderSizePixel = 0
 
-- =========================
-- DRAG WINDOW DARI TITLE SAJA
-- =========================
local dragging = false
local dragStart, startPos
 
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
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
 
---------------------------------------------------------
-- TOGGLE AFK
---------------------------------------------------------
local toggle = false
 
local toggleLabel = Instance.new("TextLabel", window)
toggleLabel.Size = UDim2.new(0, 120, 0, 30)
toggleLabel.Position = UDim2.new(0, 10, 0, 40)
toggleLabel.Text = "Toggle AFK"
toggleLabel.TextColor3 = Color3.new(1,1,1)
toggleLabel.BackgroundTransparency = 1
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
 
local toggleBtn = Instance.new("TextButton", window)
toggleBtn.Size = UDim2.new(0, 80, 0, 28)
toggleBtn.Position = UDim2.new(1, -90, 0, 41)
toggleBtn.Text = "OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(120,60,60)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = false
 
toggleBtn.MouseButton1Click:Connect(function()
    toggle = not toggle
    toggleBtn.Text = toggle and "ON" or "OFF"
    toggleBtn.BackgroundColor3 = toggle and Color3.fromRGB(60,120,60) or Color3.fromRGB(120,60,60)
 
    task.spawn(function()
        while toggle do
            print("Loop aktif")
            task.wait(1)
        end
    end)
end)
 
---------------------------------------------------------
-- SLIDER SPEED
---------------------------------------------------------
local sliderLabel = Instance.new("TextLabel", window)
sliderLabel.Size = UDim2.new(0, 100, 0, 20)
sliderLabel.Position = UDim2.new(0, 10, 0, 80)
sliderLabel.Text = "Speed"
sliderLabel.TextColor3 = Color3.new(1,1,1)
sliderLabel.BackgroundTransparency = 1
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
 
local slider = Instance.new("Frame", window)
slider.Size = UDim2.new(1, -120, 0, 8)
slider.Position = UDim2.new(0, 110, 0, 90)
slider.BackgroundColor3 = Color3.fromRGB(90,90,90)
slider.BorderSizePixel = 0
 
local knob = Instance.new("Frame", slider)
knob.Size = UDim2.new(0, 14, 0, 14)
knob.Position = UDim2.new(0, 0, -0.4, 0)
knob.BackgroundColor3 = Color3.fromRGB(200,200,200)
knob.BorderSizePixel = 0
knob.Active = true
knob.Draggable = true
 
local sliderValue = 0
 
knob.Changed:Connect(function(prop)
    if prop == "Position" then
        local x = math.clamp(knob.Position.X.Offset, 0, slider.AbsoluteSize.X - knob.Size.X.Offset)
        knob.Position = UDim2.new(0, x, -0.4, 0)
        sliderValue = math.floor((x / (slider.AbsoluteSize.X - knob.Size.X.Offset)) * 100)
        print("Slider Value:", sliderValue)
    end
end)
 
---------------------------------------------------------
-- DROPDOWN
---------------------------------------------------------
local dropLabel = Instance.new("TextLabel", window)
dropLabel.Size = UDim2.new(0, 120, 0, 30)
dropLabel.Position = UDim2.new(0, 10, 0, 120)
dropLabel.Text = "Teleport To"
dropLabel.TextColor3 = Color3.new(1,1,1)
dropLabel.BackgroundTransparency = 1
dropLabel.TextXAlignment = Enum.TextXAlignment.Left
 
local dropdown = Instance.new("TextButton", window)
dropdown.Size = UDim2.new(0, 120, 0, 30)
dropdown.Position = UDim2.new(1, -130, 0, 120)
dropdown.Text = "Select"
dropdown.BackgroundColor3 = Color3.fromRGB(70,70,70)
dropdown.TextColor3 = Color3.new(1,1,1)
dropdown.BorderSizePixel = 0
 
local places = {"Spawn", "Shop", "Boss"}
 
local list = Instance.new("Frame", window)
list.Size = UDim2.new(1, -20, 0, 0)
list.Position = UDim2.new(0, 10, 0, 155)
list.BackgroundColor3 = Color3.fromRGB(60,60,60)
list.Visible = false
list.BorderSizePixel = 0
 
dropdown.MouseButton1Click:Connect(function()
    list.Visible = not list.Visible
end)
 
for _, place in pairs(places) do
    local option = Instance.new("TextButton", list)
    option.Size = UDim2.new(1, 0, 0, 30)
    option.Text = place
    option.BackgroundColor3 = Color3.fromRGB(80,80,80)
    option.TextColor3 = Color3.new(1,1,1)
    option.BorderSizePixel = 0
 
    option.MouseButton1Click:Connect(function()
        dropdown.Text = "Place: " .. place
        list.Visible = false
    end)
end
 
---------------------------------------------------------
-- BUTTON TELEPORT (TANPA LABEL)
---------------------------------------------------------
local tpBtn = Instance.new("TextButton", window)
tpBtn.Size = UDim2.new(1, -20, 0, 35)
tpBtn.Position = UDim2.new(0, 10, 0, 210)
tpBtn.Text = "Teleport"
tpBtn.BackgroundColor3 = Color3.fromRGB(80,80,120)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.BorderSizePixel = 0
 
tpBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char then return end
 
    if dropdown.Text == "Place: Spawn" then
        char:PivotTo(CFrame.new(0, 5, 0))
    elseif dropdown.Text == "Place: Shop" then
        char:PivotTo(CFrame.new(50, 5, 0))
    elseif dropdown.Text == "Place: Boss" then
        char:PivotTo(CFrame.new(100, 5, 0))
    end
end)
