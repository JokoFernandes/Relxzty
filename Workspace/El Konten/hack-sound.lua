local sound = Instance.new("Sound")
sound.SoundId = getcustomasset("brainrotRap.mp3") -- ganti dengan ID musik kamu
sound.Volume = 1
sound.Looped = true
sound.Parent = workspace
sound:Play()
task.wait((60*2) + 48)
sound:Destroy()
