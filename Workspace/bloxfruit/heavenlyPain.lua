-- lighting
-- Diamon Muani
-- simplefied
local location = game:GetService("Players").LocalPlayer:WaitForChild("PainFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")
local a,b,c = 255,255,0
local d,e,f = 255,255,255
local h,i,j = 210,210,210
local k,l,m = 255,255,0
local color2 = Color3.fromRGB(a,b,c)
local color = Color3.fromRGB(d,e,f)
local color3 = Color3.fromRGB(h,i,j)
local color4 = Color3.fromRGB(k,l,m)
function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end
local newSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 200, 0))
})

recolor(shifted,"GrayscaleToColorStrength",1)
recolor(shifted,"GrayscaleToColorSequence",newSequence)
recolor(fruit, "Default_Color1", color2)
recolor(fruit,"Default_Color2", color2)
recolor(fruit,"Default_Color3", color2)
recolor(shifted,"Shifted_Color1",color)
recolor(shifted,"Shifted_Color2",color3)
recolor(shifted,"Shifted_Color3",color)
