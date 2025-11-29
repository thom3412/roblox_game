local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerStats = {}

-- Storage for player stats
local playerStats = {}

-- Configuration
local MAX_STATS = 100
local DECAY_RATE = 1 -- Amount to decrease
local DECAY_INTERVAL = 5 -- Seconds
local STARVATION_DAMAGE = 5

function PlayerStats.Init()
	print("❤️ PlayerStats: Initializing...")
	
	-- Create RemoteEvent
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	local updateStatsEvent = eventsFolder:FindFirstChild("UpdateStats")
	
	if not updateStatsEvent then
		updateStatsEvent = Instance.new("RemoteEvent")
		updateStatsEvent.Name = "UpdateStats"
		updateStatsEvent.Parent = eventsFolder
		print("📡 RemoteEvent 'UpdateStats' created")
	end
	
	-- Start decay loop
	task.spawn(function()
		while true do
			task.wait(DECAY_INTERVAL)
			PlayerStats.ProcessDecay()
		end
	end)
	
	print("✅ PlayerStats: Ready!")
end

function PlayerStats.CreateStats(player)
	playerStats[player.UserId] = {
		Health = MAX_STATS,
		Hunger = MAX_STATS,
		Thirst = MAX_STATS
	}
	print("❤️ Created stats for " .. player.Name)
	PlayerStats.SyncStats(player)
end

function PlayerStats.GetStats(player)
	return playerStats[player.UserId]
end

function PlayerStats.ModifyStat(player, statName, amount)
	local stats = playerStats[player.UserId]
	if not stats then return end
	
	if stats[statName] then
		stats[statName] = math.clamp(stats[statName] + amount, 0, MAX_STATS)
		
		-- Handle Health specifically (Roblox Humanoid)
		if statName == "Health" then
			local character = player.Character
			if character and character:FindFirstChild("Humanoid") then
				character.Humanoid.Health = stats.Health
			end
		end
		
		PlayerStats.SyncStats(player)
		return true
	end
	return false
end

function PlayerStats.ProcessDecay()
	for userId, stats in pairs(playerStats) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			-- Decrease Hunger & Thirst
			stats.Hunger = math.max(0, stats.Hunger - DECAY_RATE)
			stats.Thirst = math.max(0, stats.Thirst - (DECAY_RATE * 1.5)) -- Thirst decays faster
			
			-- Starvation / Dehydration Damage
			if stats.Hunger <= 0 or stats.Thirst <= 0 then
				PlayerStats.ModifyStat(player, "Health", -STARVATION_DAMAGE)
				print("⚠️ " .. player.Name .. " is starving/dehydrated!")
			end
			
			PlayerStats.SyncStats(player)
		end
	end
end

function PlayerStats.SyncStats(player)
	local stats = playerStats[player.UserId]
	if not stats then return end
	
	local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
	local updateEvent = eventsFolder and eventsFolder:FindFirstChild("UpdateStats")
	
	if updateEvent then
		updateEvent:FireClient(player, stats)
	end
end

function PlayerStats.OnPlayerAdded(player)
	PlayerStats.CreateStats(player)
	
	-- Hook into CharacterAdded to reset health but keep hunger/thirst? 
	-- Or reset all on death? For now, let's reset all on respawn for simplicity.
	player.CharacterAdded:Connect(function(character)
		-- Ensure stats exist (might be nil if first join)
		if not playerStats[player.UserId] then
			PlayerStats.CreateStats(player)
		else
			-- Reset Health on respawn, keep hunger/thirst? 
			-- Usually in survival games you reset everything or lose items.
			-- Let's reset Health to max, but keep Hunger/Thirst (punishment)
			-- OR reset all. Let's reset all for now to be safe.
			playerStats[player.UserId].Health = MAX_STATS
			playerStats[player.UserId].Hunger = MAX_STATS
			playerStats[player.UserId].Thirst = MAX_STATS
			PlayerStats.SyncStats(player)
		end
		
		-- Listen for Humanoid damage to sync back to our stats
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.HealthChanged:Connect(function(health)
			if playerStats[player.UserId] then
				playerStats[player.UserId].Health = health
				PlayerStats.SyncStats(player)
			end
		end)
	end)
end

function PlayerStats.OnPlayerRemoving(player)
	playerStats[player.UserId] = nil
end

return PlayerStats
