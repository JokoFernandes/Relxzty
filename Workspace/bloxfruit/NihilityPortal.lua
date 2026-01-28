local location = game:GetService("Players").LocalPlayer:WaitForChild("PortalFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")

function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end

local a,b,c = 150,25,0
local d,e,f = 80,80,80
local color = Color3.fromRGB(a,b,c)
local color2 = Color3.fromRGB(d,e,f)
recolor(fruit, "Default_Color1", color)
recolor(fruit,"Default_Color2", color)
recolor(fruit,"Default_Color3", color)
recolor(fruit, "Default_Color4", color)
recolor(fruit, "Default_Color5", color)
recolor(fruit,"Default_Color6", color)
recolor(fruit,"Default_Color7", color)
recolor(shifted,"Shifted_Color1",color2)
recolor(shifted,"Shifted_Color2",color2)
recolor(shifted,"Shifted_Color3",color2)
recolor(shifted,"Shifted_Color4",color2)
recolor(shifted,"Shifted_Color5",color2)
recolor(shifted,"Shifted_Color6",color2)
recolor(shifted,"Shifted_Color7",color2)
