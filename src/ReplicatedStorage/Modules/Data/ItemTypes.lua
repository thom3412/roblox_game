local ItemTypes = {
	-- Consumables
	BANDAGE = {
		Name = "Bandage",
		Type = "Consumable",
		Description = "Restores 25 HP",
		MaxStack = 10,
		HealAmount = 25,
		Icon = "rbxassetid://0" -- TODO: Add real asset ID
	},
	FOOD_CAN = {
		Name = "Canned Food",
		Type = "Consumable",
		Description = "Restores hunger and 10 HP",
		MaxStack = 5,
		HealAmount = 10,
		HungerRestore = 50,
		Icon = "rbxassetid://0"
	},
	WATER_BOTTLE = {
		Name = "Water Bottle",
		Type = "Consumable",
		Description = "Restores thirst",
		MaxStack = 5,
		ThirstRestore = 100,
		Icon = "rbxassetid://0"
	},
	
	-- Ammo
	AMMO_9MM = {
		Name = "9mm Ammo",
		Type = "Ammo",
		Description = "Pistol ammunition",
		MaxStack = 50,
		Icon = "rbxassetid://0"
	},
	AMMO_556 = {
		Name = "5.56mm Ammo",
		Type = "Ammo",
		Description = "Rifle ammunition",
		MaxStack = 30,
		Icon = "rbxassetid://0"
	},
	
	-- Materials
	WOOD = {
		Name = "Wood",
		Type = "Material",
		Description = "Used for crafting and building",
		MaxStack = 100,
		Icon = "rbxassetid://0"
	},
	METAL = {
		Name = "Metal Scrap",
		Type = "Material",
		Description = "Used for advanced building",
		MaxStack = 50,
		Icon = "rbxassetid://0"
	},
	CLOTH = {
		Name = "Cloth",
		Type = "Material",
		Description = "Used for crafting bandages",
		MaxStack = 50,
		Icon = "rbxassetid://0"
	}
}

return ItemTypes
