local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local PlayerInventory = {}

-- Storage for all player inventories
local inventories = {}

-- Inventory settings
local MAX_SLOTS = 20

function PlayerInventory.Init()
	print("🎒 PlayerInventory: Initializing...")
	
	-- Get RemoteEvents (they exist from ReplicatedStorage at startup)
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	local updateInventoryEvent = eventsFolder:WaitForChild("UpdateInventory")
	local useItemEvent = eventsFolder:WaitForChild("UseItem")
	
	-- Listen for usage
	useItemEvent.OnServerEvent:Connect(function(player, slot)
		PlayerInventory.UseItem(player, slot)
	end)
	
	print("✅ PlayerInventory: Ready!")
end

function PlayerInventory.CreateInventory(player)
	local inventory = {}
	
	-- Initialize empty slots
	for i = 1, MAX_SLOTS do
		inventory[i] = nil
	end
	
	inventories[player.UserId] = inventory
	print("🎒 Created inventory for " .. player.Name)
	
	-- Sync to client
	PlayerInventory.SyncInventory(player)
	
	return inventory
end

function PlayerInventory.GetInventory(player)
	return inventories[player.UserId]
end

function PlayerInventory.AddItem(player, itemType, amount)
	local inventory = PlayerInventory.GetInventory(player)
	if not inventory then
		warn("Player has no inventory!")
		return false
	end
	
	local itemData = ItemTypes[itemType]
	if not itemData then
		warn("Unknown item type: " .. itemType)
		return false
	end
	
	amount = amount or 1
	local remaining = amount
	
	-- First, try to stack with existing items
	for slot, itemStack in pairs(inventory) do
		if itemStack and itemStack.ItemType == itemType then
			local spaceInStack = itemData.MaxStack - itemStack.Count
			if spaceInStack > 0 then
				local toAdd = math.min(remaining, spaceInStack)
				itemStack.Count += toAdd
				remaining -= toAdd
				
				if remaining == 0 then
					print("✅ Added " .. amount .. "x " .. itemData.Name .. " to " .. player.Name .. "'s inventory (stacked)")
					PlayerInventory.SyncInventory(player)
					return true
				end
			end
		end
	end
	
	-- Then, fill empty slots
	while remaining > 0 do
		local emptySlot = PlayerInventory.FindEmptySlot(inventory)
		if not emptySlot then
			warn("⚠️ Inventory full! Could only add " .. (amount - remaining) .. "/" .. amount)
			PlayerInventory.SyncInventory(player)
			return false
		end
		
		local toAdd = math.min(remaining, itemData.MaxStack)
		inventory[emptySlot] = {
			ItemType = itemType,
			Count = toAdd
		}
		remaining -= toAdd
	end
	
	print("✅ Added " .. amount .. "x " .. itemData.Name .. " to " .. player.Name .. "'s inventory")
	PlayerInventory.SyncInventory(player)
	return true
end

function PlayerInventory.RemoveItem(player, itemType, amount)
	local inventory = PlayerInventory.GetInventory(player)
	if not inventory then return false end
	
	amount = amount or 1
	local remaining = amount
	
	-- Remove from slots
	for slot, itemStack in pairs(inventory) do
		if itemStack and itemStack.ItemType == itemType then
			local toRemove = math.min(remaining, itemStack.Count)
			itemStack.Count -= toRemove
			remaining -= toRemove
			
			if itemStack.Count <= 0 then
				inventory[slot] = nil
			end
			
			if remaining == 0 then
				PlayerInventory.SyncInventory(player)
				return true
			end
		end
	end
	
	warn("Not enough items to remove!")
	return false
end

function PlayerInventory.FindEmptySlot(inventory)
	for i = 1, MAX_SLOTS do
		if not inventory[i] then
			return i
		end
	end
	return nil
end

function PlayerInventory.SyncInventory(player)
	local inventory = PlayerInventory.GetInventory(player)
	if not inventory then return end
	
	local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
	local updateEvent = eventsFolder and eventsFolder:FindFirstChild("UpdateInventory")
	
	if updateEvent then
		updateEvent:FireClient(player, inventory)
	end
end

function PlayerInventory.OnPlayerAdded(player)
	PlayerInventory.CreateInventory(player)
end

function PlayerInventory.OnPlayerRemoving(player)
	inventories[player.UserId] = nil
	print("🗑️ Removed inventory for " .. player.Name)
end

-- Handle Item Usage
function PlayerInventory.UseItem(player, slot)
	local inventory = inventories[player.UserId]
	if not inventory then return end
	
	local itemStack = inventory[slot]
	if not itemStack then return end
	
	local itemData = ItemTypes[itemStack.ItemType]
	if not itemData then return end
	
	-- Check if consumable
	if itemData.Type == "Consumable" then
		local PlayerStats = require(script.Parent.Parent.Stats.PlayerStats)
		local used = false
		
		if itemData.HealAmount then
			PlayerStats.ModifyStat(player, "Health", itemData.HealAmount)
			used = true
		end
		
		if itemData.HungerRestore then
			PlayerStats.ModifyStat(player, "Hunger", itemData.HungerRestore)
			used = true
		end
		
		if itemData.ThirstRestore then
			PlayerStats.ModifyStat(player, "Thirst", itemData.ThirstRestore)
			used = true
		end
		
		if used then
			PlayerInventory.RemoveItem(player, itemStack.ItemType, 1)
			print("🍽️ " .. player.Name .. " used " .. itemData.Name)
			
			-- Play Sound
			local soundId = "rbxassetid://12221967" -- Default blip
			if itemData.HungerRestore then
				soundId = "rbxassetid://907524496" -- Crunch
			elseif itemData.ThirstRestore then
				soundId = "rbxassetid://907527632" -- Drink
			end
			
			local sound = Instance.new("Sound")
			sound.SoundId = soundId
			sound.Parent = player.Character.HumanoidRootPart
			sound:Play()
			game:GetService("Debris"):AddItem(sound, 2)
		end
	end
end

return PlayerInventory
