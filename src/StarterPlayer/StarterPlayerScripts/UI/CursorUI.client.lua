local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Cursor UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CursorGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true -- Same as CrosshairGui for alignment
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Cursor Dot (Center of screen)
local cursorDot = Instance.new("Frame")
cursorDot.Name = "CursorDot"
cursorDot.Size = UDim2.new(0, 6, 0, 6) -- Small dot
cursorDot.Position = UDim2.new(0.5, 0, 0.5, 0)
cursorDot.AnchorPoint = Vector2.new(0.5, 0.5)
cursorDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cursorDot.BorderSizePixel = 0
cursorDot.ZIndex = 10
cursorDot.Parent = screenGui

-- Make it circular
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = cursorDot

-- Add subtle outline for visibility
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Thickness = 1
stroke.Transparency = 0.5
stroke.Parent = cursorDot

-- Track right-click state
local isRightClickHeld = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isRightClickHeld = true
		cursorDot.Visible = false -- Hide dot when aiming
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isRightClickHeld = false
		cursorDot.Visible = true -- Show dot when not aiming
	end
end)

print("🎯 Cursor UI: Ready!")
