function getchar()
  return getgenv().gameNewVar.player.Character
end

function loadhttpscript(sc)
   loadstring(game:HttpGet(sc))()
end

function getpath(var)
  var:GetFullName()
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
  getgenv().gameNewVar.Http:JSONDecode(val)
end

function JSONEncode(val)
  getgenv().gameNewVar.Http:JSONEncode(val)
end

-- method 

local ex = {}
function ex:GetPlayTime()
  local t = math.floor(game.Workspace.DistributedGameTime)
	local jam = math.floor(t / 3600)
  local menit = math.floor((t % 3600) / 60)
  local detik = t % 60
  local playtime = {
    H = jam,
    M = menit,
    S = detik
  }
  return playtime
end

function ex:Respawn()
	getgenv().gameNewVar.player.Character.Humanoid.Health = 0
end

function ex:TriggerEvent(event,data)
	if event == "proximity" then
		fireproximityprompt(data)
	elseif event == "touch" then
		firetouchinterest(getchar().HumanoidRootPart,data,0)
		firetouchinterest(getchar().HumanoidRootPart,data,1)
	end
end

function ex:HttpScript(script)
  loadstring(game:HttpGet(script))()
end

function ex:RunNameCallIf(var,func,metode,varname)
  var = hookmetamethod(game,"__namecall",function(self,...)
  local method = getnamecallmethod()
  if name then
    if method == metode and name == varname then
      func()
    end
  else
    if method == metode then
      func()
    end
  end
     
    return var(self,...)
  end)
end

local liudex = {}
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

function liudex:GetProperty()
	return self.Property
end

local a = liudex.new("Jorell")
local b = liudex.new("Budi","Alok")

print(a:GetName())
print(b:GetProperty())
