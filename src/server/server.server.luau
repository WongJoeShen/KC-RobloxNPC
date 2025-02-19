--[[ 
  NPC Chatbot Script (Roblox)
  - Listens for player messages
  - Sends messages to a remote AI API
  - Displays AI responses as NPC dialogue
--]]

-- SERVICES --
local c = game:GetService("Chat")         -- Chat service for displaying NPC dialogue
local HS = game:GetService("HttpService") -- HttpService for sending API requests

-- VARIABLES --
local npc = workspace:WaitForChild("Trainer") -- Find the NPC in the workspace
local promise = require(script:WaitForChild("promise")) -- Load promise module for handling async tasks

local api = "https://knowing-spark-yarn.glitch.me/" -- API endpoint for AI chatbot

local history = {} -- Stores conversation history for better responses

-- FUNCTIONS --

-- Function to send a request to the AI API
local function apirequest(prompt)
	print("Requesting response") -- Debugging log

	local success, message = promise.retryWithDelay(function()
		return promise.try(function()
			-- Prepare the request payload with user input and chat history
			local body = {
				prompt = prompt,
				history = history
			}
			body = HS:JSONEncode(body) -- Convert table to JSON

			-- Send an HTTP POST request to the AI API
			local response = HS:RequestAsync({
				Url = api,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json" -- Specify JSON format
				},
				Body = body
			})

			-- Check if the request was successful
			if response.Success then
				return response.Body -- Return AI response
			else
				error(response.StatusCode .. "-" .. response.StatusMessage) -- Handle errors
			end
		end)
	end, 5, 5):await() -- Retry up to 5 times with a 5-second delay

	print("Request done") -- Debugging log

	if success then
		return message -- Return AI response text
	else
		warn(message) -- Log error message
		return nil
	end
end

-- Function to make the NPC display chat messages
local function chat(message)
	local head = npc:WaitForChild("Head") -- Get NPC's head (required for chat bubble)
	c:Chat(head, message) -- Display message in chat bubble
end

-- EVENTS --

-- When a player joins, set up chat listener
game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(message)
		local response = apirequest(message) -- Send player's message to AI

		if response then
			-- Save user message to chat history
			table.insert(history, {
				role = "user",
				parts = {{
					text = message
				}}
			})

			-- Save AI response to chat history
			table.insert(history, {
				role = "model",
				parts = {{
					text = response 
				}}
			})

			chat(response) -- Make NPC say the AI's response
		end
	end)
end)
