local PathFindingService = game:GetService("PathfindingService")

local human = script.Parent:WaitForChild("Humanoid")
local torso = script.Parent:WaitForChild("HumanoidRootPart")

local path = PathFindingService:CreatePath()  
path:ComputeAsync(torso.Position, game.Workspace.EndingPart.Position)
local waypoints = path:GetWaypoints()


for i, waypoint in pairs(waypoints) do
	if waypoint.Action == Enum.PathWaypointAction.Jump then
		human:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	human:MoveTo(waypoint.Position)
	human.MoveToFinished:Wait(2)
end

human:MoveTo(game.Workspace.EndingPart.Position)