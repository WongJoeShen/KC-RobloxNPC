-- This script should be added as a child of the Sensor block --
-- Get the parent of this script, which is the part acting as the sensor
local sensor = script.Parent

-- When something touches the sensor part, this function is triggered
sensor.Touched:Connect(function(hit)
	-- Print the name of the object that touched the sensor, and its collision properties
	print(string.format("Touched by: %s | Position: (%.2f, %.2f, %.2f)", hit.Name, hit.Position.X, hit.Position.Y, hit.Position.Z))
end)