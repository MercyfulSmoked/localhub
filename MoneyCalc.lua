-- Made by Local
local gui = Instance.new("ScreenGui")
gui.Name = "ProfitTracker"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Name = "ProfitFrame"
frame.Size = UDim2.new(0, 250, 0, 80)
frame.AnchorPoint = Vector2.new(0.5, 1)
frame.Position = UDim2.new(0.5, 0, 1, -125)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = gui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))}
uiGradient.Rotation = 90
uiGradient.Parent = frame

local profitLabel = Instance.new("TextLabel")
profitLabel.Name = "ProfitLabel"
profitLabel.Size = UDim2.new(1, 0, 0.5, 0)
profitLabel.Font = Enum.Font.GothamBold
profitLabel.TextSize = 24
profitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
profitLabel.TextStrokeTransparency = 0.5
profitLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
profitLabel.BackgroundTransparency = 1
profitLabel.Text = "Profit: $0"
profitLabel.Parent = frame

local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
timeLabel.Position = UDim2.new(0, 0, 0.5, 0)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 20
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.TextStrokeTransparency = 0.5
timeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Elapsed Time: 00:00:00"
timeLabel.Parent = frame

local profitShadow = Instance.new("TextLabel")
profitShadow.Name = "ProfitShadow"
profitShadow.Size = UDim2.new(1, 0, 0.5, 0)
profitShadow.Font = Enum.Font.GothamBold
profitShadow.TextSize = 24
profitShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
profitShadow.TextTransparency = 0.8
profitShadow.BackgroundTransparency = 1
profitShadow.Text = "Profit: $0"
profitShadow.Position = UDim2.new(0, 2, 0, 2)
profitShadow.Parent = profitLabel

local timeShadow = Instance.new("TextLabel")
timeShadow.Name = "TimeShadow"
timeShadow.Size = UDim2.new(1, 0, 0.5, 0)
timeShadow.Font = Enum.Font.GothamBold
timeShadow.TextSize = 20
timeShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
timeShadow.TextTransparency = 0.8
timeShadow.BackgroundTransparency = 1
timeShadow.Text = "Elapsed Time: 00:00:00"
timeShadow.Position = UDim2.new(0, 2, 0, 2) 
timeShadow.Parent = timeLabel

local player = game.Players.LocalPlayer
local moneyGui = player.PlayerGui:FindFirstChild("MainScreenGui", true)
local initialMoney = 0
local currentMoney = 0

if moneyGui and moneyGui:FindFirstChild("MoneyText") then
    local moneyTextParts = moneyGui.MoneyText.Text:split("$")
    initialMoney = moneyTextParts[2]:gsub(",", "")
    initialMoney = tonumber(initialMoney)
end

local function formatNumber(amount)
    local formatted = tostring(amount)
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function formatTime(seconds)
    local hrs = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hrs, mins, secs)
end

local startTime = tick()

while true do
    wait(0.1)
    local elapsedTime = tick() - startTime
    local moneyTextParts = moneyGui.MoneyText.Text:split("$")
    currentMoney = moneyTextParts[2]:gsub(",", "")
    currentMoney = tonumber(currentMoney)
    local profit = currentMoney - initialMoney
    profitLabel.Text = "Profit: $" .. formatNumber(profit)
    profitShadow.Text = profitLabel.Text
    timeLabel.Text = "Elapsed Time: " .. formatTime(math.floor(elapsedTime))
    timeShadow.Text = timeLabel.Text
end
