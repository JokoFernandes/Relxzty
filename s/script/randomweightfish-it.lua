-- admin abuse

-- input
local chance = _G.chance
local min = tonumber((_G.min or 0))
local max = tonumber((_G.max or 0)) - 0.1
local fishId = tonumber((_G.fishId or 186))
local delay = tonumber(_G.delay)
local fishtype = _G.fishtype
local mutation = {
	             "Galaxy", 
	             "Radioactive",
	             "Fairy Dust",
	             "Stone",
	             "Albino",
	             "Holographic",
	             "Moon Fragment",
	             "1X1X1",
	             "Bloodmoon",
                }

if max < min then
    max = min
end

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function formatNumber(num)
    if num >= 1_000_000_000 then
        return string.format("%.1fB", num / 1_000_000_000)  -- Billion
    elseif num >= 1_000_000 then
        return string.format("%.1fM", num / 1_000_000)      -- Million
    elseif num >= 1_000 then
        return string.format("%.1fK", num / 1_000)          -- Thousand
    else
        return tostring(num)
    end
end
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
	local wght = min + (math.random(0, 1000000) / 1000000) * (max - min)
	local m = math.random(1, #mutation) 
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
			VariantId= mutation[m],
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
local messager = "<b><font size=\'20\' color=\'#ffffff\'>[Server]:</font></b> " .. player.DisplayName .. " obtained a <b><font color=\'rgb(24, 255, 152)\'>" .. string.upper(mutation[m]) .. " " ..  fishtype  .. " ("..weight  .. " kg)</font></b> with ".. chance .." chance!"
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
			VariantId = mutation[m]
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
					VariantId = mutation[m]
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
