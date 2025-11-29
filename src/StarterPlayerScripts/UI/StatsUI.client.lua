local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Constants
local BAR_WIDTH = 200
local BAR_HEIGHT = 20
local PADDING = 5

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StatsGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "StatsFrame"
mainFrame.Size = UDim2.new(0, BAR_WIDTH + 20, 0, (BAR_HEIGHT + PADDING) * 3 + 20)
mainFrame.Position = UDim2.new(0, 20, 1, -20)
mainFrame.AnchorPoint = Vector2.new(0, 1)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local function CreateBar(name, color, order)
	local container = Instance.new("Frame")
	container.Name = name .. "Container"
	container.Size = UDim2.new(1, -20, 0, BAR_HEIGHT)
	container.Position = UDim2.new(0, 10, 0, 10 + (order - 1) * (BAR_HEIGHT + PADDING))
	container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	container.BorderSizePixel = 0
	container.Parent = mainFrame
	
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = color
	fill.BorderSizePixel = 0
	fill.Parent = container
	
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, -10, 1, 0)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.ZIndex = 2
	label.Parent = container
	
	return fill
end

local healthBar = CreateBar("Health", Color3.fromRGB(231, 76, 60), 1)
local hungerBar = CreateBar("Hunger", Color3.fromRGB(230, 126, 34), 2)
local thirstBar = CreateBar("Thirst", Color3.fromRGB(52, 152, 219), 3)

local warningLabel = Instance.new("TextLabel")
warningLabel.Name = "Warning"
warningLabel.Size = UDim2.new(1, 0, 0, 20)
warningLabel.Position = UDim2.new(0, 0, 0, -25)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "STARVING!"
warningLabel.TextColor3 = Color3.fromRGB(231, 76, 60)
warningLabel.TextStrokeTransparency = 0
warningLabel.Font = Enum.Font.GothamBlack
warningLabel.TextSize = 18
warningLabel.Visible = false
warningLabel.Parent = mainFrame

-- Update Function
local function UpdateStats(stats)
	-- Tween bars
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	TweenService:Create(healthBar, tweenInfo, {Size = UDim2.new(stats.Health / 100, 0, 1, 0)}):Play()
	TweenService:Create(hungerBar, tweenInfo, {Size = UDim2.new(stats.Hunger / 100, 0, 1, 0)}):Play()
	TweenService:Create(thirstBar, tweenInfo, {Size = UDim2.new(stats.Thirst / 100, 0, 1, 0)}):Play()
	
	-- Warnings
	if stats.Hunger < 20 then
		warningLabel.Text = "STARVING!"
		warningLabel.Visible = true
	elseif stats.Thirst < 20 then
		warningLabel.Text = "THIRSTY!"
		warningLabel.Visible = true
	elseif stats.Health < 20 then
		warningLabel.Text = "LOW HEALTH!"
		warningLabel.Visible = true
	else
		warningLabel.Visible = false
	end
end

-- Listen for updates
local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local updateStatsEvent = eventsFolder:WaitForChild("UpdateStats", 10)

if updateStatsEvent then
	updateStatsEvent.OnClientEvent:Connect(UpdateStats)
else
	warn("⚠️ StatsUI: Could not find UpdateStats event!")
end

print("📊 StatsUI: Ready!")
