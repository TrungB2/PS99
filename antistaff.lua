local WAITING = false

local function serverhop(player)
    local timeToWait = Random.new():NextInteger(300, 600)
    print("[iHH] BIG Games staff (" .. player.Name ..  ") is in server! Waiting for " .. tostring(timeToWait) .. " seconds before server hopping...")
    task.wait(timeToWait)

    local success, _ = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/main/serverhop.lua"))()
    end)

    if not success then
        game.Players.LocalPlayer:Kick("[iHH] A BIG Games staff member joined and script was unable to server hop")
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    local success, _ = pcall(function()
        if player:IsInGroup(5060810) then
            WAITING = true
            serverhop(player)
        end
    end)
    if not success then
        print("[iHH] Error while checking player: " .. player.Name)
    end
end

print("[iHH] No staff member detected")

game.Players.PlayerAdded:Connect(function(player)
    if player:IsInGroup(5060810) and not WAITING then

        getgenv().STAFF_DETECTED = true

        print("[iHH] Staff member joined, stopping all scripts")
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        local _, zoneData = require(game:GetService("ReplicatedStorage").Library.Util.ZonesUtil).GetZoneFromNumber(Random.new():NextInteger(40, 90))
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map[tostring(zoneData["_script"])].PERSISTENT.Teleport.CFrame

        serverhop(player)
    end
end)
