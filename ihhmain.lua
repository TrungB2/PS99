repeat wait() until game:IsLoaded()
wait(3)

getgenv().Config = {
	userToMail = "TrnBi99", -- Đổi thành tên của bạn
	minShards = 50, -- Tuỳ chỉnh số lượng shard
	gemAmount = 300000, -- Số lượng gem (2000000 = 2m)
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/PS99/main/ihhscript.lua"))()
