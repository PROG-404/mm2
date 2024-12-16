-- التحقق من اللعبة
if not game.PlaceId == 2753915549 and not game.PlaceId == 4442272183 and not game.PlaceId == 7449423635 then
    warn("This script is only for Blox Fruits!")
    return
end

-- تحميل مكتبة Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- إعداد واجهة Orion
local Window = OrionLib:MakeWindow({
    Name = "PROG - Advanced Aimbot for Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "PROGConfig"
})

-- متغيرات التحكم بالـ Aimbot
local AimbotEnabled = false
local WeaponType = "Sword" -- الافتراضي: سيف

-- دالة إيجاد أقرب لاعب
local function GetClosestPlayer()
    local player = game.Players.LocalPlayer
    local shortestDistance = math.huge
    local closestPlayer = nil

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") and otherPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = otherPlayer.Character.Humanoid
            if humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end

    return closestPlayer
end

-- دالة لتحريك السلاح نحو العدو
local function AimAtPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") -- إيجاد السلاح الحالي
        if tool then
            if WeaponType == "Sword" or WeaponType == "Gun" or WeaponType == "Melee" or WeaponType == "Fruit" then
                -- تحريك السلاح نحو الهدف
                local targetPos = targetPlayer.Character.HumanoidRootPart.Position
                -- هنا نضبط الزاوية لنتأكد من ضرب اللاعب مباشرة
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos) * CFrame.new(0, 0, 3) -- الاقتراب من الهدف
                -- تنفيذ الهجوم
                tool:Activate()
            end
        end
    end
end

-- دالة تفعيل الـ Aimbot
local function EnableAimbot()
    AimbotEnabled = true
    print("Aimbot Enabled!")
    -- استماع لحدث الضربة
    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Running:Connect(function(speed)
        if AimbotEnabled and speed > 0 then
            -- عندما يبدأ اللاعب بالتحرك (مؤشر لضرب السيف أو الهجوم)
            local closestPlayer = GetClosestPlayer()
            if closestPlayer then
                AimAtPlayer(closestPlayer)
            end
        end
    end)
end

-- دالة تعطيل الـ Aimbot
local function DisableAimbot()
    AimbotEnabled = false
    print("Aimbot Disabled!")
end

-- قسم الـ Aimbot في Orion
local AimbotTab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- زر تفعيل/تعطيل Aimbot
AimbotTab:AddToggle({
    Name = "Enable Aimbot",
    Default = false,
    Callback = function(value)
        if value then
            EnableAimbot()
        else
            DisableAimbot()
        end
    end
})

-- قائمة اختيار نوع السلاح
AimbotTab:AddDropdown({
    Name = "Weapon Type",
    Default = "Sword",
    Options = { "Sword", "Gun", "Melee", "Fruit" },
    Callback = function(value)
        WeaponType = value
        print("Weapon Type set to:", WeaponType)
    end
})

-- تفعيل Orion
OrionLib:Init()
