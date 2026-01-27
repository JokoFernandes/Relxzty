-- lighting
-- Diamon Muani
-- simplefied
local location = game:GetService("Players").LocalPlayer:WaitForChild("PainFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")
local a,b,c = 255,255,255
local d,e,f = 18,5,50
local color2 = Color3.fromRGB(a,b,c)
local color = Color3.fromRGB(d,e,f)
function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end
recolor(shifted,"GrayscaleToColorStrength",0.1)
recolor(fruit, "Default_Color1", color2)
recolor(fruit,"Default_Color2", color2)
recolor(fruit,"Default_Color3", color2)
recolor(shifted,"Shifted_Color1",color)
recolor(shifted,"Shifted_Color2",color)
recolor(shifted,"Shifted_Color3",color)
