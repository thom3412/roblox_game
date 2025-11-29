local Players = game:GetService("Players")
local PlayerInventory = require(script.Parent:WaitForChild("PlayerInventory"))

-- Initialize the system
PlayerInventory.Init()

-- Handle player joining
Players.PlayerAdded:Connect(function(player)
	PlayerInventory.OnPlayerAdded(player)
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
	PlayerInventory.OnPlayerRemoving(player)
end)

print("✅ Inventory system initialized!")
