local textColor = Color3.fromRGB(255,255,255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local buttonBackground = Color3.fromRGB(56, 0, 154)
local frameColor = Color3.fromRGB(81, 0, 161)
local screenGui = Instance.new("ScreenGui")
local HttpService = game:GetService("HttpService")
local buttonTransparency = 0.6
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
icon.Image = "rbxassetid://83078126930016" -- ganti dengan ID gambar kamu
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
-- main
local main = gui("Frame","Main",mainBackground,"Main",rightPanel,10,1)
main.Size = UDim2.new(1,0,1,0)
main.Position = UDim2.new(0,0,0,0)
local CreateButton = gui("TextButton","Button",buttonBackground,"Create",main,10,frameTransparency)
CreateButton.Size = UDim2.new(1,0,0,40)
CreateButton.Position = UDim2.new(0,0,0,10)
local Join = gui("Frame","Join",buttonBackground,"",main,10,frameTransparency)
Join.Size = UDim2.new(1,0,0,40) 
Join.Position = UDim2.new(0,0,0,55)
local JoinText = Instance.new("TextLabel")
JoinText.Size = UDim2.new(0.5,0,0,50)
JoinText.Position = UDim2.new(0,0,0,80)
JoinText.Text = "Insert UID"
JoinText.Parent = Join
local JoinBox = gui("TextBox","TextBox",Color3.fromRGB(38, 0, 255),"UID...",Join,10,frameTransparency)
JoinBox.Size = UDim2.new(0.5,0,0,35)
JoinBox.Text = "UID..."
JoinBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBox.Position = UDim2.new(0.5,0,0,2)
local JoinTextLabel = gui("TextLabel","TextLabel",Color3.fromRGB(255, 255, 255),"",Join,10,1)
JoinTextLabel.Size = UDim2.new(0.3,0,0,20)
JoinTextLabel.Position = UDim2.new(0,10,0,8)
JoinTextLabel.Text = "Insert UID/Party Id"
local JoinButton = gui("TextButton","Button",buttonBackground,"Join",main,10,frameTransparency)
JoinButton.Size = UDim2.new(1,0,0,40)
JoinButton.Position = UDim2.new(0,0,0,100)
--============================================================================================================
-- tools
--============================================================================================================
local Tools = gui("Frame","Tools",mainBackground,"Tools",rightPanel,10,1)
Tools.Size = UDim2.new(1,0,1,0)
Tools.Position = UDim2.new(0,0,0,0)

local CommandPanel= gui("TextBox","CommandInputPanel",buttonBackground,"Leader Command here...",Tools,10,frameTransparency)
CommandPanel.Size = UDim2.new(1,0,0,40)
CommandPanel.Text = "Lead Command here"
CommandPanel.TextColor3 = textColor
CommandPanel.Position = UDim2.new(0,0,0,10)
local CommandButtonAll = gui("TextButton","Button",buttonBackground,"Invoke To All",Tools,10,frameTransparency)
CommandButtonAll.Size = UDim2.new(1,0,0,40)
CommandButtonAll.Position = UDim2.new(0,0,0,55)
local CommandSelectMember = gui("TextBox","Button",buttonBackground,"Input 1 Member To Invoke",Tools,10,frameTransparency)
CommandSelectMember.Size = UDim2.new(0.5,0,0,40)
CommandSelectMember.Position = UDim2.new(0.5,0,0,100)
CommandSelectMember.TextColor3 = textColor
CommandSelectMember.Text = "Member"
local CommandButton = gui("TextButton","Button",buttonBackground,"Invoke To The Member",Tools,10,frameTransparency)
CommandButton.Size = UDim2.new(0.5,0,0,40)
CommandButton.Position = UDim2.new(0,0,0,100)
local LeaderCommandPanel = gui("TextBox","CommandInputPanel",buttonBackground,"",Tools,10,frameTransparency)
LeaderCommandPanel.Size = UDim2.new(1,0,0,40)
LeaderCommandPanel.Text = ""
LeaderCommandPanel.TextScaled = false
LeaderCommandPanel.TextSize = 18
LeaderCommandPanel.MultiLine = false           -- kalau cuma satu baris
LeaderCommandPanel.TextColor3 = textColor
LeaderCommandPanel.TextXAlignment = Enum.TextXAlignment.Left
LeaderCommandPanel.Position = UDim2.new(0,0,0,145)

-- padding 5px
local padding = Instance.new("UIPadding")
padding.Parent = LeaderCommandPanel
padding.PaddingLeft = UDim.new(0,5)
local LeaderCommandButton = gui("TextButton","Button",buttonBackground,"Run Code",Tools,10,frameTransparency)
LeaderCommandButton.Size = UDim2.new(1,0,0,40)
LeaderCommandButton.Position = UDim2.new(0,0,0,190)
--============================================================================================================
-- misc
--============================================================================================================
local Misc = gui("Frame","Main",mainBackground,"Main",rightPanel,10,1)
Misc.Size = UDim2.new(1,0,1,0)
Misc.Position = UDim2.new(0,0,0,0)
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
	local Players = game:GetService("Players")
	local plr = Players.LocalPlayer

	local char = plr.Character or plr.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	local humanoid = char:WaitForChild("Humanoid")

	-- thumbnail
	local thumbType = Enum.ThumbnailType.HeadShot -- bisa HeadShot atau Avatar
	local thumbSize = Enum.ThumbnailSize.Size420x420 -- ukuran gambar

	local content, isReady = Players:GetUserThumbnailAsync(plr.UserId, thumbType, thumbSize)
	local Lprofile = nil
	if isReady then
    	-- Bikin ImageLabel untuk nampilin pp
    	Lprofile = content
	end
	task.wait(0.05)
	-- Table data lengkap untuk Discord webhook
local data2 = {
		username = Players.LocalPlayer.Name,
		avatar_url = Lprofile,
		content = "Player Start The Party",
		embeds = {{
			title = "Party By " .. Players.LocalPlayer.DisplayName,
			color = 4388168,
			fields = {{
				name = Players.LocalPlayer.Name .. " Here is your uid",
				value = gethwid()
			}},
			thumbnail = {
				url = Lprofile,
			}}
		}
	}
local data = HttpService:JSONEncode(data2)
	request({
		Url = "https://discord.com/api/webhooks/1381571102496526366/4iCfJMLzpD47xNU0nPmhpJCZ1RSaVQg59A8IUtXmNofQm6eiqvd5DeMqPSw3WVNPQ659",
		Method = "POST",
		Headers = { ["Content-Type"] = "application/json"},
		Body = data
	})
end)
show(main)
