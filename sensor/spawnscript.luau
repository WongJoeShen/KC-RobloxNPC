-- This script should be placed in ServerScriptService --

-- Don't forget to add the RemoteEvent objects to ReplicatedStorage --
local spawnEvent = game.ReplicatedStorage:FindFirstChild("SpawnPartEvent")
local moveEvent = game.ReplicatedStorage:FindFirstChild("MoveNPCEvent") -- Event to signal NPC movement

-- Event listener: Executes when a player requests to spawn a part
spawnEvent.OnServerEvent:Connect(function(player, position)
	local main = game.ReplicatedStorage:FindFirstChild("SpawnPart")
	if not main then return end -- Exit if the part template is missing

	local npart = main:Clone() -- Create a copy of the part
	npart.Parent = game.Workspace -- Place it in the game world
	npart.Anchored = false -- Allow physics interactions
	npart.CanCollide = true -- Enable collisions
	npart.CanTouch = true -- Allow touch interactions
	npart.Position = position -- Position the part where requested

	print("Spawned part at:", npart.Position)

	-- Notify NPCs to move to the spawned part
	if moveEvent then
		moveEvent:FireAllClients(npart.Position, npart)
	end
end)
