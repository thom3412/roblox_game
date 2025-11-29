local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local InteractionSystem = {}
local PlayerInventory = nil

function InteractionSystem.Init()
	print("🎯 InteractionSystem: Initializing...")
	
	-- Get PlayerInventory reference
	PlayerInventory = require(script.Parent.Parent.Inventory.PlayerInventory)
	
	local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
	if not eventsFolder then
		eventsFolder = Instance.new("Folder")
		eventsFolder.Name = "Events"
		eventsFolder.Parent = ReplicatedStorage
	end
	
	-- Create RemoteEvents
	local function CreateEvent(name)
		local event = eventsFolder:FindFirstChild(name)
		if not event then
			event = Instance.new("RemoteEvent")
			event.Name = name
			event.Parent = eventsFolder
			print("📡 RemoteEvent '" .. name .. "' created")
		end
		return event
	end
	
	local pickupEvent = CreateEvent("PickupItem")
	local searchEvent = CreateEvent("SearchContainer")
	local openUIEvent = CreateEvent("OpenContainerUI")
	local transferEvent = CreateEvent("TransferItem")
	
	-- Listen for pickup requests
	pickupEvent.OnServerEvent:Connect(function(player, item)
		InteractionSystem.OnPickupRequest(player, item)
	end)
	
	-- Listen for search requests
	searchEvent.OnServerEvent:Connect(function(player, container)
		InteractionSystem.OnSearchRequest(player, container)
	end)
	
	-- Listen for transfer requests
	transferEvent.OnServerEvent:Connect(function(player, container, slotIndex)
		InteractionSystem.HandleTransfer(player, container, slotIndex)
	end)
	
	print("✅ InteractionSystem: Ready!")
end

function InteractionSystem.OnSearchRequest(player, container)
	-- Validation
	if not container or not container:FindFirstChild("ContainerType") then return end
	
	local distance = (container.Position - player.Character.HumanoidRootPart.Position).Magnitude
	if distance > 15 then return end
	
	-- Get Loot
	local ContainerManager = require(script.Parent.ContainerManager)
	local contents = ContainerManager.GetContents(container)
	
	-- Send to client (Open UI)
	local events = ReplicatedStorage:FindFirstChild("Events")
	local openUIEvent = events and events:FindFirstChild("OpenContainerUI")
	
	if openUIEvent then
		openUIEvent:FireClient(player, container, contents)
		print("📂 Opened container for " .. player.Name)
	end
end

function InteractionSystem.HandleTransfer(player, container, slotIndex)
	local ContainerManager = require(script.Parent.ContainerManager)
	local PlayerInventory = require(script.Parent.Parent.Inventory.PlayerInventory)
	
	local contents = ContainerManager.GetContents(container)
	if not contents then return end
	
	local itemData = contents[slotIndex]
	if not itemData then return end
	
	-- Try to add to player inventory
	local success = PlayerInventory.AddItem(player, itemData.ItemType, itemData.Count)
	
	if success then
		-- Remove from container
		ContainerManager.RemoveItem(container, slotIndex)
		
		-- Refresh UI
		local events = ReplicatedStorage:FindFirstChild("Events")
		local openUIEvent = events and events:FindFirstChild("OpenContainerUI")
		if openUIEvent then
			openUIEvent:FireClient(player, container, contents)
		end
		print("✅ Looted " .. itemData.ItemType)
	end
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
