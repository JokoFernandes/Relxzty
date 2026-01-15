local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local player = game:GetService("Players").LocalPlayer
local WEBHOOK = "https://discord.com/api/webhooks/1441305375574851635/YV0xu1N8-KCGr1WV9x0RwsWiQD48Kxlg3qKd5C1DvS-K1ejfgKGYNY3NE_zQGcx_Bj8G"

local keywords = getgenv().listToRead

local function removeMarkup(str)
    if not str then return "" end
    return (str:gsub("<.->", ""))
end

TextChatService.MessageReceived:Connect(function(msg)
    -- Ambil text aman dari pesan
    local rawText = msg.Text or msg.TextSource or tostring(msg)

    -- bersihkan markup
    local cleanedText = removeMarkup(rawText)
    -- Cek keyword
    for _, key in ipairs(keywords) do
         -- cari pola chance (contoh: "chance 1 in 100M")
         local chanceMatch = cleanedText:match("with a%s+(.-)%s+chance")

        print("Keyword terdeteksi → " .. matchedWord)
        if chanceMatch then
            print("Chance terdeteksi → " .. chanceMatch)
        end
        local datawh = {
            ["content"] = cleanedText,
            ["embeds"] = {
                {
                    ["title"] = "Tittle Embed",
                    ["description"] = "Deskripsi konten di sini",
                    ["color"] = 16711680, -- Warna (Decimal) atau hex

                    ["thumbnail"] = {
                        ["url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                    }, -- koma di sini

                    ["fields"] = {
                        {
                            ["name"] = "Name",
                            ["value"] = player.DisplayName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Caught",
                            ["value"] = key,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Chance",
                            ["value"] = chanceMatch,
                            ["inline"] = true
                        }
                    }, -- koma di sini

                    ["footer"] = {
                        ["text"] = "footer text",
                        ["icon-url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                    }, -- koma di sini

                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            }
        }
        if cleanedText:lower():find(key:lower()) then

            request({
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

local Players = game:GetService("Players")
local msg = "<font color='rgb(255, 215, 105)'>Shark</font>"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
channel:DisplaySystemMessage(msg)
