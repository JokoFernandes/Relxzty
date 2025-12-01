-- admin abuse

-- input
local message = _G.Msg
local fishId = _G.fishId
local wght = _G.Weight 
local delay = _G.delay
local fishtype = _G.fishtype
local mutation = _G.mutation
local chance = _G.chance
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function formatNumber(num)
    if num >= 1_000_000_000 then
        return string.format("%.1fB", num / 1_000_000_000)  -- Billion
    elseif num >= 1_000_000 then
        return string.format("%.1fM", num / 1_000_000)      -- Million
	elseif num >= 1_000_000 then
        return string.format("%.1fM", num / 1_000_000)      -- Million
	elseif num >= 650_000 then
        return string.format("%.0fM", num / 1_000)      -- Million
	elseif num >= 450_100 then
        return string.format("%.1fM", num / 1_000)
	elseif num >= 450_000 then
        return string.format("%.0fM", num / 1_000)      -- Hundred Thousand
    elseif num >= 1_000 then
        return string.format("%.1fK", num / 1_000)          -- Thousand
    else
        return tostring(num)
    end
end
local weight = formatNumber(wght)
-- Variables
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 4.5,
        Text = "Get ready 😈",
		AdminId= 75974130,
        Type = "AdminText",
        AdminName = "Talon",
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
            B = 30,
            G = 30,
            R = 30
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
			VariantId= mutation,
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
local messager = "<b><font size=\'20\' color=\'#ffffff\'>[Server]:</font></b> " .. player.DisplayName .. " obtained a <b><font color=\'rgb(24, 255, 152)\'>" .. string.upper(mutation) .. " " ..  fishtype  .. " ("..weight  .. " kg)</font></b> with ".. chance .." chance!"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local REDisplaySystemMessage = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/DisplaySystemMessage"]

-- This data was received from the server
firesignal(REDisplaySystemMessage.OnClientEvent, 
    messager
)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local REObtainedNewFishNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ObtainedNewFishNotification"]

	firesignal(REObtainedNewFishNotification.OnClientEvent, 
		fishId,
		{
			Weight = wght,
			VariantSeed = 17419837,
			VariantId = mutation
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
					VariantId = mutation
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
    "\12",
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

-- Generated with sigma spy 

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local Set = ReplicatedStorage.Packages._Index["ytrev_replion@2.0.0-rc.3"].replion.Remotes.Set

-- This data was received from the server
firesignal(Set.OnClientEvent, 
    "\12",
    {
        "InventoryNotifications",
        "Fish"
    },
    i
)

local Update = ReplicatedStorage.Packages._Index["ytrev_replion@2.0.0-rc.3"].replion.Remotes.Update

-- This data was received from the server
firesignal(Update.OnClientEvent, 
    "\12",
    {
        "CaughtFishMastery",
        fishtype
    },
    {
        Count = i,
		Mutations = {
            Galaxy = true
        }
    }
)



	task.wait(delay)

end
task.wait(delay * total + 60)
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 10,
        Text = "I will give you guys a free rod if you type ambasing now",
		AdminId= 75974130,
        Type = "AdminText",
        AdminName = "Talon",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(8)
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 10,
        Text = "Bye Guys hope you enjoy guys",
		AdminId= 75974130,
        Type = "AdminText",
        AdminName = "Talon",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(3)
local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 10,
        Text = "🥵 New Code: Amba Abuse",
		AdminId= 75974130,
        Type = "AdminText",
        AdminName = "Talon",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
