local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place, _id = game.PlaceId, game.JobId
local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"

function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
end

local waitTime = tonumber(Value) or 0
local retryAttempts = 3
local Next

while true do
    local Servers = ListServers(Next)

    for i, v in next, Servers.data do
        if v.playing < v.maxPlayers and v.id ~= _id then
            if v.playing >= v.maxPlayers then
                print("Skipped server:", v.id, "as it is now full.")
                continue
            end

            for attempt = 1, retryAttempts do
                if waitTime > 0 then
                    print("Waiting for", waitTime, "seconds before attempting to teleport to the next server...")
                    wait(waitTime)
                end

                local success, errorInfo = pcall(TPS.TeleportToPlaceInstance, TPS, _place, v.id, Player)

                if success then
                    print("Successfully teleported to server:", v.id)
                    return
                else
                    print("Failed to teleport to server:", v.id, "Error:", errorInfo)
                    wait(1)
                end
            end
        end
    end

    Next = Servers.nextPageCursor
    
    print("No available servers to teleport.")
end
