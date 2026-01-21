local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local place = game.PlaceId
local function detectGame(placeId,str)
  if place == placeId then
    print(str)
  end
end
detectGame(121864768012064,"Fish It")
detectGame(2753915549,"Blox Fruit")
detectGame(7041939546,"Catalog Avatar")

loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/VeldoraX/create-party.lua"))()
task.wait()
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local StarterGui = game:GetService("StarterGui")
if isfolder("LIUDEX Z") then
for i,v in ipairs(listfiles("LIUDEX Z/Auto Execute")) do
   print(v)
   loadfile("LIUDEX Z/Auto Execute/" .. v)
   if v == "Blox Fruit" then
      print("bf")
    end
end
else 
makefolder("LIUDEX Z")
task.wait()
makefolder("LIUDEX Z/Auto Execute")
makefolder("LIUDEX Z/Config")
writefile("LIUDEX Z/Config/Chat.lorips","true\nViolation under here \ngive me robux\nsex\ni will give you robux\ncutie\ncome with me")
end


-- Buat BindableFunction
local clickBindable = Instance.new("BindableFunction")

-- Fungsi saat tombol diklik
clickBindable.OnInvoke = function(button)
    if button == "Join" then
       setclipboard("https://discord.gg/WmsssRkgd2")
        print("Copy")
        task.wait(0.8)
        StarterGui:SetCore("SendNotification", {
            Title = "Link Copied",
            Icon = "rbxassetid://71775514575470", -- contoh ikon notifikasi default
            Text = "Paste it to browser to join",
            Duration = 10,
            Callback = nil,
            Button1 = "Close",
})
        -- contoh aksi
        -- game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    elseif button == "No Thanks" then
        print("Player klik Cancel")
    end
end

-- Kirim notifikasi
StarterGui:SetCore("SendNotification", {
    Title = "LUIDEX Z v 0.01",
    Icon = "rbxassetid://71775514575470", -- contoh ikon notifikasi default
    Text = "Loading ...",
    Duration = 4
})
task.wait(1)
StarterGui:SetCore("SendNotification", {
    Title = "Discord",
    Icon = "rbxassetid://71775514575470", -- contoh ikon notifikasi default
    Text = "Join our Discord Server  to get more info",
    Duration = 10,
    Callback = clickBindable,
    Button1 = "Join",
    Button2 = "No Thanks"
})

task.wait(3)

