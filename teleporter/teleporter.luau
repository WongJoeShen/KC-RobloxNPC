
-- Get the TeleportService, which allows teleporting players to other games
local TeleportService = game:GetService("TeleportService")

-- Set the ID of the game to teleport to. Replace with your actual game ID
local gameID = 17244533263

-- Function that runs when something touches the part with this script
function onTouched(hit)
	-- Check if the object that touched the part is a player character
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)

	-- If it’s a player (not something else), teleport them
	if player then
		-- Teleport the player to the game with the ID provided above
		TeleportService:Teleport(gameID, player)
	end
end

-- Connect the "Touched" event of the part to the onTouched function
script.Parent.Touched:connect(onTouched)