
local gameVar1 = game:GetService("Players")
local gameVar2 = gameVar1.LocalPlayer
local gameVar3 = game:GetService("UserInputService")
local gameVar4 = game:GetService("TweenService")
local gameVar5 = game:GetService("HttpService") 
local gameVar6 = game:GetService("ReplicatedStorage")
getgenv().gameNewVar = {
  players = gameVar1,
  player = gameVar2,
  UIS = gameVar3,
  TS = gameVar4,
  Http = gameVar5,
  Replicated = gameVar6
}

function getchar()
  return getgenv().gameNewVar.player.Character
end

function loadhttpscript(sc)
   loadstring(game:HttpGet(sc))()
end

function getpath(var)
  return var:GetFullName()
end

function uid(bol)
  if bol then
    local guid = getgenv().gameNewVar.Http:GenerateGUID(false)
    local uuid = guid:gsub("-","")
    return uuid
  else
    return getgenv().gameNewVar.Http:GenerateGUID(false)
  end
end

function JSONDecode(val)
  return getgenv().gameNewVar.Http:JSONDecode(val)
end

function JSONEncode(val)
  return getgenv().gameNewVar.Http:JSONEncode(val)
end
function postjson(uri,json)
	request({
			Url = uri,
			Method = "POST",
			Head = {["Content-type"] = "application/json"},
			Body = json or JSONEncode(json)
		})
end
-- method 

ex = {}
ex.__index = ex
function ex.new()
    local self = setmetatable({}, ex)
    return self
end
function ex:GetPlayTime()
  t = math.floor(game.Workspace.DistributedGameTime)
  return t
end

function ex:Respawn()
	getgenv().gameNewVar.player.Character.Humanoid.Health = 0
end

function ex:TriggerEvent(event,data)
	if event == "proximity" then
		fireproximityprompt(data)
	elseif event == "touch" then
		firetouchinterest(getgenv().gameNewVar.player.Character.HumanoidRootPart,data,0)
		firetouchinterest(getgenv().gameNewVar.player.Character.HumanoidRootPart,data,1)
	end
end

function ex:HttpScript(script)
  loadstring(game:HttpGet(script))()
end

liudex = {}
liudex.__index = liudex

function liudex.new(name,prop)
	local self = setmetatable({}, liudex)
	self.Name = name
  self.Property = prop
	return self
end
function liudex:SetProperty(prop)
  self.Property = prop
end
function liudex:GetName()
	print(self.Name)
end
function liudex:Rspwn()
	getgenv().gameNewVar.player.Character.Humanoid.Health = 0
end
function liudex:GetProperty()
	return self.Property
end

local a = liudex.new("Jorell")
local b = liudex.new("Budi","Alok")
print(a:GetName())
print(b:GetProperty())
return {
	ex = ex,
    liudex = liudex
}
