# 💰 Roblox Project 1 — Secure Money Button System

Este projeto é um mini-jogo criado no Roblox Studio com o objetivo de aprender a arquitetura correta de jogos no Roblox, utilizando separação entre Client e Server, RemoteEvents e um sistema seguro de dinheiro.

O jogador pode clicar em um botão na interface para ganhar dinheiro, mas todo o processamento acontece no servidor, impedindo exploits.

---

## 🧠 O que este projeto ensina

- Diferença entre Client e Server
- Uso de `RemoteEvent` para comunicação em rede
- Criação de sistema de dinheiro seguro
- Uso de `leaderstats`
- Sistema de cooldown no servidor
- Arquitetura profissional de jogos Roblox

---

## 🗂 Estrutura do Projeto

ReplicatedStorage
└── GiveMoney (RemoteEvent)

ServerScriptService
└── MoneyServer (Script)

StarterGui
└── ScreenGui
└── TextButton
└── MoneyClient (LocalScript)


---

## 🔁 Fluxo do Sistema

1. O jogador clica no botão na interface
2. O LocalScript envia um pedido ao servidor usando `GiveMoney:FireServer()`
3. O servidor recebe o evento
4. O servidor valida o jogador
5. O servidor adiciona +10 de Cash
6. O leaderboard é atualizado

Nenhum dinheiro é criado no client.

---

## 🧾 Código — Server (MoneyServer)

```lua
local Players = game.Players
local event = game.ReplicatedStorage.GiveMoney
local cooldown = {}

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = 0
    cash.Parent = leaderstats
end)

event.OnServerEvent:Connect(function(player)
    if cooldown[player] then
        return
    end

    cooldown[player] = true
    player.leaderstats.Cash.Value += 10

    task.delay(2, function()
        cooldown[player] = nil
    end)
end)
```

## 🧾 Código — Client (MoneyClient)
```
  local button = script.Parent
local event = game.ReplicatedStorage.GiveMoney

button.MouseButton1Click:Connect(function()
    event:FireServer()
end)
```

## 🔐 Segurança

- O dinheiro só pode ser alterado no servidor

- O client apenas envia pedidos

- O servidor valida e aplica as mudanças

- O cooldown impede spam e exploits
