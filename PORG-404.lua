local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "PORG-404", HidePremium = false, SaveConfig = true, ConfigFolder = "PORG-404"})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


MainTab:AddSection({
    Name = "Kill All Options"
})


MainTab:AddButton({
    Name = "Kill All",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame
                    wait(0.5)
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end    
})


MainTab:AddSection({
    Name = "Auto Win"
})


MainTab:AddToggle({
    Name = "Auto Win",
    Default = false,
    Callback = function(state)
        if state then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
            wait(30)
        else
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
        end
    end    
})


MainTab:AddSection({
    Name = "Performance Settings"
})


MainTab:AddButton({
    Name = "Increase FPS",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end    
})


MainTab:AddButton({
    Name = "Increase Quality",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
    end    
})


MainTab:AddButton({
    Name = "Reset Player",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end    
})


local TeleportTab = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


TeleportTab:AddSection({
    Name = "Teleport to Players"
})


local playerList = {}
for _, player in pairs(game.Players:GetPlayers()) do
    table.insert(playerList, player.Name)
end

TeleportTab:AddDropdown({
    Name = "Teleport to Player",
    Options = playerList,
    Callback = function(selectedPlayer)
        local player = game.Players:FindFirstChild(selectedPlayer)
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end    
})


TeleportTab:AddSection({
    Name = "Teleport to Gun"
})


TeleportTab:AddToggle({
    Name = "Teleport to Gun",
    Default = false,
    Callback = function(state)
        if state then
            local gun = workspace:FindFirstChild("Gun")
            if gun then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gun.CFrame
            end
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
        end
    end    
})


local ESPTab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


ESPTab:AddSection({
    Name = "ESP Settings"
})


ESPTab:AddToggle({
    Name = "ESP (Detect Roles)",
    Default = false,
    Callback = function(state)
        if state then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local role = player:GetRoleInGroup() or "Innocent"
                        local color = role == "Murderer" and Color3.fromRGB(255, 0, 0) or (role == "Sheriff" and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(0, 255, 0))
                        local highlight = Instance.new("Highlight", character)
                        highlight.FillColor = color
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0.5
                    end
                end
            end
        else
            for _, highlight in pairs(workspace:GetDescendants()) do
                if highlight:IsA("Highlight") then
                    highlight:Destroy()
                end
            end
        end
    end    
})


local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


PlayerTab:AddSection({
    Name = "Player Enhancements"
})


PlayerTab:AddToggle({
    Name = "Speed",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end    
})


PlayerTab:AddToggle({
    Name = "Jump",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end    
})


PlayerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(state)
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if state then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end    
})


PlayerTab:AddToggle({
    Name = "Wall Hack",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
        end
    end    
})


OrionLib:Init()
