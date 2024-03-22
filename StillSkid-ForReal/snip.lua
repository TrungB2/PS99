local osclock = os.clock()
repeat task.wait(1) until game:IsLoaded()


print("booty works V8")
--// loadstring(game:HttpGet('https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/StillSkid-ForReal/snip.lua'))()

--PS99 ITEMS
local ItemsPS99 = {
	["Diamond Plant Seed"] = 17500
}

wait(20)
local Booths_Broadcast = game:GetService("ReplicatedStorage").Network:WaitForChild("Booths_Broadcast")
local Players = game:GetService('Players')
local Player = Players.LocalPlayer
local getPlayers = Players:GetPlayers()
local PlayerInServer = #getPlayers
local http = game:GetService("HttpService")
local vu = game:GetService("VirtualUser")
local Library = require(game.ReplicatedStorage:WaitForChild('Library'))
local vu = game:GetService("VirtualUser")

local character = Player.Character or Player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA('Humanoid')

local function moveToPosition(position)
	local moveFinished = false
	local connection
	connection = humanoid.MoveToFinished:Connect(function(reached)
		moveFinished = reached
		if connection then
			connection:Disconnect()
		end
	end)
	humanoid:MoveTo(position)
	repeat task.wait() until moveFinished
end
	
moveToPosition(Vector3.new(-970, 284, -2278))
moveToPosition(Vector3.new(-935, 284, -2189))
moveToPosition(Vector3.new(-919, 285, -2183))

print("Anti AFKEY")
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

local niggaJump = coroutine.create(function ()
    while 1 do
        wait(10)
        game.Players.LocalPlayer.Character.Humanoid.Jump = true
    end
end)
coroutine.resume(niggaJump)

local function processListingInfo(uid, gems, item, version, shiny, amount, boughtFrom, boughtPet, class, boughtMessage, ping)
    local gemamount = Player.leaderstats["💎 Diamonds"] and Player.leaderstats["💎 Diamonds"].Value or 0
    local versionVal = { [2] = "Rainbow", [1] = "Golden" }
    local versionStr = versionVal[version] or (version == nil and "Normal" or "")
    local snipeMessage = string.format("Found a %s%s%s!", versionStr, shiny and " Shiny " or " ", item)
    local tag = string.find(item, "Seed") and "@everyone" or ""
    local colourcheck = boughtPet and 0x05ff00 or 0xff000f
    local failMessage = boughtPet and "Sniped! No errors occured!" or tostring(boughtMessage)

    local message1 = {
        ['content'] = tag,
        ['embeds'] = {{
            ['title'] = snipeMessage,
            ["color"] = tonumber(colourcheck),
            ["timestamp"] = DateTime.now():ToIsoDate(),
            ['fields'] = {{
                ['name'] = "*LISTING INFO* :",
                ['value'] = string.format("**Price :** %s gems \n**Amount :** %s\n**Seller :** ||%s||\n**Listing ID : ** ||%s||", tostring(gems), tostring(amount or 1), tostring(boughtFrom), tostring(uid)),
            }, {
                ['name'] = "*USER INFO* :",
                ['value'] = string.format("**User :** ||%s||\n**Remaining gems :** %s", Player.Name, tostring(gemamount)),
            }, {
                ['name'] = "*SNIPER INFO* :",
                ['value'] = string.format("**Status :** %s\n**Ping :** %s ms", failMessage, tostring(ping)),
            }},
            ['footer'] = {
                ['text'] = "V 3.2 by TrungB"
            },
            ['thumbnail'] = {
                ['url'] = "https://cdn.discordapp.com/attachments/1057080336313495614/1190229689126621235/target_PNG42.png?ex=65a10ac7&is=658e95c7&hm=51fb914c7330c90326660077f6487ce9238a26ad483ad38bbccc41cbc216ad59&"
            },
        }},
    }

    local jsonMessage = http:JSONEncode(message1)
    local success, webMessage = pcall(function()
        http:PostAsync(webhook, jsonMessage)
    end)
    if not success then
        local response = request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonMessage
        })
    end
end

local function tryPurchase(uid, gems, item, version, shiny, amount, username, class, playerid, buytimestamp, listTimestamp)
    local args = {
        [1] = playerid, --sellers roblox id
        [2] = {
            [tostring(uid)] = amount --id of the item and the amount
        }
    }
    local ping = Player:GetNetworkPing()
    if buytimestamp > listTimestamp then
        task.wait(3.4 - ping)
    end
    local boughtPet, boughtMessage = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Booths_RequestPurchase"):InvokeServer(unpack(args))
    processListingInfo(uid, gems, item, version, shiny, amount, username, boughtPet, class, boughtMessage, math.floor(ping*1000))
end

Booths_Broadcast.OnClientEvent:Connect(function(username, message)
    if type(message) == "table" then
        local highestTimestamp = -math.huge
        local key, listing
        for v, value in pairs(message["Listings"] or {}) do
            if type(value) == "table" and value["ItemData"] and value["ItemData"]["data"] then
                local timestamp = value["Timestamp"]
                if timestamp > highestTimestamp then
                    highestTimestamp = timestamp
                    key = v
                    listing = value
                end
            end
        end
        if listing then
            local buytimestamp, listTimestamp = listing["ReadyTimestamp"], listing["Timestamp"]
            local data, playerid = listing["ItemData"]["data"], message['PlayerID']
            local gems, uid = tonumber(listing["DiamondCost"]), key
            local item, version, shiny = data["id"], data["pt"], data["sh"]
            local amount = tonumber(data["_am"]) or 1
            local class, unitGems = tostring(listing["ItemData"]["class"]), gems / amount

            print(string.format("%s listed %s %s - %s gems, %s gems/unit", tostring(username), tostring(amount), tostring(item), tostring(gems), tostring(unitGems)))

            for i, v in pairs(ItemsPS99) do
				if item == i and gems <= v then
                    coroutine.wrap(tryPurchase)(uid, gems, item, version, shiny, amount, username, class, playerid, buytimestamp, listTimestamp)
					return
				end
			end

        end
    end
end)

local function serverHop(id)
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local sfUrl = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s&excludeFullGames=true"
    local req = request({
        Url = string.format(sfUrl, id, "Desc", 100)
    })
    local body = HttpService:JSONDecode(req.Body)
    task.wait(0.2)
    local servers = {}
    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and v.playing >= 35 and v.id ~= game.JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end
    local randomCount = #servers
    if not randomCount then
        randomCount = 2
    end
    TeleportService:TeleportToPlaceInstance(id, servers[math.random(1, randomCount)], Players.LocalPlayer)
end


task.spawn(function()
    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        serverHop(place)
        game.Players.LocalPlayer:Kick("Found An Error, Reconnecting...")
        wait(0.1)
    end)
end)

if PlayerInServer < 25 then
    while task.wait(1) do
        serverHop(place)
    end
end


Players.PlayerRemoving:Connect(function(player)
    getPlayers = Players:GetPlayers()
    PlayerInServer = #getPlayers
    if PlayerInServer < 25 then
        while task.wait(1) do
            serverHop(place)
        end
    end
end)

local hopDelay = math.random(1500, 1800)

task.spawn(function ()
    while task.wait(1) do
        if math.floor(os.clock() - osclock) >= hopDelay then
            while task.wait(1) do
                serverHop(place)
            end
        end
    end
end)
