local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ResourceTypes = require(ReplicatedStorage.Modules.Data.ResourceTypes)

local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local updateEvent = eventsFolder:WaitForChild("UpdateResources", 10) -- Attendre un peu que le serveur le crée

if not updateEvent then
	warn("⚠️ ResourceController: Could not find UpdateResources event!")
	return
end

print("🛒 ResourceController Started")

updateEvent.OnClientEvent:Connect(function(newResources)
	print("💰 CLIENT: Received new resources:")
	for key, amount in pairs(newResources) do
		local name = ResourceTypes[key].Name
		print("   - " .. name .. ": " .. amount)
	end
	-- TODO: Mettre à jour l'interface graphique (GUI) ici
end)
