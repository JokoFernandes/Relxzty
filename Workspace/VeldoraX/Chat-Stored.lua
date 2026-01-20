local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local player = game:GetService("Players").LocalPlayer

local WEBHOOK = "https://discord.com/api/webhooks/1441305375574851635/YV0xu1N8-KCGr1WV9x0RwsWiQD48Kxlg3qKd5C1DvS-K1ejfgKGYNY3NE_zQGcx_Bj8G"
local keywords = {}

local function removeMarkup(str)
    if not str then return "" end
    return (str:gsub("<.->", ""))
end

local function getRank(text)
    local rank = text:match("^%s*(%b[])")
    if rank then
        return rank:sub(2,-2)  -- hapus []
    end
    return "-"  -- default kalau tidak ada
end

-- Ambil Nama dari chat
local function getName(text)
    -- Ambil nama setelah rank (jika ada) sampai sebelum ":"
    local name = text:match("^%s*(%b[])?.-?%s*(.-)%s*:")
    return name or "-"
end
TextChatService.MessageReceived:Connect(function(msg)
    local rawText = msg.Text or msg.TextSource or tostring(msg)
    local cleanedText = removeMarkup(rawText)
    table.insert(keywords,"Nieagalodon")
    local violatekey = "-"
    for _, key in ipairs(keywords) do
        violatekey = key or "-"
        print(violatekey)
        break
    end
        local chatName = getName(cleanedText)
        local chatUserId = "-"
        local playerName = "-"
        task.wait()
        local datawh = {
            ["embeds"] = {
                {
                    ["title"] = "LIUDEX Z",
                    ["description"] = "||@here|| <:shut:1432612191064031252>",
                    ["color"] = 16711680,
                    ["thumbnail"] = {
                        ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                    },
                    ["fields"] = {
                        {["name"]="Name",["value"]=chatName,["inline"]=true},
                        {["name"]="UserName",["value"]="Test",["inline"]=true},
                        {["name"]="UserId",["value"]="nothing",["inline"]=true},
                        {["name"]="Violation",["value"]="none",["inline"]=false},
                        {["name"]="Message",["value"]="```"..cleanedText.."```",["inline"]=false}
                    },
                    ["footer"] = {
                        ["text"] = "footer text",
                        ["icon_url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                      },
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            }
        }
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(datawh)
        }) -- change this to PostAsync if you want to put in your roblox studio for your game

        print("TERKIRIM → " .. cleanedText)
end)

-- contoh system message
local msg = "Jokowi: obtained a <b><font color=\"rgb(24, 255, 152)\">Nieagalodon (450K kg)</font></b> with a 1 in 1Sx chance!"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
channel:DisplaySystemMessage(msg)
