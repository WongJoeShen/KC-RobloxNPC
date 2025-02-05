-- SERVICES --
local c = game:GetService("Chat")
local HS = game:GetService("HttpService")

-- VARIABLES --
local npc = workspace:WaitForChild("AI BOT")
local promise = require(script:WaitForChild("promise"))

local api = "https://knowing-spark-yarn.glitch.me/"

local history = {}

-- FUNCTIONS --
local function apirequest(prompt)
	print("Requesting response")
	local success,message = promise.retryWithDelay(function()
		return promise.try(function()
			local body = {
				prompt = prompt,
				history = history
			}
			body = HS:JSONEncode(body)
			
			local response = HS:RequestAsync({
				Url = api,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = body
			})
			
			if response.Success then
				return response.Body
			else
				error(response.StatusCode.."-"..response.StatusMessage)
			end
		end)
	end,5,5):await()
	
	print("Request done")
	if success then
		return message
	else
		warn(message)
		return nil
	end
end

local function chat(message)
	local head = npc:WaitForChild("Head")
	c:Chat(head,message)
end

-- EVENTS --
game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(message)
		local response = apirequest(message)
		
		if response then
			table.insert(history,{
				role = "user",
				parts = {{
					text = message
				}}
			})
			table.insert(history,{
				role = "model",
				parts = {{
					text = response 
				}}
			})
			
			chat(response)
		end
	end)
end)

