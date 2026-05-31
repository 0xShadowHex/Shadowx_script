local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("ShadowX") then
    playerGui.ShadowX:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShadowX"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local isMobile = UserInputService.TouchEnabled
local autoSpeed = 100  
local REQUIRED_KEY = "key_J7mQ2xV9aL4pN8rT1wK6cY3uH5dE0"

local function stroke(parent, color, thickness)
    local s = Instance.new("UIStroke", parent)
    s.Color = color or Color3.fromRGB(120, 80, 200)
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local function corner(parent, radius)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, radius or 8)
    return c
end

local function getTime()
    return os.date("%H:%M:%S")
end

local panelSize
local fontSizeScale = isMobile and 0.8 or 1
local buttonHeight = isMobile and 36 or 28
local titleBarHeight = isMobile and 44 or 52
local footerHeight = isMobile and 44 or 50

if isMobile then
    panelSize = UDim2.new(0.9, 0, 0.7, 0)
else
    panelSize = UDim2.new(0, 760, 0, 520)
end

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = panelSize
panel.Position = UDim2.new(0.5, -panelSize.X.Offset/2, 0.5, -panelSize.Y.Offset/2)
if isMobile then
    panel.Position = UDim2.new(0.05, 0, 0.15, 0)
end
panel.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
panel.BorderSizePixel = 0
panel.Visible = false
panel.ClipsDescendants = true
panel.Parent = screenGui
corner(panel, 12)
stroke(panel, Color3.fromRGB(150, 80, 255), 1.5)

local panelGradient = Instance.new("UIGradient")
panelGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 9, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 4, 16))
})
panelGradient.Rotation = 45
panelGradient.Parent = panel

local keyWindow = Instance.new("Frame")
keyWindow.Name = "KeySystem"
keyWindow.Size = UDim2.new(0, 360, 0, 240)
keyWindow.Position = UDim2.new(0.5, -180, 0.5, -120)
keyWindow.BackgroundColor3 = Color3.fromRGB(12, 6, 24)
keyWindow.BorderSizePixel = 0
keyWindow.ClipsDescendants = true
keyWindow.Parent = screenGui
corner(keyWindow, 14)
stroke(keyWindow, Color3.fromRGB(160, 90, 255), 1.5)

local keyGradient = Instance.new("UIGradient")
keyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 11, 44)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
})
keyGradient.Rotation = 45
keyGradient.Parent = keyWindow

local keyTitleText = Instance.new("TextLabel")
keyTitleText.Size = UDim2.new(1, 0, 0, 50)
keyTitleText.Position = UDim2.new(0, 0, 0, 10)
keyTitleText.BackgroundTransparency = 1
keyTitleText.Text = "ShadowX Authenticator"
keyTitleText.TextColor3 = Color3.fromRGB(230, 200, 255)
keyTitleText.TextSize = 18
keyTitleText.Font = Enum.Font.GothamBold
keyTitleText.Parent = keyWindow

local keySubText = Instance.new("TextLabel")
keySubText.Size = UDim2.new(1, 0, 0, 20)
keySubText.Position = UDim2.new(0, 0, 0, 55)
keySubText.BackgroundTransparency = 1
keySubText.Text = "Please enter your security key below"
keySubText.TextColor3 = Color3.fromRGB(150, 120, 190)
keySubText.TextSize = 11
keySubText.Font = Enum.Font.Gotham
keySubText.Parent = keyWindow

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 280, 0, 42)
keyBox.Position = UDim2.new(0.5, -140, 0, 90)
keyBox.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
keyBox.Text = ""
keyBox.PlaceholderText = "Paste key here..."
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 80, 130)
keyBox.TextColor3 = Color3.fromRGB(240, 220, 255)
keyBox.TextSize = 12
keyBox.Font = Enum.Font.Code
keyBox.BorderSizePixel = 0
keyBox.ClipsDescendants = true
keyBox.Parent = keyWindow
corner(keyBox, 8)
stroke(keyBox, Color3.fromRGB(100, 60, 160), 1)

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 130, 0, 36)
verifyBtn.Position = UDim2.new(0.5, -140, 0, 155)
verifyBtn.BackgroundColor3 = Color3.fromRGB(130, 60, 220)
verifyBtn.Text = "Verify Key"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.TextSize = 13
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = keyWindow
corner(verifyBtn, 8)
stroke(verifyBtn, Color3.fromRGB(180, 110, 255), 1)

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0, 130, 0, 36)
getKeyBtn.Position = UDim2.new(0.5, 10, 0, 155)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 55)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(180, 150, 220)
getKeyBtn.TextSize = 13
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Parent = keyWindow
corner(getKeyBtn, 8)
stroke(getKeyBtn, Color3.fromRGB(80, 40, 120), 1)

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 20)
infoLabel.Position = UDim2.new(0, 0, 0, 205)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Status: Awaiting verification..."
infoLabel.TextColor3 = Color3.fromRGB(130, 100, 160)
infoLabel.TextSize = 10
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = keyWindow

local function bindHoverEffect(btn, activeColor, inactiveColor, strokeActive, strokeInactive)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = activeColor}):Play()
        if strokeActive then
            local str = btn:FindFirstChildOfClass("UIStroke")
            if str then TweenService:Create(str, TweenInfo.new(0.2), {Color = strokeActive}):Play() end
        end
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = inactiveColor}):Play()
        if strokeInactive then
            local str = btn:FindFirstChildOfClass("UIStroke")
            if str then TweenService:Create(str, TweenInfo.new(0.2), {Color = strokeInactive}):Play() end
        end
    end)
end

bindHoverEffect(verifyBtn, Color3.fromRGB(150, 70, 250), Color3.fromRGB(130, 60, 220), Color3.fromRGB(200, 140, 255), Color3.fromRGB(180, 110, 255))
bindHoverEffect(getKeyBtn, Color3.fromRGB(45, 22, 80), Color3.fromRGB(30, 15, 55), Color3.fromRGB(80, 40, 120), Color3.fromRGB(80, 40, 120))

local keyDragging = false
local keyDragStart, keyStartPos
keyWindow.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        keyDragging = true
        keyDragStart = input.Position
        keyStartPos = keyWindow.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if keyDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - keyDragStart
        keyWindow.Position = UDim2.new(keyStartPos.X.Scale, keyStartPos.X.Offset + delta.X, keyStartPos.Y.Scale, keyStartPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        keyDragging = false
    end
end)

getKeyBtn.MouseButton1Click:Connect(function()
    pcall(setclipboard, "https://discord.gg/BwFNhUHNjC")
    infoLabel.Text = "Key link copied to clipboard!"
    infoLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    task.wait(2)
    if infoLabel.Parent then
        infoLabel.Text = "Status: Awaiting verification..."
        infoLabel.TextColor3 = Color3.fromRGB(130, 100, 160)
    end
end)

local function unlockScript()
    infoLabel.Text = "Access Granted! Welcome to ShadowX."
    infoLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    TweenService:Create(keyBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(10, 40, 30)}):Play()
    local strokeB = keyBox:FindFirstChildOfClass("UIStroke")
    if strokeB then TweenService:Create(strokeB, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 255, 170)}):Play() end
    
    task.wait(0.6)
    
    local fadeOutInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(keyWindow, fadeOutInfo, {Size = UDim2.new(0, 360, 0, 0), Position = UDim2.new(0.5, -180, 0.5, 0)}):Play()
    
    task.wait(0.4)
    keyWindow:Destroy()
    
    panel.Visible = true
    local originalSize = panel.Size
    panel.Size = UDim2.new(0, 0, 0, 0)
    
    local popInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(panel, popInfo, {Size = originalSize}):Play()
end

verifyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == REQUIRED_KEY then
        unlockScript()
    else
        infoLabel.Text = "Access Denied! Invalid Key."
        infoLabel.TextColor3 = Color3.fromRGB(255, 80, 120)
        
        local initialPos = keyWindow.Position
        local shakeForce = 8
        task.spawn(function()
            for i = 1, 6 do
                local offset = (i % 2 == 0) and shakeForce or -shakeForce
                keyWindow.Position = UDim2.new(initialPos.X.Scale, initialPos.X.Offset + offset, initialPos.Y.Scale, initialPos.Y.Offset)
                task.wait(0.04)
            end
            keyWindow.Position = initialPos
        end)
        
        local oldBg = keyBox.BackgroundColor3
        local strokeBox = keyBox:FindFirstChildOfClass("UIStroke")
        local oldStroke = strokeBox and strokeBox.Color
        
        TweenService:Create(keyBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 15, 30)}):Play()
        if strokeBox then TweenService:Create(strokeBox, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 80, 120)}):Play() end
        
        task.wait(1.5)
        
        if keyBox.Parent then
            TweenService:Create(keyBox, TweenInfo.new(0.3), {BackgroundColor3 = oldBg}):Play()
            if strokeBox then TweenService:Create(strokeBox, TweenInfo.new(0.3), {Color = oldStroke}):Play() end
            infoLabel.Text = "Status: Awaiting verification..."
            infoLabel.TextColor3 = Color3.fromRGB(130, 100, 160)
        end
    end
end)

local resizing = false
if not isMobile then
    local resizeHandle = Instance.new("Frame")
    resizeHandle.Name = "ResizeHandle"
    resizeHandle.Size = UDim2.new(0, 16, 0, 16)
    resizeHandle.Position = UDim2.new(1, -16, 1, -16)
    resizeHandle.AnchorPoint = Vector2.new(1, 1)
    resizeHandle.BackgroundColor3 = Color3.fromRGB(140, 70, 220)
    resizeHandle.BorderSizePixel = 0
    resizeHandle.Parent = panel
    corner(resizeHandle, 999)
    stroke(resizeHandle, Color3.fromRGB(200, 120, 255), 1.5)

    local resizeStartPos, startSize
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStartPos = input.Position
            startSize = panel.AbsoluteSize
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStartPos
            local newWidth = math.clamp(startSize.X + delta.X, 450, 1200)
            local newHeight = math.clamp(startSize.Y + delta.Y, 350, 800)
            panel.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)
end

local dragging = false
local dragStart, startPos

local function onInputBegan(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not resizing then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end

local function onInputChanged(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, titleBarHeight)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = panel
corner(titleBar, 12)

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 40))
})
titleGrad.Parent = titleBar

local titleFill = Instance.new("Frame")
titleFill.Size = UDim2.new(1, 0, 0, 18)
titleFill.Position = UDim2.new(0, 0, 1, -18)
titleFill.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
titleFill.BorderSizePixel = 0
titleFill.ZIndex = titleBar.ZIndex + 1
titleFill.Parent = titleBar

titleBar.InputBegan:Connect(onInputBegan)
UserInputService.InputChanged:Connect(onInputChanged)
UserInputService.InputEnded:Connect(onInputEnded)

local liveDot = Instance.new("Frame")
liveDot.Size = UDim2.new(0, 9, 0, 9)
liveDot.Position = UDim2.new(0, 20, 0.5, -4)
liveDot.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
liveDot.BorderSizePixel = 0
liveDot.ZIndex = titleBar.ZIndex + 2
liveDot.Parent = titleBar
corner(liveDot, 999)

local liveLabel = Instance.new("TextLabel")
liveLabel.Size = UDim2.new(0, 50, 0, 20)
liveLabel.Position = UDim2.new(0, 34, 0.5, -10)
liveLabel.BackgroundTransparency = 1
liveLabel.Text = "LIVE"
liveLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
liveLabel.TextSize = 11 * fontSizeScale
liveLabel.Font = Enum.Font.GothamBold
liveLabel.TextXAlignment = Enum.TextXAlignment.Left
liveLabel.ZIndex = titleBar.ZIndex + 2
liveLabel.Parent = titleBar

task.spawn(function()
    while screenGui.Parent do
        TweenService:Create(liveDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0,11,0,11), Position = UDim2.new(0,19,0.5,-5)}):Play()
        task.wait(1)
        TweenService:Create(liveDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0,9,0,9), Position = UDim2.new(0,20,0.5,-4)}):Play()
        task.wait(1)
    end
end)

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0.5, -100, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ShadowX"
titleText.TextColor3 = Color3.fromRGB(220, 180, 255)
titleText.TextSize = 16 * fontSizeScale
titleText.Font = Enum.Font.GothamBold
titleText.ZIndex = titleBar.ZIndex + 2
titleText.Parent = titleBar

local logArea = Instance.new("ScrollingFrame")
logArea.Name = "LogArea"
logArea.Size = UDim2.new(1, -16, 1, -(titleBarHeight + footerHeight + 16))
logArea.Position = UDim2.new(0, 8, 0, titleBarHeight + 8)
logArea.BackgroundTransparency = 1
logArea.BorderSizePixel = 0
logArea.ScrollBarThickness = isMobile and 6 or 4
logArea.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 220)
logArea.CanvasSize = UDim2.new(0, 0, 0, 0)
logArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
logArea.Parent = panel

local listLayout = Instance.new("UIListLayout", logArea)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, isMobile and 10 or 8)
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local logPad = Instance.new("UIPadding", logArea)
logPad.PaddingTop = UDim.new(0, 4)
logPad.PaddingBottom = UDim.new(0, 4)
logPad.PaddingLeft = UDim.new(0, 4)
logPad.PaddingRight = UDim.new(0, 4)

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, footerHeight)
footer.Position = UDim2.new(0, 0, 1, -footerHeight)
footer.BackgroundColor3 = Color3.fromRGB(25, 12, 45)
footer.BorderSizePixel = 0
footer.Parent = panel
corner(footer, 12)

local footerGrad = Instance.new("UIGradient")
footerGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 12, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 8, 30))
})
footerGrad.Parent = footer

local footerFill = Instance.new("Frame")
footerFill.Size = UDim2.new(1, 0, 0, 18)
footerFill.BackgroundColor3 = Color3.fromRGB(25, 12, 45)
footerFill.BorderSizePixel = 0
footerFill.Parent = footer

local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(0, 200, 1, 0)
countLabel.Position = UDim2.new(0, 20, 0, 0)
countLabel.BackgroundTransparency = 1
countLabel.Text = "0 events captured"
countLabel.TextColor3 = Color3.fromRGB(190, 160, 230)
countLabel.TextSize = 12 * fontSizeScale
countLabel.Font = Enum.Font.GothamMedium
countLabel.TextXAlignment = Enum.TextXAlignment.Left
countLabel.ZIndex = footer.ZIndex + 1
countLabel.Parent = footer

local settingsBtn = Instance.new("TextButton")
settingsBtn.Size = UDim2.new(0, 56, 0, buttonHeight)
settingsBtn.Position = UDim2.new(1, -90, 0.5, -buttonHeight/2)
settingsBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 65)
settingsBtn.Text = "SET"
settingsBtn.TextColor3 = Color3.fromRGB(200, 170, 250)
settingsBtn.TextSize = 11 * fontSizeScale
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.BorderSizePixel = 0
settingsBtn.ZIndex = footer.ZIndex + 1
settingsBtn.Parent = footer
corner(settingsBtn, 8)
stroke(settingsBtn, Color3.fromRGB(140, 90, 200), 1)

local stopAllBtn = Instance.new("TextButton")
stopAllBtn.Size = UDim2.new(0, 86, 0, buttonHeight)
stopAllBtn.Position = UDim2.new(1, -186, 0.5, -buttonHeight/2)
stopAllBtn.BackgroundColor3 = Color3.fromRGB(70, 20, 55)
stopAllBtn.Text = "Stop All"
stopAllBtn.TextColor3 = Color3.fromRGB(240, 130, 190)
stopAllBtn.TextSize = 11 * fontSizeScale
stopAllBtn.Font = Enum.Font.GothamBold
stopAllBtn.BorderSizePixel = 0
stopAllBtn.ZIndex = footer.ZIndex + 1
stopAllBtn.Parent = footer
corner(stopAllBtn, 8)
stroke(stopAllBtn, Color3.fromRGB(170, 70, 130), 1)

bindHoverEffect(settingsBtn, Color3.fromRGB(60, 30, 90), Color3.fromRGB(45, 20, 65), Color3.fromRGB(230, 200, 255), Color3.fromRGB(140, 90, 200))
bindHoverEffect(stopAllBtn, Color3.fromRGB(90, 30, 70), Color3.fromRGB(70, 20, 55), Color3.fromRGB(255, 160, 210), Color3.fromRGB(170, 70, 130))

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -8, 0, 8)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 25, 45)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 120, 150)
closeBtn.TextSize = 13 * fontSizeScale
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 10
closeBtn.Parent = panel
corner(closeBtn, 999)
stroke(closeBtn, Color3.fromRGB(180, 50, 100), 1)

bindHoverEffect(closeBtn, Color3.fromRGB(110, 35, 60), Color3.fromRGB(80, 25, 45), Color3.fromRGB(255, 150, 180), Color3.fromRGB(180, 50, 100))

local settingsWindow = nil
local function toggleSettings()
    if settingsWindow then
        
        local inst = settingsWindow
        TweenService:Create(inst, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 320, 0, 0), Position = UDim2.new(0.5, -160, 0.5, 0)}):Play()
        task.wait(0.25)
        if settingsWindow == inst then
            inst:Destroy()
            settingsWindow = nil
        end
    else
        settingsWindow = Instance.new("Frame")
        settingsWindow.Name = "SettingsWindow"
        settingsWindow.Size = UDim2.new(0, 320, 0, 220)
        settingsWindow.Position = UDim2.new(0.5, -160, 0.5, -110)
        settingsWindow.BackgroundColor3 = Color3.fromRGB(16, 8, 30)
        settingsWindow.BorderSizePixel = 0
        settingsWindow.ZIndex = 50
        settingsWindow.Parent = screenGui
        corner(settingsWindow, 12)
        stroke(settingsWindow, Color3.fromRGB(140, 80, 220), 1.5)

        local settingsGrad = Instance.new("UIGradient")
        settingsGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 12, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 6, 22))
        })
        settingsGrad.Rotation = 45
        settingsGrad.Parent = settingsWindow

        local settingsTitleBar = Instance.new("Frame")
        settingsTitleBar.Size = UDim2.new(1, 0, 0, 44)
        settingsTitleBar.BackgroundColor3 = Color3.fromRGB(35, 18, 60)
        settingsTitleBar.BorderSizePixel = 0
        settingsTitleBar.ZIndex = 51
        settingsTitleBar.Parent = settingsWindow
        corner(settingsTitleBar, 12)

        local sTitleGrad = Instance.new("UIGradient")
        sTitleGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 20, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 15, 55))
        })
        sTitleGrad.Parent = settingsTitleBar

        local settingsTitle = Instance.new("TextLabel")
        settingsTitle.Size = UDim2.new(1, -40, 1, 0)
        settingsTitle.Position = UDim2.new(0, 16, 0, 0)
        settingsTitle.BackgroundTransparency = 1
        settingsTitle.Text = "Settings"
        settingsTitle.TextColor3 = Color3.fromRGB(230, 200, 255)
        settingsTitle.TextSize = 14
        settingsTitle.Font = Enum.Font.GothamBold
        settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
        settingsTitle.ZIndex = 52
        settingsTitle.Parent = settingsTitleBar

        local closeSettingsBtn = Instance.new("TextButton")
        closeSettingsBtn.Size = UDim2.new(0, 26, 0, 26)
        closeSettingsBtn.Position = UDim2.new(1, -34, 0.5, -13)
        closeSettingsBtn.BackgroundColor3 = Color3.fromRGB(80, 25, 45)
        closeSettingsBtn.Text = "✕"
        closeSettingsBtn.TextColor3 = Color3.fromRGB(255, 120, 150)
        closeSettingsBtn.TextSize = 11
        closeSettingsBtn.Font = Enum.Font.GothamBold
        closeSettingsBtn.BorderSizePixel = 0
        closeSettingsBtn.ZIndex = 52
        closeSettingsBtn.Parent = settingsTitleBar
        corner(closeSettingsBtn, 999)
        stroke(closeSettingsBtn, Color3.fromRGB(180, 50, 100), 1)

        bindHoverEffect(closeSettingsBtn, Color3.fromRGB(110, 35, 60), Color3.fromRGB(80, 25, 45), Color3.fromRGB(255, 150, 180), Color3.fromRGB(180, 50, 100))

        closeSettingsBtn.MouseButton1Click:Connect(toggleSettings)

        local dragStartPos, dragStartMouse
        local draggingSettings = false
        settingsTitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSettings = true
                dragStartPos = settingsWindow.Position
                dragStartMouse = input.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if draggingSettings and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStartMouse
                settingsWindow.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSettings = false
            end
        end)

        local speedLabel = Instance.new("TextLabel")
        speedLabel.Size = UDim2.new(0, 140, 0, 30)
        speedLabel.Position = UDim2.new(0, 20, 0, 65)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "Signals per second:"
        speedLabel.TextColor3 = Color3.fromRGB(200, 170, 240)
        speedLabel.TextSize = 12
        speedLabel.Font = Enum.Font.GothamSemibold
        speedLabel.TextXAlignment = Enum.TextXAlignment.Left
        speedLabel.ZIndex = 51
        speedLabel.Parent = settingsWindow

        local speedBox = Instance.new("TextBox")
        speedBox.Size = UDim2.new(0, 100, 0, 30)
        speedBox.Position = UDim2.new(0, 190, 0, 65)
        speedBox.BackgroundColor3 = Color3.fromRGB(28, 14, 50)
        speedBox.Text = tostring(autoSpeed)
        speedBox.TextColor3 = Color3.fromRGB(230, 200, 255)
        speedBox.TextSize = 12
        speedBox.Font = Enum.Font.Code
        speedBox.BorderSizePixel = 0
        speedBox.ZIndex = 51
        speedBox.Parent = settingsWindow
        corner(speedBox, 6)
        stroke(speedBox, Color3.fromRGB(120, 80, 180), 1)

        local speedHint = Instance.new("TextLabel")
        speedHint.Size = UDim2.new(0, 280, 0, 20)
        speedHint.Position = UDim2.new(0, 20, 0, 105)
        speedHint.BackgroundTransparency = 1
        speedHint.Text = "Min: 1  •  Max: 10000  •  Default: 100"
        speedHint.TextColor3 = Color3.fromRGB(160, 130, 210)
        speedHint.TextSize = 10
        speedHint.Font = Enum.Font.Gotham
        speedHint.TextXAlignment = Enum.TextXAlignment.Left
        speedHint.ZIndex = 51
        speedHint.Parent = settingsWindow

        local saveBtn = Instance.new("TextButton")
        saveBtn.Size = UDim2.new(0, 110, 0, 32)
        saveBtn.Position = UDim2.new(0.5, -55, 1, -55)
        saveBtn.BackgroundColor3 = Color3.fromRGB(50, 25, 75)
        saveBtn.Text = "Save Changes"
        saveBtn.TextColor3 = Color3.fromRGB(200, 120, 255)
        saveBtn.TextSize = 12
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.BorderSizePixel = 0
        saveBtn.ZIndex = 51
        saveBtn.Parent = settingsWindow
        corner(saveBtn, 8)
        stroke(saveBtn, Color3.fromRGB(140, 80, 220), 1)

        bindHoverEffect(saveBtn, Color3.fromRGB(70, 35, 105), Color3.fromRGB(50, 25, 75), Color3.fromRGB(230, 160, 255), Color3.fromRGB(140, 80, 220))

        local savedMsg = nil
        saveBtn.MouseButton1Click:Connect(function()
            local newSpeed = tonumber(speedBox.Text)
            if newSpeed then
                newSpeed = math.floor(newSpeed)
                if newSpeed >= 1 and newSpeed <= 10000 then
                    autoSpeed = newSpeed
                    speedBox.Text = tostring(autoSpeed)
                    
                    local strBox = speedBox:FindFirstChildOfClass("UIStroke")
                    local oldStrColor = strBox and strBox.Color
                    TweenService:Create(speedBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 45, 30)}):Play()
                    if strBox then TweenService:Create(strBox, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 255, 170)}):Play() end
                    
                    if savedMsg then savedMsg:Destroy() end
                    savedMsg = Instance.new("TextLabel")
                    savedMsg.Size = UDim2.new(0, 100, 0, 20)
                    savedMsg.Position = UDim2.new(0.5, -50, 1, -22)
                    savedMsg.BackgroundTransparency = 1
                    savedMsg.Text = "Successfully Saved!"
                    savedMsg.TextColor3 = Color3.fromRGB(0, 255, 170)
                    savedMsg.TextSize = 10
                    savedMsg.Font = Enum.Font.GothamBold
                    savedMsg.ZIndex = 52
                    savedMsg.Parent = settingsWindow
                    
                    task.spawn(function()
                        task.wait(1.5)
                        if speedBox.Parent then
                            TweenService:Create(speedBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(28, 14, 50)}):Play()
                            if strBox then TweenService:Create(strBox, TweenInfo.new(0.3), {Color = oldStrColor}):Play() end
                        end
                        if savedMsg then savedMsg:Destroy() end
                    end)
                else
                    local strBox = speedBox:FindFirstChildOfClass("UIStroke")
                    local oldBg = speedBox.BackgroundColor3
                    local oldStrColor = strBox and strBox.Color
                    TweenService:Create(speedBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 20, 35)}):Play()
                    if strBox then TweenService:Create(strBox, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 80, 120)}):Play() end
                    task.wait(0.6)
                    TweenService:Create(speedBox, TweenInfo.new(0.3), {BackgroundColor3 = oldBg}):Play()
                    if strBox then TweenService:Create(strBox, TweenInfo.new(0.3), {Color = oldStrColor}):Play() end
                end
            else
                local strBox = speedBox:FindFirstChildOfClass("UIStroke")
                local oldBg = speedBox.BackgroundColor3
                local oldStrColor = strBox and strBox.Color
                TweenService:Create(speedBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 20, 35)}):Play()
                if strBox then TweenService:Create(strBox, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 80, 120)}):Play() end
                task.wait(0.6)
                TweenService:Create(speedBox, TweenInfo.new(0.3), {BackgroundColor3 = oldBg}):Play()
                if strBox then TweenService:Create(strBox, TweenInfo.new(0.3), {Color = oldStrColor}):Play() end
            end
        end)
        
        settingsWindow.Size = UDim2.new(0, 320, 0, 0)
        settingsWindow.Position = UDim2.new(0.5, -160, 0.5, 0)
        TweenService:Create(settingsWindow, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 320, 0, 220), Position = UDim2.new(0.5, -160, 0.5, -110)}):Play()
    end
end

settingsBtn.MouseButton1Click:Connect(toggleSettings)

local uiVisible = true
local reopenButton = nil

local function showGui()
    if not screenGui.Enabled then
        screenGui.Enabled = true
        uiVisible = true
        if reopenButton then reopenButton.Visible = false end
        panel.Size = UDim2.new(0, 0, 0, 0)
        panel.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = panelSize, Position = UDim2.new(0.5, -panelSize.X.Offset/2, 0.5, -panelSize.Y.Offset/2)}):Play()
    end
end

local function hideGui()
    if screenGui.Enabled then
        uiVisible = false
        local panelT = TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
        panelT:Play()
        panelT.Completed:Connect(function()
            if not uiVisible then
                screenGui.Enabled = false
            end
        end)

        if isMobile then
            if not reopenButton or not reopenButton.Parent then
                reopenButton = Instance.new("TextButton")
                reopenButton.Size = UDim2.new(0, 56, 0, 56)
                reopenButton.Position = UDim2.new(1, -70, 1, -70)
                reopenButton.AnchorPoint = Vector2.new(1, 1)
                reopenButton.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
                reopenButton.Text = "S"
                reopenButton.TextColor3 = Color3.fromRGB(230, 190, 255)
                reopenButton.TextSize = 24
                reopenButton.Font = Enum.Font.GothamBold
                reopenButton.BorderSizePixel = 0
                reopenButton.ZIndex = 100
                reopenButton.Parent = playerGui
                corner(reopenButton, 28)
                stroke(reopenButton, Color3.fromRGB(150, 90, 230), 1.5)

                bindHoverEffect(reopenButton, Color3.fromRGB(70, 30, 110), Color3.fromRGB(50, 20, 80), Color3.fromRGB(200, 140, 255), Color3.fromRGB(150, 90, 230))

                local dragStartPos, dragStartMouse
                reopenButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragStartPos = reopenButton.Position
                        dragStartMouse = input.Position
                        local moveConn, endConn
                        moveConn = UserInputService.InputChanged:Connect(function(input2)
                            if input2.UserInputType == input.UserInputType then
                                local delta = input2.Position - dragStartMouse
                                reopenButton.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
                            end
                        end)
                        endConn = UserInputService.InputEnded:Connect(function(input2)
                            if input2.UserInputType == input.UserInputType then
                                moveConn:Disconnect()
                                endConn:Disconnect()
                            end
                        end)
                    end
                end)

                reopenButton.MouseButton1Click:Connect(showGui)
            else
                reopenButton.Visible = true
            end
        end
    end
end

closeBtn.MouseButton1Click:Connect(hideGui)

if not isMobile then
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            if uiVisible then hideGui() else showGui() end
        end
    end)
end

-- Log management
local eventCount = 0
local entries = {}
local suppressCounter = 0

local function fireFakeSignal(signalType, id)
    suppressCounter = suppressCounter + 1
    pcall(function()
        if signalType == "Product" then
            MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, id, true)
        elseif signalType == "Gamepass" then
            MarketplaceService:SignalPromptGamePassPurchaseFinished(player, id, true)
        elseif signalType == "Bulk" then
            MarketplaceService:SignalPromptBulkPurchaseFinished(player.UserId, id, true)
        elseif signalType == "Purchase" then
            MarketplaceService:SignalPromptPurchaseFinished(player.UserId, id, true)
        end
    end)
    suppressCounter = suppressCounter - 1
end

local function makeEmptyLabel()
    local el = Instance.new("TextLabel")
    el.Name = "EmptyState"
    el.Size = UDim2.new(1, 0, 0, 260)
    el.BackgroundTransparency = 1
    el.Text = "Waiting for events…\nAll marketplace events will appear here."
    el.TextColor3 = Color3.fromRGB(150, 120, 200)
    el.TextSize = 13 * fontSizeScale
    el.Font = Enum.Font.GothamMedium
    el.TextWrapped = true
    el.LayoutOrder = 99999
    el.Parent = logArea
    return el
end

local function setEmpty(show)
    local e = logArea:FindFirstChild("EmptyState")
    if show and not e then
        makeEmptyLabel()
    elseif not show and e then
        e:Destroy()
    end
end

local activeAutoButtons = {}
local activeSpamButtons = {}

local function stopAllAutoAndSpam()
    for btn, data in pairs(activeAutoButtons) do
        data.active = false
        if data.loop then task.cancel(data.loop) end
        if btn and btn.Parent then
            btn.Text = "Auto"
            btn.TextColor3 = Color3.fromRGB(190, 150, 240)
            btn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
            local str = btn:FindFirstChildOfClass("UIStroke")
            if str then str.Color = Color3.fromRGB(120, 80, 180) end
        end
    end
    table.clear(activeAutoButtons)
    for btn, data in pairs(activeSpamButtons) do
        data.active = false
        if data.loop then task.cancel(data.loop) end
        if btn and btn.Parent then
            btn.Text = "Run"
            btn.TextColor3 = Color3.fromRGB(190, 150, 240)
            btn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
            local str = btn:FindFirstChildOfClass("UIStroke")
            if str then str.Color = Color3.fromRGB(120, 80, 180) end
        end
    end
    table.clear(activeSpamButtons)
end

stopAllBtn.MouseButton1Click:Connect(stopAllAutoAndSpam)

local function addLog(label, id, signalType)
    if suppressCounter > 0 then return end
    setEmpty(false)
    local entryHeight = isMobile and 56 or 48
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, -2, 0, entryHeight)
    entry.BackgroundColor3 = Color3.fromRGB(24, 12, 45)
    entry.BorderSizePixel = 0
    entry.LayoutOrder = -(eventCount)
    entry.Parent = logArea
    corner(entry, 10)
    stroke(entry, Color3.fromRGB(100, 60, 150), 1)
    
    local logGrad = Instance.new("UIGradient")
    logGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 14, 52)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 9, 36))
    })
    logGrad.Parent = entry

    entry.Size = UDim2.new(1, -2, 0, 0)
    entry.BackgroundTransparency = 1
    TweenService:Create(entry, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, -2, 0, entryHeight),
        BackgroundTransparency = 0
    }):Play()

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 14, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
    dot.BorderSizePixel = 0
    dot.Parent = entry
    corner(dot, 999)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 76, 1, 0)
    lbl.Position = UDim2.new(0, 28, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(label)
    lbl.TextColor3 = Color3.fromRGB(200, 160, 250)
    lbl.TextSize = 10 * fontSizeScale
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = entry

    local idEl = Instance.new("TextLabel")
    idEl.Size = UDim2.new(0, 180, 1, 0)
    idEl.Position = UDim2.new(0, 108, 0, 0)
    idEl.BackgroundTransparency = 1
    idEl.Text = tostring(id)
    idEl.TextColor3 = Color3.fromRGB(230, 215, 255)
    idEl.TextSize = 13 * fontSizeScale
    idEl.Font = Enum.Font.Code
    idEl.TextXAlignment = Enum.TextXAlignment.Left
    idEl.TextTruncate = Enum.TextTruncate.AtEnd
    idEl.Parent = entry

    local timeEl = Instance.new("TextLabel")
    timeEl.Size = UDim2.new(0, 70, 1, 0)
    timeEl.Position = UDim2.new(0, 298, 0, 0)
    timeEl.BackgroundTransparency = 1
    timeEl.Text = getTime()
    timeEl.TextColor3 = Color3.fromRGB(160, 130, 210)
    timeEl.TextSize = 11 * fontSizeScale
    timeEl.Font = Enum.Font.GothamMedium
    timeEl.Parent = entry

    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(0, 210, 1, 0)
    buttonFrame.Position = UDim2.new(1, -218, 0, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = entry

    local horizontalLayout = Instance.new("UIListLayout")
    horizontalLayout.FillDirection = Enum.FillDirection.Horizontal
    horizontalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    horizontalLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    horizontalLayout.Padding = UDim.new(0, 8)
    horizontalLayout.Parent = buttonFrame

    local autoBtn = Instance.new("TextButton")
    autoBtn.Size = UDim2.new(0, 60, 0, buttonHeight)
    autoBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
    autoBtn.Text = "Auto"
    autoBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
    autoBtn.TextSize = 11 * fontSizeScale
    autoBtn.Font = Enum.Font.GothamBold
    autoBtn.BorderSizePixel = 0
    autoBtn.Parent = buttonFrame
    corner(autoBtn, 8)
    stroke(autoBtn, Color3.fromRGB(120, 80, 180), 1)

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 60, 0, buttonHeight)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
    copyBtn.Text = "Copy"
    copyBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
    copyBtn.TextSize = 11 * fontSizeScale
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.BorderSizePixel = 0
    copyBtn.Parent = buttonFrame
    corner(copyBtn, 8)
    stroke(copyBtn, Color3.fromRGB(120, 80, 180), 1)

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(0, 56, 0, buttonHeight)
    runBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
    runBtn.Text = "Run"
    runBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
    runBtn.TextSize = 11 * fontSizeScale
    runBtn.Font = Enum.Font.GothamBold
    runBtn.BorderSizePixel = 0
    runBtn.Parent = buttonFrame
    corner(runBtn, 8)
    stroke(runBtn, Color3.fromRGB(120, 80, 180), 1)

    bindHoverEffect(copyBtn, Color3.fromRGB(55, 25, 80), Color3.fromRGB(40, 20, 60), Color3.fromRGB(220, 180, 255), Color3.fromRGB(120, 80, 180))
    bindHoverEffect(autoBtn, Color3.fromRGB(55, 25, 80), Color3.fromRGB(40, 20, 60), Color3.fromRGB(220, 180, 255), Color3.fromRGB(120, 80, 180))
    bindHoverEffect(runBtn, Color3.fromRGB(55, 25, 80), Color3.fromRGB(40, 20, 60), Color3.fromRGB(220, 180, 255), Color3.fromRGB(120, 80, 180))

    copyBtn.MouseButton1Click:Connect(function()
        pcall(setclipboard, tostring(id))
        copyBtn.Text = "Copied!"
        copyBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
        local str = copyBtn:FindFirstChildOfClass("UIStroke")
        if str then str.Color = Color3.fromRGB(0, 255, 170) end
        
        task.wait(1.5)
        
        if copyBtn.Parent then
            copyBtn.Text = "Copy"
            copyBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
            if str then str.Color = Color3.fromRGB(120, 80, 180) end
        end
    end)

    local autoActive = false
    local autoLoop = nil
    local function startAuto()
        if autoActive then return end
        autoActive = true
        autoBtn.Text = "Auto ON"
        autoBtn.TextColor3 = Color3.fromRGB(255, 120, 200)
        autoBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 80)
        local str = autoBtn:FindFirstChildOfClass("UIStroke")
        if str then str.Color = Color3.fromRGB(255, 120, 200) end
        
        autoLoop = task.spawn(function()
            local delay = autoSpeed > 0 and (1 / autoSpeed) or 0.01
            while autoActive and autoBtn.Parent do
                fireFakeSignal(signalType, id)
                task.wait(delay)
            end
        end)
        activeAutoButtons[autoBtn] = {active = true, loop = autoLoop}
    end
    local function stopAuto()
        autoActive = false
        if autoLoop then task.cancel(autoLoop) end
        activeAutoButtons[autoBtn] = nil
        if autoBtn.Parent then
            autoBtn.Text = "Auto"
            autoBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
            autoBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
            local str = autoBtn:FindFirstChildOfClass("UIStroke")
            if str then str.Color = Color3.fromRGB(120, 80, 180) end
        end
    end
    autoBtn.MouseButton1Click:Connect(function()
        if autoActive then stopAuto() else startAuto() end
    end)

    local holdStart = nil
    local holdConnection = nil
    local spamLoop = nil
    local isSpamming = false
    local function startSpam()
        if isSpamming then return end
        isSpamming = true
        runBtn.Text = "Spamming"
        runBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
        local str = runBtn:FindFirstChildOfClass("UIStroke")
        if str then str.Color = Color3.fromRGB(255, 200, 100) end
        
        spamLoop = task.spawn(function()
            while isSpamming and runBtn.Parent do
                fireFakeSignal(signalType, id)
                task.wait(0.1)
            end
        end)
        activeSpamButtons[runBtn] = {active = true, loop = spamLoop}
    end
    local function stopSpam()
        isSpamming = false
        if spamLoop then task.cancel(spamLoop) end
        activeSpamButtons[runBtn] = nil
        if runBtn.Parent then
            runBtn.Text = "Run"
            runBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
            runBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
            local str = runBtn:FindFirstChildOfClass("UIStroke")
            if str then str.Color = Color3.fromRGB(120, 80, 180) end
        end
    end

    local function onRunPress()
        if isSpamming then return end
        holdStart = tick()
        holdConnection = task.spawn(function()
            while holdStart and (tick() - holdStart) < 3 do
                task.wait(0.1)
            end
            if holdStart and not isSpamming then
                startSpam()
            end
        end)
    end

    local function onRunRelease()
        local heldDuration = holdStart and (tick() - holdStart) or 0
        holdStart = nil
        if holdConnection then task.cancel(holdConnection) end
        if isSpamming then
            stopSpam()
        elseif heldDuration < 3 then
            fireFakeSignal(signalType, id)
            runBtn.Text = "Sent!"
            runBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
            local str = runBtn:FindFirstChildOfClass("UIStroke")
            if str then str.Color = Color3.fromRGB(0, 255, 170) end
            
            task.spawn(function()
                task.wait(1.5)
                if runBtn.Parent and not isSpamming then
                    runBtn.Text = "Run"
                    runBtn.TextColor3 = Color3.fromRGB(190, 150, 240)
                    if str then str.Color = Color3.fromRGB(120, 80, 180) end
                end
            end)
        end
    end

    runBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            onRunPress()
        end
    end)
    runBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            onRunRelease()
        end
    end)

    entry.AncestryChanged:Connect(function()
        if not entry.Parent then
            if autoActive then stopAuto() end
            if isSpamming then stopSpam() end
            for i, e in ipairs(entries) do
                if e == entry then
                    table.remove(entries, i)
                    break
                end
            end
        end
    end)

    eventCount = eventCount + 1
    countLabel.Text = eventCount .. (eventCount == 1 and " event captured" or " events captured")
    table.insert(entries, entry)
end

MarketplaceService.PromptProductPurchaseFinished:Connect(function(plr, id, bought)
    if suppressCounter == 0 then addLog("Product", id, "Product") end
end)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(plr, id, bought)
    if suppressCounter == 0 then addLog("Gamepass", id, "Gamepass") end
end)
MarketplaceService.PromptBulkPurchaseFinished:Connect(function(userId, id, bought)
    if suppressCounter == 0 then addLog("Bulk", id, "Bulk") end
end)
MarketplaceService.PromptPurchaseFinished:Connect(function(userId, id, bought)
    if suppressCounter == 0 then addLog("Purchase", id, "Purchase") end
end)

setEmpty(true)
