local mastery = require(game:GetService("ReplicatedStorange").Library.Client.MasteryCmds)

local player = game.Players.LocalPlayer
local iHHLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Lib/TrungBLib.lua')))()
local Window = iHHLib:MakeWindow({Name = "[iHH] 🐾 Fish 🐾", HidePremium = false, IntroEnabled = false, Saveconfig = true, configFolder = "iHHCheat"})
local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library", 2000))

game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Server Closing"].Enabled = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/Misc/loadgame.lua"))()

------------- Info tab

------------- Fast tele setup to fishing
local FastFish = Window:MakeTab(
    {
        Name = "Fast Fishing",
        Icon = "rbxassetid://7733916988",
        PremiumOnly = false
    })
FastFish:AddParagraph("Thông báo nhỏ","Chill chill !!! ☺☺☺")
FastFish:AddSection({Name = "Support Fishing (Map 92, 27)"})
FastFish:AddToggle({
        Name = "Auto tele, Fishing, Deep pool!",
        Default = config.Fishing.Enabled,
        Callback = function(v)
            getgenv().config.Fishing.Enable = v
            spawn(fastTeleFishArea)
        end
    })
local present = FastFishing:AddToggle(
    {
        Name = "Auto Hidden Present",
        Default = config.Fishing.Presents,
        Save = true,
        Flag = "HiddenPresents",
        Callback = function(v)
            getgenv().config.Fishing.Presents = v
            spawn(autoHiddenPresent)
        end
    })
------------- Mail tab
local Mail = Window:MakeTab({Name = "Mail",Icon = "rbxassetid://7733992732",PremiumOnly = false})
Mail:AddSection({Name = "Auto Claim Mail"})
Mail:AddToggle(
    {
        Name = "Auto Claim Mail",
        Default = config.Fishing.autoClaimMail,
        Callback = function(v)
            getgenv().config.Fishing.autoClaimMail = v
            spawn(autoClaimMail)
        end
    })

Mail:AddSection({Name = "Auto Send Mail"})
local sendMail = Mail:AddToggle(
    {
        Name = "Auto Send Mail",
        Default = config.AutoSendMail.Enable,
        Save = true,
        Flag = "Auto Send Mail",
        Callback = function()
            getgenv().config.AutoSendMail.Enable = v
            spawn(autoSendMail)
        end
    })
Mail:AddSection({Name = "Select items to send"})
local magicShards = Mail:AddToggle(
    {
        Name = "Magic Shards",
        Default = config.Fishing.sendShards,
        Save = true,
        Flag = "SendShards",
        Callback = function(v)
            getgenv().config.Fishing.sendShards = v
        end
    })
local hugePoseidon = Mail:AddToggle(
    {
        Name = "Send Huge",
        Default = config.Fishing.sendHuge,
        Save = true,
        Flag = "SendHuge",
        Callback = function(v)
            getgenv().config.Fishing.sendHuge = v
        end
    })
local someShit = Mail:AddToggle(
    {
        Name = "Send Shit",
        Default = config.Fishing.sendShit,
        Save = true,
        Flag = "SendShit",
        Callback = function(v)
            getgenv().config.Fishing.sendShit = v
        end
    })
------------- Mics
local Mics = Window:MakeTab({Name = "Mics",Icon = "rbxassetid://7734053495",PremiumOnly = false})
Mics:AddSection({Name = "Setup your game with Low CPU and auto antiAFK"})
Mics:AddButton(
    {
        Name = "ReduceCPU",
        Callback = function()
			spawn(lowCPU)
        end
    })
Mics:AddButton(
    {
        Name = "Rejoin Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
    })
iHHLib:Init()

-- Low CPU
function lowCPU()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/ReduceLag/lowCPU.lua"))()
end
function ultrafpsboost()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8d2c3244d2b5cf8794e35145358783f2.lua"))()
end
-- Fast tele fishing
function fastTeleFishArea()
    if getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "AdvancedFishing" then
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__THINGS"].Instances.AdvancedFishing.Teleports.Enter.CFrame
    elseif getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "NormalFishing" then
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = game:GetService("Workspace").__THINGS.Instances.Fishing.Teleports.Enter.CFrame
    end
	wait(3)
	present:Set(true)
	fish:Set(true)
    wait(1)
    if getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "AdvancedFishing" then
        spawn(moveToFishingDerec)
        spawn(ultrafpsboost)
    elseif getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "NormalFishing" then
        spawn(moveToFishingDerec)
        spawn(lowCPU)
    end
end

-- Auto Present
function autoHiddenPresent()
	while task.wait() and getgenv().config.Fishing.Presents do
		local save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = save.Get()
		local present = result.HiddenPresents
		for i, v in pairs(present) do
			local args = {
				[1] = v.ID
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Hidden Presents: Found"):InvokeServer(unpack(args))
			wait(1.5)
		end
	end
end
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
-- Auto Claim Mail
function autoClaimMail()
	while task.wait(10) and config.AutoMail.autoClaimMail do
		game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
	end
end
-- Auto Fishing
function moveToFishingDerec()
    if getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "AdvancedFishing" then
        local LocalPlayer = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        LocalPlayer.Anchored = true
        LocalPlayer.CFrame = LocalPlayer.CFrame + Vector3.new(Random.new():NextInteger(-10, 10), -30, Random.new():NextInteger(-10, 10))

        local platform = Instance.new("Part")
        platform.Parent = game:GetService("Workspace")
        platform.Anchored = true
        platform.CFrame = LocalPlayer.CFrame + Vector3.new(0, -5, 0)
        platform.Size = Vector3.new(5, 1, 5)
        platform.Transparency = 1

        LocalPlayer.Anchored = false
        spawn(autoFishAdvanced)
    elseif getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "NormalFishing" then
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(1124.83521 + x, 75.4893112, -3454.31177 + z))
        wait(3)
        spawn(autoFishNormal)
    end
end

function autoFishAdvanced()
    while task.wait() and getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "AdvancedFishing" do
        local x = math.random(1, 50)
        local z = math.random(1, 50)

        local argsCast = {
            [1] = "AdvancedFishing",
            [2] = "RequestCast",
            [3] = Vector3.new(1465.877685546875 + x, 61.62495040893555, -4455.58447265625 + z)
        }

        game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsCast))
        task.wait(2.5)

        local argsReel = {
            [1] = "AdvancedFishing",
            [2] = "RequestReel"
        }
        game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsReel))

        repeat
            task.wait()

            local hasFishingLine = false
            for _, descendant in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if descendant.Name == "FishingLine" then
                    hasFishingLine = true
                    break
                end
            end
            
            game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsReel))
            if not hasFishingLine then
                break
            end

            local argsClicked = {
                [1] = "AdvancedFishing",
                [2] = "Clicked"
            }

            game:GetService("ReplicatedStorage").Network.Instancing_InvokeCustomFromClient:InvokeServer(unpack(argsClicked))
        until not hasFishingLine
        task.wait()
    end
end
function autoFishNormal()

    if not game:GetService("Workspace").__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("Fishing") then
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = game:GetService("Workspace").__THINGS.Instances.Fishing.Teleports.Enter.CFrame
        task.wait(1)
    end

    while task.wait() and getgenv().config.Fishing.Enabled and getgenv().config.Fishing.PlaceToFish == "NormalFishing" do
        local x = math.random(1, 50)
        local z = math.random(1, 20)

        local argsCast = {
            [1] = "Fishing",
            [2] = "RequestCast",
            [3] = Vector3.new(1149.94775390625, 75.91414642333984, -3460.374755859375) + Vector3.new(x, 0, z)
        }

        game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsCast))
        task.wait(2.5)

        local argsReel = {
            [1] = "Fishing",
            [2] = "RequestReel"
        }
        game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsReel))

        repeat
            task.wait()

            local hasFishingLine = false
            for _, descendant in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if descendant.Name == "FishingLine" then
                    hasFishingLine = true
                    break
                end
            end
            
            game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsReel))
            if not hasFishingLine then
                break
            end

            local argsClicked = {
                [1] = "Fishing",
                [2] = "Clicked"
            }

            game:GetService("ReplicatedStorage").Network.Instancing_InvokeCustomFromClient:InvokeServer(unpack(argsClicked))
        until not hasFishingLine
        task.wait()
    end
end
-- Auto Send Mail
function autoSendMail()
    
    local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local result = saveModule.Get()
    local ms = result.Inventory.Misc
    for i, v in pairs(ms) do
        if v.id == "Magic Shard" and getgenv().config.AutoMail.sendShards then
            if v._am >= getgenv().config.AutoMail.minShards then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." shards",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
        if v.id == "Charm Stone" and getgenv().config.AutoMail.sendShit then
            if v._am >= 10 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." Charm Stone",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
        if v.id == "Gift Bag" and getgenv().config.AutoMail.sendShit then
            if v._am >= 15 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." Gift Bag",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
        if v.id == "Large Gift Bag" and getgenv().config.AutoMail.sendShit then
            if v._am >= 5 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." Large Gift Bag",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
        if v.id == "Mini Lucky Block" and getgenv().config.AutoMail.sendShit then
            if v._am >= 5 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." Lucky Block",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
        if v.id == "Mini Pinata" and getgenv().config.AutoMail.sendShit then
            if v._am >= 5 then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Misc", i, v._am}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v._am.." Pinata",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    end

    task.wait(0.2)

    local pet = result.Inventory.Pet
    for i, v in pairs(pet) do
        if getgenv().config.AutoMail.sendHuge then
            if v.id == "Huge Poseidon Corgi" or v.id == "Huge Whale Shark" then
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Pet", i, 1}))
                iHHLib:MakeNotification({
                    Name = "[iHH] Mail Send!",
                    Content = "Sended "..v.id.." !",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    end
    task.wait(0.2)

    local GetSave = function()
        return require(game.ReplicatedStorage.Library.Client.Save).Get()
    end
    for i, v in pairs(GetSave().Inventory.Currency) do
        if v.id == "Diamonds" then
            if v._am >= getgenv().config.AutoMail.gemAmount then
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack({getgenv().config.AutoMail.userToMail, "", "Currency", i, v._am -30000})) -- 30k = 10k mail + 20k keep
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
spawn(antiAFK)
