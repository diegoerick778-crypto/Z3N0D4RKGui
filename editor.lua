local EditorModule = {}

function EditorModule.Create(HG, Config, TS, UIS, CG)
	local Colors = Config.Colors

	-- Frame Principal
	local Main = Instance.new("Frame", HG)
	Main.Size = UDim2.new(0, 560, 0, 340)
	Main.Position = UDim2.new(0.5, -280, 0.5, -170)
	Main.BackgroundColor3 = Colors.MAIN_BG
	Main.BorderSizePixel = 0
	Config.addCorner(Main, 8)
	Config.addStroke(Main, Colors.BORDER_COLOR, 2)

	-- Arrastar Interface (Draggable)
	local dragging, dragInput, dragStart, startPos
	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true dragStart = input.Position startPos = Main.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	Main.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- Barra Superior (Topbar)
	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1, 0, 0, 38)
	Top.BackgroundColor3 = Colors.TOP_BG
	Config.addCorner(Top, 8)

	-- LOGO DO EXECUTOR
	local Logo = Instance.new("ImageLabel", Top)
	Logo.Size = UDim2.new(0, 22, 0, 22)
	Logo.Position = UDim2.new(0, 12, 0.5, -11)
	Logo.BackgroundTransparency = 1
	Logo.Image = "rbxassetid://11415714032"
	Logo.ZIndex = 5

	-- Nome do Executor
	local Tit = Instance.new("TextLabel", Top)
	Tit.Size = UDim2.new(1, -90, 0, 38)
	Tit.Position = UDim2.new(0, 40, 0, 0)
	Tit.BackgroundTransparency = 1
	Tit.Text = "[Z3N0_D4RK_v5.5] owner: anonymous.zz76"
	Tit.TextColor3 = Colors.LIGHT_GREEN 
	Tit.Font = Enum.Font.Code
	Tit.TextSize = 13
	Tit.TextXAlignment = Enum.TextXAlignment.Left
	Tit.ZIndex = 5

	-- Botão Fechar / Minimizar Topbar
	local Cls = Instance.new("TextButton", Top)
	Cls.Size = UDim2.new(0, 35, 0, 35)
	Cls.Position = UDim2.new(1, -38, 0, 1.5)
	Cls.BackgroundTransparency = 1
	Cls.Text = "×"
	Cls.TextColor3 = Colors.TEXT_WHITE 
	Cls.Font = Enum.Font.Code
	Cls.TextSize = 24
	Cls.ZIndex = 5

	-- Sistema de Minimizar por Animação
	local animInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local minimizado = false
	local posOriginalMain, tamOriginalMain = Main.Position, Main.Size
	local posOriginalLogo, paiOriginalLogo = Logo.Position, Logo.Parent

	Cls.MouseButton1Click:Connect(function()
		if not minimizado then
			minimizado = true posOriginalMain = Main.Position
			for _, f in pairs(Main:GetChildren()) do if f ~= Top and f:IsA("GuiObject") then f.Visible = false end end
			Cls.Visible, Tit.Visible = false, false
			if Main:FindFirstChild("SidePanel") then Main.SidePanel.Visible = false end
			Logo.Parent = HG
			Logo.Position = UDim2.new(0, Main.AbsolutePosition.X + posOriginalLogo.X.Offset, 0, Main.AbsolutePosition.Y + posOriginalLogo.Y.Offset)
			TS:Create(Main, animInfo, {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), BackgroundTransparency = 1}):Play()
			TS:Create(Top, animInfo, {BackgroundTransparency = 1}):Play()
			TS:Create(Logo, animInfo, {Position = UDim2.new(0, 20, 0, 20), Size = UDim2.new(0, 45, 0, 45)}):Play()
		end
	end)

	local LogoBtn = Instance.new("TextButton", Logo)
	LogoBtn.Size, LogoBtn.BackgroundTransparency, LogoBtn.Text = UDim2.new(1,0,1,0), 1, ""
	LogoBtn.MouseButton1Click:Connect(function()
		if minimizado then
			minimizado = false
			local tLogo = TS:Create(Logo, animInfo, {Position = posOriginalLogo, Size = UDim2.new(0, 22, 0, 22)}) tLogo:Play()
			TS:Create(Main, animInfo, {Size = tamOriginalMain, Position = posOriginalMain, BackgroundTransparency = 0}):Play()
			TS:Create(Top, animInfo, {BackgroundTransparency = 0}):Play()
			tLogo.Completed:Connect(function()
				Logo.Parent, Logo.Position, Cls.Visible, Tit.Visible = paiOriginalLogo, posOriginalLogo, true, true
				for _, f in pairs(Main:GetChildren()) do if f ~= Top and f:IsA("GuiObject") then f.Visible = true end end
				if Main:FindFirstChild("SidePanel") then Main.SidePanel.Visible = true end
			end)
		end
	end)

	-- Área do Editor de Código (ScrollingFrame)
	local EdScr = Instance.new("ScrollingFrame", Main)
	EdScr.Size, EdScr.Position = UDim2.new(1, -16, 1, -105), UDim2.new(0, 8, 0, 46)
	EdScr.BackgroundColor3, EdScr.BorderSizePixel, EdScr.ScrollBarThickness = Color3.fromRGB(15, 15, 15), 0, 6
	EdScr.ScrollBarImageColor3, EdScr.AutomaticCanvasSize = Colors.BORDER_COLOR, Enum.AutomaticSize.XY
	Config.addCorner(EdScr, 6) Config.addStroke(EdScr, Colors.BORDER_COLOR, 1)

	local LineC = Instance.new("TextLabel", EdScr)
	LineC.Size, LineC.Position, LineC.BackgroundTransparency = UDim2.new(0, 35, 1, 0), UDim2.new(0, 5, 0, 6), 1
	LineC.Text, LineC.TextColor3, LineC.Font, LineC.TextSize = "1", Color3.fromRGB(100, 100, 100), Enum.Font.Code, 13
	LineC.TextXAlignment, LineC.TextYAlignment = Enum.TextXAlignment.Right, Enum.TextYAlignment.Top

	local EditorBox = Instance.new("TextBox", EdScr)
	EditorBox.Size, EditorBox.Position, EditorBox.BackgroundTransparency = UDim2.new(1, -55, 1, 0), UDim2.new(0, 50, 0, 6), 1
	EditorBox.Text, EditorBox.PlaceholderText, EditorBox.TextColor3 = "", "-- Cole seu script aqui...", Colors.TEXT_WHITE
	EditorBox.Font, EditorBox.TextSize, EditorBox.MultiLine = Enum.Font.Code, 13, true
	EditorBox.TextXAlignment, EditorBox.TextYAlignment, EditorBox.ClearTextOnFocus = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top, false

	EditorBox:GetPropertyChangedSignal("Text"):Connect(function()
		local _, lines = string.gsub(EditorBox.Text, "\n", "")
		local text = "" for i = 1, lines + 1 do text = text .. i .. "\n" end
		LineC.Text = text
	end)

	-- Sistema Executar Interno
	local function executarCodigo(texto)
		if loadstring then
			local s, e = pcall(function() local f = loadstring(texto) if f then f() end end)
			if not s then pcall(function() CG:SetCore("SendNotification", {Title = "Erro no Script", Text = tostring(e), Duration = 5}) end) end
		else
			pcall(function() CG:SetCore("SendNotification", {Title = "Aviso", Text = "Loadstring não suportado.", Duration = 5}) end)
		end
	end

	-- Botões Inferiores
	local execBtn = Instance.new("TextButton", Main)
	execBtn.Size, execBtn.Position, execBtn.BackgroundColor3 = UDim2.new(0, 120, 0, 35), UDim2.new(0, 8, 1, -45), Color3.fromRGB(0, 180, 80)
	execBtn.Text, execBtn.TextColor3, execBtn.Font, execBtn.TextSize = "EXECUTE", Color3.fromRGB(0, 0, 0), Enum.Font.RobotoMono, 14
	Config.addCorner(execBtn, 6) Config.AddAnim(execBtn, TS)
	execBtn.MouseButton1Click:Connect(function() executarCodigo(EditorBox.Text) end)

	local clrBtn = Instance.new("TextButton", Main)
	clrBtn.Size, clrBtn.Position, clrBtn.BackgroundColor3 = UDim2.new(0, 120, 0, 35), UDim2.new(0, 136, 1, -45), Colors.BTN_BG
	clrBtn.Text, clrBtn.TextColor3, clrBtn.Font, clrBtn.TextSize = "CLEAR", Colors.TEXT_WHITE, Enum.Font.RobotoMono, 14
	Config.addCorner(clrBtn, 6) Config.addStroke(clrBtn, Colors.BORDER_COLOR, 1) Config.AddAnim(clrBtn, TS)
	clrBtn.MouseButton1Click:Connect(function() EditorBox.Text = "" end)

	return Main, EditorBox, executarCodigo
end

return EditorModule
