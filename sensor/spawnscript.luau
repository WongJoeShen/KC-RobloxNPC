-- This script should be placed in ServerScriptService --

-- Don't forget to add the RemoteEvent objects to ReplicatedStorage --
local spawnEvent = game.ReplicatedStorage:FindFirstChild("SpawnPartEvent")
local moveEvent = game.ReplicatedStorage:FindFirstChild("MoveNPCEvent") -- Get NPC movement event

spawnEvent.OnServerEvent:Connect(function(player, position)
	local main = game.ReplicatedStorage:FindFirstChild("SpawnPart")
	if not main then return end

	local npart = main:Clone()
	npart.Parent = game.Workspace
	npart.Anchored = false
	npart.CanCollide = true
	npart.CanTouch = true
	npart.Position = position

	print("Spawned part at:", npart.Position)

	-- ✅ Fire MoveNPCEvent to tell the NPC to go to the part
	if moveEvent then
		moveEvent:FireAllClients(npart.Position, npart)
	end
end)
