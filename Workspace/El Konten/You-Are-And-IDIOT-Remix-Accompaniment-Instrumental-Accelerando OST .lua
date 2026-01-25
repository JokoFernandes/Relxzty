local function addsound(assetPath, duration, bol)
    local s = Instance.new("Sound")
    s.SoundId = getcustomasset(assetPath)
    s.Volume = 1
    s.Looped = bol
    s.Parent = workspace
    s:Play()

    -- auto destroy kalau selesai (non-loop)
    s.Ended:Connect(function()
        s:Destroy()
    end)

    -- destroy manual setelah durasi (jalan di thread terpisah)
    task.spawn(function()
        task.wait(duration)
        if s.Parent then
            s:Destroy()
        end
    end)

    return s -- <--- ini di level fungsi, bukan di dalam spawn
end
local sduration = (60 * 4) + 38
-- path, duration
local intro = addsound("L-sound-package/intro.mp3", 20, false)
task.wait(8)
loadstring(game:HttpGet("https://raw.githubusercontent.com/JokoFernandes/Relxzty/refs/heads/main/Workspace/El%20Konten/fake-bot.lua"))()
local backsound = addsound("L-sound-package/backsound.mp3", sduration, false)
local backsound2 = addsound("L-sound-package/backsound2.mp3", sduration, true)
task.wait(2)
local hacksound2 = addsound("L-sound-package/hacksound2.mp3", sduration, true)
task.wait(5)
local hacksound1 = addsound("L-sound-package/hacksound1.mp3", sduration, true)
task.wait(3)
local repeatS = addsound("L-sound-package/repeat.mp3", sduration + 0.99, true)
