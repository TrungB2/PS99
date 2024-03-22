getgenv().webhook = "https://discord.com/api/webhooks/1217176778972336209/k0yAZEx1f04DuRG3YaOSj9vsJS96EebiHaQSQHaeF3S_TTCFfO774Z2q69bjarXJphae" -- webhook link for successful snipes
getgenv().userid = "370499333101060096" -- pings your discord id if it snipes a huge or titanic
getgenv().place = 15502339080

repeat wait() until game:IsLoaded()
if game.PlaceId == 15502339080 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/StillSkid-ForReal/snip.lua'))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AwesomeDudePerfect/bop/main/tp-to-plaza.lua"))()
end
