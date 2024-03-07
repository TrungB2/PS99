repeat task.wait() until game:IsLoaded()
if not game:IsLoaded() then game:IsLoaded():Wait(5) end
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
UserSettings():GetService("UserGameSettings").MasterVolume = 0
local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
sethiddenproperty(l,"Technology",2)
sethiddenproperty(t,"Decoration",false)
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 1
l.GlobalShadows = 0
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(w:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Transparency = 1
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Transparency = 1
        v.Reflectance = 0
        v.TextureID = 0
    elseif v:IsA("SpecialMesh") and decalsyeeted  then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.Graphic=1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=1
    end
end
for i = 1,#l:GetChildren() do
    e=l:GetChildren()[i]
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end
w.DescendantAdded:Connect(function(v)
    pcall(function()
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.Transparency = 1
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") and decalsyeeted then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 0
            v.Transparency = 1
        elseif v:IsA("SpecialMesh") and decalsyeeted then
            v.TextureId=0
        elseif v:IsA("ShirtGraphic") and decalsyeeted then
            v.ShirtGraphic=1
        elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
            v[v.ClassName.."Template"]=1
        end
    end)
end)
