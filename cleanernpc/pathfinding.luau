local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SimplePath = require(ServerStorage.SimplePath)

local npc = script.Parent
local root = npc:FindFirstChild("HumanoidRootPart")
local humanoid = npc:FindFirstChildOfClass("Humanoid")

if not root or not humanoid then 
	warn("NPC missing root or humanoid!")
	return 
end

local SpObj = SimplePath.new(npc)
SpObj.Visualize = true

local stopDistance = 2
local footprintQueue = {} -- Store footprints in a table
local isCleaning = false
local isReturning = false
local startPosition = root.Position -- Save the NPC's starting position

-- **🏠 Return NPC to starting position**
local function returnToStart()
	if isReturning or isCleaning then return end
	isReturning = true

	print("Returning to starting position:", startPosition)
	local success = SpObj:Run(startPosition)

	if success then
		SpObj.Reached:Once(function()
			print("NPC returned to starting position.")
			isReturning = false
		end)
	else
		warn("Pathfinding to start position failed!")
		isReturning = false
	end
end

-- **🧹 Process footprints**
local function processFootprints()
	if isCleaning then return end
	isCleaning = true
	isReturning = false -- Stop returning if new footprints appear

	while next(footprintQueue) do
		local footprints = {}
		for footprint, _ in pairs(footprintQueue) do
			if footprint and footprint.Parent then
				table.insert(footprints, footprint)
			else
				footprintQueue[footprint] = nil
			end
		end

		table.sort(footprints, function(a, b)
			return (root.Position - a.Position).Magnitude < (root.Position - b.Position).Magnitude
		end)

		for _, footprint in ipairs(footprints) do
			local targetPos = footprint.Position
			local direction = (targetPos - root.Position).Unit
			local adjustedPosition = targetPos - (direction * stopDistance)

			print("Moving to footprint:", footprint, "Adjusted Pos:", adjustedPosition)

			local success = SpObj:Run(adjustedPosition)
			if not success then
				warn("Pathfinding failed!")
				footprintQueue[footprint] = nil
				continue
			end

			SpObj.Reached:Once(function()
				print("Reached footprint:", footprint)
				footprint:Destroy()
				footprintQueue[footprint] = nil
			end)

			task.wait(1.5)
		end
	end

	isCleaning = false
	task.wait(3) -- Wait a bit before returning to start
	if not next(footprintQueue) then
		returnToStart()
	end
end

-- **📌 Add footprint to queue**
local function addFootprint(footprint)
	if not footprintQueue[footprint] then
		footprintQueue[footprint] = true
		print("Added footprint:", footprint, "Total:", #footprintQueue)

		if not isCleaning then
			task.spawn(processFootprints)
		end
	end
end

-- **👣 Detect new footprints**
workspace.ChildAdded:Connect(function(child)
	if child:IsA("BasePart") and child.Name == "SpawnPart" then
		print("New footprint detected:", child)
		addFootprint(child)
	end
end)
