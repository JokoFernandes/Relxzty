-- NOTIFIKASI OBTAIN FISH
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REObtainedNewFishNotification =
	ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ObtainedNewFishNotification"]

firesignal(REObtainedNewFishNotification.OnClientEvent,
	257,
	{
		VariantId = "Galaxy",
		VariantSeed = 1764769101,
		Weight = 3.2
	},
	{
		CustomDuration = 5,
		InventoryItem = {
			Id = 192,
			Favorited = false,
			UUID = "d783dbfb-32de-43dd-86e5-b08c1376351a",
			Metadata = {
				VariantId = "Galaxy",
				VariantSeed = 1764769101,
				Weight = 3.2
			}
		},
		ItemType = "Items",
		_newlyIndexed = false,
		Type = "Item",
		ItemId = 192
	},
	false
)


local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function getNotif()
	local notifUI = playerGui:FindFirstChild("Text Notifications")
	if not notifUI then return end

	local frame = notifUI:FindFirstChild("Frame")
	if not frame then return end

	local tile = frame:FindFirstChild("Tile")
	if not tile then return end

	local textFrame = tile:FindFirstChild("TextFrame")
	if not textFrame then return end

	local label = textFrame:FindFirstChild("Label")
	if not label then return end

	return label
end

while true do
	local label = getNotif()

	if label and label.Text == "Galactic" then
		label.Text = "Amba Rod"
	end

	task.wait()
end
