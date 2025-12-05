local color = _G.color
local scolor = _G.secColor
local rod = _G.rod
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local partA = game:GetService("ReplicatedStorage").VFX[rod .. " Dive"]
local partB = game:GetService("ReplicatedStorage").VFX["Bait Dive"]

if partA and partB then
    for _, obj in ipairs(partA:GetChildren()) do
            local clone = obj:Clone()
            clone.Parent = partB
           for _, sub in ipairs(clone:GetDescendants()) do
            if sub:IsA("ParticleEmitter") then
                sub.Color = color
            elseif sub:IsA("Beam") then
                sub.Color = color
            elseif sub:IsA("Trail") then
                sub.Color = color
            elseif sub:IsA("PointLight") or sub:IsA("SpotLight") or sub:IsA("SurfaceLight") then
                sub.Color = scolor
            end
        end
    end
end

