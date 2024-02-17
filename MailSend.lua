getgenv().Config = {}

local TrungBLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/PS99/main/TrungBLib.lua')))()
local Window = TrungBLib:MakeWindow({Name = "AutoMail", HidePremium = false, SaveConfig = false, ConfigFolder = "TrungBTest"})

local Tab = Window:MakeTab(
    {
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

Tab:AddTextbox(
    {
        Name = "Username",
        Default = "",
        TextDisappear = false,
        Callback = function(user)
            username = user
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Gem Amount",
        Default = "",
        TextDisappear = false,
        Callback = function(gems)
            gemAmount = tonumber(gems)
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Mail (Huge, 50 Shards, Gems)",
        Default = false,
        Callback = function(v)
            Config.autoMail = v
            spawn(autoMail)
        end
    }
)

TrungBLib:Init()

function autoMail()
    while task.wait() and Config.autoMail do
        local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = saveModule.Get()
	local ms = result.Inventory.Misc
	for i, v in pairs(ms) do
		if v.id == "Magic Shard" then
			if v._am >= 50 then
				local args = {
					[1] = username,
					[2] = "Magic Shard",
					[3] = "Misc",
					[4] = i,
					[5] = v._am or 1
				}
				game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(
					unpack(args)
				)
			end
		elseif v.id == "Charm Stone" then
			if v._am >= 1 then
				local args = {       
					[1] = username,
					[2] = "Charm Stone",
					[3] = "Misc",
					[4] = i,
					[5] = v._am or 1      
				}
				game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(
					unpack(args)
				)
			end
		end
	end

	task.wait(2)

	local pet = result.Inventory.Pet
	for i, v in pairs(pet) do
	    if v.id == "Huge Poseidon Corgi" then
		local args = {
		    [1] = username,
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
		if v._am >= gemAmount then
			local args = {
				[1] = username,
				[2] = v.id,
				[3] = "Currency",
				[4] = i,
				[5] = gemAmount - 10000
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
		end
	    end
	    task.wait(1)
	end
    end
end
