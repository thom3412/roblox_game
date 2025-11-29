-- Sprint and Crouch System with Stamina
-- Shift = Sprint, C = Crouch (Toggle)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Configuration
local NORMAL_SPEED = 16
local SPRINT_SPEED = 24
local CROUCH_SPEED = 8

-- Stamina Configuration
local MAX_STAMINA = 100
local STAMINA_DRAIN_RATE = 15 -- par seconde
local STAMINA_REGEN_RATE = 10 -- par seconde
local STAMINA_REGEN_DELAY = 3.0 -- délai avant regen (2s animation + 1s pause)

-- Animation de Crouch
local CROUCH_ANIM_ID = "rbxassetid://107697526413845"
local crouchTrack = nil

-- Fonction pour charger l'animation
local function loadAnimations()
	if humanoid then
		local anim = Instance.new("Animation")
		anim.AnimationId = CROUCH_ANIM_ID
		crouchTrack = humanoid:LoadAnimation(anim)
		crouchTrack.Priority = Enum.AnimationPriority.Action
		crouchTrack.Looped = true
	end
end

loadAnimations()

-- État
local isSprinting = false
local isCrouching = false
local currentStamina = MAX_STAMINA
local lastSprintTime = 0

-- Get or create Events folder
local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
if not eventsFolder then
	eventsFolder = Instance.new("Folder")
	eventsFolder.Name = "Events"
	eventsFolder.Parent = ReplicatedStorage
end

-- Get or create UpdateStats event
local updateStatsEvent = eventsFolder:FindFirstChild("UpdateStats")
if not updateStatsEvent then
	updateStatsEvent = Instance.new("RemoteEvent")
	updateStatsEvent.Name = "UpdateStats"
	updateStatsEvent.Parent = eventsFolder
end

-- Fonction pour notifier l'UI
local function updateUI()
	-- On envoie les stats au client (même si on est déjà sur le client, ça passe par l'event)
	-- Pour Stamina seulement (Health et Hunger seront gérés par le serveur normalement)
	local stats = {
		Health = humanoid.Health,
		Hunger = 100, -- Placeholder
		Stamina = math.floor(currentStamina)
	}
	
	-- Déclencher l'événement localement pour l'UI
	if updateStatsEvent then
		-- On ne peut pas faire OnClientEvent depuis le client, donc on utilise des attributes
		character:SetAttribute("Stamina", math.floor(currentStamina))
		character:SetAttribute("MaxStamina", MAX_STAMINA)
		character:SetAttribute("IsSprinting", isSprinting) -- Sync state for UI
	end
end

-- Fonction pour mettre à jour la vitesse et l'animation
local function updateMovementState()
	if isCrouching then
		-- Crouch
		humanoid.WalkSpeed = CROUCH_SPEED
		if crouchTrack and not crouchTrack.IsPlaying then
			crouchTrack:Play(0.2)
		end
	elseif isSprinting and currentStamina > 0 then
		-- Sprint (seulement si stamina disponible)
		humanoid.WalkSpeed = SPRINT_SPEED
		if crouchTrack and crouchTrack.IsPlaying then
			crouchTrack:Stop(0.2)
		end
	else
		-- Normal
		humanoid.WalkSpeed = NORMAL_SPEED
		if crouchTrack and crouchTrack.IsPlaying then
			crouchTrack:Stop(0.2)
		end
		-- Si on essaie de sprinter mais pas de stamina, on force l'arrêt
		if isSprinting and currentStamina <= 0 then
			isSprinting = false
		end
	end
end

-- Gestion de la stamina
local lastUpdate = tick()
RunService.Heartbeat:Connect(function()
	local now = tick()
	local deltaTime = now - lastUpdate
	lastUpdate = now
	
	-- Drain de stamina pendant le sprint
	if isSprinting and humanoid.MoveDirection.Magnitude > 0.1 and currentStamina > 0 then
		currentStamina = math.max(0, currentStamina - (STAMINA_DRAIN_RATE * deltaTime))
		lastSprintTime = now
		updateMovementState()
		updateUI()
	
	-- Régénération de stamina
	elseif currentStamina < MAX_STAMINA then
		-- Vérifier le délai de regen
		if (now - lastSprintTime) >= STAMINA_REGEN_DELAY then
			currentStamina = math.min(MAX_STAMINA, currentStamina + (STAMINA_REGEN_RATE * deltaTime))
			updateUI()
		end
	end
end)

-- Gestion des inputs
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = true
		-- Si on court, on se lève
		if isCrouching then
			isCrouching = false
		end
		updateMovementState()
		updateUI() -- Force update to notify UI of sprint start
		
	elseif input.KeyCode == Enum.KeyCode.C then
		-- Toggle Crouch (On/Off)
		isCrouching = not isCrouching
		updateMovementState()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = false
		lastSprintTime = tick() -- Mettre à jour le temps pour la regen
		updateMovementState()
		updateUI() -- Update immédiat pour sync visuel
	end
end)

-- Réinitialiser à chaque respawn
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	
	loadAnimations()
	
	isSprinting = false
	isCrouching = false
	currentStamina = MAX_STAMINA
	lastSprintTime = 0
	updateMovementState()
	updateUI()
end)

-- Initialiser l'UI
updateUI()

print("🏃 [Movement] Sprint (Hold Shift) et Crouch (Toggle C) activés avec Stamina")
