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
function ex:Fire(type,part)
	if type:lower() == "proximity" then
		fireproximityprompt(part)
	elseif type:lower() == "touch"
		firetouchinterest(getgenv().gameNewVar.player.Character.HumanoidRootPart,part,0)
		firetouchinterest(getgenv().gameNewVar.player.Character.HumanoidRootPart,part,1)
	elseif type:lower() == "click" then
		return
	end
end

function ex:HttpScript(script)
  loadstring(game:HttpGet(script))()
end

local liudex = {}
liudex.__index = liudex

function liudex.new(name,prop)
	local self = setmetatable({}, liudex)
	self.Name = name
  self.Property = prop
	return self
end
function liudex:GetName()
	print(self.Name)
end

function liudex:GetProperty()
	print(self.Property)
end

local a = liudex.new("Jorell")
local b = liudex.new("Budi","Alok")

print(a:GetName())
print(b:GetProperty())
