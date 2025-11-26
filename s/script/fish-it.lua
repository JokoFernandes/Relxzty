-- admin abuse
-- input
local fishId = 269
local wght = 650000
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 1,
        Text = "Get ready ",
        Type = "Text",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(2)
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 5,
        Text = "Ambatukammmmmm",
        Type = "Event",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(1.5)
-- ikan
local total = 50
for i = 1, total do

	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	-- hitung posisi di depan player
	local front = hrp.Position + (hrp.CFrame.LookVector * 5)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	-- Variables
	local RECaughtFishVisual = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/CaughtFishVisual"]

	-- This data was received from the server
	firesignal(RECaughtFishVisual.OnClientEvent, 
		Players.LocalPlayer,
		front,
		"Elshark Gran Maja",
		{
			VariantId= "GALAXY",
			VariantSeed = 12349013,
			Weight = wght
		}
	) 

	-- animation
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	-- Variables
	local REFishCaught = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/FishCaught"]

	-- This data was received from the server
	firesignal(REFishCaught.OnClientEvent, 
		"Elshark Gran Maja",
		{
			Weight = wght
		}
	) 
-- Generated with sigma spy 

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local Character = Players.LocalPlayer.Character
local REReplicateTextEffect = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ReplicateTextEffect"]

-- This data was received from the server
firesignal(REReplicateTextEffect.OnClientEvent, 
    {
        UUID = "4b669e89-d602-4182-9508-f3ee2f305033",
        Channel = "All",
        TextData = {
            AttachTo = Character.Head,
            Text = "!",
            EffectType = "Exclaim",
            TextColor = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0.25, 0.90, 0.80)),
	ColorSequenceKeypoint.new(1, Color3.new(0.25, 0.90, 0.80))
})
        },
        Duration = 0.5,
        Container = Character.Head
    }
)
	-- Generated with sigma spy 

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local Head = Players.LocalPlayer.Character.Head
local REPlayFishingEffect = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/PlayFishingEffect"]

-- This data was received from the server
firesignal(REPlayFishingEffect.OnClientEvent, 
    Players.LocalPlayer,
    Head,
    5
)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local REObtainedNewFishNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ObtainedNewFishNotification"]

	firesignal(REObtainedNewFishNotification.OnClientEvent, 
		fishId,
		{
			Weight = wght,
			VariantSeed = 17419837,
			VariantId = "Galaxy"
		},
		{
			CustomDuration = 5,
			InventoryItem = {
				Id = fishId,
				Favorited = false,
				UUID = "1a06884e-3430-473d-af94-304ff5b8e532",
				Metadata = {
					Weight = wght,
					VariantSeed = 17419837,
					VariantId = "Galaxy"
				}
			},
			ItemType = "Items",
			_newlyIndexed = false,
			Type = "Item",
			ItemId = fishId
		},
		false
	)

	-- ✅ KODE BARU DITAMBAHKAN DI AKHIR TIAP PERULANGAN
	-- Generated with sigma spy 

	-- Services
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	-- Variables
	local ArrayUpdate = ReplicatedStorage.Packages._Index["ytrev_replion@2.0.0-rc.3"].replion.Remotes.ArrayUpdate

	-- This data was received from the server
	firesignal(ArrayUpdate.OnClientEvent, 
		"\11",
		"i",
		{
			"Inventory",
			"Items"
		},
		{
			Id = fishId,
			Favorited = false,
			UUID = i,
			Metadata = {
				Weight = wght
			}
		}
	)

	task.wait(1.8)

end
