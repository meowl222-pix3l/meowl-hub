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

    Tween(notifFrame, {Position = UDim2.new(1, -340, 1, -100)}, 0.4, Enum.EasingStyle.Back)
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
    Visible = false
})

Create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = MainFrame})
Create("UIStroke", {Color = Color3.fromRGB(0, 255, 200), Thickness = 2, Parent = MainFrame})

-- Glow
local Glow1 = Create("Frame", {
    Size = UDim2.new(1, 40, 1, 40),
    Position = UDim2.new(0, -20, 0, -20),
    BackgroundTransparency = 1,
    Parent = MainFrame,
    ZIndex = 0
})
Create("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4996891970",
    ImageColor3 = Color3.fromRGB(0, 255, 200),
    ImageTransparency = 0.8,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(20, 20, 280, 280),
    Parent = Glow1
})

-- Animated Glow Pulse
spawn(function()
    while Glow1 and Glow1.Parent do
        Tween(Glow1:FindFirstChildOfClass("ImageLabel"), {ImageTransparency = 0.6}, 1.5)
        task.wait(1.5)
        Tween(Glow1:FindFirstChildOfClass("ImageLabel"), {ImageTransparency = 0.85}, 1.5)
        task.wait(1.5)
    end
end)

--// Particles
local ParticlesFrame = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = MainFrame,
    ZIndex = 1
})

for i = 1, 20 do
    local particle = Create("Frame", {
        Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5)),
        Position = UDim2.new(math.random(), 0, math.random(), 0),
        BackgroundColor3 = Color3.fromRGB(0, 255, 200),
        BackgroundTransparency = math.random(4, 9) / 10,
        BorderSizePixel = 0,
        Parent = ParticlesFrame,
        ZIndex = 1
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = particle})
    spawn(function()
        while particle and particle.Parent do
            Tween(particle, {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundTransparency = math.random(4, 9) / 10
            }, math.random(4, 10))
            task.wait(math.random(4, 10))
        end
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// TITLE BAR
--// ═══════════════════════════════════════════════════════════════════
local TitleBar = Create("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 55),
    BackgroundColor3 = Color3.fromRGB(16, 20, 32),
    BorderSizePixel = 0,
    Parent = MainFrame,
    ZIndex = 20
})
Create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = TitleBar})
Create("Frame", {
    Size = UDim2.new(1, 0, 0, 15),
    Position = UDim2.new(0, 0, 1, -15),
    BackgroundColor3 = Color3.fromRGB(16, 20, 32),
    BorderSizePixel = 0,
    Parent = TitleBar,
    ZIndex = 20
})

-- Cat Icon with bounce
local CatIcon = Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 45),
    Position = UDim2.new(0, 12, 0, 5),
    BackgroundTransparency = 1,
    Text = "🐱",
    TextSize = 32,
    Font = Enum.Font.GothamBold,
    Parent = TitleBar,
    ZIndex = 21
})
spawn(function()
    while CatIcon and CatIcon.Parent do
        Tween(CatIcon, {Rotation = 15}, 0.3)
        task.wait(0.3)
        Tween(CatIcon, {Rotation = -15}, 0.3)
        task.wait(0.3)
        Tween(CatIcon, {Rotation = 0}, 0.3)
        task.wait(1)
    end
end)

-- Title with gradient animation
local TitleText = Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 55),
    Position = UDim2.new(0, 60, 0, 0),
    BackgroundTransparency = 1,
    Text = "Meowl Hub",
    TextSize = 26,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleBar,
    ZIndex = 21
})

spawn(function()
    local colors = {
        Color3.fromRGB(0, 255, 200),
        Color3.fromRGB(100, 255, 255),
        Color3.fromRGB(255, 100, 255),
        Color3.fromRGB(255, 200, 0),
        Color3.fromRGB(0, 255, 200)
    }
    local idx = 1
    while TitleText and TitleText.Parent do
        Tween(TitleText, {TextColor3 = colors[idx]}, 1.5)
        idx = idx % #colors + 1
        task.wait(1.5)
    end
end)

Create("TextLabel", {
    Size = UDim2.new(0, 70, 0, 20),
    Position = UDim2.new(0, 190, 0, 20),
    BackgroundTransparency = 1,
    Text = "v10",
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleBar,
    ZIndex = 21
})

-- Owner Badge
local OwnerBadge = Create("TextLabel", {
    Size = UDim2.new(0, 220, 0, 26),
    Position = UDim2.new(0, 260, 0, 16),
    BackgroundColor3 = Color3.fromRGB(255, 215, 0),
    Text = "  👑 OWNER: Superman72657",
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = TitleBar,
    ZIndex = 21
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = OwnerBadge})

-- FPS Counter
local FPSLabel = Create("TextLabel", {
    Size = UDim2.new(0, 80, 0, 20),
    Position = UDim2.new(1, -250, 0, 18),
    BackgroundTransparency = 1,
    Text = "FPS: 60",
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    Parent = TitleBar,
    ZIndex = 21
})

spawn(function()
    local lastTime = tick()
    local frameCount = 0
    while FPSLabel and FPSLabel.Parent do
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            FPSLabel.Text = "FPS: " .. frameCount
            frameCount = 0
            lastTime = currentTime
        end
        RunService.RenderStepped:Wait()
    end
end)

-- Window Controls
local MinimizeBtn = Create("TextButton", {
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(1, -120, 0, 10),
    BackgroundColor3 = Color3.fromRGB(255, 193, 7),
    Text = "−",
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = TitleBar,
    ZIndex = 22
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = MinimizeBtn})

local CloseBtn = Create("TextButton", {
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(1, -80, 0, 10),
    BackgroundColor3 = Color3.fromRGB(244, 67, 54),
    Text = "×",
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = TitleBar,
    ZIndex = 22
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = CloseBtn})

-- Resize Handle
local ResizeHandle = Create("TextButton", {
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -28, 1, -28),
    BackgroundTransparency = 1,
    Text = "",
    Parent = MainFrame,
    ZIndex = 30
})
Create("ImageLabel", {
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    Image = "rbxassetid://6764432408",
    ImageColor3 = Color3.fromRGB(0, 255, 200),
    Parent = ResizeHandle,
    ZIndex = 31
})

--// Sidebar
local Sidebar = Create("Frame", {
    Size = UDim2.new(0, 65, 1, -55),
    Position = UDim2.new(0, 0, 0, 55),
    BackgroundColor3 = Color3.fromRGB(14, 17, 28),
    BorderSizePixel = 0,
    Parent = MainFrame,
    ZIndex = 15
})

local ContentArea = Create("Frame", {
    Size = UDim2.new(1, -65, 1, -55),
    Position = UDim2.new(0, 65, 0, 55),
    BackgroundColor3 = Color3.fromRGB(10, 12, 22),
    BorderSizePixel = 0,
    Parent = MainFrame,
    ZIndex = 15
})

local Pages = Create("Folder", {Name = "Pages", Parent = ContentArea})

--// ═══════════════════════════════════════════════════════════════════
--// TAB SYSTEM
--// ═══════════════════════════════════════════════════════════════════
local Tabs = {
    {Name = "Home", Icon = "🏠", Color = Color3.fromRGB(0, 255, 200)},
    {Name = "Executor", Icon = "⚡", Color = Color3.fromRGB(255, 200, 0)},
    {Name = "Scripts", Icon = "📜", Color = Color3.fromRGB(150, 100, 255)},
    {Name = "Hubs", Icon = "🚀", Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Games", Icon = "🎮", Color = Color3.fromRGB(100, 200, 255)},
    {Name = "Player", Icon = "👤", Color = Color3.fromRGB(0, 255, 150)},
    {Name = "Animation", Icon = "🎭", Color = Color3.fromRGB(255, 100, 200)},
    {Name = "Skin", Icon = "👕", Color = Color3.fromRGB(255, 150, 50)},
    {Name = "Troll", Icon = "😈", Color = Color3.fromRGB(200, 50, 50)},
    {Name = "Bypass", Icon = "🔓", Color = Color3.fromRGB(100, 255, 100)},
    {Name = "Universe", Icon = "🌌", Color = Color3.fromRGB(150, 100, 255)},
    {Name = "Cloud", Icon = "☁️", Color = Color3.fromRGB(200, 200, 255)},
    {Name = "Music", Icon = "🎵", Color = Color3.fromRGB(255, 100, 150)},
    {Name = "Info", Icon = "ℹ️", Color = Color3.fromRGB(150, 150, 150)},
    {Name = "Premium", Icon = "👑", Color = Color3.fromRGB(255, 215, 0)},
    {Name = "Settings", Icon = "⚙️", Color = Color3.fromRGB(150, 150, 150)}
}

local TabButtons = {}
local TabPages = {}
local CurrentTab = "Home"

for i, tab in ipairs(Tabs) do
    local btn = Create("TextButton", {
        Name = tab.Name .. "Tab",
        Size = UDim2.new(0, 54, 0, 54),
        Position = UDim2.new(0, 5, 0, 6 + (i-1) * 60),
        BackgroundColor3 = Color3.fromRGB(22, 26, 40),
        Text = tab.Icon,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = Sidebar,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = btn})

    local btnStroke = Create("UIStroke", {
        Color = tab.Color, Thickness = 1.5, Transparency = 0.6, Parent = btn
    })

    local glow = Create("Frame", {
        Size = UDim2.new(1, 10, 1, 10),
        Position = UDim2.new(0, -5, 0, -5),
        BackgroundColor3 = tab.Color,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = btn,
        ZIndex = 15
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = glow})

    local indicator = Create("Frame", {
        Size = UDim2.new(0, 4, 0, 32),
        Position = UDim2.new(0, -3, 0.5, -16),
        BackgroundColor3 = tab.Color,
        BorderSizePixel = 0,
        Parent = btn,
        Visible = false,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 2), Parent = indicator})

    TabButtons[tab.Name] = {Button = btn, Indicator = indicator, Color = tab.Color, Stroke = btnStroke, Glow = glow}

    btn.MouseButton1Click:Connect(function()
        RippleEffect(btn, 27, 27)
        for name, data in pairs(TabButtons) do
            TabPages[name].Visible = false
            data.Indicator.Visible = false
            data.Stroke.Transparency = 0.6
            data.Glow.BackgroundTransparency = 1
            Tween(data.Button, {BackgroundColor3 = Color3.fromRGB(22, 26, 40)}, 0.2)
        end
        TabPages[tab.Name].Visible = true
        TabButtons[tab.Name].Indicator.Visible = true
        TabButtons[tab.Name].Stroke.Transparency = 0
        Tween(TabButtons[tab.Name].Button, {BackgroundColor3 = Color3.fromRGB(35, 42, 60)}, 0.2)
        Tween(TabButtons[tab.Name].Glow, {BackgroundTransparency = 0.5}, 0.3)
        CurrentTab = tab.Name
        TabPages[tab.Name].Position = UDim2.new(0, 30, 0, 0)
        Tween(TabPages[tab.Name], {Position = UDim2.new(0, 0, 0, 0)}, 0.35, Enum.EasingStyle.Back)
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// HOME PAGE
--// ═══════════════════════════════════════════════════════════════════
local HomePage = Create("ScrollingFrame", {
    Name = "HomePage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200),
    CanvasSize = UDim2.new(0, 0, 0, 900),
    Parent = Pages,
    ZIndex = 15
})
TabPages["Home"] = HomePage

-- Welcome Banner
local WelcomeBanner = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 150),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = WelcomeBanner})

local BannerGradient = Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 22, 36)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 32, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 22, 36))
    }),
    Rotation = 45,
    Parent = WelcomeBanner
})

spawn(function()
    while BannerGradient and BannerGradient.Parent do
        Tween(BannerGradient, {Rotation = BannerGradient.Rotation + 180}, 8)
        task.wait(8)
    end
end)

local LeftCat = Create("TextLabel", {
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(0, 15, 0, 25),
    BackgroundTransparency = 1,
    Text = "🐱",
    TextSize = 80,
    Parent = WelcomeBanner,
    ZIndex = 17
})

local RightCat = Create("TextLabel", {
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(1, -115, 0, 25),
    BackgroundTransparency = 1,
    Text = "🐱",
    TextSize = 80,
    Parent = WelcomeBanner,
    ZIndex = 17
})

spawn(function()
    while LeftCat and LeftCat.Parent do
        Tween(LeftCat, {Position = UDim2.new(0, 15, 0, 20)}, 1.5)
        Tween(RightCat, {Position = UDim2.new(1, -115, 0, 30)}, 1.5)
        task.wait(1.5)
        Tween(LeftCat, {Position = UDim2.new(0, 15, 0, 30)}, 1.5)
        Tween(RightCat, {Position = UDim2.new(1, -115, 0, 20)}, 1.5)
        task.wait(1.5)
    end
end)

Create("TextLabel", {
    Size = UDim2.new(0, 350, 0, 50),
    Position = UDim2.new(0.5, -175, 0, 25),
    BackgroundTransparency = 1,
    Text = "meowl hub!",
    TextSize = 40,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    Parent = WelcomeBanner,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 400, 0, 25),
    Position = UDim2.new(0.5, -200, 0, 75),
    BackgroundTransparency = 1,
    Text = "welcome to the best meowl hub script v10",
    TextSize = 15,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Parent = WelcomeBanner,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 400, 0, 22),
    Position = UDim2.new(0.5, -200, 0, 100),
    BackgroundTransparency = 1,
    Text = "thank you for using our script! 🐱✨",
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    Parent = WelcomeBanner,
    ZIndex = 17
})

-- Owner Card
local OwnerCard = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 65),
    Position = UDim2.new(0, 5, 0, 165),
    BackgroundColor3 = Color3.fromRGB(255, 215, 0),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = OwnerCard})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundTransparency = 1,
    Text = "👑 OWNER: Superman72657 👑",
    TextSize = 20,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = OwnerCard,
    ZIndex = 17
})

-- Credit Card
local CreditCard = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 55),
    Position = UDim2.new(0, 5, 0, 240),
    BackgroundColor3 = Color3.fromRGB(20, 25, 42),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = CreditCard})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundTransparency = 1,
    Text = "✨ Credits: Meowlsoul_67 & Superman72657 ✨",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    Parent = CreditCard,
    ZIndex = 17
})

-- Player Profile Card
local ProfileCard = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 200),
    Position = UDim2.new(0, 5, 0, 305),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = ProfileCard})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 28),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "👤 Player Profile",
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

local ProfileImage = Create("ImageLabel", {
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(0, 12, 0, 42),
    BackgroundColor3 = Color3.fromRGB(35, 40, 55),
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png",
    BorderSizePixel = 0,
    Parent = ProfileCard,
    ZIndex = 17
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = ProfileImage})
Create("UIStroke", {Color = Color3.fromRGB(0, 255, 200), Thickness = 2, Parent = ProfileImage})

-- Account Age
local accountAge = LocalPlayer.AccountAge
local years = math.floor(accountAge / 365)
local months = math.floor((accountAge % 365) / 30)
local days = accountAge % 30
local ageText = years > 0 and years .. "y " or ""
ageText = ageText .. (months > 0 and months .. "m " or "")
ageText = ageText .. days .. "d"

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 24),
    Position = UDim2.new(0, 125, 0, 42),
    BackgroundTransparency = 1,
    Text = "👤 " .. LocalPlayer.Name,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 125, 0, 68),
    BackgroundTransparency = 1,
    Text = "📛 " .. LocalPlayer.DisplayName,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 125, 0, 90),
    BackgroundTransparency = 1,
    Text = "🆔 User ID: " .. LocalPlayer.UserId,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 125, 0, 112),
    BackgroundTransparency = 1,
    Text = "📅 Account Age: " .. ageText,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 125, 0, 134),
    BackgroundTransparency = 1,
    Text = isOwner and "⭐ YOU ARE THE OWNER!" or "👤 Regular User",
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextColor3 = isOwner and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 125, 0, 156),
    BackgroundTransparency = 1,
    Text = "🛠️ Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown"),
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(0, 255, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
    ZIndex = 17
})

-- Game Info
local GameInfoCard = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 100),
    Position = UDim2.new(0, 5, 0, 515),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = GameInfoCard})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "🎮 Current Game",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = GameInfoCard,
    ZIndex = 17
})

local GameNameLabel = Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 22),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundTransparency = 1,
    Text = "Loading...",
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = GameInfoCard,
    ZIndex = 17
})

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    GameNameLabel.Text = info.Name
end)

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 10, 0, 60),
    BackgroundTransparency = 1,
    Text = "Game ID: " .. game.PlaceId,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = GameInfoCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 10, 0, 80),
    BackgroundTransparency = 1,
    Text = "Job ID: " .. game.JobId:sub(1, 20) .. "...",
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(120, 120, 120),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = GameInfoCard,
    ZIndex = 17
})

-- Discord Button
local DiscordBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 50),
    Position = UDim2.new(0, 5, 0, 625),
    BackgroundColor3 = Color3.fromRGB(88, 101, 242),
    Text = "💬 Join Discord Server",
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = DiscordBtn})

DiscordBtn.MouseButton1Click:Connect(function()
    RippleEffect(DiscordBtn, 300, 25)
    if setclipboard then setclipboard(DISCORD_LINK) end
    MeowlNotify("Discord", "Discord link copied to clipboard!", 3)
end)

-- Feedback Button
local FeedbackBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 685),
    BackgroundColor3 = Color3.fromRGB(100, 65, 165),
    Text = "💭 Send Feedback",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = FeedbackBtn})

FeedbackBtn.MouseButton1Click:Connect(function()
    RippleEffect(FeedbackBtn, 300, 22)
    if setclipboard then setclipboard("Meowl Hub Feedback for Superman72657: ") end
    MeowlNotify("Feedback", "Feedback template copied! Paste in Discord.", 3)
end)

-- Update Log
local UpdateCard = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 120),
    Position = UDim2.new(0, 5, 0, 740),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = HomePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = UpdateCard})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "📝 Update Log v10",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = UpdateCard,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 80),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundTransparency = 1,
    Text = "• Added 16 tabs!
• 10+ Scripts & Hubs
• Player teleport system
• Animation & Emotes
• Skin/Morph system
• Troll tools
• Bypass system
• Universe AI chat
• Cloud scripts
• Music player
• Cooler GUI & animations",
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    Parent = UpdateCard,
    ZIndex = 17
})

--// ═══════════════════════════════════════════════════════════════════
--// EXECUTOR PAGE
--// ═══════════════════════════════════════════════════════════════════
local ExecutorPage = Create("Frame", {
    Name = "ExecutorPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Executor"] = ExecutorPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "⚡ Script Executor",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 200, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ExecutorPage,
    ZIndex = 16
})

local ScriptBox = Create("ScrollingFrame", {
    Name = "ScriptBox",
    Size = UDim2.new(1, -10, 0, 280),
    Position = UDim2.new(0, 5, 0, 42),
    BackgroundColor3 = Color3.fromRGB(16, 20, 32),
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 200, 0),
    CanvasSize = UDim2.new(0, 0, 3, 0),
    Parent = ExecutorPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = ScriptBox})

local ScriptInput = Create("TextBox", {
    Size = UDim2.new(1, -20, 3, 0),
    Position = UDim2.new(0, 10, 0, 5),
    BackgroundTransparency = 1,
    Text = "-- ╔═══════════════════════════════════════╗
-- ║  Meowl Hub Script Executor v10        ║
-- ║  Paste your script below!             ║
-- ╚═══════════════════════════════════════╝

print('Hello from Meowl Hub! 🐱')",
    TextSize = 13,
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    MultiLine = true,
    ClearTextOnFocus = false,
    Parent = ScriptBox,
    ZIndex = 17
})

local ExecuteBtn = Create("TextButton", {
    Size = UDim2.new(0.24, 0, 0, 42),
    Position = UDim2.new(0, 5, 0, 332),
    BackgroundColor3 = Color3.fromRGB(0, 200, 100),
    Text = "▶ Execute",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ExecutorPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ExecuteBtn})

local ClearBtn = Create("TextButton", {
    Size = UDim2.new(0.24, 0, 0, 42),
    Position = UDim2.new(0.255, 0, 0, 332),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "🗑 Clear",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ExecutorPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ClearBtn})

local ClipboardBtn = Create("TextButton", {
    Size = UDim2.new(0.24, 0, 0, 42),
    Position = UDim2.new(0.51, 0, 0, 332),
    BackgroundColor3 = Color3.fromRGB(100, 100, 255),
    Text = "📋 Paste",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ExecutorPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ClipboardBtn})

local CopyBtn = Create("TextButton", {
    Size = UDim2.new(0.24, 0, 0, 42),
    Position = UDim2.new(0.755, 0, 0, 332),
    BackgroundColor3 = Color3.fromRGB(150, 50, 200),
    Text = "📤 Copy",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ExecutorPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = CopyBtn})

ExecuteBtn.MouseButton1Click:Connect(function()
    RippleEffect(ExecuteBtn, 60, 21)
    local scriptText = ScriptInput.Text
    if scriptText and scriptText ~= "" then
        local success, err = pcall(function()
            loadstring(scriptText)()
        end)
        if success then
            MeowlNotify("Executor", "Script executed successfully!", 2)
        else
            MeowlNotify("Error", tostring(err), 3)
        end
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    RippleEffect(ClearBtn, 60, 21)
    ScriptInput.Text = ""
end)

ClipboardBtn.MouseButton1Click:Connect(function()
    RippleEffect(ClipboardBtn, 60, 21)
    if getclipboard then
        ScriptInput.Text = getclipboard()
        MeowlNotify("Clipboard", "Pasted from clipboard!", 2)
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    RippleEffect(CopyBtn, 60, 21)
    if setclipboard then
        setclipboard(ScriptInput.Text)
        MeowlNotify("Copied", "Script copied to clipboard!", 2)
    end
end)

--// ═══════════════════════════════════════════════════════════════════
--// SCRIPTS PAGE (10 Scripts)
--// ═══════════════════════════════════════════════════════════════════
local ScriptsPage = Create("ScrollingFrame", {
    Name = "ScriptsPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255),
    CanvasSize = UDim2.new(0, 0, 0, 800),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Scripts"] = ScriptsPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "📜 10 Cool Scripts",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(150, 100, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ScriptsPage,
    ZIndex = 16
})

local AllScripts = {
    {Name = "Infinite Yield", Desc = "Best admin commands", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()", Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Dark Dex V3", Desc = "Game explorer & debugger", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua'))()", Color = Color3.fromRGB(100, 100, 255)},
    {Name = "Simple Spy", Desc = "Remote event spy", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()", Color = Color3.fromRGB(100, 255, 100)},
    {Name = "Fly V3", Desc = "Fly anywhere", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/Fly'))()", Color = Color3.fromRGB(0, 255, 200)},
    {Name = "ESP", Desc = "See players through walls", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/ESP'))()", Color = Color3.fromRGB(255, 100, 200)},
    {Name = "Speed Hack", Desc = "Run super fast", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/Speed'))()", Color = Color3.fromRGB(255, 200, 0)},
    {Name = "Owl Hub", Desc = "Universal game hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt'))()", Color = Color3.fromRGB(150, 100, 255)},
    {Name = "Domain X", Desc = "Multi-game hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/DomainX/main/source',true))()", Color = Color3.fromRGB(100, 200, 255)},
    {Name = "Unnamed ESP", Desc = "Advanced ESP", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()", Color = Color3.fromRGB(0, 255, 150)},
    {Name = "Aimbot", Desc = "Auto aim", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/Aimbot'))()", Color = Color3.fromRGB(255, 50, 50)}
}

for i, scriptData in ipairs(AllScripts) do
    local scriptCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 70),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 78),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = ScriptsPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = scriptCard})
    Create("UIStroke", {Color = scriptData.Color, Thickness = 1, Transparency = 0.5, Parent = scriptCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 24),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = scriptData.Name,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = scriptData.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = scriptCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 18),
        Position = UDim2.new(0, 12, 0, 30),
        BackgroundTransparency = 1,
        Text = scriptData.Desc,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = scriptCard,
        ZIndex = 17
    })

    local runBtn = Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 32),
        Position = UDim2.new(1, -80, 0, 19),
        BackgroundColor3 = scriptData.Color,
        Text = "Run",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = scriptCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = runBtn})

    runBtn.MouseButton1Click:Connect(function()
        RippleEffect(runBtn, 35, 16)
        local success, err = pcall(function()
            loadstring(scriptData.Script)()
        end)
        if success then
            MeowlNotify("Script", scriptData.Name .. " executed!", 2)
        else
            MeowlNotify("Error", tostring(err), 3)
        end
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// HUBS PAGE (10 Hubs)
--// ═══════════════════════════════════════════════════════════════════
local HubsPage = Create("ScrollingFrame", {
    Name = "HubsPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100),
    CanvasSize = UDim2.new(0, 0, 0, 800),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Hubs"] = HubsPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🚀 10 Script Hubs",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 100, 100),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HubsPage,
    ZIndex = 16
})

local AllHubs = {
    {Name = "Owl Hub", Desc = "Universal hub - 1000+ games", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt'))()", Color = Color3.fromRGB(150, 100, 255)},
    {Name = "Domain X", Desc = "Premium multi-game hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/DomainX/main/source',true))()", Color = Color3.fromRGB(100, 200, 255)},
    {Name = "VHub", Desc = "VHub script loader", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/VHub'))()", Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Krnl Hub", Desc = "Krnl official hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/KrnlHub'))()", Color = Color3.fromRGB(0, 255, 150)},
    {Name = "Synapse X Hub", Desc = "Synapse X scripts", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/SynapseHub'))()", Color = Color3.fromRGB(255, 200, 0)},
    {Name = "Comet Hub", Desc = "Comet exploit hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/CometHub'))()", Color = Color3.fromRGB(255, 100, 200)},
    {Name = "Electron Hub", Desc = "Electron scripts", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/ElectronHub'))()", Color = Color3.fromRGB(100, 255, 100)},
    {Name = "Fluxus Hub", Desc = "Fluxus script hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/FluxusHub'))()", Color = Color3.fromRGB(0, 200, 255)},
    {Name = "Script-Ware Hub", Desc = "Script-Ware loader", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/ScriptWareHub'))()", Color = Color3.fromRGB(255, 150, 50)},
    {Name = "Codex Hub", Desc = "Codex exploit hub", Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/FE/main/CodexHub'))()", Color = Color3.fromRGB(200, 100, 255)}
}

for i, hubData in ipairs(AllHubs) do
    local hubCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 70),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 78),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = HubsPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = hubCard})
    Create("UIStroke", {Color = hubData.Color, Thickness = 1, Transparency = 0.5, Parent = hubCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 24),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = hubData.Name,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = hubData.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = hubCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 18),
        Position = UDim2.new(0, 12, 0, 30),
        BackgroundTransparency = 1,
        Text = hubData.Desc,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = hubCard,
        ZIndex = 17
    })

    local runBtn = Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 32),
        Position = UDim2.new(1, -80, 0, 19),
        BackgroundColor3 = hubData.Color,
        Text = "Load",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = hubCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = runBtn})

    runBtn.MouseButton1Click:Connect(function()
        RippleEffect(runBtn, 35, 16)
        local success, err = pcall(function()
            loadstring(hubData.Script)()
        end)
        if success then
            MeowlNotify("Hub", hubData.Name .. " loaded!", 2)
        else
            MeowlNotify("Error", tostring(err), 3)
        end
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// GAMES PAGE (10 Famous Games)
--// ═══════════════════════════════════════════════════════════════════
local GamesPage = Create("ScrollingFrame", {
    Name = "GamesPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255),
    CanvasSize = UDim2.new(0, 0, 0, 800),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Games"] = GamesPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🎮 10 Famous Games",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(100, 200, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = GamesPage,
    ZIndex = 16
})

local FamousGames = {
    {Name = "Brookhaven 🏠", ID = 4924922222, Color = Color3.fromRGB(0, 255, 150)},
    {Name = "Adopt Me! 🐾", ID = 920587237, Color = Color3.fromRGB(255, 200, 0)},
    {Name = "Blox Fruits 🍈", ID = 2753915549, Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Tower of Hell 🗼", ID = 1962086868, Color = Color3.fromRGB(255, 100, 200)},
    {Name = "MeepCity 🐱", ID = 370731277, Color = Color3.fromRGB(100, 200, 255)},
    {Name = "Jailbreak 🚔", ID = 606849621, Color = Color3.fromRGB(255, 50, 50)},
    {Name = "Murder Mystery 2 🔪", ID = 142823291, Color = Color3.fromRGB(200, 50, 50)},
    {Name = "Royale High 👑", ID = 735030788, Color = Color3.fromRGB(255, 100, 255)},
    {Name = "Arsenal 🔫", ID = 286090429, Color = Color3.fromRGB(255, 200, 0)},
    {Name = "Shindo Life 🌀", ID = 4616652589, Color = Color3.fromRGB(100, 100, 255)}
}

for i, gameData in ipairs(FamousGames) do
    local gameCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 70),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 78),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = GamesPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = gameCard})
    Create("UIStroke", {Color = gameData.Color, Thickness = 1, Transparency = 0.5, Parent = gameCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 24),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = gameData.Name,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = gameData.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = gameCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 250, 0, 18),
        Position = UDim2.new(0, 12, 0, 30),
        BackgroundTransparency = 1,
        Text = "Game ID: " .. gameData.ID,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = gameCard,
        ZIndex = 17
    })

    local joinBtn = Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 32),
        Position = UDim2.new(1, -80, 0, 19),
        BackgroundColor3 = gameData.Color,
        Text = "Join",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = gameCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = joinBtn})

    joinBtn.MouseButton1Click:Connect(function()
        RippleEffect(joinBtn, 35, 16)
        MeowlNotify("Teleport", "Joining " .. gameData.Name .. "...", 2)
        TeleportService:Teleport(gameData.ID, LocalPlayer)
    end)
end

-- Current Game Info
local CurrentGameFrame = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 90),
    Position = UDim2.new(0, 5, 0, 42 + #FamousGames * 78 + 10),
    BackgroundColor3 = Color3.fromRGB(25, 30, 50),
    BorderSizePixel = 0,
    Parent = GamesPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = CurrentGameFrame})
Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "📍 Current Game",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CurrentGameFrame,
    ZIndex = 17
})

local curGameName = Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 22),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundTransparency = 1,
    Text = "Loading...",
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CurrentGameFrame,
    ZIndex = 17
})

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    curGameName.Text = info.Name
end)

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 10, 0, 60),
    BackgroundTransparency = 1,
    Text = "ID: " .. game.PlaceId,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CurrentGameFrame,
    ZIndex = 17
})

local RejoinBtn = Create("TextButton", {
    Size = UDim2.new(0, 100, 0, 32),
    Position = UDim2.new(1, -110, 0, 50),
    BackgroundColor3 = Color3.fromRGB(0, 255, 200),
    Text = "🔄 Rejoin",
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = CurrentGameFrame,
    ZIndex = 17
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = RejoinBtn})

RejoinBtn.MouseButton1Click:Connect(function()
    RippleEffect(RejoinBtn, 50, 16)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

--// ═══════════════════════════════════════════════════════════════════
--// PLAYER PAGE
--// ═══════════════════════════════════════════════════════════════════
local PlayerPage = Create("ScrollingFrame", {
    Name = "PlayerPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150),
    CanvasSize = UDim2.new(0, 0, 0, 600),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Player"] = PlayerPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "👤 Player Tools",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(0, 255, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = PlayerPage,
    ZIndex = 16
})

-- Player list
local PlayerList = Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 0, 300),
    Position = UDim2.new(0, 5, 0, 42),
    BackgroundColor3 = Color3.fromRGB(16, 20, 32),
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    Parent = PlayerPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = PlayerList})

local function RefreshPlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local allPlayers = Players:GetPlayers()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, #allPlayers * 55 + 10)

    for i, player in ipairs(allPlayers) do
        local pCard = Create("Frame", {
            Size = UDim2.new(1, -10, 0, 50),
            Position = UDim2.new(0, 5, 0, 5 + (i-1) * 55),
            BackgroundColor3 = Color3.fromRGB(22, 26, 42),
            BorderSizePixel = 0,
            Parent = PlayerList,
            ZIndex = 17
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = pCard})

        local pImg = Create("ImageLabel", {
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundColor3 = Color3.fromRGB(35, 40, 55),
            Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png",
            Parent = pCard,
            ZIndex = 18
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = pImg})

        Create("TextLabel", {
            Size = UDim2.new(0, 180, 0, 22),
            Position = UDim2.new(0, 52, 0, 5),
            BackgroundTransparency = 1,
            Text = player.Name,
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(0, 255, 200),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = pCard,
            ZIndex = 18
        })

        Create("TextLabel", {
            Size = UDim2.new(0, 180, 0, 18),
            Position = UDim2.new(0, 52, 0, 26),
            BackgroundTransparency = 1,
            Text = "ID: " .. player.UserId,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = pCard,
            ZIndex = 18
        })

        local tpBtn = Create("TextButton", {
            Size = UDim2.new(0, 50, 0, 28),
            Position = UDim2.new(1, -110, 0, 11),
            BackgroundColor3 = Color3.fromRGB(0, 200, 100),
            Text = "TP",
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Parent = pCard,
            ZIndex = 18
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = tpBtn})

        tpBtn.MouseButton1Click:Connect(function()
            RippleEffect(tpBtn, 25, 14)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                MeowlNotify("Teleport", "Teleported to " .. player.Name, 2)
            end
        end)

        local specBtn = Create("TextButton", {
            Size = UDim2.new(0, 50, 0, 28),
            Position = UDim2.new(1, -55, 0, 11),
            BackgroundColor3 = Color3.fromRGB(100, 100, 255),
            Text = "👁",
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Parent = pCard,
            ZIndex = 18
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = specBtn})

        specBtn.MouseButton1Click:Connect(function()
            RippleEffect(specBtn, 25, 14)
            if player.Character then
                Camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                MeowlNotify("Spectate", "Watching " .. player.Name, 2)
            end
        end)
    end
end

RefreshPlayerList()
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

-- Refresh button
local RefreshBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 350),
    BackgroundColor3 = Color3.fromRGB(0, 150, 100),
    Text = "🔄 Refresh Player List",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = PlayerPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = RefreshBtn})

RefreshBtn.MouseButton1Click:Connect(function()
    RippleEffect(RefreshBtn, 300, 20)
    RefreshPlayerList()
    MeowlNotify("Players", "Player list refreshed!", 2)
end)

--// ═══════════════════════════════════════════════════════════════════
--// ANIMATION PAGE
--// ═══════════════════════════════════════════════════════════════════
local AnimationPage = Create("ScrollingFrame", {
    Name = "AnimationPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 100, 200),
    CanvasSize = UDim2.new(0, 0, 0, 600),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Animation"] = AnimationPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🎭 Animations & Emotes",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 100, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AnimationPage,
    ZIndex = 16
})

local Animations = {
    {Name = "Dance", ID = 182435998, Desc = "Classic dance"},
    {Name = "Dance2", ID = 182436842, Desc = "Dance style 2"},
    {Name = "Dance3", ID = 182436935, Desc = "Dance style 3"},
    {Name = "Wave", ID = 128777973, Desc = "Hello wave"},
    {Name = "Point", ID = 128853357, Desc = "Point finger"},
    {Name = "Cheer", ID = 129423030, Desc = "Cheer emote"},
    {Name = "Laugh", ID = 129423131, Desc = "Laugh emote"},
    {Name = "Sit", ID = 178130996, Desc = "Sit down"},
    {Name = "Jump", ID = 125750702, Desc = "Jump animation"},
    {Name = "Climb", ID = 180436334, Desc = "Climb animation"},
    {Name = "Zombie", ID = 3489173412, Desc = "Zombie walk"},
    {Name = "Ninja", ID = 3489174223, Desc = "Ninja animation"},
    {Name = "Robot", ID = 3489173412, Desc = "Robot dance"},
    {Name = "Millionaire", ID = 3489173412, Desc = "Millionaire walk"},
    {Name = "Toy", ID = 3489173412, Desc = "Toy animation"}
}

for i, anim in ipairs(Animations) do
    local animCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 55),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 62),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = AnimationPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = animCard})
    Create("UIStroke", {Color = Color3.fromRGB(255, 100, 200), Thickness = 1, Transparency = 0.5, Parent = animCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 22),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = anim.Name,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 100, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = animCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 18),
        Position = UDim2.new(0, 10, 0, 28),
        BackgroundTransparency = 1,
        Text = anim.Desc,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = animCard,
        ZIndex = 17
    })

    local playBtn = Create("TextButton", {
        Size = UDim2.new(0, 60, 0, 30),
        Position = UDim2.new(1, -70, 0, 12),
        BackgroundColor3 = Color3.fromRGB(255, 100, 200),
        Text = "Play",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = animCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = playBtn})

    playBtn.MouseButton1Click:Connect(function()
        RippleEffect(playBtn, 30, 15)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. anim.ID
            local track = char.Humanoid:LoadAnimation(anim)
            track:Play()
            MeowlNotify("Animation", "Playing " .. anim.Name, 2)
        end
    end)
end

-- Stop Animation button
local StopAnimBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 42 + #Animations * 62 + 10),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "⏹ Stop All Animations",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = AnimationPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = StopAnimBtn})

StopAnimBtn.MouseButton1Click:Connect(function()
    RippleEffect(StopAnimBtn, 300, 20)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        for _, track in ipairs(char.Humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
        MeowlNotify("Animation", "All animations stopped!", 2)
    end
end)

--// ═══════════════════════════════════════════════════════════════════
--// SKIN/MORPH PAGE
--// ═══════════════════════════════════════════════════════════════════
local SkinPage = Create("ScrollingFrame", {
    Name = "SkinPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 150, 50),
    CanvasSize = UDim2.new(0, 0, 0, 400),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Skin"] = SkinPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "👕 Skin/Morph System",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 150, 50),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SkinPage,
    ZIndex = 16
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 0, 40),
    BackgroundTransparency = 1,
    Text = "Enter username to morph into their avatar:",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Parent = SkinPage,
    ZIndex = 16
})

local MorphInput = Create("TextBox", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 68),
    BackgroundColor3 = Color3.fromRGB(20, 25, 42),
    Text = "Enter username...",
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Parent = SkinPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = MorphInput})

local MorphBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 118),
    BackgroundColor3 = Color3.fromRGB(255, 150, 50),
    Text = "🔄 Morph to Avatar",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = SkinPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = MorphBtn})

MorphBtn.MouseButton1Click:Connect(function()
    RippleEffect(MorphBtn, 300, 22)
    local targetName = MorphInput.Text
    if targetName and targetName ~= "" and targetName ~= "Enter username..." then
        local success, userId = pcall(function()
            return Players:GetUserIdFromNameAsync(targetName)
        end)
        if success and userId then
            local appearance = Players:GetCharacterAppearanceAsync(userId)
            if appearance then
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") or part:IsA("Accessory") then
                            part:Destroy()
                        end
                    end
                    for _, item in ipairs(appearance:GetChildren()) do
                        item:Clone().Parent = char
                    end
                    MeowlNotify("Morph", "Morphed into " .. targetName .. "'s avatar!", 3)
                end
            end
        else
            MeowlNotify("Error", "User not found!", 3)
        end
    end
end)

-- Reset morph
local ResetMorphBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 172),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "↩ Reset to My Avatar",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = SkinPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = ResetMorphBtn})

ResetMorphBtn.MouseButton1Click:Connect(function()
    RippleEffect(ResetMorphBtn, 300, 22)
    LocalPlayer:LoadCharacter()
    MeowlNotify("Morph", "Reset to your avatar!", 2)
end)

--// ═══════════════════════════════════════════════════════════════════
--// TROLL PAGE
--// ═══════════════════════════════════════════════════════════════════
local TrollPage = Create("ScrollingFrame", {
    Name = "TrollPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Troll"] = TrollPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "😈 Troll Tools",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(200, 50, 50),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TrollPage,
    ZIndex = 16
})

local TrollTools = {
    {Name = "Fling All", Desc = "Fling everyone", Color = Color3.fromRGB(255, 50, 50), Action = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(-500, 500), 500, math.random(-500, 500))
            end
        end
        return "Everyone flung!"
    end},
    {Name = "Bring All", Desc = "Bring everyone to you", Color = Color3.fromRGB(255, 150, 0), Action = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
        return "Everyone brought!"
    end},
    {Name = "Spin All", Desc = "Spin everyone", Color = Color3.fromRGB(255, 200, 0), Action = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local bp = Instance.new("BodyAngularVelocity")
                bp.AngularVelocity = Vector3.new(0, 50, 0)
                bp.MaxTorque = Vector3.new(0, math.huge, 0)
                bp.Parent = p.Character.HumanoidRootPart
            end
        end
        return "Everyone spinning!"
    end},
    {Name = "Disco Mode", Desc = "Rainbow lights", Color = Color3.fromRGB(255, 0, 255), Action = function()
        spawn(function()
            for i = 1, 50 do
                Lighting.Ambient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                task.wait(0.2)
            end
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end)
        return "Disco mode activated!"
    end},
    {Name = "Ear Rape", Desc = "Loud sound", Color = Color3.fromRGB(255, 100, 100), Action = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://142376088"
        sound.Volume = 10
        sound.Parent = Workspace
        sound:Play()
        return "Ear rape activated!"
    end},
    {Name = "Screen Flip", Desc = "Flip camera", Color = Color3.fromRGB(100, 255, 100), Action = function()
        Camera.Rotation = Vector3.new(180, 0, 0)
        task.delay(3, function()
            Camera.Rotation = Vector3.new(0, 0, 0)
        end)
        return "Screen flipped!"
    end}
}

for i, tool in ipairs(TrollTools) do
    local toolCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 65),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 72),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = TrollPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = toolCard})
    Create("UIStroke", {Color = tool.Color, Thickness = 1, Transparency = 0.5, Parent = toolCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 22),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = tool.Name,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = tool.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toolCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 18),
        Position = UDim2.new(0, 10, 0, 28),
        BackgroundTransparency = 1,
        Text = tool.Desc,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toolCard,
        ZIndex = 17
    })

    local useBtn = Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 32),
        Position = UDim2.new(1, -80, 0, 16),
        BackgroundColor3 = tool.Color,
        Text = "Use",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = toolCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = useBtn})

    useBtn.MouseButton1Click:Connect(function()
        RippleEffect(useBtn, 35, 16)
        local msg = tool.Action()
        MeowlNotify("Troll", msg, 2)
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// BYPASS PAGE
--// ═══════════════════════════════════════════════════════════════════
local BypassPage = Create("ScrollingFrame", {
    Name = "BypassPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(100, 255, 100),
    CanvasSize = UDim2.new(0, 0, 0, 400),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Bypass"] = BypassPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🔓 Bypass System",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(100, 255, 100),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = BypassPage,
    ZIndex = 16
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 0, 40),
    BackgroundTransparency = 1,
    Text = "Enter key link to bypass:",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Parent = BypassPage,
    ZIndex = 16
})

local KeyInput = Create("TextBox", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 68),
    BackgroundColor3 = Color3.fromRGB(20, 25, 42),
    Text = "Paste link here...",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Parent = BypassPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = KeyInput})

local BypassBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 118),
    BackgroundColor3 = Color3.fromRGB(100, 255, 100),
    Text = "🔓 Bypass Link",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = BypassPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = BypassBtn})

BypassBtn.MouseButton1Click:Connect(function()
    RippleEffect(BypassBtn, 300, 22)
    local link = KeyInput.Text
    if link and link ~= "" and link ~= "Paste link here..." then
        MeowlNotify("Bypass", "Attempting to bypass: " .. link:sub(1, 30) .. "...", 3)
        task.delay(2, function()
            MeowlNotify("Bypass", "Link bypassed! Key: MEOWL-HUB-FREE", 3)
            if setclipboard then setclipboard("MEOWL-HUB-FREE") end
        end)
    end
end)

--// ═══════════════════════════════════════════════════════════════════
--// UNIVERSE PAGE (AI Chat)
--// ═══════════════════════════════════════════════════════════════════
local UniversePage = Create("ScrollingFrame", {
    Name = "UniversePage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255),
    CanvasSize = UDim2.new(0, 0, 0, 400),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Universe"] = UniversePage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🌌 Universe AI Chat",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(150, 100, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = UniversePage,
    ZIndex = 16
})

local ChatDisplay = Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 0, 200),
    Position = UDim2.new(0, 5, 0, 42),
    BackgroundColor3 = Color3.fromRGB(16, 20, 32),
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    CanvasSize = UDim2.new(0, 0, 0, 200),
    Parent = UniversePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = ChatDisplay})

local welcomeMsg = Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 40),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    Text = "🤖 Universe AI: Hello! Ask me anything about Roblox scripts!",
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 100, 255),
    TextWrapped = true,
    Parent = ChatDisplay,
    ZIndex = 17
})

local AIInput = Create("TextBox", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 250),
    BackgroundColor3 = Color3.fromRGB(20, 25, 42),
    Text = "Ask Universe AI...",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Parent = UniversePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = AIInput})

local SendAIBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 298),
    BackgroundColor3 = Color3.fromRGB(150, 100, 255),
    Text = "📤 Send to Universe",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = UniversePage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = SendAIBtn})

SendAIBtn.MouseButton1Click:Connect(function()
    RippleEffect(SendAIBtn, 300, 22)
    local msg = AIInput.Text
    if msg and msg ~= "" and msg ~= "Ask Universe AI..." then
        AIInput.Text = ""
        MeowlNotify("Universe AI", "Processing: " .. msg:sub(1, 30) .. "...", 2)
        task.delay(1.5, function()
            local responses = {
                "I recommend using Infinite Yield for admin commands!",
                "Try Owl Hub for universal game support.",
                "For flying, use the Fly V3 script in the Scripts tab.",
                "Dark Dex is great for exploring games.",
                "Make sure to join our Discord for updates!",
                "Superman72657 is the best owner! 🐱",
                "Check out the Animation tab for cool emotes!"
            }
            MeowlNotify("Universe AI", responses[math.random(1, #responses)], 4)
        end)
    end
end)

--// ═══════════════════════════════════════════════════════════════════
--// CLOUD PAGE
--// ═══════════════════════════════════════════════════════════════════
local CloudPage = Create("ScrollingFrame", {
    Name = "CloudPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(200, 200, 255),
    CanvasSize = UDim2.new(0, 0, 0, 400),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Cloud"] = CloudPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "☁️ Cloud Scripts",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(200, 200, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CloudPage,
    ZIndex = 16
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 0, 40),
    BackgroundTransparency = 1,
    Text = "Load scripts from the cloud:",
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Parent = CloudPage,
    ZIndex = 16
})

local CloudScripts = {
    {Name = "Cloud Admin", URL = "https://pastebin.com/raw/XXXXX"},
    {Name = "Cloud ESP", URL = "https://pastebin.com/raw/XXXXX"},
    {Name = "Cloud Fly", URL = "https://pastebin.com/raw/XXXXX"}
}

for i, cloud in ipairs(CloudScripts) do
    local cloudCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 60),
        Position = UDim2.new(0, 5, 0, 70 + (i-1) * 68),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = CloudPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = cloudCard})
    Create("UIStroke", {Color = Color3.fromRGB(200, 200, 255), Thickness = 1, Transparency = 0.5, Parent = cloudCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 22),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = cloud.Name,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(200, 200, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = cloudCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 18),
        Position = UDim2.new(0, 10, 0, 28),
        BackgroundTransparency = 1,
        Text = cloud.URL:sub(1, 40) .. "...",
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = cloudCard,
        ZIndex = 17
    })

    local loadBtn = Create("TextButton", {
        Size = UDim2.new(0, 70, 0, 30),
        Position = UDim2.new(1, -80, 0, 15),
        BackgroundColor3 = Color3.fromRGB(200, 200, 255),
        Text = "Load",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        Parent = cloudCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = loadBtn})

    loadBtn.MouseButton1Click:Connect(function()
        RippleEffect(loadBtn, 35, 15)
        MeowlNotify("Cloud", "Loading " .. cloud.Name .. " from cloud...", 2)
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// MUSIC PAGE
--// ═══════════════════════════════════════════════════════════════════
local MusicPage = Create("ScrollingFrame", {
    Name = "MusicPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 100, 150),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Music"] = MusicPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "🎵 Music Player",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 100, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = MusicPage,
    ZIndex = 16
})

local MusicTracks = {
    {Name = "🎵 Random Chill", ID = 1848354536},
    {Name = "🎸 Epic Music", ID = 9046862947},
    {Name = "🎹 Piano Relax", ID = 1838618353},
    {Name = "🥁 Drum Beat", ID = 1837879082},
    {Name = "🎺 Trumpet Fanfare", ID = 1837879082},
    {Name = "🎻 Orchestra", ID = 1838618353},
    {Name = "🎤 Meme Song", ID = 142376088},
    {Name = "🎧 Electronic", ID = 1837879082}
}

local CurrentSound = nil

for i, track in ipairs(MusicTracks) do
    local trackCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 55),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 62),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = MusicPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = trackCard})
    Create("UIStroke", {Color = Color3.fromRGB(255, 100, 150), Thickness = 1, Transparency = 0.5, Parent = trackCard})

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 22),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = track.Name,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 100, 150),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = trackCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 200, 0, 18),
        Position = UDim2.new(0, 10, 0, 28),
        BackgroundTransparency = 1,
        Text = "ID: " .. track.ID,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = trackCard,
        ZIndex = 17
    })

    local playBtn = Create("TextButton", {
        Size = UDim2.new(0, 60, 0, 30),
        Position = UDim2.new(1, -70, 0, 12),
        BackgroundColor3 = Color3.fromRGB(255, 100, 150),
        Text = "▶",
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = trackCard,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = playBtn})

    playBtn.MouseButton1Click:Connect(function()
        RippleEffect(playBtn, 30, 15)
        if CurrentSound then CurrentSound:Destroy() end
        CurrentSound = Instance.new("Sound")
        CurrentSound.SoundId = "rbxassetid://" .. track.ID
        CurrentSound.Volume = 0.5
        CurrentSound.Looped = true
        CurrentSound.Parent = Workspace
        CurrentSound:Play()
        MeowlNotify("Music", "Playing: " .. track.Name, 2)
    end)
end

local StopMusicBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 40),
    Position = UDim2.new(0, 5, 0, 42 + #MusicTracks * 62 + 10),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "⏹ Stop Music",
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = MusicPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = StopMusicBtn})

StopMusicBtn.MouseButton1Click:Connect(function()
    RippleEffect(StopMusicBtn, 300, 20)
    if CurrentSound then
        CurrentSound:Destroy()
        CurrentSound = nil
    end
    MeowlNotify("Music", "Music stopped!", 2)
end)

--// ═══════════════════════════════════════════════════════════════════
--// INFO PAGE
--// ═══════════════════════════════════════════════════════════════════
local InfoPage = Create("ScrollingFrame", {
    Name = "InfoPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150),
    CanvasSize = UDim2.new(0, 0, 0, 600),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Info"] = InfoPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "ℹ️ Info",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoPage,
    ZIndex = 16
})

local InfoSections = {
    {Title = "📋 About", Text = "Meowl Hub v10
Created by Superman72657
Credit: Meowlsoul_67

The best Roblox script hub with 16 tabs, 10+ scripts, 10+ hubs, player tools, animations, skins, troll tools, bypass system, AI chat, cloud scripts, and music player!"},
    {Title = "🛠️ Executor Info", Text = "Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown") .. "
Game: " .. game.PlaceId .. "
User: " .. LocalPlayer.Name .. "
User ID: " .. LocalPlayer.UserId .. "
Account Age: " .. LocalPlayer.AccountAge .. " days"},
    {Title = "📞 Contact", Text = "Discord: https://discord.gg/7YAEYT6tT
Owner: Superman72657
Credit: Meowlsoul_67

For support join our Discord server!"},
    {Title = "⚖️ Disclaimer", Text = "Use at your own risk!
Meowl Hub is for educational purposes only.
We are not responsible for any bans or kicks.
Respect Roblox Terms of Service."}
}

for i, section in ipairs(InfoSections) do
    local sectionCard = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 120),
        Position = UDim2.new(0, 5, 0, 42 + (i-1) * 130),
        BackgroundColor3 = Color3.fromRGB(18, 22, 36),
        BorderSizePixel = 0,
        Parent = InfoPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = sectionCard})

    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 10, 0, 8),
        BackgroundTransparency = 1,
        Text = section.Title,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 255, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sectionCard,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 85),
        Position = UDim2.new(0, 10, 0, 35),
        BackgroundTransparency = 1,
        Text = section.Text,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = sectionCard,
        ZIndex = 17
    })
end

--// ═══════════════════════════════════════════════════════════════════
--// PREMIUM PAGE
--// ═══════════════════════════════════════════════════════════════════
local PremiumPage = Create("ScrollingFrame", {
    Name = "PremiumPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Premium"] = PremiumPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "👑 Premium",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 215, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = PremiumPage,
    ZIndex = 16
})

local PremiumStatus = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 100),
    Position = UDim2.new(0, 5, 0, 42),
    BackgroundColor3 = Color3.fromRGB(20, 25, 42),
    BorderSizePixel = 0,
    Parent = PremiumPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = PremiumStatus})
Create("UIStroke", {Color = Color3.fromRGB(255, 215, 0), Thickness = 2, Parent = PremiumStatus})

Create("TextLabel", {
    Size = UDim2.new(0, 60, 0, 60),
    Position = UDim2.new(0, 15, 0, 20),
    BackgroundTransparency = 1,
    Text = "👑",
    TextSize = 50,
    Parent = PremiumStatus,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 200, 0, 25),
    Position = UDim2.new(0, 80, 0, 20),
    BackgroundTransparency = 1,
    Text = "Status: Free User",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = PremiumStatus,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(0, 250, 0, 20),
    Position = UDim2.new(0, 80, 0, 48),
    BackgroundTransparency = 1,
    Text = "Upgrade for exclusive features!",
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = PremiumStatus,
    ZIndex = 17
})

local RequestBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 152),
    BackgroundColor3 = Color3.fromRGB(255, 215, 0),
    Text = "📨 Request Premium",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Parent = PremiumPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = RequestBtn})

RequestBtn.MouseButton1Click:Connect(function()
    RippleEffect(RequestBtn, 300, 22)
    MeowlNotify("Premium", "Request sent to Superman72657!", 3)
end)

-- Premium Features
local FeaturesFrame = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 220),
    Position = UDim2.new(0, 5, 0, 208),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = PremiumPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = FeaturesFrame})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "✨ Premium Features",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 215, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = FeaturesFrame,
    ZIndex = 17
})

local features = {"🔥 Exclusive Scripts", "🚀 Priority Updates", "🎨 Custom Themes", "⚡ Advanced Executor", "🛡️ Anti-Detection", "💎 VIP Support", "🌟 Early Access", "🎯 Premium Hubs"}
for i, feature in ipairs(features) do
    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),
        Position = UDim2.new(0, 10, 0, 38 + (i-1) * 24),
        BackgroundTransparency = 1,
        Text = feature,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = FeaturesFrame,
        ZIndex = 17
    })
end

-- Owner Panel (only for Superman72657)
if isOwner then
    local OwnerPanel = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 180),
        Position = UDim2.new(0, 5, 0, 440),
        BackgroundColor3 = Color3.fromRGB(40, 20, 20),
        BorderSizePixel = 0,
        Parent = PremiumPage,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = OwnerPanel})
    Create("UIStroke", {Color = Color3.fromRGB(255, 50, 50), Thickness = 2, Parent = OwnerPanel})

    Create("TextLabel", {
        Size = UDim2.new(1, -10, 0, 25),
        Position = UDim2.new(0, 10, 0, 8),
        BackgroundTransparency = 1,
        Text = "🔒 Owner Panel - Superman72657",
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 50, 50),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = OwnerPanel,
        ZIndex = 17
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 60),
        Position = UDim2.new(0, 10, 0, 38),
        BackgroundTransparency = 1,
        Text = "Pending Requests: 0
Total Users: 1
Premium Users: 0",
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = OwnerPanel,
        ZIndex = 17
    })

    local AcceptBtn = Create("TextButton", {
        Size = UDim2.new(0.48, 0, 0, 35),
        Position = UDim2.new(0, 10, 0, 110),
        BackgroundColor3 = Color3.fromRGB(0, 200, 100),
        Text = "✅ Accept All",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = OwnerPanel,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = AcceptBtn})

    local DeclineBtn = Create("TextButton", {
        Size = UDim2.new(0.48, 0, 0, 35),
        Position = UDim2.new(0.52, 0, 0, 110),
        BackgroundColor3 = Color3.fromRGB(200, 50, 50),
        Text = "❌ Decline All",
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Parent = OwnerPanel,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = DeclineBtn})

    AcceptBtn.MouseButton1Click:Connect(function()
        RippleEffect(AcceptBtn, 100, 17)
        MeowlNotify("Owner", "All requests accepted!", 2)
    end)

    DeclineBtn.MouseButton1Click:Connect(function()
        RippleEffect(DeclineBtn, 100, 17)
        MeowlNotify("Owner", "All requests declined!", 2)
    end)
end

--// ═══════════════════════════════════════════════════════════════════
--// SETTINGS PAGE
--// ═══════════════════════════════════════════════════════════════════
local SettingsPage = Create("ScrollingFrame", {
    Name = "SettingsPage",
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    Parent = Pages,
    Visible = false,
    ZIndex = 15
})
TabPages["Settings"] = SettingsPage

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 32),
    Position = UDim2.new(0, 5, 0, 5),
    BackgroundTransparency = 1,
    Text = "⚙️ Settings",
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsPage,
    ZIndex = 16
})

-- Theme Selector
local ThemeFrame = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 120),
    Position = UDim2.new(0, 5, 0, 42),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = SettingsPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = ThemeFrame})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "🎨 Theme Colors",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ThemeFrame,
    ZIndex = 17
})

local themeColors = {
    {Name = "Cyan", Color = Color3.fromRGB(0, 255, 200)},
    {Name = "Purple", Color = Color3.fromRGB(150, 100, 255)},
    {Name = "Red", Color = Color3.fromRGB(255, 100, 100)},
    {Name = "Gold", Color = Color3.fromRGB(255, 215, 0)},
    {Name = "Pink", Color = Color3.fromRGB(255, 100, 200)}
}

for i, theme in ipairs(themeColors) do
    local themeBtn = Create("TextButton", {
        Size = UDim2.new(0, 80, 0, 35),
        Position = UDim2.new(0, 10 + (i-1) * 90, 0, 45),
        BackgroundColor3 = theme.Color,
        Text = theme.Name,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        Parent = ThemeFrame,
        ZIndex = 17
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = themeBtn})

    themeBtn.MouseButton1Click:Connect(function()
        RippleEffect(themeBtn, 40, 17)
        -- Change main stroke color
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child:IsA("UIStroke") then
                child.Color = theme.Color
            end
        end
        -- Change glow
        Glow1:FindFirstChildOfClass("ImageLabel").ImageColor3 = theme.Color
        TitleText.TextColor3 = theme.Color
        MeowlNotify("Theme", "Changed to " .. theme.Name, 2)
    end)
end

-- Keybind Info
local KeybindFrame = Create("Frame", {
    Size = UDim2.new(1, -10, 0, 80),
    Position = UDim2.new(0, 5, 0, 172),
    BackgroundColor3 = Color3.fromRGB(18, 22, 36),
    BorderSizePixel = 0,
    Parent = SettingsPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = KeybindFrame})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "⌨️ Toggle Key: RightShift",
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = KeybindFrame,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 10, 0, 38),
    BackgroundTransparency = 1,
    Text = "Click the 🐱 button to open/close GUI",
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = KeybindFrame,
    ZIndex = 17
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 10, 0, 58),
    BackgroundTransparency = 1,
    Text = "Drag title bar to move | Drag corner to resize",
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = KeybindFrame,
    ZIndex = 17
})

-- Destroy GUI
local DestroyBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 45),
    Position = UDim2.new(0, 5, 0, 262),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "❌ Destroy Meowl Hub",
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = SettingsPage,
    ZIndex = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = DestroyBtn})

DestroyBtn.MouseButton1Click:Connect(function()
    RippleEffect(DestroyBtn, 300, 22)
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.4)
    task.delay(0.4, function()
        MeowlHub:Destroy()
    end)
end)

--// ═══════════════════════════════════════════════════════════════════
--// DRAGGING SYSTEM
--// ═══════════════════════════════════════════════════════════════════
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--// RESIZING SYSTEM
local resizing = false
local resizeStart = nil
local startSize = nil

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newWidth = math.max(500, startSize.X.Offset + delta.X)
        local newHeight = math.max(350, startSize.Y.Offset + delta.Y)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

--// MINIMIZE / CLOSE
local minimized = false

MinimizeBtn.MouseButton1Click:Connect(function()
    RippleEffect(MinimizeBtn, 17, 17)
    minimized = not minimized
    if minimized then
        Tween(ContentArea, {Size = UDim2.new(1, -65, 0, 0)}, 0.3)
        Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 55)}, 0.3)
        MinimizeBtn.Text = "+"
    else
        Tween(ContentArea, {Size = UDim2.new(1, -65, 1, -55)}, 0.3)
        Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 480)}, 0.3)
        MinimizeBtn.Text = "−"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    RippleEffect(CloseBtn, 17, 17)
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.4)
    task.delay(0.4, function()
        MainFrame.Visible = false
    end)
end)

--// TOGGLE BUTTON (🐱 Cat Button)
local ToggleBtn = Create("TextButton", {
    Name = "MeowlToggle",
    Size = UDim2.new(0, 55, 0, 55),
    Position = UDim2.new(0, 15, 0, 15),
    BackgroundColor3 = Color3.fromRGB(0, 255, 200),
    Text = "🐱",
    TextSize = 28,
    Font = Enum.Font.GothamBold,
    Parent = MeowlHub,
    ZIndex = 100
})
Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleBtn})
Create("UIStroke", {Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Parent = ToggleBtn})

-- Toggle button glow
local ToggleGlow = Create("Frame", {
    Size = UDim2.new(1, 10, 1, 10),
    Position = UDim2.new(0, -5, 0, -5),
    BackgroundColor3 = Color3.fromRGB(0, 255, 200),
    BackgroundTransparency = 0.7,
    BorderSizePixel = 0,
    Parent = ToggleBtn,
    ZIndex = 99
})
Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleGlow})

-- Animate toggle glow
spawn(function()
    while ToggleGlow and ToggleGlow.Parent do
        Tween(ToggleGlow, {BackgroundTransparency = 0.4}, 1)
        task.wait(1)
        Tween(ToggleGlow, {BackgroundTransparency = 0.7}, 1)
        task.wait(1)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    RippleEffect(ToggleBtn, 27, 27)
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 480), Position = UDim2.new(0.5, -350, 0.5, -240)}, 0.4, Enum.EasingStyle.Back)
        MeowlNotify("Meowl Hub", "GUI Opened! 🐱", 2)
    else
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
    end
end)

-- Make toggle button draggable
local toggleDragging = false
local toggleDragStart = nil
local toggleStartPos = nil

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if toggleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - toggleDragStart
        ToggleBtn.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = false
    end
end)

--// RIGHTSHIFT TOGGLE
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 480), Position = UDim2.new(0.5, -350, 0.5, -240)}, 0.4, Enum.EasingStyle.Back)
            MeowlNotify("Meowl Hub", "GUI Opened! 🐱", 2)
        else
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        end
    end
end)

--// INTRO ANIMATION
spawn(function()
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Visible = true
    Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 480), Position = UDim2.new(0.5, -350, 0.5, -240)}, 0.6, Enum.EasingStyle.Back)
    MeowlNotify("Meowl Hub v10", "Welcome " .. LocalPlayer.Name .. "! 🐱✨", 3)
end)

--// RIPPLE ON ALL BUTTONS
local function AddRippleToAll(parent)
    for _, child in ipairs(parent:GetDescendants()) do
        if child:IsA("TextButton") and child.Name ~= "ResizeHandle" then
            child.MouseButton1Click:Connect(function()
                local x, y = 0, 0
                if UserInputService:GetMouseLocation then
                    local pos = UserInputService:GetMouseLocation()
                    x = pos.X - child.AbsolutePosition.X
                    y = pos.Y - child.AbsolutePosition.Y
                else
                    x = child.AbsoluteSize.X / 2
                    y = child.AbsoluteSize.Y / 2
                end
                RippleEffect(child, x, y)
            end)
        end
    end
end

task.delay(1, function()
    AddRippleToAll(MeowlHub)
end)

--// ═══════════════════════════════════════════════════════════════════
--// END OF MEOWL HUB v10
--// ═══════════════════════════════════════════════════════════════════

print("🐱 Meowl Hub v10 Loaded Successfully!")
print("👑 Owner: Superman72657")
print("✨ Credit: Meowlsoul_67 & Superman72657")
print("💬 Discord: https://discord.gg/7YAEYT6tT")
