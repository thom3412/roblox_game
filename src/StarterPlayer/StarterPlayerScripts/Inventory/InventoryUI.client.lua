local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Constants
local SLOT_SIZE = 50
local SLOT_PADDING = 5
local COLUMNS = 5
local ROWS = 4

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InventoryGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, (SLOT_SIZE + SLOT_PADDING) * COLUMNS + SLOT_PADDING, 0, (SLOT_SIZE + SLOT_PADDING) * ROWS + SLOT_PADDING)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false -- Hidden by default
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, -35)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "INVENTORY"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, SLOT_SIZE, 0, SLOT_SIZE)
gridLayout.CellPadding = UDim2.new(0, SLOT_PADDING, 0, SLOT_PADDING)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.Parent = mainFrame

local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, SLOT_PADDING)
uiPadding.PaddingLeft = UDim.new(0, SLOT_PADDING)
uiPadding.PaddingRight = UDim.new(0, SLOT_PADDING)
uiPadding.PaddingBottom = UDim.new(0, SLOT_PADDING)
uiPadding.Parent = mainFrame

-- Create Slots
local slots = {}
for i = 1, COLUMNS * ROWS do
	local slot = Instance.new("Frame")
	slot.Name = "Slot" .. i
	slot.LayoutOrder = i
	slot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	slot.BorderSizePixel = 0
	slot.Parent = mainFrame
	
	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.Size = UDim2.new(0.8, 0, 0.8, 0)
	icon.Position = UDim2.new(0.1, 0, 0.1, 0)
	icon.BackgroundTransparency = 1
	icon.Visible = false
	icon.Parent = slot
	
	local countLabel = Instance.new("TextLabel")
	countLabel.Name = "Count"
	countLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
	countLabel.Position = UDim2.new(0.6, 0, 0.6, 0)
	countLabel.BackgroundTransparency = 1
	countLabel.Text = ""
	countLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	countLabel.TextStrokeTransparency = 0
	countLabel.TextSize = 14
	countLabel.Font = Enum.Font.GothamBold
	countLabel.ZIndex = 2
	countLabel.Parent = slot
	
	-- Add Name Label (Temporary until we have icons)
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "ItemName"
	nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
	nameLabel.Position = UDim2.new(0, 0, 0.35, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = ""
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 10
	nameLabel.Font = Enum.Font.Gotham
	nameLabel.TextWrapped = true
	nameLabel.ZIndex = 2
	nameLabel.Parent = slot
	
	slots[i] = {
		Frame = slot,
		Icon = icon,
		Count = countLabel,
		NameLabel = nameLabel
	}
end

-- Create Sound
local pickupSound = Instance.new("Sound")
pickupSound.Name = "PickupSound"
pickupSound.SoundId = "rbxassetid://12221967" -- Generic blip sound
pickupSound.Volume = 0.5
pickupSound.Parent = screenGui

-- Update Inventory Function
local function UpdateInventory(inventoryData)
	print("🎒 Client: Updating inventory UI...")
	pickupSound:Play()
	
	for i = 1, #slots do
		local slotData = inventoryData[tostring(i)] -- Keys might be strings in JSON/RemoteEvent
		local uiSlot = slots[i]
		
		if slotData then
			local itemType = slotData.ItemType
			local count = slotData.Count
			local itemInfo = ItemTypes[itemType]
			
			if itemInfo then
				uiSlot.Icon.Image = itemInfo.Icon
				uiSlot.Icon.Visible = true
				uiSlot.NameLabel.Text = itemInfo.Name -- Show name
				
				if count > 1 then
					uiSlot.Count.Text = tostring(count)
				else
					uiSlot.Count.Text = ""
				end
				
				-- Color code background based on type
				if itemInfo.Type == "Consumable" then
					uiSlot.Frame.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
				elseif itemInfo.Type == "Ammo" then
					uiSlot.Frame.BackgroundColor3 = Color3.fromRGB(80, 80, 60)
				else
					uiSlot.Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				end
			else
				uiSlot.Icon.Visible = false
				uiSlot.Count.Text = ""
				uiSlot.NameLabel.Text = ""
				uiSlot.Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end
		else
			uiSlot.Icon.Visible = false
			uiSlot.Count.Text = ""
			uiSlot.NameLabel.Text = ""
			uiSlot.Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end
end

-- Listen for updates
local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local updateInventoryEvent = eventsFolder:WaitForChild("UpdateInventory", 10)

if updateInventoryEvent then
	updateInventoryEvent.OnClientEvent:Connect(UpdateInventory)
else
	warn("⚠️ InventoryUI: Could not find UpdateInventory event!")
end

-- Toggle UI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	-- Debug input
	if input.KeyCode == Enum.KeyCode.I or input.KeyCode == Enum.KeyCode.Tab then
		print("⌨️ Input detected: " .. input.KeyCode.Name .. " | GameProcessed: " .. tostring(gameProcessed))
		
		-- Force toggle even if gameProcessed (Tab is PlayerList, I is Zoom)
		mainFrame.Visible = not mainFrame.Visible
		print("🎒 Toggled Inventory: " .. tostring(mainFrame.Visible))
	end
end)

print("🎒 InventoryUI: Ready!")
