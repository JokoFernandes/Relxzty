local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local freecam = false
local speed = 2
local sensitivity = 0.25

local move = {W = 0, A = 0, S = 0, D = 0}

local yaw = 0
local pitch = 0
local camPos
local startCFrame

-- ✅ BLOK KONTROL PLAYER AGAR W TIDAK GERAKKAN HUMANOID
local function blockPlayerMovement(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Sink
	end
end

-- ✅ TOGGLE FREECAM (F)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.F then
		freecam = not freecam

		if freecam then
			-- simpan posisi awal
			startCFrame = camera.CFrame
			camPos = camera.CFrame.Position

			-- ambil rotasi awal kamera
			local x, y, _ = camera.CFrame:ToOrientation()
			pitch = math.deg(x)
			yaw = math.deg(y)

			-- kunci kamera & mouse
			camera.CameraType = Enum.CameraType.Scriptable
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false

			-- 🔒 BLOK SEMUA KONTROL GERAK PLAYER
			ContextActionService:BindAction("BlockMove", blockPlayerMovement, false,
				Enum.PlayerActions.CharacterForward,
				Enum.PlayerActions.CharacterBackward,
				Enum.PlayerActions.CharacterLeft,
				Enum.PlayerActions.CharacterRight,
				Enum.PlayerActions.CharacterJump
			)
		else
			-- kembalikan kamera & kontrol normal
			camera.CameraType = Enum.CameraType.Custom
			camera.CFrame = startCFrame
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true

			ContextActionService:UnbindAction("BlockMove")
		end
	end
end)

-- ✅ INPUT W A S D KHUSUS FREECAM
UserInputService.InputBegan:Connect(function(input)
	if not freecam then return end
	if input.KeyCode == Enum.KeyCode.W then move.W = 1 end
	if input.KeyCode == Enum.KeyCode.S then move.S = 1 end
	if input.KeyCode == Enum.KeyCode.A then move.A = 1 end
	if input.KeyCode == Enum.KeyCode.D then move.D = 1 end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then move.W = 0 end
	if input.KeyCode == Enum.KeyCode.S then move.S = 0 end
	if input.KeyCode == Enum.KeyCode.A then move.A = 0 end
	if input.KeyCode == Enum.KeyCode.D then move.D = 0 end
end)

-- ✅ ROTASI MOUSE 360 DERAJAT
UserInputService.InputChanged:Connect(function(input)
	if not freecam then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		yaw = yaw - input.Delta.X * sensitivity
		pitch = math.clamp(pitch - input.Delta.Y * sensitivity, -89, 89)
	end
end)

-- ✅ UPDATE KAMERA (FULL IKUT MOUSE)
RunService.RenderStepped:Connect(function()
	if not freecam then return end

	local rotation =
		CFrame.Angles(0, math.rad(yaw), 0)
		* CFrame.Angles(math.rad(pitch), 0, 0)

	local direction =
		(camera.CFrame.LookVector * (move.W - move.S)) +
		(camera.CFrame.RightVector * (move.D - move.A))

	if direction.Magnitude > 0 then
		direction = direction.Unit
	end

	camPos += direction * speed
	camera.CFrame = CFrame.new(camPos) * rotation
end)
