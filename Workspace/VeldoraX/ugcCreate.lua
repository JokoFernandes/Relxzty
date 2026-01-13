
local function customAccessory(acsyId, acsyParent, acsyColor, acsyTexture,x,y,z)
    local rot = CFrame.Angles(math.rad(x), math.rad(y), math.rad(z))
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild(acsyParent)

    -- bikin Part baru
    local part = Instance.new("MeshPart")
    part.Name = "Liudex Accessory"
    part.Size = Vector3.new(1, 1, 1)
    part.MeshId = acsyId or "rbxassetid://15172160765"
    part.Color = acsyColor or Color3.fromRGB(255, 255, 255)
    part.CanCollide = false
    part.Anchored = false
    part.Parent = character
    part.TextureID = acsyTexture or ""

    -- bikin weld ke Head
    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = part
    weld.C0 = CFrame.new(0, 0, 0)
    weld.C1 = CFrame.new(0, -0.6, 0) * rot
    weld.Parent = part

    -- posisikan awal part relatif ke kepala
    part.CFrame = head.CFrame * CFrame.new(0, 2, 0)
end

customAccessory(getgenv().acsryId, getgenv().acsryParent, getgenv().acsryColor, getgenv().acsryTexture,getgenv().acsryX,getgenv().acsrY,getgenv().acsrZ)
