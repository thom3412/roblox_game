local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI Elements
local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui", 10)
if not screenGui then
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ScreenGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player.PlayerGui
end

local promptLabel = screenGui:FindFirstChild("InteractionPrompt")
if not promptLabel then
	promptLabel = Instance.new("TextLabel")
	promptLabel.Name = "InteractionPrompt"
	promptLabel.Size = UDim2.new(0, 300, 0, 50)
	promptLabel.Position = UDim2.new(0.5, -150, 0.7, 0)
	promptLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	promptLabel.BackgroundTransparency = 0.5
	promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	promptLabel.TextSize = 20
	promptLabel.Font = Enum.Font.GothamBold
	promptLabel.Text = ""
	promptLabel.Visible = false
	promptLabel.Parent = screenGui
end

-- Interaction settings
local RAYCAST_DISTANCE = 100 -- Long range for camera ray
local INTERACTION_RANGE = 15 -- Max distance from character to item
local currentTarget = nil

-- Remote Events
local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local pickupEvent = eventsFolder:WaitForChild("PickupItem", 10)

if not pickupEvent then
	warn("⚠️ InteractionController: PickupItem event not found!")
	return
end

print("🎯 InteractionController: Ready!")

-- Raycast from camera center
local function CheckForInteractable()
	local rayOrigin = camera.CFrame.Position
	local rayDirection = camera.CFrame.LookVector * RAYCAST_DISTANCE
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	if player.Character then
		raycastParams.FilterDescendantsInstances = {player.Character}
	end
	
	local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	
	if raycastResult and raycastResult.Instance then
		local hit = raycastResult.Instance
		
		-- Check if it's an interactable item
		local itemType = hit:FindFirstChild("ItemType")
		if itemType and itemType:IsA("StringValue") then
			-- Check distance from CHARACTER (not camera)
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local charPos = player.Character.HumanoidRootPart.Position
				local dist = (hit.Position - charPos).Magnitude
				
				if dist <= INTERACTION_RANGE then
					currentTarget = hit
					promptLabel.Text = "[E] Pick up " .. hit.Name
					promptLabel.Visible = true
					return
				end
			end
		end
	end
	
	-- No target found
	currentTarget = nil
	promptLabel.Visible = false
end

-- Handle E key press
local lastPickupTime = 0
local PICKUP_COOLDOWN = 0.5

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.E then
		local now = tick()
		if now - lastPickupTime < PICKUP_COOLDOWN then return end
		
		if currentTarget then
			lastPickupTime = now
			print("📦 Attempting to pick up: " .. currentTarget.Name)
			pickupEvent:FireServer(currentTarget)
			
			-- Hide prompt immediately to prevent confusion
			promptLabel.Visible = false
			currentTarget = nil
		end
	end
end)

-- Continuous raycast check
game:GetService("RunService").RenderStepped:Connect(function()
	CheckForInteractable()
end)
