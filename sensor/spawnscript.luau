local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sensor = script.Parent  -- Sensor part
local spawnPartTemplate = ReplicatedStorage:FindFirstChild("SpawnPart")  -- Transparent part with decal
local footsteps = {}  -- Track footsteps per player

local FOOTSTEP_THRESHOLD = 9  -- Number of footsteps before spawning
local HEIGHT_OFFSET = 0.1  -- Adjust if needed to ensure it's on the ground

sensor.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(character)

	if player and (hit.Name == "LeftFoot" or hit.Name == "RightFoot") then
		local playerId = player.UserId
		footsteps[playerId] = (footsteps[playerId] or 0) + 1

		print("Footstep detected:", hit.Name, "from", player.Name, "Count:", footsteps[playerId])

		if footsteps[playerId] >= FOOTSTEP_THRESHOLD then
			footsteps[playerId] = 0  -- Reset count

			-- Spawn part behind player and rotate it
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and spawnPartTemplate then
				local newPart = spawnPartTemplate:Clone()
				newPart.Anchored = true  -- Ensure it stays in place
				local position = humanoidRootPart.Position - (humanoidRootPart.CFrame.LookVector * 2)
				newPart.Position = Vector3.new(position.X, sensor.Position.Y + HEIGHT_OFFSET, position.Z) -- Align to ground

				-- Adjust rotation
				local lookVector = humanoidRootPart.CFrame.LookVector
				local rotation = CFrame.lookAt(newPart.Position, newPart.Position + lookVector) * CFrame.Angles(0, math.rad(180), 0)
				newPart.CFrame = rotation

				newPart.Parent = workspace
			end
		end
	end
end)
