local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Configuration
local CAMERA_OFFSET = Vector3.new(2, 0.5, 0) -- Right: 2, Up: 0.5
local DEFAULT_FOV = 70
local ZOOMED_FOV = 45
local ZOOM_SPEED = 0.15

-- State
local isZooming = false
local targetFOV = DEFAULT_FOV

-- Input handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isZooming = true
		targetFOV = ZOOMED_FOV
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isZooming = false
		targetFOV = DEFAULT_FOV
	end
end)

local function updateCamera()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			-- Apply the offset to the Humanoid's camera settings
			humanoid.CameraOffset = humanoid.CameraOffset:Lerp(CAMERA_OFFSET, 0.1)
		end
	end
	
	-- Smooth FOV transition
	camera.FieldOfView = camera.FieldOfView + (targetFOV - camera.FieldOfView) * ZOOM_SPEED
end

-- Connect to RenderStepped to ensure smooth updates every frame
RunService.RenderStepped:Connect(updateCamera)
