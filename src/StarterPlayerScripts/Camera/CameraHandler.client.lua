local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Configuration
local CAMERA_OFFSET = Vector3.new(2, 0.5, 0) -- Right: 2, Up: 0.5

local function updateCamera()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			-- Apply the offset to the Humanoid's camera settings
			-- This shifts the camera relative to the character without breaking standard controls
			humanoid.CameraOffset = humanoid.CameraOffset:Lerp(CAMERA_OFFSET, 0.1)
		end
	end
end

-- Connect to RenderStepped to ensure smooth updates every frame
RunService.RenderStepped:Connect(updateCamera)
