local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local freecam = false
local speed = 1.5
local sensitivity = 0.2

local direction = Vector3.new(0, 0, 0)

local yaw = 0
local pitch = 0

local camPos = camera.CFrame.Position
local startCFrame = camera.CFrame -- ✅ posisi awal kamera disimpan

-- TOGGLE FREE CAM (F)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.F then
		freecam = not freecam

		if freecam then
			startCFrame = camera.CFrame -- ✅ simpan saat mulai freecam
			camPos = camera.CFrame.Position

			-- ✅ ambil rotasi awal kamera supaya mouse bisa langsung muter
			local x, y, z = camera.CFrame:ToOrientation()
			pitch = math.deg(x)
			yaw = math.deg(y)

			camera.CameraType = Enum.CameraType.Scriptable
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		else
			camera.CameraType = Enum.CameraType.Custom
			camera.CFrame = startCFrame -- ✅ balik ke posisi awal
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end
	end
end)

-- INPUT GERAK (WASD + SPACE + CTRL)
UserInputService.InputBegan:Connect(function(input)
	if not freecam then return end

	if input.KeyCode == Enum.KeyCode.W then
		direction = Vector3.new(0, 0, -1)
	elseif input.KeyCode == Enum.KeyCode.S then
		direction = Vector3.new(0, 0, 1)
	elseif input.KeyCode == Enum.KeyCode.A then
		direction = Vector3.new(-1, 0, 0)
	elseif input.KeyCode == Enum.KeyCode.D then
		direction = Vector3.new(1, 0, 0)
	elseif input.KeyCode == Enum.KeyCode.Space then
		direction = Vector3.new(0, 1, 0)
	elseif input.KeyCode == Enum.KeyCode.LeftControl then
		direction = Vector3.new(0, -1, 0)
	end
end)

UserInputService.InputEnded:Connect(function()
	direction = Vector3.new(0, 0, 0)
end)

-- ROTASI DENGAN MOUSE ✅
UserInputService.InputChanged:Connect(function(input)
	if not freecam then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		yaw = yaw - input.Delta.X * sensitivity
		pitch = math.clamp(pitch - input.Delta.Y * sensitivity, -80, 80)
	end
end)

-- UPDATE POSISI & ROTASI KAMERA ✅
RunService.RenderStepped:Connect(function()
	if freecam then
		local rot =
			CFrame.Angles(0, math.rad(yaw), 0)
			* CFrame.Angles(math.rad(pitch), 0, 0)

		camPos = camPos + (rot:VectorToWorldSpace(direction) * speed)

		camera.CFrame = CFrame.new(camPos) * rot
	end
end)
