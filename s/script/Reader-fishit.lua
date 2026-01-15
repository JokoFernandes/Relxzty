local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

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
        if cleanedText:lower():find(key:lower()) then

            request({
                Url = WEBHOOK,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({
                    content = "@here " .. cleanedText
                })
            })

            print("TERKIRIM → " .. cleanedText)
            break
        end
    end
end)
