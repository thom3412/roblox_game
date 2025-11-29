local ZombieManager = {}

-- Configuration des vagues
local waveConfig = {
	Wave1 = { Count = 10, Type = "Walker" },
	Wave2 = { Count = 20, Type = "Walker" }
}

function ZombieManager.Init()
	print("🧟 ZombieManager Initialized")
	-- TODO: Commencer le timer de la première vague
end

function ZombieManager.SpawnZombie(type, position)
	print("Spawning zombie " .. type .. " at " .. tostring(position))
	-- TODO: Cloner le modèle du zombie et le placer
end

ZombieManager.Init()

return ZombieManager
