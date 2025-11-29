local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local requestHarvestEvent = eventsFolder:WaitForChild("RequestHarvest", 10)

if not requestHarvestEvent then
	warn("⚠️ HarvestController: Could not find RequestHarvest event!")
	return
end

print("⛏️ HarvestController: Ready to harvest!")

-- Écouter les clics de souris
mouse.Button1Down:Connect(function()
	local target = mouse.Target
	
	if not target then return end
	
	-- Vérifier si c'est un node de ressources
	local nodeType = target:FindFirstChild("NodeType")
	local available = target:FindFirstChild("Available")
	
	if nodeType and available then
		if available.Value then
			print("🖱️ Clicked on: " .. target.Name)
			-- Envoyer la demande au serveur
			requestHarvestEvent:FireServer(target)
		else
			print("⏳ This node is not available yet...")
		end
	end
end)
