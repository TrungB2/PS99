repeat task.wait(1) until game.PlaceId ~= nil
repeat task.wait(1) until game:GetService("Players") and game:GetService("Players").LocalPlayer
repeat task.wait(1) until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("__INTRO")
--//*--------- FPS Boost ---------*//--
if game:IsLoaded() and getgenv().config.Balloon.balloonFpsBoost then
    local RunService = game:GetService("RunService")
    pcall(function()
        local THINGS = game:GetService("Workspace")["__THINGS"]
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

        for _, v in pairs(game:GetService("Workspace").Map2:GetChildren()) do 
            for _, map in pairs(v:GetChildren()) do
                for _, mapChild in pairs(map:GetChildren()) do
                    if map:IsA("Model") and map.Name ~= "INTERACT" then
                        map:Destroy()
                    end
                    if map:IsA("Folder") and map.Name == "PARTS_LOD" then
                        mapChild:Destroy()
                    end
                    if map:IsA('Model') and map.Name == "INTERACT" then
                        if mapChild:IsA('Folder') and mapChild.Name ~= "BREAK_ZONES" and mapChild.Name ~= "BREAKABLE_SPAWNS" then
                            mapChild:Destroy()
                        end
                    end
                end
            end
        end
        for _, v in pairs(game:GetService("Workspace"):FindFirstChild("__THINGS"):GetChildren()) do
            if table.find({"ShinyRelics", "Ornaments", "Instances", "Ski Chairs", "Flags", "Sounds", "Insctances", "Eggs", "CustomEggs"}, v.Name) then
                v:Destroy()
            end
        end
        
    end)
	for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
	    if v:IsA('Model') and v.Name ~= "Border" and v.Name ~= game:GetService("Players").LocalPlayer.Name then
		v:Destroy()
	    end
	end
	
	for i, v in pairs(game:GetService("StarterGui"):GetChildren()) do
	    if v:IsA("ScreenGui") then
		v.Enabled = false
	    end
	end
	
	for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
	    if v:IsA("ScreenGui") then
		v.Enabled = false
	    end
	end
	
	
	game:GetService("Lighting"):ClearAllChildren()
	for _, v in pairs(game:GetService("Chat").ClientChatModules:GetChildren()) do
	    v:Destroy()
	end
	for _, v in pairs(game:GetService("Players"):GetChildren()) do
	    if v.Name ~= game.Players.LocalPlayer.Name then
		v:Destroy()
	    end
	end
	for _, v in pairs(game:GetService("ReplicatedStorage")["__INSTANCE_STORAGE"]:GetChildren()) do
	    v:Destroy()
	end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/ReduceLag/lowmap.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/ReduceLag/lowCPU.lua"))()
    
end

local HttpService = game:GetService("HttpService")

local LargeRAP = 10700; local SmallRAP = 2550
local player = game.Players.LocalPlayer
local lastPosition = player.Character.HumanoidRootPart.Position
local notMovingTimer = 0
local hopWhenTheGameIsStuck = 60
local RepStor = game:GetService("ReplicatedStorage")
local saveMod = require(RepStor.Library.Client.Save)
hookfunction(require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier, function() return 250 end)

local iHHLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Lib/TrungBLib.lua')))()
local Window = iHHLib:MakeWindow({Name = "[iHH] 🐾 Balloon World 2 🐾", HidePremium = false, IntroEnabled = false, SaveConfig = true, ConfigFolder = "iHHBalloon"})

------------- Notification

print('[iHH] Script Loaded!!')

local function checkPlayerMovement()
    while true do
        wait(1)
        local currentPosition = player.Character.HumanoidRootPart.Position
        if currentPosition == lastPosition then
            notMovingTimer = notMovingTimer + 1
        else
            lastPosition = currentPosition
            notMovingTimer = 0
        end

        if notMovingTimer >= hopWhenTheGameIsStuck then
            print("Player has not moved for "..hopWhenTheGameIsStuck.." seconds, initiating server hop")
              
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Misc/lowserverhop.lua"))()
            break
        end
    end
end

spawn(checkPlayerMovement)
------------- Info tab
local Info = Window:MakeTab(
    {
        Name = "INFOMATION",
        Icon = "rbxassetid://7733911828",
        PremiumOnly = false
    })

Info:AddParagraph("Thông tin về script", "Full cụt tay")
Info:AddParagraph("Hướng dẫn đơn giản", "*Khuyên dùng acc Rebirth 3 full World1\n* Mọi thứ đều tự động :)")
Info:AddSection(
    {
        Name = "_ Script made by TrungB\n_ Tks for your support!!"
    })
------------- Dig tab
local Balloon = Window:MakeTab(
    {
        Name = "Balloon",
        Icon = "rbxassetid://7743866529",
        PremiumOnly = false
    })
Balloon:AddSection({
        Name = "Auto Setup Balloon Farm"
    })
local runBalloon = Balloon:AddToggle(
    {
        Name = "Auto Balloon",
        Default = config.Balloon.Enabled,
        Save = true,
        Flag = "AutoBalloon",
        Callback = function(v)
            getgenv().config.Balloon.Enabled = v
            spawn(autoPopBalloon)
        end
    })
local runTap = Balloon:AddToggle(
    {
        Name = "Auto Tap",
        Default = config.Balloon.autoTap,
        Save = true,
        Flag = "AutoTap",
        Callback = function(v)
            getgenv().config.Balloon.autoTap = v
            spawn(autoTapper)
        end
    })
local runCollect = Balloon:AddToggle(
    {
        Name = "Auto Collect Bag",
        Default = config.Balloon.autoCollectBag,
        Save = true,
        Flag = "AutoCollectBag",
        Callback = function(v)
            getgenv().config.Balloon.autoCollectBag = v
            spawn(autoCollectBag)
        end
    })
local openGift = Balloon:AddToggle(
    {
        Name = "Auto Open Gift",
        Default = config.Balloon.autoOpenGift,
        Save = true,
        Flag = "AutoOpenGift",
        Callback = function(v)
            getgenv().config.Balloon.autoOpenGift = v
            spawn(autoOpenAllGift)
        end
    })

------------- Mail tab
local Mail = Window:MakeTab(
    {
        Name = "Mail",
        Icon = "rbxassetid://7733992732",
        PremiumOnly = false
    })
Mail:AddSection(
    {
        Name = "Auto Claim Mail"
    })

local claimMail = Mail:AddToggle(
    {
        Name = "Auto Claim Mail",
        Default = config.AutoMail.autoClaimMail,
        Save = true,
        Flag = "AutoClaimMail",
        Callback = function(v)
            getgenv().config.AutoMail.autoClaimMail = v
            spawn(autoClaimM)
        end
    })
Mail:AddSection(
    {
        Name = "Auto Send Mail"
    })
local sendMail= Mail:AddToggle(
    {
        Name = "Auto Send Mail Every "..config.AutoMail.delayAutoSendMail.." Seconds",
        Default = config.AutoMail.Enabled,
        Save = true,
        Flag = "AutoSendMail",
        Callback = function(v)
            getgenv().config.AutoMail.Enabled = v
            spawn(autoSendMail)
        end
    })
local sendDiamonds = Mail:AddToggle(
    {
        Name = "Send Diamonds",
        Default = false,
        Save = true,
        Flag = "TickDiamonds",
        Callback = function(v)
            config.sendGems = v
        end
    })
local sendGiftBag = Mail:AddToggle(
    {
        Name = "Gift Bag (1k), Large Gift Bag (700), Mini Chest (30)",
        Default = false,
        Save = true,
        Flag = "TickGifts",
        Callback = function(v)
            config.sendGift = v
        end
    })
------------- Mics
local Mics = Window:MakeTab(
    {
        Name = "Mics",
        Icon = "rbxassetid://7734053495",
        PremiumOnly = false
    })
Mics:AddSection({
        Name = "Back to main script"
    })
Mics:AddButton(
    {
        Name = "Turn back to main script (Not Working)",
        Callback = function()

        end
    })

Mics:AddSection(
    {
        Name = "Rejoin to this server"
    })
Mics:AddButton(
    {
        Name = "Rejoin Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
    })
Mics:AddButton(
    {
        Name = "ServerHop",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Misc/serverhop.lua"))()
        end
    })


-- Anti AFk
function antiAFK()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    while task.wait() do
        VirtualInputManager:SendKeyEvent(true, "Space", false, game)
        task.wait(.2)
        VirtualInputManager:SendKeyEvent(false, "Space", false, game)
        task.wait(300)
    end
end

local Network = game.ReplicatedStorage.Network
local Items = {"Gift Bag"}

function autoOpen(name)
    Network.GiftBag_Open:InvokeServer(name)
end
local GetSave = function()
    return require(game.ReplicatedStorage.Library.Client.Save).Get()
end

for i, v in pairs(GetSave().Inventory.Currency) do
    if v.id == "Diamonds" then
        if v._am <= 10000 then
            while wait() do
                for i,gift in pairs(Items) do
                    autoOpen(gift)
                end
                break
            end
        end
    end
end

-- Auto Send Mail
function autoSendMail()
    local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local result = saveModule.Get()

    local ms = result.Inventory.Misc 
    while wait(config.AutoMail.delayAutoSendMail) and config.AutoMail.Enabled do
        print('Checking Mail!')
        for i, v in pairs(ms) do
            if v.id == "Gift Bag" and config.sendGift then
                if v._am >= 200 then
                    local giftbag = {
                        [1] = config.AutoMail.userToMail,
                        [2] = "",
                        [3] = "Misc",
                        [4] = i,
                        [5] = v._am
                    }
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(giftbag))
                    iHHLib:MakeNotification({
                        Name = "[iHH] Mail Send!",
                        Content = "Sended "..v._am.." Gift Bag",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                else
                end
            end
            if v.id == "Large Gift Bag" and config.sendGift then
                if v._am >= 100 then
                    local largegift = {
                        [1] = config.AutoMail.userToMail,
                        [2] = "",
                        [3] = "Misc",
                        [4] = i,
                        [5] = v._am
                    }
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(largegift))
                    iHHLib:MakeNotification({
                        Name = "[iHH] Mail Send!",
                        Content = "Sended "..v._am.." Large Gift Bag",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                else
                end
            end
            if v.id == "Mini Chest" and config.sendGift then
                if v._am >= 30 then
                    local largegift = {
                        [1] = config.AutoMail.userToMail,
                        [2] = "",
                        [3] = "Misc",
                        [4] = i,
                        [5] = v._am
                    }
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(largegift))
                    iHHLib:MakeNotification({
                        Name = "[iHH] Mail Send!",
                        Content = "Sended "..v._am.." Mini Chest",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                else
                end
            end
        end
        task.wait(0.2)
        local GetSave = function()
            return require(game.ReplicatedStorage.Library.Client.Save).Get()
        end
        for i, v in pairs(GetSave().Inventory.Currency) do
            if v.id == "Diamonds" and config.sendGems then
                if v._am >= config.AutoMail.gemAmount then
                    local diamonds = {
                        [1] = config.AutoMail.userToMail,
                        [2] = "",
                        [3] = "Currency",
                        [4] = i,
                        [5] = v._am - 10000
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(diamonds)) -- 30k = 10k mail + 20k keep
                    iHHLib:MakeNotification({
                        Name = "[iHH] Mail Send!",
                        Content = "Sended "..v._am.." gems",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                end
            end
            task.wait(0.2)
        end
    end
end
-- Auto Claim Mail
function autoClaimM()
    while wait(10) and config.AutoMail.autoClaimMail do
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):FindFirstChild("Mailbox: Claim All"):InvokeServer()
    end
end


function getServer()
	local servers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100')).data
	local server = servers[Random.new():NextInteger(1, 10)]
	if server then return server else return getServer() end
end
-- Auto Balloon
function autoPopBalloon()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local hrp = player.Character.HumanoidRootPart
    
    while wait() and config.Balloon.Enabled do
        local balloonIds = {}
        local getActiveBalloons = ReplicatedStorage.Network.BalloonGifts_GetActiveBalloons:InvokeServer()
        
        local allPopped = true
        for i, v in pairs(getActiveBalloons) do
            if not v.Popped then
                allPopped = false
                balloonIds[i] = v
            end
        end

        if allPopped then
            if config.Balloon.hopWhenNoBalloon then
                task.wait(config.Balloon.delayHopWhenNoBalloon)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Misc/serverhop.lua"))()
            end
            task.wait(1)
            continue
        end
        if not config.Balloon.Enabled then
            break
        end
        
        hrp.Anchored = true
        for balloonId, balloonData in pairs(balloonIds) do
            local balloonPosition = balloonData.Position
            
            game:GetService("ReplicatedStorage").Network.Slingshot_Toggle:InvokeServer()
            task.wait()
            hrp.CFrame = CFrame.new(balloonPosition.X, balloonPosition.Y + 30, balloonPosition.Z)

            task.wait()
            local args = {
                [1] = Vector3.new(balloonPosition.X, balloonPosition.Y + 25, balloonPosition.Z),
                [2] = 0.5794160315249014,
                [3] = -0.8331117721691044,
                [4] = 200
            }
            ReplicatedStorage.Network.Slingshot_FireProjectile:InvokeServer(unpack(args))
            task.wait(0.1)
            local args = {
                [1] = balloonId
            }
            ReplicatedStorage.Network.BalloonGifts_BalloonHit:FireServer(unpack(args))
            task.wait(0.2)
            ReplicatedStorage.Network.Slingshot_Unequip:InvokeServer()
            task.wait(0.5)
            hrp.CFrame = CFrame.new(balloonData.LandPosition)
            hrp.Anchored = false
            task.wait(2)
            
            hrp.Anchored = true
        end
        if config.Balloon.hopWhenNoBalloon then
           	task.wait(config.Balloon.delayHopWhenNoBalloon)
		repeat game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getServer().id, player) task.wait(3) until not game.PlaceId
        end
    end
end
-- Auto Tap
function autoTapper()
    local Library = require(game:GetService("ReplicatedStorage").Library)
    local Network = Library.Network
    local GetNearestBreakable = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.GUIs["Auto Tapper"]).GetNearestBreakable

    while task.wait() and getgenv().config.Balloon.autoTap do
        pcall(function()
            local Breakable = GetNearestBreakable()
            if Breakable then
                Network.Fire("Breakables_PlayerDealDamage", Breakable.Name)
            end
        end)
    end
end
-- Auto Bundle Gift Bag
function autoOpenAllGift()
    local Network = game.ReplicatedStorage.Network
    local Items = {"Gift Bag", "Large Gift Bag", "Mini Chest"}

    function autoOpen(name)
        Network.GiftBag_Open:InvokeServer(name)
    end

    while task.wait(0.3) and getgenv().config.Balloon.autoOpenGift do
        for i,v in pairs(Items) do
            autoOpen(v)
        end
    end
end
-- Auto  Collect
function autoCollectBag()
    while wait(0.1) and getgenv().config.Balloon.autoCollectBag do
        for _, lootbag in pairs(game:GetService("Workspace").__THINGS:FindFirstChild("Lootbags"):GetChildren()) do
            if lootbag then
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack( { [1] = { [1] = lootbag.Name, }, } ))
                lootbag:Destroy()
                task.wait()
            end
        end
        
        game:GetService("Workspace").__THINGS:FindFirstChild("Lootbags").ChildAdded:Connect(function(lootbag)
            task.wait()
            if lootbag then
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack( { [1] = { [1] = lootbag.Name, }, } ))
                lootbag:Destroy()
            end
        end)
        
        game:GetService("Workspace").__THINGS:FindFirstChild("Orbs").ChildAdded:Connect(function(orb)
            task.wait()
            if orb then
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):FindFirstChild("Orbs: Collect"):FireServer(unpack( { [1] = { [1] = tonumber(orb.Name), }, } ))
                orb:Destroy()
            end
        end)
    end
end
function atoggle()
    --Auto Balloon
    runBalloon:Set(config.Balloon.Enabled)
    runTap:Set(config.Balloon.autoTap)
    runCollect:Set(config.Balloon.autoCollectBag)
    openGift:Set(config.Balloon.autoOpenGift)
    --Auto Mail
    sendMail:Set(config.AutoMail.Enabled)
    sendDiamonds:Set(true)
    sendGiftBag:Set(true)
    claimMail:Set(config.AutoMail.autoClaimMail)
end
spawn(atoggle)
spawn(antiAFK)
