local Player = game.Players.LocalPlayer
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local GroupService = game:GetService("GroupService")

local Api = "https://games.roblox.com/v1/games/"
local _place, _id = game.PlaceId, game.JobId
local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"

local groupIds = {5060810}
local Moderators = {"BuildIntoGames"}

local retryAttempts = 3
local Next
local lastServerId
local continuousHopping = false

local function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
end

local function hopServer()
    print("[iHH] Attempting to hop server...")
    local Servers = ListServers(Next)

    for _, v in ipairs(Servers.data) do
        if v.playing < v.maxPlayers and v.id ~= _id and v.id ~= lastServerId then
            if v.playing >= v.maxPlayers then
                print("[iHH] Server full, skipping...")
            else
                for attempt = 1, retryAttempts do
                    local success, errorInfo = pcall(TPS.TeleportToPlaceInstance, TPS, _place, v.id, Player)

                    if success then
                        lastServerId = v.id
                        print("Successfully hopped to a new server!")
                        return
                    else
                        wait(1)
                    end
                end
            end
        end
    end

    Next = Servers.nextPageCursor
end

local function checkPlayer(player)
    local isInGroup = false

    for _, groupId in ipairs(groupIds) do
        local success, inGroup = pcall(function()
            return GroupService:IsInGroup(player.UserId, groupId)
        end)

        if success and inGroup then
            isInGroup = true
            break
        end
    end

    if isInGroup then
        print("[iHH] "..player.Name .. " is in the group. Starting Server Hop")
        continuousHopping = true
        while wait(0.5) and Player:IsDescendantOf(game) and continuousHopping do
            hopServer()
        end
        return
    end

    for _, username in ipairs(Moderators) do
        if player.Name == username then
            print("[iHH] "..player.Name .. " is a moderator. Starting Server Hop")
            continuousHopping = true
            while wait(0.5) and Player:IsDescendantOf(game) and continuousHopping do
                hopServer()
            end
            return
        end
    end

    print("[iHH] "..player.Name .. " is not a moderator or in the group.")
end

for _, player in ipairs(game.Players:GetPlayers()) do
    checkPlayer(player)
end

game.Players.PlayerAdded:Connect(function(player)
    checkPlayer(player)
end)
