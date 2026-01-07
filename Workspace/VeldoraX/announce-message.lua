local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local message = "Thank you for using our script, we hope you have fun and enjoy it. use #help to see custom command"
local msg = "<b><font color='rgb(76, 0, 255)'>[LIUDEX Z]</font></b>: <font color='rgb(255, 230,140)'>hello</font> <font color='rgb(90, 250, 255)'>" .. Players.LocalPlayer.DisplayName .. "</font> " .. "<font color='rgb(255,230,140)'>" .. message .. "</font>"
local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local msg2 = "<b><font color='rgb(76, 0, 255)'>[LIUDEX Z]</font></b>: <font color='rgb(255, 0, 0)'>Disclaimer</font> <font color='rgb(0, 255, 25)'>Do not use this for game breaking exploits. Don't forget to join our Discord</font><b><font color='rgb(25,100,255)'> https://discord.gg/DxFgaFe4</font></b>"

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()


plr.Chatted:Connect(function(msg)
    if msg:lower() == "#help" then
        -- chat /show buat show ui deltanya
        channel:DisplaySystemMessage(
            "  /showhui to show all ui in gethui"
        )
        channel:DisplaySystemMessage(
            "  /hidehui to hide all ui in gethui"
        )
        channel:DisplaySystemMessage(
            "  /tp <target> it will tp you to target"
        )
        channel:DisplaySystemMessage(
            "  /bring <target> it will bring your member to  your position (leader only)"
        )
        channel:DisplaySystemMessage(
            "  /highlight <1 to show 0 to hide> to see all member"
        )
        channel:DisplaySystemMessage(
            "  /global <message> to send message cross server or game"
        )
    end
end)
channel:DisplaySystemMessage(
    msg
)
channel:DisplaySystemMessage(
    msg2
)
