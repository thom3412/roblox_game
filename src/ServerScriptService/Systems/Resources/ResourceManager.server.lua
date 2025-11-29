local ResourceManager = {}

-- Stockage des ressources globales
local resources = {
	Food = 0,
	Wood = 0,
	Metal = 0,
	Ammo = 0,
	Meds = 0
}

function ResourceManager.Init()
	print("🌲 ResourceManager Initialized")
	-- TODO: Charger les données sauvegardées
end

function ResourceManager.AddResource(type, amount)
	if resources[type] then
		resources[type] += amount
		print("Added " .. amount .. " to " .. type .. ". Total: " .. resources[type])
		-- TODO: FireClient pour mettre à jour l'UI
	end
end

ResourceManager.Init()

return ResourceManager
