if import.RobloxReplicatedStorage.GetServerType:InvokeServer() ~= "VIPServer" then
    ldx:Announce("Warning","You are in public right now go to private server to run this script")
    print("Not on VIPServer")
    return
end

if getgenv().ldxautofamrsailor then
    return
end

getgenv().ldxautofamrsailor = true

local EquipTool = game:GetService("ReplicatedStorage").Remotes.EquipWeapon

local function useskill(num)
local Event = game:GetService("ReplicatedStorage").AbilitySystem.Remotes.RequestAbility
Event:FireServer(num)
end

local function acceptquest(quest)
local Event = game:GetService("ReplicatedStorage").RemoteEvents.QuestAccept
Event:FireServer("QuestNPC10")
end

local function repeatquest(quest)
local Event = game:GetService("ReplicatedStorage").RemoteEvents.QuestRepeat
Event:FireServer("QuestNPC10")
end

local function endquest()
local Event = game:GetService("ReplicatedStorage").RemoteEvents.QuestAbandon
Event:FireServer("repeatable")
end

local function upgradeestats(point,stat)
local Event = game:GetService("ReplicatedStorage").RemoteEvents.AllocateStat
Event:FireServer(stat,point)
end

local function equipweapon(weapon)
EquipTool:FireServer("Equip",weapon)
end

local function gotoisland(island)
local Event = game:GetService("ReplicatedStorage").Remotes.TeleportToPortal
Event:FireServer(island)
end

local function reqhit(target)
local Event = game:GetService("ReplicatedStorage").CombatSystem.Remotes.RequestHit
Event:FireServer(target.Position)
end

local key1 = Enum.KeyCode.One
local key2 = Enum.KeyCode.Two
local key3 = Enum.KeyCode.Three
local VIM = game:GetService("VirtualInputManager")

local function fireskill()
    equipweapon("Anos")
    task.wait(0.5)
    VIM:SendKeyEvent(true,key1,false,game)
    task.wait()
    VIM:SendKeyEvent(false,key1,false,game)
    task.wait(0.6)
    useskill(1)
    task.wait(2.75)
    equipweapon("Strongest In History")
    task.wait(0.5)
    VIM:SendKeyEvent(true,key1,false,game)
    task.wait()
    VIM:SendKeyEvent(false,key1,false,game)
    task.wait(0.6)
    useskill(2)
end

local config = {
    FarmName = "NPCNAME",
    Skill = 2,
    Quest = "10",
}


local i = false
local n, a, l, s = 
CFrame.new(-1874.85852, 8.5140295, -738.912109, -0.924387217, -1.07305576e-09, 0.381455481, 4.73140505e-09, 1, 1.42787462e-08, -0.381455481, 1.5003911e-08, -0.924387217), 
CFrame.new(1072.83594, 1.77835536, 1275.90063, 0.764241993, 2.56266404e-08, -0.644929588, -8.37245153e-08, 1, -5.94780438e-08, 0.644929588, 9.94520377e-08, 0.764241993),
CFrame.new(60.6488075, 0.578745723, 1816.01917, -0.938887239, 7.71933202e-08, -0.3442249, 4.30438227e-08, 1, 1.06848816e-07, 0.3442249, 8.55022364e-08, -0.938887239),
CFrame.new(-1341.80322, 1604.37329, 1597.76282, -0.998015821, -3.26242677e-08, 0.0629635081, -2.63301914e-08, 1, 1.00793628e-07, -0.0629635081, 9.89357929e-08, -0.998015821)

function gotoisland(island,npc,key)
local Event = game:GetService("ReplicatedStorage").Remotes.TeleportToIslandSpot
Event:FireServer(island,npc)
task.wait(0.4)
if npc == "QuestNPC18" then
getchar().HumanoidRootPart.CFrame = n
elseif npc == "QuestNPC19" then
getchar().HumanoidRootPart.CFrame = 
l
elseif npc == "QuestNPC15" then
getchar().HumanoidRootPart.CFrame =
a
elseif npc == "QuestNPC17" then
getchar().HumanoidRootPart.CFrame =
s
end
task.wait(0.5)
end

gotoisland("Hogyoku","QuestNPC17",key1)
task.wait(3)
local COREGUI = import.CoreGui
local networkPaused = COREGUI.RobloxGui.ChildAdded:Connect(function(obj)
        if obj.Name == "CoreScripts/NetworkPause" then
            obj:Destroy()
        end
    end)
    COREGUI.RobloxGui["CoreScripts/NetworkPause"]:Destroy()
--[[local path = workspace.NPCs.SukunaBoss.HumanoidRootPart
gototarget(path,true,30)]]
task.spawn(function()
    while task.wait() do
        fireskill()
        task.wait(2)
    end
end)
local sessionStart = os.time()
local qtp = queueonteleport or queue_on_teleport

while true do
gotoisland("Lawless","QuestNPC19",key1)
task.wait(1.1)
gotoisland("Ninja","QuestNPC18",key1)
task.wait(1.1)
gotoisland("Ninja","QuestNPC17",key1)
task.wait(1.1)
gotoisland("Academy","QuestNPC15",key2)
task.wait(1.1)
if ((os.time() - sessionStart) / 60) >= 120 then
    qtp([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Asepthegoat/LIUDEX-Z/refs/heads/main/script/delta-addon.lua"))()
    task.wait()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/s/script/sailor4island.lua"))()
]])
task.wait()
import.TeleportService:Teleport(game.PlaceId,getplayer())
end
end
