local getchar = function()
  return getgenv().player.Character
end

local function loadhttpscript(sc)
   loadstring(game:HttpGet(sc))()
end

local function getpath(var)
  var:GetFullName()
end

local function uid(bol)
  if bol then
    local guid = getgenv().Http:GenerateGUID(false)
    local uid = guid:gsub("-","")
    return uid
  else
    return getgenv().Http:GenerateGUID(false)
  end
end

local function JSONDecode(val)
  getgenv().Http:JSONDecode(val)
end

local function JSONEncode(val)
  getgenv().Http:JSONEncode(val)
end

local hooknamecall = function(f)
  hookmetamethod(game,"__namecall",f())
end
