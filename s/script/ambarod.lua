local rodimg = "rbxassetid://127771159160485"
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local rodBackpackImg = game:GetService("Players").LocalPlayer.PlayerGui.Backpack.Display.Tile.Inner.Vector.Image
local rodbackground = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Glow.UIGradient.Color
local nameRodInven = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.Label
local Rarity = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.TierLabel 
local invTextColor = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.TierLabel.UIGradient.Color 
local backpackRodName = game:GetService("Players").LocalPlayer.PlayerGui.Backpack.Display.Tile.Inner.Tags.ItemName
local nameRodBackpackColor = game:GetService("Players").LocalPlayer.PlayerGui.Backpack.Display.Tile.Inner.Tags.ItemName.UIGradient
-- stats
local rodstat = playerGui:WaitForChild("Inventory"):WaitForChild("Main"):WaitForChild("Content"):WaitForChild("Pages"):WaitForChild("Rods"):WaitForChild("Ghostfinn Rod"):WaitForChild("Padded"):WaitForChild("Bottom")
local invrod = playerGui:WaitForChild("Inventory"):WaitForChild("Main"):WaitForChild("Content"):WaitForChild("Pages"):WaitForChild("Rods"):WaitForChild("Ghostfinn Rod"):WaitForChild("BG"):WaitForChild("Vector")
local invrodbg = playerGui:WaitForChild("Inventory"):WaitForChild("Main"):WaitForChild("Content"):WaitForChild("Pages"):WaitForChild("Rods"):WaitForChild("Ghostfinn Rod"):WaitForChild("BG"):WaitForChild("Glow"):WaitForChild("UIGradient")
local luck = rodstat.Luck
local speed = rodstat.Speed
local weight = rodstat.Weight

task.spawn(function()
		while true do
			invrodbg.Color = invTextColor
			invrod.Image = rodimg
			luck.Counter.Text = "66666666%"
			speed.Counter.Text = "7777777%"
			weight.Counter.Text = "67M kg"
			task.wait()
		end
	end)
-- notif
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REObtainedNewFishNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ObtainedNewFishNotification"]

-- This data was received from the server
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
task.spawn(function()
    while true do

	local notif = playerGui:WaitForChild("Text Notifications"):WaitForChild("Frame"):WaitForChild("Tile"):WaitForChild("TextFrame"):WaitForChild("Label")
    local notifimg = playerGui:WaitForChild("Text Notifications"):WaitForChild("Frame"):WaitForChild("Tile"):WaitForChild("TextFrame"):WaitForChild("VectorFrame"):WaitForChild("Vector")

	if notif.Text == "Element Rod" and notifimg.Image == "rbxassetid://99867965187788" then
		notif.Text = "Ambarod"
        notif.Image = rodimg
	end

	task.wait(0.1)
end
end)


