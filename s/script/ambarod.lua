local rodimg = "rbxassetid://127771159160485"

-- Ambil service Players
local player = game:GetService("Players").LocalPlayer

-- Ambil PlayerGui
local playerGui = player:WaitForChild("PlayerGui")

-- Ambil tampilan gambar rod di backpack
local rodBackpackImg = playerGui.Backpack.Display.Tile.Inner.Vector

-- Ambil warna UIGradient background rod di inventory
local rodbackground = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Glow.UIGradient

-- Nama rod di inventory
local nameRodInven = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.Label

-- Label rarity rod
local Rarity = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.TierLabel

-- UIGradient text rarity
local invTextColor = Rarity.UIGradient

-- Nama rod dalam backpack
local backpackRodName = playerGui.Backpack.Display.Tile.Inner.Tags.ItemName

-- Warna nama rod backpack
local nameRodBackpackColor = backpackRodName.UIGradient

-- Bagian stats rod
local rodstat = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Bottom

-- Gambar rod di inventory
local invrod = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Vector

-- Background glow inventory rod
local invrodbg = playerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Glow.UIGradient

-- Ambil stat labels
local luck = rodstat.Luck
local speed = rodstat.Speed
local weight = rodstat.Weight

-- LOOP PERUBAHAN STATS
task.spawn(function()
	while true do

		-- UI Inventory harus Visible baru diganti
		if playerGui.Inventory.Main.Visible == true then
			invrodbg.Color = invTextColor.Color
			invrod.Image = rodimg

			luck.Counter.Text = "66666666%"
			speed.Counter.Text = "7777777%"
			weight.Counter.Text = "67M kg"
		end

		task.wait()
	end
end)


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
			Id = 257,
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
		ItemId = 257
	},
	false
)


-- LOOP PERUBAHAN NOTIFIKASI
task.spawn(function()
	while true do
		local notif = playerGui["Text Notifications"].Frame.Tile.TextFrame.Label
		local notifimg = playerGui["Text Notifications"].Frame.Tile.TextFrame.VectorFrame.Vector

		-- Cek apakah muncul notif
		if notif.Text:find("Element Rod")
			and notifimg.Image:find("99867965187788") then

			notif.Text = "Ambarod"
			notifimg.Image = rodimg
		end

		task.wait(0.1)
	end
end)
