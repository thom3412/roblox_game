local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI Elements
local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui", 0.5)
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
local pickupEvent = eventsFolder:WaitForChild("PickupItem")

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
		
		-- Check if it's an interactable item or container
		local itemType = hit:FindFirstChild("ItemType")
		local containerType = hit:FindFirstChild("ContainerType")
		
		if (itemType or containerType) then
			-- Check if container is empty
			if containerType and hit:GetAttribute("IsEmpty") then
				-- Skip empty containers
			elseif player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local charPos = player.Character.HumanoidRootPart.Position
				local dist = (hit.Position - charPos).Magnitude
				
				if dist <= INTERACTION_RANGE then
					-- New Target Found
					if currentTarget ~= hit then
						-- Clear old highlight
						if currentTarget then
							local oldHighlight = currentTarget:FindFirstChild("InteractionHighlight")
							if oldHighlight then oldHighlight:Destroy() end
						end
						
						-- Set new target
						currentTarget = hit
						
						-- Add Highlight
						local highlight = Instance.new("Highlight")
						highlight.Name = "InteractionHighlight"
						highlight.Adornee = hit
						highlight.FillColor = Color3.fromRGB(255, 255, 255)
						highlight.FillTransparency = 0.8
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						highlight.OutlineTransparency = 0
						highlight.Parent = hit
						
						-- Update Prompt
						if containerType then
							promptLabel.Text = "[E] Search " .. hit.Name
						else
							promptLabel.Text = "[E] Pick up " .. hit.Name
						end
						promptLabel.Visible = true
					end
					return
				end
			end
		end
	end
	
	-- No target found or out of range
	if currentTarget then
		local oldHighlight = currentTarget:FindFirstChild("InteractionHighlight")
		if oldHighlight then oldHighlight:Destroy() end
		currentTarget = nil
		promptLabel.Visible = false
	end
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
			
			if currentTarget:FindFirstChild("ContainerType") then
				print("🔍 Requesting to search: " .. currentTarget.Name)
				local events = ReplicatedStorage:FindFirstChild("Events")
				local searchEvent = events and events:FindFirstChild("SearchContainer")
				if searchEvent then
					searchEvent:FireServer(currentTarget)
				end
			else
				print("📦 Attempting to pick up: " .. currentTarget.Name)
				pickupEvent:FireServer(currentTarget)
			end
			
			-- Hide prompt immediately
			promptLabel.Visible = false
			currentTarget = nil
		end
	end
end)

-- Continuous raycast check
game:GetService("RunService").RenderStepped:Connect(function()
	CheckForInteractable()
end)
