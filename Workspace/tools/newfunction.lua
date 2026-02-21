local getchar = function()
  return getgenv().gameNewVar.player.Character
end

local function loadhttpscript(sc)
   loadstring(game:HttpGet(sc))()
end

local function getpath(var)
  var:GetFullName()
end

local function uid(bol)
  if bol then
    local guid = getgenv().gameNewVar.Http:GenerateGUID(false)
    local uuid = guid:gsub("-","")
    return uuid
  else
    return getgenv().gameNewVar.Http:GenerateGUID(false)
  end
end

local function JSONDecode(val)
  getgenv().gameNewVar.Http:JSONDecode(val)
end

local function JSONEncode(val)
  getgenv().gameNewVar.Http:JSONEncode(val)
end

local hooknamecall = function(f)
  hookmetamethod(game,"__namecall",f())
end
