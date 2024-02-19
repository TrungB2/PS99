local player = game.Players.LocalPlayer
local iHHLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/Skid/main/TrungBLib.lua')))()
local Window = iHHLib:MakeWindow({Name = "[iHH] Hub", HidePremium = false, SaveConfig = false, ConfigFolder = "iHHCheat"})

local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library", 2000))
------------- Farming tab
local Farm = Window:MakeTab(
    {
        Name = "Farming",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

local Section = Farm:AddSection(
	{
		Name = "Farming method"
	}
)
Farm:AddToggle(
    {
        Name = "Auto Collect Bag",
        Default = false,
        Callback = function(v)
            Config.autoCollectBag = v
            spawn(autoCollectBag)
        end
    }
)

local Section = Farm:AddSection(
	{
		Name = "Open Gift Bag method"
	}
)

Farm:AddToggle(
    {
        Name = "Auto Claim Reward",
        Default = false,
        Callback = function(v)
            Config.autoClaimReward = v
            spawn(autoClaimReward)
        end
    }
)

Farm:AddToggle(
    {
        Name = "Auto Gift Bag",
        Default = false,
        Callback = function(v)
            Config.autoGiftBag = v
            spawn(autoGiftBag)
        end
    }
)

Farm:AddToggle(
    {
        Name = "Auto Large Gift Bag",
        Default = false,
        Callback = function(v)
            Config.autoLargeGiftBag = v
            spawn(autoLargeGiftBag)
        end
    }
)

local Section = Farm:AddSection(
	{
		Name = "Open Bundle Gift Bag"
	}
)

Farm:AddToggle(
    {
        Name = "Auto Bundle Gift Bag",
        Default = false,
        Callback = function(v)
            Config.autoBundleGiftBag = v
            spawn(autoBundleGiftBag)
        end
    }
)
------------- Fishing tab
local Fishing = Window:MakeTab(
    {
        Name = "Fishing",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

local Section = Fishing:AddSection(
	{
		Name = "Auto Claim Hidden Present"
	}
)
Fishing:AddToggle(
    {
        Name = "Auto Hidden Present",
        Default = false,
        Callback = function(v)
            Config.autoHiddenPresent = v
            spawn(autoHiddenPresent)
        end
    }
)
local Section = Fishing:AddSection(
	{
		Name = "Auto Advanced Fishing"
	}
)

Fishing:AddToggle(
    {
        Name = "Auto Fish (Advanced)",
        Default = false,
        Callback = function(v)
            Config.autoFishA = v
            spawn(autoFishA)
        end
    }
)
Fishing:AddButton(
    {
        Name = "TP Fishing Area",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-180.852783203125, 117.92350006103516, 5175.45703125)
        end
    }
)

------------- Mail tab
local Mail =
    Window:MakeTab(
    {
        Name = "Mail",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)
local Section = Mail:AddSection(
	{
		Name = "Auto Claim Mail"
	}
)

Mail:AddToggle(
    {
        Name = "Auto Claim Mail",
        Default = false,
        Callback = function(v)
            Config.autoClaimMail = v
            spawn(autoClaimMail)
        end
    }
)

local Section = Mail:AddSection(
	{
		Name = "Auto Send Mail"
	}
)
Mail:AddToggle(
    {
        Name = "Auto Send Mail (Huge, Shard, Gems)",
        Default = false,
        Callback = function(v)
            Config.autoSendMail = v
            spawn(autoSendMail)
        end
    }
)

------------- Mics
local Mics = Window:MakeTab(
    {
        Name = "Mics",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

local Section = Mics:AddSection(
	{
		Name = "Setup your game with Low CPU and auto antiAFK"
	}
)
Mics:AddButton(
    {
        Name = "Reduce CPU",
        Callback = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/main/lowCPU.lua"))()
        end
    }
)
Mics:AddButton(
    {
        Name = "Whitescreen ON",
        Callback = function()
            game:GetService("RunService"):Set3dRenderingEnabled(false)
        end
    }
)
Mics:AddButton(
    {
        Name = "Whitescreen OFF",
        Callback = function()
            game:GetService("RunService"):Set3dRenderingEnabled(true)
        end
    }
)

iHHLib:Init()

-- Auto Gift Bag
function autoGiftBag()
	while task.wait() and Config.autoGiftBag do
		local args = {
			[1] = "Gift Bag"
		}
		game:GetService("ReplicatedStorage").Network.GiftBag_Open:InvokeServer(unpack(args))

	end
end

-- Auto Large Gift Bag

function autoLargeGiftBag()
	while task.wait() and Config.autoLargeGiftBag do
		local args = {
			[1] = "Large Gift Bag"
		}
		game:GetService("ReplicatedStorage").Network.GiftBag_Open:InvokeServer(unpack(args))
	end
end

-- Auto Bundle Gift Bag

function autoBundleGiftBag()
	while task.wait() and Config.autoBundleGiftBag do
		local args = {
			[1] = "Large Gift Bag"
		}
		game:GetService("ReplicatedStorage").Network.GiftBag_Open:InvokeServer(unpack(args))
	end
end
-- Auto Free Gift
function autoClaimReward()
    while task.wait() and Config.autoClaimReward do
		for i = 1, 12 do
			local args = {[1] = i}
			game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Redeem Free Gift"):InvokeServer(unpack(args))
			wait(0.5)
		end
    end
end

-- Auto  Collect
function autoCollectBag()
    while task.wait() and Config.autoCollectBag do

        -- Coins
        for i, v in pairs(game.workspace['__THINGS'].Orbs:GetChildren()) do
            if v:IsA("Part") then
                v.CFrame = player.Character.HumanoidRootPart.CFrame
            end
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer(unpack({[1] = {[1] = tonumber(v.Name)}}))
            wait(0.03)
        end
        
        -- LootBags
        for _, lootbag in pairs(Library.Things:FindFirstChild("Lootbags"):GetDescendants()) do
            if lootbag and not lootbag:GetAttribute("Collected") then
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack({ [1] = { [1] = lootbag.Name, }, }))
                task.wait(0.03)
                if lootbag:IsA("MeshPart") then
                    lootbag.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end
        end
        
    end	
end


-- Auto Present
function autoHiddenPresent()
	while task.wait() and Config.autoHiddenPresent do
		local save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = save.Get()
		local present = result.HiddenPresents
		for i, v in pairs(present) do
			local args = {
				[1] = v.ID
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Hidden Presents: Found"):InvokeServer(unpack(args))
			wait(0.3)
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
	while task.wait() and Config.autoClaimMail do
		game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
	end
end

-- Auto Fishing
function autoFishA()
    while task.wait() and Config.autoFishA do
        local x = math.random(10, 20)
        local z = math.random(10, 20)

        local argsCast = {
            [1] = "AdvancedFishing",
            [2] = "RequestCast",
            [3] = Vector3.new(1470.6005859375, 61.6249885559082, -4448.0107421875) + Vector3.new(x, 0, z)
        }

        game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(argsCast))
        task.wait(3.5)

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

            if not hasFishingLine then
                break
            end

            local argsClicked = {
                [1] = "AdvancedFishing",
                [2] = "Clicked"
            }

            game:GetService("ReplicatedStorage").Network.Instancing_InvokeCustomFromClient:InvokeServer(
                unpack(argsClicked)
            )
        until not hasFishingLine
        task.wait()
    end
end

-- Auto Send Mail
function autoSendMail()
    while task.wait() and Config.autoSendMail do
        local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = saveModule.Get()

        local ms = result.Inventory.Misc
        for i, v in pairs(ms) do
            if v.id == "Magic Shard" then
                if v._am >= config.minShards then
                    local args = {
                        [1] = config.userToMail,
                        [2] = "Magic Shard",
                        [3] = "Misc",
                        [4] = i,
                        [5] = v._am or 1
                    }
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
                end
            end
        end

        task.wait(2)

        local pet = result.Inventory.Pet
        for i, v in pairs(pet) do
            if v.id == "Huge Poseidon Corgi" then
                local args = {
                    [1] = config.userToMail,
                    [2] = "Huge Poseidon Corgi",
                    [3] = "Pet",
                    [4] = i,
                    [5] = v._am or 1
                }
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
            end
        end

        task.wait(2)

        local GetSave = function()
            return require(game.ReplicatedStorage.Library.Client.Save).Get()
        end
        for i, v in pairs(GetSave().Inventory.Currency) do
            if v.id == "Diamonds" then
                if v._am >= config.gemAmount then
                    local args = {
                        [1] = config.userToMail,
                        [2] = v.id,
                        [3] = "Currency",
                        [4] = i,
                        [5] = v._am - 60000
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                end
            end
            task.wait(1)
        end
    end
end

antiAFK()
