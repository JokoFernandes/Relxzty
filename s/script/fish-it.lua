-- admin abuse

-- input
local message = _G.Msg
local fishId = _G.fishId
local wght = _G.Weight
local delay = _G.delay
local fishtype = _G.fishtype
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 3.5,
        Text = "Get ready ",
        Type = "Text",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(4.5)
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 5,
        Text = "🥵 AMBATUKAAMMMMM",
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
local total = _G.Loop
for i = 1, total do

	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	-- hitung posisi di depan player
	local front = hrp.Position + (hrp.CFrame.LookVector * 20)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	-- Variables
	local RECaughtFishVisual = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/CaughtFishVisual"]

	-- This data was received from the server
	firesignal(RECaughtFishVisual.OnClientEvent, 
		Players.LocalPlayer,
		front,
		fishtype,
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
		fishtype,
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
        UUID = i,
        Channel = "All",
        TextData = {
            AttachTo = Character.Head,
            Text = "!",
            EffectType = "Exclaim",
            TextColor = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0.25, 0.85, 0.80)),
	ColorSequenceKeypoint.new(1, Color3.new(0.25, 0.85, 0.80))
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
    6
)
-- Generated with sigma spy 

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local REDisplaySystemMessage = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/DisplaySystemMessage"]

-- This data was received from the server
firesignal(REDisplaySystemMessage.OnClientEvent, 
    message
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
				UUID = i,
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
            Weight = 650000,
VariantSeed = 17419837,
					VariantId = "Galaxy"
        }
    }
)

	task.wait(delay)

end
