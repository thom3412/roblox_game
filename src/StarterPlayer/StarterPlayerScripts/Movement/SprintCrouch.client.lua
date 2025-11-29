-- Sprint and Crouch System
-- Shift = Sprint, C = Crouch (Toggle)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Configuration
local NORMAL_SPEED = 16
local SPRINT_SPEED = 24
local CROUCH_SPEED = 8

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

-- Fonction pour mettre à jour la vitesse et l'animation
local function updateMovementState()
	if isCrouching then
		-- Crouch
		humanoid.WalkSpeed = CROUCH_SPEED
		if crouchTrack and not crouchTrack.IsPlaying then
			crouchTrack:Play(0.2)
		end
	elseif isSprinting then
		-- Sprint
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
	end
end

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
		
	elseif input.KeyCode == Enum.KeyCode.C then
		-- Toggle Crouch (On/Off)
		isCrouching = not isCrouching
		updateMovementState()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = false
		updateMovementState()
	end
	-- On ne gère plus le relâchement de C car c'est un toggle
end)

-- Réinitialiser à chaque respawn
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	
	loadAnimations()
	
	isSprinting = false
	isCrouching = false
	updateMovementState()
end)

print("🏃 [Movement] Sprint (Hold Shift) et Crouch (Toggle C) activés")
