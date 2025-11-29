local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Configuration
local OFFSET_X = 2.5      -- Right offset (Camera to right -> Character to left)
local OFFSET_Y = 2        -- Up offset
local OFFSET_Z = 8        -- Distance behind
local ZOOMED_Z = 4        -- Distance when zoomed
local ZOOMED_FOV = 60     -- Less zoom (was 50)
local DEFAULT_FOV = 70
local LERP_SPEED = 0.2

-- State
local cameraAngleX = 0   -- Pitch (Up/Down)
local cameraAngleY = 0   -- Yaw (Left/Right)
local isZooming = false
local currentFov = DEFAULT_FOV
local currentZ = OFFSET_Z

-- Setup
camera.CameraType = Enum.CameraType.Scriptable
UserInputService.MouseIconEnabled = false
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

-- Input Handling
UserInputService.InputChanged:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Delta
		-- Adjust sensitivity here
		local sensitivity = 0.005
		
		cameraAngleY = cameraAngleY - delta.X * sensitivity
		cameraAngleX = cameraAngleX - delta.Y * sensitivity
		
		-- Clamp pitch to avoid flipping
		cameraAngleX = math.clamp(cameraAngleX, math.rad(-80), math.rad(80))
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isZooming = true
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		isZooming = false
	end
end)

local function updateCamera()
	local character = player.Character
	if not character then return end
	
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	
	-- 1. Handle Zoom State
	local targetFov = isZooming and ZOOMED_FOV or DEFAULT_FOV
	local targetZ = isZooming and ZOOMED_Z or OFFSET_Z
	
	currentFov = currentFov + (targetFov - currentFov) * LERP_SPEED
	currentZ = currentZ + (targetZ - currentZ) * LERP_SPEED
	
	camera.FieldOfView = currentFov
	
	-- 2. Calculate Camera Rotation & Position
	-- We rotate around the character's position
	local startCFrame = CFrame.new(rootPart.Position + Vector3.new(0, OFFSET_Y, 0))
	local rotationCFrame = CFrame.Angles(0, cameraAngleY, 0) * CFrame.Angles(cameraAngleX, 0, 0)
	
	-- Offset is applied in Camera Space
	-- Positive X moves camera Right -> Character appears Left
	-- Positive Z moves camera Back
	local finalOffset = Vector3.new(OFFSET_X, 0, currentZ)
	local cameraCFrame = startCFrame * rotationCFrame * CFrame.new(finalOffset)
	
	camera.CFrame = cameraCFrame
	
	-- 3. Character Rotation on Zoom
	-- If zooming, character must face the camera's look direction (yaw only)
	if isZooming then
		-- Create a new CFrame at root position, looking at the horizon direction of camera
		local lookDir = rotationCFrame.LookVector
		local lookAt = rootPart.Position + Vector3.new(lookDir.X, 0, lookDir.Z)
		
		-- Smoothly rotate character or instant? User asked for "se retourner" (turn around)
		-- Instant rotation for responsiveness
		rootPart.CFrame = CFrame.lookAt(rootPart.Position, lookAt)
	end
end

RunService.RenderStepped:Connect(updateCamera)
