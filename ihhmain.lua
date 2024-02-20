repeat wait() until game:IsLoaded()
wait(2)

getgenv().config = {
	bundleGiftBag = "", -- Cái này đừng đụng vào
	
	userToMail = "TrnBi99", -- Đổi thành tên của bạn
	minShards = 50, -- Tuỳ chỉnh số lượng shard
	gemAmount = 300000, -- Số lượng gem (2000000 = 2m)
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/main/ihhscript.lua"))()
