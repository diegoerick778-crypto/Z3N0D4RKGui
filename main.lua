-- Versão Consolidada para GitHub (Tung Tung Sahur Executor v1.2) - Black Edition
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove versões antigas da tela para não duplicar
if playerGui:FindFirstChild("Z3N0D4RKGui") then playerGui.Z3N0D4RKGui:Destroy() end
if playerGui:FindFirstChild("TungTungExecutorGui") then playerGui.TungTungExecutorGui:Destroy() end

local CG, UIS, PL, TS = game:GetService("CoreGui"), game:GetService("UserInputService"), game:GetService("Players"), game:GetService("TweenService")

pcall(function() CG:SetCore("SendNotification", {Title = "Z3N0 D4RK v5.5", Text = "Logo Adicionada com Sucesso!", Duration = 3}) end)

if CG:FindFirstChild("PerplexityExecutor") then CG.PerplexityExecutor:Destroy() end
local HG = Instance.new("ScreenGui", (gethui and gethui()) or CG:FindFirstChild("RobloxGui") or CG or PL.LocalPlayer:WaitForChild("PlayerGui"))
HG.Name, HG.ResetOnSpawn = "PerplexityExecutor", false

-- ====================================================
-- CONFIGURAÇÕES DE CORES (TEMA CINZA ESCURO SÓLIDO)
-- ====================================================
local MAIN_BG = Color3.fromRGB(25, 25, 25)       -- Cinza Escuro Sólido
local TOP_BG = Color3.fromRGB(18, 18, 18)        -- Cinza Mais Escuro para o Topo
local BTN_BG = Color3.fromRGB(35, 35, 35)        -- Cinza dos Botões
local BORDER_COLOR = Color3.fromRGB(70, 70, 70)  -- Borda Cinza
local TEXT_WHITE = Color3.fromRGB(255, 255, 255)  -- Branco Puro
local LIGHT_GREEN = Color3.fromRGB(120, 255, 120) -- Verde Claro para Destaques

-- Funções Auxiliares de Design
local function addCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent
end

local function addStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
end

local function AddAnim(btn)
	local orig = btn.BackgroundColor3
	btn.MouseButton1Down:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
	btn.MouseButton1Up:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = orig}):Play() end)
	btn.MouseLeave:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = orig}):Play() end)
end

-- ====================================================
-- INTERFACE PRINCIPAL (SÓLIDA)
-- ====================================================
local Main = Instance.new("Frame", HG)
Main.Size = UDim2.new(0, 560, 0, 340)
Main.Position = UDim2.new(0.5, -280, 0.5, -170)
Main.BackgroundColor3 = MAIN_BG
Main.BorderSizePixel = 0
Main.ClipsDescendants = false 
addCorner(Main, 8)
addStroke(Main, BORDER_COLOR, 2)

-- Arrastar Interface (Draggable)
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Barra Superior (Topbar)
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 38)
Top.BackgroundColor3 = TOP_BG
addCorner(Top, 8)

-- LOGO DO EXECUTOR
local Logo = Instance.new("ImageLabel", Top)
Logo.Size = UDim2.new(0, 22, 0, 22)
Logo.Position = UDim2.new(0, 12, 0.5, -11)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://120193086529841"
Logo.ZIndex = 5

-- Nome do Executor
local Tit = Instance.new("TextLabel", Top)
Tit.Size = UDim2.new(1, -90, 0, 38)
Tit.Position = UDim2.new(0, 40, 0, 0)
Tit.BackgroundTransparency = 1
Tit.Text = "[Z3N0_D4RK_v5.5] owner: anonymous.zz76"
Tit.TextColor3 = LIGHT_GREEN 
Tit.Font = Enum.Font.Code
Tit.TextSize = 13
Tit.TextXAlignment = Enum.TextXAlignment.Left
Tit.ZIndex = 5

-- Botão Fechar Topbar
local Cls = Instance.new("TextButton", Top)
Cls.Size = UDim2.new(0, 35, 0, 35)
Cls.Position = UDim2.new(1, -38, 0, 1.5)
Cls.BackgroundTransparency = 1
Cls.Text = "×"
Cls.TextColor3 = TEXT_WHITE 
Cls.Font = Enum.Font.Code
Cls.TextSize = 24
Cls.ZIndex = 5
Cls.MouseButton1Click:Connect(function() HG:Destroy() end)

-- ====================================================
-- ÁREA DO EDITOR DE CÓDIGO 
-- ====================================================
local EdScr = Instance.new("ScrollingFrame", Main)
EdScr.Size = UDim2.new(1, -16, 1, -105) 
EdScr.Position = UDim2.new(0, 8, 0, 46)
EdScr.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
EdScr.BorderSizePixel = 0
EdScr.ScrollBarThickness = 6
EdScr.ScrollBarImageColor3 = BORDER_COLOR
EdScr.AutomaticCanvasSize = Enum.AutomaticSize.XY
addCorner(EdScr, 6)
addStroke(EdScr, BORDER_COLOR, 1)

-- Contador de Linhas
local LineC = Instance.new("TextLabel", EdScr)
LineC.Size = UDim2.new(0, 35, 1, 0)
LineC.Position = UDim2.new(0, 5, 0, 6)
LineC.BackgroundTransparency = 1
LineC.Text = "1"
LineC.TextColor3 = Color3.fromRGB(100, 100, 100)
LineC.Font = Enum.Font.Code
LineC.TextSize = 13
LineC.TextXAlignment = Enum.TextXAlignment.Right
LineC.TextYAlignment = Enum.TextYAlignment.Top

local EditorBox = Instance.new("TextBox", EdScr)
EditorBox.Size = UDim2.new(1, -55, 1, 0)
EditorBox.Position = UDim2.new(0, 50, 0, 6)
EditorBox.BackgroundTransparency = 1
EditorBox.Text = ""
EditorBox.PlaceholderText = "-- Cole seu script aqui..."
EditorBox.TextColor3 = TEXT_WHITE
EditorBox.Font = Enum.Font.Code
EditorBox.TextSize = 13
EditorBox.TextXAlignment = Enum.TextXAlignment.Left
EditorBox.TextYAlignment = Enum.TextYAlignment.Top
EditorBox.MultiLine = true
EditorBox.TextWrapped = false
EditorBox.ClearTextOnFocus = false

-- Atualização dinâmica de linhas
EditorBox:GetPropertyChangedSignal("Text"):Connect(function()
	local _, lines = string.gsub(EditorBox.Text, "\n", "")
	local text = ""
	for i = 1, lines + 1 do text = text .. i .. "\n" end
	LineC.Text = text
end)

-- SISTEMA DE EXECUÇÃO REAL
local function executarCodigo(texto)
	if loadstring then
		local sucesso, erro = pcall(function()
			local func = loadstring(texto)
			if func then func() end
		end)
		if not sucesso then
			pcall(function() CG:SetCore("SendNotification", {Title = "Erro no Script", Text = tostring(erro), Duration = 5}) end)
		end
	else
		pcall(function() CG:SetCore("SendNotification", {Title = "Aviso", Text = "Loadstring não suportado neste exploit.", Duration = 5}) end)
	end
end

-- ====================================================
-- BOTÕES DE AÇÃO INFERIORES
-- ====================================================
local executeBtn = Instance.new("TextButton", Main)
executeBtn.Size = UDim2.new(0, 120, 0, 35)
executeBtn.Position = UDim2.new(0, 8, 1, -45)
executeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
executeBtn.Text = "EXECUTE"
executeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
executeBtn.Font = Enum.Font.RobotoMono
executeBtn.TextSize = 14
addCorner(executeBtn, 6)
AddAnim(executeBtn)
executeBtn.MouseButton1Click:Connect(function() executarCodigo(EditorBox.Text) end)

local clearBtn = Instance.new("TextButton", Main)
clearBtn.Size = UDim2.new(0, 120, 0, 35)
clearBtn.Position = UDim2.new(0, 136, 1, -45)
clearBtn.BackgroundColor3 = BTN_BG
clearBtn.Text = "CLEAR"
clearBtn.TextColor3 = TEXT_WHITE
clearBtn.Font = Enum.Font.RobotoMono
clearBtn.TextSize = 14
addCorner(clearBtn, 6)
addStroke(clearBtn, BORDER_COLOR, 1)
AddAnim(clearBtn)
clearBtn.MouseButton1Click:Connect(function() EditorBox.Text = "" end)

-- ====================================================
-- PAINEL LATERAL DE UPLOADS (SALVOS)
-- ====================================================
local sidePanel = Instance.new("Frame", Main)
sidePanel.Name = "SidePanel"
sidePanel.Size = UDim2.new(0, 160, 1, 0)
sidePanel.Position = UDim2.new(1, 8, 0, 0)
sidePanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidePanel.BorderSizePixel = 0
addCorner(sidePanel, 8)
addStroke(sidePanel, LIGHT_GREEN, 1)

local sideTitle = Instance.new("TextLabel", sidePanel)
sideTitle.Size = UDim2.new(1, 0, 0, 38)
sideTitle.BackgroundTransparency = 1
sideTitle.Text = "UPLOADS / SALVOS"
sideTitle.TextColor3 = LIGHT_GREEN
sideTitle.Font = Enum.Font.Code
sideTitle.TextSize = 12

local scrollFrame = Instance.new("ScrollingFrame", sidePanel)
scrollFrame.Size = UDim2.new(1, -10, 1, -90)
scrollFrame.Position = UDim2.new(0, 5, 0, 42)
scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scrollFrame.BackgroundTransparency = 0.3
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = BORDER_COLOR
addCorner(scrollFrame, 4)

local uiListLayout = Instance.new("UIListLayout", scrollFrame)
uiListLayout.Padding = UDim.new(0, 5)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Ajuste automático do Canvas da lista de scripts
uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
end)

local addScriptBtn = Instance.new("TextButton", sidePanel)
addScriptBtn.Size = UDim2.new(1, -10, 0, 35)
addScriptBtn.Position = UDim2.new(0, 5, 1, -43)
addScriptBtn.BackgroundColor3 = BTN_BG
addScriptBtn.Text = "[+ ADD SCRIPT]"
addScriptBtn.TextColor3 = LIGHT_GREEN
addScriptBtn.Font = Enum.Font.Code
addScriptBtn.TextSize = 12
addCorner(addScriptBtn, 6)
addStroke(addScriptBtn, BORDER_COLOR, 1)
AddAnim(addScriptBtn)

-- Função para criar botões na lista de salvos
local function adicionarScriptPreSalvo(nome, codigo)
	local scriptBtn = Instance.new("TextButton", scrollFrame)
	scriptBtn.Size = UDim2.new(1, -10, 0, 30)
	scriptBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	scriptBtn.Text = nome
	scriptBtn.TextColor3 = TEXT_WHITE
	scriptBtn.Font = Enum.Font.Code
	scriptBtn.TextSize = 11
	addCorner(scriptBtn, 4)
	addStroke(scriptBtn, BORDER_COLOR, 1)
	AddAnim(scriptBtn)
	
	scriptBtn.MouseButton1Click:Connect(function()
		EditorBox.Text = codigo
		executarCodigo(codigo)
	end)
end

-- Dex pré-salvo de fábrica carregado por padrão
adicionarScriptPreSalvo("Dex Explorer plus", 'loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()')

-- Criação dinâmica de novos botões via interface interativa
addScriptBtn.MouseButton1Click:Connect(function()
	if HG:FindFirstChild("InputFrame") then HG.InputFrame:Destroy() end
	
	local inputFrame = Instance.new("Frame", HG)
	inputFrame.Name = "InputFrame"
	inputFrame.Size = UDim2.new(0, 300, 0, 160)
	inputFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
	inputFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	inputFrame.BorderSizePixel = 0
	addCorner(inputFrame, 8)
	addStroke(inputFrame, LIGHT_GREEN, 1)
	
	local nameInput = Instance.new("TextBox", inputFrame)
	nameInput.Size = UDim2.new(1, -20, 0, 30)
	nameInput.Position = UDim2.new(0, 10, 0, 15)
	nameInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	nameInput.TextColor3 = TEXT_WHITE
	nameInput.PlaceholderText = "Nome do Script"
	nameInput.Text = ""
	nameInput.Font = Enum.Font.Code
	nameInput.TextSize = 12
	addCorner(nameInput, 4)
	addStroke(nameInput, BORDER_COLOR, 1)
	
	local linkInput = Instance.new("TextBox", inputFrame)
	linkInput.Size = UDim2.new(1, -20, 0, 50)
	linkInput.Position = UDim2.new(0, 10, 0, 55)
	linkInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	linkInput.TextColor3 = Color3.fromRGB(200, 255, 200)
	linkInput.PlaceholderText = "Cole o link ou loadstring aqui..."
	linkInput.Text = ""
	linkInput.MultiLine = true
	linkInput.ClearTextOnFocus = false
	linkInput.Font = Enum.Font.Code
	linkInput.TextSize = 12
	addCorner(linkInput, 4)
	addStroke(linkInput, BORDER_COLOR, 1)
	
	local saveBtn = Instance.new("TextButton", inputFrame)
	saveBtn.Size = UDim2.new(0, 100, 0, 30)
	saveBtn.Position = UDim2.new(0.5, -50, 0, 115)
	saveBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	saveBtn.Text = "SALVAR"
	saveBtn.TextColor3 = LIGHT_GREEN
	saveBtn.Font = Enum.Font.RobotoMono
	addCorner(saveBtn, 4)
	addStroke(saveBtn, BORDER_COLOR, 1)
	AddAnim(saveBtn)
	
	saveBtn.MouseButton1Click:Connect(function()
		if nameInput.Text ~= "" and linkInput.Text ~= "" then
			adicionarScriptPreSalvo(nameInput.Text, linkInput.Text)
			inputFrame:Destroy()
		end
	end)
end)
