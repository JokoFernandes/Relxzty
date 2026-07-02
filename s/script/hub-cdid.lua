local trucktimeout = 5
loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/tools/functions.lua"))()
local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/packages/UI-LIB.lua"))()
local camera = workspace.CurrentCamera

gui.Set({
    title = "CDID",
    textcolor = Color3.fromRGB(255,255,255),
    desc = "IM NOT ASEP",
    background = Color3.fromRGB(48,10,105),
    transparency = 0.25,
    tabbackground = Color3.fromRGB(66,23,137),
    tabtransparency = 0.7,
    border = Color3.fromRGB(52,5,105),
    toggle = {
        framecolor = Color3.fromRGB(110,32,245),
        active = Color3.fromRGB(0,255,0),
        inactive = Color3.fromRGB(255,0,0)
    },
    input = {
        framecolor = Color3.fromRGB(110,32,245),
        bgplaceholder =  Color3.fromRGB(100,17,185)
    },
    option = {
        active = Color3.fromRGB(91, 27, 201), -- rgb(53, 0, 145) pallete
        inactive = Color3.fromRGB(123, 93, 255),
        stroke = Color3.fromRGB(53, 0, 145)
    },
    buttonColor = Color3.fromRGB(110,32,245),
    logo = "rbxassetid://131858077876191" --or you can use getcustomasset to
})

local player = getplayer()

local main = gui.new("Main")
local truck = false
local farm = main:AddTab("Farm")
local time_job = tick()
function dotruck()

local function wheels(val)
for i,v in ipairs(workspace.Vehicles[player.Name .. "sCar"].Wheels:GetChildren()) do
v.CanCollide = val
end
end
local args = {
    "Truck"
}
game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("Job"):FireServer(unpack(args)) --get job
task.wait(1)
gototarget(workspace.Etc.Waypoint.Waypoint,true,1)
task.wait(5)
gototarget(workspace.Etc.Waypoint.Waypoint)
camera.CFrame = CFrame.lookAt(
    camera.CFrame.Position,
    workspace.Etc.Job.Truck.Starter.Prompt.Parent.Image.Position
)
task.wait(1)
fireproximityprompt(workspace.Etc.Job.Truck.Starter.Prompt)

task.wait()
getchar().HumanoidRootPart.CFrame = CFrame.new(0,0,0) + workspace.Etc.Job.Truck.Spawner.Part.Position + Vector3.new(0,8,0)
task.wait(1)
fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
camera.CFrame = CFrame.lookAt(
    camera.CFrame.Position,
    workspace.Etc.Job.Truck.Spawner.Part.Prompt.Parent.Position
)
local player = game:GetService("Players").LocalPlayer
task.wait(8)
local car = workspace.Vehicles[player.Name .. "sCar"]
local seat = workspace.Vehicles[player.Name .. "sCar"].DriveSeat.PromptDriveSeat
gototarget(seat.Parent)
task.wait(0.5)
fireproximityprompt(seat)
task.wait(0.5)
keypress(Enum.KeyCode.P)
wheels(false)
local root = workspace.Vehicles[player.Name .. "sCar"].Body["#Weight"]
local car = workspace.Vehicles[player.Name .. "sCar"]
local carhrp = car.PrimaryPart
local target = workspace.Etc.Waypoint.Waypoint
local scr = 0
while scr <= 12 do
car:SetPrimaryPartCFrame(target.CFrame * CFrame.new(-500,450,0))
root.Anchored = false
task.wait(1.8)
root.AssemblyLinearVelocity = Vector3.new(0,0,0)
root.Anchored = true
task.wait(1.8)
root.AssemblyLinearVelocity = Vector3.new(0,0,0)
task.wait(0.2)
scr = scr + 1
end
root.Anchored = false
car:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0,1,0))
task.wait(1)
local near = 0
local nearest = 3000
for i,v in pairs(workspace.Etc.Job.Truck.Destination:GetChildren()) do
    if v:IsA("BasePart") then
        if (v.Position - getrootpart().Position).Magnitude < nearest then
            near = v.CFrame
            nearest = (getrootpart().Position - v.Position).Magnitude
        end
    end
end
car:SetPrimaryPartCFrame(near * CFrame.new(0,1,0))
task.wait(0.1)
local getcash = game:GetService("Players").LocalPlayer.PlayerGui.Main.Container.Hub.CashFrame.TextLabel
local repeatruck = 0
repeat
repeatruck = repeatruck + 1
root.AssemblyLinearVelocity = Vector3.new(0,0,0)
car:SetPrimaryPartCFrame(near * CFrame.new(0,-1,0))
task.wait(0.3)
root.AssemblyLinearVelocity = Vector3.new(0,0,0)
until (getcash.Transparency < 1 and getcash.TextTransparency < 1) or repeatruck >= trucktimeout

wheels(true)
end
farm:Toggle({Text = "Farm Truck",Callback = function(val) truck = val end},false)
task.spawn(function()
local is_working = false
while task.wait(0.2) do
    if truck and (tick() - time_job) > 0.9 then
        time_job = tick()
        local suc,res = pcall(dotruck) 
        if not suc then
            warn("Refresh")
        end
        warn(res)
        is_working = false
    end
    task.wait(0.1)
end
end)
local pot;
local RunService,RenderSettings = import.RunService,cloneref(settings():GetService("RenderSettings"))
local render = gui.new("Misc"):AddTab("Render")
render:Toggle({Text = "Render 3D",Callback = function(val) RunService:Set3dRenderingEnabled(not val) end})
render:Toggle({Text = "NIH GAS",Callback = function(val)
    pot = val
end})
render:Button({Text = "Disable Material",OnClick = function(val)
    local j = 0
    for i,v in ipairs(game:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("MeshPart")) and not v:IsDescendantOf(getchar()) then
            v.Material = Enum.Material.Plastic
            v.MaterialVariant = ""
            v.TopSurface = Enum.SurfaceType.Smooth
            v.BottomSurface = Enum.SurfaceType.Smooth
            v.LeftSurface = Enum.SurfaceType.Smooth
            v.RightSurface = Enum.SurfaceType.Smooth
            v.FrontSurface = Enum.SurfaceType.Smooth
            v.BackSurface = Enum.SurfaceType.Smooth
            j = j + 1
        end
        if j >= 450 then
            task.wait(0.15)
            j = 0
        end
    end
end})
render:Button({Text = "Disable Texture",OnClick = function(val)
for i,v in ipairs(game:GetDescendants()) do
    if v:IsA("MeshPart") and not v:IsDescendantOf(getchar()) then
        v.TextureID = "rbxassetid://0"
    elseif v:IsA("Decal") and not v:IsDescendantOf(getchar()) then
        v.Texture = "rbxassetid://0"
    end
end
end})
render:Button({Text = "Disable Particle Effect",OnClick = function(val)
for i,v in ipairs(game:GetDescendants()) do
    if v:IsA("Beam") or v:IsA("Explosion") or v:IsA("ParticleEmitter") or v:IsA("Sparkles") or v:IsA("Smoke") or v:IsA("Trail") then
        v:Destroy()
    end
end
end}) 
render:Button({Text = "Less Render",OnClick = function() RenderSettings.GraphicsMode = Enum.GraphicsMode.NoGraphics
RenderSettings.QualityLevel = Enum.QualityLevel.Level01
RenderSettings.EditQualityLevel = Enum.QualityLevel.Level01
RenderSettings.ViewMode = Enum.ViewMode.None
RenderSettings.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
end})
game.DescendantAdded:Connect(function(v)
    if pot then
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Transparency = 1
        end
    end
end)

sethiddenproperty(workspace, "StreamingMinRadius", 2) 
sethiddenproperty(workspace, "StreamingTargetRadius", 3)

getplayer().Idled:Connect(function(time)
    mouse2click()
    task.wait()
    mouse2click()
    task.wait(0.6)
    mouse2click()
end)

local function getthumnail(id)
  local urls = import.HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar?userIds=".. id .."&size=250x250&format=Png&isCircular=false"))
  local image = urls.data[1].imageUrl
  print(image)
  return image
end

print(getthumnail(getplayer().UserId))
local function sendplrdata(url)
local bd = {
    content = "@here",
    username = "Alok Perpeler perpeler",
    avatar_url = "https://upload.wikimedia.org/wikipedia/commons/b/be/Joko_Widodo_2019_official_portrait.jpg",
    embeds = {
        {
            title = getplayer().DisplayName,
            description = "PlaceId ```" .. game.PlaceId .. "```\nJobId ```" .. game.JobId .. "```" .. "\nCash```" .. getplayer().PlayerGui:WaitForChild('Main').Container.Hub.CashFrame.Frame.TextLabel.Text .. "```",
            color = 14177041,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            thumbnail = {url = getthumnail(getplayer().UserId)}
        }
    }
}

request({
    Url = url or "",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = import.HttpService:JSONEncode(bd)
})
end

local wh = gui.new("Webhook")
local webhook,lastwhsend,enablewh = wh:AddTab("Webhook"),tick(),false
local urlf,url = webhook:Input({Text = "Webhook URL",Placeholder = "url..."})
webhook:Button({Text = "Test",OnClick = function() sendplrdata(url.Text) end})
webhook:Toggle({Text = "Enable Send Data",Callback = function(val) enablewh = val end})

--secondary
import.RunService.RenderStepped:Connect(function()
    if enablewh and (tick() - lastwhsend) >= (15 * 60) then
        lastwhsend = tick()
        sendplrdata(url.Text)
    end
end)
--[[
local Event = game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.PhoneEarnings
for _, Connection in getconnections(Event.OnClientEvent) do
	local old; old = hookfunction(Connection.Function, function(...)
		print(`Intercepted (Connection) {Event.Name}.OnClientEvent`, ...)
		return old(...)
	end)
end]]
