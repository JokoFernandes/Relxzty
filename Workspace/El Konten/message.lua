local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
