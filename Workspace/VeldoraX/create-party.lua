local textColor = Color3.fromRGB(255,255,255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local buttonBackground = Color3.fromRGB(56, 0, 154)
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local frameColor = Color3.fromRGB(81, 0, 161)
---------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
local HttpService = game:GetService("HttpService")
local buttonTransparency = 0.6
local plrparty = nil
local frameTransparency = 0.4
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local borderColor = Color3.fromRGB(0, 0, 4) 
local mainBackground = backgroundColor
local char = Players.LocalPlayer.Character or Players.LocalPlayers.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local onMobile = not UIS.KeyboardEnabled
local keysDown = {}
local rotating = false
local freecamEnabled = false

local oldCameraType
local oldCameraCFrame

screenGui.Parent = gethui()
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
--=============================================================
--Free Cam
--=============================================================
local speed = 5
local sens = .3
speed /= 2
if onMobile then sens *= 2 end

-- FUNCTION TOGGLE FREECAM
local function toggleFreecam()
	freecamEnabled = not freecamEnabled

	if freecamEnabled then
		oldCameraType = cam.CameraType
		oldCameraCFrame = cam.CFrame

		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = oldCameraCFrame

		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
	else
		cam.CameraType = oldCameraType

		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50

		keysDown = {}
		rotating = false
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end

-- RENDER
local function renderStepped()
	if not freecamEnabled then return end

	if rotating then
		local delta = UIS:GetMouseDelta()
		local cf = cam.CFrame
		local yAngle = cf:ToEulerAngles(Enum.RotationOrder.YZX)
		local newAmount = math.deg(yAngle) + delta.Y

		if newAmount > 65 or newAmount < -65 then
			if not (yAngle < 0 and delta.Y < 0) and not (yAngle > 0 and delta.Y > 0) then
				delta = Vector2.new(delta.X, 0)
			end
		end

		cf *= CFrame.Angles(-math.rad(delta.Y), 0, 0)
		cf = CFrame.Angles(0, -math.rad(delta.X), 0) * (cf - cf.Position) + cf.Position
		cf = CFrame.lookAt(cf.Position, cf.Position + cf.LookVector)

		if delta ~= Vector2.new(0, 0) then
			cam.CFrame = cam.CFrame:Lerp(cf, sens)
		end

		UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	else
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end

	if keysDown["Enum.KeyCode.W"] then
		cam.CFrame *= CFrame.new(0, 0, -speed)
	end
	if keysDown["Enum.KeyCode.A"] then
		cam.CFrame *= CFrame.new(-speed, 0, 0)
	end
	if keysDown["Enum.KeyCode.S"] then
		cam.CFrame *= CFrame.new(0, 0, speed)
	end
	if keysDown["Enum.KeyCode.D"] then
		cam.CFrame *= CFrame.new(speed, 0, 0)
	end
end

RS.RenderStepped:Connect(renderStepped)

local validKeys = {
	"Enum.KeyCode.W",
	"Enum.KeyCode.A",
	"Enum.KeyCode.S",
	"Enum.KeyCode.D"
}

-- INPUT BEGIN
UIS.InputBegan:Connect(function(Input, gp)
	if gp then return end

	if not freecamEnabled then return end

	for _, key in pairs(validKeys) do
		if key == tostring(Input.KeyCode) then
			keysDown[key] = true
		end
	end

	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = true
	end
end)

-- INPUT END
UIS.InputEnded:Connect(function(Input)
	if not freecamEnabled then return end

	for key in pairs(keysDown) do
		if key == tostring(Input.KeyCode) then
			keysDown[key] = false
		end
	end

	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = false
	end
end)

--==============================================================
--script attr
--==============================================================

local function createLayout(parent,padding)
	local cLayout = Instance.new("UIListLayout")
	cLayout.Parent = parent
	cLayout.Padding = UDim.new(0,10)
	cLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	cLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	cLayout.SortOrder = Enum.SortOrder.LayoutOrder
	return cLayout
end

local function createPadding(parent,top,bottom,right,left)
	local cPadding = Instance.new("UIPadding")
	cPadding.Parent = parent
	cPadding.PaddingTop = top
	cPadding.PaddingBottom = bottom
	cPadding.PaddingLeft = right
	cPadding.PaddingRight = left
	return cPadding
end

local hlColor = Color3.fromRGB(0, 255, 0)
local function gui(type,name,bg,text,parent,radius,transparency)
    local ui = Instance.new(type)
    ui.Parent = parent
    ui.BackgroundColor3 = bg
	if ui:IsA("Frame") then
		
	else
		-- semua yang bukan Frame
		if ui:IsA("TextButton") or ui:IsA("TextLabel") then
			ui.Text = text
			ui.Font = Enum.Font.SourceSansBold
			ui.TextScaled = true
			ui.TextColor3 = textColor
		elseif ui:IsA("TextBox") then
			ui.PlaceholderText = text
			ui.Font = Enum.Font.SourceSansBold
			ui.TextScaled = true
			ui.PlaceholderColor3 = textColor
		end
	end
    ui.Name = name
	ui.BackgroundTransparency = transparency
    local corner = Instance.new("UICorner")
    corner.Parent = ui
    corner.CornerRadius = UDim.new(0,radius)
    return ui
end

local function border(name,color,thickness,parrent)
    local border = Instance.new("UIStroke")
	border.Parent = parrent
	border.Name = name
   	border.Color = color
    border.Thickness = thickness
    return border
end

local frame = gui("Frame","MainFrame",frameColor,"Text",screenGui,10,frameTransparency)
frame.Size = UDim2.new(0.7,0,0.8,0)
frame.Position = UDim2.new(0.15,0,0.01,0)

local iconButton = gui("TextButton","IconButton",buttonBackground,"",screenGui,10,1)
iconButton.Size = UDim2.new(0,52,0,52)
iconButton.Position = UDim2.new(0,10,0,200) -- posisikan tombol
iconButton.Text = "" -- kosongkan teks

-- gambar di dalam button
local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(1, 0, 1, 0) -- isi penuh button
icon.Position = UDim2.new(0, 0, 0, 0)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://126569944133822" -- ganti dengan ID gambar kamu
icon.Parent = iconButton

-- sudut rounded
local iconCorner = Instance.new("UICorner")
iconCorner.Parent = icon
iconCorner.CornerRadius = UDim.new(0,10)

-- fungsi drag
local function makeDraggable(frame)
	local dragging = false
	local dragStart = nil
	local startPos = nil

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- panggil fungsi untuk frame kamu
makeDraggable(frame)
makeDraggable(iconButton)

local leftPanel = gui("Frame","LeftPanel",backgroundColor,"Text",frame,10,frameTransparency)
leftPanel.Size = UDim2.new(0,150,0.89,0)
leftPanel.Position = UDim2.new(0,0,0,45)
local rightPanel = gui("Frame","RightPanel",backgroundColor,"Text",frame,10,frameTransparency)
rightPanel.Size = UDim2.new(0,447,0.89,0)
rightPanel.Position = UDim2.new(0.5,-147,0,45)
local topPanel = gui("Frame","TopPanel",backgroundColor,"Text",frame,10,frameTransparency)
topPanel.Size = UDim2.new(1,0,0,50)
topPanel.Position = UDim2.new(0,0,0,0)
local mainButton = gui("TextButton","Button",buttonBackground,"Main",leftPanel,10,frameTransparency)
mainButton.Size = UDim2.new(1,0,0,30)
mainButton.Position = UDim2.new(0,0,0,10)
local ToolsButton = gui("TextButton","Button",buttonBackground,"Tools",leftPanel,10,frameTransparency)
ToolsButton.Size = UDim2.new(1,0,0,30)
ToolsButton.Position = UDim2.new(0,0,0,50)
local MiscButton = gui("TextButton","Button",buttonBackground,"Misc",leftPanel,10,frameTransparency)
MiscButton.Size = UDim2.new(1,0,0,30)
MiscButton.Position = UDim2.new(0,0,0,90)
local SettingsButton = gui("TextButton","Button",buttonBackground,"Settings",leftPanel,10,frameTransparency)	
SettingsButton.Size = UDim2.new(1,0,0,30)
SettingsButton.Position = UDim2.new(0,0,0,130)
local KeyBindButton = gui("TextButton","Keybind Set",buttonBackground,"Keybind Set",leftPanel,10,frameTransparency)	
KeyBindButton.Size = UDim2.new(1,0,0,30)
KeyBindButton.Position = UDim2.new(0,0,0,170)


leftLayout = createLayout(leftPanel,UDim.new(0,10))
leftPadding = createPadding(leftPanel,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,10))
-- border
local leftBorder = border("Border",borderColor,1,leftPanel)
local rightBorder = border("Border",borderColor,1,rightPanel)
local topBorder = border("Border",borderColor,1,topPanel)
local bottomBorder = border("Border",borderColor,1,frame)
-- title
local title = gui("TextLabel","Title",backgroundColor,"Text",topPanel,10,1)
title.Text = "LIUDEX Z"
title.Size = UDim2.new(0.5,0,0,40)
title.Position = UDim2.new(0.28,0,0,5)
title.Font = Enum.Font.Garamond
title.FontFace = Font.new("rbxasset://fonts/families/Guru.json",Enum.FontWeight.Bold,Enum.FontStyle.Italic)
--============================================================================================================
-- main
--============================================================================================================
local main = gui("Frame","Main",mainBackground,"Main",rightPanel,10,1)
main.Size = UDim2.new(1,0,1,0)
main.Position = UDim2.new(0,0,0,0)

mainLayout = createLayout(main,UDim.new(0,10))
mainPadding = createPadding(main,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,10))

local CreateButton = gui("TextButton","Button",buttonBackground,"Create (WIP)",main,10,frameTransparency)
CreateButton.Size = UDim2.new(1,0,0,40)
CreateButton.Position = UDim2.new(0,0,0,10)
local inputJoin = gui("TextBox","Input",buttonBackground,"Input Party ID",main,10,frameTransparency)
inputJoin.Size = UDim2.new(1,0,0,40)
inputJoin.Position = UDim2.new(0,0,0,55)
inputJoin.TextColor3 = Color3.fromRGB(255,255,255)
inputJoin.Text = ""
inputJoin.PlaceholderText = "Insert Party ID..."
local JoinButton = gui("TextButton","Button",buttonBackground,"Join Party",main,10,frameTransparency)
JoinButton.Size = UDim2.new(1,0,0,40)
JoinButton.Position = UDim2.new(0,0,0,100)
local partyServer = nil
-- join func
JoinButton.MouseButton1Click:Connect(function()
	local partyID = inputJoin.Text
	if partyID ~= "" and plrparty == nil then
		local success, err = pcall(function()
			-- Kirim permintaan ke server untuk bergabung
			print("hellos")
		end)
		if success then
			print("Request Sent To:", partyID)
			plrparty = partyID
			partyServer = partyID
		else
			print("Terjadi error:", err)
		end
	else
		print("error: partyID kosong")
	end
end)
local leaveButton = gui("TextButton","Button",buttonBackground,"Leave",main,10,frameTransparency)
leaveButton.Size = UDim2.new(1,0,0,40)
leaveButton.Position = UDim2.new(0,0,0,145)
leaveButton.MouseButton1Click:Connect(function()
	print("leave")
	plrparty = nil
	partyServer = nil
	inputJoin.Text = ""
end)
--============================================================================================================
-- tools
--============================================================================================================
local Tools = gui("ScrollingFrame","Tools",mainBackground,"Tools",rightPanel,10,1)
Tools.Size = UDim2.new(1,0,1,0)
Tools.CanvasSize = UDim2.new(0,0,0,900)
Tools.ScrollBarThickness = 8
Tools.Position = UDim2.new(0,0,0,0)

local toolLayout = createLayout(Tools,UDim.new(0,10))
local toolPadding = createPadding(Tools,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,18))

local TrackTitle = gui("TextLabel","TrackTitle",mainBackground,"Tracker",Tools,10,1)
TrackTitle.Size = UDim2.new(1,0,0,20)
TrackTitle.Position = UDim2.new(0,0,0,10)
local trackConfig = gui("TextBox","TrackConfig",buttonBackground,"Config",Tools,10,frameTransparency)
trackConfig.Size = UDim2.new(1,0,0,40)
trackConfig.Position = UDim2.new(0,0,0,30)
trackConfig.Text = "0,255,0"
trackConfig.TextColor3 = textColor
trackConfig.PlaceholderText = "Insert RGB Color..."
trackConfig.PlaceholderColor3 = textColor
local Tracker = gui("TextButton","Tracker",buttonBackground,"Track",Tools,10,frameTransparency)
Tracker.Size = UDim2.new(1,0,0,40)
Tracker.Position = UDim2.new(0,0,0,75)
local trackToggle = false
Tracker.MouseButton1Click:Connect(function()
	trackToggle = not trackToggle
	if trackToggle then
		local args = string.split(trackConfig.Text, ",")
		for i,v in pairs(Players:GetPlayers()) do
			local highlight = Instance.new("Highlight")
			highlight.Parent = v.Character
			highlight.Adornee = v.Character
			highlight.Name = "Highlight"
			highlight.FillColor = Color3.fromRGB(args[1], args[2], args[3]) or hlColor
			highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
			highlight.FillTransparency = 0.4
			highlight.OutlineTransparency = 0
			local profile = game:GetService("Players"):GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			local Headers = Instance.new("BillboardGui")
			Headers.Parent = v.Character.Head
			Headers.Name = "LBill"
			Headers.Size = UDim2.new(0,80,0,80)
			Headers.StudsOffset = Vector3.new(0, 3, 0)
			Headers.AlwaysOnTop = true
			Headers.MaxDistance = math.huge
			local frame = gui("ImageButton","Profile",mainBackground,"Image", Headers ,100,0)
			frame.Size = UDim2.new(1,0,1,0)
			frame.Image = profile
			local text = gui("TextLabel","Name",mainBackground,"",frame,100,1)
			text.Size = UDim2.new(1,0,1,0)
			text.Position = UDim2.new(0,0,0.3,0)
			text.Text = v.Name
			text.TextColor3 = textColor
			text.BackgroundTransparency = 1
			text.Font = Enum.Font.GothamBold
			text.TextSize = 14
			text.TextXAlignment = Enum.TextXAlignment.Center
			text.TextYAlignment = Enum.TextYAlignment.Bottom
			
		end
		Tracker.Text = "UnTrack"
	else
		Tracker.Text = "Track"
		for i,v in pairs(Players:GetPlayers()) do
			local plrs = v.Character
			local plrsH = v.Character.Head
			for _, t in ipairs(plrs:GetChildren()) do
				if t:IsA("Highlight") then
					t:Destroy()
				end
			end
			for _, r in ipairs(plrsH:GetChildren()) do
				if r:IsA("BillboardGui") then
					r:Destroy()
				end
			end 
		end
	end
end)

local TextBox = gui("TextBox","TextBox",buttonBackground,"",Tools,10,frameTransparency)
TextBox.Size = UDim2.new(1,0,0,430)
TextBox.Position = UDim2.new(0,0,0,400)
TextBox.MultiLine = true
TextBox.Text = ""
TextBox.ClearTextOnFocus = false
TextBox.TextScaled = false
TextBox.TextColor3 = textColor
TextBox.TextSize = 18
TextBox.PlaceholderText = "Script Here...."
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.TextWrapped = true
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.PaddingTop = UDim.new(0, 5)
padding.PaddingBottom = UDim.new(0, 5)
padding.Parent = TextBox

local execute = gui("TextButton","Execute",buttonBackground,"Execute",Tools,10,frameTransparency)
execute.Size = UDim2.new(1,0,0,40)
execute.Position = UDim2.new(0,0,0,840)
execute.MouseButton1Click:Connect(function()
	local result = string.gsub(TextBox.Text, "\n", " ")
	task.spawn(function()
		loadstring(result)()
	end)
end)
local FreecamTitle = gui("TextLabel","TrackTitle",mainBackground,"Tracker",Tools,10,1)
FreecamTitle.Size = UDim2.new(1,0,0,20)
local Freecam = gui("TextButton","FreeCam",buttonBackground,"FreeCam",Tools,10,0)
Freecam.Size = UDim2.new(1,0,0,40)
Freecam.MouseButton1Click:Connect(function()
	toggleFreecam()
end)
--============================================================================================================
-- misc
--============================================================================================================
local Misc = gui("ScrollingFrame","Main",mainBackground,"Main",rightPanel,10,1)
Misc.Size = UDim2.new(1,0,1,0)
Misc.CanvasSize = UDim2.new(0,0,0,900)
Misc.ScrollBarThickness = 8
Misc.Position = UDim2.new(0,0,0,0)

function cosmetic(type, parentName, size, color)
	local selfChar = game:GetService("Players").LocalPlayer.Character
	local cosmeticc = Instance.new(type)

	-- cari parent di dalam character
	local targetParent = selfChar:FindFirstChild(parentName)
	if not targetParent then
		warn("Parent tidak ditemukan:", parentName)
		return
	end

	cosmeticc.Parent = targetParent

	if cosmeticc:IsA("Fire") then
		cosmeticc.Color = color
		cosmeticc.SecondaryColor = color
		cosmeticc.Heat = 25
		cosmeticc.Size = size
	end

	return cosmeticc
end
local cosmeticControler = gui("TextBox","Input",buttonBackground,"Cosmetic",Misc,10,frameTransparency)
cosmeticControler.Size = UDim2.new(1,0,0,40)
cosmeticControler.Position = UDim2.new(0,0,0,10)
cosmeticControler.TextColor3 = textColor
cosmeticControler.Text = "Aura ex: Fire Head 5 0,255,255"
cosmeticControler.PlaceholderColor3 = textColor
local cosmeticButton = gui("TextButton","Button",buttonBackground,"Apply",Misc,10,frameTransparency)
cosmeticButton.Size = UDim2.new(1,0,0,40)
cosmeticButton.Position = UDim2.new(0,0,0,55)
cosmeticButton.MouseButton1Click:Connect(function()
	local args = string.split(cosmeticControler.Text,"-")
	local type = args[1]
	local parentName = args[2]
	local size = tonumber(args[3]) or 25

	local rgb = string.split(args[4], ",")
	local color = Color3.fromRGB(tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3]))

	cosmetic(type, parentName, size, color)
end)

local Accessories = gui("TextLabel","Accessories",buttonBackground,"Accessories",Misc,10,1)
Accessories.Size = UDim2.new(1,0,0,20)
Accessories.Position = UDim2.new(0,0,0,110)
Accessories.Text = "Accessories"
local AccessoriesControler = gui("TextBox","Input",buttonBackground,"Accessories",Misc,10,frameTransparency)
AccessoriesControler.Size = UDim2.new(1,0,0,40)
AccessoriesControler.Position = UDim2.new(0,0,0,130)
AccessoriesControler.ClearTextOnFocus = false
AccessoriesControler.Text = "rbxassetid://8602648782-Head-0,0,0-rbxassetid://8602648207-0-0-0"
AccessoriesControler.TextColor3 = textColor
AccessoriesControler.PlaceholderColor3 = textColor
local AccessoriesButton = gui("TextButton","Button",buttonBackground,"Apply",Misc,10,frameTransparency)
AccessoriesButton.Size = UDim2.new(1,0,0,40)
AccessoriesButton.Position = UDim2.new(0,0,0,175)
AccessoriesButton.MouseButton1Click:Connect(function()
	local args = string.split(AccessoriesControler.Text,"-")
	local rgb = string.split(args[3],",")
    print (args[1],args[2],args[3],args[4],args[5],args[6],args[7])
	getgenv().acsryId = args[1] or "rbxassetid://8602648782"
	getgenv().acsryParent = args[2] or "Head"
	getgenv().acsryColor = Color3.fromRGB(tonumber(rgb[1]),tonumber(rgb[2]),tonumber(rgb[3])) or Color3.fromRGB(0,0,0)
	getgenv().acsryTexture = args[4] or "rbxassetid://8602648207"
	getgenv().acsryX = tonumber(args[5]) or 0
	getgenv().acsrY = tonumber(args[6]) or 0
	getgenv().acsrZ = tonumber(args[7]) or 0
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/VeldoraX/ugcCreate.lua"))()
end)

local shaders = gui("TextLabel","Shaders",buttonBackground,"Shaders",Misc,10,1)
shaders.Size = UDim2.new(1,0,0,20)
shaders.Position = UDim2.new(0,0,0,215)
shaders.Text = "Shaders"
local bloom = gui("TextLabel","Bloom",buttonBackground,"Bloom",Misc,10,1)
bloom.Size = UDim2.new(1,0,0,20)
bloom.Position = UDim2.new(0,0,0,230)
bloom.Text = "Bloom"
local bloomControler = gui("TextBox","Input",buttonBackground,"Shaders",Misc,10,frameTransparency)
bloomControler.Size = UDim2.new(0.32,0,0,40)
bloomControler.Position = UDim2.new(0,0,0,250)
bloomControler.ClearTextOnFocus = false
bloomControler.PlaceholderText = "Intensity"
bloomControler.Text = ""
bloomControler.TextColor3 = textColor
bloomControler.PlaceholderColor3 = textColor
local bloomControler1 = gui("TextBox","Input",buttonBackground,"Shaders",Misc,10,frameTransparency)
bloomControler1.Size = UDim2.new(0.32,0,0,40)
bloomControler1.Position = UDim2.new(0.33,0,0,250)
bloomControler1.ClearTextOnFocus = false
bloomControler1.Text = ""
bloomControler1.PlaceholderText = "Size"
bloomControler1.TextColor3 = textColor
bloomControler1.PlaceholderColor3 = textColor
local bloomControler2 = gui("TextBox","Input",buttonBackground,"Shaders",Misc,10,frameTransparency)
bloomControler2.Size = UDim2.new(0.32,0,0,40)
bloomControler2.Position = UDim2.new(0.66,0,0,250)
bloomControler2.ClearTextOnFocus = false
bloomControler2.Text = ""
bloomControler1.PlaceholderText = "Treshold"
bloomControler2.TextColor3 = textColor
bloomControler2.PlaceholderColor3 = textColor
local bloomButton = gui("TextButton","Button",buttonBackground,"Apply",Misc,10,frameTransparency)
bloomButton.Size = UDim2.new(1,0,0,40)
bloomButton.Position = UDim2.new(0,0,0,300)
bloomButton.MouseButton1Click:Connect(function()
	local Lighting = game:GetService("Lighting")
	for i,v in ipairs(Lighting:GetChildren()) do
		if v:IsA("BloomEffect") then
			v:Destroy()
		end
	end
	task.wait()
	local newBloom = Instance.new("BloomEffect")
	newBloom.Intensity = tonumber(bloomControler.Text) or 0
	newBloom.Size = tonumber(bloomControler1.Text) or 0	
	newBloom.Threshold = tonumber(bloomControler2.Text) or 0
	newBloom.Parent = Lighting
	print("Create")
end)
local atmosphere = gui("TextLabel","Atmosphere",buttonBackground,"Atmosphere",Misc,10,1)
atmosphere.Size = UDim2.new(1,0,0,20)
atmosphere.Position = UDim2.new(0,0,0,340)
atmosphere.Text = "Atmosphere"
local atmosphereControler = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
atmosphereControler.Size = UDim2.new(0.32,0,0,40)
atmosphereControler.Position = UDim2.new(0,0,0,365)
atmosphereControler.ClearTextOnFocus = false
atmosphereControler.Text = ""
atmosphereControler.PlaceholderText = "Density"
atmosphereControler.TextColor3 = textColor
atmosphereControler.PlaceholderColor3 = textColor
local atmosphereControler1 = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
atmosphereControler1.Size = UDim2.new(0.32,0,0,40)
atmosphereControler1.Position = UDim2.new(0.33,0,0,365)
atmosphereControler1.ClearTextOnFocus = false
atmosphereControler1.Text = ""
atmosphereControler1.PlaceholderText = "Offset"
atmosphereControler1.TextColor3 = textColor
atmosphereControler1.PlaceholderColor3 = textColor
local atmosphereControler2 = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
atmosphereControler2.Size = UDim2.new(0.32,0,0,40)
atmosphereControler2.Position = UDim2.new(0.66,0,0,365)
atmosphereControler2.ClearTextOnFocus = false
atmosphereControler2.Text = ""
atmosphereControler2.PlaceholderText = "Color"
atmosphereControler2.TextColor3 = textColor
atmosphereControler2.PlaceholderColor3 = textColor
local atmosphereControler3 = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
atmosphereControler3.Size = UDim2.new(0.32,0,0,40)
atmosphereControler3.Position = UDim2.new(0.33,0,0,410)
atmosphereControler3.ClearTextOnFocus = false
atmosphereControler3.Text = ""
atmosphereControler3.PlaceholderText = "Decay"
atmosphereControler3.TextColor3 = textColor
atmosphereControler3.PlaceholderColor3 = textColor
local athmosphereControler4 = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
athmosphereControler4.Size = UDim2.new(0.32,0,0,40)
athmosphereControler4.Position = UDim2.new(0.66,0,0,410)
athmosphereControler4.ClearTextOnFocus = false
athmosphereControler4.Text = ""
athmosphereControler4.PlaceholderText = "Glare"
athmosphereControler4.TextColor3 = textColor
athmosphereControler4.PlaceholderColor3 = textColor
local athmosphereControler5 = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
athmosphereControler5.Size = UDim2.new(0.32,0,0,40)
athmosphereControler5.Position = UDim2.new(0,0,0,410)
athmosphereControler5.ClearTextOnFocus = false
athmosphereControler5.Text = ""
athmosphereControler5.PlaceholderText = "Haze"
athmosphereControler5.TextColor3 = textColor
athmosphereControler5.PlaceholderColor3 = textColor	
local atmosphereButton = gui("TextButton","Button",buttonBackground,"Apply",Misc,10,frameTransparency)
atmosphereButton.Size = UDim2.new(1,0,0,40)
atmosphereButton.Position = UDim2.new(0,0,0,460)
atmosphereButton.MouseButton1Click:Connect(function()
	local Lighting = game:GetService("Lighting")

	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end

	local color = string.split(atmosphereControler2.Text, ",")
	local color2 = string.split(atmosphereControler3.Text, ",")

	local newAthmosphere = Instance.new("Atmosphere")
	newAthmosphere.Parent = Lighting

	newAthmosphere.Density = tonumber(atmosphereControler.Text) or 0
	newAthmosphere.Offset = tonumber(atmosphereControler1.Text) or 0
	newAthmosphere.Haze = tonumber(athmosphereControler5.Text) or 0
	newAthmosphere.Glare = tonumber(athmosphereControler4.Text) or 0

	newAthmosphere.Color = Color3.fromRGB(tonumber(color[1]) or 0,tonumber(color[2]) or 0,tonumber(color[3]) or 0)

	newAthmosphere.Decay = Color3.fromRGB(tonumber(color2[1]) or 0,tonumber(color2[2]) or 0,tonumber(color2[3]) or 0)
end)
local blur = gui("TextLabel","Atmosphere",buttonBackground,"Atmosphere",Misc,10,1)
blur.Size = UDim2.new(1,0,0,20)
blur.Position = UDim2.new(0,0,0,500)
blur.Text = "Blur"
blur.TextColor3 = textColor
local blurControler = gui("TextBox","Input",buttonBackground,"Atmosphere",Misc,10,frameTransparency)
blurControler.Size = UDim2.new(1,0,0,40)
blurControler.Position = UDim2.new(0,0,0,520)
blurControler.ClearTextOnFocus = false
blurControler.Text = ""
blurControler.PlaceholderText = "Blur"
blurControler.TextColor3 = textColor
blurControler.PlaceholderColor3 = textColor
blurControler.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local Lighting = game:GetService("Lighting")
		-- hapus blur lama
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("BlurEffect") then
				v:Destroy()
			end
		end
		-- ambil angka dari TextBox blur
		local args = tonumber(blurControler.Text) -- pastikan blur adalah TextBox
		if args then
			local newBlur = Instance.new("BlurEffect")
			newBlur.Parent = Lighting
			newBlur.Size = args
		end
	end
end)
local sky = gui("TextLabel","Sky",buttonBackground,"Sky",Misc,10,1)
sky.Size = UDim2.new(1,0,0,20)
sky.Position = UDim2.new(0,0,0,560)
sky.Text = "Sky"
sky.TextColor3 = textColor
local skyControler = gui("TextBox","Input",buttonBackground,"Sky",Misc,10,frameTransparency)
skyControler.Size = UDim2.new(1,0,0,180)
skyControler.Position = UDim2.new(0,0,0,580)
skyControler.ClearTextOnFocus = false
skyControler.PlaceholderText = "SkyboxBk\nSkyboxDn\nSkyboxFt\nSkyboxLf\nSkyboxRt\nSkyboxUp\nSunTextureId\nMoonTextureId\nStarCount\nSunAngularSize\nMoonAngularSize"
skyControler.TextColor3 = textColor
skyControler.MultiLine = true
skyControler.TextWrapped = true
skyControler.TextXAlignment = Enum.TextXAlignment.Left
skyControler.TextYAlignment = Enum.TextYAlignment.Top
skyControler.TextScaled = false
skyControler.TextSize = 15
skyControler.Text = ""
skyControler.PlaceholderColor3 = textColor
local skybutton = gui("TextButton","Sky",buttonBackground,"Sky",Misc,10,0)
skybutton.Size = UDim2.new(1,0,0,40)
skybutton.Position = UDim2.new(0,0,0,760)
skybutton.Text = "Apply"
skybutton.TextColor3 = textColor
skybutton.MouseButton1Click:Connect(function()
	local Lighting = game:GetService("Lighting")
	for i,v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Sky") then
			v:Destroy()
		end
	end
	local args = string.split(skyControler.Text, "\n")
	local skys = Instance.new("Sky")
	for i,v in ipairs(args) do
		args[i] = v:match("%S+") or ""
	end
	skys.Parent = Lighting
	skys.SkyboxBk = "rbxassetid://"..((args[1] and args[1] ~= "") and args[1] or "126569944133822")
	skys.SkyboxDn = "rbxassetid://"..((args[2] and args[2] ~= "") and args[2] or "126569944133822")
	skys.SkyboxFt = "rbxassetid://"..((args[3] and args[3] ~= "") and args[3] or "126569944133822")
	skys.SkyboxLf = "rbxassetid://"..((args[4] and args[4] ~= "") and args[4] or "126569944133822")
	skys.SkyboxRt = "rbxassetid://"..((args[5] and args[5] ~= "") and args[5] or "126569944133822")
	skys.SkyboxUp = "rbxassetid://"..((args[6] and args[6] ~= "") and args[6] or "126569944133822")
	skys.SunTextureId = "rbxassetid://"..((args[6] and args[7] ~= "") and args[7] or "126569944133822")
	skys.MoonTextureId = "rbxassetid://"..((args[6] and args[8] ~= "") and args[8] or "126569944133822")
	skys.StarCount = tonumber(args[9]) or 10
	skys.SunAngularSize = tonumber(args[10]) or 20
	skys.MoonAngularSize = tonumber(args[11]) or 20
end)
--============================================================================================================
-- settings
--============================================================================================================
local Settings = gui("ScrollingFrame","Settings",mainBackground,"Settings",rightPanel,10,1)
Settings.Size = UDim2.new(1,0,1,0)
Settings.CanvasSize = UDim2.new(0, 0, 0, 1000)
Settings.ScrollBarThickness = 8
Settings.Position = UDim2.new(0,0,0,0)

local NoParticle = gui("TextButton","Button",buttonBackground,"NoParticle",Settings,10,frameTransparency)
NoParticle.Size = UDim2.new(1,0,0,40)
NoParticle.Position = UDim2.new(0,0,0,10)
NoParticle.MouseButton1Click:Connect(function()
	local workspace = game:GetService("Workspace")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Sparkles") or v:IsA("") then
			v.Enabled = false
		end
	end
	for i,v in ipairs(ReplicatedStorage:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
			v:Destroy()
		end
	end
end)
local NoShaders = gui("TextButton","Button",buttonBackground,"NoShaders",Settings,10,frameTransparency)
NoShaders.Size = UDim2.new(1,0,0,40)
NoShaders.Position = UDim2.new(0,0,0,55)
NoShaders.MouseButton1Click:Connect(function()
	local Lighting = game:GetService("Lighting")

	-- Matikan shadow
	Lighting.GlobalShadows = false
	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0

	-- Fog biar ringan
	Lighting.FogStart = 0
	Lighting.FogEnd = 100000
end)
local renderDistace = gui("TextBox","Input",buttonBackground,"RenderDistance",Settings,10,frameTransparency)
renderDistace.Size = UDim2.new(1,0,0,40)
renderDistace.Position = UDim2.new(0,0,0,145)
renderDistace.Text = "256"
renderDistace.TextColor3 = textColor
renderDistace.PlaceholderColor3 = textColor
renderDistace.PlaceholderText = "Max Distace"
local minRender = gui("TextBox","Input",buttonBackground,"MinRender",Settings,10,frameTransparency)
minRender.Size = UDim2.new(1,0,0,40)
minRender.PlaceholderText = "Min Distace"
minRender.Position = UDim2.new(0,0,0,100)
minRender.PlaceholderColor3 = textColor
minRender.TextColor3 = textColor
minRender.Text = "64"
local DisableMaterial = gui("TextButton","Button",buttonBackground,"DisableMaterial",Settings,10,frameTransparency)
DisableMaterial.Size = UDim2.new(1,0,0,40)
DisableMaterial.Position = UDim2.new(0,0,0,190)
DisableMaterial.MouseButton1Click:Connect(function()
	local workspace = game:GetService("Workspace")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.Material = Enum.Material.Plastic
		end
	end
	for i,v in ipairs(ReplicatedStorage:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.Material = Enum.Material.Plastic
		end	
	end
end)
DisableMesh = gui("TextButton","Button",buttonBackground,"DisableMesh",Settings,10,frameTransparency)
DisableMesh.Size = UDim2.new(1,0,0,40)
DisableMesh.Position = UDim2.new(0,0,0,235)
DisableMesh.MouseButton1Click:Connect(function()
	local workspace = game:GetService("Workspace")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.MeshId = ""
			v.TextureID = ""
		end
	end
	for i,v in ipairs(ReplicatedStorage:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.MeshId = ""
			v.TextureID = ""
		end
	end
end)
-- function
local function show(ui)
	main.Visible = false
	Tools.Visible = false
	Misc.Visible = false
	Settings.Visible = false
	main.Active = false
	Tools.Active = false
	Misc.Active = false
	Settings.Active = false
	task.wait()
	ui.Active = true
	ui.Visible = true
end
-- click event
mainButton.MouseButton1Click:Connect(function()
	show(main)
end)
ToolsButton.MouseButton1Click:Connect(function()
	show(Tools)
end)
MiscButton.MouseButton1Click:Connect(function()
	show(Misc)
end)
SettingsButton.MouseButton1Click:Connect(function()
	show(Settings)
end)
local toggle = false -- mulai dari OFF

iconButton.MouseButton1Click:Connect(function()
	toggle = not toggle -- setiap klik, nilai dibalik
	if toggle then
		frame.Visible = false
	else
		frame.Visible = true
	end
end)
CreateButton.MouseButton1Click:Connect(function()
local HttpService = game:GetService("HttpService")
local plr = game:GetService("Players").LocalPlayer

local request = req or http_request or syn.request

-- Buat body sebagai string form-encoded
local body = "leader=" .. plr.Name .. "&uid=" .. tostring(gethwid())

local res = request({
    Url = "https://xochitl-superexacting-unconcentrically.ngrok-free.dev/roblox-script/create-party.php",
    Method = "POST",
    Headers = { ["Content-Type"] = "application/x-www-form-urlencoded" },
    Body = body
})

print(res.StatusCode, res.Body)
setclipboard(gethwid())
end)
local delayGet = 2
-- request
show(main)
loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/VeldoraX/announce-message.lua"))()
task.spawn(function()
while true do
	if partyServer then
		local url = "https://loremipsumapps.infinityfree.me/roblox-script/users/" 
			.. tostring(partyServer)
		task.wait(delayGet)
		print(url)
	else
		warn("partyServer masih nil, isi dulu sebelum dipakai")
		task.wait(delayGet)
	end
end
end)
