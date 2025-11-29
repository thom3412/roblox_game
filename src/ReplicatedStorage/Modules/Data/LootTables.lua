local LootTables = {
	MedicalCrate = {
		{Type = "BANDAGE", Chance = 0.8, Min = 1, Max = 3},
		{Type = "FOOD_CAN", Chance = 0.3, Min = 1, Max = 2},
	},
	AmmoCrate = {
		{Type = "AMMO_9MM", Chance = 0.9, Min = 5, Max = 15},
		{Type = "AMMO_556", Chance = 0.5, Min = 10, Max = 30},
	},
	CivilianCrate = {
		{Type = "FOOD_CAN", Chance = 0.6, Min = 1, Max = 3},
		{Type = "WATER_BOTTLE", Chance = 0.6, Min = 1, Max = 3},
		{Type = "WOOD", Chance = 0.4, Min = 2, Max = 5},
		{Type = "METAL", Chance = 0.2, Min = 1, Max = 3},
	},
	-- Add your new container types here
	-- Example:
	-- MilitaryCrate = {
	--     {Type = "RIFLE", Chance = 0.1, Min = 1, Max = 1},
	-- }
}

return LootTables
