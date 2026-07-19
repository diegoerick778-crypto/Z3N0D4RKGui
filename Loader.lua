-- Versão Consolidada - Loader Principal (Z3N0 D4RK v5.5)
local baseUrl = "https://raw.githubusercontent.com/diegoerick778-crypto/Z3N0D4RKGui/main/"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Limpeza de interfaces antigas para evitar sobreposição
if playerGui:FindFirstChild("Z3N0D4RKGui") then playerGui.Z3N0D4RKGui:Destroy() end
if playerGui:FindFirstChild("TungTungExecutorGui") then playerGui.TungTungExecutorGui:Destroy() end

local CG, UIS, PL, TS = game:GetService("CoreGui"), game:GetService("UserInputService"), game:GetService("Players"), game:GetService("TweenService")
pcall(function() CG:SetCore("SendNotification", {Title = "Z3N0 D4RK v5.5", Text = "Carregando módulos do GitHub...", Duration = 3}) end)

if CG:FindFirstChild("PerplexityExecutor") then CG.PerplexityExecutor:Destroy() end
local HG = Instance.new("ScreenGui", (gethui and gethui()) or CG:FindFirstChild("RobloxGui") or CG or PL.LocalPlayer:WaitForChild("PlayerGui"))
HG.Name, HG.ResetOnSpawn = "PerplexityExecutor", false

-- 1. Baixa e executa as configurações de cores e funções de design
local Config = loadstring(game:HttpGet(baseUrl .. "config.lua"))()

-- 2. Baixa e executa o editor principal (cria a janela e a caixa de texto)
local EditorModule = loadstring(game:HttpGet(baseUrl .. "editor.lua"))()

-- 3. Baixa e executa o painel lateral de scripts salvos
local SidePanelModule = loadstring(game:HttpGet(baseUrl .. "sidepanel.lua"))()

-- 4. Junta todas as partes baixadas na ordem correta de funcionamento
local Main, EditorBox, executarCodigo = EditorModule.Create(HG, Config, TS, UIS, CG)
SidePanelModule.Create(Main, HG, Config, TS, EditorBox, executarCodigo)

pcall(function() CG:SetCore("SendNotification", {Title = "Z3N0 D4RK v5.5", Text = "Executor Pronto para Uso!", Duration = 3}) end)
