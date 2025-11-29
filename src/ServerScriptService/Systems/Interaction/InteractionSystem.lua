local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local InteractionSystem = {}
local PlayerInventory = nil

function InteractionSystem.Init()
	print("🎯 InteractionSystem: Initializing...")
	
	-- Get PlayerInventory reference
	PlayerInventory = require(script.Parent.Parent.Inventory.PlayerInventory)
	
	-- Create RemoteEvent for pickups
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	local pickupEvent = eventsFolder:FindFirstChild("PickupItem")
	
	if not pickupEvent then
		pickupEvent = Instance.new("RemoteEvent")
		pickupEvent.Name = "PickupItem"
		pickupEvent.Parent = eventsFolder
		print("📡 RemoteEvent 'PickupItem' created")
	end
	
	-- Listen for pickup requests
	pickupEvent.OnServerEvent:Connect(function(player, item)
		InteractionSystem.OnPickupRequest(player, item)
	end)
	
	print("✅ InteractionSystem: Ready!")
end

function InteractionSystem.OnPickupRequest(player, item)
	-- Security checks
	if not item or not item:IsA("BasePart") then
		warn("Invalid item!")
		return
	end
	
	if not item.Parent then
		-- Item was likely just picked up by someone else or double-clicked
		return
	end
	
	-- Check distance
	local character = player.Character
	if not character then return end
	
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end
	
	local distance = (item.Position - humanoidRootPart.Position).Magnitude
	if distance > 15 then
		warn(player.Name .. " is too far from item!")
		return
	end
	
	-- Get item data
	local itemTypeValue = item:FindFirstChild("ItemType")
	if not itemTypeValue then
		warn("Item has no ItemType!")
		return
	end
	
	local itemData = ItemTypes[itemTypeValue.Value]
	if not itemData then
		warn("Unknown item type: " .. itemTypeValue.Value)
		return
	end
	
	-- Try to add to inventory
	local success = PlayerInventory.AddItem(player, itemTypeValue.Value, 1)
	
	if success then
		print("✅ " .. player.Name .. " picked up: " .. itemData.Name)
		item:Destroy()
	else
		warn("❌ Could not add item to inventory (full?)")
	end
end

return InteractionSystem
