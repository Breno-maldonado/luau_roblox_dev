local button = script.Parent
local event = game.ReplicatedStorage.GiveMoney

button.MouseButton1Click:Connect(function()
	event:FireServer()
end)