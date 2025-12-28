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

-- fallback kalau InputChanged tidak kebaca (executor tertentu)
local useMouseDeltaFallback = false

local function blockPlayerMovement(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Sink
	end
end

-- Toggle Freecam (F)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.F then
		freecam = not freecam

		if freecam then
			startCFrame = camera.CFrame
			camPos = startCFrame.Position

			-- ambil rotasi awal kamera
			local rx, ry, _ = startCFrame:ToOrientation()
			pitch = math.deg(rx)
			yaw = math.deg(ry)

			camera.CameraType = Enum.CameraType.Scriptable
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
			camera.CameraType = Enum.CameraType.Custom
			camera.CFrame = startCFrame
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true

			ContextActionService:UnbindAction("BlockMove")
		end
	end
end)

-- Input WASD
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

-- Rotasi mouse (event-based). Jika event ini tidak pernah jalan, kita aktifkan fallback.
UserInputService.InputChanged:Connect(function(input)
	if not freecam then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		-- kanan = deltaX+, yaw berkurang → putar ke kanan (feel FPS umum)
		yaw = yaw - input.Delta.X * sensitivity
		-- atas = deltaY-, pitch naik → menengadah
		pitch = math.clamp(pitch - input.Delta.Y * sensitivity, -89, 89)
		useMouseDeltaFallback = false
	end
end)

-- Update kamera
RunService.RenderStepped:Connect(function(dt)
	if not freecam then return end

	-- Fallback: beberapa executor tidak mem-forward event MouseMovement
	if useMouseDeltaFallback then
		local dx, dy = UserInputService:GetMouseDelta().X, UserInputService:GetMouseDelta().Y
		yaw = yaw - dx * sensitivity
		pitch = math.clamp(pitch - dy * sensitivity, -89, 89)
	end

	-- Bangun rotasi dari yaw/pitch
	local rotation =
		CFrame.Angles(0, math.rad(yaw), 0) *
		CFrame.Angles(math.rad(pitch), 0, 0)

	-- Gerak menggunakan basis rotasi (LookVector/RightVector dari 'rotation'),
	-- bukan dari camera.CFrame supaya sinkron sama arah pandang.
	local forward = rotation.LookVector
	local right = rotation.RightVector

	local direction = (forward * (move.W - move.S)) + (right * (move.D - move.A))
	if direction.Magnitude > 0 then
		direction = direction.Unit
	end

	camPos += direction * speed * (dt > 0 and (dt * 60/60) or 1) -- skala ringan sesuai framerate
	camera.CFrame = CFrame.new(camPos) * rotation
end)

-- Jika dalam ~0.25 detik tidak ada event MouseMovement, nyalakan fallback
task.defer(function()
	task.wait(0.25)
	if freecam and yaw == yaw and pitch == pitch then
		-- Tidak ada update dari InputChanged sejak toggle → coba fallback
		useMouseDeltaFallback = true
	end
end)
