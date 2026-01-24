local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")

local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

local msage = {"Hidup Jokowi!!","Saya akan kembali ke solo dan menjadi rakyat biasa","Akan terbuka 19jt lapangan pekerjaan","Oke gas oke gas","Wiwok detok","Aku Nak SAWITTTTT"}
local color = {
	{255,0,0},
	{50,0,255},
	{0,150,10}}
local i = 0
while i <= 5 do
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- CONFIG
local FOLLOW_DISTANCE = 6 + (i * 2)
local TWEEN_DISTANCE = 300 
local TWEEN_TIME = 0.3
local JUMP_DELAY = 0.4

local followChar
local humanoid
local hrp
local lastJump = 0

-- SPAWN NPC
local function SpawnOtherAvatar(modelName, userId)
	local char = Players:CreateHumanoidModelFromUserId(userId)
	if not char then return end
	local nameColor = math.random(#color)
	char.Name = modelName
	char.Parent = workspace
    task.spawn(function()
      
      while true do
      local messages = msage[math.random(#msage)]
      local npc = char
      local head = npc:WaitForChild("Head")
      local rgb = color[nameColor]
	  local colorString = string.format("rgb(%d,%d,%d)", rgb[1], rgb[2], rgb[3])
	  channel:DisplaySystemMessage("<font color='" .. colorString .. "'>" .. char.Name .. "</font>: " .. messages)


      -- kirim bubble chat
      Chat:Chat(head, messages, Enum.ChatColor.White)
          task.wait(4)
        end
      end)
	followChar = char

	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")

	local lpChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local lpHRP = lpChar:WaitForChild("HumanoidRootPart")

	local startPos = lpHRP.Position - lpHRP.CFrame.LookVector * FOLLOW_DISTANCE
	char:PivotTo(CFrame.new(startPos))
end

-- FOLLOW LOOP
RunService.Heartbeat:Connect(function()
	if not followChar or not humanoid or not hrp then return end

	local lpChar = LocalPlayer.Character
	if not lpChar then return end

	local lpHRP = lpChar:FindFirstChild("HumanoidRootPart")
	if not lpHRP then return end

	local targetPos = lpHRP.Position - lpHRP.CFrame.LookVector * FOLLOW_DISTANCE
	local distance = (hrp.Position - lpHRP.Position).Magnitude

	-- SPAM JUMP
	if tick() - lastJump > JUMP_DELAY then
		humanoid.Jump = true
		lastJump = tick()
	end

	-- JAUH → TWEEN
	if distance > TWEEN_DISTANCE then
		local tween = TweenService:Create(
			hrp,
			TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{ CFrame = CFrame.new(targetPos) }
		)
		tween:Play()
	else
		-- DEKET → MOVETO
		humanoid:MoveTo(targetPos)

		-- FACING HANYA SAAT DI TANAH
		if humanoid.FloorMaterial ~= Enum.Material.Air then
			hrp.CFrame = CFrame.lookAt(hrp.Position, lpHRP.Position)
		end
	end
end)

-- CONTOH PANGGIL
SpawnOtherAvatar("Mafia Sawit", 1079792491)
i = i+1
task.wait()
end
