-- Put this script inside the Humanoid of the Cleaner Rig Model --
local bot = script.Parent
local human = bot.Humanoid
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Get the event that signals when a part is destroyed
local blockDestroyedEvent = replicatedStorage:FindFirstChild("PartDestroyedEvent")

task.wait(3) -- Initial delay before the NPC starts working

while true do
	local foundBlock = false  -- Tracks if any block was found

	-- Loop through all objects in the workspace
	for _, obj in ipairs(game.Workspace:GetChildren()) do
		if obj.Name == "SpawnPart" then
			human:MoveTo(obj.Position) -- Move NPC to the block
			human.MoveToFinished:Wait() -- Wait until NPC reaches the block

			obj:Destroy() -- Remove the block
			print("Destroyed SpawnPart at:", obj.Position)

			-- Notify the Cleaner NPC script about the destroyed block
			if blockDestroyedEvent then
				blockDestroyedEvent:Fire()
			end

			foundBlock = true  -- A block was found and cleaned
			break  -- Stop searching after cleaning one block
		end
	end

	-- If no blocks were found, wait before checking again
	if not foundBlock then
		task.wait(1)
	end
end
