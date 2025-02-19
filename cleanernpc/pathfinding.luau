-- Put this script inside the Humanoid of the Cleaner Rig Model --
local bot = script.Parent
local human = bot.Humanoid
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Don't forget to add the BindableEvent object to ReplicatedStorage --
local blockDestroyedEvent = replicatedStorage:FindFirstChild("PartDestroyedEvent")  -- Get the event

task.wait(3)

while true do
	local foundBlock = false  
	for i, j in ipairs(game.Workspace:GetChildren()) do
		if j.Name == "SpawnPart" then
			human:MoveTo(j.Position)
			human.MoveToFinished:Wait()

			j:Destroy()
			print("Destroyed SpawnPart at:", j.Position)

			if blockDestroyedEvent then
				blockDestroyedEvent:Fire()  -- Notify the Cleaner NPC script
			end

			foundBlock = true  
			break  
		end
	end

	if not foundBlock then
		task.wait(1)  
	end
end
