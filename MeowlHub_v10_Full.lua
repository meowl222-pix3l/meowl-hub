--// ╔══════════════════════════════════════════════════════════════════╗
--// ║                                                                  ║
--// ║           🐱🐱🐱  MEOWL HUB v10  🐱🐱🐱                          ║
--// ║                                                                  ║
--// ║  Owner: Superman72657                                            ║
--// ║  Credit: Meowlsoul_67 & Superman72657                          ║
--// ║  Discord: https://discord.gg/7YAEYT6tT                         ║
--// ║                                                                  ║
--// ╚══════════════════════════════════════════════════════════════════╝

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

--// Owner Info
local OWNER_NAME = "Superman72657"
local DISCORD_LINK = "https://discord.gg/7YAEYT6tT"
local isOwner = (LocalPlayer.Name == OWNER_NAME or LocalPlayer.DisplayName == OWNER_NAME)

--// Utility Functions
local function Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

local function Tween(obj, properties, duration, easingStyle, easingDirection)
    local tween = TweenService:Create(obj, TweenInfo.new(
        duration or 0.3, 
        easingStyle or Enum.EasingStyle.Quad, 
        easingDirection or Enum.EasingDirection.Out
    ), properties)
    tween:Play()
    return tween
end

local function RippleEffect(button, x, y)
    local ripple = Create("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, x, 0, y),
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = button,
        ZIndex = button.ZIndex + 5
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ripple})
    local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
    Tween(ripple, {Size = UDim2.new(0, maxSize, 0, maxSize), BackgroundTransparency = 1}, 0.7)
    task.delay(0.7, function() ripple:Destroy() end)
end

--// Notification System
function MeowlNotify(title, message, duration)
    duration = duration or 3
    local notifFrame = Create("Frame", {
        Size = UDim2.new(0, 320, 0, 85),
        Position = UDim2.new(1, 20, 1, -100),
        BackgroundColor3 = Color3.fromRGB(20, 25, 40),
        BorderSizePixel = 0,
        Parent = CoreGui,
        ZIndex = 1000
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = notifFrame})
    Create("UIStroke", {Color = Color3.fromRGB(0, 255, 200), Thickness = 1.5, Parent = notifFrame})
    
    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 28),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = "🐱 " .. title,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 255, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notifFrame,
        ZIndex = 1001
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 45),
        Position = UDim2.new(0, 10, 0, 32),
        BackgroundTransparency = 1,
        Text = message,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notifFrame,
        ZIndex = 1001
    })
    
    Tween(notifFrame, {Position = UDim2.new(1, -340, 1, -100)}, 0.4)
    task.delay(duration, function()
        Tween(notifFrame, {Position = UDim2.new(1, 20, 1, -100)}, 0.3)
        task.wait(0.3)
        if notifFrame then notifFrame:Destroy() end
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// MAIN GUI
--// ═══════════════════════════════════════════════════════════════════
local MeowlHub = Create("ScreenGui", {
    Name = "MeowlHubV10",
    Parent = CoreGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

--// Main Frame
local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = Color3.fromRGB(10, 12, 22),
    BorderSizePixel = 0,
    Parent = MeowlHub,
    ClipsDescendants = true,
    ZIndex = 10,
    Visible = true
})

Create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = MainFrame})
Create("UIStroke", {Color = Color3.fromRGB(0, 255, 200), Thickness = 2, Parent = MainFrame})

MeowlNotify("Meowl Hub", "Welcome! 🐱✨", 2)

print("✅ Meowl Hub v10 loaded successfully!")
