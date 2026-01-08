local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local place = game.PlaceId
local function detectGame(placeId,str)
  if place == placeId then
    print(str)
  end
end
detectGame(121864768012064,"Fish It")
detectGame(2753915549,"Blox Fruit")
detectGame(7041939546,"Catalog Avatar")

loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/VeldoraX/create-party.lua"))()
task.wait(0.3)
--===================
--Message
--===================
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local message = "Thank you for using our script, we hope you have fun and enjoy it. use #help to see custom command"
local msg = "<b><font color='rgb(76, 0, 255)'>[LIUDEX Z]</font></b>: <font color='rgb(255, 230,140)'>hello</font> <font color='rgb(90, 250, 255)'>" .. Players.LocalPlayer.DisplayName .. "</font> " .. "<font color='rgb(255,230,140)'>" .. message .. "</font>"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local msg2 = "<b><font color='rgb(76, 0, 255)'>[LIUDEX Z]</font></b>: <font color='rgb(255, 0, 0)'>Disclaimer</font> <font color='rgb(0, 255, 25)'>Do not use this for game breaking exploits. Don't forget to join our Discord</font><b><font color='rgb(25,100,255)'> https://discord.gg/DxFgaFe4</font></b>"

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()


plr.Chatted:Connect(function(msg)
    if msg:lower() == "#help" then
        -- chat /show buat show ui deltanya
        channel:DisplaySystemMessage(
            "  /showhui to show all ui in gethui"
        )
        channel:DisplaySystemMessage(
            "  /hidehui to hide all ui in gethui"
        )
        channel:DisplaySystemMessage(
            "  /tp <target> it will tp you to target"
        )
        channel:DisplaySystemMessage(
            "  /bring <target> it will bring your member to  your position (leader only)"
        )
        channel:DisplaySystemMessage(
            "  /highlight <1 to show 0 to hide> to see all member"
        )
        channel:DisplaySystemMessage(
            "  /global <message> to send message cross server or game"
        )
    end
end)
channel:DisplaySystemMessage(
    msg
)
channel:DisplaySystemMessage(
    msg2
)



	-- =====================
	-- UI CREATION
	-- =====================
	local gui = Instance.new("ScreenGui")
	gui.Name = "LevelCompleteNotification"
	gui.ResetOnSpawn = false
	gui.Parent = gethui()

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0.35, 0, 0.12, 0)
	frame.Position = UDim2.new(0.5, 0, -0.2, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.2, 0)
	corner.Parent = frame

	-- Icon (fake badge)
	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.new(0, 60, 0.9, 0)
	icon.Position = UDim2.new(0.05, 0, 0, 5)
	icon.BackgroundTransparency = 1
	icon.Image = "rbxassetid://126569944133822" -- default badge icon
	icon.Parent = frame

	-- Text
	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(0.7, 0, 1, 0)
	text.Position = UDim2.new(0.2, 0, 0, 0)
	text.BackgroundTransparency = 1
	text.Text = ""
	text.TextColor3 = Color3.fromRGB(136, 0, 255)
	text.Font = Enum.Font.Garamond
	text.TextScaled = true
	text.Parent = frame

	-- =====================
	-- ANIMATION POSITIONS
	-- =====================
	local hiddenPos = UDim2.new(0.5, 0, -0.2, 0)
	local showPos = UDim2.new(0.5, 0, -0.05, 0)

	frame.Position = hiddenPos

	-- =====================
	-- FUNCTION
	-- =====================
	local function ShowLevelComplete(levelNumber)
		text.Text = "WELCOME LUIDEX Z " ..levelNumber
		-- sfx
		task.spawn(function()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://3398620867"
			sound.Volume = 80
			sound.Looped = true
			sound.Parent = game.SoundService

			sound:Play()
			task.wait(1.1)
			sound:Destroy()
		end)
		-- Reset
		frame.BackgroundTransparency = 0.1
		text.TextTransparency = 0
		icon.ImageTransparency = 0
		frame.Position = hiddenPos

		--show
		local showTween = TweenService:Create(
			frame,
			TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Position = showPos}
		)
		showTween:Play()

		task.wait(2.5)

		-- Fade out
		local fadeTween = TweenService:Create(
			frame,
			TweenInfo.new(0.5),
			{
				Position = hiddenPos,
				BackgroundTransparency = 1
			}
		)

		local textFade = TweenService:Create(text, TweenInfo.new(0.5), {TextTransparency = 1})
		local iconFade = TweenService:Create(icon, TweenInfo.new(0.5), {ImageTransparency = 1})
		-- out
		task.spawn(function()
			local sound2 = Instance.new("Sound")
			sound2.SoundId = "rbxassetid://3072176098"
			sound2.Volume = 80
			sound2.Looped = true
			sound2.Parent = game.SoundService

			sound2:Play()
			task.wait(0.6)
			sound2:Destroy()
		end)
		task.wait(0.1)
		fadeTween:Play()
		textFade:Play()
		iconFade:Play()
	end

	-- =====================
	-- CONTOH PEMANGGILAN
	-- =====================
	-- Panggil ini saat level selesai
	-- Contoh:
	ShowLevelComplete("V 0.01")
	task.wait(3)
	gui:Destroy()
	-- Kalau mau test manual:
	-- task.wait(5)
	-- ShowLevelComplete(2)
