local Players = game:GetService("Players")
local PlayerStats = require(script.Parent:WaitForChild("PlayerStats"))

-- Initialize the system
PlayerStats.Init()

-- Handle player joining
Players.PlayerAdded:Connect(function(player)
	PlayerStats.OnPlayerAdded(player)
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
	PlayerStats.OnPlayerRemoving(player)
end)

print("✅ Stats system initialized!")
