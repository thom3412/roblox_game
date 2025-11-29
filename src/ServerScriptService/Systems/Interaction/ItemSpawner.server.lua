local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local ItemSpawner = {}

-- Spawn locations
local SPAWN_AREA = {
	Center = Vector3.new(0, 5, 0), -- Increased height to be safe
	Size = Vector3.new(80, 0, 80)
}

local SPAWN_COUNTS = {
	BANDAGE = 5,
	FOOD_CAN = 3,
	AMMO_9MM = 4,
	WOOD = 6,
	METAL = 4
}

function ItemSpawner.Init()
	print("📦 ItemSpawner: Initializing span...")
	
	-- Create folder for items
	local itemsFolder = workspace:FindFirstChild("WorldItems")
	if not itemsFolder then
		itemsFolder = Instance.new("Folder")
		itemsFolder.Name = "WorldItems"
		itemsFolder.Parent = workspace
	else
		-- Clean old items
		itemsFolder:ClearAllChildren()
		print("🧹 Cleared old items")
	end
	
	--  Spawn each item type
	for itemType, count in pairs(SPAWN_COUNTS) do
		ItemSpawner.SpawnItems(itemType, count, itemsFolder)
	end
	
	-- Spawn Containers (NEW)
	for i = 1, 3 do ItemSpawner.SpawnContainer("MedicalCrate", SPAWN_AREA) end
	
	print("✅ ItemSpawner: Spawned all items!")
end

function ItemSpawner.SpawnItems(itemType, count, parent)
	local itemData = ItemTypes[itemType]
	
	if not itemData then
		warn("Unknown item type: " .. itemType)
		return
	end
	
	for i = 1, count do
		local item = ItemSpawner.CreateItem(itemType, itemData)
		item.Parent = parent
		
		-- Random position
		local randomX = SPAWN_AREA.Center.X + math.random(-SPAWN_AREA.Size.X/2, SPAWN_AREA.Size.X/2)
		local randomZ = SPAWN_AREA.Center.Z + math.random(-SPAWN_AREA.Size.Z/2, SPAWN_AREA.Size.Z/2)
		item.Position = Vector3.new(randomX, SPAWN_AREA.Center.Y, randomZ)
	end
	
	print("Spawned " .. count .. " " .. itemData.Name .. "(s)")
end

function ItemSpawner.CreateItem(itemType, itemData)
	-- Create the pickup part
	local part = Instance.new("Part")
	part.Name = itemData.Name
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	
	-- Color based on type
	if itemData.Type == "Consumable" then
		part.Color = Color3.fromRGB(0, 255, 0) -- Green
	elseif itemData.Type == "Ammo" then
		part.Color = Color3.fromRGB(255, 255, 0) -- Yellow
	elseif itemData.Type == "Material" then
		part.Color = Color3.fromRGB(128, 128, 128) -- Gray
	end
	
	-- Add item type identifier
	local itemTypeValue = Instance.new("StringValue")
	itemTypeValue.Name = "ItemType"
	itemTypeValue.Value = itemType
	itemTypeValue.Parent = part
	
	-- Add billboard UI
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Size = UDim2.new(0, 100, 0, 40)
	billboardGui.StudsOffset = Vector3.new(0, 2, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Parent = part
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = itemData.Name
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextStrokeTransparency = 0.5
	textLabel.Parent = billboardGui
	
	return part
end

function ItemSpawner.SpawnContainer(type, area)
	local container = Instance.new("Part")
	container.Name = type
	container.Size = Vector3.new(4, 3, 4)
	container.Anchored = true
	container.CanCollide = true
	container.Material = Enum.Material.Metal
	container.Color = Color3.fromRGB(0, 100, 255) -- Blue for containers
	
	-- Random position
	local randomX = area.Center.X + math.random(-area.Size.X/2, area.Size.X/2)
	local randomZ = area.Center.Z + math.random(-area.Size.Z/2, area.Size.Z/2)
	container.Position = Vector3.new(randomX, area.Center.Y, randomZ)
	
	-- Tags
	local typeVal = Instance.new("StringValue")
	typeVal.Name = "ContainerType"
	typeVal.Value = type
	typeVal.Parent = container
	
	local lootable = Instance.new("BoolValue")
	lootable.Name = "Lootable"
	lootable.Value = true
	lootable.Parent = container
	
	container.Parent = workspace:FindFirstChild("WorldItems") or workspace
	print("📦 Spawned Container: " .. type)
end

-- Auto-initialize
ItemSpawner.Init()

return ItemSpawner
