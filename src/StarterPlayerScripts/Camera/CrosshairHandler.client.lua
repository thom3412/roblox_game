local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local CROSSHAIR_SIZE = 4
local CROSSHAIR_COLOR = Color3.new(1, 1, 1) -- White
local CROSSHAIR_TRANSPARENCY = 0.5

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CrosshairGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local crosshairFrame = Instance.new("Frame")
crosshairFrame.Name = "Crosshair"
crosshairFrame.Size = UDim2.new(0, CROSSHAIR_SIZE, 0, CROSSHAIR_SIZE)
crosshairFrame.AnchorPoint = Vector2.new(0.5, 0.5)
crosshairFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
crosshairFrame.BackgroundColor3 = CROSSHAIR_COLOR
crosshairFrame.BackgroundTransparency = 0 -- Solid center
crosshairFrame.BorderSizePixel = 0
crosshairFrame.Parent = screenGui

-- Add a slight outline or transparency for better visibility
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0) -- Circle
corner.Parent = crosshairFrame

-- Mouse Handling
local function updateMouseBehavior()
	UserInputService.MouseIconEnabled = false
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

-- Connect to RenderStepped to enforce mouse behavior
RunService.RenderStepped:Connect(updateMouseBehavior)

-- Initial setup
updateMouseBehavior()
