local screengui = Instance.new("ScreenGui")
local textColor = Color3.fromRGB(255,255,255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local buttonBackground = Color3.fromRGB(56, 0, 154)
local workspace = game:GetService("Workspace")
local Camera = workspace.CurrentCamera

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local frameColor = Color3.fromRGB(30, 30, 30)
local transparency = 0.5
local SocialService = game:GetService("SocialService")
local GroupService = game:GetService("GroupService")
local specialButton = Color3.fromRGB(235, 209, 10)
--PLAYER
local StarterGui = game:GetService("StarterGui")
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
-- prop

screengui.Parent = gethui()
screengui.ResetOnSpawn = false
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

local function smallNotify(title,text,button1,button2,call)
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Icon = "rbxassetid://71775514575470", -- contoh ikon notifikasi default
		Text = text,
		Duration = 4,
		Button1 = button1 or nil,
		Button2 = button2 or nil,
		Callback = call or nil
	})
end

local function border(name,color,thickness,parrent)
	local border = Instance.new("UIStroke")
	border.Parent = parrent
	border.Name = name
	border.Color = color
	border.Thickness = thickness
	return border
end

local frame = gui("Frame","MainFrame",frameColor,"Text",screengui,10,0)
frame.Size = UDim2.new(0.6,0,0.8,0)
frame.Position = UDim2.new(0.2,0,0.01,0)
local frameBorder = border("FrameBorder",Color3.fromRGB(64, 0, 227),4,frame)
local closeButton = gui("TextButton","CloseButton",Color3.fromRGB(255,0,0),"X",frame,10,1)
closeButton.Size = UDim2.new(0.05,0,0.1,0)
closeButton.Position = UDim2.new(0.95,0,0,0)

local icon = gui("ImageButton","Icon",Color3.fromRGB(255,255,255),nil,screengui,7,0)
icon.Size = UDim2.new(0,55,0,55)
icon.Position = UDim2.new(0.04,0,0.5,0)
icon.Image = "rbxassetid://109307491767726"
iconBorder = border("IconBorder",Color3.fromRGB(98, 7, 255),2,icon)
icon.ZIndex = 200
local icontoggle = true
icon.MouseButton1Click:Connect(function()
icontoggle = not icontoggle
	if icontoggle then
		frame.Visible = true
	else
		frame.Visible = false
	end
end)
-- main ui
local function layouts(parent)
	local Layout = Instance.new("UIListLayout")
	Layout.Parent = parent
	Layout.Padding = UDim.new(0,10)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Layout.VerticalAlignment = Enum.VerticalAlignment.Top
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	return Layout
end
local function paddings(parent,pad)
	local Padding = Instance.new("UIPadding")
	Padding.Parent = parent
	Padding.PaddingTop = UDim.new(0,pad)
	Padding.PaddingBottom = UDim.new(0,pad)
	Padding.PaddingLeft = UDim.new(0,pad)
	Padding.PaddingRight = UDim.new(0,pad)
	return Padding
end
local leftPanel = gui("Frame","LeftPanel",backgroundColor,"Text",frame,10,1)
leftPanel.Size = UDim2.new(0.3,0,0.88,0)
leftPanel.Position = UDim2.new(0,0,0.02,45)
local leftBorder = border("LeftBorder",Color3.fromRGB(64, 0, 227),3,leftPanel)
local rightPanel = gui("Frame","RightPanel",backgroundColor,"Text",frame,10,1)
rightPanel.Size = UDim2.new(0.7,0,0.88,0)
rightPanel.Position = UDim2.new(0.3,0,0.02,45)
local rightBorder = border("LeftBorder",Color3.fromRGB(64, 0, 227),3,rightPanel)
local topPanel = gui("Frame","TopPanel",Color3.fromRGB(66, 10, 150),"Text",frame,10,1)
topPanel.Size = UDim2.new(1,0,0.12,0)
topPanel.Position = UDim2.new(0,0,0,0)
local topBorder = border("LeftBorder",Color3.fromRGB(64, 0, 227),3,topPanel)
topTitle = gui("TextLabel","TopTitle",Color3.fromRGB(255,255,255),"LIUDEX BLOX FRUIT [Beta 0.2]",topPanel,10,1)
topTitle.Size = UDim2.new(0.5,-20,0,30)
topTitle.Position = UDim2.new(0.3,0,0,10)
-- layout
local leftLayout = layouts(leftPanel)
local leftPadding = paddings(leftPanel,10)
makeDraggable(icon)
makeDraggable(frame)
local btn1 = gui("TextButton","Btn1",buttonBackground,"Home",leftPanel,8,0)
btn1.Size = UDim2.new(1,-20,0,40)
btn1.MouseButton1Click:Connect(function()
	print("Home")
end)

local btn2 = gui("TextButton","Btn2",buttonBackground,"Main",leftPanel,8,0)
btn2.Size = UDim2.new(1,-20,0,40)

local btn3 = gui("TextButton","Btn3",buttonBackground,"Modify",leftPanel,8,0)
btn3.Size = UDim2.new(1,-20,0,40)

local btn4 = gui("TextButton","Btn4",buttonBackground,"Settings",leftPanel,8,0)
btn4.Size = UDim2.new(1,-20,0,40)

local btn5 = gui("TextButton","Btn5",buttonBackground,"Keybind",leftPanel,8,0)
btn5.Size = UDim2.new(1,-20,0,40)

--=======
--Home
--=======
local home = gui("Frame","Home",Color3.fromRGB(255,255,255),"Text",rightPanel,10,1)
home.Size = UDim2.new(1,-20,0.5,-20)
homeLayout = layouts(home)
homePadding = paddings(home,10)
local homeTitle = gui("TextLabel","HomeTitle",Color3.fromRGB(255,255,255),"Home",home,10,1)
homeTitle.Size = UDim2.new(0.5,-20,0,20)

local discord = gui("TextButton","Discord",buttonBackground,"Discord",home,10,0)
discord.Size = UDim2.new(1,-20,0,40)
discord.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/WmsssRkgd2")
end)



local donation = gui("TextButton","Discord",buttonBackground,"Donate",home,10,0)
donation.Size = UDim2.new(1,-20,0,40)
donation.MouseButton1Click:Connect(function()
	setclipboard("Donate")
end)

local profile = gui("TextButton","profile",buttonBackground,"Our Profile",home,10,0)
profile.Size = UDim2.new(1,-20,0,40)
profile.MouseButton1Click:Connect(function()
	setclipboard("Our Profile")
end)




--==================
--Main
--==================

local skinList = {"Black Panther","Monarch Lighting", "Abyss Pain","Pain Over Heaven", "Imperial Lighting","Cursed Rift Portal", "Nihility Portal", "Imperial Dragon Sovereign"}
local listSkins = {
	blackpantherTiger = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/black-panther.lua",
	abyssPain = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/abyssPain.lua",
	cursePortal = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/CursedVoidPortal",
	nihilityPortal = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/NihilityPortal.lua",
	heavenlyPain = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/heavenlyPain.lua",
	monarchLighting = "https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/bloxfruit/monarch-lighting.lua"
}
local boltable = {}
function ActivedSkin()
	for _, v in pairs(boltable) do
		if _ == "Black Panther" and v then
			loadstring(game:HttpGet(listSkins.blackpantherTiger))()
		end
		if _ == "Abyss Pain" and v then
			loadstring(game:HttpGet(listSkins.abyssPain))()
		end
		if _ == "Pain Over Heaven" and v then
			loadstring(game:HttpGet(listSkins.heavenlyPain))()
		end
		if _ == "Monarch Lighting" and v then
			print(listSkins.monarchLighting)
			task.wait(2)
			print(_, "Loaded")
		end
		if _ == "Monarch Pain" and v then
			print(listSkins.blackpantherTiger)
			task.wait(2)
			print(_, "Loaded")
		end
	end
end
local main = gui("Frame","Main",Color3.fromRGB(255,255,255),"Text",rightPanel,10,1)
main.Size = UDim2.new(1,-20,0.5,-20)
mainLayout = layouts(main)
mainPadding = paddings(main,10)
local mainTitle = gui("TextLabel","MainTitle",Color3.fromRGB(255,255,255),"Main",main,10,1)
mainTitle.Size = UDim2.new(0.5,-20,0,20)
main.Visible = false

local skins = gui("TextButton","Skins",buttonBackground,"Skins",main,10,0)
skins.Size = UDim2.new(1,-20,0,40)
local skintoggle = false
local dropdown = gui("ScrollingFrame","SkinList",Color3.fromRGB(0, 0, 0),"Text",skins,10,0)
dropdownBorder = border("Dropdown",Color3.fromRGB(255,255,255),2,dropdown)
dropdown.Position = UDim2.new(0,0,0,40)
dropdown.Size = UDim2.new(1,0,5,0)
dropdown.ScrollBarThickness = 10
dropdown.CanvasSize = UDim2.new(0,0,0,300)
dropdown.Visible = false
dropdown.ZIndex = 100
droplayout = layouts(dropdown)
dropdownPadding = paddings(dropdown,10)
local function showSkinsList(bol)
	if bol == 1 then
		for i,v in pairs(skinList) do
			dropdown.Visible = true
		end
	else
		for i,v in pairs(skinList) do
			dropdown.Visible = false
		end
	end
end
skins.MouseButton1Click:Connect(function()
	skintoggle = not skintoggle
	print("Skins " .. tostring(skintoggle))
	if skintoggle then
		showSkinsList(1)
	else
		showSkinsList(0)
	end
end)
local bindReset = Instance.new("BindableFunction")
bindReset.OnInvoke = function()
	char.Humanoid.Health = 0
end

local GROUP_ID = 411609583
for i, v in pairs(skinList) do
	if v == "Imperial Dragon Sovereign" then
		local btn = gui("TextButton", v, buttonBackground, v, dropdown, 10, 0)
		btn.Size = UDim2.new(1, 0, 0, 40)
		btn.ZIndex = 101
		boltable[tostring(v)] = false
		btn.TextColor3 = specialButton
		local btnBorder = border("Dropdown", Color3.fromRGB(50, 0, 100), 2, btn)
		btn.MouseButton1Click:Connect(function()
			if player:IsInGroup(GROUP_ID) then
				local activeSkin = boltable[v]
				activeSkin = not activeSkin
				if activeSkin then
					for i,v in pairs(boltable) do
						boltable[i] = false
					end
					boltable[tostring(v)] = true
					print(boltable)
					smallNotify("LIUDEX Z","Loading " .. tostring(v) .. " Skin","Close")
					smallNotify("LIUDEX Z","Stoping " .. tostring(v) .. " Skin Reset to remove it","Reset","Close",bindReset)
				else
					boltable[tostring(v)] = false
					print(boltable)
				end
			else
				GroupService:PromptJoinAsync(GROUP_ID)
				smallNotify("LIUDEX Z","Join Group to use " .. tostring(v) .. " Skin","Close")
			end
		end)
	else
		local btn = gui("TextButton", v, buttonBackground, v, dropdown, 10, 0)
		btn.Size = UDim2.new(1, 0, 0, 40)
		btn.ZIndex = 101
		buttonBorder = border("Dropdown",Color3.fromRGB(50, 0, 100),2,btn)
		boltable[tostring(v)] = false
		btn.MouseButton1Click:Connect(function()
			local activeSkin = boltable[v]
			activeSkin = not activeSkin
			if activeSkin then
				for i,v in pairs(boltable) do
					boltable[i] = false
				end
				boltable[tostring(v)] = true
				print(boltable)
				smallNotify("LIUDEX Z","Loading " .. tostring(v) .. " Skin","Close")
				task.wait()
				ActivedSkin()
			else
				boltable[tostring(v)] = false
				print(boltable)
				smallNotify("LIUDEX Z","Stoping " .. tostring(v) .. " Skin Reset to remove it","Reset","Close",bindReset)
			end
		end)
	end
end
task.spawn(function()
	player.CharacterAdded:Connect(function()
		ActivedSkin()
	end)
end)

print(boltable)
--=================
--Tool
--=================
local tool = gui("ScrollingFrame","Tool",Color3.fromRGB(255,255,255),"Text",rightPanel,10,1)
tool.ScrollBarThickness = 10
tool.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
tool.CanvasSize = UDim2.new(0,0,0,500)
tool.Size = UDim2.new(1,-20,1,-20)
toolLayout = layouts(tool)
toolPadding = paddings(tool,10)
local toolTitle = gui("TextLabel","ToolTitle",Color3.fromRGB(255,255,255),"Tool",tool,10,1)
toolTitle.Size = UDim2.new(0.5,-20,0,20)
tool.Visible = false

local fruitListButton = gui("TextButton","Fruit",buttonBackground,"Fruit",tool,10,0)
fruitListButton.Size = UDim2.new(1,-0,0,40)
fruitListButton.Text = "Fruit"
local fruitList = {"Tiger","Dragon","Pain","Lighting","Diamond","Bomb"}
local dropdownFruit = gui("ScrollingFrame","SkinList",Color3.fromRGB(0, 0, 0),"Text",fruitListButton,10,0)
dropdownFruitBorder = border("Dropdown",buttonBackground,2,dropdownFruit)
dropdownFruit.Position = UDim2.new(0,0,0,40)
dropdownFruit.Size = UDim2.new(1,0,0,200)
dropdownFruit.ScrollBarThickness = 10
dropdownFruit.CanvasSize = UDim2.new(0,0,0,500)
dropdownFruit.Visible = false
dropdownFruit.ZIndex = 100
dropdownFruitlayout = layouts(dropdownFruit)
dropdownFruitPadding = paddings(dropdownFruit,10)
local function showFruitList(bol)
	if bol == 1 then
		dropdownFruit.Visible = true
	else
		dropdownFruit.Visible = false
	end
end
local fruitToggle = false
local selecterdFruitEdit = nil
for i,v in pairs(fruitList) do
	local buttonz = gui("TextButton",v,buttonBackground,tostring(v),dropdownFruit,10,0)
	buttonz.Size = UDim2.new(1,-0,0,40)
	buttonz.TextColor3 = Color3.fromRGB(255,255,255)
	buttonz.Text = tostring(v)
	buttonz.ZIndex = 101
	buttonz.MouseButton1Click:Connect(function()
	selecterdFruitEdit = tostring(v)
	showFruitList(0)
	fruitToggle = false
	fruitListButton.Text = tostring(v)
	end)
end

fruitListButton.MouseButton1Click:Connect(function()
	fruitToggle = not fruitToggle
	print("Skins " .. tostring(fruitToggle))
	if fruitToggle then
		showFruitList(1)
	else
		showFruitList(0)
	end
end)
local colorAttributeButton = gui("TextButton","Color",buttonBackground,"Color",tool,10,0)
colorAttributeButton.Size = UDim2.new(1,-0,0,40)
local colorAttributeDropDown = gui("ScrollingFrame","ColorList",Color3.fromRGB(0, 0, 0),"Text",colorAttributeButton,10,0)
colorAttributeDropDown.Position = UDim2.new(0,0,0,40)
colorAttributeDropDown.Size = UDim2.new(1,0,0,200)
colorAttributeDropDown.ScrollBarThickness = 10
colorAttributeDropDown.CanvasSize = UDim2.new(0,0,0,100)
colorAttributeDropDown.Visible = false
colorAttributeDropDown.ZIndex = 100
local colorAttributeDropDownlayout = layouts(colorAttributeDropDown)
local colorAttributeDropDownPadding = paddings(colorAttributeDropDown,10)
local colorFruit = {"Default","Shifted"}
local editData = {}
for i,v in pairs(colorFruit) do
	local buttonz = gui("TextBox",v,buttonBackground,tostring(v),colorAttributeDropDown,10,0)
	buttonz.Size = UDim2.new(1,-0,0,40)
	buttonz.TextColor3 = Color3.fromRGB(255,255,255)
	buttonz.Text = tostring(v)
	buttonz.ZIndex = 101
	buttonz.FocusLost:Connect(function()
		editData[i] = buttonz.Text
	end)
end
colorAttributeButton.MouseButton1Click:Connect(function()
	colorAttributeDropDown.Visible = not colorAttributeDropDown.Visible
end)
local modify = gui("TextButton","Modify",buttonBackground,"Modify",tool,10,0)
modify.Size = UDim2.new(1,-0,0,40)
modify.Text = "Modify"
modify.MouseButton1Click:Connect(function()
	if editData then
		local defaultColor = editData[1]
		local shiftedColor = editData[2]
		print(defaultColor .." " .. shiftedColor)
	end
end)
--====================
--Settings
--====================
local settings = gui("ScrollingFrame","Settings",buttonBackground,"Text",rightPanel,10,1)
settings.ScrollBarThickness = 10
settings.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
settings.CanvasSize = UDim2.new(0,0,0,100)
settings.Size = UDim2.new(1,-20,1,-20)
settings.Visible = false

settingsLayout = layouts(settings)
settingsPadding = paddings(settings,10)

local keybindsTitle = gui("TextLabel","KeybindsTitle",buttonBackground,"Keybinds",settings,10,1)
keybindsTitle.Size = UDim2.new(0.5,-20,0,20)

local keybindsButton = gui("TextButton","KeybindsButton",buttonBackground,"Keybinds",settings,10,0)
keybindsButton.Size = UDim2.new(1,-20,0,40)
keybindsButton.Text = "Keybinds"

local keybinds = gui("ScrollingFrame","KeybindsFrame",backgroundColor,"Text",settings,10,0)
keybinds.Size = UDim2.new(1,-20,0.5,-20)
keybinds.ScrollBarThickness = 10
keybinds.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
keybinds.CanvasSize = UDim2.new(0,0,0,100)
keybinds.Visible = false

keybindslayout = layouts(keybinds)
keybindsPadding = paddings(keybinds,10)

keybindsButton.MouseButton1Click:Connect(function()
	keybinds.Visible = not keybinds.Visible
end)
local keyList = {
	"A","B","C","D","E",
	"G","H","J","K","L","M","N",
	"P","Q","R","S","T","U","V","W","X","Y","Z",
	"0","5","6","7","8","9"
}
local selectedKey = {}
for i,v in pairs(keyList) do
	local key = gui("Frame","Bg_".. v,buttonBackground,"KeyCode ".. v,keybinds,10,0)
	key.Size = UDim2.new(1,-5,0,40)
	key.ZIndex = 10
	local keyText = gui("TextLabel","Text",buttonBackground,v,key,10,0)
	keyText.Size = UDim2.new(0.5,-10,1,0)
	keyText.ZIndex = 11
	local keyInput = gui("TextBox","Input",buttonBackground,"",key,10,0)
	keyInput.Size = UDim2.new(0.5,-10,1,0)
	keyInput.ZIndex = 12
	keyInput.Text = v
	keyInput.PlaceholderText = "Press a key.."
	keyInput.TextColor3 = Color3.fromRGB(255,255,255)
	keyInput.TextXAlignment = Enum.TextXAlignment.Center
	keyInput.TextScaled = false
	keyInput.TextSize = 14
	keyInput.ClearTextOnFocus = false
	local code = gui("TextBox","Input",buttonBackground,"",key,10,0)
	code.Size = UDim2.new(0.5,-10,1,0)
	code.Position = UDim2.new(0.5,0,0,0)
	code.ZIndex = 12
	code.Text = v
	code.PlaceholderText = "Press a key.."
	code.TextColor3 = Color3.fromRGB(255,255,255)
	code.TextXAlignment = Enum.TextXAlignment.Center
	code.TextScaled = false
	code.TextSize = 14
	code.ClearTextOnFocus = false
	code.FocusLost:Connect(function()
		if keyInput.Text == "" then
			keyInput.Text = v
			selectedKey[i] = v
			selectedKey[i].v = code.Text
			print(selectedKey[i])
		end
	end)
end
--++++++++++++++++++++++++++++++++++
--End
--++++++++++++++++++++++++++++++++++
local closeaccept = gui("Frame","Button",backgroundColor,"Destroy ui",screengui,10,0)
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
local function show(ui)
	local var ={home,main,tool,settings,closeaccept}
	for i,v in pairs(var) do
		if v == ui then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end

-- Show
btn1.MouseButton1Click:Connect(function()
	show(home)
end)

btn2.MouseButton1Click:Connect(function()
	show(main)
end)

btn3.MouseButton1Click:Connect(function()
	show(tool)
end)
btn4.MouseButton1Click:Connect(function()
	show(settings)
end)
closeButton.MouseButton1Click:Connect(function()
	closeaccept.Visible = true
end)

closeOk.MouseButton1Click:Connect(function()
	closeaccept.Visible = false
	screengui:Destroy()
end)

closeCancel.MouseButton1Click:Connect(function()
	closeaccept.Visible = false
end)

player.CharacterAdded:Connect(function()
	char= player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
	task.wait(0.1)
	ActivedSkin()
end)
