local textColor = Color3.fromRGB(255,255,255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local buttonBackground = Color3.fromRGB(56, 0, 154)
local frameColor = Color3.fromRGB(81, 0, 161)
local screenGui = Instance.new("ScreenGui")
local HttpService = game:GetService("HttpService")
local buttonTransparency = 0.6
local plrparty = nil
local frameTransparency = 0.4
local Players = game:GetService("Players")

local UserInputService = game:GetService("UserInputService")
local borderColor = Color3.fromRGB(0, 0, 4) 
local mainBackground = backgroundColor
screenGui.Parent = gethui()
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

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
frame.Size = UDim2.new(0,600,0,350)
frame.Position = UDim2.new(0.5, -400, 0.5, -150)

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
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
leftPanel.Size = UDim2.new(0,150,0,305)
leftPanel.Position = UDim2.new(0,0,0,45)
local rightPanel = gui("Frame","RightPanel",backgroundColor,"Text",frame,10,frameTransparency)
rightPanel.Size = UDim2.new(0,447,0,305)
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
local Tools = gui("Frame","Tools",mainBackground,"Tools",rightPanel,10,1)
Tools.Size = UDim2.new(1,0,1,0)
Tools.Position = UDim2.new(0,0,0,0)

--============================================================================================================
-- misc
--============================================================================================================
local Misc = gui("Frame","Main",mainBackground,"Main",rightPanel,10,1)
Misc.Size = UDim2.new(1,0,1,0)
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
local cosmeticButton = gui("TextButton","Button",buttonBackground,"Apply",Misc,10,frameTransparency)
cosmeticButton.Size = UDim2.new(1,0,0,40)
cosmeticButton.Position = UDim2.new(0,0,0,50)
cosmeticButton.MouseButton1Click:Connect(function()
	local args = string.split(cosmeticControler.Text," ")
	local type = args[1]
	local parentName = args[2]
	local size = tonumber(args[3]) or 25

	local rgb = string.split(args[4], ",")
	local color = Color3.fromRGB(tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3]))

	cosmetic(type, parentName, size, color)
end)
--============================================================================================================
-- settings
--============================================================================================================
local Settings = gui("Frame","Main",mainBackground,"Main",rightPanel,10,1)
Settings.Size = UDim2.new(1,0,1,0)
Settings.Position = UDim2.new(0,0,0,0)
-- function
local function show(ui)
	main.Visible = false
	Tools.Visible = false
	Misc.Visible = false
	Settings.Visible = false
	task.wait()
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
	print("Misc")
end)
SettingsButton.MouseButton1Click:Connect(function()
	print("Settings")
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
while true do
	if partyServer then
		local url = "https://loremipsumapps.infinityfree.me/roblox-script/users/" 
			.. tostring(partyServer) .. "/script.lua"
		task.wait(delayGet)
		print(url)
	else
		warn("partyServer masih nil, isi dulu sebelum dipakai")
		task.wait(delayGet)
	end
end
show(main)
