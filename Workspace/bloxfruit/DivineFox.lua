-- Tiger Chromatic
-- simplefied
local location = game:GetService("Players").LocalPlayer:WaitForChild("KitsuneFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end
local color = Color3.fromRGB(255,255,255)
local color2 = Color3.fromRGB(170,160,10)
recolor(fruit,"Default_Color1",Color3.new(0.152941, 0.239216, 1))
recolor(fruit,"Default_Color2",Color3.new(0.239216, 0.403922, 1))
recolor(fruit,"Default_Color3",Color3.new(0.25098, 0.513726, 1))
recolor(fruit,"Default_Color4",Color3.new(0.14902, 0.14902, 1))
recolor(fruit,"Default_Color5",Color3.new(0.839216, 0.427451, 0.152941))
recolor(fruit,"Default_Color6",Color3.new(0.329412, 0.160784, 1))
recolor(fruit,"Default_Color7",Color3.new(0.368627, 1, 0.980392))
recolor(fruit,"Default_Color8",Color3.new(1, 0.129412, 0.145098))
recolor(fruit,"Default_Color9",Color3.new(0.462745, 1, 0.192157))

recolor(shifted,"Shifted_Color1",color2)
recolor(shifted,"Shifted_Color2",color)
recolor(shifted,"Shifted_Color3",color)
recolor(shifted,"Shifted_Color4",color)
recolor(shifted,"Shifted_Color5",color)
recolor(shifted,"Shifted_Color6",color)
recolor(shifted,"Shifted_Color7",color)
recolor(shifted,"Shifted_Color8",color)
recolor(shifted,"Shifted_Color9",color)

char.ChildAdded:Connect(function(obj)
    if obj.Name == "Kitsune" then
        task.wait(0.2)
        print("change")
        local kitsuneRig = obj
        local body = kitsuneRig:WaitForChild("Kitsune"):WaitForChild("Kitsune")
        local surface = body:FindFirstChild("SurfaceAppearance")
        local var = surface:Clone()
        if surface then
        var.ColorMap = "rbxassetid://126543037252587"
        var.MetalnessMap = surface.MetalnessMap
        var.NormalMap = "rbxassetid://126543037252587"
        var.RoughnessMap =surface.RoughnessMap
        var.TexturePack = ""
        var.Parent = body
        print("changed")
            surface:Destroy()
        end
    end
end)
