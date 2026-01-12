local Players = game.Players

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 0
	cash.Parent = leaderstats
end)

local event = game.ReplicatedStorage.GiveMoney
local cooldown = {}

event.OnServerEvent:Connect(function(player)
	if cooldown[player] then
		return -- ignora se estiver em cooldown
	end

	cooldown[player] = true

	player.leaderstats.Cash.Value += 10

	task.delay(2, function()
		cooldown[player] = nil
	end)
end)
