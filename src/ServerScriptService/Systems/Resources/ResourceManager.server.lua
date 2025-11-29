local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ResourceTypes = require(ReplicatedStorage.Modules.Data.ResourceTypes)

local ResourceManager = {}

-- Stockage des ressources globales (initialisé dynamiquement)
local resources = {}
local updateEvent = nil

function ResourceManager.Init()
	print("🌲 ResourceManager Initialized")
	
	-- Créer le RemoteEvent s'il n'existe pas
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	updateEvent = eventsFolder:FindFirstChild("UpdateResources")
	
	if not updateEvent then
		updateEvent = Instance.new("RemoteEvent")
		updateEvent.Name = "UpdateResources"
		updateEvent.Parent = eventsFolder
		print("📡 RemoteEvent 'UpdateResources' created")
	end
	
	-- Initialiser toutes les ressources à 0
	for key, data in pairs(ResourceTypes) do
		resources[key] = 0
	end
	
	print("Resources loaded:", resources)
end

function ResourceManager.AddResource(key, amount)
	if resources[key] ~= nil then
		resources[key] += amount
		print("Added " .. amount .. " to " .. ResourceTypes[key].Name .. ". Total: " .. resources[key])
		
		-- Envoyer la mise à jour à tous les clients
		if updateEvent then
			updateEvent:FireAllClients(resources)
		end
	else
		warn("Resource type not found: " .. tostring(key))
	end
end

ResourceManager.Init()

-- TEST LOOP (A supprimer plus tard)
task.spawn(function()
	while true do
		task.wait(5)
		ResourceManager.AddResource("WOOD", 10)
		ResourceManager.AddResource("FOOD", 5)
	end
end)

return ResourceManager
