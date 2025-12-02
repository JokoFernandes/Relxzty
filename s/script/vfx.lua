local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- ambil folder VFX
local vfxFolder = ReplicatedStorage:WaitForChild("VFX")

-- ambil template
local baitTemplate = vfxFolder:WaitForChild("BaitDive")
local scytheTemplate = game:GetService("ReplicatedStorage").VFX["Soul Scythe Dive"]
-- clone object
local bait = baitTemplate:Clone()
bait.Parent = workspace

local scythe = scytheTemplate:Clone()
scythe.Parent = character

-- COPY SEMUA ISI SOULSCYTHE KE BAITDIVE
for _, obj in ipairs(scythe:GetChildren()) do
	local cloneObj = obj:Clone()
	cloneObj.Parent = bait
end

-- ambil salah satu attachment hasil copy / asli
local soulAttachment = scythe:FindFirstChildOfClass("Attachment")
if not soulAttachment then
	warn("Tidak ada Attachment di SoulScythe")
	return
end

-- buat attachment baru di bait
local baitAttachment = Instance.new("Attachment")
baitAttachment.Parent = bait

-- Align Position
local alignPos = Instance.new("AlignPosition")
alignPos.Parent = bait
alignPos.Attachment0 = baitAttachment
alignPos.Attachment1 = soulAttachment
alignPos.RigidityEnabled = false
alignPos.MaxForce = 999999
alignPos.Responsiveness = 200

-- Align Orientation
local alignOri = Instance.new("AlignOrientation")
alignOri.Parent = bait
alignOri.Attachment0 = baitAttachment
alignOri.Attachment1 = soulAttachment
alignOri.RigidityEnabled = false
alignOri.MaxTorque = 999999
alignOri.Responsiveness = 200

-- pastikan tidak di-anchored
bait.Anchored = false
scythe.Anchored = false
