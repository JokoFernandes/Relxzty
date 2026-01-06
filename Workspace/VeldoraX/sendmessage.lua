local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local message = "hello"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

channel:DisplaySystemMessage(
    "<b><font color='rgb(75,10,150)'>" .. Players.LocalPlayer.DisplayName .. "</font></b>" .. ": <font color='rgb(255,255,255)'>" .. message .. "</font>"
)
