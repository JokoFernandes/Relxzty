-- Freecam Full Script (toggle dengan F, WASD + mouse rotate)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local freecam = false
local speed = 2
local sensitivity = 0.25

local move = {W = 0, A = 0, S = 0, D = 0}
local yaw, pitch = 0, 0
local camPos, startCFrame

-- blok kontrol humanoid
local function blockPlayerMovement(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Sink
	end
end

-- toggle freecam (F)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.F then
		freecam = not freecam

		if freecam then
			startCFrame = Camera.CFrame
			camPos = startCFrame.Position

			local rx, ry, _ = startCFrame:ToOrientation()
			pitch = math.deg(rx)
			yaw = math.deg(ry)

			Camera.CameraType = Enum.CameraType.Scriptable
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false

			ContextActionService:BindAction("BlockMove", blockPlayerMovement, false,
				Enum.PlayerActions.CharacterForward,
				Enum.PlayerActions.CharacterBackward,
				Enum.PlayerActions.CharacterLeft,
				Enum.PlayerActions.CharacterRight,
				Enum.PlayerActions.CharacterJump
			)
		else
			Camera.CameraType = Enum.CameraType.Custom
			Camera.CFrame = startCFrame
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true
			ContextActionService:UnbindAction("BlockMove")
		end
	end
end)

-- input WASD
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

-- rotasi mouse
UserInputService.InputChanged:Connect(function(input)
	if not freecam then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		yaw = yaw - input.Delta.X * sensitivity
		pitch = math.clamp(pitch - input.Delta.Y * sensitivity, -89, 89)
	end
end)

-- update kamera
RunService.RenderStepped:Connect(function(dt)
	if not freecam then return end

	-- paksa mouse tetap lock center (biar klik kanan tidak reset)
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

	local rotation = CFrame.Angles(0, math.rad(yaw), 0) * CFrame.Angles(math.rad(pitch), 0, 0)
	local forward = rotation.LookVector
	local right = rotation.RightVector

	local direction = (forward * (move.W - move.S)) + (right * (move.D - move.A))
	if direction.Magnitude > 0 then
		direction = direction.Unit
	end

	camPos += direction * speed
	Camera.CFrame = CFrame.new(camPos) * rotation
end)
