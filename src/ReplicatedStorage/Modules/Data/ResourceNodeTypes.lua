local ResourceNodeTypes = {
	TREE = {
		Name = "Tree",
		ResourceType = "WOOD",
		HarvestAmount = 10,
		HarvestTime = 3,
		RespawnTime = 30,
		Color = Color3.fromRGB(0, 255, 0), -- VERT FLUO !
		Size = Vector3.new(4, 8, 4)
	},
	ROCK = {
		Name = "Rock",
		ResourceType = "METAL",
		HarvestAmount = 5,
		HarvestTime = 4,
		RespawnTime = 60,
		Color = Color3.fromRGB(0, 255, 255), -- CYAN FLUO !
		Size = Vector3.new(6, 5, 6)
	},
	CRATE = {
		Name = "Supply Crate",
		ResourceType = "FOOD",
		HarvestAmount = 15,
		HarvestTime = 2,
		RespawnTime = 120,
		Color = Color3.fromRGB(255, 255, 0), -- JAUNE FLUO !
		Size = Vector3.new(5, 4, 5)
	}
}

return ResourceNodeTypes
