local buttonColor = getgenv().ButtonColor or Color3.fromRGB(50,10,100)
local bgColor = getgenv().bgColor or Color3.fromRGB(25,5,50)
local placeHolder = getgenv().placeHolder or "Welcome Place Your Script Here Dont Forget To Join Our Community at https://discord.gg/SshP7wVS - Mod By CecepLoremIpsum"
local borderColor = getgenv().borderColor or Color3.fromRGB(100,15,150)
local function mod()
    local main = gethui()

    for i, v in pairs(main:GetChildren()) do
        -- side bar
        local sidebar = v:FindFirstChild("Sidebar")
        if sidebar then
            sidebar.BackgroundColor3 = bgColor
            for _, icon in ipairs(sidebar:GetChildren()) do
                if icon:IsA("ImageButton") then
                    icon.BackgroundColor3 = buttonColor
                end
            end
        end

        -- script
        local executor = v:FindFirstChild("Executor")
        if executor and executor:FindFirstChild("Executor") then
            executor.Executor.Image = getcustomasset("background.png")
            local var = executor.Executor.Overlay.Code
            local var1 = executor.Executor.Overlay.Buttons
            local var2 = executor.Sidemenu
            var2.Network.BackgroundColor3 = bgColor
            var2.Script.BackgroundColor3 = bgColor

            for _, code in ipairs(var:GetChildren()) do
                code.PlaceholderText = placeHolder
            end
            for _, exe in ipairs(var1:GetChildren()) do
                if exe:IsA("ImageButton") then
                    exe.BackgroundColor3 = bgColor
                    exe.BackgroundTransparency = 0
                end
            end
        end

        -- home
        local home = v:FindFirstChild("Home")
        if home then
            local var3 = home.Holder
            local var4 = home.Searchbar
            var4.Button.BackgroundColor3 = buttonColor
            var4.BackgroundColor3 = bgColor
            
            for _, sc in ipairs(var3:GetChildren()) do
                if sc:IsA("ImageLabel") then
                    sc.BackgroundColor3 = bgColor
                    if sc:FindFirstChild("Button") then
                        sc.Button.BackgroundColor3 = buttonColor
                    end
                    if sc:FindFirstChild("Button1") then
                        sc.Button1.BackgroundColor3 = buttonColor
                    end
                end
            end
        end
    end
end
-- di bantu mas gpt biar g berat :) 
-- Hubungkan fungsi ke event perubahan
local main = gethui()

-- loop semua ScreenGui
for _, gui in ipairs(main:GetChildren()) do
    if gui:IsA("ScreenGui") then
        -- Sidebar di dalam ScreenGui
        local sidebar = gui:FindFirstChild("Sidebar")
        if sidebar then
            sidebar.DescendantAdded:Connect(function() mod() end)
            sidebar.DescendantRemoving:Connect(function() mod() end)
            sidebar.Changed:Connect(function(prop)
                if prop == "BackgroundColor3" then
                    mod()
                end
            end)
        end

        -- Executor di dalam ScreenGui
        local executor = gui:FindFirstChild("Executor")
        if executor then
            executor.DescendantAdded:Connect(function() mod() end)
            executor.DescendantRemoving:Connect(function() mod() end)
            executor.Changed:Connect(function(prop)
                if prop == "BackgroundColor3" then
                    mod()
                end
            end)
        end

        -- Home di dalam ScreenGui
        local home = gui:FindFirstChild("Home")
        if home then
            home.DescendantAdded:Connect(function() mod() end)
            home.DescendantRemoving:Connect(function() mod() end)
            home.Changed:Connect(function(prop)
                if prop == "BackgroundColor3" then
                    mod()
                end
            end)
        end
    end
end
mod()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/VeldoraX/hidehui"))()

