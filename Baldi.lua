--> This is a pretty funny bypass I found when playing this game: 16068228913 (baldi game)
--> Anyways, really easy to figure out, but I wonder when will they fix this...
--> (NOTE: the script is pretty bad and buggy since I mostly rushed it.)

local players = game:GetService("Players")
local lplr = players.LocalPlayer
local char = lplr.Character or lplr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
lplr.CharacterAdded:Connect(function(newchar)
    char = newchar
    root = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")
end)
local function getPad()
    local obj
    repeat obj = workspace:GetChildren()[45] task.wait() until obj
    local pad
    repeat pad = obj:FindFirstChild("Pad") task.wait() until pad
    pcall(function()
        pad.Massless = true
        pad.CanCollide = false
    end)
    return pad
end
local function getKiller()
    local killer
    repeat killer = workspace:FindFirstChild(lplr.Name) task.wait() until killer
    local torso
    repeat torso = killer:FindFirstChild("Torso") task.wait() until torso
    pcall(function()
        torso.Massless = true
        torso.CanCollide = false
    end)
    return torso
end
local function killAll()
    if not char or not root or not hum then return end
    pcall(function()
        local pad = getPad()
        local killerTorso = getKiller()
        if not pad or not killerTorso then return end
        local oldlplrpos = root.CFrame
        local oldpos = pad.CFrame
        task.wait(0.05)
        firetouchinterest(root, pad, 0)
        task.wait(0.1)
        firetouchinterest(root, pad, 1)
        task.wait(0.1)
        pad.CFrame = oldpos
        task.wait(0.7)
        for _, v in ipairs(players:GetPlayers()) do
            local vchar = v.Character
            if v ~= lplr and vchar then
                local vroot = vchar:FindFirstChild("HumanoidRootPart")
                if vroot then
                    task.spawn(function()
                        pcall(function()
                            for i = 1, 10 do
                                firetouchinterest(vroot, killerTorso, 0)
                                firetouchinterest(vroot, killerTorso, 1)
                            end
                        end)
                    end)
                end
            end
        end
    end)
end
local loopkillOn = false
lplr.Chatted:Connect(function(msg)
    if msg == '?kill' then
        killAll()
    elseif msg == '?loopkill' then
        if loopkillOn then return end
        loopkillOn = true
        task.spawn(function()
            while loopkillOn do
                killAll()
                task.wait(0.3)
            end
        end)
    elseif msg == '?unloopkill' then
        loopkillOn = false
    end
end)
