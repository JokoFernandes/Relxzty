local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RETextNotification = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/TextNotification"]

-- This data was received from the server
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 5,
        Text = "Hello Everyone",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(2)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 5,
        Text = "Tubers Was Here",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(4.4)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "This game is so boring",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(5)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "lets make it more fun",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(5)
function decal(texture, enum, parent)
    local decal = Instance.new("Decal")
    decal.Texture = texture
    decal.Face = enum
    decal.Parent = parent
    return decal
end
local function changeMaterial(container, newMaterial)
    -- Loop semua child di dalam container
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("BasePart") then
            -- Kalau object adalah Part/MeshPart, ubah material
            child.Material = newMaterial
            local res = getcustomasset("base.png") or "rbxassetid://126569944133822"
            decal(res, Enum.NormalId.Top, child)
            decal(res, Enum.NormalId.Left, child)
            decal(res, Enum.NormalId.Right, child)
            decal(res, Enum.NormalId.Front, child)
            decal(res, Enum.NormalId.Back, child)
            decal(res, Enum.NormalId.Bottom, child)
        elseif child:IsA("Model") or child:IsA("Folder") then
            -- Kalau object adalah Model/Folder, loop lagi ke dalamnya
            changeMaterial(child, newMaterial)
        end
    end
end
local Lighting = game:GetService("Lighting")

function setSky(assetId,SunassetId)
    -- Hapus Sky lama
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then
            v:Destroy()
        end
    end

    -- Buat Sky baru
    local newSky = Instance.new("Sky")
    newSky.Name = "LSky"

    -- Pakai assetId untuk semua arah
    newSky.SkyboxBk = assetId
    newSky.SkyboxDn = assetId
    newSky.SkyboxFt = assetId
    newSky.SkyboxLf = assetId
    newSky.SkyboxRt = assetId
    newSky.SkyboxUp = assetId
    newSky.SunTextureId = SunassetId
    newSky.MoonTextureId = SunassetId
    newSky.SunAngularSize = 30
    newSky.MoonAngularSize = 30
    -- Masukkan ke Lighting
    newSky.Parent = Lighting
end

-- Panggil fungsi dengan asset ID
local sun = getcustomasset("sun.png")
local sky = getcustomasset("sky.png")
-- "rbxassetid://126569944133822"
setSky(sky,sun)
-- Panggil fungsi untuk workspace
changeMaterial(workspace, Enum.Material.Neon) -- contoh: ubah semua jadi Neon
task.wait(10)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "Perfect",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(2)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "it's better now.",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(5)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "We walk the talk, not only talk the talk",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
task.wait(1)
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local msg = "<font color='rgb(255, 215, 105)'>King of Java join the game</font>"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
channel:DisplaySystemMessage(msg)
task.wait(8)
firesignal(RETextNotification.OnClientEvent, 
    {
        CustomDuration = 8,
        Text = "He Deop Jokowi",
		AdminId= 8651913431,
        Type = "AdminText",
        AdminName = "Tubers93",
        TextColor = {
            B = 0,
            G = 0,
            R = 0
        }
    }
)
