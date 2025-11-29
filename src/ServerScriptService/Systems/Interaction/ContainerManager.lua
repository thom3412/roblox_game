local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local ContainerManager = {}

-- Storage for container contents: { [ContainerInstance] = { {ItemType="BANDAGE", Count=1}, ... } }
local containerContents = {}

-- Loot Tables
local LootTables = require(ReplicatedStorage.Modules.Data.LootTables)

function ContainerManager.Init()
	print("📦 ContainerManager: Initializing...")
	-- Could listen for container spawning here if needed
end

function ContainerManager.GetContents(container)
	if not containerContents[container] then
		ContainerManager.GenerateLoot(container)
	end
	return containerContents[container]
end

function ContainerManager.GenerateLoot(container)
	local typeVal = container:FindFirstChild("ContainerType")
	local containerType = typeVal and typeVal.Value or "CivilianCrate"
	
	local lootTable = LootTables[containerType] or LootTables.CivilianCrate
	local items = {}
	
	for _, entry in ipairs(lootTable) do
		if math.random() <= entry.Chance then
			local count = math.random(entry.Min, entry.Max)
			table.insert(items, {
				ItemType = entry.Type,
				Count = count
			})
		end
	end
	
	containerContents[container] = items
	print("🎲 Generated loot for " .. container.Name .. " (" .. #items .. " items)")
end

function ContainerManager.RemoveItem(container, index)
	local contents = containerContents[container]
	if contents and contents[index] then
		table.remove(contents, index)
		
		-- Check if empty
		if #contents == 0 then
			container:SetAttribute("IsEmpty", true)
			print("🗑️ Container " .. container.Name .. " is now empty")
		end
		
		return true
	end
	return false
end

return ContainerManager
