local location = game:GetService("Players").LocalPlayer:WaitForChild("LightningFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")

function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end

local a,b,c = 255,0,255
local d,e,f = 60,5,0
local color = Color3.fromRGB(a,b,c)
local color2 = Color3.fromRGB(d,e,f)
recolor(fruit, "Default_Color1", color)
recolor(fruit,"Default_Color2", color)
recolor(fruit,"Default_Color3", color)
recolor(fruit, "Default_Color4", color)
recolor(shifted,"Shifted_Color1",color2)
recolor(shifted,"Shifted_Color2",color2)
recolor(shifted,"Shifted_Color3",color2)
recolor(shifted,"Shifted_Color4",color2)
