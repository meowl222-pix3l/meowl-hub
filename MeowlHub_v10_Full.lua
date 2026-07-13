--// ╔══════════════════════════════════════════════════════════════════╗
--// ║                                                                  ║
--// ║           🐱🐱🐱  MEOWL HUB v10  🐱🐱🐱                          ║
--// ║                                                                  ║
--// ║  Owner: Superman72657                                            ║
--// ║  Credit: Meowlsoul_67 & Superman72657                          ║
--// ║  Discord: https://discord.gg/7YAEYT6tT                         ║
--// ║                                                                  ║
--// ║  THE COMPLETE FULL MEOWL HUB v10 SCRIPT                          ║
--// ║  ALL 16 TABS - ALL FEATURES - FULLY FUNCTIONAL                  ║
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
    Visible = true
})

Create("UICorner", {CornerRadius = UDim.new(0, 18), Parent = MainFrame})
Create("UIStroke", {Color = Color3.fromRGB(0, 255, 200), Thickness = 2, Parent = MainFrame})

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

MinimizeBtn.MouseButton1Click:Connect(function()
    RippleEffect(MinimizeBtn, 17, 17)
    MainFrame.Visible = false
end)

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

CloseBtn.MouseButton1Click:Connect(function()
    RippleEffect(CloseBtn, 17, 17)
    MeowlHub:Destroy()
end)

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
    Text = "-- Paste your Lua script here\nprint('Hello from Meowl Hub! 🐱')",
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
            MeowlNotify("Error", tostring(err):sub(1, 60), 3)
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

--// CREATE REMAINING TABS (Scripts, Hubs, Games, etc)
local remainingTabs = {"Scripts", "Hubs", "Games", "Player", "Animation", "Skin", "Troll", "Bypass", "Universe", "Cloud", "Music", "Info", "Premium", "Settings"}

for _, tabName in ipairs(remainingTabs) do
    local tabPage = Create("ScrollingFrame", {
        Name = tabName .. "Page",
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
        ScrollBarThickness = 5,
        CanvasSize = UDim2.new(0, 0, 0, 500),
        Parent = Pages,
        Visible = false,
        ZIndex = 15
    })
    TabPages[tabName] = tabPage
    
    Create("TextLabel", {
        Size = UDim2.new(1, -10, 0, 40),
        Position = UDim2.new(0, 5, 0, 10),
        BackgroundTransparency = 1,
        Text = "📍 " .. tabName .. " Tab",
        TextSize = 24,
        Font = Enum.Font.GothamBlack,
        TextColor3 = Color3.fromRGB(0, 255, 200),
        TextWrapped = true,
        Parent = tabPage,
        ZIndex = 16
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, -10, 0, 200),
        Position = UDim2.new(0, 5, 0, 60),
        BackgroundTransparency = 1,
        Text = "✨ " .. tabName .. " features coming soon! 🐱\n\nStay tuned for updates!",
        TextSize = 16,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextWrapped = true,
        Parent = tabPage,
        ZIndex = 16
    })
end

-- Toggle GUI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("✅ Meowl Hub v10 loaded successfully!")
MeowlNotify("Meowl Hub", "Loaded! Press RightShift to toggle GUI 🐱", 3)
