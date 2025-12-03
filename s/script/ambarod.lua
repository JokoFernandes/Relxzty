local rod = "rbxassetid://127771159160485"
local notif = game:GetService("Players").LocalPlayer.PlayerGui["Text Notifications"].Frame.Tile.TextFrame.Label.Text
local rodBackpackImg = game:GetService("Players").LocalPlayer.PlayerGui.Backpack.Display.Tile.Inner.Vector.Image
local rodInven = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Vector.Image
local rodbackground = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].BG.Glow.UIGradient.Color
local nameRodInven = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.Label.Text 
local Rarity = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.TierLabel.Text 
local invTextColor =game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Top.TierLabel.UIGradient.Color 
-- stats
local luck = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Bottom.Luck.Counter.Text
local speed = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Bottom.Speed.Counter.Text
local weight = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.Content.Pages.Rods["Ghostfinn Rod"].Padded.Bottom.Weight.Counter.Text
-- start
-- get Rod

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


