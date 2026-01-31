-- prop
local webhook = getgenv().WebhookDiscord
local messageId = getgenv().messageIdDiscord

--
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local timer = Instance.new("ScreenGui")
timer.Name = "Timer"
timer.Parent = gethui()

local time = Instance.new("TextLabel") -- benerin ejaan
time.Parent = timer -- WAJIB biar kelihatan
time.Size = UDim2.new(0, 50, 0, 25)
time.Position = UDim2.new(0.13, 0, 0, 50) -- turun 50px
time.Text = "Text"
time.BackgroundTransparency = 1
time.TextColor3 = Color3.fromRGB(255,255,255)
time.TextSize = 20

while true do
local t = math.floor(game.Workspace.DistributedGameTime)

local jam = math.floor(t / 3600)
local menit = math.floor((t % 3600) / 60)
local detik = t % 60

time.Text =jam .. "jam ".. menit .. "menit " .. detik .. "detik "

local datawh = {
        ["embeds"] = {
            {
                ["title"] = "Timer ",
                ["description"] = "||@everyone|| <:shut:1432612191064031252>",
                ["color"] = 16711680,
                ["fields"] = {
                    {["name"]="Play Time: ",["value"]="```" .. time.Text .. "```",["inline"]=false},
                    {["name"]="JobId:",["value"]="```".. game.JobId .. "```",["inline"]=false}
                },
                ["footer"] = {
                    ["text"] = "Place: " .. game.PlaceId,
                    ["icon_url"] = "https://tr.rbxcdn.com/180DAY-768363145abfc634e1b026bdb214fbef/150/150/Image/Png/noFilter"
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
}}
}
local HttpService = game:GetService("HttpService")
request({
                Url = webhook .. "/messages/" .. messageId,
                Method = "PATCH",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(datawh)
})
task.wait(0.7)
end 
