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
