local npc = script.Parent
local hrpOfNPC = npc:FindFirstChild("HumanoidRootPart")
local humanoid = npc:WaitForChild("Humanoid")

local plrsHit = {} -- Stores players on cooldown
local maxDistance = math.huge
local messageCooldown = 2 -- Cooldown before talking again
local stopDuration = 3 -- Time NPC stops moving after touching a player
local avoidDuration = 60 -- 10 minutes before NPC can target the same player again

local isStopped = false -- Prevents movement while interacting

-- Function to make NPC talk
local function talkToPlayer(player)
	local chatService = game:GetService("Chat")
	local character = player.Character
	if character then
		local npcHead = npc:FindFirstChild("Head")
		if npcHead then
			chatService:Chat(npcHead, "Hello there, " .. player.Name .. "!", Enum.ChatColor.Green)
		end
	end
end

-- Interaction Handling
npc.Humanoid.Touched:Connect(function(touch)
	local player = game.Players:GetPlayerFromCharacter(touch.Parent)
	if player and not plrsHit[player] then
		plrsHit[player] = os.time() -- Store time when player was interacted with
		isStopped = true -- Stop NPC movement
		talkToPlayer(player)

		-- Wait before allowing movement again
		task.wait(stopDuration)
		isStopped = false

		-- Reset cooldown for talking
		task.wait(messageCooldown)
		print(plrsHit)
	end
end)

-- NPC Movement Logic
game:GetService("RunService").Heartbeat:Connect(function()
	if isStopped then return end -- Prevent movement when stopped

	local plrs = game.Players:GetPlayers()
	local closestHRP = nil
	local minDistance = maxDistance

	for i, plr in pairs(plrs) do
		if plr.Character and not plrsHit[plr] or (os.time() - plrsHit[plr] > avoidDuration) then
			local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
			local humanoid = plr.Character:FindFirstChild("Humanoid")

			if hrp and humanoid and humanoid.Health > 0 then
				local distance = (hrpOfNPC.Position - hrp.Position).Magnitude
				if distance < minDistance then
					minDistance = distance
					closestHRP = hrp
				end
			end
		end
	end

	if closestHRP and minDistance <= maxDistance then
		humanoid:MoveTo(closestHRP.Position)
	end
end)
