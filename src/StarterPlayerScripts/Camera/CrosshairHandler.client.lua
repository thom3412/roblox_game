local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Create Crosshair UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CrosshairGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local circle = Instance.new("Frame")
circle.Name = "AimCircle"
circle.Size = UDim2.new(0, 40, 0, 40) -- 40x40 pixels
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Position = UDim2.new(0.5, 0, 0.5, 0)
circle.BackgroundColor3 = Color3.new(1, 1, 1)
circle.BackgroundTransparency = 1 -- Only show outline
circle.Visible = true -- Visible but transparent initially
circle.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0) -- Perfect circle
corner.Parent = circle

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(1, 1, 1) -- White outline
stroke.Transparency = 1 -- Start fully invisible
stroke.Parent = circle

-- Tweens
local fadeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fadeIn = TweenService:Create(stroke, fadeInfo, {Transparency = 0.2})
local fadeOut = TweenService:Create(stroke, fadeInfo, {Transparency = 1})

-- 2. Mouse Locking
local function updateMouseBehavior()
	UserInputService.MouseIconEnabled = false
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

RunService.RenderStepped:Connect(updateMouseBehavior)
updateMouseBehavior()

-- 3. Handle Input for Crosshair Visibility
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		fadeIn:Play()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		fadeOut:Play()
	end
end)
