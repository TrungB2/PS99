repeat wait() until game:IsLoaded()
wait(2)
print("Loading...")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local WindowFocusReleasedFunction = function()
    RunService:Set3dRenderingEnabled(false)
    setfpscap(60)
    return
end

local WindowFocusedFunction = function()
    RunService:Set3dRenderingEnabled(true)
    setfpscap(60)
    return
end

local Initialize = function()
    UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
    UserInputService.WindowFocused:Connect(WindowFocusedFunction)
    return
end
Initialize()

print('starting')

function run()
    print('deleting every thing')
    task.spawn(function()
        local THINGS = game:GetService("Workspace")["__THINGS"]
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

        for _, v in pairs(game:GetService("Workspace"):GetDescendants())) do
            if v.Name == "ALWAYS_RENDERING" and v.Name == "Border" and v.Name == "Border2" and v.Name == "FlyBorder" and v.Name == "FlyBorder2" and v.Name ~= game.Players.LocalPlayer.Name then
                print('deleted border')
                v:Destroy()
            end
        end
        for _, v in pairs(game:GetService("Workspace").Map:GetChildren()) do 
            v:Destroy()
        end
        
        for _, v in pairs(THINGS.Sounds:GetChildren()) do
            v:Destroy()
        end

        for _, v in pairs(THINGS["Ski Chairs"]:GetChildren()) do
            v:Destroy()
        end
        
        for _, v in pairs(THINGS:GetChildren()) do
            if v:IsA('Model') and v.Name ~= "Breakables" and v.Name ~= "__FAKE_GROUND" and v.Name ~= "AnimatedBreakables" and v.Name ~= "Pets" then
                v:Destroy()
            end
        end

        for _, v in pairs(game:GetService("GuiService"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("Stats"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("CorePackages"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("MaterialService"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("StarterGui"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("Chat").ClientChatModules:GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("InsertService"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                v:Destroy()
            end
        end
        for _, v in pairs(game:GetService("ReplicatedFirst"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("ControllerService"):GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("TextChatService").BIGTextChatCommands:GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("TextChatService").TextChannels:GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("TextChatService").TextChatCommands:GetChildren()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("StarterPlayer").StarterPlayerScripts:GetDescendants()) do
            v:Destroy()
        end
        for _, v in pairs(game:GetService("StarterPlayer").StarterCharacterScripts:GetChildren()) do
            v:Destroy()
        end
    end)
end
run()

loadstring(game:HttpGet("https://raw.githubusercontent.com/TrungB2/Skid/BestSkid/ReduceLag/lowCPU.lua"))()
