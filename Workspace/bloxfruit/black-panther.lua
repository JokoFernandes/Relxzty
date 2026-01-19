-- Tiger Chromatic
-- simplefied
local location = game:GetService("Players").LocalPlayer:WaitForChild("LeopardFruitVFXColor")
local fruit = location:WaitForChild("Default")
local shifted = location:WaitForChild("Shifted")
local a,b,c = 0,0,250
local d,e,f = 0,25,0
local color2 = Color3.fromRGB(a,b,c)
local color = Color3.fromRGB(d,e,f)
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

-- Transform
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local tigerIdle = game:GetService("ReplicatedStorage").Util.Anims.Storage["2"].Tiger.Transformed.Movement.TigerTransformed_Idle
local tigerMovement = game:GetService("ReplicatedStorage").Util.Anims.Storage["2"].Tiger.Transformed.Movement.TigerTransformed_Movement
tigerMovement = "rbxassetid://124379749442847"
tigerIdle.AnimationId = "rbxassetid://73861360346938"
char.ChildAdded:Connect(function(obj)
    if obj.Name == "TigerRig" then
        task.wait(0.5)
        print("change")

        local tigerRig = obj
        local body = tigerRig:WaitForChild("TigerRig"):WaitForChild("Body")
        local eyes = tigerRig:WaitForChild("TigerRig"):WaitForChild("Eyes")
        local surface = body:FindFirstChild("SurfaceAppearance")
        eyes.Color = Color3.fromRGB(255,10,5)
        body.Color = Color3.fromRGB(25,5,60)
          body.Material = Enum.Material.Cobblestone
        if surface then
            surface:Destroy()
        end
          local hair =char:WaitForChild("TigerRig"):WaitForChild("AccessoriesFolder"):WaitForChild("Handle")
        hair.Transparency = 1
    end
end)
