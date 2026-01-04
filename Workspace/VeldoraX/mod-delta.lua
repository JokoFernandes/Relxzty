local buttonColor = Color3.fromRGB(50,10,100)
local bgColor = Color3.fromRGB(25,5,50)
local borderColor = Color3.fromRGB(100,15,150)
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
                code.PlaceholderText = "Welcome Place Your Script Here Dont Forget To Join Our Community at https://discord.gg/SshP7wVS - Mod By CecepLoremIpsum"
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

-- Jika ada child baru ditambahkan
main.ChildAdded:Connect(function()
    mod()
end)

-- Jika ada descendant baru ditambahkan
main.DescendantAdded:Connect(function()
    mod()
end)

-- Jika ada perubahan properti di main
main.DescendantRemoving:Connect(function()
    mod()
end)

-- fungsi untuk set warna tombol
local function fixButton(btn)
    if btn:IsA("ImageButton") then
        btn.BackgroundColor3 = buttonColor

        -- pantau perubahan warna tombol
        btn.Changed:Connect(function(property)
            if property == "BackgroundColor3" then
                btn.BackgroundColor3 = buttonColor
            end
        end)
    end
end

-- cek semua Sidebar yang sudah ada
for _, v in ipairs(main:GetChildren()) do
    local sidebar = v:FindFirstChild("Sidebar")
    if sidebar then
        -- set semua ImageButton di dalam Sidebar
        for _, child in ipairs(sidebar:GetDescendants()) do
            fixButton(child)
        end

        -- kalau ada ImageButton baru masuk ke Sidebar
        sidebar.DescendantAdded:Connect(function(obj)
            fixButton(obj)
        end)
    end
end
mod()


