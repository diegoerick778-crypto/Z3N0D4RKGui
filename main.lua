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

-- Funções Auxiliares de Design e Transparência
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

local function setCharacterTransparency(char, transparency)
	for _, v in ipairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name ~= "HumanoidRootPart" then
				v.Transparency = transparency
			end
		elseif v:IsA("Decal") then
			v.Transparency = transparency
		end
	end
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
Main.ClipsDescendants = true 
Main.BackgroundTransparency = 0 
addCorner(Main, 8)
addStroke(Main, BORDER_COLOR, 2)

-- Barra Superior (Topbar)
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 38)
Top.BackgroundColor3 = TOP_BG
Top.BackgroundTransparency = 0
addCorner(Top, 8)

-- LOGO DO EXECUTOR (Posicionada exatamente no começo do nome)
local Logo = Instance.new("ImageLabel", Top)
Logo.Size = UDim2.new(0, 22, 0, 22) -- Tamanho simétrico para o topo
Logo.Position = UDim2.new(0, 12, 0.5, -11) -- Fixada no início esquerdo
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://120193086529841"
Logo.ZIndex = 5

-- Nome do Executor (Alinhado perfeitamente colado após a logo)
local Tit = Instance.new("TextLabel", Top)
Tit.Size = UDim2.new(1, -90, 0, 38)
Tit.Position = UDim2.new(0, 40, 0, 0) -- Espaçamento ideal após os 12px de margem + 22px da logo
Tit.BackgroundTransparency = 1
Tit.Text = "[Z3N0_D4RK_v5.5] owner: anonymous.zz76"
Tit.TextColor3 = LIGHT_GREEN 
Tit.Font = Enum.Font.Code
Tit.TextSize = 13
Tit.TextXAlignment = Enum.TextXAlignment.Left
Tit.ZIndex = 5

-- Botão Fechar (× Branco)
local Cls = Instance.new("TextButton", Top)
Cls.Size = UDim2.new(0, 35, 0, 35)
Cls.Position = UDim2.new(1, -38, 0, 1.5)
Cls.BackgroundTransparency = 1
Cls.Text = "×"
Cls.TextColor3 = TEXT_WHITE 
Cls.Font = Enum.Font.Code
Cls.TextSize = 24
Cls.ZIndex = 5

-- ====================================================
-- ÁREA DO EDITOR DE CÓDIGO 
-- ====================================================
local EdScr = Instance.new("ScrollingFrame", Main)
EdScr.Size = UDim2.new(1, -16, 1, -92) 
EdScr.Position = UDim2.new(0, 8, 0, 46)
EdScr.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
EdScr.BorderSizePixel = 0
EdScr.BackgroundTransparency = 0
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
LineC.AutomaticSize = Enum.AutomaticSize.Y

-- Highlights (Verde Claro e Branco)
local High = Instance.new("TextLabel", EdScr)
High.Size = UDim2.new(1, -55, 1, 0)
High.Position = UDim2.new(0, 50, 0, 6)
High.BackgroundTransparency = 1
High.Text = ""
High.TextColor3 = TEXT_WHITE 
High.Font = Enum.Font.Code
High.TextSize = 13
High.TextXAlignment = Enum.TextXAlignment.Left
High.TextYAlignment = Enum.TextYAlignment.Top
High.RichText = true
High.AutomaticSize = Enum.AutomaticSize.XY
High.ZIndex = 1

local EditorBox = Instance.new("TextBox", EdScr)
EditorBox.Size = UDim2.new(1, -55, 1, 0)
EditorBox.Position = UDim2.new(0, 50, 0, 6)
EditorBox.BackgroundTransparency = 1
EditorBox.Text = "-- Cole seu script aqui..."
EditorBox.TextColor3 = TEXT_WHITE
EditorBox.TextTransparency = 1 
EditorBox.Font = Enum.Font.Code
EditorBox.TextSize = 13
EditorBox.TextXAlignment = Enum.TextXAlignment.Left
EditorBox.TextYAlignment = Enum.TextYAlignment.Top
EditorBox.MultiLine = true
EditorBox.TextWrapped = false
EditorBox.ClearTextOnFocus = false
