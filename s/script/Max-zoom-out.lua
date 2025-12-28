local maxcam= getgenv().max
local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CameraMinZoomDistance = 0.5
player.CameraMaxZoomDistance = maxcam
