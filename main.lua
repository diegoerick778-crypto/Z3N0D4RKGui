-- Versão Consolidada para GitHub (Tung Tung Sahur Executor v1.2)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove versões antigas da tela para não duplicar
if playerGui:FindFirstChild("TungTungExecutorGui") then
	playerGui.TungTungExecutorGui:Destroy()
end

-- Tela Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TungTungExecutorGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Janela Principal do Executor (Design Marrom)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -310, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(65, 43, 21)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(139, 90, 43)
mainFrame.Active = true
mainFrame.Draggable = true 
mainFrame.Parent = screenGui

-- Título Principal
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(48, 32, 15)
titleLabel.Text = "  [TUNG_TUNG_SAHUR_EXECUTOR_v1.2] owner tiktok:anonymous.zz76"
titleLabel.TextColor3 = Color3.fromRGB(244, 226, 198)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.RobotoMono
titleLabel.TextSize = 14
titleLabel.Parent = mainFrame

-- Caixa de Texto (Editor de Código)
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 430, 0, 180)
textBox.Position = UDim2.new(0, 10, 0, 40)
textBox.BackgroundColor3 = Color3.fromRGB(35, 23, 11)
textBox.TextColor3 = Color3.fromRGB(200, 255, 200)
textBox.Text = "-- Cole ou digite seu script cuzudo aqui..."
textBox.ClearTextOnFocus = false
textBox.MultiLine = true
textBox.TextSize = 14
textBox.Font = Enum.Font.Code
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.TextYAlignment = Enum.TextYAlignment.Top
textBox.Parent = mainFrame

-- Botão EXECUTE
local executeBtn = Instance.new("TextButton")
executeBtn.Size = UDim2.new(0, 120, 0, 35)
executeBtn.Position = UDim2.new(0, 10, 0, 235)
executeBtn.BackgroundColor3 = Color3.fromRGB(102, 68, 33)
executeBtn.Text = "EXECUTE"
executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
executeBtn.Font = Enum.Font.RobotoMono
executeBtn.TextSize = 14
executeBtn.Parent = mainFrame

-- Botão CLEAR
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 120, 0, 35)
clearBtn.Position = UDim2.new(0, 140, 0, 235)
clearBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 25)
clearBtn.Text = "CLEAR"
clearBtn.TextColor3 = Color3.fromRGB(244, 226, 198)
clearBtn.Font = Enum.Font.RobotoMono
clearBtn.TextSize = 14
clearBtn.Parent = mainFrame

-- Botão Fechar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 16
closeBtn.Parent = mainFrame

----------------------------------------------------
-- PAINEL LATERAL DE UPLOADS (SALVOS)
----------------------------------------------------
local sidePanel = Instance.new("Frame")
sidePanel.Name = "SidePanel"
sidePanel.Size = UDim2.new(0, 160, 0, 280)
sidePanel.Position = UDim2.new(1, 5, 0, 0)
sidePanel.BackgroundColor3 = Color3.fromRGB(55, 36, 18)
sidePanel.BorderSizePixel = 2
sidePanel.BorderColor3 = Color3.fromRGB(139, 90, 43)
sidePanel.Parent = mainFrame

-- Título do Painel Lateral
local sideTitle = Instance.new("TextLabel")
sideTitle.Size = UDim2.new(1, 0, 0, 30)
sideTitle.BackgroundColor3 = Color3.fromRGB(40, 26, 12)
sideTitle.Text = " UPLOADS / SALVOS"
sideTitle.TextColor3 = Color3.fromRGB(244, 226, 198)
sideTitle.Font = Enum.Font.RobotoMono
sideTitle.TextSize = 12
sideTitle.Parent = sidePanel

-- Lista com rolagem (ScrollingFrame)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -75)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 10)
scrollFrame.BackgroundTransparency = 0.3
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = sidePanel

-- Organizador automático em lista
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 5)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = scrollFrame

-- Botão para Adicionar Novo Script (+ ADD SCRIPT)
local addScriptBtn = Instance.new("TextButton")
addScriptBtn.Size = UDim2.new(1, -10, 0, 30)
addScriptBtn.Position = UDim2.new(0, 5, 1, -35)
addScriptBtn.BackgroundColor3 = Color3.fromRGB(120, 85, 45)
addScriptBtn.Text = "[+ ADD SCRIPT]"
addScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
addScriptBtn.Font = Enum.Font.RobotoMono
addScriptBtn.TextSize = 12
addScriptBtn.Parent = sidePanel

----------------------------------------------------
-- SISTEMA DE FUNÇÕES E EXECUÇÃO
----------------------------------------------------

-- Função auxiliar para rodar strings
local function executarCodigo(texto)
	if loadstring then
		local sucesso, erro = pcall(function()
			local func = loadstring(texto)
			if func then func() end
		end)
		if not sucesso then
			warn("Erro no script interno: " .. tostring(erro))
		end
	else
		print("Executando internamente: " .. texto)
	end
end

-- Função para injetar scripts pré-salvos de fábrica
local function adicionarScriptPreSalvo(nome, codigo)
	local scriptBtn = Instance.new("TextButton")
	scriptBtn.Size = UDim2.new(1, -10, 0, 30)
	scriptBtn.BackgroundColor3 = Color3.fromRGB(80, 53, 26)
	scriptBtn.Text = nome
	scriptBtn.TextColor3 = Color3.fromRGB(244, 226, 198)
	scriptBtn.Font = Enum.Font.RobotoMono
	scriptBtn.TextSize = 12
	scriptBtn.Parent = scrollFrame
	
	-- Ajusta dinamicamente a barra de rolagem lateral
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y)
	
	scriptBtn.MouseButton1Click:Connect(function()
		textBox.Text = codigo
		executarCodigo(codigo)
	end)
end

-- INJEÇÃO DE FÁBRICA: Carrega o Dex Explorer automaticamente na lista
adicionarScriptPreSalvo("Dex Explorer plus", 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-Explorer-plus-50432"))()')

-- Ação do botão principal EXECUTE
executeBtn.MouseButton1Click:Connect(function()
	executarCodigo(textBox.Text)
end)

-- Ação do botão CLEAR
clearBtn.MouseButton1Click:Connect(function()
	textBox.Text = ""
end)

-- Ação do botão FECHAR (X)
closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Mecânica para o usuário criar novos botões manualmente
addScriptBtn.MouseButton1Click:Connect(function()
	local inputFrame = Instance.new("Frame")
	inputFrame.Size = UDim2.new(0, 300, 0, 160)
	inputFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
	inputFrame.BackgroundColor3 = Color3.fromRGB(45, 30, 15)
	inputFrame.BorderSizePixel = 2
	inputFrame.BorderColor3 = Color3.fromRGB(139, 90, 43)
	inputFrame.ZIndex = 5
	inputFrame.Parent = screenGui
	
	local nameInput = Instance.new("TextBox")
	nameInput.Size = UDim2.new(1, -20, 0, 30)
	nameInput.Position = UDim2.new(0, 10, 0, 15)
	nameInput.BackgroundColor3 = Color3.fromRGB(30, 20, 10)
	nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameInput.PlaceholderText = "Nome do Script"
	nameInput.Text = ""
	nameInput.ZIndex = 5
	nameInput.Parent = inputFrame
	
	local linkInput = Instance.new("TextBox")
	linkInput.Size = UDim2.new(1, -20, 0, 50)
	linkInput.Position = UDim2.new(0, 10, 0, 55)
	linkInput.BackgroundColor3 = Color3.fromRGB(30, 20, 10)
	linkInput.TextColor3 = Color3.fromRGB(200, 255, 200)
	linkInput.PlaceholderText = "Cole o link ou loadstring aqui..."
	linkInput.Text = ""
	linkInput.MultiLine = true
	linkInput.ZIndex = 5
	linkInput.Parent = inputFrame
	
	local saveBtn = Instance.new("TextButton")
	saveBtn.Size = UDim2.new(0, 100, 0, 30)
	saveBtn.Position = UDim2.new(0.5, -50, 0, 115)
	saveBtn.BackgroundColor3 = Color3.fromRGB(102, 68, 33)
	saveBtn.Text = "SALVAR"
	saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	saveBtn.Font = Enum.Font.RobotoMono
	saveBtn.ZIndex = 5
	saveBtn.Parent = inputFrame
	
	saveBtn.MouseButton1Click:Connect(function()
		local nomeScript = nameInput.Text
		local conteudoScript = linkInput.Text
		
		if nomeScript ~= "" and conteudoScript ~= "" then
			adicionarScriptPreSalvo(nomeScript, conteudoScript)
			inputFrame:Destroy()
		end
	end)
end)
