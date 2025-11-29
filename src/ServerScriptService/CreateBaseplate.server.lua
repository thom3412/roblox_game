-- Simple script to create a ground plane
local Workspace = game:GetService("Workspace")

-- Create a baseplate if it doesn't exist
local baseplate = Workspace:FindFirstChild("Baseplate")

if not baseplate then
	baseplate = Instance.new("Part")
	baseplate.Name = "Baseplate"
	baseplate.Size = Vector3.new(512, 1, 512)
	baseplate.Position = Vector3.new(0, -0.5, 0)
	baseplate.Anchored = true
	baseplate.Color = Color3.fromRGB(106, 127, 91) -- Green
	baseplate.Material = Enum.Material.Grass
	baseplate.Parent = Workspace
	
	print("✅ Baseplate created!")
else
	print("ℹ️ Baseplate already exists")
end
