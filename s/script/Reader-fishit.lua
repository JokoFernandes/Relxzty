local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local player = game:GetService("Players").LocalPlayer

local WEBHOOK = "https://discord.com/api/webhooks/..."
local keywords = getgenv().listToRead

local function removeMarkup(str)
    if not str then return "" end
    return (str:gsub("<.->", ""))
end

TextChatService.MessageReceived:Connect(function(msg)
    local rawText = msg.Text or msg.TextSource or tostring(msg)
    local cleanedText = removeMarkup(rawText)
    table.insert(keywords,"Nieagalodon")

    for _, key in ipairs(keywords) do
        -- cari pola chance: "with a 1 in 100M chance"
        local chanceMatch = cleanedText:match("with a%s+(.-)%s+chance")
        local playerName = cleanedText:match("%[Server%]%:%s+(.-)%s+obtained") or player.DisplayName

        if cleanedText:lower():find(key:lower()) then
            print("Keyword terdeteksi → " .. key)
            if chanceMatch then
                print("Chance terdeteksi → " .. chanceMatch)
            end

            local datawh = {
                ["content"] = playerName .. " caught " .. key,
                ["embeds"] = {
                    {
                        ["title"] = playerName,
                        ["description"] = "||@here||",
                        ["color"] = 16711680,
                        ["thumbnail"] = {
                            ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                        },
                        ["fields"] = {
                            {["name"]="Name",["value"]=playerName,["inline"]=true},
                            {["name"]="Caught",["value"]=key,["inline"]=true},
                            {["name"]="Chance",["value"]=chanceMatch or "N/A",["inline"]=true},
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

            local httpRequest = syn and syn.request or http_request or request
            httpRequest({
                Url = WEBHOOK,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(datawh)
            })

            print("TERKIRIM → " .. cleanedText)
            break
        end
    end
end)

-- contoh system message
local msg = "<b><font size=\"18\">[Server]:</font></b> Jokowi obtained a <b><font color=\"rgb(24, 255, 152)\">Nieagalodon (450K kg)</font></b> with a 1 in 1Sx chance!"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
channel:DisplaySystemMessage(msg)
