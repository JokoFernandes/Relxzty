--  i modified the script from @azionellll in script blox

local cam = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local onMobile = not UIS.KeyboardEnabled
local keysDown = {}
local rotating = false
local freecamEnabled = false

local oldCameraType
local oldCameraCFrame

if not game:IsLoaded() then game.Loaded:Wait() end

local speed = 5
local sens = .3
speed /= 10
if onMobile then sens *= 2 end

-- FUNCTION TOGGLE FREECAM
local function toggleFreecam()
	freecamEnabled = not freecamEnabled

	if freecamEnabled then
		oldCameraType = cam.CameraType
		oldCameraCFrame = cam.CFrame

		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = oldCameraCFrame

		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
	else
		cam.CameraType = oldCameraType

		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50

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
end

RS.RenderStepped:Connect(renderStepped)

local validKeys = {
	"Enum.KeyCode.W",
	"Enum.KeyCode.A",
	"Enum.KeyCode.S",
	"Enum.KeyCode.D"
}

-- INPUT BEGIN
UIS.InputBegan:Connect(function(Input, gp)
	if gp then return end

	if Input.KeyCode == Enum.KeyCode.F then
		toggleFreecam()
	end

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
