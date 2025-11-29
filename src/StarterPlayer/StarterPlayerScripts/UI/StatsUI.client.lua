local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Constants (Ultra Compact)
local BAR_WIDTH = 180
local BAR_HEIGHT = 12 -- Réduit encore plus
local PADDING = 6

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StatsGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "StatsFrame"
mainFrame.Size = UDim2.new(0, BAR_WIDTH + 24, 0, (BAR_HEIGHT + PADDING) * 3 + 24)
mainFrame.Position = UDim2.new(0, 20, 1, -20)
mainFrame.AnchorPoint = Vector2.new(0, 1)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Transparency = 0.85
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

local function CreateBar(name, color, order)
	local container = Instance.new("Frame")
	container.Name = name .. "Container"
	container.Size = UDim2.new(1, -24, 0, BAR_HEIGHT)
	container.Position = UDim2.new(0, 12, 0, 12 + (order - 1) * (BAR_HEIGHT + PADDING))
	container.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	container.BackgroundTransparency = 0.3
	container.BorderSizePixel = 0
	container.Parent = mainFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromHex("6d6e77")
	stroke.Transparency = 0.3
	stroke.Thickness = 1
	stroke.Parent = container
	
	-- Background pour le fill
	local fillBackground = Instance.new("Frame")
	fillBackground.Name = "FillBackground"
	fillBackground.Size = UDim2.new(1, 0, 1, 0)
	fillBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	fillBackground.BorderSizePixel = 0
	fillBackground.Parent = container
	
	-- Fill bar avec gradient
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = color
	fill.BorderSizePixel = 0
	fill.ZIndex = 2
	fill.Parent = container
	
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, color)
	})
	gradient.Rotation = 90
	gradient.Parent = fill
	
	-- Overlay shine effect
	local shine = Instance.new("Frame")
	shine.Name = "Shine"
	shine.Size = UDim2.new(1, 0, 0.5, 0)
	shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	shine.BackgroundTransparency = 0.85
	shine.BorderSizePixel = 0
	shine.ZIndex = 3
	shine.Parent = fill
	
	-- Pourcentage (sans label du nom)
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.Size = UDim2.new(0, 40, 1, 0)
	valueLabel.Position = UDim2.new(1, -48, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = "100%"
	valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 9
	valueLabel.ZIndex = 4
	valueLabel.Parent = container
	
	local valueStroke = Instance.new("UIStroke")
	valueStroke.Color = Color3.fromRGB(0, 0, 0)
	valueStroke.Thickness = 1.5
	valueStroke.Transparency = 0.5
	valueStroke.Parent = valueLabel
	
	return fill, valueLabel, container
end

-- Fonction spéciale pour la barre de stamina avec effet "ghost drain"
local function CreateStaminaBar(color, order)
	local container = Instance.new("Frame")
	container.Name = "StaminaContainer"
	container.Size = UDim2.new(1, -24, 0, BAR_HEIGHT)
	container.Position = UDim2.new(0, 12, 0, 12 + (order - 1) * (BAR_HEIGHT + PADDING))
	container.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	container.BackgroundTransparency = 0.3
	container.BorderSizePixel = 0
	container.ClipsDescendants = true -- IMPORTANT: Pour couper les coins des enfants rectangulaires
	container.Parent = mainFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromHex("6d6e77")
	stroke.Transparency = 0.3
	stroke.Thickness = 1
	stroke.Parent = container
	
	-- Background gris
	local fillBackground = Instance.new("Frame")
	fillBackground.Name = "FillBackground"
	fillBackground.Size = UDim2.new(1, 0, 1, 0)
	fillBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	fillBackground.BorderSizePixel = 0
	fillBackground.Parent = container
	
	-- Couche NOIRE (par dessus le gris, sous la barre cyan)
	local blackLayer = Instance.new("Frame")
	blackLayer.Name = "BlackLayer"
	blackLayer.Size = UDim2.new(1, 0, 1, 0)
	blackLayer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blackLayer.BorderSizePixel = 0
	blackLayer.ZIndex = 1
	blackLayer.Parent = container
	
	-- Fill bar CYAN
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = color
	fill.BorderSizePixel = 0
	fill.ZIndex = 2
	fill.Parent = container
	
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, color)
	})
	gradient.Rotation = 90
	gradient.Parent = fill
	
	-- Overlay shine
	local shine = Instance.new("Frame")
	shine.Name = "Shine"
	shine.Size = UDim2.new(1, 0, 0.5, 0)
	shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	shine.BackgroundTransparency = 0.85
	shine.BorderSizePixel = 0
	shine.ZIndex = 3
	shine.Parent = fill
	
	-- Barre BLANCHE "fantôme" (perte récente)
	local ghostFill = Instance.new("Frame")
	ghostFill.Name = "GhostFill"
	ghostFill.Size = UDim2.new(1, 0, 1, 0)
	ghostFill.BackgroundColor3 = Color3.fromHex("ffffff")
	ghostFill.BackgroundTransparency = 1 -- Invisible par défaut
	ghostFill.BorderSizePixel = 0
	ghostFill.ZIndex = 1.5 -- Entre noir (1) et cyan (2)
	ghostFill.Parent = container
	
	-- PAS de UICorner pour éviter l'écart avec le cyan !
	-- Le ghost doit être parfaitement rectangulaire pour coller au cyan
	
	-- Pourcentage
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.Size = UDim2.new(0, 40, 1, 0)
	valueLabel.Position = UDim2.new(1, -48, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = "100%"
	valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 9
	valueLabel.ZIndex = 5
	valueLabel.Parent = container
	
	local valueStroke = Instance.new("UIStroke")
	valueStroke.Color = Color3.fromRGB(0, 0, 0)
	valueStroke.Thickness = 1.5
	valueStroke.Transparency = 0.5
	valueStroke.Parent = valueLabel
	
	return fill, valueLabel, ghostFill, blackLayer
end

local healthBar, healthValue = CreateBar("Health", Color3.fromRGB(231, 76, 60), 1)
local hungerBar, hungerValue = CreateBar("Hunger", Color3.fromRGB(230, 126, 34), 2)
local staminaBar, staminaValue, staminaGhost, staminaBlack = CreateStaminaBar(Color3.fromHex("05848e"), 3)

-- Warning Label
local warningLabel = Instance.new("TextLabel")
warningLabel.Name = "Warning"
warningLabel.Size = UDim2.new(1, 0, 0, 24)
warningLabel.Position = UDim2.new(0, 0, 0, -32)
warningLabel.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
warningLabel.BackgroundTransparency = 0.2
warningLabel.Text = "⚠️ STARVING!"
warningLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
warningLabel.TextStrokeTransparency = 0.5
warningLabel.Font = Enum.Font.GothamBlack
warningLabel.TextSize = 11
warningLabel.Visible = false
warningLabel.ZIndex = 5
warningLabel.Parent = mainFrame

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 8)
warningCorner.Parent = warningLabel

local pulseAnimation
local function PulseWarning()
	if pulseAnimation then
		pulseAnimation:Cancel()
	end
	
	local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	pulseAnimation = TweenService:Create(warningLabel, tweenInfo, {
		BackgroundTransparency = 0.6,
		TextTransparency = 0.3
	})
	pulseAnimation:Play()
end

-- Update Function (Health & Hunger)
local function UpdateStats(stats)
	local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	
	TweenService:Create(healthBar, tweenInfo, {Size = UDim2.new(stats.Health / 100, 0, 1, 0)}):Play()
	TweenService:Create(hungerBar, tweenInfo, {Size = UDim2.new(stats.Hunger / 100, 0, 1, 0)}):Play()
	
	healthValue.Text = math.floor(stats.Health) .. "%"
	hungerValue.Text = math.floor(stats.Hunger) .. "%"
	
	if stats.Hunger < 20 then
		warningLabel.Text = "⚠️ STARVING!"
		warningLabel.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
		warningLabel.Visible = true
		PulseWarning()
	elseif stats.Health < 20 then
		warningLabel.Text = "⚠️ LOW HEALTH!"
		warningLabel.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
		warningLabel.Visible = true
		PulseWarning()
	else
		if not warningLabel.Text:find("EXHAUSTED") then
			warningLabel.Visible = false
			if pulseAnimation then
				pulseAnimation:Cancel()
				pulseAnimation = nil
			end
		end
	end
end

-- Stamina tracking pour effet ghost
local lastStamina = 100
local ghostTween = nil
local fadeTween = nil
local isSprinting = false
local ghostStartPosition = nil -- Position initiale du ghost

-- Update Stamina avec effet ghost
local function UpdateStamina()
	local character = player.Character
	if not character then return end
	
	local stamina = character:GetAttribute("Stamina") or 100
	local maxStamina = character:GetAttribute("MaxStamina") or 100
	local staminaPercent = stamina / maxStamina
	
	-- Détection si on est en train de sprinter (stamina descend)
	-- OU si l'attribut IsSprinting est vrai (pour la synchro immédiate)
	local isSprintingAttr = character:GetAttribute("IsSprinting") == true
	local isLosingStamina = stamina < lastStamina or isSprintingAttr
	
	-- Update barre principale CYAN (sans tween pour plus de réactivité)
	staminaBar.Size = UDim2.new(staminaPercent, 0, 1, 0)
	staminaValue.Text = math.floor(stamina) .. "%"
	
	-- Gestion de la barre fantôme BLANCHE
	if isLosingStamina then
		-- Si c'est le début du sprint, capturer la position de départ du ghost
		if not isSprinting then
			ghostStartPosition = lastStamina / maxStamina
			isSprinting = true
			
			-- Annuler les tweens précédents
			if ghostTween then ghostTween:Cancel() end
			if fadeTween then fadeTween:Cancel() end
		end
		
		-- Le ghost reste ancré à sa position initiale et s'étend vers la gauche
		-- IMPORTANT: Pas d'écart, le blanc commence exactement où le cyan se termine
		local ghostWidth = ghostStartPosition - staminaPercent
		
		staminaGhost.Position = UDim2.new(staminaPercent, 0, 0, 0)
		staminaGhost.Size = UDim2.new(ghostWidth, 0, 1, 0)
		staminaGhost.BackgroundTransparency = 0.2 -- Blanc visible
	
	else
		-- Si on arrête de sprinter et qu'on avait du blanc visible
		if isSprinting and staminaGhost.BackgroundTransparency < 1 then
			isSprinting = false
			
			-- Capturer la taille actuelle pour l'animation
			local currentGhostWidth = ghostStartPosition - staminaPercent
			
			-- Animation: le blanc disparaît de DROITE vers GAUCHE (comme le drain)
			-- On réduit la taille tout en gardant la position fixe
			local shrinkTweenInfo = TweenInfo.new(2.0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			ghostTween = TweenService:Create(staminaGhost, shrinkTweenInfo, {
				Size = UDim2.new(0, 0, 1, 0) -- Rétrécit jusqu'à 0
			})
			ghostTween:Play()
			
			-- En même temps, fade la transparence
			fadeTween = TweenService:Create(staminaGhost, shrinkTweenInfo, {
				BackgroundTransparency = 1
			})
			fadeTween:Play()
			
			-- Reset pour le prochain sprint
			task.delay(2.0, function()
				ghostStartPosition = nil
			end)
		end
	end
	
	-- Warning
	if stamina < 20 then
		warningLabel.Text = "⚠️ EXHAUSTED!"
		warningLabel.BackgroundColor3 = Color3.fromHex("05848e")
		warningLabel.Visible = true
		PulseWarning()
	else
		if warningLabel.Text:find("EXHAUSTED") then
			warningLabel.Visible = false
			if pulseAnimation then
				pulseAnimation:Cancel()
				pulseAnimation = nil
			end
		end
	end
	
	lastStamina = stamina
end

-- Écouter les changements de stamina
local function setupStaminaListener()
	local character = player.Character
	if character then
		character:GetAttributeChangedSignal("Stamina"):Connect(UpdateStamina)
		character:GetAttributeChangedSignal("IsSprinting"):Connect(UpdateStamina) -- Listen for sprint stop
		UpdateStamina()
	end
end

player.CharacterAdded:Connect(setupStaminaListener)
if player.Character then
	setupStaminaListener()
end

-- Listen for updates (Health & Hunger)
local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local updateStatsEvent = eventsFolder:WaitForChild("UpdateStats", 10)

if updateStatsEvent then
	updateStatsEvent.OnClientEvent:Connect(UpdateStats)
else
	warn("⚠️ StatsUI: Could not find UpdateStats event!")
end

print("📊 StatsUI: Ready! (Linear Reverted)")
