local EditorModule = {}

function EditorModule.Create(HG, Config, TS, UIS, CG)
	local Colors = Config.Colors

	-- ====================================================
	-- FRAME PRINCIPAL (CONTAINER)
	-- ====================================================
	local Main = Instance.new("Frame", HG)
	Main.Size = UDim2.new(0, 560, 0, 340)
	Main.Position = UDim2.new(0.5, -280, 0.5, -170)
	Main.BackgroundColor3 = Colors.MAIN_BG
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = false
	Config.addCorner(Main, 8)
	
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Colors.BORDER_COLOR
	MainStroke.Thickness = 2
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.Parent = Main

	-- ====================================================
	-- BARRA SUPERIOR (TOPBAR) E ARRASTAR (DRAGGABLE)
	-- ====================================================
	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1, 0, 0, 38)
	Top.BackgroundColor3 = Colors.TOP_BG
	Config.addCorner(Top, 8)

	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPos = nil

	Top.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then 
					dragging = false 
				end 
			end)
		end
	end)

	Top.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
			dragInput = input 
		end 
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- ====================================================
	-- ELEMENTOS DA TOPBAR
	-- ====================================================
	local Logo = Instance.new("ImageLabel", Top)
	Logo.Size = UDim2.new(0, 22, 0, 22)
	Logo.Position = UDim2.new(0, 12, 0.5, -11)
	Logo.BackgroundTransparency = 1
	Logo.Image = "rbxassetid://6031280882"
	Logo.ZIndex = 5

	-- CORREÇÃO: Removida a linha duplicada 'local Tit' que estava obsoleta
	local Title = Instance.new("TextLabel", Top)
	Title.Size = UDim2.new(1, -90, 0, 38)
	Title.Position = UDim2.new(0, 40, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = "[Z3N0_D4RK_v5.5] owner: anonymous.zz76"
	Title.TextColor3 = Colors.LIGHT_GREEN 
	Title.Font = Enum.Font.Code
	Title.TextSize = 13
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 5

	local Cls = Instance.new("TextButton", Top)
	Cls.Size = UDim2.new(0, 35, 0, 35)
	Cls.Position = UDim2.new(1, -38, 0, 1.5)
	Cls.BackgroundTransparency = 1
	Cls.Text = "−"
	Cls.TextColor3 = Colors.TEXT_WHITE 
	Cls.Font = Enum.Font.Code
	Cls.TextSize = 20
	Cls.ZIndex = 5

	-- ====================================================
	-- BOTÃO MINIATURA FLUTUANTE (FIXO INDEPENDENTE)
	-- ====================================================
	local Minibutton = Instance.new("ImageButton", HG)
	Minibutton.Size = UDim2.new(0, 45, 0, 45)
	Minibutton.Position = UDim2.new(0, 20, 0, 20)
	Minibutton.BackgroundTransparency = 1
	Minibutton.Image = "rbxassetid://6031280882"
	Minibutton.Visible = false
	Minibutton.ZIndex = 10
	Config.addCorner(Minibutton, 8)
	
	local MiniStroke = Instance.new("UIStroke")
	MiniStroke.Color = Colors.LIGHT_GREEN
	MiniStroke.Thickness = 1.5
	MiniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MiniStroke.Parent = Minibutton

	-- ====================================================
	-- SISTEMA DE MINIMIZAR / RESTAURAR PERFEITO
	-- ====================================================
	local animInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local minimizado = false
	
	local posOriginalMain = Main.Position
	local tamOriginalMain = Main.Size

	Cls.MouseButton1Click:Connect(function()
		if not minimizado then
			minimizado = true
			
			posOriginalMain = Main.Position
			tamOriginalMain = Main.Size

			local tweenMain = TS:Create(Main, animInfo, {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1
			})
			
			TS:Create(MainStroke, animInfo, {Thickness = 0}):Play()
			TS:Create(Top, animInfo, {BackgroundTransparency = 1}):Play()
			
			Cls.Visible = false
			Title.Visible = false
			Logo.Visible = false
			if Main:FindFirstChild("SidePanel") then 
				Main.SidePanel.Visible = false 
			end

			tweenMain:Play()

			local connection
			connection = tweenMain.Completed:Connect(function()
				connection:Disconnect()
				Main.Visible = false
				Minibutton.Size = UDim2.new(0, 10, 0, 10)
				Minibutton.Visible = true
				
				TS:Create(Minibutton, animInfo, {Size = UDim2.new(0, 45, 0, 45)}):Play()
			end)
		end
	end)

	Minibutton.MouseButton1Click:Connect(function()
		if minimizado then
			minimizado = false
			
			local tweenMini = TS:Create(Minibutton, animInfo, {Size = UDim2.new(0, 0, 0, 0)})
			tweenMini:Play()

			local connection
			connection = tweenMini.Completed:Connect(function()
				connection:Disconnect()
				Minibutton.Visible = false
				Main.Visible = true

				TS:Create(Main, animInfo, {
					Size = tamOriginalMain,
					Position = posOriginalMain,
					BackgroundTransparency = 0
				}):Play()
				
				TS:Create(MainStroke, animInfo, {Thickness = 2}):Play()
				TS:Create(Top, animInfo, {BackgroundTransparency = 0}):Play()

				Cls.Visible = true
				Title.Visible = true
				Logo.Visible = true
				if Main:FindFirstChild("SidePanel") then 
					Main.SidePanel.Visible = true 
				end
			end)
		end
	end)

	-- ====================================================
	-- ÁREA DO EDITOR DE CÓDIGO (SCROLLINGFRAME)
	-- ====================================================
	local EdScr = Instance.new("ScrollingFrame", Main)
	EdScr.Size = UDim2.new(1, -16, 1, -105)
	EdScr.Position = UDim2.new(0, 8, 0, 46)
	EdScr.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	EdScr.BorderSizePixel = 0
	EdScr.ScrollBarThickness = 6
	EdScr.ScrollBarImageColor3 = Colors.BORDER_COLOR
	EdScr.AutomaticCanvasSize = Enum.AutomaticSize.XY
	Config.addCorner(EdScr, 6) 
	Config.addStroke(EdScr, Colors.BORDER_COLOR, 1)

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
	EditorBox.TextColor3 = Colors.TEXT_WHITE
	EditorBox.Font = Enum.Font.Code
	EditorBox.TextSize = 13
	EditorBox.TextXAlignment = Enum.TextXAlignment.Left
	EditorBox.TextYAlignment = Enum.TextYAlignment.Top
	EditorBox.MultiLine = true
	EditorBox.TextWrapped = false
	EditorBox.ClearTextOnFocus = false

	EditorBox:GetPropertyChangedSignal("Text"):Connect(function()
		local _, lines = string.gsub(EditorBox.Text, "\n", "")
		local text = "" 
		for i = 1, lines + 1 do 
			text = text .. i .. "\n" 
		end
		LineC.Text = text
	end)

	-- ====================================================
	-- SISTEMA INTERNO DE EXECUÇÃO E BOTÕES
	-- ====================================================
	local function executarCodigo(texto)
		if loadstring then
			local s, e = pcall(function() 
				local f = loadstring(texto) 
				if f then f() end 
			end)
			if not s then 
				pcall(function() CG:SetCore("SendNotification", {Title = "Erro no Script", Text = tostring(e), Duration = 5}) end) 
			end
		else
			pcall(function() CG:SetCore("SendNotification", {Title = "Aviso", Text = "Loadstring não suportado.", Duration = 5}) end)
		end
	end

	local execBtn = Instance.new("TextButton", Main)
	execBtn.Size = UDim2.new(0, 120, 0, 35)
	execBtn.Position = UDim2.new(0, 8, 1, -45)
	execBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
	execBtn.Text = "EXECUTE"
	execBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	execBtn.Font = Enum.Font.RobotoMono
	execBtn.TextSize = 14
	Config.addCorner(execBtn, 6) 
	Config.AddAnim(execBtn, TS)
	execBtn.MouseButton1Click:Connect(function() executarCodigo(EditorBox.Text) end)

	local clrBtn = Instance.new("TextButton", Main)
	clrBtn.Size = UDim2.new(0, 120, 0, 35)
	clrBtn.Position = UDim2.new(0, 136, 1, -45)
	clrBtn.BackgroundColor3 = Colors.BTN_BG
	clrBtn.Text = "CLEAR"
	clrBtn.TextColor3 = Colors.TEXT_WHITE
	clrBtn.Font = Enum.Font.RobotoMono
	clrBtn.TextSize = 14
	Config.addCorner(clrBtn, 6) 
	Config.addStroke(clrBtn, Colors.BORDER_COLOR, 1) 
	Config.AddAnim(clrBtn, TS)
	clrBtn.MouseButton1Click:Connect(function() EditorBox.Text = "" end)

	return Main, EditorBox, executarCodigo
end

return EditorModule
