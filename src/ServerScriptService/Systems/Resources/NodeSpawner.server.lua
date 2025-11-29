local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ResourceNodeTypes = require(ReplicatedStorage.Modules.Data.ResourceNodeTypes)

local NodeSpawner = {}

-- Configuration de spawn - ZONES SÉPARÉES
local SPAWN_AREAS = {
	TREE = {
		Center = Vector3.new(-40, 0, 0),
		Size = Vector3.new(60, 0, 60)
	},
	ROCK = {
		Center = Vector3.new(40, 0, 0),
		Size = Vector3.new(60, 0, 60)
	},
	CRATE = {
		Center = Vector3.new(0, 0, 40),
		Size = Vector3.new(60, 0, 60)
	}
}

local SPAWN_COUNTS = {
	TREE = 15,
	ROCK = 8,
	CRATE = 5
}

function NodeSpawner.Init()
	print("🌳 NodeSpawner: Initializing...")
	
	-- Créer le dossier pour les nodes
	local nodesFolder = workspace:FindFirstChild("ResourceNodes")
	if not nodesFolder then
		nodesFolder = Instance.new("Folder")
		nodesFolder.Name = "ResourceNodes"
		nodesFolder.Parent = workspace
	else
		-- NETTOYER les anciens nodes si on relance
		nodesFolder:ClearAllChildren()
		print("🧹 Cleared old nodes")
	end
	
	-- Spawn chaque type de node
	for nodeType, count in pairs(SPAWN_COUNTS) do
		NodeSpawner.SpawnNodes(nodeType, count, nodesFolder)
	end
	
	print("✅ NodeSpawner: Spawned all resource nodes!")
end

function NodeSpawner.SpawnNodes(nodeType, count, parent)
	local nodeData = ResourceNodeTypes[nodeType]
	
	if not nodeData then
		warn("Unknown node type: " .. nodeType)
		return
	end
	
	-- Utiliser la zone spécifique pour ce type
	local spawnArea = SPAWN_AREAS[nodeType]
	if not spawnArea then
		warn("No spawn area defined for: " .. nodeType)
		return
	end
	
	for i = 1, count do
		local node = NodeSpawner.CreateNode(nodeType, nodeData)
		node.Parent = parent
		
		-- Position aléatoire dans LA ZONE SPÉCIFIQUE
		local randomX = spawnArea.Center.X + math.random(-spawnArea.Size.X/2, spawnArea.Size.X/2)
		local randomZ = spawnArea.Center.Z + math.random(-spawnArea.Size.Z/2, spawnArea.Size.Z/2)
		-- Y = moitié de la hauteur + 2 studs de marge
		local yPosition = (nodeData.Size.Y / 2) + 2
		
		node.Position = Vector3.new(randomX, yPosition, randomZ)
		
		print("  → " .. nodeData.Name .. " at " .. tostring(node.Position))
	end
	
	print("Spawned " .. count .. " " .. nodeData.Name .. "(s)")
end

function NodeSpawner.CreateNode(nodeType, nodeData)
	-- Créer la part principale
	local part = Instance.new("Part")
	part.Name = nodeData.Name
	part.Size = nodeData.Size
	part.Color = nodeData.Color
	part.Anchored = true
	part.CanCollide = true
	part.Material = Enum.Material.Neon -- TOUT EN NEON !
	
	-- Ajouter un StringValue pour identifier le type
	local typeValue = Instance.new("StringValue")
	typeValue.Name = "NodeType"
	typeValue.Value = nodeType
	typeValue.Parent = part
	
	-- Ajouter un BoolValue pour savoir si c'est disponible
	local availableValue = Instance.new("BoolValue")
	availableValue.Name = "Available"
	availableValue.Value = true
	availableValue.Parent = part
	
	return part
end

-- Initialize on server start
NodeSpawner.Init()

return NodeSpawner
