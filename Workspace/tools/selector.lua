local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
task.wait(2)
local tool = Instance.new("Tool")
tool.Name = "Tool"
tool.RequiresHandle = true
tool.CanBeDropped = false
tool.Parent = player.Backpack

local handle = Instance.new("Part")
handle.Size = Vector3.new(1, 1, 1)
handle.Anchored = false
handle.CanCollide = true
handle.Transparency = 1
handle.Name = "Handle"
handle.Parent = tool

local function getModelFromPart(obj)
	while obj and not obj:IsA("Model") do
		obj = obj.Parent
	end
	return obj
end

local curretSelect
local inputConn -- simpan connection
local targetBody = nil
tool.Equipped:Connect(function(m)
	mouse = m
	print("Tool dipegang!")

	inputConn = UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local target = mouse.Target

			if target and (target:IsA("BasePart") or target:IsA("MeshPart")) then
				if curretSelect then
					curretSelect:Destroy()
					curretSelect = nil
				end

				local select = Instance.new("Highlight")
				select.Name = "Selected"
				select.FillTransparency = 1
				select.OutlineTransparency = 0
				select.OutlineColor = Color3.new(1, 0, 0)
				select.Adornee = target
				select.Parent = target
				
				curretSelect = select
				targetBody = getModelFromPart(target)
				print("Part terpilih:", target.Name)
				print("Body", tostring(targetBody))
			end
		end
		if input.KeyCode == Enum.KeyCode.T then
			if targetBody then
				local VFX = Instance.new("Explosion")
				VFX.Position = targetBody:GetPivot().Position
				VFX.Parent = targetBody.HumanoidRootPart
				targetBody:WaitForChild("Humanoid").Health = 0
				Debris:AddItem(VFX, 2)
				print("Body terhapus")
			else
				print("Tidak ada body yang terpilih")
			end
		end
	end)
end)

tool.Unequipped:Connect(function()
	print("Tool dilepas")

if inputConn then
		inputConn:Disconnect()
		inputConn = nil
	end
end)
