local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local ItemTypes = require(ReplicatedStorage.Modules.Data.ItemTypes)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- SoD2 Theme Constants
local THEME = {
	HeaderOrange = Color3.fromHex("#D35400"), -- Burnt Orange
	BackgroundDark = Color3.fromHex("#151515"), -- Very Dark Grey (almost black)
	SlotBackground = Color3.fromHex("#252525"), -- Dark Grey
	TextWhite = Color3.fromRGB(255, 255, 255),
	TextOrange = Color3.fromHex("#E67E22"),
	Border = Color3.fromHex("#333333")
}

-- Tweens
local TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local HOVER_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SoDInventoryGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Helper: Add Corner
local function AddCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 6)
	corner.Parent = parent
	return corner
end

-- Player Inventory Frame (RIGHT SIDE)
local playerFrame = Instance.new("Frame")
playerFrame.Name = "PlayerFrame"
playerFrame.Size = UDim2.new(0, 350, 0.85, 0)
playerFrame.Position = UDim2.new(1, 0, 0.05, 0) -- Start off-screen (Right)
playerFrame.BackgroundColor3 = THEME.BackgroundDark
playerFrame.BorderSizePixel = 0
playerFrame.Visible = false
playerFrame.Parent = screenGui
AddCorner(playerFrame, 10) -- Rounded Main Frame

-- Player Header
local pHeader = Instance.new("Frame")
pHeader.Name = "Header"
pHeader.Size = UDim2.new(1, 0, 0, 40)
pHeader.BackgroundColor3 = THEME.HeaderOrange
pHeader.BorderSizePixel = 0
pHeader.Parent = playerFrame
AddCorner(pHeader, 10) -- Rounded Header

-- Fix Header Bottom Corners (to be flat)
local pHeaderCover = Instance.new("Frame")
pHeaderCover.Size = UDim2.new(1, 0, 0.5, 0)
pHeaderCover.Position = UDim2.new(0, 0, 0.5, 0)
pHeaderCover.BackgroundColor3 = THEME.HeaderOrange
pHeaderCover.BorderSizePixel = 0
pHeaderCover.Parent = pHeader

local pTitle = Instance.new("TextLabel")
pTitle.Text = "INVENTAIRE"
pTitle.Size = UDim2.new(1, -10, 1, 0)
pTitle.Position = UDim2.new(0, 10, 0, 0)
pTitle.BackgroundTransparency = 1
pTitle.Font = Enum.Font.GothamBlack
pTitle.TextSize = 24
pTitle.TextColor3 = THEME.TextWhite
pTitle.TextXAlignment = Enum.TextXAlignment.Left
pTitle.ZIndex = 2
pTitle.Parent = pHeader

-- Player Content Scroll
local pScroll = Instance.new("ScrollingFrame")
pScroll.Name = "Content"
pScroll.Size = UDim2.new(1, 0, 1, -40)
pScroll.Position = UDim2.new(0, 0, 0, 40)
pScroll.BackgroundTransparency = 1
pScroll.BorderSizePixel = 0
pScroll.ScrollBarThickness = 4
pScroll.ScrollBarImageColor3 = THEME.HeaderOrange
pScroll.Parent = playerFrame

local pLayout = Instance.new("UIListLayout")
pLayout.Padding = UDim.new(0, 5)
pLayout.SortOrder = Enum.SortOrder.LayoutOrder
pLayout.Parent = pScroll

local pPadding = Instance.new("UIPadding")
pPadding.PaddingTop = UDim.new(0, 10)
pPadding.PaddingLeft = UDim.new(0, 10)
pPadding.PaddingRight = UDim.new(0, 10)
pPadding.Parent = pScroll

-- Helper: Section Header
local function CreateSectionHeader(text, order, parent)
	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(1, 0, 0, 25)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextColor3 = Color3.fromRGB(180, 180, 180)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.LayoutOrder = order
	label.Parent = parent
	return label
end

-- Helper: Grid
local function CreateGrid(name, order, parent, cellSize)
	local gridFrame = Instance.new("Frame")
	gridFrame.Name = name
	gridFrame.Size = UDim2.new(1, 0, 0, 0) -- Auto height
	gridFrame.BackgroundTransparency = 1
	gridFrame.LayoutOrder = order
	gridFrame.Parent = parent
	
	local gridLayout = Instance.new("UIGridLayout")
	gridLayout.CellSize = cellSize or UDim2.new(0, 75, 0, 75)
	gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
	gridLayout.Parent = gridFrame
	
	return gridFrame, gridLayout
end

-- Player Sections
-- 1. EQUIPMENT
CreateSectionHeader("ÉQUIPEMENT", 1, pScroll)
local equipGrid, equipLayout = CreateGrid("EquipmentGrid", 2, pScroll, UDim2.new(0, 160, 0, 80)) -- Wide slots
-- Placeholder Weapons
for i = 1, 2 do
	local slot = Instance.new("Frame")
	slot.BackgroundColor3 = THEME.SlotBackground
	slot.BorderSizePixel = 0
	slot.Parent = equipGrid
	AddCorner(slot, 4)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = (i == 1) and "Arme Mêlée" or "Arme à Feu"
	label.TextColor3 = Color3.fromRGB(100, 100, 100)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.Parent = slot
end
equipGrid.Size = UDim2.new(1, 0, 0, 90)

-- 2. POCKETS
CreateSectionHeader("POCHES", 3, pScroll)
local pocketGrid, pocketLayout = CreateGrid("PocketGrid", 4, pScroll, UDim2.new(0, 160, 0, 60)) -- Wide but shorter
-- Placeholder Pockets
for i = 1, 2 do
	local slot = Instance.new("Frame")
	slot.BackgroundColor3 = THEME.SlotBackground
	slot.BorderSizePixel = 0
	slot.Parent = pocketGrid
	AddCorner(slot, 4)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "Poche " .. i
	label.TextColor3 = Color3.fromRGB(100, 100, 100)
	label.Font = Enum.Font.Gotham
	label.TextSize = 10
	label.Parent = slot
end
pocketGrid.Size = UDim2.new(1, 0, 0, 70)

-- 3. BACKPACK
CreateSectionHeader("SAC À DOS", 5, pScroll)
local backpackGrid, backpackLayout = CreateGrid("BackpackGrid", 6, pScroll, UDim2.new(0, 75, 0, 75)) -- Square slots

-- Container Frame (LEFT SIDE)
local containerFrame = Instance.new("Frame")
containerFrame.Name = "ContainerFrame"
containerFrame.Size = UDim2.new(0, 400, 0, 300)
containerFrame.Position = UDim2.new(0.5, -250, 0.5, -150) -- Centered leftish
containerFrame.BackgroundColor3 = Color3.fromHex("#000000")
containerFrame.BackgroundTransparency = 0.2
containerFrame.BorderSizePixel = 0
containerFrame.Visible = false
containerFrame.Parent = screenGui
AddCorner(containerFrame, 10)

local cHeader = Instance.new("Frame")
cHeader.Name = "Header"
cHeader.Size = UDim2.new(1, 0, 0, 40)
cHeader.BackgroundColor3 = THEME.HeaderOrange
cHeader.BorderSizePixel = 0
cHeader.Parent = containerFrame
AddCorner(cHeader, 10)

-- Fix Container Header Bottom Corners
local cHeaderCover = Instance.new("Frame")
cHeaderCover.Size = UDim2.new(1, 0, 0.5, 0)
cHeaderCover.Position = UDim2.new(0, 0, 0.5, 0)
cHeaderCover.BackgroundColor3 = THEME.HeaderOrange
cHeaderCover.BorderSizePixel = 0
cHeaderCover.Parent = cHeader

local cTitle = Instance.new("TextLabel")
cTitle.Text = "OBJETS TROUVÉS"
cTitle.Size = UDim2.new(1, -10, 1, 0)
cTitle.Position = UDim2.new(0, 10, 0, 0)
cTitle.BackgroundTransparency = 1
cTitle.Font = Enum.Font.GothamBlack
cTitle.TextSize = 24
cTitle.TextColor3 = THEME.TextWhite
cTitle.TextXAlignment = Enum.TextXAlignment.Left
cTitle.ZIndex = 2
cTitle.Parent = cHeader

local cScroll = Instance.new("ScrollingFrame")
cScroll.Name = "Content"
cScroll.Size = UDim2.new(1, 0, 1, -40)
cScroll.Position = UDim2.new(0, 0, 0, 40)
cScroll.BackgroundTransparency = 1
cScroll.BorderSizePixel = 0
cScroll.ScrollBarThickness = 4
cScroll.ScrollBarImageColor3 = THEME.HeaderOrange
cScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
cScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
cScroll.Parent = containerFrame

local cGrid = Instance.new("UIGridLayout")
cGrid.CellSize = UDim2.new(0, 85, 0, 85)
cGrid.CellPadding = UDim2.new(0, 10, 0, 10)
cGrid.Parent = cScroll

local cPadding = Instance.new("UIPadding")
cPadding.PaddingTop = UDim.new(0, 10)
cPadding.PaddingLeft = UDim.new(0, 10)
cPadding.Parent = cScroll

-- Logic Variables
local currentContainer = nil
local currentContainerContents = {}
local playerInventory = {}

-- Helper: Add Corner
local function AddCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 6)
	corner.Parent = parent
	return corner
end

-- Helper: Create Slot
local function CreateSlot(itemData, parent, onClick)
	local slot = Instance.new("TextButton")
	slot.BackgroundColor3 = THEME.SlotBackground
	slot.BorderSizePixel = 0
	slot.Text = ""
	slot.AutoButtonColor = false
	slot.Parent = parent
	AddCorner(slot, 4) -- Rounded slots
	
	-- Hover Effect
	slot.MouseEnter:Connect(function()
		TweenService:Create(slot, HOVER_INFO, {BackgroundColor3 = Color3.fromHex("#3E4A59")}):Play()
	end)
	slot.MouseLeave:Connect(function()
		TweenService:Create(slot, HOVER_INFO, {BackgroundColor3 = THEME.SlotBackground}):Play()
	end)
	
	if itemData then
		local itemInfo = ItemTypes[itemData.ItemType]
		if itemInfo then
			-- Icon
			local icon = Instance.new("ImageLabel")
			icon.Size = UDim2.new(0.7, 0, 0.7, 0)
			icon.Position = UDim2.new(0.15, 0, 0.15, 0)
			icon.BackgroundTransparency = 1
			icon.Image = itemInfo.Icon
			icon.Parent = slot
			
			-- Count
			if itemData.Count > 1 then
				local count = Instance.new("TextLabel")
				count.Text = "x" .. itemData.Count
				count.Size = UDim2.new(1, -5, 0, 20)
				count.Position = UDim2.new(0, 0, 1, -20)
				count.BackgroundTransparency = 1
				count.TextColor3 = THEME.TextWhite
				count.TextXAlignment = Enum.TextXAlignment.Right
				count.Font = Enum.Font.GothamBold
				count.TextSize = 12
				count.Parent = slot
			end
			
			-- Click
			slot.MouseButton1Click:Connect(onClick)
		end
	end
	return slot
end

local function RefreshUI()
	-- Clear Backpack
	for _, child in pairs(backpackGrid:GetChildren()) do
		if child:IsA("GuiObject") then child:Destroy() end
	end
	
	-- Clear Container
	for _, child in pairs(cScroll:GetChildren()) do
		if child:IsA("GuiObject") then child:Destroy() end
	end
	
	-- Populate Player Backpack
	for i, item in pairs(playerInventory) do
		CreateSlot(item, backpackGrid, function()
			-- Use Item
			local events = ReplicatedStorage:FindFirstChild("Events")
			local useEvent = events and events:FindFirstChild("UseItem")
			if useEvent then useEvent:FireServer(i) end
		end)
	end
	-- Fill empty slots (8 min)
	for i = #playerInventory + 1, 8 do
		local slot = Instance.new("Frame")
		slot.BackgroundColor3 = Color3.fromHex("#1E1E1E")
		slot.BorderSizePixel = 0
		slot.Parent = backpackGrid
		AddCorner(slot, 4)
	end
	
	-- Resize Backpack Grid
	local rows = math.ceil(math.max(#playerInventory, 8) / 4)
	backpackGrid.Size = UDim2.new(1, 0, 0, rows * 85)
	
	-- Populate Container
	if currentContainer then
		containerFrame.Visible = true
		containerFrame.Position = UDim2.new(0.5, -450, 0.5, -150) -- Move left of center
		
		for i, item in pairs(currentContainerContents) do
			CreateSlot(item, cScroll, function()
				-- Transfer
				local events = ReplicatedStorage:FindFirstChild("Events")
				local transferEvent = events and events:FindFirstChild("TransferItem")
				if transferEvent then transferEvent:FireServer(currentContainer, i) end
			end)
		end
	else
		containerFrame.Visible = false
	end
end

-- Mouse Management
local function UpdateMouseState()
	if playerFrame.Visible then
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
	end
end

local function SetUIState(isOpen)
	-- Prevent re-animating if state hasn't changed
	if player:GetAttribute("IsMenuOpen") == isOpen then return end

	if isOpen then
		playerFrame.Visible = true
		player:SetAttribute("IsMenuOpen", true)
		
		-- Animate In (Slide from Right)
		playerFrame.Position = UDim2.new(1, 0, 0.05, 0) -- Start off-screen
		TweenService:Create(playerFrame, TWEEN_INFO, {Position = UDim2.new(1, -370, 0.05, 0)}):Play()
		
		-- Enable Mouse Fix (High Priority)
		RunService:BindToRenderStep("InventoryMouseFix", Enum.RenderPriority.Last.Value + 1, UpdateMouseState)
	else
		player:SetAttribute("IsMenuOpen", false)
		
		-- Animate Out
		local tween = TweenService:Create(playerFrame, TWEEN_INFO, {Position = UDim2.new(1, 0, 0.05, 0)})
		tween:Play()
		tween.Completed:Connect(function()
			if not player:GetAttribute("IsMenuOpen") then -- Check if still closed
				playerFrame.Visible = false
			end
		end)
		
		-- Disable Mouse Fix
		RunService:UnbindFromRenderStep("InventoryMouseFix")
		
		-- Reset Mouse
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		
		currentContainer = nil
		containerFrame.Visible = false
	end
end

-- Events
local events = ReplicatedStorage:WaitForChild("Events")

events:WaitForChild("UpdateInventory").OnClientEvent:Connect(function(inventory)
	playerInventory = inventory
	RefreshUI()
end)

events:WaitForChild("OpenContainerUI").OnClientEvent:Connect(function(container, contents)
	currentContainer = container
	currentContainerContents = contents
	SetUIState(true)
	RefreshUI()
end)

-- Input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.I or input.KeyCode == Enum.KeyCode.Tab then
		SetUIState(not player:GetAttribute("IsMenuOpen"))
	end
end)

print("🎒 State of Decay 2 UI Loaded (Right Aligned)")
