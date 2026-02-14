-- Tiger Chromatic
-- simplefied
local Debris = game:GetService("Debris")
local location = game:GetService("Players").LocalPlayer:WaitForChild("LeopardFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")
local tigerM = game:GetService("ReplicatedStorage").Util.Anims.Storage["2"].Tiger.Transformed.Movement
local tigerIdle = tigerM.TigerTransformed_Idle
local tigerMovement = tigerM.TigerTransformed_Movement
local tigerBackR = tigerM.TigerTransformed_BackR
local tigerBackL = tigerM.TigerTransformed_BackL
local tigerFrontR = tigerM.TigerTransformed_FrontR
local tigerFrontL = tigerM.TigerTransformed_FrontL
local tigerM4 = tigerM.Parent.M1s.TigerM1_4
local tigerZ = tigerM.Parent.Z.TigerTransformedZ_Loop
local tigerZEnd = tigerM.Parent.Z.TigerTransformedZ_End
local a,b,c = 0,0,250
local d,e,f = 0,25,0
local color2 = Color3.fromRGB(a,b,c)
local color = Color3.fromRGB(d,e,f)
local player = game:GetService("Players").LocalPlayer
local backpack = player.Backpack
local TigerTool = backpack:WaitForChild("Tiger-Tiger") or player.Character:WaitForChild("Tiger-Tiger")
function recolor(items, attr, color)
    items:SetAttribute(attr, color)
end

recolor(fruit, "Default_Color1", color2)
recolor(fruit,"Default_Color2", color2)
recolor(fruit,"Default_Color3", color2)
recolor(fruit, "Default_Color4", color2)
recolor(shifted,"Shifted_Color1",color)
recolor(shifted,"Shifted_Color2",color)
recolor(shifted,"Shifted_Color3",color)
recolor(shifted,"Shifted_Color4",color)

TigerTool.TextureId = "rbxassetid://124960029816151"
TigerTool:SetAttribute("ImageRectOffset", Vector2.new(819.25, 409))
TigerTool:SetAttribute("ImageRectSize", Vector2.new(205, 205))
-- Transform
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
tigerMovement.AnimationId = "rbxassetid://124379749442847"
tigerIdle.AnimationId = "rbxassetid://73861360346938"
tigerBackR.AnimationId = "rbxassetid://140122562850398"
tigerBackL.AnimationId = "rbxassetid://105746370380417"
tigerM4.AnimationId = "rbxassetid://121749335304244"
tigerZ.AnimationId = "rbxassetid://90948121692026"
tigerZEnd.AnimationId = "rbxassetid://120948155674370"
tigerFrontR.AnimationId = "rbxassetid://87417508667430"
tigerFrontL.AnimationId = "rbxassetid://87417508667430" 

char.ChildAdded:Connect(function(obj)
    if obj.Name == "TigerRig" then
        task.wait()
        print("change")

        local tigerRig = obj
        local body = tigerRig:WaitForChild("TigerRig"):WaitForChild("Body")
        local eyes = tigerRig:WaitForChild("TigerRig"):WaitForChild("Eyes")
        local surface = body:FindFirstChild("SurfaceAppearance")
        eyes.Color = Color3.fromRGB(255,10,5)
        body.Color = Color3.fromRGB(10,0,25)
        body.Material = Enum.Material.Cobblestone
        if surface then
            Debris:AddItem(surface, 0)
        end
        local hair =char:WaitForChild("TigerRig"):WaitForChild("AccessoriesFolder"):WaitForChild("Handle")
        hair.Transparency = 1
        task.wait()
        cr()
    end
end)
