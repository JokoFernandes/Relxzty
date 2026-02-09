if getgenv().LiudexStart then
	return
end

getgenv().LiudexStart = true
local file = "LIUDEX Z/Auto Execute"
local Place = game.PlaceId
local function addDirectScript(name,script)
	if not isfolder(tostring(Place)) then
		makefolder(file .. "/" .. tostring(Place))
	end
	writefile(file .. "/" .. tostring(Place) .. "/" .. name, script)
end
local StarterGui = game:GetService("StarterGui")

task.wait()
local function getexecutescript(path)
	local Place = game.PlaceId
	if isfolder(path)  then
		for i, v in ipairs (listfiles(path))do
			if v == (path.. "/" .. Place) then
				for u,n in ipairs(listfiles(v)) do
					dofile(n)
				end
			end
		end
	end
end
local assets = {"icon.png","icon2.png","icon3.png","icon4.png","icon5.png","icon6.png"}

local function getAllAssets(list)
	if not isfolder("LIUDEX Z/Asset") then
		makefolder("LIUDEX Z/Asset")
	end
	task.wait()
    for _, v in ipairs(list) do
        local path = "LIUDEX Z/Asset/" .. v
        if not isfile(path) then
            local ok, content = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/Assets/" .. v)
            end)
            if ok and content then
                writefile(path, content)
            else
                warn("Gagal download asset: " .. v)
            end
        end
    end
end

local function allAssetsExist(list)
    for _, v in ipairs(list) do
        if not isfile("LIUDEX Z/Asset/" .. v) then
            return false
        end
    end
    return true
end
repeat
    getAllAssets(assets)
    task.wait(1)
until allAssetsExist(assets)
print("✅ Done")




local function Notify(Titles,Texts,Buttons1)

-- Fungsi saat tombol diklik
    local btn1 = Button1
	local btn2 =Button2
	
-- Kirim notifikasi
StarterGui:SetCore("SendNotification", {
    Title = Titles,
    Icon = "rbxassetid://71775514575470", -- contoh ikon notifikasi default
    Text = Texts,
	Button1 = Buttons1,
    Duration = 4
})
end
if not getgenv().LIUDEXLoaded then
	getexecutescript(file)
end

getgenv().LIUDEXLoaded = true

local textColor = Color3.fromRGB(255,255,255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local buttonBackground = Color3.fromRGB(56, 0, 154)
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local frameColor = Color3.fromRGB(37, 5, 75)
---------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LIUDEX Z"
local HttpService = game:GetService("HttpService")
local buttonTransparency = 0.5
local plrparty = nil
local frameTransparency = 0.2
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local borderColor = Color3.fromRGB(0, 0, 4) 
local mainBackground = backgroundColor
local player = Players.LocalPlayer
local char = Players.LocalPlayer.Character or Players.LocalPlayers.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local onMobile = not UIS.KeyboardEnabled
local keysDown = {}
local rotating = false
local freecamEnabled = false
local clossed = false
local oldCameraType
local oldCameraCFrame
local freezcon
local healthcon
screenGui.Parent = gethui()
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
--============================================================
--Server Hop
--============================================================
local function hopServers(maxCount)
local Http = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local count = maxCount or 1
local servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
for i, v in pairs(servers) do
    if v.playing < v.maxPlayers and v.playing <= count then
        TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
        break
    end
end
end



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
	if clossed then
		freecamEnabled = false
	end
	if freecamEnabled and not game.Workspace:GetAttribute("LIUDEX_FREECAM") then
		oldCameraType = cam.CameraType
		oldCameraCFrame = cam.CFrame

		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = oldCameraCFrame

		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
		freezcon = humanoid.Changed:Connect(function(property)
			if property == "WalkSpeed" and humanoid.WalkSpeed ~= 0 then
				humanoid.WalkSpeed = 0
			end
		end)
		healthcon = humanoid.HealthChanged:Connect(function(health)
			if health <= 0 then
				cam.CameraType = oldCameraType
				cam.CFrame = oldCameraCFrame
				if freezcon then
					freezcon:Disconnect()
					freezcon = nil
				end
				keysDown = {}
				rotating = false
				UIS.MouseBehavior = Enum.MouseBehavior.Default
			end
		end)
	else
		cam.CameraType = oldCameraType

		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		if freezcon then
			freezcon:Disconnect()
			freezcon = nil
		end
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
	if keysDown["Enum.KeyCode.I"] then
		cam.CFrame *= CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, math.rad(15))
	end
	if keysDown["Enum.KeyCode.O"] then
		cam.CFrame *= CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, math.rad(-15))
	end
	if keysDown["Enum.KeyCode.Up"] then
		cam.CFrame *= CFrame.new(0, speed, 0)
	end
	if keysDown["Enum.KeyCode.Down"] then
		cam.CFrame *= CFrame.new(0, -speed, 0)
	end
end

RS.RenderStepped:Connect(renderStepped)

local validKeys = {
	"Enum.KeyCode.W",
	"Enum.KeyCode.A",
	"Enum.KeyCode.S",
	"Enum.KeyCode.D",
	"Enum.KeyCode.I",
	"Enum.KeyCode.O",
	"Enum.KeyCode.Up",
	"Enum.KeyCode.Down"
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
function decal(texture, enum, parent)
    local decal = Instance.new("Decal")
    decal.Texture = texture
    decal.Face = enum
    decal.Parent = parent
    return decal
end
local function changeMaterial(container, newMaterial, decal)
    -- Loop semua child di dalam container
    for _, child in ipairs(game.Workspace:GetDescendants()) do
        if child:IsA("BasePart") or child:IsA("MeshPart") then
            child.Material = newMaterial
            local res = getcustomasset("base.png") or "rbxassetid://126569944133822"
            decal(res, Enum.NormalId.Top, child)
            decal(res, Enum.NormalId.Left, child)
            decal(res, Enum.NormalId.Right, child)
            decal(res, Enum.NormalId.Front, child)
            decal(res, Enum.NormalId.Back, child)
            decal(res, Enum.NormalId.Bottom, child)
        elseif child:IsA("Model") or child:IsA("Folder") then
            -- Kalau object adalah Model/Folder, loop lagi ke dalamnya
        end
    end
end

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
frame.Size = UDim2.new(0.74,0,0.8,0)
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
local SIconSize = UDim2.new(0,18,0,18)
local SIconPos = UDim2.new(0,10,0,10)
function SetIcon(obj,assetId)
	local newIcon = Instance.new("ImageLabel")
	newIcon.Size = SIconSize
	newIcon.Image = assetId
	newIcon.Position = SIconPos
	newIcon.Parent = obj
	return newIcon
end

-- panggil fungsi untuk frame kamu
makeDraggable(frame)
makeDraggable(iconButton)

local leftPanel = gui("Frame","LeftPanel",backgroundColor,"Text",frame,10,1)
leftPanel.Size = UDim2.new(0,200,0.89,0)
leftPanel.Position = UDim2.new(0,0,0.1,2)
local rightPanel = gui("Frame","RightPanel",backgroundColor,"Text",frame,10,1)
rightPanel.Size = UDim2.new(1,-200,0.89,0)
rightPanel.Position = UDim2.new(0,200,0.1,2)
local topPanel = gui("Frame","TopPanel",backgroundColor,"Text",frame,10,1)
topPanel.Size = UDim2.new(1,0,0.1,0)
topPanel.Position = UDim2.new(0,0,0,0)
local mainButton = gui("TextButton","Button",buttonBackground,"Main",leftPanel,10,frameTransparency)
mainButton.Size = UDim2.new(1,0,0,40)
mainButton.Position = UDim2.new(0,0,0,10)
SetIcon(mainButton,getcustomasset("LIUDEX Z/Asset/icon.png"))
local ToolsButton = gui("TextButton","Button",buttonBackground,"Tools",leftPanel,10,frameTransparency)
ToolsButton.Size = UDim2.new(1,0,0,40)
ToolsButton.Position = UDim2.new(0,0,0,50)
SetIcon(ToolsButton,getcustomasset("LIUDEX Z/Asset/icon5.png"))
local MiscButton = gui("TextButton","Button",buttonBackground,"Misc",leftPanel,10,frameTransparency)
MiscButton.Size = UDim2.new(1,0,0,40)
MiscButton.Position = UDim2.new(0,0,0,90)
SetIcon(MiscButton,getcustomasset("LIUDEX Z/Asset/icon2.png"))
local SettingsButton = gui("TextButton","Button",buttonBackground,"Settings",leftPanel,10,frameTransparency)	
SettingsButton.Size = UDim2.new(1,0,0,40)
SettingsButton.Position = UDim2.new(0,0,0,130)
SetIcon(SettingsButton,getcustomasset("LIUDEX Z/Asset/icon4.png"))
local KeyBindButton = gui("TextButton","KeyBind",buttonBackground,"Keybind",leftPanel,10,frameTransparency)	
KeyBindButton.Size = UDim2.new(1,0,0,40)
KeyBindButton.Position = UDim2.new(0,0,0,170)
SetIcon(KeyBindButton,getcustomasset("LIUDEX Z/Asset/icon3.png"))

leftLayout = createLayout(leftPanel,UDim.new(0,5))
leftPadding = createPadding(leftPanel,UDim.new(0,5),UDim.new(0,5),UDim.new(0,5),UDim.new(0,5))
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
local main = gui("ScrollingFrame","Main",mainBackground,"Main",rightPanel,10,1)
main.Size = UDim2.new(1,0,1,0)
main.CanvasSize = UDim2.new(0,0,0,600)
main.ScrollBarThickness = 10
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
local decalId = gui("TextBox","Input",buttonBackground,"Decal Id ...",main,10,frameTransparency)
decalId.Size = UDim2.new(1,0,0,40)
decalId.Position = UDim2.new(0,0,0,55)
decalId.TextColor3 = Color3.fromRGB(255,255,255)
decalId.Text = ""
decalId.PlaceholderText = "Insert Party ID..."
local decalSpam = gui("TextButton","Button",buttonBackground,"Spam Decal",main,10,frameTransparency)
decalSpam.Size = UDim2.new(1,0,0,40)
decalSpam.Position = UDim2.new(0,0,0,145)
decalSpam.MouseButton1Click:Connect(function()
	local dec = "rbxassetid://" .. tostring(decalId.Text)
	changeMaterial(game.Workspace, Enum.Material.Neon, decal)
end)
local friendspawn = gui("Frame","Friend",buttonBackground,"Friends ID",main,10,frameTransparency)
friendspawn.Size = UDim2.new(1,0,0,40)
local friendspawnId = gui("TextBox","Friend",buttonBackground,"Friends ID",friendspawn,10,frameTransparency)
friendspawnId.Text = ""
friendspawnId.Size = UDim2.new(0.45,0,0,40)
friendspawnId.Position = UDim2.new(0,0,0,0)
local friendspawnCount = gui("TextBox","Friend",buttonBackground,"Count",friendspawn,10,frameTransparency)
friendspawnCount.Text = "1"
friendspawnCount.Position = UDim2.new(0.5,0,0,0)
friendspawnCount.Size = UDim2.new(0.45,0,0,40)
local spawnfriendbutton = gui("TextButton","Friend",buttonBackground,"Friends ID",main,10,frameTransparency)
spawnfriendbutton.Size = UDim2.new(1,0,0,40)
spawnfriendbutton.MouseButton1Click:Connect(function()
	getgenv().UserIDChar = tonumber(friendspawnId.Text) or 1079792491
	loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/El%20Konten/fake-bot.lua"))()
end)
--============================================================================================================
-- tools
--============================================================================================================
local Tools = gui("ScrollingFrame","Tools",mainBackground,"Tools",rightPanel,10,1)
Tools.Size = UDim2.new(1,0,1,0)
Tools.CanvasSize = UDim2.new(0,0,0,1000)
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
local function Tracking(color)
	trackToggle = not trackToggle
	if trackToggle and not game.Workspace:GetAttribute("LIUDEX_TRACKING") then
		Tracker.Text = "UnTrack"
		for i,v in pairs(Players:GetPlayers()) do
			local highlight = Instance.new("Highlight")
			highlight.Parent = v.Character
			highlight.Adornee = v.Character
			highlight.Name = "Highlight"
			highlight.FillColor = color or hlColor
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
end
Tracker.MouseButton1Click:Connect(function()
		local args = string.split(trackConfig.Text, ",")
		local colorT = Color3.fromRGB(args[1], args[2], args[3])
		task.spawn(function()
			Tracking(colorT)
		end)
end)
local TPTitle = gui("TextLabel","Tp",mainBackground,"Go To Player",Tools,10,1)
TPTitle.Size = UDim2.new(1,0,0,20)
TPTitle.Position = UDim2.new(0,0,0,10)
local TP = gui("TextBox","TPInput",buttonBackground,"",Tools,10,frameTransparency)
TP.Text = ""
TP.PlaceholderText = "Username.."
TP.Size = UDim2.new(1,0,0,40)
TP.TextColor3 = textColor
TP.PlaceholderColor3 = textColor
TP.FocusLost:Connect(function(enterPress)
    if enterPress then
        local root = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local inputText = TP.Text:lower()

        -- Cari player yang namanya mengandung inputText
        local targetPlayer
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Name:lower():sub(1, #inputText) == inputText then
                targetPlayer = plr
                break
            end
        end

        if targetPlayer and targetPlayer.Character then
            local targetRoot = targetPlayer.Character:WaitForChild("HumanoidRootPart")
            root.CFrame = targetRoot.CFrame
        else
            warn("Player dengan prefix '"..TP.Text.."' tidak ditemukan atau belum spawn.")
        end
    end
end)
local hopServer = gui("TextLabel","Tp",mainBackground,"Hop Server",Tools,10,1)
hopServer.Size = UDim2.new(1,0,0,20)
hopServer.Position = UDim2.new(0,0,0,10)
local sHop = gui("TextBox","TPInput",buttonBackground,"",Tools,10,frameTransparency)
sHop.Text = ""
sHop.PlaceholderText = "Max Player.."
sHop.Size = UDim2.new(1,0,0,40)
sHop.TextColor3 = textColor
sHop.PlaceholderColor3 = textColor
sHop.FocusLost:Connect(function(enterPress)
    if enterPress then
		local max = tonumber(sHop.Text)
		if max == "" or max == 0 then
			max = 100
		end
        hopServers(max)
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
local FreecamTitle = gui("TextLabel","Camera",mainBackground,"Camera",Tools,10,1)
FreecamTitle.Size = UDim2.new(1,0,0,20)
local inputCamSpeed = gui("TextBox","InputCamSpeed",buttonBackground,"CamSpeed",Tools,10,frameTransparency)
inputCamSpeed.Size = UDim2.new(1,0,0,40)
inputCamSpeed.TextColor3 = textColor
inputCamSpeed.Text = ""
inputCamSpeed.PlaceholderText = "Camera speed.."
inputCamSpeed.PlaceholderColor3 = textColor 
inputCamSpeed.FocusLost:Connect(function()
	speed = tonumber(inputCamSpeed.Text)
end)
local Freecam = gui("TextButton","FreeCam",buttonBackground,"FreeCam",Tools,10,frameTransparency)
Freecam.Size = UDim2.new(1,0,0,40)
Freecam.MouseButton1Click:Connect(function()
	toggleFreecam()
end)

local Drone = gui("TextBox","Drone",buttonBackground,"Set Max Zoom",Tools,10,frameTransparency)
Drone.Size = UDim2.new(1,0,0,40)
Drone.TextColor3 = textColor
Drone.Text = ""
Drone.PlaceholderText = "Max Zoom Out"
Drone.PlaceholderColor3 = textColor 
local zoomConn
Drone.FocusLost:Connect(function(enterPress)
	
	if enterPress then
		local maxcam = tonumber(Drone.Text)
		local player = Players.LocalPlayer
		if not maxcam or maxcam <= 0 then
			return
		end
		if zoomConn then
			zoomConn:Disconnect()
		end
		player.CameraMinZoomDistance = 0.5
		player.CameraMaxZoomDistance = maxcam
		zoomConn = player.Changed:Connect(function(prop)
			if prop == "CameraMaxZoomDistance" and player.CameraMaxZoomDistance ~= maxcam then
				print("Changed")
				player.CameraMaxZoomDistance = maxcam
				task.wait(1)
			end
		end)
	end
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
local settingsLayout = createLayout(Settings,UDim.new(0,10))
local settingsPadding = createPadding(Settings,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,18))

NameR = gui("TextBox","Input",buttonBackground,"",Settings,10,frameTransparency)
NameR.Size = UDim2.new(1,0,0,40)
NameR.PlaceholderColor3 = textColor
NameR.TextColor3 = textColor
NameR.PlaceholderText = "Name.."
NameR.Text = ""

AutoExecuteScript = gui("TextBox","Input",buttonBackground,"",Settings,10,frameTransparency)
AutoExecuteScript.Size = UDim2.new(1,0,0,40)
AutoExecuteScript.PlaceholderColor3 = textColor
AutoExecuteScript.TextColor3 = textColor
AutoExecuteScript.PlaceholderText = "Script.."
AutoExecuteScript.Text = ""

AddDirectScript = gui("TextButton","Button",buttonBackground,"Add Script",Settings,10,frameTransparency)
AddDirectScript.Size = UDim2.new(1,0,0,40)
AddDirectScript.MouseButton1Click:Connect(function()
	local Sname = tostring(NameR.Text)
	local Dscript = tostring(AutoExecuteScript.Text)
	if Sname ~= "" and Dscript ~= "" then
		Notify("Succes Added Script","Added ".. Sname .. " To Auto Execute list")
		addDirectScript(Sname,Dscript)
	else
		Notify("Failed Added Script","Please input name and the script you want to set")
	end
end)

ScriptList = gui("TextButton","Button",buttonBackground,"List Script",Settings,10,frameTransparency)
ScriptList.Size = UDim2.new(1,0,0,40)
local ScriptListDropDown
local scriptlistopen = false

ScriptList.MouseButton1Click:Connect(function()
	scriptlistopen = not scriptlistopen
	if scriptlistopen then
		ScriptListDropDown = gui("ScrollingFrame","Button",Color3.fromRGB(0,0,0),"List Script",ScriptList,10,0)
		ScriptListDropDown.Position = UDim2.new(0,0,0,40)
		ScriptListDropDown.Size = UDim2.new(1,0,5,0)
		ScriptListDropDown.ZIndex = 100
		ScriptListDropDown.CanvasSize = UDim2.new(0,0,0,1000)
		border("Border",buttonBackground,3,ScriptListDropDown)
		ScriptListDropDown.ScrollBarThickness = 8
		createLayout(ScriptListDropDown,UDim.new(0,10))
		createPadding(ScriptListDropDown,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,18))

		for i,v in ipairs(listfiles(file .. "/" .. tostring(Place))) do
			local str = string.split(v,"/")
			local scrptName = str[#str]
			local scrpt = gui("TextButton","Button",buttonBackground,scrptName,ScriptListDropDown,10,frameTransparency)
			scrpt.Size = UDim2.new(1,0,0,40)
			scrpt.ZIndex = 101
			scrpt.MouseButton1Click:Connect(function()
				ScriptList.Text = scrpt.Text
				ScriptListDropDown:Destroy()
				ScriptListDropDown = nil
				scriptlistopen = false
			end)
		end
	else
		if ScriptListDropDown then
			ScriptListDropDown:Destroy()
			ScriptListDropDown = nil
		end
	end
end)


RemoveDirectScript = gui("TextButton","Button",buttonBackground,"Remove Script",Settings,10,frameTransparency)
RemoveDirectScript.Size = UDim2.new(1,0,0,40)
RemoveDirectScript.MouseButton1Click:Connect(function()
	local Sname = tostring(ScriptList.Text)
	if Sname ~= "" then
		Notify("Succes Removed Script","Removed ".. Sname .. " From Auto Execute list")
		delfile(file .. "/" .. tostring(Place) .. "/" .. Sname)
	else
		Notify("Failed Removed Script","Please input the Name")
	end
end)

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
    for i,v in ipairs(Lighting:GetChildren()) do
		v:Destroy()
	end
	-- Matikan shadow
	Lighting.GlobalShadows = false
	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0

	-- Fog biar ringan
	Lighting.FogStart = 0
	Lighting.FogEnd = 10000000
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
DisableMesh = gui("TextButton","Button",buttonBackground,"Disable Mesh",Settings,10,frameTransparency)
DisableMesh.Size = UDim2.new(1,0,0,40)
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
DisableTerrain = gui("TextButton","Button",buttonBackground,"Disable Terrain",Settings,10,frameTransparency)
DisableTerrain.Size = UDim2.new(1,0,0,40)
DisableTerrain.MouseButton1Click:Connect(function()
	local workspace = game:GetService("Workspace")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local terrain = workspace:WaitForChild("Terrain")

	if terrain then
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		for _, v in ipairs(terrain:GetChildren()) do
			v:Destroy()
		end
	end
end)

local FPSCap = gui("TextBox","Input",buttonBackground,"Atmosphere",Settings,10,frameTransparency)
FPSCap.Size = UDim2.new(1,0,0,40)
FPSCap.Position = UDim2.new(0,0,0,520)
FPSCap.ClearTextOnFocus = false
FPSCap.Text = ""
FPSCap.PlaceholderText = "FPS Cap.."
FPSCap.TextColor3 = textColor
FPSCap.PlaceholderColor3 = textColor
local currentFPS
FPSCap.FocusLost:Connect(function(enterPress)
	if enterPress then
		if currentFPS then
			currentFPS:Disconnect()
		end
		local fps = tonumber(FPSCap.Text)
		if fps then
			currentFPS = setfpscap(fps)
		end
	end
end)
----------------------------------------------------------------------------------------------------------------
--KeyBind
----------------------------------------------------------------------------------------------------------------
local function KeyCode(this, setSubject)
	this:GetPropertyChangedSignal("Text"):Connect(function()
		-- apus spasi
		this.Text = this.Text:gsub("%s+", "")

		-- max 1 huruf
		if #this.Text > 1 then
			this.Text = this.Text:sub(1, 1)
		end

		-- auto kapital
		this.Text = this.Text:upper()

		-- convert ke Enum.KeyCode
		local key = Enum.KeyCode:FromName(this.Text)
		if key then
			setSubject(key) -- update variable luar
		end
	end)
end


local KeyBind = gui("ScrollingFrame","Settings",buttonBackground,"Settings",rightPanel,10,1)
KeyBind.Size = UDim2.new(1,0,1,0)
KeyBind.CanvasSize = UDim2.new(0, 0, 0, 1000)
KeyBind.ScrollBarThickness = 8
KeyBind.Position = UDim2.new(0,0,0,0)
local KeyBindLayout = createLayout(KeyBind,UDim.new(0,10))
local KeyBindPadding = createPadding(KeyBind,UDim.new(0,10),UDim.new(0,10),UDim.new(0,10),UDim.new(0,18))
-- freeCam
local FCKey = gui("Frame","FCkey",buttonBackground,"FCKey",KeyBind,10,frameTransparency)
FCKey.Size = UDim2.new(1,0,0,40)
local FCKeyInput = gui("TextBox","FCinput",buttonBackground,"Key Code..",FCKey,10,0.1)
FCKeyInput.Size = UDim2.new(0.3,0,0,35)
FCKeyInput.Position = UDim2.new(0.6,0,0,2.5)
FCKeyInput.TextColor3 = textColor
FCKeyInput.Text = "F"

local FCKeyCode = Enum.KeyCode:FromName(FCKeyInput.Text)

KeyCode(FCKeyInput, function(newKey)
	FCKeyCode = newKey
	print("FCKeyCode updated:", FCKeyCode)
end)

local FCKeyText = gui("TextLabel","Freecam Key",mainBackground,"Free Cam",FCKey,10,1)
FCKeyText.Size = UDim2.new(0.5,0,0,40)
FCKeyText.Position = UDim2.new(0.02,0,0,0)
FCKeyText.TextSize = 100
FCKeyText.TextXAlignment = Enum.TextXAlignment.Left
-- Track
local TrackerKey = gui("Frame","FCkey",buttonBackground,"FCKey",KeyBind,10,frameTransparency)
TrackerKey.Size = UDim2.new(1,0,0,40)
local TrackerKeyInput = gui("TextBox","FCinput",buttonBackground,"Key Code..",TrackerKey,10,0.1)
TrackerKeyInput.Size = UDim2.new(0.3,0,0,35)
TrackerKeyInput.Position = UDim2.new(0.6,0,0,2.5)
TrackerKeyInput.TextColor3 = textColor
TrackerKeyInput.Text = "T"

local TrackerCode = Enum.KeyCode:FromName(TrackerKeyInput.Text)

KeyCode(TrackerKeyInput, function(newKey)
	TrackerCode = newKey
	print("FCKeyCode updated:", TrackerCode)
end)

local TrackerText = gui("TextLabel","Freecam Key",mainBackground,"Free Cam",TrackerKey,10,1)
TrackerText.Size = UDim2.new(0.5,0,0,40)
TrackerText.Position = UDim2.new(0.02,0,0,0)
TrackerText.TextSize = 100
TrackerText.TextXAlignment = Enum.TextXAlignment.Left
----------------------------------------------------------------------------------------------------------------
--KeyCode
----------------------------------------------------------------------------------------------------------------
-- FC
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == FCKeyCode then
		toggleFreecam()
	end
	if input.KeyCode == TrackerCode then
		local args = string.split(trackConfig.Text, ",")
		local colorT = Color3.fromRGB(args[1], args[2], args[3])
		task.spawn(function()
			Tracking(colorT)
		end)
	end
end)

--++ close Prompt
local closeButton = gui("TextButton","CloseButton",Color3.fromRGB(255,0,0),"X",frame,10,1)
closeButton.Size = UDim2.new(0.05,0,0.1,0)
closeButton.Position = UDim2.new(0.95,0,0,0)
local closeaccept = gui("Frame","Button",backgroundColor,"Destroy ui",screenGui,10,0)
closeaccept.Position = UDim2.new(0.4,0,0.3,50)
closeaccept.Size = UDim2.new(0.24,0,0,150)
closeaccept.Visible = false

local closeacceptborder = border("border",Color3.fromRGB(255,255,255),4,closeaccept)
local closeOk = gui("TextButton","Close",Color3.fromRGB(81, 255, 0),"Ok",closeaccept,10,0)
local closeCancel = gui("TextButton","Cancel",Color3.fromRGB(255, 0, 4),"Cancel",closeaccept,10,0)
local closeTitle = gui("TextLabel","Text",Color3.fromRGB(255,255,255),"Do you want to close LIUDEX",closeaccept,0,1)
closeTitle.Size = UDim2.new(1,-10,0,50)
closeCancel.Size = UDim2.new(0.48,0,0,50)
closeOk.Size = UDim2.new(0.48,0,0,50)
closeOk.Position = UDim2.new(0.51,0,0.48,0)
closeCancel.Position = UDim2.new(0.01,0,0.48,0)

closeButton.MouseButton1Click:Connect(function()
	closeaccept.Visible = true
end)
closeOk.MouseButton1Click:Connect(function()
	closeaccept.Visible = false
	clossed = true
	getgenv().LiudexStart = false
	if zoomConn then
		zoomConn:Disconnect()
	end
	screenGui:Destroy()
	
	if freezcon then
		toggleFreecam()
	end
	if clossed then
		cam.CameraType = oldCameraType
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		if freezcon then
			freezcon:Disconnect()
			freezcon = nil
		end
		FCKeyCode = nil
		TrackerCode = nil
		keysDown = {}
		rotating = false
		UIS.MouseBehavior = Enum.MouseBehavior.Default
		cam = nil
		humanoid = nil
		char = nil
	end
end)

player.CharacterAdded:Connect(function()
	if not clossed then
		char = player.Character or player.CharacterAdded:Wait()
		if char then
			humanoid = char:WaitForChild("Humanoid")
		end
	end
end)

closeCancel.MouseButton1Click:Connect(function()
	closeaccept.Visible = false
end)
-- function
local function show(ui)
	main.Visible = false
	Tools.Visible = false
	Misc.Visible = false
	KeyBind.Visible = false
	Settings.Visible = false
	main.Active = false
	Tools.Active = false
	Misc.Active = false
	Settings.Active = false
	KeyBind.Active = false
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
KeyBindButton.MouseButton1Click:Connect(function()
	show(KeyBind)
end)
local toggle = false -- mulai dari OFF

iconButton.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
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
--task.spawn(function()
-- while true do
--	if partyServer then
--		local url = "https://loremipsumapps.infinityfree.me/roblox-script/users/" 
--			.. tostring(partyServer)
--		task.wait(delayGet)
--		print(url)
--	else
--		warn("partyServer masih nil, isi dulu sebelum dipakai")
--		task.wait(delayGet)
--	end
--end
--end
