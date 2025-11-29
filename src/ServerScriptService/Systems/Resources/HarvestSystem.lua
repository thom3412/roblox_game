local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ResourceNodeTypes = require(ReplicatedStorage.Modules.Data.ResourceNodeTypes)

local HarvestSystem = {}

-- Table pour tracker les nodes en cours de récolte
local harvestingNodes = {}

function HarvestSystem.Init(resourceManager)
	print("⛏️ HarvestSystem: Initializing...")
	
	HarvestSystem.ResourceManager = resourceManager
	
	-- Créer le RemoteEvent pour les demandes de récolte
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	local harvestEvent = eventsFolder:FindFirstChild("RequestHarvest")
	
	if not harvestEvent then
		harvestEvent = Instance.new("RemoteEvent")
		harvestEvent.Name = "RequestHarvest"
		harvestEvent.Parent = eventsFolder
		print("📡 RemoteEvent 'RequestHarvest' created")
	end
	
	-- Écouter les demandes de récolte
	harvestEvent.OnServerEvent:Connect(function(player, node)
		HarvestSystem.OnHarvestRequest(player, node)
	end)
	
	print("✅ HarvestSystem: Ready!")
end

function HarvestSystem.OnHarvestRequest(player, node)
	-- Vérifications de sécurité
	if not node or not node:IsA("BasePart") then
		warn("Invalid node!")
		return
	end
	
	local nodeTypeValue = node:FindFirstChild("NodeType")
	local availableValue = node:FindFirstChild("Available")
	
	if not nodeTypeValue or not availableValue then
		warn("Node is missing data!")
		return
	end
	
	-- Vérifier si le node est disponible
	if not availableValue.Value then
		print("Node already being harvested or depleted")
		return
	end
	
	-- Vérifier si ce node n'est pas déjà en train d'être récolté
	if harvestingNodes[node] then
		print("Node already being harvested")
		return
	end
	
	-- Récupérer les données du node
	local nodeType = nodeTypeValue.Value
	local nodeData = ResourceNodeTypes[nodeType]
	
	if not nodeData then
		warn("Unknown node type: " .. nodeType)
		return
	end
	
	-- Marquer comme en cours de récolte
	harvestingNodes[node] = true
	availableValue.Value = false
	
	print(player.Name .. " started harvesting " .. nodeData.Name)
	
	-- Attendre le temps de récolte
	task.wait(nodeData.HarvestTime)
	
	-- Donner les ressources au joueur
	HarvestSystem.ResourceManager.AddResource(nodeData.ResourceType, nodeData.HarvestAmount)
	print("✅ " .. player.Name .. " harvested " .. nodeData.HarvestAmount .. " " .. nodeData.ResourceType)
	
	-- Faire disparaître le node
	node.Transparency = 1
	node.CanCollide = false
	
	-- Respawn après un délai
	task.wait(nodeData.RespawnTime)
	
	-- Réapparaître
	node.Transparency = 0
	node.CanCollide = true
	availableValue.Value = true
	harvestingNodes[node] = nil
	
	print("🌱 " .. nodeData.Name .. " respawned")
end

return HarvestSystem
