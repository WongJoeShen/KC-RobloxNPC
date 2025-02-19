-- Put this script as a direct child of the Cleaner Rig Model --
local npc = script.Parent
local humanoid = npc:FindFirstChild("Humanoid")
local chatService = game:GetService("Chat")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

local chatRange = 10 -- Maximum distance for players to trigger chat
local cleanedBlocks = 0 -- Counter for cleaned blocks
local canSpeak = true -- Prevents spam chatting

-- Get the event that signals when a block is destroyed
local blockDestroyedEvent = replicatedStorage:FindFirstChild("PartDestroyedEvent")

-- Function to make the NPC chat
local function speak(message)
	if canSpeak then
		chatService:Chat(npc.HumanoidRootPart, message, Enum.ChatColor.Green)
		canSpeak = false -- Prevent immediate repeats
		task.delay(3, function() canSpeak = true end) -- Cooldown before speaking again
	end
end

-- Function to track cleaned blocks
local function onBlockDestroyed()
	cleanedBlocks += 1
	print("Blocks cleaned:", cleanedBlocks)

	-- NPC reacts based on how many blocks have been cleaned
	if cleanedBlocks == 3 then
		speak("What a mess")
	elseif cleanedBlocks == 6 then
		speak("Ok this is getting out of hand...")
	elseif cleanedBlocks == 10 then
		speak("CAN SOMEONE KEEP THIS PLACE CLEAN?!?!")
		cleanedBlocks = 0 -- Reset counter after comment
	end
end

-- Listen for the event when a block is destroyed
if blockDestroyedEvent then
	blockDestroyedEvent.Event:Connect(onBlockDestroyed)
end

-- Detect if a nearby player sends a chat message
local function onPlayerChatted(player, message)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local playerPosition = character.HumanoidRootPart.Position
		local npcPosition = npc.HumanoidRootPart.Position
		local distance = (npcPosition - playerPosition).Magnitude

		-- Only respond if the player is close enough
		if distance <= chatRange then
			speak("I'm just a cleaner. If you have questions, try asking the trainer.")
		end
	end
end

-- Connect to all current players and listen for chat messages
for _, player in pairs(players:GetPlayers()) do
	player.Chatted:Connect(function(message)
		onPlayerChatted(player, message)
	end)
end

-- Connect to future players who join
players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		onPlayerChatted(player, message)
	end)
end)
